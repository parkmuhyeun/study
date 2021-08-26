<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- <%@ page import = "com.ubintis.app.BaseMgt" %> --%>
<%@ page import = "com.ubintis.common.util.StrUtil" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
// 	BaseMgt baseMgt = new BaseMgt();
	String appInitUrl = "/passni/jsp/intergration/sso_init_url.jsp";//baseMgt.getFULL_SSO_AGENT_INIT_URL();	// 로그인 호출 URL
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>경기도 상권영향분석 서비스 | 소상공인지원 서비스</title>
<link rel="stylesheet" type="text/css" href="/css/ui.css">
<link rel="stylesheet" type="text/css" href="/css/ui2_policy.css">
<script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/js/jquery-resizable.js"></script>
<script type="text/javascript" src="/js/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="/js/form.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript" src="/js/ui.js"></script>
<script type="text/javascript" src="/js/common.js"></script>

<script>
	function appInit() {
		location.href = "<%=appInitUrl%>";
	}

	function appOut() {
		location.href = "/user/logout.do"
	}

	function iHelp(){
		$(".lHelp").show();
		$(".modalBg").show();
	}

	function iPrivacy() {
		var url = "http://www.gsbdc.or.kr/PageLink.do?link=forward:/PageContent.do&tempParam1=&menuNo=110000&subMenuNo=110200&thirdMenuNo=";
		var option = "left=0,top=0,width=1024,height=768,toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes";
		window.open(url, "_blank", option);
	}

	function goSelectSite(){
		var url = $('#goSelectSite option:selected').val();
		if(url != '') {
			window.open(url);
		}
	}

	function searchSSO() {
		var url = "http://www.gmr.or.kr/uss/umt/MberSelectUpdtView.do?tempParam1=&menuNo=100000&subMenuNo=100400&thirdMenuNo=";
		var option = "left=0,top=0,width=1024,height=768,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=yes";
		window.open(url, "_blank");
	}

	function fncNewWinOpen(url) {
		   window.open(url);
		}

		function complaint(){

			$(':radio').removeAttr('checked',false).change();
			$('body').scrollTop(0);
			$('[name=inconvenience]').text('');
			/*
			$(':radio[name="incon1"]').removeAttr('checked',false).change();
			$(':radio[name="incon2"]').removeAttr('checked',false).change();
			$(':radio[name="incon3"]').removeAttr('checked',false).change();
			*/
			$('.complaint').show();
		};

		function clearContents(element) {
			  element.value = '';
		}

		function cmpRstSbm(){
			var param = {};
			param.jobCd = $(':radio[name="incon1"]:checked').val();
			param.ageCd = $(':radio[name="incon2"]:checked').val();
			param.visitCd = $(':radio[name="incon3"]:checked').val();
			param.mostMenuCd = $(':radio[name="incon4"]:checked').val();

			param.survey1 = $(':radio[name="incon5"]:checked').val();
			param.survey2 = $(':radio[name="incon6"]:checked').val();
			param.survey3 = $(':radio[name="incon7"]:checked').val();
			param.survey4 = $(':radio[name="incon8"]:checked').val();
			param.survey5 = $(':radio[name="incon9"]:checked').val();
			param.survey6 = $(':radio[name="incon9"]:checked').val();
			param.survey7 = $(':radio[name="incon10"]:checked').val();
			param.inconvenience = $('#complaintVal textarea[name="inconvenience"]').val();

			var objKeys = Object.keys(param);
	 		for(var i=0; i<objKeys.length; i++){
				if( param[ objKeys[i] ] == undefined ){
					alert("설문에 모두 답해주세요");
					return;
				}
			}

			 $.ajax({
		            url : '/common/put_incnvnnc.json',
		            method : 'post',
		            data : param,
		            success: function(response) {
						$('.complaint').hide();
						$('.cmpFinish').show();
		            },
		            error : function(error) {
		            }
		    });
		};
</script>

<!--[if lte IE 9]>
    <script src="/js/lib/IE7/IE9.js"></script>
<![endif]-->
</head>

