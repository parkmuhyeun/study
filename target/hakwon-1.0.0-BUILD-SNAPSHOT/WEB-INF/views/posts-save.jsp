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

            <form:form onsubmit="submitPost(this); return false;" role="form" action="/posts/save" method="post" commandName="postSaveRequestDto" enctype="multipart/form-data">
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
                <div class="form-group">
                    <label for="hashTagContent">태그</label>
<%--                    <form:input type="text" class="form-control" name="hashTagContent" id="hashTagContent" placeholder="해시태그를 입력하세요" path="hashTagContent"/>--%>
                    <form:input type="hidden" name="hashTagContent" id="f_hashTagContent" path="hashTagContent"/>
                    <input type="text" class="form-control" id="hashTagContent" placeholder="해시태그를 입력하세요"/>
                </div>
                <div id="tag-list">
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary" id="btn-save">등록</button>
                    <a href="/posts" role="button" class="btn btn-secondary">취소</a>
                </div>
            </form:form>
        </div>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

    var tag = {};
    var counter = 0; //태그식별을위한 counter

    function submitPost(form) {
        $("#btn-save").click(function () {
            console.log("버튼");
            var array = tagArray();
            $("#f_hashTagContent").val(array);
            console.log("버튼");
            form.submit();
        });
    }

    //tag값을 array로 만듬
    function tagArray() {
        return Object.values(tag).filter(function(word) {
            return word != "";
        })
    }

    $(document).ready(function (){

        //태그추가
        function addTag (value) {
            tag[counter] = value;
            counter++;
        }

        $("#hashTagContent").on("keypress", function (e){

            var value = $(this);

            if (e.key == "Enter") {
                event.preventDefault();
                var tagValue = value.val();

                //값이 없으면 태그 저장 x
                if (tagValue != "") {

                    //중복있는지 확인
                    var result = Object.values(tag).filter(function (word) {
                        return word == tagValue;
                    })

                    //태그 중복아니면
                    if (result.length == 0) {
                        $("#tag-list").append("<span role='button' id='btn_tag' idx='" + counter + "'> #" + tagValue + " x </span>")
                        addTag(tagValue);
                        value.val("");
                    }
                }
            }

        })

        $(document).on("click", "#btn_tag", function (e) {
            var index = $(this).attr("idx");
            tag[index] = "";
            $(this).remove()
        });
    })
</script>
</html>