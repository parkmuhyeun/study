<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<%-- <script type="text/javascript" src="${JS_URL}h_Validator.js" ></script> --%>

<script>
$(document).ready(function(){
	$("#reg_teacher_view").on("click",function(){//선생님 등록 페이지 이동
		location.href = '/reg_teacher_view';
	});
	
	$("#submit").on("click",function(){//선생님 수정팝업
		
		$.ajax({
			  url : '/mod_teacher'
			, type : "post"
			, cache: false
			, headers: {"cache-control":"no-cache", "pragma": "no-cache"}
			, data : $("#frm_mod").serialize()
			, success : function(data){
				alert("수정완료!");
				self.close();
				opener.location.reload();
			}
			, error : function(data){
				alert('error');
			}
		})
		
	});
})

</script>
</head>

<body>

	선생님 수정

	<form name="frm_mod" id="frm_mod" action="/mod_teacher" method="post">
		TCD : <input type="text" name="t_cd" value="${tInfo.v_tcd }" readonly />
		TID : <input type="text" name="t_id" value="${tInfo.v_tid }" readonly />
		TPW : <input type="text" name="t_pw" value="${tInfo.v_tpassword }" />
		TNAME: <input type="text" name="t_name" value="${tInfo.v_tname }" />

		TLV : <select name="t_lv">
			<option value="1" ${tInfo.v_tlevel eq 1 ? 'selected' : ''}>관리자</option>
			<option value="2" ${tInfo.v_tlevel eq 2 ? 'selected' : ''}>일반</option>
		</select> DEL : <select name="t_flag_del">
			<option value="Y" ${tInfo.v_flag_del eq 'Y' ? 'selected' : ''}>Y</option>
			<option value="N" ${tInfo.v_flag_del eq 'N' ? 'selected' : ''}>N</option>
		</select> REG_DTM : <input type="text" name="t_flag_del"
			value="${tInfo.v_reg_dtm }" readonly /> MOD_DTM : <input type="text"
			name="t_flag_del" value="${tInfo.v_mod_dtm }" readonly /> <a
			href="javascript:" id="submit">제출</a>
	</form>



</body>
</html>

