<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
    <div class="container" style= "margin-top:100px; margin-bottom:100px" >
        <form:form role="form" onsubmit="submitJoin(this); return false;" commandName="userSaveDto" action = "/join" method="post" style="width: 600px" >
            <div>
                <label for="id">ID</label>
                <form:input name="id" id="id" type="text" path="userId" placeholder="ID를 입력하세요"/>
                <button id="idchkbtn" class="btn btn-primary" onclick="idCheck()" type="button">중복 검사</button>
                <b id="iddupchk"></b> <br>
                <span id="iderr" style="color: red"></span>
                <form:errors path="userId" cssStyle="color: red"/>
            </div>

            <div>
                <label for="password">Password</label>
                <form:password name="password" oninput="pwCheck()" id="password" path="password"/>
                <b id="pwV" name="pwV"></b>  <br>
                <span id="pwerr" style="color: red"></span>
                <form:errors path="password" cssStyle="color: red"/>
            </div>

            <div>
                <label for="name">이름</label>
                <form:input type="text"  id="name" oninput="nameCheck()" path="name" size="4" />          <br>
                <span id="nameerr" style="color: red"></span>
                <form:errors path="name" cssStyle="color: red"/>
            </div>

            <div>
                휴대폰번호: <form:select name="f_number" onchange="fChange()" id="f_number" path="f_number">
                    <option value="010">010</option>
                    <option value="019">019</option>
                </form:select>
                <form:input type="text" name="m_number" id="m_number" path="m_number" onkeyup="moveOnMax(this, 'e_number')" size="4" maxlength="4"/>
                <form:input type="text" name="e_number" id="e_number" path="e_number" size="4" maxlength="4"/>      <br>
                <span id="numbererr" style="color: red"></span>
                <form:errors path="f_number" cssStyle="color: red"/>
            </div>

            <br>

            <div>
                주소: <form:select name="sido" onchange="sidoChange()" id="sido"  path="sido">
                <option value="">시/도</option>
                <c:forEach var="sidoList" items="${sido}">
                    <option value="${sidoList.sido_cd}">${sidoList.sido_name}</option>
                </c:forEach>
            </form:select>
                <form:select name="sigungu" id="sigungu"  path="sigungu">
                    <option value="">시/군/구</option>
                </form:select>
                <br>
                <span id="adderr" style="color: red"></span>
                <form:errors path="sido" cssStyle="color: red"/>
            </div>

            <div>
                <label for="email">Email</label>
                <form:input type="email" name="email" id="email" path="email"/>         <br>
                <span id="emailerr" style="color: red"></span>
                <form:errors path="email" cssStyle="color: red"/>
            </div>

            <div class="text-center">
                <button class="btn btn-primary " id="sub_btn" type="submit" >회원 가입</button>
            </div>
        </form:form>
<%--        <button class="btn btn-primary" onclick="location.href = 'main'" >취소</button>--%>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">

    var joinFormSubmit = false;

    var pwPattern = /^[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{8,15}$/;
    var namePattern = /^[가-힣]{2,30}$/;
    var numberPattern = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
    var addressPattern = /^[0-9]+$/;
    var emailPattern = /^[_a-zA-Z0-9-\.]+@[\.a-zA-Z0-9-]+\.[a-zA-Z]+$/;



    function submitJoin(form) {

        // 중복검사 부터
        // 그다음 프론트단에서 유효성 검사 후 이상없으면 submit
        if (!joinFormSubmit) {
            $('#iddupchk').text("중복 검사해주세요.");
            $('#iddupchk').css("color", "red");
            return false;
        }

        if(checkPw() & checkName() & checkNum() & checkadd() & checkmail()){
            form.submit();
        }else{
            return false;
        }


        // if (!joinFormSubmit) {
        //     $('#iddupchk').text("중복 검사해주세요.");
        //     $('#iddupchk').css("color", "red");
        //     return false;
        // }else {
        //
        //     if ($('#password').val() == "") {
        //         $('#pwerr').text('필수 정보입니다.');
        //         return false;
        //     }else if (!pwCheck.test($('#password').val())) {
        //         $('#pwerr').text('8자리에서 15자리 영문, 숫자, 특수문자를 사용하세요.');
        //         return false;
        //     }
        //
        //     if ($('#name').val() == "") {
        //         $('#nameerr').text('필수 정보입니다.');
        //         return false;
        //     }else if (!nameCheck.test($('#name').val())) {
        //         $('#nameerr').text('2글자 이상 30글자 이하로 적어주세요.');
        //         return false;
        //     }
        //
        //     var phonenum = $('#f_number').val() + '-' + $('#m_number').val() + '-' + $('#e_number').val();
        //     if (!numberCheck.test(phonenum)) {
        //         $('#numbererr').text('올바른 형식이 아닙니다.');
        //         return false;
        //     }
        //
        //     if (!addCheck.test($('#sido').val())) {
        //         $('#adderr').text('주소를 입력해주세요.');
        //         return false;
        //     }
        //
        //     if ($('#email').val() == "") {
        //         $('#emailerr').text('필수 정보입니다.');
        //         return false;
        //     }else if (!emailCheck.test($('#email').val())) {
        //         $('#emailerr').text('올바른 형식이 아닙니다.');
        //         return false;
        //     }
        //
        //     form.submit();
        // }

    }

    function idCheck() {

        var id = $('#id').val();
        var idPattern = /^[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{8,15}$/;

        if ($('#id').val() == "") {
            $('#iderr').text('필수 정보입니다.');
        }
        else if ( !idPattern.test(id)) {
            // alert('8 ~ 15 자리 영문 혹은 숫자 등(한글제외) 입력 해주세요')
            $('#iderr').text('8자리에서 15자리 영문, 숫자, 특수문자를 사용하세요.');
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
                                $('#iddupchk').text("");
                                // $('#sub_btn').removeAttr('disabled');
                                joinFormSubmit = true;
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
                    console.log("t");
                    $('#pwV').text("사용 가능");
                    $('#pwV').css("color", "green");
                }else{
                    console.log("f");
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


    // 유효성 체크function
    function checkPw(){
        if ($('#password').val() == "") {
            $('#pwerr').text('필수 정보입니다.');
            return false;
        }else if (!pwPattern.test($('#password').val())) {
            $('#pwerr').text('8자리에서 15자리 영문, 숫자, 특수문자를 사용하세요.');
            return false;
        }

        return true;
    }

    function checkName(){
        if ($('#name').val() == "") {
            $('#nameerr').text('필수 정보입니다.');
            return false;
        }else if (!namePattern.test($('#name').val())) {
            $('#nameerr').text('2글자 이상 30글자 이하로 적어주세요.');
            return false;
        }

        return true;
    }

    function checkNum(){
        var phonenum = $('#f_number').val() + '-' + $('#m_number').val() + '-' + $('#e_number').val();
        if (!numberPattern.test(phonenum)) {
            $('#numbererr').text('올바른 형식이 아닙니다.');
            return false;
        }

        return true;
    }

    function checkadd(){
        if (!addressPattern.test($('#sido').val())) {
            $('#adderr').text('주소를 입력해주세요.');
            return false;
        }

        return true;
    }

    function checkmail(){
        if ($('#email').val() == "") {
            $('#emailerr').text('필수 정보입니다.');
            return false;
        }else if (!emailPattern.test($('#email').val())) {
            $('#emailerr').text('올바른 형식이 아닙니다.');
            return false;
        }

        return true;
    }


</script>
</html>
