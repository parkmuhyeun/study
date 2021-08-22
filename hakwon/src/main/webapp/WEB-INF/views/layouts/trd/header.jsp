<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import = "com.ubintis.common.util.StrUtil" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%
	String MBR_ID		= StrUtil.NVL( session.getAttribute( "MBR_ID" ) );
	String MBR_NM		= StrUtil.NVL( session.getAttribute( "MBR_NM" ) );
	String ISADMIN		= StrUtil.NVL( session.getAttribute( "ISADMIN" ) );
%>
	<!-- header -->
	<div id="header2">
		<h1>
			<span class="img"><a href="/main.do"><img src="/images/logo21.png" alt="경기도 상권영향분석 서비스"></a></span>
		</h1>
		<div class="gRt">
			<span class="link">
				<a href="/trd/intro.do"> 서비스소개</a>
				<span class="bar">|</span>
				<a href="/trd/data.do">데이터 출처</a>
				<span class="bar">|</span>
				<a href="javascript:iHelp();">도움말</a>
			</span>
			<span class="log">
				<% if (!MBR_ID.equals("")) { %>
				<span class="gLog">
					<a href="###" class="sel"><span><%=MBR_NM%> 님</span></a>
					<span class="lst">
						<span class="lstBg">
							<% if ("Y".equals(ISADMIN)) { %>
							<a href="/manage/confirmList.do" class="noline">관리자 페이지</a>
							<% } %>
							<a href="javascript:searchSSO();">비밀번호변경</a>
						</span>
					</span>
				</span>
				<a href="javascript:appOut();" class="out"><span>로그아웃</span></a>
				<% } else { %>
				<a href="javascript:appInit();" class="in"><span>로그인</span></a>
				<% } %>	
			</span>
		</div>
		<!-- gnb -->
		<div class="mGnb2">
			<ul>
			<% if (!MBR_ID.equals("")) { %>
			<li class="nobar"><a href="/passni/jsp/intergration/ssoLink.jsp?appid=sgbiz_infl">상권영향정보 서비스</a></li>
			<% } else { %>
			<li class="nobar"><a href="http://effect.gmr.or.kr/infl/analysis.do">상권영향정보 서비스</a></li>
			<% } %>
				
			<% if (!MBR_ID.equals("")) { %>
			<li><a href="/passni/jsp/intergration/ssoLink.jsp?appid=sgbiz_mnt">정책지원 서비스</a></li>
			<% } else { %>
			<li><a href="http://policy.gmr.or.kr/mnt/oldstore.do">정책지원 서비스</a></li>
			<% } %>	
			</ul>
		</div>
		<!-- //gnb -->
				
	</div>
	<!-- //header --> 

