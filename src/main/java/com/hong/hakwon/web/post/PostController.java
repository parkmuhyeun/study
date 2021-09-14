package com.hong.hakwon.web.post;


import com.hong.hakwon.Beans.UserBean;
import com.hong.hakwon.SessionConst;
import com.hong.hakwon.argumentresolver.Login;
import com.hong.hakwon.service.PostService;
import com.hong.hakwon.web.dto.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class PostController {

    private PostService postService;

    private Log logger = LogFactory.getLog(this.getClass());

    private String fileDir = "C:/Users/Muto/Desktop/study/study/hakwon/src/main/webapp/resources/images/upload/";

    @Autowired
    public PostController(PostService postService) {
        this.postService = postService;
    }

    /*
     * 게시판 페이지
     */
    @RequestMapping(value = "/posts")
    public ModelAndView posts(HttpServletRequest request, RedirectAttributes redirectAttributes, @Login UserBean loginMember) throws Exception {

        String requestURI = request.getRequestURI();
        //로그인 안되있으면 login페이지로
//        HttpSession session = request.getSession(false);
//        UserBean loginMember = (UserBean) session.getAttribute(SessionConst.LOGIN_MEMBER);

//        if (loginMember == null) {
//            //다시 돌아올 requestURI 추가
//            redirectAttributes.addAttribute("redirectURL", requestURI);
//            ModelAndView mav = new ModelAndView("redirect:/login");
//            return mav;
//        }

        ModelAndView mav = new ModelAndView("/posts");
        ModelAndView chk = new ModelAndView("/layouts/default/header");
//        mav.addObject("memberName", loginMember.getName());
        mav.addObject("member", loginMember);

        return mav;
    }


    /*
     * datatable 값 넘기기
     */
    @ResponseBody
    @RequestMapping(value = "/posts/dataTable")
    public List<PostListResponseDto> postAll() throws Exception {
        List<PostListResponseDto> allPost = postService.get_allPostDesc();

        return allPost;
    }

    /*
     * 게시글등록 페이지
     */
    @RequestMapping(value = "/posts/save")
    public ModelAndView SaveForm() throws Exception {
        CategoryListDto all_category = postService.get_all_category();

        ModelAndView mav = new ModelAndView("/posts-save");
        mav.addObject("postSaveRequestDto", new PostSaveRequestDto());
        mav.addObject("all_category", all_category);

        return mav;
    }

    /*
     * 게시글 등록 요청
     */
    @RequestMapping(value = "/posts/save", method = RequestMethod.POST)
    public ModelAndView Save(@ModelAttribute PostSaveRequestDto requestDto, HttpSession session) throws Exception {

        postService.save(requestDto, session);

        ModelAndView mav = new ModelAndView("redirect:/posts");
        return mav;
    }

    /*
     * 개별 게시글 페이지
     */
    @RequestMapping(value = "/posts/{id}")
    public ModelAndView Post(@PathVariable("id") int id, HttpServletRequest request, HttpServletResponse response) throws Exception {

        //TODO 첨부파일: 업로드파일명으로 바꾸기

        ModelAndView mav = new ModelAndView("post");
        PostResponseDto post = postService.get_post(id,request, response);
        mav.addObject("post", post);
        return mav;
    }

    /*
     * 첨부파일 다운로드 요청
     */
    @RequestMapping("/attach/{id}")
    public ResponseEntity<UrlResource> downloadAttach(@PathVariable int id) throws Exception {
        FileResponseDto file = postService.get_file(id);
        String storeFileName = file.getUuidName();
        String uploadFileName = file.getFileName();

        Date today = new Date();
        SimpleDateFormat date = new SimpleDateFormat("MM.dd");
        String now = date.format(today);

        UrlResource resource = new UrlResource("file:" + fileDir + now + '/' + storeFileName);
        String contentDisposition = "attachment; filename=\"" + uploadFileName + "\"";
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION,contentDisposition)
                .body(resource);
    }


    /*
     * 카테고리 관리자페이지
     */
    @RequestMapping("/posts/mng_category")
    public ModelAndView mng_category() throws Exception {
        ModelAndView mav = new ModelAndView("mng_category");
        MCategoryListDto mCategoryListDto = postService.m_get_all_category();
        mav.addObject("categoryList", mCategoryListDto);
        return mav;
    }

    /*
     * 카테고리 추가
     */
    @RequestMapping(value = "/mng_category/add", method = RequestMethod.POST)
    @ResponseBody
    public Boolean save_category(@RequestBody CategorySaveDto saveDto) throws Exception {

        boolean check = false;
        int row = postService.save_category(saveDto);
        if (row > 0) {
            check = true;
        }
        return check;
    }

    /*
     * 카테고리 수정
     */
    @RequestMapping(value = "/mng_category/update", method = RequestMethod.POST)
    @ResponseBody
    public Boolean update_category(@RequestBody CategoryUpdateDto updateDto) throws Exception {

        boolean check = false;
        int row = postService.update_category(updateDto);
        if (row > 0) {
            check = true;
        }
        return check;
    }

    /*
     * 카테고리 삭제
     */
    @RequestMapping(value = "/mng_category/delete", method = RequestMethod.POST)
    @ResponseBody
    public Boolean update_category(@RequestParam("id") Long id) throws Exception {

        boolean check = false;
        int row = postService.delete_category(id);
        if (row > 0) {
            check = true;
        }
        return check;
    }

}

