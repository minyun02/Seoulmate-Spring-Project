<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/choi.css"/>
<script>
	$(function(){
		// 1
		$("#proNext1").click(function(){			
			$("#proDiv1").css("display","none");
			$("#proDiv2").css("display","block");
			goTop();
		});
		// 2
		$("#proPrev2").click(function(){
			$("#proDiv1").css("display","block");
			$("#proDiv2").css("display", "none");
			goTop();
		});
		$("#proNext2").click(function(){
			$("#proDiv2").css("display","none");
			$("#proDiv3").css("display","block");
			goTop();
		});
		// 3
		$("#proPrev3").click(function(){
			$("#proDiv2").css("display","block");
			$("#proDiv3").css("display","none");
			goTop();
		});
		$("#proNext3").click(function(){
			$("#proDiv3").css("display","none");
			$("#proDiv4").css("display","block");
			$("#mateChoice>p").css("display", "none");
			$("#Choice>p").css("display", "block");
			goTop();
		});
		// 4
		$("#proPrev4").click(function(){
			$("#proDiv3").css("display","block");
			$("#proDiv4").css("display","none");
			$("#mateChoice>p").css("display", "block");
			$("#Choice>p").css("display", "none");
			goTop();
		});
		$("#proNext4").click(function(){
			$("#proDiv4").css("display","none");
			$("#proDiv5").css("display","block");
			goTop();
		});
		$("#proPrev5").click(function(){
			$("#proDiv4").css("display","block");
			$("#proDiv5").css("display","none");
			goTop();
		});
		// 상단으로 스크롤 이동
		function goTop(){
			$('html').scrollTop(0);
		}
	});
	function mateEditCheck(){
		if(${fail=='fail'}){
			alert("메이트 성향 수정에 실패하였습니다.");
		}
	}
	mateEditCheck();
