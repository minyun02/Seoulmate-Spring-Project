<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	//페이징
	function pageClick(state, grade, page, searchKey, searchWord){
		var f=document.go;
		f.state.value=state;
		f.grade.value=grade;
		f.pageNum.value=page; // post 방식을 넘길 값
		f.searchKey.value=searchKey; // post 방식을 넘길 값
		f.searchWord.value=searchWord; // post 방식을 넘길 값
		f.action="/home/admin/contactManagement"; // 이동할 페이지
		f.method="post"; // post 방식
		f.submit();
	}
	$(function(){
		//선택한 tr
		var selected = "";
		
		//필터 기능 
		$('select[name=grade]').change(function(){
			$('.managementSearchForm').submit();
		});
		$('select[name=state]').change(function(){
			$('.managementSearchForm').submit();
		});
		//검색창 리셋
		$("#contactSearchWord").click(function(){
			$("#contactSearchWord").val("");
		});
		
		//문의 상세보기
		$(".admin_contactManagement_DetailInfo").on('click', function(){
			selected = $(this);
			var params = 'no='+$(this).children().eq(0).text();
			var url = "/home/admin/contactDetailInfo"
			
			$.ajax({
				url : url,
				data : params,
				success : function(result){
					console.log(result)
					contactFormFill(result);
				},error : function(){
					alert("문의 데이터 에러");
				}
			});
		});
		//문의 상세보기 값 넣기
		function contactFormFill(result){
			$("#contactNo").val(result.no);
			$("#contactUserid").val(result.userid);
			$("#contactState").val(result.state);
			$('#contactMState').val(result.mState);
			$('#contactEmail').val(result.email);
			$('#contactCategory').val(result.category);
			$('#qDate').val(result.qdate);
			$('#qContent').val(result.qContent);
			$('#aContent').val(result.aContent);
			if(result.state=='답변완료'){
				$('#adate').text(result.adate);
				$('.contactUpdateSubmitBtn').css('display','none');
				
			}else{
				$('#adate').text("미답변 상태입니다.");
			}
			
			//팝업 열기
			$(".contact_wrap").css('display','block');
			$(document.body).css('overflow','hidden');
		}
		
		//답변하기
		$('#contactUpdateForm').submit(function(){
			$.ajax({
				url : '/home/admin/contactAdmin',
				data : $(this).serialize(),
				success : function(result){
					console.log(result)
					updateContactTable(result);
					alert("문의 답변이 완료되었습니다.");
				},error : function(){
					console.log("???")
				}
			});
			return false;
		});
		
		//문의처리하고 테이블 정보바꾸기
		function updateContactTable(state){
			//상태 수정
			if(state==1){
				$(selected).children().eq(7).css('color','black');
				$(selected).children().eq(7).text('답변완료');
				$('.contact_wrap').css('display','none');
			}
		}
	});
</script>
		<section class="admin_Section">
			<div class="admin_Content">
				<div class="m_title managementTitle">문의 관리</div>
				<form method="post" action="/home/admin/contactManagement" class="managementSearchForm">
					<div class="reportSearchCategory">
						<span class="reportSpan" id="categorySpan">분류</span>
						<select name=grade class="custom-select input">
							<option value="" selected>전체</option>
							<option value="쉐어하우스" <c:if test="${pVO.grade=='쉐어하우스'}">selected</c:if>>쉐어하우스</option>
							<option value="하우스메이트" <c:if test="${pVO.grade=='하우스메이트'}">selected</c:if>>하우스메이트</option>
							<option value="커뮤니티" <c:if test="${pVO.grade=='커뮤니티'}">selected</c:if>>커뮤니티</option>
							<option value="프리미엄 결제"<c:if test="${pVO.grade=='프리미엄 결제'}">selected</c:if>>프리미엄 결제</option>
							<option value="기타"<c:if test="${pVO.grade=='기타'}">selected</c:if>>기타</option>
						</select>
						<span class="reportSpan" id="stateSpan">답변 상태</span>
						<select name="state" class="custom-select">
							<option value="" selected>전체</option>
							<option value="미답변" <c:if test="${pVO.state=='미답변'}">selected</c:if>>미답변</option>
							<option value="답변완료" <c:if test="${pVO.state=='답변완료'}">selected</c:if>>답변완료</option>
						</select>
					</div>	
					<div class="reportSearch">
						<select name="searchKey" class="custom-select reportSearchKey">
							<option value="userid"<c:if test="${pVO.searchKey=='userid'}">selected</c:if>>아이디</option>
							<option value="username"<c:if test="${pVO.searchKey=='username'}">selected</c:if>>이름</option>
							<option value="email"<c:if test="${pVO.searchKey=='email'}">selected</c:if>>이메일</option>
						</select>
						<input type="text" id="contactSearchWord" name="searchWord" class="form-control" <c:if test="${pVO.searchWord!=null}">value="${pVO.searchWord}"</c:if>/>
						<input type="submit" value="Search" class="btn btn-custom"/>
					</div>
