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
		location.href = '/edit_answer?v_bcd='+$(this).attr("id").split(",")[0]+'&v_unit_cnt='+$(this).attr("id").split(",")[1];
	});
	
	$(".view_answer").on("click",function(){
		location.href = '/view_answer?v_bcd='+$(this).attr("id").split(",")[0]+'&v_unit_cnt='+$(this).attr("id").split(",")[1];
	});
	
	$(".mod_ans").on("click",function(){
		location.href = '/mng_answer?v_loc='+$(this).attr("id").split(",")[0]+'&bcd='+$(this).attr("id").split(",")[2];
	});
	
	$(".print_book").on("click",function(){
		location.href = '/question_list';
	});
	
	$(".delete_book").on("click",function(){
		
		swal({
			  title: "정말 삭제하시겠습니까?",
			  text: "공유도서 삭제시 모든 선생님이 볼 수 없게됩니다!",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
			    swal("잠시후에 삭제됩니다!", {
			      icon: "success",
			    });
			    setTimeout(function(){
				    location.href = '/delete_book?v_bcd='+$(this).attr("id");
			    },2000);
			  } else {
			    swal("삭제가 취소되었습니다.");
			  }
			});
		 
		
		
		
		//location.href = '/delete_book?v_bcd='+$(this).attr("id");
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
			<h1>도서 및 답안 등록</h1>
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
						<th>답안 등록</th>
						<th>답안 확인 및 수정</th>
						<th>도서 삭제</th>
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
								id="${vo.v_bcd},${vo.v_unit_cnt }">답안 등록하기</a></td>
							<td><a href="javascript:" class="view_answer"
								id="${vo.v_bcd},${vo.v_unit_cnt }">답안 확인 및 수정</a></td>
							<td><a href="javascript:" class="delete_book"
								id="${vo.v_bcd}">도서 삭제</a></td>
						</c:if>



					</tr>
				</c:forEach>
			</tbody>
		</table>


		<!-- 관리자만 접근 -->
		<c:if test="${!empty sessionScope.s_tlv && sessionScope.s_tlv eq '1'}">
			<form name="frm_reg" id="frm_reg" action="/reg_book" method="post">
				<h2>책 등록하기</h2>
				<label>공유여부 : </label> <select name="b_shareYn" id="b_shareYn">
					<option value="${sessionScope.s_tcd}">N</option>
					<option value="S">Y</option>
				</select> <label>책 코드 : </label> <input type="text" name="b_cd"
					class="_target" id="bcd" /> <label>책 이름 : </label> <input
					type="text" name="b_name" class="_target" id="bname" /> <label>단원
					수 : </label> <input type="text" name="b_unit" class="_target" id="bunit" />
				<a href="javascript:" class="btn btn-default btn-sm" id="btn_reg">제출</a>
			</form>
		</c:if>
	</div>
</body>
</html>

