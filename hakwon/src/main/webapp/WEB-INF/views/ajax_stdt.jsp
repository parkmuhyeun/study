<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<body>

	<select name="v_scd" class="input form-control v_scd" id="v_scd">
		<option value="">선택</option>
		<c:forEach items="${sList}" varStatus="s" var="vo">
			<option value="${vo.v_scd}">${vo.v_sname}</option>
		</c:forEach>
	</select>

	<input type="hidden" name="v_sname" class="v_sname" id="v_sname">



</body>
</html>