<!-- 					<div class="qnaSearch"> -->
<!-- 						<select name="searchKey" class="custom-select"> -->
<!-- 							<option selected>전체</option> -->
<!-- 							<option>쉐어하우스</option> -->
<!-- 							<option>하우스메이트</option> -->
<!-- 							<option>커뮤니티</option> -->
<!-- 							<option>프리미엄 결제</option> -->
<!-- 							<option>기타</option> -->
<!-- 						</select> -->
<!-- 						<input type="text" name="searchWord" class="form-control"/> -->
<!-- 						<input type="submit" value="Search" class="btn btn-custom"/> -->
<!-- 					</div> -->
				</form>
				
				<div class="table-responsive, managementList">
					<table class="table table-hover table-sm table-bordered">
						<thead class="thead-light">
							<tr>
								<th>No.</th>
								<th>카테고리</th>
								<th>아이디</th>
								<th>이름</th>
								<th>회원등급</th>
								<th>이메일</th>
								<th>등록일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="contact" items="${contact}">
								<tr class="admin_contactManagement_DetailInfo">
									<td>${contact.no}</td>
									<td>${contact.category}</td>
									<td>${contact.userid}</td>
									<td>${contact.username}</td>
									<td>${contact.mState}</td>
									<td>${contact.email}</td>
									<td>${contact.qdate}</td>
									<c:if test="${contact.state=='미답변'}">
										<td style="color:#007bff">${contact.state}</td>
									</c:if>
									<c:if test="${contact.state!='미답변'}">
										<td>${contact.state}</td>
									</c:if>	
								</tr>
							</c:forEach>	
						</tbody>
					</table>
					<div class="paging">
						<form name="go"> <!-- 자바스크립트로 submit 시키려면 form을 추가하고 name을 지정해야 한다. -->
							<input type="hidden" name="state" value="${state}"/>
							<input type="hidden" name="grade" value="${grade}"/>
							<input type="hidden" name="pageNum"/> <!-- 폼에 post로 값을 보내주기 위해 hidden -->
							<input type="hidden" name="searchKey"/> <!-- 폼에 post로 값을 보내주기 위해 hidden -->
							<input type="hidden" name="searchWord"/> <!-- 폼에 post로 값을 보내주기 위해 hidden -->
							<c:if test="${pVO.pageNum>1}">
							<c:if test="${pVO.searchWord==null}">
								<a class="first_page" href="contactManagement?pageNum=1"></a>
								<a class="prev_page" href="contacttManagement?pageNum=${pVO.pageNum-1}"></a>
							</c:if>
							
							<c:if test="${pVO.searchWord!=null}">
								<a href="javascript:pageClick('${state}', '${grade}', 1, '${pVO.searchKey}', '${pVO.searchWord}')" class="first_page"></a>
								<a href="javascript:pageClick('${state}', '${grade}', ${pVO.pageNum-1}, '${pVO.searchKey}', '${pVO.searchWord}')" class="prev_page"></a>
							</c:if>
							</c:if>
							<c:if test="${pVO.pageNum==1}">
								<a class="first_page"></a>
								<a class="prev_page"></a>
							</c:if>
							<c:forEach var="pageNum" begin="${pVO.startPageNum}" end="${pVO.startPageNum + pVO.onePageNum-1}">
								<c:if test="${pageNum<=pVO.totalPage }">
								<c:if test="${pVO.searchWord==null}">
									<c:if test="${pageNum==pVO.pageNum }"><!-- 1 -->
										<a href="contactManagement?pageNum=${pVO.pageNum}" class="nowPageNum on">${pageNum}</a>
									</c:if>
									<c:if test="${pageNum!=pVO.pageNum}">
										<a href="contactManagement?pageNum=${pageNum}">${pageNum}</a>
									</c:if>
								</c:if>
								<c:if test="${pVO.searchWord!=null}"><!-- 2 -->
									<c:if test="${pageNum==pVO.pageNum }">
										<a href="javascript:pageClick('${state}', '${grade}', ${pageNum}, '${pVO.searchKey}', '${pVO.searchWord}')" class="nowPageNum on">${pageNum}</a>
									</c:if>
									<c:if test="${pageNum!=pVO.pageNum }">
										<a href="javascript:pageClick('${state}', '${grade}', ${pageNum}, '${pVO.searchKey}', '${pVO.searchWord}')">${pageNum}</a>
									</c:if>
								</c:if>
								</c:if>
							</c:forEach>
							<c:if test="${pVO.pageNum < pVO.totalPage}">
								<c:if test="${pVO.searchWord==null}"> <!-- 검색어가 없는 경우 -->
									<a class="next_page" href="contactManagement?pageNum=${pVO.pageNum+1}"></a>
									<a class="last_page" href="contactManagement?pageNum=${pVO.totalPage}"></a>
								</c:if>
								<c:if test="${pVO.searchWord!=null}"> <!-- 검색어가 있는 경우 -->
									<a class="next_page" href="javascript:pageClick('${state}', '${grade}', ${pVO.pageNum+1}, '${pVO.searchKey}', '${pVO.searchWord}')" class="next_page"></a>
									<a class="last_page" href="javascript:pageClick('${state}', '${grade}', ${pVO.totalPage}, '${pVO.searchKey}', '${pVO.searchWord}')" class="last_page"></a>
								</c:if>
							</c:if>
							<c:if test="${pVO.totalPage==0}">
								<a class="nowPageNum on">1</a>
							</c:if>
							<c:if test="${pVO.pageNum == pVO.totalPage || pVO.totalPage == 0}">
								<a class="next_page"></a>
								<a class="last_page"></a>
							</c:if>
						</form>
					</div>
				</div>
			</div>
		</section>
