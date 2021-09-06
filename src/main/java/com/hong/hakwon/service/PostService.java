package com.hong.hakwon.service;

import com.hong.hakwon.Beans.AttachmentFile;
import com.hong.hakwon.Beans.Post;
import com.hong.hakwon.Beans.UserBean;
import com.hong.hakwon.SessionConst;
import com.hong.hakwon.UserDAOImpl;
import com.hong.hakwon.repository.PostRepository;
import com.hong.hakwon.web.dto.FileResponseDto;
import com.hong.hakwon.web.dto.PostListResponseDto;
import com.hong.hakwon.web.dto.PostResponseDto;
import com.hong.hakwon.web.dto.PostSaveRequestDto;
import com.hong.hakwon.web.validation.RegisterValidator;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

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

    //등록
    public int save(PostSaveRequestDto requestDto, HttpSession session) throws Exception {
        Date today = new Date();
//        SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd a HH:mm:ss");
//        String now = date.format(today);

        String fullPath = "";
        if (!requestDto.getFile().isEmpty()) {
            fullPath = fileDir +  createUuidFileName(requestDto.getFile().getOriginalFilename());
            requestDto.getFile().transferTo(new File(fullPath));
        }

        UserBean user = (UserBean) session.getAttribute(SessionConst.LOGIN_MEMBER);

        Post post = new Post(requestDto.getTitle(),
                requestDto.getContent(),
                fullPath, today.getTime(),
                user.getName(),
                today.getTime(),
                user.getName()
        );

        int res = postRepository.post_save(post);

        //TODO 일단 datetime 안되서 임시처방
        if(!requestDto.getFile().isEmpty()){
            AttachmentFile file = new AttachmentFile(post.getId(),
                    createUuidFileName(requestDto.getFile().getOriginalFilename()) ,
                    requestDto.getFile().getOriginalFilename(),
                    today.toString(), user.getName(),
                    today.toString(),
                    user.getName()
            );
            postRepository.file_save(file);
        }

        return res;
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

    //한건 조회
    public PostResponseDto get_post(int id) throws Exception {
        Post post = postRepository.get_post(id);
        return new PostResponseDto(post.getId(),
                post.getTitle(),
                post.getContent(),
                post.getFilePath(),
                post.getCreatedDate(),
                post.getCreator(),
                post.getModifiedDate(),
                post.getModifier());
    }

    //전체 조회
    public List<PostListResponseDto> get_allPostDesc() throws Exception {
        List<Post> posts = postRepository.get_allPostDesc();

        List<PostListResponseDto> responseDtoList = new ArrayList<PostListResponseDto>();
        logger.info(posts.get(0).getCreatedDate());
        logger.info("전 조회");

        for (int i = 0; i < posts.size(); i++) {
            PostListResponseDto dto = new PostListResponseDto(posts.get(i).getId(),
                    posts.get(i).getTitle(),
                    posts.get(i).getCreatedDate(),
                    posts.get(i).getCreator());
            responseDtoList.add(dto);
        }
        logger.info(responseDtoList.get(0).getCreatedDate());
        logger.info("후 조회");

        return responseDtoList;
    }
}
