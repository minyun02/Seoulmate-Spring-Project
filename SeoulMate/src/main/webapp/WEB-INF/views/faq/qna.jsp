<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/yun.css">
<script>
	$(function(){
		$('.qnaList>div').click(function(){
			var th=$(this);			
			var i=$(this).children('.faqATag2').css('display');
			if(i=='none'){ // 숨기기
				$(this).children('.faqATag2').css("display","block"); // 더보기 버튼 보이기
				$(this).children('.faqATag1').css("display","none"); // 숨기기 버튼 숨기기
				
				$(this).parent().css('height','52px');
			}else{ // 보이기
				$(this).parent().siblings().css('height','52px');
				$(this).parent().siblings().children().children('.faqATag1').css("display","none"); // 펼쳤던 다른 질문의 숨기기 버튼을 숨겨버림
				$(this).parent().siblings().children().children('.faqATag2').css("display","block"); // 펼쳤던 다른 질문의 보이기 버튼을 보이게 함 
				
				$(this).children('.faqATag2').css("display","none"); // 더보기 버튼 숨기기
				$(this).children('.faqATag1').css("display","block"); // 숨기기 버튼 보이기 
				
				var textHeight=$(this).next().height(); // 답변의 높이 구하기
				
				$(this).parent().css('height',(textHeight+90)+"px")
			}
		});

		
		// 검색
		$('#faqSearch>input').keyup(function(){ /* $('#faqSearch>input').keyup(function(){ */
			var value=$(this).val().toLowerCase(); // 검색어로 입력한 문자열

			$('#qnaUl>li>div>span').filter(function(){
				// 없으면 -1
				var idx=$(this).text().indexOf(value); // 질문 제목의 값 구하기
				var idx2=$(this).parent().next().children('p').text().indexOf(value); // 질문 답변의 값 구하기
				
				//	true : 그냥 둠, false : 숨김
				$(this).parent().parent().toggle(idx+idx2>-2); // 둘다 없으면 -2 
			});
		});
	})
</script>
<div class="wrap">
	<div class="member_wrap" id="faq_member_wrap">
		<p class="s_title">자주하는 질문</p>
		<br>
		<ul>
			<li id="faqSearch"><input type="text" placeholder="검색어을 입력해주세요"><br/></li>
<!-- 			<li><button id="faqSearchBtn" class="q_btn green">검색</button></li> -->
			<li style="text-align:center;"><br><p>원하는 답을 못 찾았다면 <a class="faqATag" href="contact">문의하기</a>를 이용해보세요.</p></li>
		</ul>
	</div>	
	<br>
	<div class="content">
		<ul id="qnaUl">
			<c:forEach var="list" items="${faqList}">
				<li class="qnaList">
					<div class="cursor">
						<span>Q. ${list.subject}</span>
						<a class="faqATag1">
							<img alt="질문숨기기" src="<%=request.getContextPath()%>/img/yun/fi-rr-cross-small.svg">
						</a>
						<a class="faqATag2">
							<img alt="질문더보기" src="<%=request.getContextPath()%>/img/yun/fi-rr-plus-small.svg">
						</a>
					</div>
					<div class="faqDiv">
						<p>${list.content}</p>
					</div>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>