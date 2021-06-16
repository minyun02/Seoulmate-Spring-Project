<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	// 테이블의 행 클릭 시 팝업 이벤트
	$(function(){
		// 회원정보 수정 후 회원 목록의 값을 업데이트 해주기 위해 저장하는 변수들
		var select;
		
		$("#tableMain>tr").click(function(){
			select=$(this);
			$("#memberInfo").css("display", "block");
			$(document.body).css("overflow","hidden");
			$('.pup_body').scrollTop(0);
			var selectId=$(this).children().eq(1).text(); // 선택한 행의 userid
			
			var url="/home/admin/memberInfo";
			var params="userid="+selectId;
			$.ajax({
				url:url,
				data:params,
				success:function(data){
					var info=[data.userid, data.userpwd, data.username, data.birth, data.tel, data.email, data.reportCnt, data.state];
					$("#profileImg").attr('src', "/home/profilePic/"+data.profilePic);
					$("#delFile").attr('value', data.profilePic);
					for(var i=1; i<=7; i++){
						$("ul>li").eq(i).children('input').attr('value', info[i-1]);	
					}
					
					if(data.state=='블랙'){
						$("ul>li").eq(8).children('.toggle_cont').children('input[name=state]').prop('checked', true);
					}else{
						$("ul>li").eq(8).children('.toggle_cont').children('input[name=state]').prop('checked', false);
					}
				}, error:function(){
					console.log("회원 관리에서 회원 정보 가져오기 실패");
				}
			});
		});
		// 이름 고치려했던거 알려줌
		$("#infoName").change(function(){
			var afterName=document.getElementById("infoName").value;
			$(document.getElementById("infoName")).css('backgroundColor','#F0F0F0');
		});
		
		// 연락처 고치려했던거 알려줌
		$("#infoTel").change(function(){
			var afterName=document.getElementById("infoTel").value;
			$(document.getElementById("infoTel")).css('backgroundColor','#F0F0F0');
		});
		
		// 이메일 고치려했던거 알려줌
		$("#infoEmail").change(function(){
			var afterName=document.getElementById("infoEmail").value;
			$(document.getElementById("infoEmail")).css('backgroundColor','#F0F0F0');
		});
		
		// 팝업창 닫기 이벤트
		$(".pup_btn_close, #btnClose").click(function(){
			pupClose();
		});
		
		$("#InfoSaveBtn").click(function(){
			// 이름 정규식 표현
			var regName=/^[가-힣]{2,4}$/;
			if(!regName.test(document.getElementById("infoName").value)){
				$("#infoName").focus();
				alert("이름은 한글 2~4자리여야 합니다.");
				return false;
			}
			
			// 연락처 정규식 표현
			var regTel=/(010|02|031|032|033|041|042|043|051|052|053|061|062|063)[-][0-9]{3,4}[-][0-9]{4}/;
			if(!regTel.test(document.getElementById("infoTel").value)){
				$("#infoTel").focus();
				alert("전화번호 형식에 맞게 입력해주세요");
				return false;
			}
			
			// 이메일 정규식 표현
			var regEmail=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			if(!regEmail.test(document.getElementById("infoEmail").value)){
				$("#infoEmail").focus();
				alert("이메일을 잘못 입력하셨습니다.");
				return false;
			}
			var form=$("#memInfoForm")[0]; // 폼을 변수에 담음
			var url="/home/admin/memInfoSave";
			var params=new FormData(form); // 변수에 담은 폼을 FormData 객체로 만들어 데이터로 넣음
			
			$.ajax({
				url:url,
				data:params,
				dataType:'json',
				enctype: 'multipart/form-data',
				contentType : false,
		        processData : false, 
				type:"POST",
				success:function(result){
					console.log("성공 : "+result);
					$("#memberInfo").css("display","none");
// 					var uname=document.getElementById("infoName").value;
					var uname=$("#infoName").val();
// 					var utel=document.getElementById("infoTel").value;
					var utel=$("#infoTel").val();
// 					var uemail=document.getElementById("infoEmail").value;
					var uemail=$("#infoEmail").val();
					var ustate=$("#infoState").is(":checked");
					if(ustate==false){
						ustate='일반';
					}else{
						ustate='블랙리스트';
					}
					select.children().eq(2).html(uname);
					select.children().eq(3).html(utel);
					select.children().eq(4).html(uemail);
					select.children().eq(7).html(ustate);
				}, error:function(err){
					console.log("에러 : "+err.responseText);
				}
			});
			// 팝업창이 닫히면서 수정하려했던 input들의 배경색을 다시 원래대로 되돌림
			$(document.getElementById("infoName")).css('backgroundColor', '');
			$(document.getElementById("infoTel")).css('backgroundColor', '');
			$(document.getElementById("infoEmail")).css('backgroundColor', '');
		});
		
		// 검색창을 누르면 값을 지워준다.
		$("#searchWord").click(function(){
			$("#searchWord").val("");
		});
		
		// 등급 필터
		$("#member_grade").change(function(){
			$("#memberForm").submit();
		});
		
		// 상태 필터
		$("#member_state").change(function(){
			$("#memberForm").submit();
		});
		
		// 프로필 사진
		$("#profilePic").on('change', function(){
			$("#delFile").attr('name', 'delFile');
			readURL(this);
		});
		
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function (e) {
					$('#profileImg').attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
	});
	function pupClose(){
		$("#memberInfo").css("display", "none");
		$(document.body).css("overflow","visible");
		for(var i=1; i<=7; i++){
			$("ul>li").eq(i).children().eq(1).attr("value","");
		}
		$("ul>li").eq(8).children('.toggle_cont').children('input[name=state]').prop('checked', false);
		// 팝업창을 닫으면서 수정하려했던 input들의 배경색을 다시 원래대로 되돌림
		$(document.getElementById("infoName")).css('backgroundColor', '');
		$(document.getElementById("infoTel")).css('backgroundColor', '');
		$(document.getElementById("infoEmail")).css('backgroundColor', '');
	}
	function pageClick(state, grade, page, searchKey, searchWord){
		var f=document.go;
		f.state.value=state;
		f.grade.value=grade;
		f.pageNum.value=page; // post 방식을 넘길 값
		f.searchKey.value=searchKey; // post 방식을 넘길 값
		f.searchWord.value=searchWord; // post 방식을 넘길 값
		f.action="/home/admin/memberManagement"; // 이동할 페이지
		f.method="post"; // post 방식
		f.submit();
	}
</script>
	<section>
		<div class="admin_Content">
			<div class="m_title managementTitle">회원 관리</div>
			<form method="post" id="memberForm" action="/home/admin/memberManagement" class="managementSearchForm">
				<div class="management_memberSearch">
					<div class="management_memberSelect">
						<span class="managementSpan" id="gradeSpan">등급</span>
						<select name="grade" id="member_grade" class="custom-select">
							<option value="0" <c:if test="${grade==0}">selected</c:if>>전체</option>						
							<option value="1" <c:if test="${grade==1}">selected</c:if>>일반</option>						
							<option value="2" <c:if test="${grade==2}">selected</c:if>>프리미엄</option>						
						</select>
						<span class="managementSpan" id="stateSpan">상태</span>
						<select name="state" id="member_state" class="custom-select">
							<option value="" <c:if test="${state==null}">selected</c:if>>전체</option>						
							<option value="일반" <c:if test="${state=='일반'}">selected</c:if>>일반</option>						
							<option value="블랙" <c:if test="${state=='블랙'}">selected</c:if>>블랙리스트</option>						
							<option value="탈퇴" <c:if test="${state=='탈퇴'}">selected</c:if>>탈퇴</option>						
						</select>
					</div>
					<div class="managementSearch">
						<select name="searchKey" class="custom-select">
							<option value="userid" <c:if test="${pVO.searchKey=='userid'}">selected</c:if>>아이디</option>
							<option value="username" <c:if test="${pVO.searchKey=='username'}">selected</c:if>>이름</option>
							<option value="tel" <c:if test="${pVO.searchKey=='tel'}">selected</c:if>>연락처</option>
							<option value="email" <c:if test="${pVO.searchKey=='email'}">selected</c:if>>이메일</option>
						</select>
						<input type="text" id="searchWord" name="searchWord" class="form-control" <c:if test="${pVO.searchWord!=null}">value="${pVO.searchWord}"</c:if>/>
						<input type="submit" value="Search" class="btn btn-custom"/>
					</div>
				</div>
				
			</form>
			<div class="table-responsive, managementList">
				<table class="table table-hover table-sm table-bordered" id="memberTable">
					<thead class="thead-light">
						<tr>
							<th width="7%">No.</th>
							<th width="13%">아이디</th>
							<th width="11%">이름</th>
							<th width="14%">연락처</th>
							<th width="25%">이메일</th>
							<th width="10%">등급</th>
							<th width="10%">신고 누적 수</th>
							<th width="10%">상태</th>
						</tr>
					</thead>
					<tbody id="tableMain">
						<c:forEach var="vo" items="${list}">
							<tr>
								<td>${vo.no}</td>
								<td>${vo.userid}</td>
								<td>${vo.username}</td>
								<td>${vo.tel}</td>
								<td>${vo.email}</td>
								<td><c:if test="${vo.grade==1}">일반</c:if><c:if test="${vo.grade==2}">프리미엄</c:if></td>
								<td>${vo.reportCnt}</td>
								<td><c:if test="${vo.state=='일반'}">일반</c:if><c:if test="${vo.state=='블랙'}">블랙리스트</c:if><c:if test="${vo.state=='탈퇴'}">탈퇴</c:if></td>
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
							<a class="first_page" href="memberManagement?pageNum=1"></a>
							<a class="prev_page" href="memberManagement?pageNum=${pVO.pageNum-1}"></a>
						</c:if>
						<c:if test="${pVO.searchWord!=null}">
							<a href="javascript:pageClick('${state}', ${grade}, 1, '${pVO.searchKey}', '${pVO.searchWord}')" class="first_page"></a>
							<a href="javascript:pageClick('${state}', ${grade}, ${pVO.pageNum-1}, '${pVO.searchKey}', '${pVO.searchWord}')" class="prev_page"></a>
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
									<a href="memberManagement?pageNum=${pVO.pageNum}" class="nowPageNum on">${pageNum}</a>
								</c:if>
								<c:if test="${pageNum!=pVO.pageNum}">
									<a href="memberManagement?pageNum=${pageNum}">${pageNum}</a>
								</c:if>
							</c:if>
							<c:if test="${pVO.searchWord!=null}"><!-- 2 -->
								<c:if test="${pageNum==pVO.pageNum }">
									<a href="javascript:pageClick('${state}', ${grade}, ${pageNum}, '${pVO.searchKey}', '${pVO.searchWord}')" class="nowPageNum on">${pageNum}</a>
								</c:if>
								<c:if test="${pageNum!=pVO.pageNum }">
									<a href="javascript:pageClick('${state}', ${grade}, ${pageNum}, '${pVO.searchKey}', '${pVO.searchWord}')">${pageNum}</a>
								</c:if>
							</c:if>
							</c:if>
						</c:forEach>
						<c:if test="${pVO.pageNum < pVO.totalPage}">
							<c:if test="${pVO.searchWord==null}"> <!-- 검색어가 없는 경우 -->
								<a class="next_page" href="memberManagement?pageNum=${pVO.pageNum+1}"></a>
								<a class="last_page" href="memberManagement?pageNum=${pVO.totalPage}"></a>
							</c:if>
							<c:if test="${pVO.searchWord!=null}"> <!-- 검색어가 있는 경우 -->
								<a class="next_page" href="javascript:pageClick('${state}', ${grade}, ${pVO.pageNum+1}, '${pVO.searchKey}', '${pVO.searchWord}')" class="next_page"></a>
								<a class="last_page" href="javascript:pageClick('${state}', ${grade}, ${pVO.totalPage}, '${pVO.searchKey}', '${pVO.searchWord}')" class="last_page"></a>
							</c:if>
						</c:if>
						<c:if test="${pVO.totalPage == 0}">
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
	<!--  팝업창///////////////////////////////////////////// -->
	<div class="pup_wrap" id="memberInfo">
		<div class="pup_form">
			<div class="pup_head">회원 정보</div>
			<form method="post" id="memInfoForm" enctype="multipart/form-data"> <!-- action="memInfoSave" -->
				<div class="pup_body">
					<div class="pup_list">
							<ul>
								<li class="pup_long"><div>프로필 사진</div>
									<img class="profile_img" id="profileImg" name="profileImg" src="" onerror="this.src='<%=request.getContextPath()%>/profilePic/basic.jpg'" alt="upload image"/>
									<input id="delFile" type="hidden" name="" value=""/>
									<input class="profile_input profile_left" type="file" accept="image/*" name="filename" id="profilePic" />
								</li>
								<li><div>아이디</div><input type="text" name="userid" id="infoId" value="" readonly/></li>
								<li><div>비밀번호</div><input type="text" name="userpwd" id="infoPwd" value="" readonly/></li>
								<li><div>*이름</div><input type="text" name="username" id="infoName" value="" autocomplete="off"/></li>
								<li><div>생년월일</div><input type="text" name="birth" id="infoBirth" value="" readonly/></li>
								<li><div>*연락처</div><input type="text" name="tel" id="infoTel" value="" maxlength="13"/></li>
								<li><div>*email</div><input type="text" name="email" id="infoEmail" value="" autocomplete="off"/></li>
								<li><div>신고 누적 수</div><input type="text" id="infoReportCnt" value="" readonly/></li>
								<li><div>*블랙리스트</div>
									<div class="toggle_cont">
										<input id="infoState" class="cmn_toggle cmn_toggle_round" type="checkbox" name="state">
										<label for="infoState"></label>
									</div><br>
								</li>
							</ul>
						
					</div>
				</div>
				<div class="pup_bottom">
					<a class="btn btn-custom" id="InfoSaveBtn">수정</a>
					<a class="btn btn-custom" id="btnClose">닫기</a>
				</div>
			</form>
			<a class="pup_btn_close">닫기</a>
		</div>
	</div>
</body>
</html>