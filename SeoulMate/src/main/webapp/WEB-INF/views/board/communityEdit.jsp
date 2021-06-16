<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reset.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/comm.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/yun.css">

<div class="wrap">
	<div class="content">
		<p class="m_title">커뮤니티 글 수정</p>
		<br>
		<form id="writeForm" method="post" action="/home/communityEditOk">
			<input type="hidden" name="no" value="${list.no}">
			<ul>
				<li id="comWriteLi">
					<select id="category" name="category">
						<option disabled selected hidden>카테고리 선택</option>
						<option <c:if test="${list.category == '우리집 자랑'}"> selected</c:if> >우리집 자랑</option>
						<option <c:if test="${list.category == '중고장터'}"> selected</c:if> >중고장터</option>
						<option <c:if test="${list.category == '쉐어TIP'}"> selected</c:if> >쉐어TIP</option>
						<option <c:if test="${list.category == '자유게시판'}"> selected</c:if> >자유게시판</option>
					</select>
				</li>
				<li id="comWriteSubject"><input id="subject" name="subject" type="text" value="${list.subject}"></li>
				<li id="comWriteBtn"><button class="green" id="communityEditOk">수정 완료</button></li>
			</ul>
			<br>
			<textarea id="summernote" name="content">${list.content}</textarea>
		</form>
		<script>
			// 4월28일 추가 + summernote에디터 사용할때 제이쿼리 버전 출동로 인해서 추가된 부분////
			jQuery.curCSS = function(element, prop, val) {
			    return jQuery(element).css(prop, val);
			};
			/////
		  	$(document).ready(function(){
		  		$("#summernote").summernote({
		  			placeholder : '내용을 입력해주세요.',
		  			height : 500
		  		});
		  	});
			$("#writeForm").submit(function(){
				if($("#category option:selected").val()=='카테고리 선택'){
					alert("카테고리를 선택해주세요.");
					return false;
				}
				if($("#subject").val()== ''){
					alert("제목을 입력해주세요.");
					return false;
				}
				if ($('#summernote').summernote('isEmpty')) {
					alert('내용을 입력해주세요.');
					return false;
				}
			});
			//카테고리 선택
			//$("#category").val('${list.category}').prop('selected', true);
	    </script>
	</div>
</div>