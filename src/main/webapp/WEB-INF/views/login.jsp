<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<script>

//TODO

</script>
	<title>로그인</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>

<body>
	<div class="container" style= "margin-top:100px; margin-bottom:100px" >
		<form:form role="form" commandName="loginForm"  action ="/login" method="post" style="width: 600px">
			<div class="form-group">
				<label for="id">ID</label>
				<form:input type="text" name="id" class="form-control" id="id" path="id" placeholder="Id"/>
			</div>
			<div class="form-group">
				<label for="pw">Password</label>
				<form:input path="password" type="password" name="pw" class="form-control" id="pw" placeholder="Password"/>
			</div>
			<div class="text-center">
				<button class="btn btn-primary" type="submit">로그인</button>
			</div>
			<div class="text-center">
				<form:errors cssStyle="color: red"/>
			</div>

		</form:form>

<%--		<button class="btn btn-primary" onclick="location.href = 'main'" >취소</button> <br>--%>

	</div>
</body>
</html>

