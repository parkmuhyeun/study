package com.hong.hakwon.service;

import com.hong.hakwon.Beans.*;
import com.hong.hakwon.SessionConst;
import com.hong.hakwon.UserDAOImpl;
import com.hong.hakwon.repository.PostRepository;
import com.hong.hakwon.web.dto.*;
import com.hong.hakwon.web.validation.RegisterValidator;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
public class PostService {
    private PostRepository postRepository;

    private Log logger	= LogFactory.getLog(this.getClass());

    private String fileDir = "C:/Users/Muto/Desktop/study/study/hakwon/src/main/webapp/resources/images/upload/";

    @Autowired
    public PostService(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    /*
     * 게시글 등록
     */
    public int save(PostSaveRequestDto requestDto, HttpSession session) throws Exception {
        Date today = new Date();
        SimpleDateFormat date = new SimpleDateFormat("MM.dd");
        String now = date.format(today);

        String storeFileName = createUuidFileName(requestDto.getFile().getOriginalFilename());

        String fullPath = "";
        if (!requestDto.getFile().isEmpty()) {
            fullPath = fileDir + now;

            CreateFolder(fullPath);     //fullPath 경로로 폴더 생성
            requestDto.getFile().transferTo(new File(fullPath + '/' + storeFileName));
        }

        UserBean user = (UserBean) session.getAttribute(SessionConst.LOGIN_MEMBER);

        Post post = new Post(requestDto.getTitle(),
                requestDto.getContent(),
                fullPath,
                user.getName(),
                user.getName(),
                requestDto.getCategory()
        );

        int res = postRepository.post_save(post);

        //TODO 일단 datetime 안되서 임시처방
        if(!requestDto.getFile().isEmpty()){
            AttachmentFile file = new AttachmentFile(post.getId(),
                    storeFileName ,
                    requestDto.getFile().getOriginalFilename(),
                    today.toString(), user.getName(),
                    today.toString(),
                    user.getName()
            );
            postRepository.file_save(file);
        }

        if (requestDto.getHashTagContent() != null) {
//            //post_hashtag(중간다리)저장
//            PostHashTag postHashTag = new PostHashTag(post.getId());
//            postRepository.post_hashtag_save(postHashTag);

            for (int i = 0; i < requestDto.getHashTagContent().size(); i++) {
                //post_hashtag(중간다리)저장
                PostHashTag postHashTag = new PostHashTag(post.getId());
                postRepository.post_hashtag_save(postHashTag);

                //해시태그에 저장
                HashTag hashTag = new HashTag(postHashTag.getHashtag_id(), requestDto.getHashTagContent().get(i));
                postRepository.hashtag_save(hashTag);
            }

        }

        return res;
    }

    private void CreateFolder(String fullPath) {
        File folder = new File(fullPath);
        if (!folder.exists()) {
            folder.mkdir();
        }
    }

    public FileResponseDto get_file(int id) throws Exception {
        AttachmentFile file = postRepository.get_file(id);
        return new FileResponseDto(file.getId(), file.getUuidName(), file.getFileName());
    }

    private String createUuidFileName(String originalFilename) {
        String ext = extractExt(originalFilename);
        String uuid = UUID.randomUUID().toString();
        return uuid + "." + ext;
    }

    private String extractExt(String originalFilename) {
        int pos = originalFilename.lastIndexOf(".");
        return originalFilename.substring(pos+1);
    }

    /*
     * 게시글 한개 조회
     */
    public PostResponseDto get_post(int id, HttpServletRequest request,HttpServletResponse response) throws Exception {


        String sid = Integer.toString(id);
        //쿠키가 같지않은경우 조회수 상승
        Cookie[] cookies = request.getCookies();

        Cookie viewCookie = null;

        if (cookies != null && cookies.length > 0) {
            for (int i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equals("recent_board_read"+sid)) {
                    viewCookie = cookies[i];
                }
            }
        }

        if (viewCookie == null) {
            postRepository.update_views(id);
            Cookie readCookie =  new Cookie("recent_board_read"+sid, sid);
            readCookie.setPath("/");
            response.addCookie(readCookie);
        }
//
//        //쿠키가 없는경우 + 쿠키가 다른경우
//        Cookie readCookie =  new Cookie("recent_board_read", sid);
//        readCookie.setMaxAge(60 * 60 * 24);
//        readCookie.setPath("/");
//        response.addCookie(readCookie);

//        HttpSession session = request.getSession();
//        if (!session.getAttribute("recent_board_read").equals(id)) {
//            postRepository.update_views(id);
//        }
//        session.setAttribute("recent_board_read", id);

        Post post = postRepository.get_post(id);
        List<HashTag> tagList = postRepository.get_hashtag(id);
        List<String> dtoTagList = new ArrayList<String>();
        for (int i = 0; i < tagList.size(); i++) {
            String tagContent = tagList.get(i).getContent();
            dtoTagList.add(tagContent);
        }

        return new PostResponseDto(post.getId(),
                post.getTitle(),
                post.getContent(),
                post.getFilePath(),
                dtoTagList,
                post.getCreatedDate(),
                post.getCreator(),
                post.getModifiedDate(),
                post.getModifier());
    }

    /*
     * 게시글 전체 조회
     */
    public List<PostListResponseDto> get_allPostDesc() throws Exception {
        List<Post> posts = postRepository.get_allPostDesc();


        List<List<String>> tagList = new ArrayList<List<String>>();

        for (Post post : posts) {
            List<HashTag> hashtag = postRepository.get_hashtag(post.getId());
            List<String> tagL = new ArrayList<String>();
            for (HashTag hashTag : hashtag) {
                tagL.add(hashTag.getContent());
            }
            tagList.add(tagL);

        }


        List<PostListResponseDto> responseDtoList = new ArrayList<PostListResponseDto>();

        for (int i = 0; i < posts.size(); i++) {
            PostListResponseDto dto = new PostListResponseDto(posts.get(i).getId(),
                    posts.get(i).getTitle(),
                    posts.get(i).getCreatedDate(),
                    posts.get(i).getCreator(),
                    tagList.get(i),
                    posts.get(i).getViews());
            responseDtoList.add(dto);
        }

        return responseDtoList;
    }

    /*
     * 카테고리 이름 전체 조회
     */
    public CategoryListDto get_all_category() throws Exception {
        List<Category> all_category = postRepository.get_all_category();
        List<String> all_category_name = new ArrayList<String>();
        List<Long> all_category_id = new ArrayList<Long>();

        for (Category category : all_category) {
            all_category_name.add(category.getCategoryName());
            all_category_id.add(category.getId());
        }
        CategoryListDto dto = new CategoryListDto(all_category_id, all_category_name);

        return dto;
    }

    /*
     *
     */

}
