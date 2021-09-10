<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<header class="p-3 bg-dark text-white">
	<div class="container">
		<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
			<ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
				<li><a href="/main" class="nav-link px-2 text-secondary">Home</a></li>
				<li><a href="/posts" id="abcd" class="nav-link px-2 text-white">Posts</a></li>
				<li><a href="#" class="nav-link px-2 text-white">Pricing</a></li>
				<li><a href="#" class="nav-link px-2 text-white">FAQs</a></li>
				<li><a href="#" class="nav-link px-2 text-white">About</a></li>
			</ul>

			<form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
				<input type="search" class="form-control form-control-dark" placeholder="Search..." aria-label="Search">
			</form>

			<c:if test="${empty memberName}">
				<div class="text-end">
					<button type="button" onclick="location.href = 'login'" class="btn btn-outline-light me-2">Login</button>
					<button type="button" onclick="location.href = 'join'" class="btn btn-warning">Sign-up</button>
				</div>
			</c:if>
			<c:if test="${not empty memberName}">
				<form action="/logout" method="post">
					<button class="btn btn-outline-light me-2" onclick="location.href = 'main'" type="submit">Log Out</button>
				</form>
				<button type="button" class="btn btn-warning">My Page</button>
			</c:if>
		</div>
	</div>
</header>


<%--	<!-- header -->--%>
<%--	<div id="header2">--%>
<%--			header--%>
<%--	</div>--%>
<%--	<!-- //header --> --%>

