package com.hong.hakwon.web.validation;

import com.hong.hakwon.web.dto.UserSaveDto;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
public class RegisterValidator implements Validator {

    String id_chk = "^[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]*$";      //영문자 && 숫자 && 특수문자
    String name_chk = "^[가-힣]*$";      //한글만
    String email_chk = "^[_a-zA-Z0-9-\\.]+@[\\.a-zA-Z0-9-]+\\.[a-zA-Z]+$";       //표준 이메일
    String pw_chk = "^[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]*$";      //영문자 && 숫자 && 특수문자
    String number_chk = "^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}$";
    String sido_chk = "^[0-9]+$";

    private Pattern idP = Pattern.compile(id_chk);
    private Pattern passP = Pattern.compile(pw_chk);
    private Pattern nameP = Pattern.compile(name_chk);
    private Pattern numberP = Pattern.compile(number_chk);
    private Pattern sidoP = Pattern.compile(sido_chk);
    private Pattern emailP = Pattern.compile(email_chk);

    @Override
    public boolean supports(Class<?> clazz) {
        return UserSaveDto.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        UserSaveDto userSaveDto = (UserSaveDto) target;

        if(userSaveDto.getUserId() == null || userSaveDto.getUserId().length() < 8 || userSaveDto.getUserId().length() > 15){
            errors.rejectValue("userId", null, "8 ~ 15 자리 영문 혹은 숫자 등(한글제외) 입력 해주세요");
        } else {
            Matcher matcher = idP.matcher(userSaveDto.getUserId());
            if(!matcher.matches()){
                errors.rejectValue("userId", null, "올바르지 않는 형식입니다.");
            }
        }

        if(userSaveDto.getName() == null || userSaveDto.getName().length() < 2 || userSaveDto.getName().length() > 30){
            errors.rejectValue("name", null, "2글자 이상 30글자 이하로 적어주세요.");
        }else {
            Matcher matcher = nameP.matcher(userSaveDto.getName());
            if (!matcher.matches()) {
                errors.rejectValue("name", null, "올바르지 않는 형식입니다.(한글만 입력) ");
            }
        }

        String phoneNumber = userSaveDto.getF_number() +"-"+ userSaveDto.getM_number() +"-"+ userSaveDto.getE_number();
        Matcher matcherNum = numberP.matcher(phoneNumber);
        if (!matcherNum.matches()) {
            errors.rejectValue("f_number", null, "올바르지 않은 형식입니다.");
        }


        //시도 시군구 두개다 null이면 오류

        Matcher matchersi = sidoP.matcher(userSaveDto.getSido());
        if (!matchersi.matches()) {
            errors.rejectValue("sido",null, "주소를 입력해주세요");
        }


        Matcher matcherE = emailP.matcher(userSaveDto.getEmail());
        if(userSaveDto.getEmail() == null || !matcherE.matches()) {
            errors.rejectValue("email", null, "올바르지 않는 형식입니다. ex) example@email.com");
        }

        if(userSaveDto.getPassword() == null || userSaveDto.getPassword().length() < 8 || userSaveDto.getPassword().length() > 15){
            errors.rejectValue("password", null, "8 ~ 15 자리 영문 혹은 숫자 입력 해주세요");
        } else {
            Matcher matcher = passP.matcher(userSaveDto.getPassword());
            if(!matcher.matches()){
                errors.rejectValue("password", null, "올바르지 않는 형식입니다.");
            }
        }


    }
}