<body>
	<!-- s:skip navigation -->
	<div id="skipnavigation">
		<ul class="skip">
		<li><a href="#body">본문내용 바로가기</a></li>
		<li><a href="#gnbNavi">메인메뉴 바로가기</a></li>
		</ul>
	</div>
	<!-- e:skip navigation -->

	<div id="progress" class="lLoading" style="display: none">
		<div class="loadBg">
			<div class="img"><img src="/images/img_loading2.gif" alt="정보 분석 중 입니다. 1분 이상 소요될 수 있습니다."></div>
			<p class="txt">정보 분석 중 입니다. 1분 이상 소요될 수 있습니다.</p>
			<a href="javascript:hideLoading()" class="mBtn11 blue">분석취소</a>
		</div>
	</div>

	<div id="wrap">
		<tiles:insertAttribute name="header" />
		<tiles:insertAttribute name="contents" />
		<tiles:insertAttribute name="footer" />
	</div>

	<!-- layer-help -->
	<div class="lHelp hidden">
		<div class="helpBg">
			<h3>도움말</h3>
			<span class="gRt"><a href="http://sbiz.gmr.or.kr/sg_user_manual.pdf" class="iManual">사용자 매뉴얼 다운로드 </a></span>
			<!-- tab -->
			<div class="mTab21 type3 col3 jsBtnTab3">
				<a href="#jsLHelpCont1" class="selected"><span>상권분석</span></a>
				<a href="#jsLHelpCont2"><span>내 점포 마케팅</span></a>
				<a href="#jsLHelpCont3"><span>업종 변경</span></a>
			</div>
			<!-- //tab -->

			<!-- 상권분석 -->
			<div id="jsLHelpCont1" class="cont">
				<h4>상권 분석 순서</h4>
				<div class="con1">
					<ul>
					<li class="ls1">업종 트렌드 분석<br> (매출추이,점포추이,폐업률 등)</li>
					<li class="ls2">분석 예비 업종 선정<br> (비교 대상 예비 업종)</li>
					<li class="ls3">시군 단위 주제도 분석</li>
					<li class="ls4">시군 단위 분석 리포트 조회</li>
					<li class="ls5">기초상권 단위 주제도 분석</li>
					<li class="ls6">상권 단위 분석 리포트 조회</li>
					<li class="ls7">상권비교 담기</li>
					<li class="ls8">상권비교 분석</li>
					</ul>
				</div>
				<div class="con2">
					<img src="/images/img_help1.png" alt="1.업종 트렌드 분석, 2.업종선택, 3.선택업종 트렌드 분석, 4.시군단위 주제도 분석, 5.시군 단위 분석 리포트 조회, 6.상권 단위 주제도 분석, 7.업종트렌드 분석, 8.업종선택, 9.선택업종 트렌드 분석">
				</div>
			</div>
			<!-- 내 점포 마케팅 -->
			<div id="jsLHelpCont2" class="cont hidden">
				<h4>내 점포 마케팅 분석 순서</h4>
				<div class="con1">
					<ul>
					<li class="ls1">업종선택<br> (업종선택, 검색)</li>
					<li class="ls2">점포위치 입력<br> (새주소, 구주소)</li>
					<li class="ls3 row2">분석영역 설정<br> (반경, 다각형)</li>
					<li class="ls4">분석 리포트 조회</li>
					<li class="ls5 row2">마케팅 분석<br> (유동인구, 거주인구)</li>
					<li class="ls6">경쟁점포 분석</li>
					<li class="ls7">상세 정보 분석</li>
					<li class="ls8">주요 시설 분석</li>
					</ul>
				</div>
				<div class="con2">
					<img src="/images/img_help1_2.png" alt="업종선택 (업종선택, 검색), 2.점포위치 입력 (새주소, 구주소), 3.분석영역 설정 (반경, 다각형), 4.분석 리포트 조회, 5.마케팅 분석 (유동인구, 거주인구), 6.경쟁점포 분석, 7.상세 정보 분석, 8.주요 시설 분석">
				</div>
			</div>
			<!-- 업종비교 -->
			<div id="jsLHelpCont3" class="cont hidden">
				<h4>업종비교</h4>
				<div class="con1">
					<ul>
					<li class="ls1">점포위치 입력<br> (새주소, 구주소)</li>
					<li class="ls2">분석영역 설정<br> (반경, 다각형)</li>
					<li class="ls3 row2">업종 설정<br> (기준1개, 비교2개)</li>
					<li class="ls4">분석 리포트 조회</li>
					<li class="ls5">업종 비교 분석</li>
					<li class="ls6">매출 비교 분석</li>
					<li class="ls7">배후 인구 분석</li>
					<li class="ls8">경쟁 점포 분석</li>
					</ul>
				</div>
				<div class="con2">
					<img src="/images/img_help1_3.png" alt="1. 점포위치 입력 (새주소, 구주소), 2.분석영역 설정 (반경, 다각형), 3.업종 설정 (기준1개, 비교2개), 4.분석 리포트 조회, 5.업종 비교 분석, 6.매출 비교 분석, 7.배후 인구 분석, 8.경쟁 점포 분석">
				</div>
			</div>

			<a href="###" class="close">닫기</a>
		</div>
	</div>

	<!-- //layer-help -->
	<div class="modalBg" style="display:none;"></div>

	<!-- 지표설명 -->
	<div class="lIndicator hidden">
		<div class="title">
			<h3>지표설명</h3>
			<a href="###" class="iClose">닫기</a>
		</div>
		<div class="con">
			<h4 class="mt1"><span>창업위험지수</span></h4>
			<div class="co1">
				상권 내 시장 수요 대비 경쟁과 선택 업종의 성장성과 안정성을 고려하여 상권 내 선택 업종의 창업 시 위험 정도를 판단
				<div class="row"><em class="tit">수식</em> 창업위험지수 = ( <img src="/images/ico_num1.png" alt="①" class="n">시장성 + <img src="/images/ico_num2.png" alt="②" class="n">성장성 + <img src="/images/ico_num3.png" alt="③" class="n">안정성) / 3</div>
				<div class="ts">
					<img src="/images/ico_num1.png" alt="①" class="n"> 시장성 = (상권내 매출액(거래고객수X객단가) / 상권 내 점포수)–(시군 내 매출액(거래고객수X객단가/시군 내 점포수))<br>
					<img src="/images/ico_num2.png" alt="②" class="n"> 성장성 = (당분기 매출액 / 전년 동분기 매출액)<br>
					<img src="/images/ico_num3.png" alt="③" class="n"> 안정성 = 1 - (폐업 점포수 / 신규 점포수)
				</div>
			</div>
			<h4><span>업종 성장성</span></h4>
			<div class="co1">
				선택 업종의 전년 대비 당년의 매출 증감률을 비교하여 성장 정도를 판단
				<div class="row"><em class="tit">수식</em> 성장성 = (당분기 매출액 / 전년 동분기 매출액) - 1</div>
			</div>
			<h4><span>업종 안정성</span></h4>
			<div class="co1">
				점포수의 변동의 민감도를 판단하기 위해 직전분기 대비 점포수 변화량을 산출하여 선택 업종의 안정 정도를 판단,<br> 급격한 증감 시 안정성이 낮아짐
				<div class="row"><em class="tit">수식</em> 안정성 = 1 - (폐업 점포수 / 신규 점포수)</div>
			</div>
			<h4><span>업종 시장성</span></h4>
			<div class="co1">
				상권 내 점포당 평균 매출이 시군 평균 매출과 비교하여 시군 평균 대비 시장성을 판단
				<div class="row"><em class="tit">수식</em> 시장성​ = 상권 내 매출 (거래고객수 X 객단가 / 상권 내 점포수 - 시군 내 매출(거래고객수 X 객단가 / 시군 내 점포수)</div>
			</div>
			<h4><span>업종 구매력</span></h4>
			<div class="co1">
				선택 업종의 주 고객을 분석하여 상권 내 주고객 규모가 비중을 산출하여 상권 내 구매력을 판단
				<div class="row"><em class="tit">수식</em> 구매력 = <img src="/images/ico_num1.png" alt="①" class="n">주고객군 X <img src="/images/ico_num2.png" alt="②" class="n">배후인구수</div>
				<div class="ts">
					<img src="/images/ico_num1.png" alt="①" class="n"> 주고객군 : 상권별 매출 비중이 높은 연령대 (연령대별 특화도 = 상권 연령대별 매출비 / 시군구 연령대별 매출비)<br>
					<img src="/images/ico_num2.png" alt="②" class="n"> 배후인구수 : 상권 내 주거인구수, 유동인구수
				</div>
			</div>
			<h4><span>상가밀집도</span></h4>
			<div class="co1">
				선택 상권의 면적당 밀집도를 경기도와 비교하여 상대적인 상가의 밀집 정도를 판단
				<div class="row"><em class="tit">수식</em> 상권 내 <img src="/images/ico_num1.png" alt="①" class="n">셀 당 점포수 / 경기도 <img src="/images/ico_num1.png" alt="①" class="n">셀 당 점포수</div>
				<div class="ts"><img src="/images/ico_num1.png" alt="①" class="n"> 셀단위(100mX100m)</div>
			</div>
		</div>
	</div>
	<!-- //지표설명 -->

</body>
</html>