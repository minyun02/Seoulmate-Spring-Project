<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<script>
	var payVO = '<c:out value="${payVO}"/>';
	var pagingVO = '<c:out value="${pagingVO}"/>';
	var nodeResult = '<c:out value="${nodeResult}"/>';
	
	$.ajax({
		url : "/home/admin/payManagement",
		data : {"payVO":payVO, "pagingVO":pagingVO, "nodeResult":nodeResult}
	})
</script>
	</body>
</html>