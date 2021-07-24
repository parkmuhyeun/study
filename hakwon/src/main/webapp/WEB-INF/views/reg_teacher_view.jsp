<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/header.jsp"%>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<%-- <script type="text/javascript" src="${JS_URL}h_Validator.js" ></script> --%>

<script>
$(document).ready(function(){
	
})

</script>
</head>

<body>
	<div class="w3-content" style="max-width: 2000px; margin-top: 46px">
		선생님 등록(마스터)

		<form name="frm_reg" id="frm_reg" action="/reg_teacher" method="post">

			<!-- v_tcd		v_tid		v_tpassword	v_tname	v_tlevel	v_flag_del	v_reg_dtm			v_mod_dtm
	tcd00001	dowkekd9576	1234		홍석훈	1			N			2017-09-24 21:28	2017-09-24 21:28 -->

			ID : <input type="text" name="id" class="_target" id="id" /> PW : <input
				type="password" name="pw" class="_target" id="pw" /> 이름: <input
				type="text" name="name" class="_target" id="name" /> 권한: <select
				name="level">
				<option value="1">관리자</option>
				<option value="2">일반</option>
			</select>

			<button class="submit" id="submit">제출</button>
		</form>
	</div>
</body>
</html>

