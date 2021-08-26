package com.hong.hakwon;


import com.hong.hakwon.Beans.UserBean;
import com.hong.hakwon.dto.UserSaveDto;
import org.junit.Before;
import org.junit.Test;
import org.junit.jupiter.api.Assertions;
import org.junit.runner.RunWith;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
public class UserDAOImplTest {

    @Test
    public void save_select() throws Exception{

        UserDAOImpl userDAO = new UserDAOImpl();

        String userId = "test";
        String password = "1234";
        String name = "테스트";
        String phoneNumber = "010-1234-5678";
        String city = "ci";
        String county = "co";
        String district = "d";
        String email = "test@gmail.com";

        UserSaveDto saveDto = new UserSaveDto(userId, password, name, phoneNumber, city, county, district, email);
        userDAO.saveUser(saveDto);


        List<UserBean> list = userDAO.selectAllUser();
        for (UserBean user : list) {
            System.out.println("user.id = " + user.getId());
            System.out.println("user.name = " + user.getName());
        }

    }
}
