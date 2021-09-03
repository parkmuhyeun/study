<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>로그인</title>
	<link href="/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="/resources/css/signin.css" rel="stylesheet">
</head>
<body class="text-center">
	<main class="form-signin">
		<div class="container"  >
			<form:form role="form" onsubmit="submitJoin(this); return false;" commandName="loginForm"  action ="/login" method="post" >
				<h1 class="h3 mb-3 fw-normal">Please sign in</h1>

				<div class="form-floating">
					<form:input type="text" name="id" class="form-control" id="id" path="id" placeholder="ID"/>
					<label for="id">ID</label>
				</div>
				<div class="form-floating">
					<form:input path="password" type="password" name="pw" class="form-control" id="pw" placeholder="Password"/>
					<label for="pw">Password</label>
				</div>
				<div class="checkbox mb-3">
					<label>
						<form:checkbox onchange="ReIdCheck(this)" id="rememberId" name="rememberId" path="rememberId"/>
						Remember ID
					</label>
				</div>
				<button class="w-100 btn btn-lg btn-primary" type="submit">Sign in</button>
				<span id="err" style="color: red"></span>
				<form:errors id="gerr" cssStyle="color: red"/>
				<p class="mt-5 mb-3 text-muted">&copy; 2017–2021</p>
			</form:form>

	<%--		<button class="btn btn-primary" onclick="location.href = 'main'" >취소</button> <br>--%>
		</div>
	</main>
</body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	function submitJoin(form) {

		if ($('#id').val() == "") {
			$('#gerr').text('');
			$('#err').text('아이디를 입력해주세요.');
			return false;
		}else if ($('#pw').val() == "") {
			$('#gerr').text('');
			$('#err').text('비밀번호를 입력해주세요.');
			return false;
		}
		$('#err').text('');
		form.submit();
	}

	function ReIdCheck(box) {

		$.ajax({
			type:"POST",
			url: "/login/reid",
			data: { rid: box.checked}
		})
	}
</script>
</html>