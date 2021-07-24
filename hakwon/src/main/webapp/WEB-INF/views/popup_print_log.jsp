<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script>
</script>
<style>
#break {
	word-break: break-all
}
</style>
</head>

<body>
	문제 출력 로그 목록

	<table class="table table-hover">
		<thead>
			<tr>
				<th>학생</th>
				<th>선생님</th>
				<th>책</th>
				<th>문제</th>
				<th>출력일시</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${lList}" varStatus="s" var="vo">
				<tr>
					<td>${vo.v_scd}</td>
					<td>${vo.v_tcd}</td>
					<td>${vo.v_bcd}</td>
					<td id="break">${vo.v_filenms}</td>
					<td>${vo.v_reg_dtm}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>

