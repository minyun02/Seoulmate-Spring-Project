<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/hyun.css">
<div class="wrap">
	<div class="content">
		<p class="m_title">결제 내역 확인</p>
		<form action="/home/payDetailList" method="post" id="payForm">
			<input type="hidden" name="pageNum" id="hiddenPageNum" />
			<select id="payYearSelect">
				<option value="0" selected>전체목록</option>
				<c:forEach var="year" items="${payList }">
				<option value="${fn:substring(year.payStart, 0, 4) }">${fn:substring(year.payStart, 0, 4) }년</option>
				</c:forEach>
			</select>
		</form>
		<table class="tb" id="payDetailTable">
			<caption>결제내역</caption>
			<thead>
				<tr>
					<th>결제일</th>
					<th>서비스기간</th>
					<th>결제수단</th>
					<th>금액</th>
					<th>환불여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="pVO" items="${payList }">
				<tr>
					<td>${fn:substring(pVO.payStart, 0, 10) }</td>
					<td>${fn:substring(pVO.payStart, 0, 10) } ~ ${fn:substring(pVO.payEnd, 0, 10) }</td>
					<td>
					<c:choose>
						<c:when test="${pVO.payMethod == 'card'}">카드결제</c:when>
						<c:when test="${pVO.payMethod == 'point'}">포인트결제</c:when>
						<c:otherwise>그 외 결제</c:otherwise>
					</c:choose>
					</td>
					<fmt:formatNumber var="amount" value="${pVO.amount}" />
					<td>₩ ${amount }</td>
					<td><c:if test="${pVO.refund==null or pVO.refund=='' }">X</c:if>
					<c:if test="${pVO.refund!=null and pVO.refund!='' }">O</c:if></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>