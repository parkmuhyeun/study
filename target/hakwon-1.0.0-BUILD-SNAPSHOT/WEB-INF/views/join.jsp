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
        <form:form role="form"  commandName="userSaveDto" action = "/join" method="post" >
            <div>
                id: <form:input name="id" id="id" type="text" path="userId"/>
                <button id="idchkbtn" onclick="idCheck()" type="button">중복 검사</button>
                <b id="idV"> </b>           <br>
                <form:errors path="userId" cssStyle="color: red"/>
            </div>
            <div>
                password: <form:password name="password" oninput="pwCheck()" id="password" path="password"/>
                <b id="pwV" name="pwV"></b>  <br>
                <form:errors path="password" cssStyle="color: red"/>
            </div>
            <div>
                이름: <form:input type="text" id="name" oninput="nameCheck()" path="name" size="4" />          <br>
                <form:errors path="name" cssStyle="color: red"/>
            </div>

            <div>
                휴대폰번호: <form:select name="f_number" onchange="fChange()" id="f_number" path="f_number">
                    <option value="010">010</option>
                    <option value="019">019</option>
                </form:select>
                <form:input type="text" name="m_number" id="m_number" path="m_number" onkeyup="moveOnMax(this, 'e_number')" size="4" maxlength="4"/>
                <form:input type="text" name="e_number" id="e_number" path="e_number" size="4" maxlength="4"/>      <br>
                <form:errors path="f_number" cssStyle="color: red"/>
            </div>
                  주소: <form:select name="sido" onchange="sidoChange()" id="sido"  path="sido">
                    <option value="">시/도</option>
                        <c:forEach var="sidoList" items="${sido}">
                            <option value="${sidoList.sido_cd}">${sidoList.sido_name}</option>
                        </c:forEach>
                    </form:select>
                  <form:select name="sigungu" id="sigungu"  path="sigungu">
                  <option value="">시/군/구</option>
                  </form:select>
            <div>

            </div>

            <div>
                email: <form:input type="email" name="email" id="email" path="email"/>         <br>
                <form:errors path="email" cssStyle="color: red"/>

            </div>
            <button id="sub_btn" type="submit" disabled>회원 가입</button>
            <button onclick="location.href = 'main'" type="button">취소</button>
        </form:form>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">

    function idCheck() {
        var id = $('#id').val();
        var idV = /^[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{8,15}$/;
        if ( !idV.test(id)) {
            alert('8 ~ 15 자리 영문 혹은 숫자 등(한글제외) 입력 해주세요')
        }
        else{
            $.ajax({
                type:"POST",
                url: "/join/idCheck",
                data: { id: id },
                success:function(response) {
                    if(response == true){
                        Swal.fire({
                            title: '사용하시겠습니까?',
                            showDenyButton: true,
                            showCancelButton: true,
                            confirmButtonText: `Yes`,
                            denyButtonText: `No`,
                        }).then((result) => {
                            /* Read more about isConfirmed, isDenied below */
                            if (result.isConfirmed) {
                                $('#id').attr("readonly", true);
                                $('#idchkbtn').prop('disabled', true);
                                $('#sub_btn').removeAttr('disabled');
                            } else if (result.isDenied) {
                                $('#id').focus();
                            }
                        })
                    }else{
                        alert('이미 존재하는 아이디입니다.')
                    }
                }
            });
        }


    }

    function pwCheck() {
        $.ajax({
            type:"POST",
            url: "/join/pwCheck",
            data : { password: $('#password').val() },
            success:function(result) {
                if(result == true){
                    $('#pwV').text("사용 가능");
                    $('#pwV').css("color", "green");
                }else{
                    $('#pwV').text("사용 불가능(8 ~ 15자리 입력(한글제외)");
                    $('#pwV').css("color", "red");
                }
            }
        })
    }

    function nameCheck() {
        if($('#name').val().length >=5){
            $('#name').prop("type", "textarea");
            $('#name').attr("size", 30);
        }else{
            $('#name ').prop("type", "text");
            $('#name').attr("size", 4);
        }
    }

    function fChange(){
        if( $('#f_number').val() == "019" ){
            $('#m_number').val('');
            $('#m_number').attr("maxLength", 3)
        }else{
            $('#m_number').val('');
            $('#m_number').attr("maxLength", 4)
        }
    }

    function moveOnMax(field, nextFieldId) {

        if (field.value.length >= field.maxLength) {
                document.getElementById(nextFieldId).focus();
        }
    }

    function sidoChange() {

        $.ajax({
            type:"POST",
            url: "/join/sigungu",
            data : { sido_cd: $("#sido option:selected").val() },
            success: function (result){
                $('#sigungu').find('option').remove();
                for (var i = 0; i < result.length; i++) {
                    $('#sigungu').append("<option value='" + result[i].sigungu_name + "'>" + result[i].sigungu_name + "</option>");
                }

                console.log(result[0]);

            }
        })

    }



</script>
</html>
