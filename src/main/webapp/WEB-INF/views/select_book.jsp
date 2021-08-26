<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/header.jsp"%>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- <script src="/resources/js/cm_dialog.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/sub.css">
<link rel="stylesheet" type="text/css" href="/resources/css/popup.css"> -->

<script>
$(document).ready(function(){
	$(".selBook").on("click",function(){
		
		location.href = '/stack?bName='+$(this).attr("id");
	});
});
</script>
</head>

<body>

	<c:forEach items="${bookList}" varStatus="s" var="vo">
		<a href="javascript:" class="selBook" id="${vo}">${vo}</a>
	</c:forEach>

</body>
</html>

