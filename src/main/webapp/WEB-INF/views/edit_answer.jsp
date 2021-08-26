<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/header.jsp"%>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" async
	src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-MML-AM_CHTML">
	
</script>
<script>
	$(document)
			.ready(
					function() {

						function makeSelect() {
							var unitCnt = $("#unitCnt").val();
							var appdHtml = [];
							for (var i = 1; i < +unitCnt + 1; i++) {
								appdHtml.push("<option value="+i+"> " + i
										+ "</option>");
							}
							$("#v_unit").append(appdHtml.join(""));
						}
						makeSelect();

						$("#mkInputs")
								.on(
										"click",
										function() {

											$("#saveAns").show();

											var unit = $("#v_unit").val();

											var qCnt1 = $("#v_q_cnt1").val();

											var qCnt2 = $("#v_q_cnt2").val();

											var appdHtml2 = [];

											for (qCnt1; qCnt1 < +qCnt2 + 1; qCnt1++) {
												appdHtml2
														.push("<div class='w3-col l3 m6 w3-margin-bottom'>");
												appdHtml2
														.push("	<div class='w3-display-container' >");
												appdHtml2.push("		<label> "
														+ unit + "단원의 " + qCnt1
														+ "번 문제</label>");
												appdHtml2
														.push("		<textarea class='form-control v_answer' id='answer_"+qCnt1+"' rows='5' name='v_answer'></textarea>");

												//appdHtml2.push("		<legend>미리보기<div id='preview'>\({}\)</div></legend>");

												appdHtml2
														.push("		<input type='hidden' name='v_unit' value="+unit+">");
												appdHtml2
														.push("		<input type='hidden' name='v_num' value="+qCnt1+">");
												appdHtml2.push("	</div>");
												appdHtml2.push("</div>");
											}
											$("#input-area").append(
													appdHtml2.join(""));

											$(".v_answer").on(
													"focus",
													function() {
														$("#nowAnsNum").val(
																$(this).attr(
																		"id"));
													});

											$("#preview")
													.on(
															"click",
															function(e) {
																var id = $(
																		"#nowAnsNum")
																		.val();
																var answer = $(
																		"#"
																				+ id)
																		.val();
																console
																		.log("answer : "
																				+ answer);

																var math = MathJax.Hub
																		.getAllJax("preview")[0];
																MathJax.Hub
																		.Queue([
																				"Text",
																				math,
																				answer ]);
															});

										});

						$(".v_answer").on("focus", function() {
							alert("ㅇㅇㅇ");
							$(this).addClass("active");
						});

						$("#saveAns").on("click", function() {
							var frm = $("#frm_upload");

							swal("Sucess!", "저장완료!", "success");
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

.v_answer {
	max-height: 300px;
	resize: vertical;
}

#preview {
	border-color: rgb(255, 204, 255);
	border-style: solid;
	cursor: help;
	height: 100px;
	width: 200px;
}

.w3-display-container {
	border-style: dashed;
	padding: 10px;
}

.table {
	width: 60%;
}
</style>
</head>

<body>

	<input type="hidden" name="unitCnt" id="unitCnt" value="${unitCnt}">
	<input type="hidden" name="nowAnsNum" id="nowAnsNum" value="">
	<div class="w3-content" style="max-width: 2000px; margin-top: 46px">

		<div class="page-header">
			<h1>답안 편집</h1>
		</div>

		<table class="table table-hover">
			<thead>
				<tr>
					<th>책 이름</th>
					<th>책 코드</th>
					<th>공유여부</th>
					<th>단원 수</th>
					<th>등록 일시</th>
					<th>preview</th>
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
						<td><div id="preview">\({}\)</div></td>
					</tr>
				</c:forEach>

			</tbody>
		</table>

		단원별 문제 생성

		<p>
			단원 : <select name="v_unit" id="v_unit">
			</select>
			<!-- 문제수 : <input type="text"	name="v_q_cnt"	id="v_q_cnt"/>
	
	<button id="mkInputs">생성</button> -->

			문제범위 지정 : <input type="text" name="v_q_cnt1" id="v_q_cnt1" /> ~ <input
				type="text" name="v_q_cnt2" id="v_q_cnt2" />
	
			<button id="mkInputs">생성</button>

		</p>


		<form name="frm_upload" id="frm_upload" action="/reg_question"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="v_bcd" value="${v_bcd}"> <input
				type="hidden" name="v_unit_cnt" value="${unitCnt}">
			<div class="w3-row-padding" id="input-area"></div>
		</form>
		<button id="saveAns" style="display: none">저장</button>


	</div>

</body>
</html>

