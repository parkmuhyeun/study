<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<%-- <script type="text/javascript" src="${JS_URL}h_Validator.js" ></script> --%>

<script>
$(document).ready(function(){
//_validate("click","submit");
	function fnFileUpload(){
			var frm = $("#frm_upload");
			frm.attr("action", "http://127.0.0.1:8080/comm_image_fileupload");
			frm.submit();
	}
	$(".btn_fileupload").click(function(){
		alert("dadsfasdfa");
		fnFileUpload();
	})
})

</script>
</head>

<body>
	<form name="frm_upload" id="frm_upload" action="" method="post"
		enctype="multipart/form-data">
		<input type="file" name="i_sFileUpload" id="i_sFileUpload"> <a
			href="javascript:;" class="btn_big btn_fileupload"><strong>업로드</strong></a>

		asas ${reqVo.ddd }
		<%-- ${reqVo.i_sFileId}
		${reqVo.i_sFileIdTemp}
		${reqVo.i_sFilePath}
		${reqVo.i_sFileSize}
		${reqVo.i_sFileRealName}
		${reqVo.i_sFileSaveName}
		<img src="${reqVo.img0}" width="100" height="100"/>
		<img src="${reqVo.img1}"/>
		<img src="${reqVo.img2}"/> --%>
	</form>


	<div>
		&nbsp;id: <input type="text" class="_target" id="id" />
		&nbsp;password:<input type="password" class="_target" id="password" />
		&nbsp;phone:<input type="text" class="_target" id="phone" />
		&nbsp;mobile:<input type="text" class="_target" id="mobile" />
		&nbsp;rrn:<input type="text" class="_target" id="rrn" /> &nbsp;mail:<input
			type="text" class="_target" id="mail" /> &nbsp;nick:<input
			type="text" class="_target" id="nick" /> &nbsp;name:<input
			type="text" class="_target" id="name" />
		<button class="submit" id="submit">제출</button>
	</div>
</body>
</html>

