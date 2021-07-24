<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript" async
	src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

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
	
	function setDate(){
		var date = new Date();
		var dateString = "";
		dateString = date.getFullYear() + " / " + Number( date.getMonth()+1 ) + " / " + date.getDate();
		$(".cover1").find("span:first").text(dateString);
	}
	setDate();
	
	
	
	
	var q_cnt = parseInt($("input[name='q_cnt']").val());
	var show_num = $("input[name='show_num']").val();
	var also_ans = $("input[name='also_ans']").val();
	var s_tcd	 = $("input[name='s_tcd']").val();
	
	
	function loadQuestion( q_cnt ,show_num){
		
		var qCnt = parseInt($("input[name='question']").length);//문제 cnt
		var pageCnt = parseInt(qCnt / q_cnt);
		var plus	= qCnt % q_cnt == 0 ? 0 : 1;//페이지 cnt
		pageCnt = pageCnt+plus;
		$("#pgnum_0 >b").text("1/"+pageCnt);//첫페이지에 페이지 번호 세팅
		
		var appdHtml = [];
		
		
		if(q_cnt == 4){
			for(var i=0; i<pageCnt; i++){
				appdHtml.push("<div class='page_question' id='pgnum_'"+i+"'>");
				appdHtml.push("		<div class='subpage'>");
				appdHtml.push("			<div class='quarter'><image class='qimg' src=''></div>");
				appdHtml.push("			<div class='quarter'><image class='qimg' src=''></div>");
				appdHtml.push("			<div class='quarter'><image class='qimg' src=''></div>");
				appdHtml.push("			<div class='quarter'><image class='qimg' src=''></div>");
				appdHtml.push("		</div>");
				appdHtml.push("			<b class='pg_idx'>-"+parseInt(i+1)+"/"+pageCnt+"-</b>");
				appdHtml.push("</div>");
			}
			$(".q_area").append(appdHtml.join(""));
		
		}else if(q_cnt == 2){
			for(var i=0; i<pageCnt; i++){
				appdHtml.push("<div class='page_question' id='pgnum_'"+i+"'>");
				appdHtml.push("		<div class='subpage'>");
				appdHtml.push("			<div class='half'><image class='qimg' src=''></div>");
				appdHtml.push("			<div class='half'><image class='qimg' src=''></div>");
				appdHtml.push("		</div>");
				appdHtml.push("			<b class='pg_idx'>-"+parseInt(i+1)+"/"+pageCnt+"-</b>");
				appdHtml.push("</div>");
			}
			$(".q_area").append(appdHtml.join(""));
			
		}else{
			for(var i=0; i<pageCnt; i++){
				appdHtml.push("<div class='page_question' id='pgnum_'"+i+"'>");
				appdHtml.push("		<div class='subpage'>");
				appdHtml.push("			<div class='full'><image class='qimg_full' src=''></div>");
				appdHtml.push("		</div>");
				appdHtml.push("			<b class='pg_idx'>-"+parseInt(i+1)+"/"+pageCnt+"-</b>");
				appdHtml.push("</div>");
			}
			$(".q_area").append(appdHtml.join(""));
			
			/* $(".question").each(function(idx){//각 img마다 src세팅해주고
				
				if(show_num == 'Y'){
					console.log("원래 문제 번호보여주기");
					$("<p class='q_nums'><b>"+$(this).val().split("/")[1]+".</b></p>").insertBefore($(".qimg_full").eq(idx));
				}
				
				else if(show_num == 'H'){
					console.log("아예 가리기");
					$("<p class='q_nums'></p>").insertBefore($(".qimg_full").eq(idx));
				}
				
				else {
					console.log("순서상 번호 보여주기");
					$("<p class='q_nums'><b>"+parseInt(idx+1)+"번.</b></p>").insertBefore($(".qimg_full").eq(idx));
				}
			
					$(".qimg_full").eq(idx).attr("src","/resources/UPLOAD/"+$(this).val()+".png");
			}); */
			
			/* $(".qimg[src='']").hide();
			$(".qimg[src='']").parent().hide(); */
		}
		
		
		$(".question").each(function(idx){//각 img마다 src세팅해주고
			
			if(show_num == 'Y'){
				console.log("원래 문제 번호보여주기");
				$("<p class='q_nums'><b>"+$(this).val().split("/")[1]+".</b></p>").insertBefore($(".qimg").eq(idx));
			}
			else if(show_num == 'H'){
				console.log("아예 가리기");
				$("<p class='q_nums'></p>").insertBefore($(".qimg_full").eq(idx));
			}
			else{
				console.log("순서상 번호 보여주기");
				$("<p class='q_nums'><b>"+parseInt(idx+1)+"번.</b></p>").insertBefore($(".qimg").eq(idx));
			}
				$(".qimg").eq(idx).attr("src","/resources/UPLOAD/"+$(this).val()+".png");
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
		
		for(var i=0; i<pageCnt; i++){
			appdHtml.push("<div class='page_answer' id='pgnum_'"+i+"'>");
			appdHtml.push("		<div class='subpage'>\({}\)");
			appdHtml.push("		</div>");
			appdHtml.push("			<b class='pg_idx'>"+parseInt(i+1)+"/"+pageCnt+"</b>");
			appdHtml.push("</div>");
		}
		
		//$(".a_area").append(appdHtml.join(""));
		
		var answers = [];
		
		$(".answer").each(function(idx){//각 div마다 답
			
			answers.push("<p>"+$(this).val()+"</p>");
			
		});
		console.log(answers);
		//$(".page_answer > .subpage").text(answers.join(""));
		
	}
	
	
	loadQuestion(q_cnt,show_num);
	
	if(also_ans == 'Y'){
		loadAnswer();
	}
	
	
	setTimeout(function(){
		//window.print();
	},1500)
	
})

