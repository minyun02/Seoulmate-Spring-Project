<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<link rel="stylesheet" href="/home/css/choi.css"/>
<script>
	$(function(){
		$("#delUl>.no>a").click(function(){
			var delNo=$(this).attr("class"); // 삭제할 성향 번호를 id로 가져옴
			
			if(confirm("삭제하시겠습니까?")){
				location.href="proDelNoHouse?pno="+delNo;
			}
		});
		
		$("#delUl>.yes>a").click(function(){
			var delNo=$(this).attr("class"); // 삭제할 성향 번호를 id로 가져옴
			
			if(confirm("삭제하시겠습니까?")){
				location.href="proDelHouse?pno="+delNo;
			}
		});
	});
</script>
<div class="wrap">
	<div class="member_wrap">
		<p class="m_title" id="proTitle">성향 수정</p>
		<div class="title_wrap p_center">
			<c:if test="${pcaseM==1}">
				<p class="s_title s_margin">메이트 성향 수정</p><br/>
				<a class="green s_margin" href="proEditMateForm">메이트 성향 수정</a><br/>
			</c:if>
			<c:if test="${pcaseH>0}"> <!-- 수정해야 할 수도 있음 -->
				<p class="s_title s_margin">하우스 성향 수정</p><br/>
				<ul class="s_margin" id="proUl">
					<c:if test="${noHouse>0}">
						<c:forEach var="pno" items="${noList}" varStatus="index">
							<li><a href="proEditNoHouseForm?pno=${pno}">이름없는 집 ${index.count} 수정</a></li>
						</c:forEach>
					</c:if>
					<c:forEach var="vo" items="${list}">
						<li><a href="proEditHouseForm?pno=${vo.pno}">${vo.housename}</a></li>
					</c:forEach>
				</ul>
				<c:if test="${noHouse>0 || fn:length(list)>0}">
				<p class="s_title s_margin">하우스 성향 삭제</p><br/>
				<ul class="s_margin" id="delUl">
					<%-- <c:if test="${noHouse>0}"> --%>
						<c:forEach var="pno" items="${noList}" varStatus="index">
							<li class="no"><a class="${pno}">이름없는 집 ${index.count} 삭제</a></li>
						</c:forEach>
					<%-- </c:if> --%>
					<c:if test="${fn:length(list)>0}">
						<c:forEach var="pno" items="${list}">
							<li class="yes"><a class="${pno.pno}">${pno.housename} 삭제</a></li>
						</c:forEach>
					</c:if>
				</ul>
				</c:if>
			</c:if>
			<c:if test="${pcaseM==0}">
				<p class="s_title s_margin">메이트 성향 추가</p><br/>
				<a class="green s_margin" href="proInsertForm">메이트 성향 추가</a><br/>
			</c:if>
		</div>
	</div>
</div>
</body>
</html>