<!-- 팝업창*********************************************** -->
		<div class="contact_wrap">
			<div class="contact_form">
				<div class="contact_head">문의 관리</div>
				<div class="contact_pup_body">
					<div class="contact_list">
						<form post="post"id="contactUpdateForm">
							<ul class="readonlyDiv">
								<li><div>아이디</div><input id="contactUserid" type="text" name="userid" readonly></li>
								<li><div>회원등급</div><input id="contactMState" type="text" name="mState" readonly></li>
							</ul>
							<ul class="readonlyDiv">	
								<li><div>답변상태</div>
									<input id="contactState" type="text" name="state" readonly>
								</li>
								<li><div>이메일</div><input id="contactEmail" type="text" name="email" readonly></li>
							</ul>
							<ul class="readonlyDiv">
								<li><div id="divGap">문의 분류</div> <input id="contactCategory" type="text" name="category" readonly></li>
								<li><div>문의 날짜</div> <input id="qDate" type="text" name="qdate" readonly> </li>
							</ul>
							<ul>	
								<li><div>문의 내용</div> <textarea id="qContent" rows="5" name="qContent" readonly></textarea></li>
								<li><div>답변 내용</div> <textarea id="aContent" rows="5" name="aContent"></textarea></li>
							</ul>
							답변 날짜 : <span id="adate"></span><input id="contactNo" type="hidden" name="no">
						</form>	
					</div>
				</div>
				<div class="pup_bottom">
					<a href="" class="btn_cancel">닫기</a>
					<a href="javascript:$('#contactUpdateForm').submit()" class="btn_reply contactUpdateSubmitBtn">답변하기</a>
				</div>
				<a href="" class="pup_btn_close">닫기</a>
			</div>
		</div>
	</body>
</html>