</script>
<div class="wrap">
	<div class="member_wrap">
		<form method="post" id="proId" action="proInsertOk">
			<div id="mateChoice">
				<p class="m_title">희망하는 하우스의 성향 등록</p>
				<p class="d_title">희망하는 하우스의 라이프 스타일을 선택해주세요.</p>
			</div>
			<div id="proDiv1">
				
				<div class="title_wrap">
					<p class="s_title">생활</p>
				</div>
				<ul class="form_box choice">
					<li><label><span class="red_txt">*</span>생활 소음</label>
						<div class="checks">
							<input type="radio" name="h_noise" id="h_noise1" value="1" checked/>
							<label for="h_noise1">매우 조용함</label>
							<input type="radio" name="h_noise" id="h_noise2" value="2"/>
							<label for="h_noise2">보통</label>
							<input type="radio" name="h_noise" id="h_noise3" value="3"/>
							<label for="h_noise3">조용하지 않음</label>
						</div>
					</li>
					<li><label><span class="red_txt">*</span>생활 시간</label>
						<div class="checks">
							<input type="radio" name="h_pattern" id="h_pattern1" value="1" checked/>
							<label for="h_pattern1">주행성</label>
							<input type="radio" name="h_pattern" id="h_pattern3" value="3"/>
							<label for="h_pattern3">야행성</label>
						</div>
					</li>
					<li><label><span  class="red_txt">*</span>반려동물 여부</label>
						<div class="checks">
							<input type="radio" name="h_pet" id="h_pet3" value="3" checked/>
							<label for="h_pet3">있음</label>
							<input type="radio" name="h_pet" id="h_pet1" value="1"/>
							<label for="h_pet1">없음</label>
						</div>
					</li>
					<li><label><span  class="red_txt">*</span>반려동물 동반 입실 여부</label>
						<div class="checks">
							<input type="radio" name="h_petwith" id="h_petwith3" value="3" checked/>
							<label for="h_petwith3">가능</label>
							<input type="radio" name="h_petwith" id="h_petwith1" value="1"/>
							<label for="h_petwith1">불가능</label>
						</div>
					</li>
					<li><label><span  class="red_txt">*</span>흡연</label>
						<div class="checks">
							<input type="radio" name="h_smoke" id="h_smoke1" value="1" checked/>
							<label for="h_smoke1">비흡연</label>
							<input type="radio" name="h_smoke" id="h_smoke2"value="2"/>
							<label for="h_smoke2">실외 흡연</label>
							<input type="radio" name="h_smoke" id="h_smoke3"value="3"/>
							<label for="h_smoke3">실내 흡연</label>
						</div>
					</li>
				</ul>
				<div class="btn_wrap">
					<a class="q_btn green" id="proNext1">다음</a>
				</div>
			</div>
			<div id="proDiv2">
				<div class="title_wrap">
					<p class="s_title">소통</p>
				</div>
				<ul class="form_box choice">
					<li><label><span class="red_txt">*</span>분위기</label>
						<div class="checks">
							<input type="radio" name="h_mood" id="h_mood1" value="1" checked/>
							<label for="h_mood1">화목함</label>
							<input type="radio" name="h_mood" id="h_mood2" value="2"/>
							<label for="h_mood2">보통</label>
							<input type="radio" name="h_mood" id="h_mood3" value="3"/>
							<label for="h_mood3">독립적</label>
						</div>
					</li>
					<li><label><span class="red_txt">*</span>소통 방식</label>
						<div class="checks">
							<input type="radio" name="h_communication" id="h_communication3" value="3" checked/>
							<label for="h_communication3">대화</label>
							<input type="radio" name="h_communication" id="h_communication1" value="1"/>
							<label for="h_communication1">메신저</label>
							<input type="radio" name="h_communication" id="h_communication2" value="2"/>
							<label for="h_communication2">기타</label>
						</div>
					</li>
					<li><label><span class="red_txt">*</span>모임 빈도</label>
						<div class="checks">
							<input type="radio" name="h_party" id="h_party3" value="3" checked/>
							<label for="h_party3">자주</label>
							<input type="radio" name="h_party" id="h_party2" value="2"/>
							<label for="h_party2">가끔</label>
							<input type="radio" name="h_party" id="h_party1" value="1"/>
							<label for="h_party1">없음</label>
						</div>
					</li>
					<li><label><span class="red_txt">*</span>모임 참가 의무</label>
						<div class="checks">
							<input type="radio" name="h_enter" id="h_enter1" value="1" checked/>
							<label for="h_enter1">없음</label>
							<input type="radio" name="h_enter" id="h_enter2" value="2"/>
							<label for="h_enter2">상관없음</label>
							<input type="radio" name="h_enter" id="h_enter3" value="3"/>
							<label for="h_enter3">있음</label>
						</div>
					</li>
				</ul>
				<div class="btn_wrap">
					<a class="h_btn white" id="proPrev2">이전</a>
					<a class="h_btn green" id="proNext2">다음</a>
				</div>
			</div>
			<div id="proDiv3">
				<div class="title_wrap">
					<p class="s_title">서비스 및 기타</p>
				</div>
				<ul class="form_box choice">
					<li><label><span class="red_txt">*</span>하우스 내 지원 서비스</label>
						<div class="checks checkbox">
							<input type="checkbox" name="h_support" id="h_support1" value="1"/>
							<label for="h_support1">공용공간 청소 지원</label>
							<input type="checkbox" name="h_support" id="h_support2" value="2"/>
							<label for="h_support2">공용 생필품 지원</label><br/>
							<input type="checkbox" name="h_support" id="h_support3" value="3"/>
							<label for="h_support3">기본 식품 지원</label>
						</div>
					</li>
					<li><label></label></li>
					<li><label><span class="red_txt">*</span>기타</label>
						<div class="checks checkbox">
							<input type="checkbox" name="h_etc" id="h_etc1" value="1"/>
							<label for="h_etc1">보증금 조절 가능</label>
							<input type="checkbox" name="h_etc" id="h_etc3" value="3"/>
							<label for="h_etc3">즉시 입주 가능</label>
						</div>
					</li>
				</ul>
				<div class="btn_wrap">
					<a class="h_btn white" id="proPrev3">이전</a>
					<a class="h_btn green" id="proNext3">다음</a>
				</div>
			</div>
			<div id="Choice">
				<p class="m_title">나의 성향 등록</p>
				<p class="d_title">나의 라이프 스타일을 선택해주세요.</p>
			</div>
			<div id="proDiv4">
				<div class="title_wrap">
					<p class="s_title">생활</p>
				</div>
				<ul class="form_box choice">
					<li><label><span class="red_txt">*</span>생활 시간</label>
						<div class="checks">
							<input type="radio" name="m_pattern" id="m_pattern1" value="1" checked/>
							<label for="m_pattern1">주행성</label>
							<input type="radio" name="m_pattern" id="m_pattern3" value="3"/>
							<label for="m_pattern3">야행성</label>
						</div>
					</li>
					<li><label><span  class="red_txt">*</span>성격</label>
						<div class="checks">
							<input type="radio" name="m_personality" id="m_personality1" value="1" checked/>
							<label for="m_personality1">내향적</label>
							<input type="radio" name="m_personality" id="m_personality3" value="3"/>
							<label for="m_personality3">외향적</label>
							<input type="radio" name="m_personality" id="m_personality2" value="2"/>
							<label for="m_personality2">상관없음</label>
						</div>
					</li>
					<li><label><span  class="red_txt">*</span>반려동물</label>
						<div class="checks">
							<input type="radio" name="m_pet" id="m_pet1" value="1" checked/>
							<label for="m_pet1">긍정적</label>
							<input type="radio" name="m_pet" id="m_pet3" value="3"/>
							<label for="m_pet3">부정적</label>
						</div>
					</li>
					<li><label><span  class="red_txt">*</span>흡연</label>
						<div class="checks">
							<input type="radio" name="m_smoke" id="m_smoke1" value="1" checked/>
							<label for="m_smoke1">비흡연</label>
							<input type="radio" name="m_smoke" id="m_smoke2"value="2"/>
							<label for="m_smoke2">실외 흡연</label>
							<input type="radio" name="m_smoke" id="m_smoke3"value="3"/>
							<label for="m_smoke3">실내 흡연</label>
						</div>
					</li>
				</ul>
				<div class="btn_wrap">
					<a class="h_btn white" id="proPrev4">이전</a>
					<a class="h_btn green" id="proNext4">다음</a>
				</div>
			</div>
			<div id="proDiv5">
				<div class="title_wrap">
					<p class="s_title">유형</p>
				</div>
				<ul class="form_box choice">
					<li><label><span class="red_txt">*</span>나이 대</label>
						<div class="checks">
							<input type="radio" name="m_age" id="m_age1" value="1" checked/>
							<label for="m_age1">20~30대</label>
							<input type="radio" name="m_age" id="m_age3" value="3"/>
							<label for="m_age3">40대</label>
							<input type="radio" name="m_age" id="m_age2" value="2"/>
							<label for="m_age2">상관없음</label>
						</div>
					</li>
					<li><label><span  class="red_txt">*</span>성별</label>
						<div class="checks">
							<input type="radio" name="m_gender" id="m_gender1" value="1" checked/>
							<label for="m_gender1">여성</label>
							<input type="radio" name="m_gender" id="m_gender3" value="3"/>
							<label for="m_gender3">남성</label>
							<input type="radio" name="m_gender" id="m_gender2" value="2"/>
							<label for="m_gender2">상관없음</label>
						</div>
					</li>
					<li><label><span  class="red_txt">*</span>외국인 입주 가능 여부</label>
						<div class="checks">
							<input type="radio" name="m_global" id="m_global3" value="3" checked/>
							<label for="m_global3">가능</label>
							<input type="radio" name="m_global" id="m_global1" value="1"/>
							<label for="m_global1">불가능</label>
						</div>
					</li>
					<li><label><span  class="red_txt">*</span>즉시 입주 가능 여부</label>
						<div class="checks">
							<input type="radio" name="m_now" id="m_now1" value="1" checked/>
							<label for="m_now1">가능</label>
							<input type="radio" name="m_now" id="m_now3"value="3"/>
							<label for="m_now3">불가능</label>
						</div>
					</li>
				</ul>
				<div class="btn_wrap">
					<a class="h_btn white" id="proPrev5">이전</a>
					<button class="h_btn green" id="proNext5">등록</button>
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>