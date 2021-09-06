package com.hong.hakwon.web.post;


import com.hong.hakwon.Beans.UserBean;
import com.hong.hakwon.SessionConst;
import com.hong.hakwon.service.PostService;
import com.hong.hakwon.web.dto.FileResponseDto;
import com.hong.hakwon.web.dto.PostListResponseDto;
import com.hong.hakwon.web.dto.PostResponseDto;
import com.hong.hakwon.web.dto.PostSaveRequestDto;
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
import org.springframework.web.util.UriUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
    public ModelAndView posts(HttpServletRequest request) throws Exception {

        ModelAndView mav = new ModelAndView("/posts");

        //세션 없으면 home
        HttpSession session = request.getSession(false);
        if (session == null) {
            return mav;
        }

        UserBean loginMember = (UserBean) session.getAttribute(SessionConst.LOGIN_MEMBER);

        if (loginMember != null) {
            ModelAndView chk = new ModelAndView("/layouts/default/header");
            mav.addObject("memberName", loginMember.getName());
        }

        return mav;
    }

    @ResponseBody
    @RequestMapping(value = "/posts/dataTable")
    public List<PostListResponseDto> postAll() throws Exception {
        List<PostListResponseDto> allPost = postService.get_allPostDesc();

        logger.info(allPost.get(0).getCreatedDate());
//        JSONArray jsonArray = new JSONArray();
//        for (int i = 0; i < allPost.size(); i++) {
//            JSONObject data = new JSONObject();
//            data.put("data", allPost.get(i));
//            jsonArray.add(i, data);
//        }

        return allPost;
    }

    /*
     * 게시글등록 페이지
     */
    @RequestMapping(value = "/posts/save")
    public ModelAndView SaveForm() {
        ModelAndView mav = new ModelAndView("/posts-save");
        mav.addObject("postSaveRequestDto", new PostSaveRequestDto());
        return mav;
    }

    /*
     * 게시글 등록 요청
     */
    @RequestMapping(value = "/posts/save", method = RequestMethod.POST)
    public ModelAndView Save(@ModelAttribute PostSaveRequestDto requestDto, HttpSession session) throws Exception {

        logger.info(requestDto.getTitle());
        logger.info(requestDto.getContent());
        logger.info(requestDto.getFile().isEmpty());

        postService.save(requestDto, session);

        ModelAndView mav = new ModelAndView("redirect:/posts");
        return mav;
    }

    /*
     * 개별 게시글 페이지
     */
    @RequestMapping(value = "/posts/{id}")
    public ModelAndView Post(@PathVariable("id") int id) throws Exception {
        ModelAndView mav = new ModelAndView("post");
        PostResponseDto post = postService.get_post(id);
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

        UrlResource resource = new UrlResource("file:" + fileDir + storeFileName);
        String contentDisposition = "attachment; filename=\"" + uploadFileName + "\"";
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION,contentDisposition)
                .body(resource);
    }
}

