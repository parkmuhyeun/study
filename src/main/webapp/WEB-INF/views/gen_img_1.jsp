<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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

<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">

<script>
$(document).ready(function(){
	
	function loadQuestion(){
		
		var qCnt = parseInt($("input[name='question']").length);//문제 cnt
		//한 페이지 내 4개만 보이도록(첫페이지는 두개만 들어가고)
		var pageCnt = parseInt(qCnt / 2);
		var plus	= qCnt % 2 == 0 ? 0 : 1;//페이지 cnt
		pageCnt = pageCnt+plus;
		$("#pgnum_0 >b").text("1/"+pageCnt);//첫페이지에 페이지 번호 세팅
		
		var appdHtml = [];
		
		if(pageCnt >= 2){
			for(var i=1; i<pageCnt; i++){
				appdHtml.push("<div class='page_question' id='pgnum_'"+i+"'>");
				appdHtml.push("		<div class='subpage'>");
				appdHtml.push("			<div class='half'><image class='qimg' src=''></div>");
				appdHtml.push("			<div class='half'><image class='qimg' src=''></div>");
				appdHtml.push("		</div>");
				appdHtml.push("			<b class='pg_idx'>"+parseInt(i+1)+"/"+pageCnt+"</b>");
				appdHtml.push("</div>");
			}
		}
		
		$(".q_area").append(appdHtml.join(""));
		
		$(".question").each(function(idx){//각 img마다 src세팅해주고
			$(".qimg").eq(idx).attr("src","/resources/UPLOAD/"+$(this).val());
		});
		
		$(".qimg[src='']").hide();
		$(".qimg[src='']").parent().hide();
	}
	//////////////////////////////////////////////////
	
	function loadAnswer(){
		
		var aCnt = parseInt($("input[name='answer']").length);//문제 cnt
		//한 페이지 내 6개만 보이도록(첫페이지는 두개만 들어가고)
		var pageCnt = parseInt(aCnt / 6);
		var plus	= aCnt % 6 == 0 ? 0 : 1;//페이지 cnt
		pageCnt = pageCnt+plus;
		$("#pgnum_0 >b").text("1/"+pageCnt);//첫페이지에 페이지 번호 세팅
		
		var appdHtml = [];
		
		if(pageCnt >= 2){
			for(var i=1; i<pageCnt; i++){
				appdHtml.push("<div class='page_answer' id='pgnum_'"+i+"'>");
				appdHtml.push("		<div class='subpage'>");
				appdHtml.push("			<div class='hexa'><image class='aimg' src=''></div>");
				appdHtml.push("			<div class='hexa'><image class='aimg' src=''></div>");
				appdHtml.push("			<div class='hexa'><image class='aimg' src=''></div>");
				appdHtml.push("			<div class='hexa'><image class='aimg' src=''></div>");
				appdHtml.push("			<div class='hexa'><image class='aimg' src=''></div>");
				appdHtml.push("			<div class='hexa'><image class='aimg' src=''></div>");
				appdHtml.push("		</div>");
				appdHtml.push("			<b class='pg_idx'>"+parseInt(i+1)+"/"+pageCnt+"</b>");
				appdHtml.push("</div>");
			}
		}
		
		$(".a_area").append(appdHtml.join(""));
		
		$(".answer").each(function(idx){//각 img마다 src세팅해주고
			$(".aimg").eq(idx).attr("src","/resources/UPLOAD/"+$(this).val());
		});
		
		$(".aimg[src='']").hide();
		$(".aimg[src='']").parent().hide();
	}
	
	loadQuestion();
	loadAnswer();
	
	
})

</script>
<style>
/*A4 - 웹뷰 화면 세팅*/
body {
	margin: 0;
	padding: 0;
}

* {
	box-sizing: border-box;
	-moz-box-sizing: border-box;
}

.page_question {
	width: 21cm;
	min-height: 29.7cm;
	padding: 5mm;
	margin: 0 auto;
	background: #eee;
}

.page_answer {
	width: 21cm;
	min-height: 29.7cm;
	padding: 5mm;
	margin: 0 auto;
	background: #eee;
}

.subpage {
	border: 1px dotted solid;
	background: #fff;
	height: 284mm;
}

@page {
	size: A4;
	margin: 0;
}

/*A4 - 프린트 화면 세팅*/
@media print {
	html, body {
		width: 210mm;
		height: 297mm;
	}
	.page_question {
		margin: 0;
		border: initial;
		width: initial;
		min-height: initial;
		box-shadow: initial;
		background: initial;
		page-break-after: always;
	}
	.page_answer {
		margin: 0;
		border: initial;
		width: initial;
		min-height: initial;
		box-shadow: initial;
		background: initial;
		page-break-after: always;
	}
}

/* 내부 프레임 세팅*/
.hexa {
	width: 50%;
	height: 32%;
	float: left;
	border: 1px dotted black
}

.quarter {
	width: 50%;
	height: 48.5%;
	float: left;
	border: 1px dotted black
}

.half {
	width: 50%;
	height: 98%;
	float: left;
	border: 1px dotted black
}

.upper_form {
	width: 100%;
	height: 48%
}

.pg_idx {
	background-color: white;
	font-size: 13px;
	float: left;
	overflow: hidden;
	margin-top: -33px;
	margin-left: 362px;
}

img {
	width: 373px;
	height: 300px;
	margin-left: 1px;
	margin-right: 1px;
}

.table {
	margin: 0 auto;
	margin-top: 300px;
}

h2 {
	text-align: center;
}
</style>
</head>

<body>
	<c:forEach items="${queList}" var="vo" varStatus="s">
		<input type="hidden" name="question" class="question"
			id="question_${s.count}" value="${vo}">
	</c:forEach>

	<c:forEach items="${ansList}" var="vo" varStatus="s">
		<input type="hidden" name="answer" class="answer"
			id="answer_${s.count}" value="${vo}">
	</c:forEach>
	<div class="q_area">

		<div class="page_question" id="pgnum_0">
			<div class="subpage">


				<div class="upper_form">
					<h2>SAMPLE</h2>
					<h2>원수학</h2>
					<h2>문제양식-2</h2>
					<h2></h2>
					<table class="table table-bordered">
						<tr>
							<th>담당선생님</th>
							<th>학생이름</th>
							<th>문제수</th>
						</tr>
						<tr>
							<td>${t_name }</td>
							<td>${s_name }</td>
							<td>${cnt }</td>
						</tr>
					</table>

				</div>
				<div class="quarter">
					<image class="qimg" src="">
				</div>
				<div class="quarter">
					<image class="qimg" src="">
				</div>
			</div>
			<b class="pg_idx">1</b>
		</div>


	</div>




	<!-- --------------- -->




	<div class="a_area">

		<div class="page_answer" id="pgnum_0">
			<div class="subpage">

				<div class="hexa">
					<image class="aimg" src="">
				</div>
				<div class="hexa">
					<image class="aimg" src="">
				</div>
				<div class="hexa">
					<image class="aimg" src="">
				</div>
				<div class="hexa">
					<image class="aimg" src="">
				</div>
				<div class="hexa">
					<image class="aimg" src="">
				</div>
				<div class="hexa">
					<image class="aimg" src="">
				</div>
			</div>
			<b class="pg_idx">1</b>
		</div>



	</div>



</body>
</html>

