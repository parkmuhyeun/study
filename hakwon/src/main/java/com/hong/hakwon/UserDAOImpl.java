package com.hong.hakwon;

import java.io.PrintWriter;
import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.hong.hakwon.Beans.UserBean;
import com.hong.hakwon.common.CmMap;

public class UserDAOImpl {
	Reader reader =null;
	SqlSessionFactory factory = null;
	SqlSession sqlsession=null;
	
	public void getSession() throws Exception{
		String resource="util/SqlMapConfig.xml";
		reader=Resources.getResourceAsReader(resource);
		
		if(factory == null)
			factory = new SqlSessionFactoryBuilder().build(reader);
		
		sqlsession=factory.openSession(true);
	}

	public List <UserBean> get_user() throws Exception {
		getSession();
		List <UserBean> list=sqlsession.selectList("u.get_user_c", "aaa");
		sqlsession.close();
		return list;
	}
	
	public Boolean reg_user(UserBean ub) throws Exception {
		getSession();
		int result = sqlsession.insert("u.reg_user", ub);
		sqlsession.close();
		return result > 0 ? true : false;
	}
	
	public List <CmMap> get_sido() throws Exception {
		getSession();
		List <CmMap> list = sqlsession.selectList("u.get_sido");
		sqlsession.close();
		return list;
	}

}
