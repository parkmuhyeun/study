<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/header.jsp"%>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<%-- <script type="text/javascript" src="${JS_URL}h_Validator.js" ></script> --%>
<style>
th, td {
	padding: 3px 10px;
}

.off-screen {
	display: none;
}

#nav {
	width: 500px;
	text-align: center;
}

#nav a {
	display: inline-block;
	padding: 3px 5px;
	margin-right: 10px;
	font-family: Tahoma;
	background: #ccc;
	color: #000;
	text-decoration: none;
}

#nav a.active {
	background: #333;
	color: #fff;
}
</style>
<script>
$(document).ready(function(){
	$("#reg_teacher_view").on("click",function(){//선생님 등록 페이지 이동
		if($(this).hasClass("active")){
			$(this).removeClass("active");
			$("#frm_reg").hide();
		}else{
			$(this).addClass("active");
			$("#frm_reg").show();
		}
	});

	$("#btn_reg").on("click",function(){
		
		var frm = $("#frm_reg");
		var pass = 0;
		
		if($("#id").val().trim() != '') pass+=1;
		if($("#pw").val().trim() != '') pass+=1;
		if($("#name").val().trim() != '') pass+=1;
		if($("#level").val().trim() != '') pass+=1;
		
		if(pass >=4){
			frm.submit();
		}else{
			swal("Not Completed!", "모든 항목을 다 입력해주세요!", "warning");
			return;
		}
		
	});
	
	
	$(".mod_teacher").on("click",function(){
		
		if(!$(this).hasClass("active")){
			
			var idx = $(".mod_teacher").index($(this));
			
			$(".tr_teacher").eq(idx).children(".target").children(".info").hide();
			$(".tr_teacher").eq(idx).children(".target").children(".input").show();
			
			$(".tr_teacher").eq(idx).find("input").removeAttr("disabled");
			$(".tr_teacher").eq(idx).find("select").removeAttr("disabled");
			
			$(".hid").show();
			$(this).text("저장").addClass("active");
			
		}else{
			
			var frm = $("#frm_mod");
			
			frm.submit();
		}
		
	});
	
})

</script>
</head>

<body>
	<div class="w3-content" style="max-width: 2000px; margin-top: 46px">
		<div class="page-header">
			<h1>선생님 관리</h1>
		</div>

		<form action="" id="setRows">
			<input type="text" name="rowPerPage" value="10" class="hide">
			<!-- 한 페이지에 10개씩 -->
		</form>

		<form name="frm_mod" id="frm_mod" action="/mod_teacher" method="post">
			<table class="table table-hover" id="products">
				<thead>
					<tr>
						<th>선생님 코드</th>
						<th>선생님 아이디</th>
						<th class="hid" style="display: none">선생님 비밀번호</th>
						<th>선생님 이름</th>
						<th>권한</th>
						<th>삭제여부</th>
						<th>등록일시</th>
						<th>수정일시</th>
						<th>수정하기</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${tList}" varStatus="s" var="vo">
						<tr class="tr_teacher ${vo.v_flag_del eq 'Y' ? 'del' : ''}">
							<td>${vo.v_tcd }<input class="input w3-input" type="hidden"
								name="v_tcd" value="${vo.v_tcd}" disabled></td>

							<td class="target">
								<p class="info">${vo.v_tid}</p> <input type="text" name="v_tid"
								class="input w3-input" value="${vo.v_tid}" size="15"
								style="display: none" disabled>
							</td>


							<td class="target hid" style="display: none">
								<p class="info">${vo.v_tpassword}</p> <input type="text"
								name="v_tpassword" class="input w3-input"
								value="${vo.v_tpassword}" size="15" style="display: none"
								disabled>
							</td>


							<td class="target">
								<p class="info">${vo.v_tname}</p> <input type="text"
								name="v_tname" class="input w3-input" value="${vo.v_tname}"
								size="10" style="display: none" disabled>
							</td>



							<td class="target">
								<p class="info">${vo.v_tlevel}</p> <select name="t_lv"
								class="input w3-input" style="display: none" disabled>
									<option value="1" ${vo.v_tlevel eq '1' ? 'selected' : ''}>관리자</option>
									<option value="2" ${vo.v_tlevel eq '2' ? 'selected' : ''}>일반</option>
							</select>
							<td class="target">
								<p class="info">${vo.v_flag_del}</p> <select name="t_flag_del"
								class="input w3-input" style="display: none" disabled>
									<option value="Y" ${vo.v_flag_del eq 'Y' ? 'selected' : ''}>Y</option>
									<option value="N" ${vo.v_flag_del eq 'N' ? 'selected' : ''}>N</option>
							</select>
							</td>

							<td>${vo.v_reg_dtm }</td>
							<td>${vo.v_mod_dtm }</td>
							<td><a href="javascript:"
								class="mod_teacher btn btn-default btn-sm" id="${vo.v_tid }">수정하기</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
		<a href="javascript:" class="btn btn-default btn-sm"
			id="reg_teacher_view">선생님 등록</a>

		<form name="frm_reg" id="frm_reg" action="/reg_teacher" method="post"
			style="display: none">

			<table class="table table-hover">
				<thead>
					<tr>
						<th>ID</th>
						<th>PW</th>
						<th>이름</th>
						<th>권한</th>
						<th>등록</th>
					</tr>
				</thead>
				<tbody>
					<tr>

						<td><input type="text" name="id" class="_target w3-input"
							id="id" size="7" /></td>
						<td><input type="text" name="pw" class="_target w3-input"
							id="pw" size="7" /></td>
						<td><input type="text" name="name" class="_target w3-input"
							id="name" size="7" /></td>
						<td><select name="level" id="level" class="w3-input">
								<option value="1">관리자</option>
								<option value="2">일반</option>
						</select></td>
						<td><a href="javascript:" class="btn btn-default btn-sm"
							id="btn_reg">제출</a></td>
					</tr>
				</tbody>
			</table>
		</form>

	</div>

</body>
</html>

