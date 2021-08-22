<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
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
		<form name="frm_login" id="frm_login" action ="/chk_login" method="post">
		&nbsp;id: <input type="text" name="id" class="_target" id="id"/>
		&nbsp;password:<input type="password"	name="pw" class="_target"		id="pw"/>
		<button class="submit" id="submit">제출</button>
		</form>
	</div>
</body>
</html>

