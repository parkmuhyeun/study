<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/header.jsp"%>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>
$(document).ready(function(){
	
	$("#save_log").on("click",function(){
		var frm = $(".edit_log");
		frm.attr("action","/save_edit_log");
		
		$("input:checkbox[name='v_flag_corr']").each(function(){
			
			if(!$(this).is(":checked")){
				$(this).attr("checked","checked").val("Y");
			}else{
				$(this).val("N");
			}
		});
		
		console.log(frm);
		
		return;
		
		frm.submit();
	});
	
	
	$("#chg_seq").on("change",function(){
		
		var lcd = $("input[name='v_lcd']").val();
		var seq = $("select[name='chg_seq'] option:selected").val();
		
		location.href = '/edit_log?v_lcd='+lcd+'&v_seqno='+seq;
		
	});
	
	$("select[name='chg_seq']").val($(".here_seq").eq(0).text()).attr("selected","selected");
	
	
	$("#print_wrong").on("click",function(){
		var frm = $(".print_wrong");
		frm.attr("action","/gen_img");
		frm.attr("target","gen_img");
		frm.attr("method","POST");
		
		
		frm.submit();
	});
	
})

</script>

<style>
</style>
</head>

<body>
	<div class="w3-content" style="max-width: 2000px; margin-top: 46px">
		<div class="page-header">
			<h1>오답 이력 관리</h1>
		</div>

		<input type="hidden" name="hidSeq" id="hidSeq" value=""> <label>회차선택</label>
		<select name="chg_seq" id="chg_seq">
			<option value="">선택</option>
			<c:forEach items="${seqList}" varStatus="s" var="vo">
				<option value="${vo.v_seqno}">${vo.v_seqno}회차</option>
			</c:forEach>
		</select>


		<form name="edit_log" class="edit_log" action="" method="post">

			<table class="table table-hover">
				<thead>
					<tr>
						<th>로그 코드</th>
						<th>회차</th>
						<th>학생</th>
						<th>선생님</th>
						<th>학급</th>
						<th>도서명</th>
						<th>문제번호</th>
						<th>O/X</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${lList}" varStatus="s" var="vo">
						<tr class="${vo.v_flag_corr eq 'Y' ? 'correct' : 'wrong'}">
							<td>${vo.v_lcd }</td>
							<td class="here_seq">${vo.v_seqno }</td>
							<td>${vo.v_sname }</td>
							<td>${vo.v_tname }</td>
							<td>${vo.v_cname }</td>
							<td>${vo.v_bname }</td>
							<td>${vo.v_filenm }</td>
							<td><c:choose>
									<c:when test="${vo.v_flag_corr eq 'Y'}">
										<input type="checkbox" name="v_flag_corr" value="Y"
											style="display: none">O
			</c:when>
									<c:when test="${vo.v_flag_corr eq 'N'}">
										<input type="checkbox" name="v_flag_corr" class="w3-check"
											value="N">
									</c:when>
									<c:otherwise>
										<label><input type="checkbox" name="v_flag_corr"
											class="w3-check" value="N">오답</label>
									</c:otherwise>
								</c:choose></td>
						</tr>

						<input type="hidden" name="v_lcd" value="${vo.v_lcd }">
						<input type="hidden" name="v_seqno" value="${vo.v_seqno+1 }">
						<input type="hidden" name="v_scd" value="${vo.v_scd }">
						<input type="hidden" name="v_sname" value="${vo.v_sname }">
						<input type="hidden" name="v_tcd" value="${vo.v_tcd }">
						<input type="hidden" name="v_tname" value="${vo.v_tname }">
						<input type="hidden" name="v_ccd" value="${vo.v_ccd }">
						<input type="hidden" name="v_cname" value="${vo.v_cname }">
						<input type="hidden" name="v_bcd" value="${vo.v_bcd }">
						<input type="hidden" name="v_bname" value="${vo.v_bname }">
						<input type="hidden" name="v_filenm" value="${vo.v_filenm }">
						<input type="hidden" name="v_reg_dtm" value="${vo.v_reg_dtm }">

					</c:forEach>
				</tbody>
			</table>
		</form>
		<a href="javascript:" class="btn btn-default btn-sm" id="save_log">저장</a>

		<a href="javascript:" class="btn btn-default btn-sm" id="print_wrong">오답만
			출력</a>

		<form name="print_wrong" class="print_wrong">

			<input type='hidden' name='q_cnt' value="2"> <input
				type='hidden' name='show_num' value='Y'> <input
				type='hidden' name='also_ans' value='Y'>

			<c:forEach items="${lList}" varStatus="s" var="vo" begin="0" end="0"
				step="1">
				<input type='hidden' name='v_cover1'
					value="오답노트(${fn:replace( vo.v_lcd, 'lcd', '' ) })">
				<input type="hidden" name="v_cover2" value="${vo.v_seqno+1 }회독">
			</c:forEach>

			<c:forEach items="${pList}" varStatus="s" var="vo">
				<input type="hidden" name="v_scd" value="${vo.v_scd }">
				<input type="hidden" name="v_sname" value="${vo.v_sname }">
				<input type="hidden" name="v_tcd" value="${vo.v_tcd }">
				<input type="hidden" name="v_tname" value="${vo.v_tname }">
				<input type="hidden" name="v_ccd" value="${vo.v_ccd }">
				<input type="hidden" name="v_cname" value="${vo.v_cname }">

				<input type="hidden" name="v_bcd" value="${vo.v_bcd }">
				<input type="hidden" name="v_bname" value="${vo.v_bname }">
				<input type="hidden" name="hid" value="${vo.v_file_path }">


			</c:forEach>
		</form>

	</div>
</body>
</html>

