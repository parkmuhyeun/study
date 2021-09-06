<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <title>게시글 등록</title>
        <link href="/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <style>
            .container {
                max-width: 560px;
            }
        </style>
    </head>
    <body>
        <div class ="col-md-12">
            <div class="container">
                <h1>게시글 등록</h1>

                <form:form role="form" action="/posts/save" method="post" commandName="postSaveRequestDto" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="title">제목</label>
                        <form:input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요" path="title"/>
                    </div>
                    <div class="form-group">
                        <form:input type="file" id="file" name="file" path="file"/>
                    </div>
                    <div class="form-group">
                        <label for="content">내용</label>
                        <form:input type="text" class="form-control" name="content" id="content" placeholder="내용을 입력하세요" path="content"/>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary" id="btn-save">등록</button>
                        <a href="/posts" role="button" class="btn btn-secondary">취소</a>
                    </div>
                </form:form>
            </div>
        </div>
    </body>
</html>