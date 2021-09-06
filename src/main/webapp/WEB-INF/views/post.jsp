<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <a href="/attach/${post.id}" > 파일</a>
    </div>
    <div>
        <span> 내용: ${post.content}</span>
    </div>
</div>
</div>
</body>
</html>