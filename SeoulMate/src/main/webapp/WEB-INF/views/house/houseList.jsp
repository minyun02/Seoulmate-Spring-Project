<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="wrap">

<!-- 프리미엄 추천 쉐어하우스 -->
	<section class="content recommend_list">
		<div class="list_head">
			<p class="m_title">user님과 잘 어울리는 집이예요!</p>
			<a href="">더보기</a>
		</div>
		<ul class="list_content">
			<c:forEach var="i" begin="0" end="2">
				<li> <!-- 리스트 보여줄때는 li 반복문으로 추가 -->
					<div class="list_img">
						<p><span>매칭</span>90<b>%</b></p>
						<button class="btn_star"></button>
						<a href="houseView?no=${hVO.no}">
							<img alt="" src="<%=request.getContextPath()%>/img/comm/sample_house01.png">
						</a>
					</div>
					<div class="list_title">
						<span class="address">서울시 마포구 서강동</span>
						<span class="pay">￦ 100 / 25</span>
					</div>
					<ol class="list_icon">
						<li><p>1</p></li>
						<li><p>2</p></li>
						<li><p>3</p></li>
					</ol>
				</li>
			</c:forEach>
		</ul>
	</section>

</div>

