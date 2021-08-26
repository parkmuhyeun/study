<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String appInitUrl = "/passni/jsp/intergration/sso_init_url.jsp";
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<!-- 각종 스크립트 및 CSS -->
		<link rel="stylesheet" type="text/css" href="/css/ui.css">
		<link rel="stylesheet" type="text/css" href="/css/admin.css">
		<script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="/js/form.js"></script>
		<script type="text/javascript" src="/js/navigation.js"></script>
		<script type="text/javascript" src="/js/ui.js"></script> 
		<script type="text/javascript" src="/js/manage/common.js"></script> 
		<!-- <meta name="keywords" content="경기도,상권영향,정보분석 서비스,정보분석,상권,신규점포분석,기존점포분석" />
		<meta name="description" content="경기도 상권영향 정보분석 서비스 - " />-->
<script>
	function appInit() {
		location.href = "<%=appInitUrl%>";
	}

	function appOut() {
		location.href = "/user/logout.do"
	}
</script>

<!--[if lte IE 9]>
    <script src="/js/lib/IE7/IE9.js"></script>
<![endif]-->
   
		<title>경기도 상권영향 정보분석 서비스</title> 

	</head>
	
	<body>
		<div id="wrap">
			<!-- s:skip navigation -->
			<div id="skipnavigation">
				<ul class="skip">
				<li><a href="#maparea">본문내용 바로가기</a></li>
				<li><a href="#gnbNavi">메인메뉴 바로가기</a></li>
				</ul>
			</div>
			<!-- e:skip navigation -->	

			<!-- header -->
			<tiles:insertAttribute name="header" />
			<!-- header -->
			
			<div id="body">
				<div class="bg">
					<!-- title -->
					<div class="mTitle6">
						<h2>시스템 관리</h2>
					</div>
					<!-- title -->
					<!-- box -->
					<div class="mBox1">
						<!-- secondary -->
						<div id="secondary">
							<div class="mLnb2">
								<ul>
								<li <c:if test="${adminVO.menuIndex eq '1' || empty adminVO.menuIndex}">class="selected"</c:if>><a href="/manage/confirmList.do?menuIndex=1">사용자 이용 신청</a></li>
								<li <c:if test="${adminVO.menuIndex eq '2'}">class="selected"</c:if>><a href="/manage/usedList.do?menuIndex=2">이용통계</a></li>
								<li <c:if test="${adminVO.menuIndex eq '3'}">class="selected"</c:if>><a href="/manage/storeList.do?menuIndex=3">점포정보 관리</a></li>
								<li <c:if test="${adminVO.menuIndex eq '4'}">class="selected"</c:if>><a href="/manage/IncnvnncList.do?menuIndex=4">이용불편사항</a></li>
								</ul>
							</div>
						</div>
						<!-- //secondary -->
						<!-- contents -->
						<tiles:insertAttribute name="contents" />
						<!-- contents -->
					</div>
					<!-- //box -->
				</div>
			</div>

		</div>
	</body>
</html>



