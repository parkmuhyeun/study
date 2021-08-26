<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/header.jsp"%>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>
$(document).ready(function(){
	
	$(".mod_book").on("click",function(){
		location.href = '/mng_question?v_bcd='+$(this).attr("id").split(",")[0]+'&v_unit_cnt='+$(this).attr("id").split(",")[1];
	});
	
	$(".mod_ans").on("click",function(){
		location.href = '/mng_answer?v_loc='+$(this).attr("id").split(",")[0]+'&bcd='+$(this).attr("id").split(",")[2];
	});
	
	$(".print_book").on("click",function(){
		location.href = '/question_list';
	});
	
	$("#btn_reg").on("click",function(){
		
		var frm = $("#frm_reg");
		var pass = 0;
		
		if($("#bcd").val().trim() != '') pass+=1;
		if($("#bname").val().trim() != '') pass+=1;
		
		if(pass >=2){
			frm.submit();
		}else{
			swal("Not Completed!", "모든 항목을 다 입력해주세요!", "warning");
			return;
		}
		
	});
})

</script>
</head>

<body>
	<div class="w3-content" style="max-width: 2000px; margin-top: 46px">
		<div class="page-header">
			<h1>문제 관리</h1>
		</div>

		<table class="table table-hover">
			<thead>
				<tr>
					<th>책 이름</th>
					<th>책 코드</th>
					<th>공유여부</th>
					<th>단원 수</th>
					<th>등록 일시</th>
					<c:if
						test="${!empty sessionScope.s_tlv && sessionScope.s_tlv eq '1'}">
						<th>문제 편집</th>
					</c:if>
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

						<!-- 관리자만 접근 -->
						<c:if
							test="${!empty sessionScope.s_tlv && sessionScope.s_tlv eq '1'}">
							<td><a href="javascript:" class="mod_book"
								id="${vo.v_bcd},${vo.v_unit_cnt }">문제 편집하기</a></td>
						</c:if>



					</tr>
				</c:forEach>
			</tbody>
		</table>

		<a href="javascript:" class="print_book btn btn-default btn-sm">출력하기</a>

		<!-- 관리자만 접근 -->
		<c:if test="${!empty sessionScope.s_tlv && sessionScope.s_tlv eq '1'}">
			<form name="frm_reg" id="frm_reg" action="/reg_book" method="post">
				<h2>책 등록하기</h2>
				공유여부 : <select name="b_shareYn" id="b_shareYn">
					<option value="${sessionScope.s_tcd}">N</option>
					<option value="S">Y</option>
				</select> 책 코드 : <input type="text" name="b_cd" class="_target" id="bcd" /> 책
				이름 : <input type="text" name="b_name" class="_target" id="bname" />
				단원 수 : <input type="text" name="b_unit" class="_target" id="bunit" />
				<a href="javascript:" class="btn btn-default btn-sm" id="btn_reg">제출</a>
			</form>
		</c:if>
	</div>
</body>
</html>

