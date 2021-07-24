<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<body>

	<select name="v_ccd" class="input form-control v_ccd_reg"
		id="v_ccd_reg">
		<option value="">선택</option>
		<c:forEach items="${cList}" varStatus="s" var="vo">
			<option value="${vo.v_ccd}">${vo.v_cname}</option>
		</c:forEach>
	</select>

	<input type="hidden" name="v_cname" class="v_cname_reg"
		id="v_cname_reg">



</body>
</html>

