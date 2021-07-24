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
	
	
	//등록 영역 노출
	$("#reg_stdt").on("click",function(){
		
		if($(this).hasClass("active")){
			$(this).removeClass("active");
			$("#frm_reg").hide();
		}else{
			$(this).addClass("active");
			$("#frm_reg").show();
		}
		
	});

	
	$(".mod_stdt").on("click",function(){//수정버튼 클릭시
		
		if(!$(this).hasClass("active")){
			
			var idx = $(".mod_stdt").index($(this));
			
			$(".tr_stdt").eq(idx).children(".target").children(".info").hide();
			$(".tr_stdt").eq(idx).children(".target").children(".input").show();
			$(".tr_stdt").eq(idx).find("input").removeAttr("disabled");
			$(".tr_stdt").eq(idx).find("select").removeAttr("disabled");
			
			$(this).text("저장").addClass("active");
			
			$(".tr_stdt").eq(idx).children(".target").filter("#mod_teacher").replaceWith($("#copy1")["0"].outerHTML);
				
				$("#v_tcd_reg").on("change",function(){
					$.ajax({
						  url : '/class_list_ajax'
						, type : "post"
						, cache: false
						, headers: {"cache-control":"no-cache", "pragma": "no-cache"}
						, data : { v_tcd : $("select[name='v_tcd'] option:selected").val()}
						, success : function(data){
							
							var selected = $("#v_tcd_reg option:selected").text();
							$("#v_tname_reg").val(selected);
							
							$(".mod_class").eq(idx).html(data);
							
							
						}
						, error : function(data){
							alert('error');
						}
					});
				});
		}else{
			var frm = $("#frm_mod");
			frm.submit();
		}
		
	});
	
	
	$("#btn_reg").on("click",function(){//등록 제출
		
		var frm = $("#frm_reg");
		var pass = 0;
		
		if($("#v_sname_reg").val().trim() != '') pass+=1;
		if($("#v_sschool_reg").val().trim() != '') pass+=1;
		if($("#v_sgrade_reg").val().trim() != '') pass+=1;
		if($("#v_scontact_reg").val().trim() != '') pass+=1;
		if($("#v_tcd_reg").val().trim() != '') pass+=1;
		
		if($("#v_tname_reg").val().trim() != '') pass+=1;
		if($("#v_ccd_reg").val().trim() != '') pass+=1;
		if($("#v_cname_reg").val().trim() != '') pass+=1;
		
		if(pass >=5){
			frm.submit();
		}else{
			alert("모든 항목을 다 입력해주세요.");
			return;
		}
	});

		$("#v_tcd_reg").on("change",function(){
			$.ajax({
				  url : '/class_list_ajax'
				, type : "post"
				, cache: false
				, headers: {"cache-control":"no-cache", "pragma": "no-cache"}
				, data : { v_tcd : $("select[name='v_tcd'] option:selected").val()}
				, success : function(data){
					
					var selected = $("#v_tcd_reg option:selected").text();
					$("#v_tname_reg").val(selected);
					
					$(".ajax_here").html(data);
					
					
				}
				, error : function(data){
					alert('error');
				}
			});
		});
	
	/* $("#v_ccd_reg").on("change",function(){
		$("#v_cname_reg").val($("#v_ccd_reg option:selected").text());
	}); */
	
});


$(document).ajaxStop(function(){
	$(".v_ccd_reg").on("change",function(){
		var selected = $(".v_ccd_reg:visible option:selected").text();
		$(".v_cname_reg").val(selected);
	});
	
	/* $(".v_tcd:visible").on("change",function(){
		var selected = $(".v_tcd:visible option:selected").text();
		$(".v_tname").val(selected);
	}) */
	
	
});
</script>
</head>

