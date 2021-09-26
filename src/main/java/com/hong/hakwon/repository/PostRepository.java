package com.hong.hakwon.repository;

import com.hong.hakwon.Beans.*;
import com.hong.hakwon.web.dto.CategoryUpdateDto;
import com.hong.hakwon.web.dto.PostPage;
import com.hong.hakwon.web.dto.SearchRequestDto;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import java.io.Reader;
import java.util.List;


@Repository
public class PostRepository {

    Reader reader =null;
    SqlSessionFactory factory = null;
    SqlSession sqlSession =null;

    private Log logger	= LogFactory.getLog(this.getClass());

    public void getSession() throws Exception{
        String resource="util/SqlMapConfig.xml";
        reader= Resources.getResourceAsReader(resource);

        if(factory == null)
            factory = new SqlSessionFactoryBuilder().build(reader);

        sqlSession =factory.openSession(true);
    }

    /*
     * 게시글 저장
     */
    public int post_save(Post post) throws Exception {
        getSession();

        int row = sqlSession.insert("p.save_post", post);

        if (row > 0) {
            sqlSession.commit();
        }
        sqlSession.close();
        return row;
    }

    /*
     * 첨부파일저장
     */
    public int file_save(AttachmentFile file) throws Exception {
        getSession();

        int row = sqlSession.insert("p.save_file", file);
        if (row > 0) {
            sqlSession.commit();
        }
        sqlSession.close();
        return row;
    }

    /*
     * 첨부파일 불러오기
     */
    public AttachmentFile get_file(int id) throws Exception {
        getSession();
        AttachmentFile file = (AttachmentFile) sqlSession.selectOne("p.get_file", id);
        logger.info("처음 file uuid" + file.getUuidName());
        logger.info("처음 file name"+ file.getFileName());
        logger.info(file.getCreator());
        sqlSession.close();
        return file;
    }

    /*
     * 게시글 한개 조회
     */
    public Post get_post(int id) throws Exception {
        getSession();
        Post post = (Post) sqlSession.selectOne("p.selectById", id);
        sqlSession.close();
        return post;
    }

    /*
     * 게시글 전부조회
     */
    public List<Post> get_allPostDesc() throws Exception {
        getSession();
        List<Post> list = sqlSession.selectList("p.selectList");
        sqlSession.close();
        return list;
    }

    /*
     * post_hashtag(중간다리)에 저장
     */
    public int post_hashtag_save(PostHashTag postHashTag) throws Exception {
        getSession();
        int row = sqlSession.insert("p.save_post_hashtag", postHashTag);
        if (row > 0) {
            sqlSession.commit();
        }
        sqlSession.close();
        return row;
    }

    /*
     * hashtag 저장
     */
    public int hashtag_save(HashTag tag) throws Exception{
        getSession();
        int row = sqlSession.insert("p.save_hashtag", tag);
        if (row > 0) {
            sqlSession.commit();
        }
        sqlSession.close();
        return row;
    }

    /*
     * hashtag 조회
     */
    public List<HashTag> get_hashtag(int post_id) throws Exception {
        getSession();
        List<HashTag> list = sqlSession.selectList("p.get_hashtag", post_id);
        sqlSession.close();
        return list;
    }

    /*
     * 조회수 update
     */
    public int update_views(int id) throws Exception {
        getSession();
        int row = sqlSession.update("p.update_views", id);
        sqlSession.close();
        return row;
    }

    /*
     * 카테고리 등록
     */
    public int save_category(Category category) throws Exception {
        getSession();
        int row = sqlSession.insert("p.save_category", category);
        if (row > 0) {
            sqlSession.commit();
        }
        sqlSession.close();
        return row;
    }

    /*
     * 카테고리 한개조회
     */
    public Category get_category(Long category_id) throws Exception {
        getSession();
        Category category = (Category) sqlSession.selectOne("p.get_category", category_id);
        sqlSession.close();
        return category;
    }

    /*
     * 카테고리 전부 조회
     */
    public List<Category> get_all_category() throws Exception {
        getSession();
        List<Category> list = sqlSession.selectList("p.get_all_category");
        sqlSession.close();
        return list;
    }

    /*
     * 카테고리 수정
     */
    public int update_category(CategoryUpdateDto updateDto) throws Exception {
        getSession();
        int row = sqlSession.update("p.update_category", updateDto);
        if (row > 0) {
            sqlSession.commit();
        }
        sqlSession.close();
        return row;
    }

    /*
     * 카테고리 삭제
     */
    public int delete_category(Long id) throws  Exception {
        getSession();
        int row = sqlSession.delete("p.delete_category", id);
        if (row > 0) {
            sqlSession.commit();
        }
        sqlSession.close();
        return row;
    }

    /*
     * 카테고리 삭제시 관련게시물삭제
     */
    public int delete_refpost(Long id) throws Exception {
        getSession();
        int row = sqlSession.delete("p.delete_refpost", id);
        if(row > 0) {
            sqlSession.commit();
        }
        sqlSession.close();
        return row;
    }


    /*
     * 전체 게시판 수
     */
    public int count_post() throws Exception{
        getSession();
        int count = sqlSession.selectOne("p.count_post");
        sqlSession.close();
        return count;
    }

    /*
     * 게시판 with page
     */
    public List<Post> get_post_with_page(PostPage page) throws Exception {
        getSession();
        List<Post> list = sqlSession.selectList("p.get_post_with_page", page);
        sqlSession.close();
        return list;
    }

    /*
     * 검색 (제목, 글쓴이)
     */
    public List<Post> search_post(SearchRequestDto searchRequestDto) throws Exception {
        getSession();
        List<Post> list = sqlSession.selectList("p.search_post", searchRequestDto);
        sqlSession.close();
        return list;
    }

    /*
     * 검색 수 (제목, 글쓴이)
     */
    public int count_search(String param) throws Exception{
        getSession();
        int count = sqlSession.selectOne("p.count_search", param);
        sqlSession.close();
        return count;
    }

    /*
     * 검색 (by 태그)
     */
    public List<Post> search_post_by_tag(SearchRequestDto searchRequestDto) throws Exception {
        getSession();
        List<Post> list = sqlSession.selectList("p.search_post_by_tag", searchRequestDto);
        sqlSession.close();
        return list;
    }

    /*
     * 검색 수 (by 태그)
     */
    public int count_search_by_tag(String param) throws Exception{
        getSession();
        int count = sqlSession.selectOne("p.count_search_by_tag", param);
        sqlSession.close();
        return count;
    }

    /*
     * 계층형 카테고리 저장
     */
    public int save_Tcategory(Tree tree) throws Exception {
        getSession();
        int row = sqlSession.insert("p.save_Tcategory", tree);
        if (row > 0) {
            sqlSession.commit();
        }
        sqlSession.close();
        return row;
    }

    /*
     * 계층형 카테고리 출력
     */
    public List<Tree> select_Tcategory() throws Exception {
        getSession();
        List<Tree> list = sqlSession.selectList("p.select_Tcategory");
        sqlSession.close();
        return list;
    }
}

