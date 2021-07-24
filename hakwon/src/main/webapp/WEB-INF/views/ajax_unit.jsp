<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<body>

	<select name="v_unit" class="input form-control v_scd" id="v_unit">
		<option value="">선택</option>
		<c:forEach items="${unitList}" varStatus="s" var="vo">
			<option value="${vo.v_unit}">${vo.v_unit}</option>
		</c:forEach>
	</select>

	<input type="hidden" name="v_unit" class="v_unit" id="v_unit">



</body>
</html>