<body>
	<div class="w3-content" style="max-width: 2000px; margin-top: 46px">

		<div class="page-header">
			<h1>학생 관리</h1>
		</div>

		<form action="" id="setRows">
			<input type="text" name="rowPerPage" value="10" class="hide">
			<!-- 한 페이지에 10개씩 -->
		</form>

		<form name="frm_mod" id="frm_mod" action="/mod_stdt" method="post">
			<table class="table table-hover" id="products">
				<thead>
					<tr class="tr">
						<th>학생 코드</th>
						<th>학생 이름</th>
						<th>담당선생님</th>
						<th>학급</th>
						<th>학교</th>
						<th>학년</th>
						<th>연락처</th>
						<th>삭제여부</th>
						<th>등록일시</th>
						<th>수정일시</th>
						<th>수정</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${sList}" varStatus="s" var="vo">
						<tr class="tr_stdt ${vo.v_flag_del eq 'Y' ? 'del' : ''}">

							<td>${vo.v_scd}<input class="input w3-input" type="hidden"
								name="v_scd" value="${vo.v_scd}" disabled></td>

							<td class="target">
								<p class="info">${vo.v_sname}</p> <input type="text"
								name="v_sname" class="input w3-input" value="${vo.v_sname}"
								size="7" style="display: none" disabled>
							</td>

							<td class="target" id="mod_teacher">
								<p class="info">${vo.v_tname}</p>

							</td>


							<td class="target mod_class">
								<p class="info">${vo.v_cname}</p>


							</td>

							<td class="target">
								<p class="info">${vo.v_sschool}</p> <input type="text"
								name="v_sschool" class="input w3-input" value="${vo.v_sschool}"
								size="15" style="display: none" disabled>
							</td>

							<td class="target">
								<p class="info">${vo.v_sgrade}</p> <input type="text"
								name="v_sgrade" class="input w3-input" value="${vo.v_sgrade}"
								size="4" style="display: none" disabled>
							</td>

							<td class="target">
								<p class="info">${vo.v_scontact}</p> <input type="text"
								name="v_scontact" class="input w3-input"
								value="${vo.v_scontact}" size="15" style="display: none"
								disabled>
							</td>

							<td class="target">
								<p class="info">${vo.v_flag_del}</p> <select name="v_flag_del"
								class="input form-control" style="display: none" disabled>
									<option value="Y" ${vo.v_flag_del eq 'Y' ? 'selected' : ''}>Y</option>
									<option value="N" ${vo.v_flag_del eq 'N' ? 'selected' : ''}>N</option>
							</select>
							</td>


							<td>${vo.v_reg_dtm}</td>
							<td>${vo.v_mod_dtm}</td>
							<td><a href="javascript:"
								class="mod_stdt btn btn-default btn-sm" id="${vo.v_scd}">수정하기</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>

		<a href="javascript:" class="btn btn-default btn-sm" id="reg_stdt">학생등록</a>

		<form name="frm_reg" id="frm_reg" action="/reg_stdt" method="post"
			style="display: none">


			<table class="table table-hover">
				<thead>
					<tr>
						<th>이름</th>
						<th>학교</th>
						<th>학년</th>
						<th>연락처</th>
						<th>선생님</th>
						<th>학급</th>
						<th>등록</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" name="v_sname"
							class="_target w3-input" id="v_sname_reg" size="7" /></td>
						<td><input type="text" name="v_sschool"
							class="_target w3-input" id="v_sschool_reg" size="14" /></td>
						<td><input type="text" name="v_sgrade"
							class="_target w3-input" id="v_sgrade_reg" size="4" /></td>
						<td><input type="text" name="v_scontact"
							class="_target w3-input" id="v_scontact_reg" size="14" /></td>

						<!-- 관리자 일때만 선생님 선택 노출 -->
						<c:if
							test="${!empty sessionScope.s_tlv && sessionScope.s_tlv eq '1'}">
							<td id="copy1"><select class="form-control v_tcd"
								name="v_tcd" id="v_tcd_reg">
									<option value="">선택</option>
									<c:forEach items="${tList}" varStatus="s" var="vo">
										<option value="${vo.v_tcd}">${vo.v_tname}</option>
									</c:forEach>
							</select> <input type="hidden" name="v_tname" class="_target w3-input"
								class="v_tname_reg" id="v_tname_reg" /></td>

							<td class="ajax_here"></td>
						</c:if>

						<!-- 일반선생님은 본인만 노출되도록 -->
						<c:if
							test="${!empty sessionScope.s_tlv && sessionScope.s_tlv eq '2'}">
							<td id="copy2"><input type="hidden" name="v_tcd" id="v_tcd"
								value="${sessionScope.s_tcd}" /> <input type="text"
								name="v_tname" class="_target w3-input" id="v_tname"
								value="${sessionScope.s_tname}" readonly /></td>

							<td><select name="v_ccd" class="input form-control"
								id="v_ccd_reg">
									<option value="">선택</option>
									<c:forEach items="${cList}" varStatus="s" var="voo">
										<option value="${voo.v_ccd}">${voo.v_cname}</option>
									</c:forEach>
							</select> <input type="hidden" name="v_cname" class="_target w3-input"
								id="v_cname" readonly /></td>
						</c:if>

						<td><a href="javascript:" class="btn btn-default btn-sm"
							id="btn_reg">제출</a></td>
					</tr>
				</tbody>
			</table>
		</form>

	</div>
</body>
</html>

