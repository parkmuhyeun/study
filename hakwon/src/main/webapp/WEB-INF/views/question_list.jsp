<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/header.jsp"%>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style>
#feedback {
	font-size: 1.4em;
}

.selector .ui-selecting {
	background: #FECA40;
}

.selector .ui-selected {
	background: #F39814;
	color: white;
}

.selector {
	list-style-type: none;
    margin: 10px;
    padding: 5px;
    width: 99%;
}

.selector li {
	margin: 3px;
	padding: 1px;
	float: left;
	width: 19%;
	height: 200px;
	font-size: 2em;
	text-align: center;
}

#aa {
	background-color: purple
}

#bb {
	background-color: red
}

#cc {
	background-color: green
}

.w3-input {
	width: 200px;
	float: left;
}

.preImg {
	width: 300px
}

.hid > td{
	word-break:break-all;
}
</style>
<script>
$(document).ready(function(){
	
	$(".gen_img").on("click",function(){
		
		if( !$("#tmpSave").hasClass("active") ){
			swal("Not Allowed!", "중간저장을 반드시 눌러주세요!", "warning");
			return;
		}
		
		
		var frm =$("#frm_img");
		var len = $("input[name='hid']").length;
		//var url = $(this).attr("id");
		
		//$("input[name='prt_type']").val(url);
		
		 if(len<1){
			 swal("Nothing selected!", "한개 이상 선택해주세요!", "warning");
			return;
		} 
		
		console.log($("#frm_img").serialize());
		
			$.ajax({
				  url : '/print_log'
				, type : "post"
				, cache: false
				, headers: {"cache-control":"no-cache", "pragma": "no-cache"}
				, data : $("#frm_img").serialize()
				, success : function(data){
					
					$("input[name='v_sname']").val($("#v_scd option:selected").text());
					
					frm.submit();
				}
				, error : function(data){
					alert('error');
				}
			});
	});
	
	$("#v_bcd").on("change",function(){
		
		var v_bcd = $("#v_bcd").val();
		var bNameTxt = $("#v_bcd option:selected").text();
		$("input[name='v_bname']").val(bNameTxt);
		$(".bNameTxt").text(bNameTxt);
		
		$.ajax({
			  url : '/unit_list_ajax'
			, type : "post"
			, cache: false
			, headers: {"cache-control":"no-cache", "pragma": "no-cache"}
			, data : {"v_bookcd" : v_bcd}
			, success : function(data){
				
				var divArea = $(".ajax_here2");
				divArea.html("");
				divArea.html(data);
			
				$( ".selector" ).selectable();
				
					$("#v_unit").on("change",function(){
						
						var v_bcd = $("#v_bcd").val();
						var v_unit = $("#v_unit").val();
						
						$.ajax({
							  url : '/question_list_ajax'
							, type : "post"
							, cache: false
							, headers: {"cache-control":"no-cache", "pragma": "no-cache"}
							, data : {"v_bcd" : v_bcd, "v_unit" : v_unit}
							, success : function(data){
								
								var divArea = $(".ajax_area");
								
								divArea.append(data);
							
								$( ".selector" ).selectable();
								
							}
						});
					});
				
			}
		});
	});
	
	
	$("#v_ccd").on("change",function(){
		$.ajax({
			  url : '/stdt_list_ajax'
			, type : "post"
			, cache: false
			, headers: {"cache-control":"no-cache", "pragma": "no-cache"}
			, data : { v_ccd : $("select[name='v_ccd'] option:selected").val()}
			, success : function(data){
				
				var selected = $("#v_ccd option:selected").text();
				$("#v_cname").val(selected);
				
				$(".ajax_here").html("");
				$(".ajax_here").html(data);
				
				$(".v_scd").on("change",function(){
					$(".v_sname").val( $(".v_scd option:selected").text() );
				});
				
				
			}
			, error : function(data){
				alert('error');
			}
		});
	});
	
	
	$("#tmpSave").on("click",function(){
		
		if( !$(".ui-selected").length ){
			swal("Not Allowed!", "저장할 내용이 없습니다!", "warning");
			return;
		}
		
		$(this).addClass("active");
		
		$(".ui-selected > img").remove();
		$("#frm_img").append($(".ui-selected").children());
		
		$("#frm_img").children("p").remove();
		
		$(".selector").remove();
		
		var v_bcd = $("select[name='v_bcd'] option:selected").val();
		var v_bname = $("select[name='v_bcd'] option:selected").text();
		var v_unit = $("select[name='v_unit'] option:selected").text();
		
		
		if($("tr").filter("."+v_bcd+"_"+v_unit+"_list").length >= 1){
			swal("Terrible Error!", "이미 선택했던 도서는 다시 선택할 수 없습니다. 새로고침 후, 처음부터 다시해주세요!", "error");
		}else{
			$("<tr class='"+v_bcd+"_"+v_unit+"_list hid' style='display:none;'><td colspan='11'></td></tr>").insertAfter($("#tmp_save_tr"));
		}
		
		var arr = [];
		$("#frm_img").find("input[name='hid']").filter("."+v_bcd+"").removeClass("ui-selectee");
		
		var lastIdx;
		var filenm
		$("#frm_img").find("input[name='hid']").filter("."+v_bcd+"").each(function(idx){
			
			lastIdx = $(this).val().lastIndexOf("/");
			filenm = $(this).val().substring(lastIdx+1, $(this).val().length).replace(".png","").replace(v_bcd+"_","");
			
			/* if(idx%30 == 0){
				arr.push("<br>");
			} */
			if(filenm.charAt(0) == v_unit){
				arr.push(filenm+", ");//파일명만 따오기
				
			}
		})
		
		/* $("."+v_bcd+"_list").find("td").text(v_bname +" : "+arr); */
		$("."+v_bcd+"_"+v_unit+"_list").find("td").text(v_bname + " "+v_unit+"단원 : ");
		$("."+v_bcd+"_"+v_unit+"_list").find("td").append(arr);
		
	})
	
	$("#chkSaved").on("click",function(){
		
		$(".hid").show();
		
	});
	
	$(".selectAll").on("click",function(){
		$(".ajax_area").find(".ui-selectee").addClass("ui-selected");
	})
	
	
	
});
</script>
</head>

