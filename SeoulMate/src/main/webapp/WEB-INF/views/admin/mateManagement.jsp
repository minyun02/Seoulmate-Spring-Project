<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<section class="admin_Section">
			<div class="admin_Content">
				<div class="m_title managementTitle">메이트 관리</div>
				<form method="post" action="/home/admin/mateManagement" class="managementSearchForm management_SearchForm" name="mateManagementForm">
					<div class="management_houseSearch">
						<div class="management_houseSelect management_houseStateSelect">
							<span class="managementSpan3">글 개제 상태</span>
								<select name="state" id="matestate" class="custom-select">
									<option value="" <c:if test="${pagingVO.state==null }">selected</c:if>>전체</option>
									<option value="모집중" <c:if test="${pagingVO.state=='모집중' }">selected</c:if>>모집중</option>
									<option value="매칭 완료" <c:if test="${pagingVO.state=='매칭 완료' }">selected</c:if>>매칭 완료</option>
									<option value="기간 만료" <c:if test="${pagingVO.state=='기간 만료' }">selected</c:if>>기간 만료</option>
									<option value="비공개" <c:if test="${pagingVO.state=='비공개' }">selected</c:if>>비공개</option>
								</select>
							<span class="managementSpan3">멤버십 상태</span>
							<select name="grade" id="grade" class="custom-select">
								<option value="0" <c:if test="${pagingVO.grade==0 }">selected</c:if>>전체</option>
								<option value="1" <c:if test="${pagingVO.grade==1 }">selected</c:if>>일반</option>
								<option value="2" <c:if test="${pagingVO.grade==2 }">selected</c:if>>프리미엄</option>
							</select>
						</div>
						<div class="managementSearch">
							<select name="searchKey" id="searchKey" class="custom-select">
								<option value="userid" <c:if test="${pagingVO.searchKey==null || pagingVO.searchKey=='userid' }">selected</c:if>>아이디</option>
								<option value="area"  <c:if test="${pagingVO.searchKey=='area' }">selected</c:if>>희망지역</option>
							</select>
							<input type="hidden" name="pageNum" id="hiddenPageNum" value="${pagingVO.pageNum}"/>
							<input type="text" name="searchWord" class="form-control" value=<c:if test="${pagingVO.searchWord!=null }">"${pagingVO.searchWord}"</c:if><c:if test="${pagingVO.searchWord==null }">""</c:if> />
							<input type="submit" value="Search" class="btn btn-custom"/>
						</div>
						<div>
							<a href="javascript:printPage('mateWrite')" class="btn btn-custom">프린트</a>
							<a href="javascript:printPage('mateExcel')" class="btn btn-custom">엑셀</a>
						</div>
					</div>
					
				</form>
				<div class="table-responsive, managementList">
					<table class="table table-hover table-sm table-bordered">
						<thead class="thead-light">
							<tr class="admin_HouseManagement_DetailInfo_Header">
								<th>No.</th>
								<th>이름</th>
								<th>아이디</th>
								<th>희망지역</th>
								<th>등급</th>
								<th>신고수</th>
								<th>글 개제 상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="mateVO" items="${mateWriteList }">
							<tr class="admin_HouseManagement_DetailInfo" >
								<td>${mateVO.no }</td>
								<td>${mateVO.username }</td>
								<td>${mateVO.userid }</td>
								<td>${mateVO.aList[0] } <c:if test="${mateVO.aList[1]!=null }"> / ${mateVO.aList[1] }</c:if><c:if test="${mateVO.aList[2]!=null }"> / ${mateVO.aList[2] }</c:if>  </td>
								<td><c:if test="${mateVO.grade==1}">일반</c:if><c:if test="${mateVO.grade==2}">프리미엄</c:if></td>
								<td>${mateVO.reportNum }</td>
								<td>${mateVO.matestate }</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="paging">
						<c:if test="${pagingVO.pageNum>1 }">
							<a href="javascript:pageClick('first_page')" class="first_page"></a>
							<a href="javascript:pageClick('prev_page')"  class="prev_page"></a>
						</c:if>
						<c:if test="${pagingVO.pageNum==1 }">
							<a href="#" class="first_page"></a>
							<a href="#"  class="prev_page"></a>
						</c:if>
						<c:forEach var="pageNum" begin="${pagingVO.startPageNum }" end="${pagingVO.startPageNum + pagingVO.onePageNum-1 }">
							<c:if test="${pageNum<=pagingVO.totalPage }">
								<c:if test="${pageNum==pagingVO.pageNum }">
									<a href="javascript:pageClick('${pageNum }')" class="nowPageNum">${pageNum }</a>
								</c:if>
								<c:if test="${pageNum!=pagingVO.pageNum }">
									<a href="javascript:pageClick('${pageNum }')">${pageNum }</a>
								</c:if>
							</c:if>
						</c:forEach>
						<c:if test="${pagingVO.pageNum < pagingVO.totalPage }">
							<a href="javascript:pageClick('next_page')" class="next_page"></a>
							<a href="javascript:pageClick('last_page')" class="last_page"></a>
						</c:if>
						<c:if test="${pagingVO.pageNum == pagingVO.totalPage }">
							<a href="#" class="next_page"></a>
							<a href="#" class="last_page"></a>
						</c:if>
					</div>
				</div>
			</div>
			<div id="mateListPrint"></div>
		</section>
			<!-- popup   -->
		<div class="admin_Management_popup popup_hidden">
			<div class="admin_Management_popup_head">메이트 관리 상세 정보 <span class="admin_Management_popup_head_close popup_Close">X</span></div>
				<div class="admin_Management_popup_body" id="admin_Management_popup_print">
					<div class="admin_Management_popup_title"> [<span>userid</span>] 님의 메이트 게재 정보</div>
					<ul class="admin_Management_popup_table">
						<li class="admin_Management_popup_table_title" style="padding-left: 20px;">메이트 정보</li>
						<li>
							<ul class="admin_Management_popup_table_inner1">
								<li>이름</li>
								<li id="mem_username"></li>
							</ul>
							<ul class="admin_Management_popup_table_inner0">
								<li>생년월일</li>
								<li id="mem_birth"></li>
								<li>성별</li>
								<li id="mem_gender"><span ></span> 건</li>
							</ul>
							<ul class="admin_Management_popup_table_inner0">
								<li>연락처</li>
								<li id="mem_tel"></li>
								<li>이메일</li>
								<li id="mem_email"></li>
							</ul>
							<ul class="admin_Management_popup_table_inner0">
								<li>게재 기간</li>
								<li><span id="mw_writedate"></span> ~ <span id="mw_enddate"></span></li>
								<li>상태</li>
								<li>
									<select name="mw_matestate" class="custom-select" style="height: 28px; padding: 2px 10px; vertical-align: middel; margin-bottom: 5px;">
										<option value="모집중" selected>모집중</option>
										<option value="매칭 완료">매칭 완료</option>
										<option value="기간 만료">기간 만료</option>
										<option value="비공개">비공개</option>
									</select>
								</li>
							</ul>
							<ul class="admin_Management_popup_table_inner0">
								<li>등급</li>
								<li id="mem_grade">프리미엄</li>
								<li>신고수</li>
								<li><span id="mw_reportNum"></span> 건</li>
							</ul>
							<li class="admin_Management_popup_table_title" style="padding-left: 20px;">선택한 본인 성향 </li>
							<li id="admin_Management_popup_htom">
								<ul class="admin_Management_popup_table_inner3">
									<li>생활시간 : <span id="propen_m_pattern"></span></li>
									<li>성격 : <span id="propen_m_personality"></span></li>
									<li>반려동물 : <span id="propen_m_pet"></span></li>
									<li>흡연여부 : <span id="propen_m_smoke"></span></li>
									<li>나이대 : <span id="propen_m_age"></span></li>
									<li>성별 : <span id="propen_m_gender"></span></li>
									<li>외국인 여부 : <span id="propen_m_global"></span></li>
									<li>즉시입주 여부 : <span id="propen_m_now"></span></li>
								</ul>
							</li>
						<li class="admin_Management_popup_table_title" style="padding-left: 20px;">희망하는 하우스 정보 </li>
						<li>
							<ul class="admin_Management_popup_table_inner1">
								<li>희망 지역</li>
								<li id="mw_area"></li>
							</ul>
							<ul class="admin_Management_popup_table_inner0">
								<li>보증금 / 월세</li>
								<li><span id="mw_deposit"></span>만원 / <span id="mw_rent"></span>만원</li>
								<li>입주 희망일</li>
								<li><span id="mw_enterdate"></span> 이후 </li>
							</ul>
							<ul class="admin_Management_popup_table_inner0">
								<li>최소거주기간</li>
								<li id="mw_minStay"></li>
								<li>최대거주기간</li>
								<li id="mw_maxStay"></li>
							</ul>
						</li>
						<li class="admin_Management_popup_table_title" style="padding-left: 20px;">희망하는 하우스 성향</li>
						<li>
							<ul class="admin_Management_popup_table_inner2">
								<li>생활</li>
								<li>생활소음 : <span id="propen_h_noise"></span></li>
								<li>생활시간 : <span id="propen_h_pattern"></span></li>
								<li>흡연 : <span id="propen_h_smoke"></span></li>
								<li style="width: 42%;">하우스 내 반려동물 여부 : <span id="propen_h_pet"></span></li>
								<li style="width: 42%;">반려동물 동반입실(거주) 여부 : <span id="propen_h_petwith"></span></li>
							</ul>
							<ul class="admin_Management_popup_table_inner2">
								<li>소통</li>
								<li>분위기 : <span id="propen_h_mood"></span></li>
								<li>소통방식 : <span id="propen_h_communication"></span></li>
								<li>모임 빈도 : <span id="propen_h_party"></span></li>
								<li>모임 참가 의무 : <span id="propen_h_enter"></span></li>
							</ul>
							<ul class="admin_Management_popup_table_inner1">
								<li>지원 서비스</li>
								<li>공용공간 청소 지원 : <span id="propen_h_support1"></span></li>
								<li>공용 생필품 지원 : <span id="propen_h_support2"></span></li>
								<li>기본 식품 지원 : <span id="propen_h_support3"></span></li>
							</ul>
							<ul class="admin_Management_popup_table_inner1">
								<li>기타</li>
								<li>보증금 조절 가능 여부 : <span id="propen_h_etc1"></span></li>
								<li>즉시입주 가능 여부 : <span id="propen_h_etc3"></span></li>
							</ul>
						</li>
						<li class="admin_Management_popup_table_title" style="padding-left: 20px;">메이트 사진</li>
						<li class="admin_Management_popup_table_img" id="mw_matePic">
						</li>
					</ul>
				</div>
				<div class="admin_Management_popup_table_btn">
					<a href="javascript:printPage('pop')" class="btn btn-custom">프린트</a>
					<a href="#" class="btn btn-custom mate_popup_Edit">수정</a>
					<input id="change_state" type="hidden" name="change_state" value=""/>
					<input id="selectPno" type="hidden" name="selectPno" value=""/>
					<a href="#" class="btn btn-custom popup_Close">닫기</a>
				</div>
			</div>
			<div class="myPage_HouseAndMate_Popup_FullScreen popup_Close popup_hidden" id="myPage_popup_FullScreen"></div>
	</body>
