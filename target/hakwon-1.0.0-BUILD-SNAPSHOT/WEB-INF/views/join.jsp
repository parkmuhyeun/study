<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Title</title>


</head>
<body>
    <div>
        <form:form role="form" commandName="userSaveDto" action = "/join" method="post" >
            <div>
                id: <form:input type="text" class=""  path="userId"/>
                <button class = "" type="button">중복 검사</button>              <br>
                <form:errors path="userId" cssStyle="color: red"/>
                <b id="pwCheckV" name = "pwCheckV"></b>
            </div>
            <div>
                password: <form:password name="password" class="" oninput="pwCheck()" id="password" path="password"/> <br>
                <b id="pwV" name="pwV"></b>
                <form:errors path="password" cssStyle="color: red"/>
            </div>
            <div>
                이름: <form:input type="text" id="name" class="" oninput="nameCheck()" path="name" size="4" />          <br>
                <form:errors id="abc" path="name" cssStyle="color: red"/>
            </div>


            <div>
                email: <form:input type="email" name="email" class="" id="email" path="email"/>         <br>
                <form:errors path="email" cssStyle="color: red"/>

            </div>
            <button id="sub_Btn" class = "" type="submit" disabled>회원 가입</button>
            <button class = "" onclick="location.href = 'main'" type="button">취소</button>
        </form:form>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
    function pwCheck() {
        $.ajax({
            type:"POST",
            url: "/join/pwCheck",
            data : { password: $('#password').val() },
            success:function(result) {
                if(result == true){
                    $('#pwV').text("사용가능한 비밀번호입니다.");
                    $('#pwV').css("color", "green");
                    $('#sub_Btn').prop('disabled', false);
                }else{
                    $('#pwV').text("8 ~ 15 자리 영문 혹은 숫자 입력 해주세요");
                    $('#pwV').css("color", "red");
                    $('#sub_Btn').prop('disabled', true);

                }
            }
        })
    }

    function nameCheck() {
        if($('#name').val().length >=5){
            console.log("c");
            $('#name').prop("type", "textarea");
            $('#name').attr("size", "30");
        }else{
            console.log("o");
            $('#name ').prop("type", "text");
            $('#name').attr("size", "4");
        }
    }
</script>
</html>
