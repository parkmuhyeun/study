package com.hong.hakwon;

import java.io.Reader;
import java.util.List;

import com.hong.hakwon.Beans.History;
import com.hong.hakwon.Beans.SiDo;
import com.hong.hakwon.Beans.SiGunGu;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.hong.hakwon.Beans.UserBean;


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
		List<UserBean> list = sqlSession.selectList("u.selectList");
		sqlSession.close();
		return list;
	}

	public UserBean selectByUserId(String userId) throws Exception {
		getSession();
		UserBean user = (UserBean) sqlSession.selectOne("u.selectByUserId", userId);
		sqlSession.close();
		return user;
	}

	public int saveUser(UserBean userBean) throws Exception {
		getSession();

		int row = sqlSession.insert("u.save_user", userBean);
		if (row > 0) {
			sqlSession.commit();
		}
		sqlSession.close();
		return row;
	}

	public List<SiDo> get_Allsido() throws Exception {
		getSession();
		List<SiDo> siDoList = sqlSession.selectList("u.get_Allsido");
		sqlSession.close();
		return siDoList;
	}

	public SiDo get_sido(int sido_cd) throws Exception {
		getSession();
		SiDo sido = sqlSession.selectOne("u.get_sido", sido_cd);
		sqlSession.close();

		return sido;
	}

	public List<SiGunGu> get_sigungu(int sido_cd) throws Exception {
		getSession();
		List<SiGunGu> siGunGuList = sqlSession.selectList("u.get_sigungu", sido_cd);
		sqlSession.close();
		return siGunGuList;
	}

	//로그인이력 넣기
	public int history_save(History history) throws Exception{
		getSession();
		int row = sqlSession.insert("u.save_history", history);
		if (row > 0) {
			sqlSession.commit();
		}

		return row;
	}


	/*
	 * 로그인
	 * null이면 로그인 실패
	 */
	public UserBean login(String loginId, String password) throws Exception {

		UserBean user = this.selectByUserId(loginId);

		if (user != null) {
			if (user.getPassword().equals(password)) {
				return user;
			}
		}

		return null;
	}

}