<body>
	<div class="w3-content" style="max-width: 2000px; margin-top: 46px">

		<div class="page-header">
			<h1>문제 출력</h1>
		</div>
		<form name="frm_upload" id="frm_upload" action="" method="post"
			enctype="multipart/form-data"></form>

		<form name="frm_img" id="frm_img" action="/gen_img" target="gen_img"
			method="POST">
			<input type="hidden" name="v_tcd" value="${sessionScope.s_tcd }">
			<input type="hidden" name="v_tname" value="${sessionScope.s_tname }">


			<table class="table table-bordered">
				<thead>
					<tr>
						<th>학급</th>
						<th>학생</th>
						<th>책</th>
						<th>단원</th>
						<th>중간 저장</th>
						<th>내역 확인</th>
						<th>표지문구(10글자 미만)</th>
						<th>화면당 문제수</th>
						<th>문제번호 출력</th>
						<th>답안 출력 포함</th>
						<th>생성</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<!-- Combo 1 반 선택 --> <select name="v_ccd" id="v_ccd"
							class="input w3-input">
								<option value="">선택</option>
								<c:forEach items="${cList}" varStatus="s" var="vo">
									<option value="${vo.v_ccd}">${vo.v_cname}</option>
								</c:forEach>
						</select> <input type="hidden" name="v_cname" id="v_cname">

						</td>


						<td class="ajax_here"></td>

						<td><select name="v_bcd" id="v_bcd" class="input w3-input">
								<option value="">선택</option>
								<c:forEach items="${bookList}" varStatus="s" var="voo">
									<option value="${voo.v_bcd }">${voo.v_bname }</option>
								</c:forEach>
						</select> <input type="hidden" name="v_bname" id="v_bname"></td>

						<td class="ajax_here2"></td>

						<td><a id="tmpSave" class="btn btn-default btn-sm">중간 저장</a>
						</td>
						<td><a id="chkSaved" class="btn btn-default btn-sm">내역 확인</a>
						</td>
						<td><p><label>문구-1:</label><input type="text" name="v_cover1" id="v_cover1" size=13
							maxlength=12 class="input w3-input" style="float: right"></p>
							<p><label>문구-2:</label><input type="text" name="v_cover2" id="v_cover2" size=13
							maxlength=12 class="input w3-input" style="float: right"></p>
						</td>
						<td>
							<input class="w3-check" type="radio" name="q_cnt"
							value="1" checked><label>1</label>
							&nbsp;&nbsp;&nbsp;&nbsp; 
							<input class="w3-check" type="radio" name="q_cnt"
							value="2" checked><label>2</label>
							&nbsp;&nbsp;&nbsp;&nbsp; <input class="w3-check" type="radio"
							name="q_cnt" value="4"><label>4</label></td>

						<td><input class="w3-check" type="radio" name="show_num"value="Y" checked>
							<label>고유</label>
							&nbsp;&nbsp;&nbsp;&nbsp; 
							<input class="w3-check" type="radio" name="show_num" value="N">
							<label>순서</label>
							&nbsp;&nbsp;&nbsp;&nbsp; 
							<input class="w3-check" type="radio" name="show_num" value="H">
							<label>없음</label>
						</td>

						<td><input class="w3-check" type="radio" name="also_ans"
							value="Y" checked><label>Y</label>
							&nbsp;&nbsp;&nbsp;&nbsp; <input class="w3-check" type="radio"
							name="also_ans" value="N"><label>N</label></td>

						<td><a href="javascript:"
							class="gen_img btn btn-default btn-sm" id="gen_img">생성</a></td>
					</tr>
					<tr id="tmp_save_tr" style="display: none">
					</tr>
				</tbody>
			</table>

			<a href="javascript:"	class="selectAll btn btn-default btn-sm">전체선택</a>
			<div class="ajax_area"></div>
		</form>
	</div>
</body>
</html>

