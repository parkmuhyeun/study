package com.hong.hakwon;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import com.hong.hakwon.dto.SiDo;
import com.hong.hakwon.dto.SiGunGu;
import com.hong.hakwon.dto.UserSaveDto;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.hong.hakwon.Beans.UserBean;
import com.hong.hakwon.common.CmMap;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAOImpl {
	Reader reader =null;
	SqlSessionFactory factory = null;
	SqlSession sqlSession;

	public void getSession() throws Exception{
		String resource="util/SqlMapConfig.xml";
		reader=Resources.getResourceAsReader(resource);

		if(factory == null)
			factory = new SqlSessionFactoryBuilder().build(reader);

		sqlSession =factory.openSession(true);
	}

	public List <UserBean> get_user() throws Exception {
		getSession();
		List <UserBean> list= sqlSession.selectList("u.get_user_c", "aaa");
		sqlSession.close();
		return list;
	}

	public List<UserBean> selectAllUser() throws Exception {
		getSession();
		List<UserBean> list = sqlSession.selectList("u.selectAllUser");
		sqlSession.close();
		return list;
	}

	public UserBean selectById(int id) throws Exception {
		getSession();
		UserBean user = (UserBean) sqlSession.selectOne("u.selectById", id);
		sqlSession.close();
		return user;
	}

	public int saveUser(UserBean userBean) throws Exception {
		getSession();

		int row = sqlSession.insert("u.saveUser", userBean);
		if (row > 0) {
			sqlSession.commit();
		}
		sqlSession.close();
		return row;
	}

	public List<SiDo> get_sido() throws Exception {
		getSession();
		List<SiDo> siDoList = sqlSession.selectList("u.get_sido");
		sqlSession.close();
		return siDoList;
	}

	public List<SiGunGu> get_sigungu(int sido_cd) throws Exception {
		getSession();
		List<SiGunGu> siGunGuList = sqlSession.selectList("u.get_sigungu", sido_cd);
		sqlSession.close();
		return siGunGuList;
	}

}
