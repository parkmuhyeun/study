package com.hong.hakwon.repository;


import com.hong.hakwon.Beans.Category;
import com.hong.hakwon.Beans.Post;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.stereotype.Component;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Transactional
public class PostRepositoryTest {

    @Autowired
    PostRepository postRepository;

    @Value("${file.dir}")
    private String fileDir;

    @Test
    public void post_save_get() throws Exception {

        Date today = new Date();
        java.sql.Date sqlDate = new java.sql.Date(today.getTime());
        //given

        String title = "테스트";
        String content = "테스트본문";
        String path = fileDir + "test.jpg";
        Long createdDate = today.getTime();
        String creator = "테스트계정";
        Long modifiedDate = today.getTime();
        String modifier = "테스트계정";
        String category = "일반게시판";

//        Post post = new Post(title, content, path, createdDate, creator, modifiedDate, modifier);
        Post post = new Post(title, content, path, creator, modifier, category);

        //when
        postRepository.post_save(post);
        Post post1 = postRepository.get_post(1);

        List<Post> postsList = postRepository.get_allPostDesc();

        Post posts = postsList.get(1);

//        SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd a HH:mm:ss");
//        Timestamp currentTime = new Timestamp(posts.getCreatedDate());
//        String now = date.format(currentTime);

        //then
        System.out.println("getPost.title = " + posts.getTitle());
        System.out.println("getPost.content = " + posts.getContent());
        System.out.println("getPost.filepath = " + posts.getFilePath());
        System.out.println("getPost.createdDate = " + posts.getCreatedDate());
        System.out.println("getPost.creator = " + posts.getCreator());
        System.out.println("posts.getCategoryName() = " + posts.getCategoryName());

    }

    
    @Test
    public void category() throws Exception{
        //given
        String categoryName = "자유게시판";
        Boolean isUse = true;
        Long order = 2L;

//        Category category = new Category(categoryName, isUse, order);
        
        //when
//        postRepository.save_category(category);

//        Category findCate = postRepository.get_category(categoryName);

        List<Category> all_category = postRepository.get_all_category();

        //then
//        System.out.println("findCate.getCategoryName() = " + findCate.getCategoryName());
        for (Category category1 : all_category) {
            System.out.println("category1.getCategoryName() = " + category1.getCategoryName());
        }

    }
    
}