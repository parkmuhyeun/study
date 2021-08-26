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

input:read-only {
	text-decoration-line: line-through;
}

.del {
	text-decoration-line: line-through;
}
</style>
<script>
$(document).ready(function(){
	$("#reg_class").on("click",function(){//학급 등록영역 노출
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
		
		if($("#v_cname").val().trim() != '') pass+=1;
		if($("#v_tcd").val().trim() != '') pass+=1;
		if($("#v_tname").val().trim() != '') pass+=1;
		
		if(pass >=3){
			frm.submit();
		}else{
			swal("Not Completed!", "모든 항목을 다 입력해주세요!", "warning");
			return;
		}
		
	});
	
	$("#v_tcd").on("change",function(){//선생님 코드 히든으로 세팅
		$("#v_tname").val($("#v_tcd option:selected").text());
	});
	
	$(".mod_class").on("click",function(){
		
		if(!$(this).hasClass("active")){
			
			var idx = $(".mod_class").index($(this));
			$(".tr_class").eq(idx).children(".target").children(".info").hide();
			$(".tr_class").eq(idx).children(".target").children(".input").show();
			
			$(".tr_class").eq(idx).find("input").removeAttr("disabled");
			$(".tr_class").eq(idx).find("select").removeAttr("disabled");
			
			$("input[name='v_tname']:visible").attr("readonly","readonly");
			$(".tr_class").eq(idx).children(".target").children("input[name='v_tcd']").replaceWith($("#v_tcd")["0"].outerHTML);
			
				$("#v_tcd").on("change",function(){//선생님 코드 히든으로 세팅
					$("input[name='v_tname']:visible").val($("#v_tcd option:selected").text());
				});
			
			
			$(".hid").show();
			$(this).text("저장").addClass("active");
			
			$(".changable").text("기존 선생님");
			$(".changable").next("th").text("새로운 선생님");
			
		}else{
			
			if($("#v_tcd option:selected").val() == ''){
				alert("선생님을 정해주세요!");
				return;
			}
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
			<h1>학급 관리</h1>
		</div>

		<form action="" id="setRows">
			<input type="text" name="rowPerPage" value="10" class="hide">
			<!-- 한 페이지에 10개씩 -->
		</form>

		<form name="frm_mod" id="frm_mod" action="/mod_class" method="post">
			<table class="table table-hover" id="products">
				<thead>
					<tr>
						<th>학급 코드</th>
						<th>학급 이름</th>
						<th class="changable">담당선생님 이름</th>
						<th>담당선생님 코드</th>
						<th>삭제여부</th>
						<th>등록일시</th>
						<th>수정하기</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${cList}" varStatus="s" var="vo">
						<tr class="tr_class ${vo.v_flag_del eq 'Y' ? 'del' : ''}">
							<td>${vo.v_ccd }<input class="input w3-input" type="hidden"
								name="v_ccd" value="${vo.v_ccd}" disabled></td>

							<td class="target">
								<p class="info">${vo.v_cname}</p> <input type="text"
								name="v_cname" class="input w3-input" value="${vo.v_cname}"
								size="15" style="display: none" disabled>
							</td>

							<td class="target">
								<p class="info">${vo.v_tname}</p> <input type="text"
								name="v_tname" class="input w3-input" value="${vo.v_tname}"
								size="10" style="display: none" disabled> <%-- <input type="hidden" name="v_tname" class="input w3-input" value="${vo.v_tname}" size="10" style="display:none" disabled> --%>
							</td>

							<td class="target">
								<p class="info">${vo.v_tcd}</p> <input type="text" name="v_tcd"
								class="input w3-input" value="${vo.v_tcd}" size="10"
								style="display: none" disabled>
							</td>

							<td class="target">
								<p class="info">${vo.v_flag_del}</p> <select name="v_flag_del"
								class="input w3-input" style="display: none" disabled>
									<option value="Y" ${vo.v_flag_del eq 'Y' ? 'selected' : ''}>Y</option>
									<option value="N" ${vo.v_flag_del eq 'N' ? 'selected' : ''}>N</option>
							</select>
							</td>

							<td>${vo.v_reg_dtm }</td>
							<td><a href="javascript:"
								class="mod_class btn btn-default btn-sm" id="${vo.v_ccd }">수정하기</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
		<a href="javascript:" class="btn btn-default btn-sm" id="reg_class">학급
			등록</a>

		<form name="frm_reg" id="frm_reg" action="/reg_class" method="post"
			style="display: none">
			<input type="hidden" name="v_tname" class="_target w3-input"
				id="v_tname" size="7" />
			<table class="table table-hover">
				<thead>
					<tr>
						<th>학급이름</th>
						<th>선생님 이름</th>
						<th>등록</th>
					</tr>
				</thead>
				<tbody>
					<tr>

						<td><input type="text" name="v_cname"
							class="_target w3-input" id="v_cname" size="7" /></td>
						<td><select name="v_tcd" id="v_tcd" class="w3-input">
								<option value="">선택</option>
								<c:forEach items="${tList}" varStatus="s" var="voo">
									<option value="${voo.v_tcd }">${voo.v_tname }</option>
								</c:forEach>
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

