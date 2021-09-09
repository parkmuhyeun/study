<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>\
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <style>
        .container {
            max-width: 560px;
        }
    </style>
</head>
<body>
<div class="container">
    <div>
        <span> 제목 : ${post.title}</span>
    </div>
    <!-- file있으면 링크 없으면 x -->
    <div>
        <span> 첨부파일: </span>
        <c:if test="${not empty post.filePath}">
            <a href="/attach/${post.id}" >파일</a>
        </c:if>
        <c:if test="${empty post.filePath}">
            <span> 첨부파일이 없습니다.</span>
        </c:if>
    </div>
    <div>
        <span> 내용: ${post.content}</span>
    </div>
    <div>
        연관 태그:
        <c:forEach var="tag" items="${post.tagList}">
        <span> #${tag}</span>
    </c:forEach>
    </div>

</div>
</body>
</html>