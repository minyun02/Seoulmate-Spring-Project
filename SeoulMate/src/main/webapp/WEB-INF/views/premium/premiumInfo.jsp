<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	#premiumInfoImg {border: 2px solid #4DA69E; border-radius: 30px; margin-bottom: 30px;}
	#premiumInfoImg ul {overflow: auto; text-align: center; margin: 10px}
	#premiumInfoImg ul>li:first-of-type{font-family: SsangmunDong; font-size: 2.2em; width: 100%; margin-top: 50px;}
	#premiumInfoImg img {width: 32%; border-radius: 30px;}
	#premiunPoint {color:#4DA69E; font-weight: 900;}
	#premiumInfoTable th{height: 50px; line-height: 50px; }
	#premiumInfoTable{border-bottom:2px solid #4DA69E; margin-bottom: 20px;}
	#premiumContent{width: 70%;}
	#premiumContent>button, #premiumContent>a{float: right; margin: 20px 0px;}
</style>
<div class="wrap">
	<div class="content" id="premiumContent">
		<p class="m_title">프리미엄 멤버십 및 요금 안내</p>
		<hr />
		<div>
			<p class="s_title">프리미엄 멤버십 안내</p>
			<p class="d_title">
				서울메이트는 프리미엄 멤버십을 제공합니다. <br />
				결제 여부에 따라 쉐어하우스 초대 및 조회, 하우스메이트 초대 및 조회를 무제한으로 사용이 가능하며,<br />
				조건 및 성향에 따른 매칭순위를 제공합니다. <br />
				<br />
				- 쉐어하우스로 가입 시, 해당 쉐어하우스와 가장 잘 맞는 하우스메이트를 매칭하여 상위에 순위로 표시합니다.<br />
				  또한, 하우스메이트의 상세 정보 확인 시, 어떠한 성향이나 규칙 등이 하우스와 잘 맞는지 상세한 확인이 가능합니다. <br />
				  <br />
				- 하우스메이트로 가입 시, 본인과 가장 잘 맞는 쉐어하우스를 매칭하여 상위에 순위로 표시합니다.<br />
				  또한, 쉐어하우스의 상세 정보 확인 시, 어떠한 성향이나 규칙 등이 본인과 잘 맞는지 상세한 확인이 가능합니다.<br />
				 <br />
				* 매칭은 하우스의 생활, 소통, 하우스 내 지원서비스, 원하는 메이트의 생활, 성격, 나이대 등의 정보들을 비교하여 매칭합니다.<br />
				<br />
				매칭시스템을 활용하여 즐거운 쉐어생활을 할 수 있도록 더욱 잘 맞는 쉐어하우스/하우스메이트를 구하시길 바랍니다. <br />
				<br />
			</p>
		</div>
		<div id="premiumInfoImg">
			<ul>
				<li>매칭률 확인</li>
				<li>	
					<img src="<%=request.getContextPath()%>/img/premiumBefore.jpg"/>
					<img src="<%=request.getContextPath()%>/img/img01.jpg"/>
					<img src="<%=request.getContextPath()%>/img/premiumAfter.jpg"/>
				</li>
			</ul>
			<ul>
				<li>그래프 및 매칭률 확인</li>
				<li>	
					<img src="<%=request.getContextPath()%>/img/machingGraph.jpg"/>
					<img src="<%=request.getContextPath()%>/img/maching.jpg"/>
				</li>
			</ul>
		</div>
		<table class="tb" id="premiumInfoTable">
			<thead>
				<tr>
					<th></th>
					<th>무료</th>
					<th>프리미엄</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>프리미엄 요금</th>
					<th></th>
					<th>15,000원 / 월</th>
				</tr>
				<tr>
					<th id="premiunPoint">성향 매칭</th>
					<th>지원 안함</th>
					<th>지원</th>
				</tr>
				<tr>
					<th>등록 작성 가능 개수</th>
					<th>총 1건</th>
					<th>총 3건</th>
				</tr>
			</tbody>
		</table>
		<c:if test="${memberVO.grade=='1' && logId!=null && memberVO.userid==logId }">
			<a class="b_btn green" id="premiumPayBtn">프리미엄 멤버십 가입하기</a>
		</c:if>
		<c:if test="${membetVO.grade=='2' && logId!=null && memberVO.userid==logId }">
			<button class="b_btn white" disabled>프리미엄 멤버쉽 이용중</button>
		</c:if>
		<c:if test="${logId==null && memberVO.userid==null }">
			<a href="login" class="b_btn white" >로그인 후 멤버십 가입 가능</a>
		</c:if>
		
	</div>
</div>