<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->

<!-- 부가적인 테마 -->
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> -->

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<!-- <script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script>
$(document).ready(function(){
	$(".mng_stdt").on("click",function(){//학생관리 페이지 이동(일반, 관리자)
		location.href = $(this).attr("id") != 'mst' ? "/mng_stdt" : "/mng_stdt?tlv=mst"
	});
	
	$(".mng_question").on("click",function(){//문제관리 페이지 이동(일반, 관리자)
		location.href = $(this).attr("id") != 'mst' ? "/mng_book" : "/mng_book?tlv=mst"
	});
	
	$(".mng_log").on("click",function(){//문제관리 페이지 이동(일반, 관리자)
		location.href = "/mng_log";
	});
	
	$(".mng_teacher").on("click",function(){//선생님 관리 페이지 이동
		location.href = "/mng_teacher";
	});
	
	$(".mng_class").on("click",function(){//선생님 관리 페이지 이동
		location.href = "/mng_class";
	});
	
	$(".logout").on("click",function(){//선생님 관리 페이지 이동
		location.href = "/logout";
	});
	
	$(".reg_img").on("click",function(){//이미지 등록
		location.href = "/reg_img";
	});
	
	$(".reg_answer").on("click",function(){//답안 등록
		location.href = "/reg_answer";
	});
	
	$(".print_book").on("click",function(){//문제지 출력
		location.href = '/question_list';
	});
	
	if($("#s_tcd").val() == ''){//비로그인 튕겨내기
		swal("Not Allowed!", "로그인해주세요!", "warning");
		location.href = 'login';
	}
	
	
	
/* var $setRows = $("#setRows");
	
	$setRows.submit(function (e) {
		e.preventDefault();
		var rowPerPage = $('[name="rowPerPage"]').val() * 1;// 1 을  곱하여 문자열을 숫자형로 변환

		var zeroWarning = 'Sorry, but we cat\'t display "0" rows page. + \nPlease try again.'
		if (!rowPerPage) {
			alert(zeroWarning);
			return;
		}
		$('#nav').remove();
		var $products = $('#products');

		$products.after('<div id="nav">');

		var $tr = $($products).find('tbody tr');
		var rowTotals = $tr.length;
		//console.log(rowTotals);

		var pageTotal = Math.ceil(rowTotals/ rowPerPage);
		var i = 0;

		for (; i < pageTotal; i++) {
			$('<a href="#"></a>')
					.attr('rel', i)
					.html(i + 1)
					.appendTo('#nav');
		}

		$tr.addClass('off-screen')
				.slice(0, rowPerPage)
				.removeClass('off-screen');

		var $pagingLink = $('#nav a');
		$pagingLink.on('click', function (evt) {
			evt.preventDefault();
		var $this = $(this);
		if ($this.hasClass('active')) {
	            return;
	        }
	        $pagingLink.removeClass('active');
	        $this.addClass('active');

	        // 0 => 0(0*4), 4(0*4+4)
	        // 1 => 4(1*4), 8(1*4+4)
	        // 2 => 8(2*4), 12(2*4+4)
	        // 시작 행 = 페이지 번호 * 페이지당 행수
	        // 끝 행 = 시작 행 + 페이지당 행수

	        var currPage = $this.attr('rel');
	        var startItem = currPage * rowPerPage;
	        var endItem = startItem + rowPerPage;

	        $tr.css('opacity', '0.0')
	                .addClass('off-screen')
	                .slice(startItem, endItem)
	                .removeClass('off-screen')
	                .animate({opacity: 1}, 300);
	    });
	    $pagingLink.filter(':first').addClass('active');
	});

	$setRows.submit(); */
	
	
})

</script>
</head>
<style>
/* 나눔고딕 폰트사용 */
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

body{
font-family: "Nanum Gothic", sans-serif;
}
.soon {
	margin-left: 70%;
}

.page-header {
	margin: 60px 0 20px;
}

.hide {
	display: none;
}

.del {
	text-decoration-line: line-through;
}

input:radio {
	width: 13px;
	height: 13px;
	vertical-align: text-top
}

label {
	vertical-align: -1px;
}

input, select, option, .w3-content, .w3-page-header, label {
	padding: 10px;
}

th, td {
	vertical-align: middle !important;
	text-align: center;
}

th>p, td>p {
	margin: auto;
}
</style>


<body>

	<input type="hidden" id="s_tid" value="${sessionScope.s_tid}">
	<input type="hidden" id="s_tcd" value="${sessionScope.s_tcd}">
	<input type="hidden" id="s_tlv" value="${sessionScope.s_tlv}">
	<input type="hidden" id="s_tname" value="${sessionScope.s_tname}">

	<div class="w3-top">
		<div class="w3-bar w3-black w3-card-2">

			<a href="javascript:"
				class="w3-bar-item w3-button w3-padding-large w3-hide-small mng_stdt">학생
				관리</a>

			<c:if
				test="${!empty sessionScope.s_tlv && sessionScope.s_tlv eq '1'}">
				<a href="javascript:"
					class="w3-bar-item w3-button w3-padding-large w3-hide-small mng_teacher">선생님
					관리</a>

				<a href="javascript:"
					class="w3-bar-item w3-button w3-padding-large w3-hide-small mng_class">학급
					관리</a>
			</c:if>

			<a href="javascript:"
				class="w3-bar-item w3-button w3-padding-large w3-hide-small reg_img">문제
				이미지 등록/삭제</a> <a href="javascript:"
				class="w3-bar-item w3-button w3-padding-large w3-hide-small reg_answer">도서
				및 답안 등록</a> <a href="javascript:"
				class="w3-bar-item w3-button w3-padding-large w3-hide-small mng_log">오답
				이력 관리</a> <a href="javascript:"
				class="w3-bar-item w3-button w3-padding-large w3-hide-small print_book">문제지
				출력하기</a> <a href="javascript:"
				class="w3-bar-item w3-button w3-padding-large w3-hide-small logout"
				id="logout">로그아웃</a>
			<div class="soon">
				<h4>
					<c:if test="${!empty sessionScope.s_tname}">
		${sessionScope.s_tname} 선생님 
		<b class="${sessionScope.s_tlv eq 1 ? 'adm' : 'nrm' } ">(${sessionScope.s_tlv eq 1 ? '관리자' : '일반사용자' })</b>
					</c:if>
				</h4>
			</div>
		</div>
	</div>


</body>
</html>

