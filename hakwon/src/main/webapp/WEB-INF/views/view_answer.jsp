<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/header.jsp"%>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" async
	src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

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
	
	$("#loadQ").on("click",function(){
		
		var bcd = $("#v_bcd").val();
		var unitCnt = $("#unitCnt").val();
		var unit = $("#v_unit").val();
		
		location.href = '/view_answer?v_bcd='+bcd+'&v_unit_cnt='+unitCnt+'&v_unit='+unit;
	});
	
	$("#delQ").on("click",function(){
		
		$(".v_file_path").prop("disabled",true);
		var frm = $("#frm_del");
		frm.submit();
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
	
	$(".answer").on("click",function(){
		$(this).children(".showing").hide();
		$(this).children(".invisi").show();
	});
	
	$(".btn_edit").on("click",function(){
		
		var filepath = $(this).attr("id");
		var answer = $(this).siblings(".invisi").val().replace("\(","").replace("\)","");
		var appdHtml = [];
		var returnUrl = location.href;
		
		$("#frm_edit").append(" <input type='hidden' name='v_file_path' value='"+filepath+"' >");
		$("#frm_edit").append(" <input type='hidden' name='v_answer' value='"+answer+"' >");
		$("#frm_edit").append(" <input type='hidden' name='returnUrl' value='"+returnUrl+"' >" );
		
		
		$("#frm_edit").submit();
		
	});
	
	function makeSelect(){
		var unitCnt = $("#unitCnt").val();
		var appdHtml = [];
		for( var i=1; i< +unitCnt+1; i++ ){
			appdHtml.push("<option value="+i+"> "+i+"</option>");
		}
		$("#v_unit").append(appdHtml.join(""));
	}
	makeSelect();
	
	
})

</script>

<style>
.images {
	width: 95%;
	height: 90%;
	padding: 0px 10px;
}

figcaption {
	width: 90%;
	padding: 4px 18px;
}

.answer {
	position: relative;
	border: 1px dashed black;
	padding: 0 10px;
	margin: 0 auto;
	min-height: 200px;
	width: 95%;
	height: auto;
	bottom: 4px;
}

.invisi {
	display: none;
}
</style>

</head>

<body>

	<input type="hidden" name="v_bcd" id="v_bcd" value="${v_bcd}">
	<input type="hidden" name="unitCnt" id="unitCnt" value="${unitCnt}">

	<form name="frm_edit" id="frm_edit" class="frm_edit"
		action="/edit_one_answer" method="post"></form>



	<div class="w3-content" style="max-width: 2000px; margin-top: 46px">
		<div class="page-header">
			<h1>답안 확인 및 수정</h1>
		</div>

		<p>
			단원 : <select name="v_unit" id="v_unit">
			</select>

			<a href="javascript:" class="btn btn-default btn-sm" id="loadQ">조회</a>
			<a href="javascript:" class="btn btn-default btn-sm" id="delQ">선택 삭제</a>
		</p>

		<form name="frm_del" id="frm_del" class="frm_del" action="/delete_question" method="post">
		<input type="hidden" name="v_bcd" id="v_bcd" value="${v_bcd}">
		<input type="hidden" name="v_unit_cnt" value="${unitCnt}">
		<c:forEach items="${qaList}" varStatus="s" var="vo">
			<div class="col-sm-2" style="margin-bottom: 2%; width: 24%;">

				<input type="hidden" name="v_file_path" class="v_file_path"
					value="${vo.v_file_path }">

				<div class="w3-card-2" style="width: 100%">
					<input type="checkbox" name="arr_del" value="${vo.v_file_path}">
					<figcaption>
						<b>Question : ${vo.v_bcd } - ${vo.v_unit } - ${vo.v_num}</b>
					</figcaption>
					<img class="images" src="/resources/UPLOAD/${vo.v_file_path }.png"
						alt="no-image">
					<figcaption>
						<b>Answer : </b>
					</figcaption>
					<div class="w3-container answer">
						<p class="showing">\({${vo.v_answer }}\)</p>
						<textarea class="invisi" cols="38" rows="5">${vo.v_answer }</textarea>
						<a href="javascript:" class="btn btn-default invisi btn_edit"
							id="${vo.v_file_path }">제출</a>
					</div>
				</div>
			</div>
		</c:forEach>
		</form>


	</div>
</body>
</html>

