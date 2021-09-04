package com.hong.hakwon.web.join;

import com.hong.hakwon.Beans.UserBean;
import com.hong.hakwon.SessionConst;
import com.hong.hakwon.Sha256;
import com.hong.hakwon.UserDAOImpl;
import com.hong.hakwon.Beans.History;
import com.hong.hakwon.Beans.SiDo;
import com.hong.hakwon.Beans.SiGunGu;
import com.hong.hakwon.web.dto.UserSaveDto;
import com.hong.hakwon.web.validation.RegisterValidator;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@SuppressWarnings("rawtypes")
public class JoinController {

    private UserDAOImpl uService;

    private Log logger	= LogFactory.getLog(this.getClass());

    private RegisterValidator registerValidator;

    @Autowired
    public JoinController(UserDAOImpl uService, RegisterValidator registerValidator) {
        this.uService = uService;
        this.registerValidator = registerValidator;
    }

    /*
     * 회원가입 페이지
     */
    @RequestMapping(value="/join")
    public ModelAndView join() throws Exception {
        List<SiDo> sido = uService.get_Allsido();

        ModelAndView mav = new ModelAndView("/join");
        mav.addObject("sido", sido);
        mav.addObject("userSaveDto", new UserSaveDto());
        return mav;
    }


    /*
     * 아이디 중복체크
     */
    @RequestMapping(value = "/join/idCheck", method = RequestMethod.POST)
    @ResponseBody
    public boolean idCheck(@RequestParam("id") String id) throws Exception {

        boolean check = false;
        UserBean ub = uService.selectByUserId(id);

        logger.info(ub);
        if(ub == null){
            check = true;
        }

        return check;
    }

    /*
     * 비밀번호 실시간 유효성
     */
    @RequestMapping(value ="/join/pwCheck", method = RequestMethod.POST)
    @ResponseBody
    public boolean pwCheck(@RequestParam("password") String password) {

        boolean check =false;

        String pw_chk = "^[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]*$";

        Pattern passP = Pattern.compile(pw_chk);

        if(password.length() >= 8 && password.length() <= 15){
            Matcher matcher = passP.matcher(password);
            if(matcher.matches()){
                check = true;
            }
        }

        return check;
    }

    /*
     * get 시군구
     * 시도 바뀔때마다 sido_id로 시군구 조회해서 jsp로 넘겨줌
     */
    @RequestMapping(value="/join/sigungu", method = RequestMethod.POST)
    @ResponseBody
    public List<SiGunGu> get_sigungu(@RequestParam("sido_cd") int sido_cd) throws Exception {

        List<SiGunGu> sigungu = uService.get_sigungu(sido_cd);

        return sigungu;
    }

    /*
     * 회원가입 요청
     */
    @RequestMapping(value="/join", method = RequestMethod.POST)
    public ModelAndView join(@ModelAttribute UserSaveDto userSaveDto, BindingResult bindingResult, HttpServletRequest request) throws Exception {
        registerValidator.validate(userSaveDto, bindingResult);

        if (bindingResult.hasErrors()) {
            List<SiDo> sido = uService.get_Allsido();
            ModelAndView mav = new ModelAndView("/join");
            mav.addObject("sido", sido);
            return mav;
        }

        String encryPassword = Sha256.encrypt(userSaveDto.getPassword());
        String pn = userSaveDto.getF_number() + '-' + userSaveDto.getM_number() + '-' + userSaveDto.getE_number();
        UserBean ub = new UserBean(userSaveDto.getUserId(),
                encryPassword,
                userSaveDto.getName(),
                pn,
                userSaveDto.getSido(),
                userSaveDto.getSigungu(),
                userSaveDto.getEmail()
        );
        uService.saveUser(ub);

        UserBean user = uService.selectByUserId(userSaveDto.getUserId());

        ModelAndView mav = new ModelAndView("redirect:/main");

        HttpSession session = request.getSession();
        session.setAttribute(SessionConst.LOGIN_MEMBER, user);

        History history = new History(user.getUserId(),
                request.getHeader("user-agent"),
                session.getCreationTime());

        uService.history_save(history);

        return mav;
    }

}