<script>
$(function(){
	var popup_select = '';
	var delNo = [];
	var delFile = [];
	var matePic1 = '';
	var matePic2 = '';
	var matePic3 = '';
	$(document).on('change','#mw_matePic',function(){
		$('input[name=change_state]').val($(this).val());
	});
	$(document).on('click','.mate_imgDel', function(){
		$(this).prev().addClass("objectHidden");
		console.log($(this).prev().attr("id"));
		console.log($(this).prev().attr("name"));
		delNo.push($(this).prev().attr("name"));
		delFile.push($(this).prev().attr("id"));
	});
	$(document).on('click', '.mate_popup_Edit', function(){
		var change_state = $('input[name=change_state]').val();
		var selectPno = $('input[name=selectPno]').val();
		console.log("selectPno==="+selectPno);
		console.log(delNo);
		console.log(delFile);
		console.log(delFile.length);
		var Deldata = new Array();
		
		for(var i=0; i<delFile.length; i++){
			if(delNo[i]=="matePic1"){
				matePic1 = delFile[i];
			}if(delNo[i]=="matePic2"){
				matePic2 = delFile[i];
			}if(delNo[i]=="matePic3"){
				matePic3 = delFile[i];
			}
		}
		var data = {'pno':selectPno,'matePic1':matePic1, 'matePic2':matePic2, "matePic3":matePic3,"matestate":change_state };
		
		var url = "/home/admin/mate_ManagementEdit";
		$.ajax({
			url : url,
			data : data,
			type : 'POST',
			success : function(result){
				console.log(result);
				if(result==1){
					console.log("수정이 완료되었습니다.");
					alert('수정이 완료되었습니다');
				}else if(result==200){
					console.log("mate_ManagementEdit 에러발생 update 실패 ");
				}
			},error : function(){
				console.log("mate_ManagementEdit ajax 에러");
			}
		});
		
	});
	$('.admin_HouseManagement_DetailInfo').on('click', function(){
		var no = $(this).children().eq(0).text();
		var userid = $(this).children().eq(2).text();
		
		var url = "/home/admin/mateDetailInfo";
		var data = {"no" : no, "userid" : userid};
		
		$.ajax({
			url : url, 
			data : data,
			type : 'post',
			dataType : 'json',
			success : function(result){
				// mwVO, propenVO/ memVO
				$('.admin_Management_popup_title>span').eq(0).text(result.mwVO.userid);
				$('#mem_username').text(result.memVO.username);
				$('#mem_birth').text(result.memVO.birth.substr(0, 10));
				// gender 1여, 2남 
				if(result.memVO.gender == 1){ $('#mem_gender').text('여성');}
				else if(result.memVO.gender == 2){ $('#mem_gender').text('남성');}
				else{ $('#mem_gender').text('');}
				$('#mem_tel').text(result.memVO.tel);
				$('#mem_email').text(result.memVO.email);
				$('#mw_writedate').text(result.mwVO.writedate.substr(0, 10));
				$('#mw_enddate').text(result.mwVO.enddate.substr(0, 10));
				$('select[name=mw_matestate]').val(result.mwVO.matestate).prop("selected", true);
				$('input[name=change_state]').val(result.mwVO.matestate);
				$('input[name=selectPno]').val(result.mwVO.pno);
				// grade (1:일반, 2:프리미엄)
				if(result.memVO.grade == 1){ $('#mem_grade').text('일반');}
				else if(result.memVO.grade == 2){ $('#mem_grade').text('프리미엄');}
				else{ $('#mem_grade').text('');}
				$('#mw_reportNum').text(result.mwVO.reportNum);
				// 메이트 생활 시간 
				var m_pattern = result.propenVO.m_pattern;
				if(m_pattern == 1){ $('#propen_m_pattern').text('주행성');}
				else if(m_pattern == 3){ $('#propen_m_pattern').text('야행성');}
				else{$('#propen_m_pattern').text('');}
				// 메이트 성격
				var m_personality = result.propenVO.m_personality;
				if(m_personality == 1){ $('#propen_m_personality').text('내향적');}
				else if(m_personality == 2){ $('#propen_m_personality').text('상관없음');}
				else if(m_personality == 3){ $('#propen_m_personality').text('외향적');}
				else { $('#propen_m_personality').text('');}
				// 메이트 애완동물
				var m_pet = result.propenVO.m_pet;
				if(m_pet == 1){ $('#propen_m_pet').text('긍정적');}
				else if(m_pet == 3){ $('#propen_m_pet').text('부정적');}
				else {$('#propen_m_pet').text('');}
				//메이트 흡연여부
				var m_smoke = result.propenVO.m_smoke;
				if(m_smoke == 1){ $('#propen_m_smoke').text('비흡연');}
				else if(m_smoke == 2){ $('#propen_m_smoke').text('상관없음');}
				else if(m_smoke == 3){ $('#propen_m_smoke').text('흡연');}
				else { $('#propen_m_smoke').text('');}
				//메이트 나이대 
				var m_age = result.propenVO.m_age;
				if(m_age == 1){ $('#propen_m_age').text('20~30대');}
				else if(m_age == 2){ $('#propen_m_age').text('상관없음');}
				else if(m_age == 3){ $('#propen_m_age').text('40대이상');}
				else { $('#propen_m_age').text('');}
				//메이트 성별
				var m_gender = result.propenVO.m_gender;
				if(m_gender == 1){ $('#propen_m_gender').text('여성');}
				else if(m_gender == 2){ $('#propen_m_gender').text('상관없음');}
				else if(m_gender == 3){ $('#propen_m_gender').text('남성');}
				else { $('#propen_m_gender').text('');}
				//메이트 외국인 입주 가능 여부
				var m_global = result.propenVO.m_global;
				if(m_global == 1){ $('#propen_m_global').text('불가능');}
				else if(m_global == 3){ $('#propen_m_global').text('가능');}
				else {$('#propen_m_global').text('');}
				//메이트 즉시입주 가능여부
				var m_now = result.propenVO.m_now;
				if(m_now == 1){ $('#propen_m_now').text('가능');}
				else if(m_now == 3){ $('#propen_m_now').text('불가능');}
				else {$('#propen_m_now').text('');}
				$('#mw_area').text(result.mwVO.area);
				$('#mw_deposit').text(result.mwVO.deposit);
				$('#mw_rent').text(result.mwVO.rent);
				$('#mw_enterdate').text(result.mwVO.enterdate.substr(0, 10));
				$('#mw_minStay').text(result.mwVO.minStay);
				$('#mw_maxStay').text(result.mwVO.maxStay);
				//하우스 생활 소음
				var h_noise = result.propenVO.h_noise; 
				if(h_noise == 1){ $('#propen_h_noise').text('매우조용함');}
				else if(h_noise == 2){ $('#propen_h_noise').text('보통');}
				else if(h_noise == 3){ $('#propen_h_noise').text('조용하지 않음');}
				else{ $('#propen_h_noise').text('');}
				//하우스 생활 시간
				var h_pattern = result.propenVO.h_pattern;
				if(h_pattern == 1){ $('#propen_h_pattern').text('주행성');}
				else if(h_pattern == 3){ $('#propen_h_pattern').text('행성');}
				else {$('#propen_h_pattern').text('');}
				// 하우스 흡연 
				var h_smoke = result.propenVO.h_smoke;
				if(h_smoke == 1){ $('#propen_h_smoke').text('비흡연');}
				else if(h_smoke == 2){ $('#propen_h_smoke').text('실외흡연');}
				else if(h_smoke == 3){ $('#propen_h_smoke').text('실내흡연');}
				else {$('#propen_h_smoke').text('');}
				// 하우스 애완동물
				var h_pet = result.propenVO.h_pet;
				if(h_pet == 1){ $('#propen_h_pet').text('없음');}
				else if(h_pet == 3){ $('#propen_h_pet').text('있음');}
				else{ $('#propen_h_pet').text('');}
				// 하우스 애완동물 동반 입실
				var h_petwith = result.propenVO.h_petwith;
				if(h_petwith == 1){ $('#propen_h_petwith').text('불가능');}
				else if(h_petwith == 3){ $('#propen_h_petwith').text('가능');}
				else { $('#propen_h_petwith').text('');}
				// 하우스 분위기
				var h_mood = result.propenVO.h_mood;
				if(h_mood == 1){ $('#propen_h_mood').text('화목함');}
				else if(h_mood == 2){ $('#propen_h_mood').text('보통');}
				else if(h_mood == 3){ $('#propen_h_mood').text('독립적');}
				else { $('#propen_h_mood').text('');}
				// 하우스 소통 방식
				var h_communication = result.propenVO.h_communication;
				if(h_communication == 1){ $('#propen_h_communication').text('메신저');}
				else if(h_communication == 2){ $('#propen_h_communication').text('기타');}
				else if(h_communication == 3){ $('#propen_h_communication').text('대화');}
				else {$('#propen_h_communication').text('');}
				//하우스 모임 빈도
				var h_party = result.propenVO.h_party;
				if(h_party == 1){ $('#propen_h_party').text('없음');}
				else if(h_party == 2){ $('#propen_h_party').text('상관없음');}
				else if(h_party == 3){ $('#propen_h_party').text('있음');}
				else{ $('#propen_h_party').text('');}
				//하우스 모임 참가 의무
				var h_enter = result.propenVO.h_enter;
				if(h_enter == 1){ $('#propen_h_enter').text('없음');}
				else if(h_enter == 2){ $('#propen_h_enter').text('상관없음');}
				else if(h_enter == 3){ $('#propen_h_enter').text('있음');}
				else{$('#propen_h_enter').text('');}
				//지원서비스
				//공용공간 청소 지원
				var h_support = result.propenVO.h_support;
				$('#propen_h_support1').text('X');
				$('#propen_h_support2').text('X');
				$('#propen_h_support3').text('X');
				if(h_support>0){
					for(var i=0; i<h_support.length; i++){
						if(h_support[i] == 1){
							$('#propen_h_support1').text('O');
						}else if(h_support[i] == 2){
							$('#propen_h_support2').text('O');
						}else if(h_support[i] == 3){
							$('#propen_h_support3').text('O');
						}else{
							
						}
					}
				}
				//기타 : 보증금 조절 가능여부, 즉시입주 가능여부
				var h_etc = result.propenVO.h_etc;
				$('#propen_h_etc1').text('X');
				$('#propen_h_etc3').text('X');
				if(h_etc>0){
					for(var i=0; i<h_etc.length; i++){
						if(h_etc[i] == 1){
							$('#propen_h_etc1').text('O');
						}else if(h_etc[i] == 3){
							$('#propen_h_etc3').text('O');
						}
					}
				}
				// 이미지 넣기
				var mateImgTag = '';
				if(result.mwVO.matePic1!=null && result.mwVO.matePic1!=''){
					mateImgTag += '<div><img class="mate_img" id="'+result.mwVO.matePic1+'" name="matePic1" src="/home/matePic/'+result.mwVO.matePic1+'" alt="matePic1" onerror="this.src=\'/home/img/comm/no_mate_pic.png\'"/>';
					mateImgTag += '<span class="mate_imgDel">삭제</span></div>';
				}
				if(result.mwVO.matePic2!=null && result.mwVO.matePic2!=''){
					mateImgTag += '<div><img class="mate_img" id="'+result.mwVO.matePic2+'" name="matePic2" src="/home/matePic/'+result.mwVO.matePic2+'" alt="matePic2" onerror="this.src=\'/home/img/comm/no_mate_pic.png\'"/>';
					mateImgTag += '<span class="mate_imgDel">삭제</span></div>';
				}
				if(result.mwVO.matePic3!=null && result.mwVO.matePic3!=''){
					mateImgTag += '<div><img class="mate_img" id="'+result.mwVO.matePic3+'" name="matePic3" src="/home/matePic/'+result.mwVO.matePic3+'" alt="matePic3" onerror="this.src=\'/home/img/comm/no_mate_pic.png\'"/>';
					mateImgTag += '<span class="mate_imgDel">삭제</span></div>';
				}
				$('#mw_matePic').html(mateImgTag);
			}, error : function(){
				console.log(" mate DetailInfo 데이터가져오기 에러 ");
			}
		});
		//팝업보이기
		openPopup();
	});
	
});
</script>
</html>