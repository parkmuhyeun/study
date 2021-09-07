package com.hong.hakwon.web.login;

import com.hong.hakwon.Beans.UserBean;
import com.hong.hakwon.SessionConst;
import com.hong.hakwon.Sha256;
import com.hong.hakwon.UserDAOImpl;
import com.hong.hakwon.Beans.History;
import com.hong.hakwon.web.dto.LoginForm;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@SuppressWarnings("rawtypes")
public class LoginController {

    private UserDAOImpl uService;

    private Log logger	= LogFactory.getLog(this.getClass());

    @Autowired
    public LoginController(UserDAOImpl uService) {
        this.uService = uService;
    }

    /*
     * Id 저장해제
     */
    @RequestMapping(value = "/login/reid", method = RequestMethod.POST)
    public void rememberId(@RequestParam(value = "rid") Boolean rid, HttpServletResponse response) {

        //check 해제시 쿠키삭제
        if (!rid) {
            expireCookie(response, "cid");
        }
    }

    //쿠키 삭제
    private void expireCookie(HttpServletResponse response, String cookieName) {
        Cookie cookie = new Cookie(cookieName, null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    /*
     * 로그인 페이지
     */
    @RequestMapping(value="/login")
    public ModelAndView loginForm(@CookieValue(name = "cid", required = false) String userId, @ModelAttribute("loginForm") LoginForm form, HttpServletResponse response )  {
        //쿠키 존재하면
        if(userId != null){
            form.setId(userId);
            form.setRememberId(true);
        }

        ModelAndView mav = new ModelAndView("/login");
        return mav;
    }

    /*
     * 로그인
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView login(@ModelAttribute LoginForm form,
                              BindingResult bindingResult,
                              HttpServletRequest request,
                              HttpServletResponse response,
                              @RequestParam(defaultValue = "/main") String redirectURL) throws Exception {

       // TODO redirectURL 수정

        UserBean loginMember = uService.login(form.getId(), Sha256.encrypt(form.getPassword()));

        if (loginMember == null) {
            bindingResult.reject("loginFail", "아이디 또는 비밀번호가 맞지 않습니다.");
            ModelAndView mav = new ModelAndView("/login");
            return mav;
        }

        //로그인 성공 처리

        //Id remember by cookie
        CreateCookie(form, response);

        //세션있으면 세션 반환, 없으면 신규 세션 생성
        HttpSession session = request.getSession();
        //세션에 로그인 회원 정보 보관
        session.setAttribute(SessionConst.LOGIN_MEMBER, loginMember);

        //로그인이력
        History history = new History(loginMember.getUserId(),
                request.getHeader("user-agent"),
                session.getCreationTime());

        uService.history_save(history);
        logger.info("리다  " + redirectURL);
        ModelAndView mav = new ModelAndView("redirect:" + redirectURL);
        return mav;
    }

    private void CreateCookie(LoginForm form, HttpServletResponse response) {
        Cookie rCookie = new Cookie("cid", form.getId());
        if(form.getRememberId()){
            rCookie.setMaxAge(60 * 60 * 24 * 7);
        }else {
            rCookie.setMaxAge(0);
        }
        rCookie.setPath("/");
        response.addCookie(rCookie);
    }

    /*
     * 로그아웃
     */
    @RequestMapping(value = "/logout", method = RequestMethod.POST)
    public ModelAndView logout(HttpServletRequest request) {
        //세션을 삭제
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        ModelAndView mav = new ModelAndView("redirect:/main");
        return mav;
    }

}
