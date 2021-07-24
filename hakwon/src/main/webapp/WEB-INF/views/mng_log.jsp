<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/header.jsp"%>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>
$(document).ready(function(){
	
	$(".go_detail").on("click",function(){
		location.href = '/edit_log?v_lcd='+$(this).attr("id");
	});
	
	$(".delete_log").on("click",function(){
		
		location.href = '/delete_log?v_lcd='+$(this).attr("id");
	});
	
	
})

</script>
<style>
th, td {
	padding: 3px 10px;
}

.off-screen {
	display: none;
}

#nav {
	width: 500px;
	text-align: center;
}

#nav a {
	display: inline-block;
	padding: 3px 5px;
	margin-right: 10px;
	font-family: Tahoma;
	background: #ccc;
	color: #000;
	text-decoration: none;
}

#nav a.active {
	background: #333;
	color: #fff;
}

input:read-only {
	text-decoration-line: line-through;
}

.del {
	text-decoration-line: line-through;
}
</style>
</head>

<body>
	<div class="w3-content" style="max-width: 2000px; margin-top: 46px">
		<div class="page-header">
			<h1>오답 이력 관리</h1>
		</div>

		<form action="" id="setRows">
			<input type="text" name="rowPerPage" value="10" class="hide">
			<!-- 한 페이지에 10개씩 -->
		</form>

		<table class="table table-hover" id="products">
			<thead>
				<tr>
					<th>로그 코드</th>
					<th>학생</th>
					<th>선생님</th>
					<th>등록 일시</th>
					<th>관리</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${lList}" varStatus="s" var="vo">
					<tr>
						<td>${vo.v_lcd }</td>
						<td>${vo.v_sname }</td>
						<td>${vo.v_tname }</td>
						<td>${vo.v_reg_dtm }</td>
						<td><a href="javascript:"
							class="go_detail btn btn-default btn-sm" id="${vo.v_lcd }">관리</a>
						</td>
						<td><a href="javascript:"
							class="delete_log btn btn-default btn-sm" id="${vo.v_lcd }">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

	</div>
</body>
</html>

