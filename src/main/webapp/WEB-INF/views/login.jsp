<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>

//TODO

</script>
</head>

<body>
	<div>
		<form:form role="form" commandName="loginForm" name="frm_login" id="frm_login" action ="/login" method="post">
		id: <form:input type="text" name="id" class="_target" id="id" path="id"/>
		password:<form:input path="password" type="password"	name="pw" class="_target" id="pw"/>
		<button class="submit" id="submit" type="submit">제출</button> <br>
			<form:errors cssStyle="color: red"></form:errors>
		</form:form>
	</div>
</body>
</html>

