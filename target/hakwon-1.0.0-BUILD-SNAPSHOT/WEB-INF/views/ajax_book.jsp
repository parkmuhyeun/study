<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">

<body>

	<ol class="selector" id=${vo.v_bcd }>
		<c:forEach items="${qList}" varStatus="s" var="vo">
			<li class="ui-state-default"><p>${fn:split( vo.v_file_path ,  '/' )[1] }</p>
				<img src="/resources/UPLOAD/${vo.v_file_path }.png" class="preImg">
				<input type="hidden" name="hid" class="${vo.v_bcd }"
				value="${vo.v_file_path }" /></li>
		</c:forEach>
	</ol>


</body>
</html>

