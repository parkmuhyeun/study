<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/header.jsp"%>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>
$(document).ready(function(){
	
	function makeSelect(){
		var unitCnt = $("#unitCnt").val();
		var appdHtml = [];
		for( var i=1; i< +unitCnt+1; i++ ){
			appdHtml.push("<option value="+i+"> "+i+"</option>");
		}
		$("#v_unit").append(appdHtml.join(""));
	}
	makeSelect();
	
	
	$("#mkInputs").on("click",function(){
		var unit = $("#v_unit").val();
		var qCnt = $("#v_q_cnt").val();
		var appdHtml2 = [];
		
		for( var i=1; i< +qCnt+1; i++ ){
			appdHtml2.push("<div class='w3-col l3 m6 w3-margin-bottom'>");
			appdHtml2.push("	<div class='w3-display-container'>");
			appdHtml2.push("		<label> "+unit+"단원의 "+i+"번 문제</label>");
			appdHtml2.push("		<textarea class='form-control' rows='5' name='v_answer'></textarea>");
			appdHtml2.push("		<input type='hidden' name='v_unit' value="+unit+">");
			appdHtml2.push("		<input type='hidden' name='v_num' value="+i+">");
			appdHtml2.push("	</div>");
			appdHtml2.push("</div>");
		}
		$("#input-area").append(appdHtml2.join(""));
	});
	
	$("#saveAns").on("click",function(){
		var frm = $("#frm_upload");
		frm.submit();
	});
	
})

</script>
<style>
.width_30 {
	width: 29%
}

.fileinput {
	display: inline;
	border: 1px solid black;
	padding: 5px 5px;
}

.btn_fileupload {
	margin-left: 10px;
	margin-right: 10px
}

textarea {
	border-color: rgb(255, 204, 255);
	border-style: solid;
}
</style>
</head>

<body>
	<input type="hidden" name="unitCnt" id="unitCnt" value="${unitCnt}">

	<div class="w3-content" style="max-width: 2000px; margin-top: 46px">

		<div class="page-header">
			<h1>답안 등록</h1>
		</div>



		<table class="table table-hover">
			<thead>
				<tr>
					<th>책 이름</th>
					<th>책 코드</th>
					<th>공유여부</th>
					<th>단원 수</th>
					<th>등록 일시</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${bookList}" varStatus="s" var="vo">
					<tr>
						<td>${vo.v_bname }</td>
						<td>${vo.v_bcd }</td>
						<td>${vo.v_share eq 'S' ? 'Y' : 'N'}</td>
						<td>${vo.v_unit_cnt }
						<td>${vo.v_reg_dtm }</td>

					</tr>
				</c:forEach>

			</tbody>
		</table>

		단원별 문제 생성

		<p>
			단원 : <select name="v_unit" id="v_unit">
			</select> 문제수 : <input type="text" name="v_q_cnt" id="v_q_cnt" />

			<button id="mkInputs">생성</button>
		</p>


		<form name="frm_upload" id="frm_upload" action="/reg_question"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="v_bcd" value="${v_bcd}">
			<div class="w3-row-padding" id="input-area"></div>
		</form>
		<button id="saveAns">저장</button>


	</div>

</body>
</html>

