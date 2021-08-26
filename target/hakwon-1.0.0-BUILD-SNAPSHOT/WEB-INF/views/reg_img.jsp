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

	function test(){
		var fileValue = $(".fileinput").val().split("\\");
		var fileName = fileValue[fileValue.length-1]; // 파일명
		console.log( fileName.split("_")[0] );
		
		$("#bcd").val(fileName.split("_")[0]);
	
	}

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
	
	function fnFileUpload(param){
		var frm = $("#frm_upload");
		var bcd = $("input[name='bcd']").val();
		frm.attr("action", "/comm_image_fileupload2?&bookCd="+bcd);
		frm.submit();
	}
	
	$(".btn_fileupload").click(function(){
		
		if($("input[name='manyfiles']").val() == ""){
			alert("업로드할 파일을 선택해주세요");
			return;
		}
		
		fnFileUpload($(this).attr("id"));
	});


	$("#btn_del").on("click",function(){
		
		if($("input[name='arr_del']:checked").length == 0){
			alert("삭제할 파일을 선택해주세요");
			return;
		}
		$("#frm_delete").submit();
	});

	$("#selectBook").on("click",function(){//답안 편집
		var param = $("#v_bcd").val();
		location.href = "/reg_img?bookCd="+param;
	});
	
})

</script>
<style>
.width_50 {
	width: 50%
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

.short {
	display: inline;
	width: 200px;
}

.moveBook {
	float: right;
}
</style>
</head>

<body>
	<input type="hidden" name="unitCnt" id="unitCnt" value="${unitCnt}">

	<div class="w3-content" style="max-width: 2000px; margin-top: 46px">

		<div class="page-header">
			<h1>문제 이미지 등록/편집</h1>
		</div>

		<div class="panel panel-default width_50">
			<div class="panel-heading">문제이미지 등록/편집</div>
			<div class="panel-body">

				<form name="frm_upload" id="frm_upload" action="" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="bcd" id="bcd" value=""> <input
						multiple="multiple" type="file" name="manyfiles" class="fileinput"
						onchange="test();" style="display: inline" /> <a
						href="javascript:;" class="btn_fileupload btn btn-default btn-sm"
						id="${bcd}">업로드하기</a> <a href=javascript: id="btn_del"
						class="btn btn-default btn-sm">삭제하기</a> <span class="moveBook">
						<select name="v_bcd" id="v_bcd" class="input w3-input short">
							<option value="">선택</option>
							<c:forEach items="${bookList}" varStatus="s" var="voo">
								<option value="${voo.v_bcd }">${voo.v_bname }</option>
							</c:forEach>
					</select> <a href="javascript:;" class="btn btn-default btn-sm"
						id="selectBook">이 책으로 이동</a>
					</span>
				</form>

			</div>
		</div>

		<form name="frm_delete" id="frm_delete" action="/delete_file"
			method="post" enctype="multipart/form-data">
			<c:forEach items="${srcList}" varStatus="s" var="vo">
				<div class="col-sm-2" style="margin-bottom: 2%; width: 20%;">
					<div class="w3-card-2" style="width: 100%">
						<input type="checkbox" name="arr_del" value="${vo}"> <img
							src="${vo }" alt="Person" style="width: 100%">
						<div class="w3-container">
							<h5>
								<b>File : ${fn:split(vo, "UPLOAD")[1]}</b>
							</h5>
						</div>
					</div>
				</div>
			</c:forEach>

		</form>
	</div>

</body>
</html>