</script>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

/*A4 - 웹뷰 화면 세팅*/
body {
	margin: 0;
	padding: 0;
	font-family: "Nanum Gothic", sans-serif;
}

* {
	box-sizing: border-box;
	-moz-box-sizing: border-box;
}

.page_question {
	width: 21cm;
	min-height: 29.7cm;
	padding: 20mm 18mm 15mm 18mm;
	margin: 0 auto;
	background: #eee;
}

.page_answer {
	width: 21cm;
	min-height: 29.7cm;
	padding: 20mm 18mm 15mm 18mm;
	margin: 0 auto;
	background: #eee;
}

.subpage {
	border: 1px dotted solid;
	background: #fff;
	height: /* 284mm; */ 249mm;
	/* padding: 20mm 18mm 15mm 18mm; */
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
		padding: 20mm 18mm 15mm 18mm;
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
.quarter {
	width: 50%;
	height: 48.5%;
	float: left;
	/* border:1px dotted black */
	/* border-bottom: 0.5px dotted black; */
}

.quarter:nth-child(2n+0) {border-left:1px dotted;}


.half {
	width: 50%;
	height: 98%;
	float: left;
	/* border:1px dotted black */
	/* border-bottom: 0.5px dotted black; */
}

.half:nth-child(2n+0) {border-left:1px dotted;}

.full {
	width: 100%;
	height: 98%;
	float: left;
	/* border:1px dotted black */
	/* border-bottom: 0.5px dotted black; */
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
	margin-top: -23px;
	margin-left: 317px;
}

img {
	width: 320px;
	height: 407px;
	margin-left: 1px;
	margin-right: 1px;
}

.qimg_full{
	width: 500px;
    height: 650px;
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

.cover1 {
	position: absolute;
    top: 7%;
    font-size: 25px;
    border: 1px solid;
    margin: 12px;
    padding: 10px;
    width: 632px;
    text-align: center;
}

.cover1 > span:nth-child(1){
    float: left;
    font-size: 20px;
}

.cover1 > span:nth-child(2){
    float: right;
    font-size: 20px;
}

.cover2 {
	position: absolute;
	top: 31%;
	font-size: 45px;
	/* border-style: double; */
	margin: 20px;
	padding: 20px;
	width: 610px;
	text-align: center;
}

.subtitle {
	float: right;
    position: relative;
    top: 63%;
    right: 25%;
}

th, td {
	text-align: center;
	padding: 8px;
	border:1px solid;
	font-size:22px;
}

.showing {
	float: left;
	min-width: 50px;
	max-width: 600px;
	min-height: 50px;
	max-height: 500px;
	padding: 5px 10px 5px 10px;
}

.bgimg {
	position: relative;
    bottom: 45px;
    top: 767px;
    left: 209px;
    width: 200px;
    height: 66px;
}

.bgimg > img{
	width: 150px;
    height: 54px;
    margin-left: 35px;
}
.bgimg > span:nth-child(1){
	font-size:18px;
	margin-left:18px;
}
.bgimg > span:nth-child(5){
	font-size:25px;
	margin-left:52px;
}

.q_nums {
	margin: 3px 10px 2px;
}
</style>
</head>

<body>
	<c:forEach items="${queList}" var="vo" varStatus="s">
		<input type="hidden" name="question" class="question"
			id="question_${s.count}" value="${vo.V_FILE_PATH}">
	</c:forEach>

	<c:forEach items="${queList}" var="vo" varStatus="s">
		<input type="hidden" name="answer" class="answer"
			id="answer_${s.count}" value="${vo.V_ANSWER}">
	</c:forEach>
	
	<c:set value="${s_info}" var="s_info"/>

	<input type="hidden" name="q_cnt" id="q_cnt" value="${q_cnt}">
	<input type="hidden" name="show_num" id="pg_num" value="${show_num}">
	<input type="hidden" name="also_ans" id="q_cnt_pg" value="${also_ans}">
	<input type="hidden" name="s_tcd" id="s_tcd"
		value="${sessionScope.s_tcd}">

	<input type="hidden" name="v_tname" id="v_tname" value="${v_tname}">
	<input type="hidden" name="v_cname" id="v_cname" value="${v_cname}">
	<input type="hidden" name="v_sname" id="v_sname" value="${v_sname}">

	<!-- 표지 TYPE-1 -->
	<div class="title_type_1">
		<div class="page_question" id="pgnum_0">
			<div class="subpage">
				<div class="subtitle">
					<table style="width:335px;">
						<tr>
							<th width=60%>${s_info.v_sschool }&nbsp;${s_info.v_sgrade }</th>
							<th width=40%>${v_sname}</th>
						</tr>
					</table>
				</div>
				<div class="cover1">
					<span></span>
					<span>원수학 대치</span>
				</div>
				<div class="cover2"><font>${v_cover1 }</font> <br/> <font>${v_cover2 }</font></div>
				
				<div class="bgimg">
				<span>기본에 충실한 정법수학</span><br>
				<img src="/resources/images/logo.jpg">
				<br><span>563-8852</span>
				</div>
			</div>

		</div>
	</div>
	</div>


	<!-- 문제영역 -->
	<div class="q_area"></div>


	<!-- 답안영역 -->
	<div class="a_area">
		<div class='page_answer'>
			<div class='subpage'>
				<c:forEach items="${queList}" var="vo" varStatus="s">
					<span class="showing">${s.count}번 : <b>\({${vo.V_ANSWER }}\)</b></span>
				</c:forEach>
			</div>
		</div>
	</div>


</body>
</html>

