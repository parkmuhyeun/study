<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/header.jsp"%>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<%-- <script type="text/javascript" src="${JS_URL}h_Validator.js" ></script> --%>

<script>
$(document).ready(function(){
//_validate("click","submit");
	function fnFileUpload(param){
			var frm = $("#frm_upload");
			var loc = $("input[name='v_loc']").val();
			frm.attr("action", "/comm_image_fileupload?&fType=a&v_loc="+loc+"&bcd="+param);
			frm.submit();
	}
	$(".btn_fileupload").click(function(){
		
		if($("input[name='manyfiles']").val() == ""){
			alert("업로드할 파일을 선택해주세요");
			return;
		}
		
		fnFileUpload($(this).attr("id"));
	})
	
	
	$("#btn_del").on("click",function(){
		
		if($("input[name='arr_del']:checked").length == 0){
			alert("삭제할 파일을 선택해주세요");
			return;
		}
		$("#frm_delete").submit();
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

.page-header {
	margin: 60px 0 20px;
}
</style>
</head>

<body>
	<div class="w3-content" style="max-width: 2000px; margin-top: 46px">

		<div class="page-header">
			<h1>해답 편집 - ${bcd }</h1>
		</div>


		<div class="panel panel-default width_30">
			<div class="panel-heading">해답 편집</div>
			<div class="panel-body">

				<form name="frm_upload" id="frm_upload" action="" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="v_loc" id="v_loc" value="${v_loc}">
					<input type="hidden" name="bcd" id="bcd" value="${bcd}"> <input
						multiple="multiple" type="file" name="manyfiles" class="fileinput"
						style="display: inline" /> <a href="javascript:;"
						class="btn_fileupload btn btn-default btn-sm" id="${bcd}">업로드하기</a>
					<a href=javascript: id="btn_del" class="btn btn-default btn-sm">삭제하기</a>
				</form>
			</div>
		</div>

		<form name="frm_delete" id="frm_delete" action="/delete_file?fType=a"
			method="post" enctype="multipart/form-data">
			<c:forEach items="${srcList}" varStatus="s" var="vo">
				<div class="col-sm-2" style="margin-bottom: 2%; width: 10%;">
					<div class="w3-card-2" style="width: 100%">
						<input type="checkbox" name="arr_del" value="${vo}"> <img
							src="${vo }" alt="Person" style="width: 100%">
						<div class="w3-container">
							<h5>
								<b>File : ${fn:substring(vo,		fn:indexOf(vo, '.png')-4,		fn:indexOf(vo, '.png'))}</b>
							</h5>
						</div>
					</div>
				</div>
			</c:forEach>

		</form>



	</div>

</body>
</html>

