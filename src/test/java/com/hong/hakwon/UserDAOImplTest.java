package com.hong.hakwon;


import com.hong.hakwon.Beans.UserBean;
import com.hong.hakwon.Beans.SiDo;
import com.hong.hakwon.Beans.SiGunGu;
import org.junit.Test;

import java.util.List;


public class UserDAOImplTest {

    UserDAOImpl userDAO = new UserDAOImpl();

    @Test
    public void save_select() throws Exception{


        String userId = "testtest";
        String password = "1234";
        String name = "테스트";
        String phoneNumber = "010-1234-5679";
        int sido_cd = 22;
        String sigungu = "수성구";
        String email = "test@gmail.com";

        SiDo sido = userDAO.get_sido(sido_cd);
        UserBean ub = new UserBean(10, userId, password, name, phoneNumber, sido.getSido_name(), sigungu, email);

        userDAO.saveUser(ub);

        List<UserBean> list = userDAO.selectAllUser();
        for (UserBean user : list) {
            System.out.println("user.getName() = " + user.getName());
            System.out.println("user.id = " + user.getUserId());
            System.out.println("user.pass = " + user.getPassword());
            System.out.println("user.phone = " + user.getPhoneNumber());

        }
    }


    @Test
    public void get_sido() throws Exception {
        List<SiDo> sido = userDAO.get_Allsido();

        for (SiDo siDo : sido) {
            System.out.println("siDo.getSido_cd() = " + siDo.getSido_cd());
            System.out.println("siDo.getSido_name() = " + siDo.getSido_name());
        }
    }

    @Test
    public void get_sigungu() throws Exception {
        int sido_cd = 11;

        List<SiGunGu> sigungu = userDAO.get_sigungu(sido_cd);

        for (SiGunGu siGunGu : sigungu) {
            System.out.println("siGunGu.getSigungu_cd() = " + siGunGu.getSigungu_cd());
            System.out.println("siGunGu.name = " + siGunGu.getSigungu_name());
        }


    }

}
