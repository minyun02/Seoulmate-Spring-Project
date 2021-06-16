<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/choi.css"/>
<script>
	$(function(){
		$("#memNext1").click(function(){
			// 변경할 비밀번호 정규식 표현
			if($("#userpwd").val()!=""){
				if(regExpCheck()!=false){
					// 비밀번호 확인 유효성 검사
					if($("#userpwd").val()!=$("#userpwd2").val()){
						alert("비밀번호가 다릅니다.");
						return false;
					}
				}else{
					return false;
				}
			}
						
			// 프로필 사진 유효성 검사
			var reg=document.getElementById("profilePic").getAttribute('type');
			if(reg=='file'){
				var fileCheck = document.getElementById("profilePic").value;
				if(!fileCheck){
					alert("프로필 사진을 첨부해 주세요");
					return false;
				}
			}
			
			// 희망 지역1
			var area1=$("#gu1Edit").val();
			// alert(area1);
			if(area1=="구를 선택해주세요"){
				area1="";
			}else{
				area1+=" "+$("#dong1Edit").val();
			}
			document.getElementById("area1Edit").value=area1;
			
			// 희망 지역2
			var area2=$("#gu2Edit").val();
			// alert(area2);
			if(area2=="구를 선택해주세요"){
				area2="";
			}else{
				area2+=" "+$("#dong2Edit").val();
			}
			document.getElementById("area2Edit").value=area2;
			
			// 희망 지역3
			var area3=$("#gu3Edit").val();
			
			// alert(area3);
			if(area3=="구를 선택해주세요"){
				area3="";
			}else{
				area3+=" "+$("#dong3Edit").val();
			}
			document.getElementById("area3Edit").value=area3;
			
			// 희망 지역 유효성 검사
			if($("#area1Edit").val()==null || $("#area1Edit").val()==""){
				alert("희망 지역1을 선택하세요.\r\n(하우스인 경우 등록할 하우스의 지역을 선택해주세요.)");
				return false;
			}
			if($("#area3Edit").val()!=null && $("#area3Edit").val()!=""){
				if($("#area2Edit").val()==null || $("#area2Edit").val()==""){
					alert("희망 지역2를 선택하세요.");
					return false;
				}
			}
			
			if(emailExp()==false){ // 이메일 인증 통과를 위한 함수
				return false;
			}
			areaEdit(); // 희망 지역 수정을 위한 함수
		});
		
		function emailExp(){
			var emailResult=$("#emailResult").val();
			
			if(emailResult=='Y'){
				return true;
			}else{
				alert("이메일을 변경하려면 이메일 인증에 통과해야 합니다.\r\n이메일 인증 번호를 다시 보내주세요.");
				return false;
			}
		}
		
		// 희망 지역 수정
		$("select.selectGu").change(function(){
			var temp=$(this);
			var url="memberDong";
			var params="gu="+$(this).val();
			$.ajax({
				url:url,
				data:params,
				success:function(result){
					var $result=$(result);
					
					temp.next().text("");
					$result.each(function(idx, dong){
						temp.next().append("<option>"+dong+"</option>");
					});
				}, error:function(){
					console.log("동 들고오기 에러 발생");
				}
			});
		});
				
		// 이메일
		$("#emailBtn").click(function(){
			if(regEmail()==false){
				return false;
			}else{
				$("#emailResult").val("N"); // 인증 번호 전송을 누르면 인증 확인이 풀림
				var emailid=document.getElementById("emailid").value;
				var emaildomain=document.getElementById("emaildomain").value;
				var email=emailid+"@"+emaildomain;
				
				var url="emailCheck";
				var params="email="+email;
				
				$.ajax({
					url:url,
					data:params,
					success:function(result){
						if(result=="fail"){ // 이메일이 중복인 경우
							alert("중복된 이메일입니다.");
							console.log("이메일 전송 X");
						}else{ // 이메일이 중복되지 않은 경우
							alert("인증 번호가 전송되었습니다.");
							console.log("이메일 전송 O");
							$("#emailBtn").css("display", "none"); // 인증 번호 전송을 누르면 숨김
							$("#emailCheck").attr("disabled", false); // 인증 번호 전송을 누르면 인증란이 열림
							$("#emailResult").val("N");
							$("#emailCheckBtn").css("display", "block");
							$("#emailCheck").attr("placeholder", "인증 번호를 입력해주세요");
						}
					}, error:function(){
						console.log("ajax 에러 발생");
					}
				});
			}
		});
		
		// 이메일 아이디를 변경하면 인증 확인이 풀림
		$("#emailid").change(function(){
			$("#emailResult").val("N");
			$("#emailBtn").css("display", "block");
			$("#emailCheck").attr("disabled", true);
			$("#emailCheck").attr("placeholder", "");
			$("#emailCheck").val("");
		});
		
		// 이메일 도메인을 변경하면 인증 확인이 풀림
		$("#emaildomain").change(function(){
			$("#emailResult").val("N");
			$("#emailBtn").css("display", "block");
			$("#emailCheck").attr("disabled", true);
			$("#emailCheck").attr("placeholder", "");
			$("#emailCheck").val("");
		});
		
		// 이메일 인증번호 확인
		$("#emailCheckBtn").click(function(){
			var emailNum=document.getElementById("emailCheck").value;
			
			if(emailNum==null || emailNum==""){
				alert("인증 번호를 입력해주세요.");
				return false;
			}else{
				var url="emailCheckResult";
				var params="emailCheckNum="+emailNum;
				$.ajax({
					url:url,
					data:params,
					success:function(result){
						if(result=="pass"){
							$("#emailResult").val("Y");
							alert("인증에 성공하였습니다.");
							$("#emailCheck").attr("disabled", true);
							$("#emailCheckBtn").css("display", "none");
							$("#emailCheck").val("인증 완료");
						}else{
							alert("인증 번호가 맞지 않습니다.");
							$("#emailResult").val("N");
						}
					}, error:function(){
						
					}
				});
			}
		});
		
		function regExpCheck(){
			// 비밀번호
			var regPwd=/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,15}$/;
			if(!regPwd.test(document.getElementById("userpwd").value)){
				alert("비밀번호는 영문과 숫자, 특수문자를 조합한 8~15자리여야 합니다.");
				return false;
			}
			// 연락처
			var regTel=/[0-9]{4}$/;
			if(!regTel.test(document.getElementById("tel2").value)){ // 중간 번호
				alert("연락처는 숫자를 4자리씩 입력해야 합니다.");
				return false;
			}
			if(!regTel.test(document.getElementById("tel3").value)){ // 끝 번호
				alert("연락처는 숫자를 4자리씩 입력해야 합니다.");
				return false;
			}
			// 이메일 아이디
			var regEmailId=/^\w{3,17}$/;
			if(!regEmailId.test(document.getElementById("emailid").value)){
				alert("이메일을 잘못 입력하셨습니다.");
				return false;
			}
		}
		
		function regEmail(){
			var regEmailId=/^\w{3,17}$/;
			if(!regEmailId.test(document.getElementById("emailid").value)){
				alert("이메일을 잘못 입력하셨습니다.");
				return false;
			}
		}
		
		// 프로필 사진
		$("#profilePic").on('change', function(){
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
		
		$("#profileDel").click(function(){
			$(this).parent().css('display', 'none');
			$(this).next().attr('name', "delFile");
			$("#profileOrg").css('display', 'none');
			$("#profileInput").css('display', 'block');
			$(this).parent().next().children('input').attr('type', 'file');
		});
	});
	
	// 희망 지역 1,2,3에 구,동 넣기
	function areaInput(){
		var a1=$("#area1Edit").val().indexOf(" "); // 희망 지역1의 띄어쓰기 위치 구하기
		var a2=$("#area2Edit").val().indexOf(" "); // 희망 지역2의 띄어쓰기 위치 구하기
		var a3=$("#area3Edit").val().indexOf(" "); // 희망 지역3의 띄어쓰기 위치 구하기
		
		// alert(typeof a1); // 변수의 데이터 타입을 확인
		
		if(a1!=-1){ // 희망 지역 1이 있을 때
			var gu1=$("#area1Edit").val().substring(0,a1);
			var dong1=$("#area1Edit").val().substring(a1+1);
			$("#gu1Edit>option[value='"+gu1+"']").attr('selected', true);
// 			$("#dong1Edit").append("<option value='"+dong1+"' selected>"+dong1+"</option>");
			$("#dong1Edit>option[value='"+dong1+"']").attr('selected', true);
		}
		if(a2!=-1){ // 희망 지역 2가 있을 때
			var gu2=$("#area2Edit").val().substring(0,a2);
			var dong2=$("#area2Edit").val().substring(a2+1);
			$("#gu2Edit>option[value='"+gu2+"']").attr('selected', true);
// 			$("#dong2Edit").append("<option value='"+dong2+"' selected>"+dong2+"</option>");
			$("#dong2Edit>option[value='"+dong2+"']").attr('selected', true);
		}
		if(a3!=-1){ // 희망 지역 3이 있을 때
			var gu3=$("#area3Edit").val().substring(0,a3);
			var dong3=$("#area3Edit").val().substring(a3+1);
			$("#gu3Edit>option[value='"+gu3+"']").attr('selected', true);
// 			$("#dong3Edit").append("<option value='"+dong3+"' selected>"+dong3+"</option>");
			$("#dong3Edit>option[value='"+dong3+"']").attr('selected', true);
		}
	}
	
	$(window).ready(function(){
		areaInput();
		
	});
	
	// 전화번호 앞자리 넣기
	function tel1Input(){
		var tel1='${vo.tel1}';
		$("#tel1>option[value='"+tel1+"']").attr('selected', true);
		
	}
	
	function areaEdit(){
		var gu1=$("#gu1Edit").val();
		var dong1=$("#dong1Edit").val();
		var gu2=$("#gu2Edit").val();
		var dong2=$("#dong2Edit").val();
		var gu3=$("#gu3Edit").val();
		var dong3=$("#dong3Edit").val();
		
		if(dong1!="동을 선택해주세요"){
			document.getElementById("area1Edit").value=gu1+" "+dong1;
		}
		if(dong2!="동을 선택해주세요"){
			document.getElementById("area2Edit").value=gu2+" "+dong2;
		}
		if(dong3!="동을 선택해주세요"){
			document.getElementById("area3Edit").value=gu3+" "+dong3;
		}
		
	}
	
	$(window).ready(function(){
		tel1Input();
	});
</script>
<div class="wrap">
	<div class="title_wrap editDiv">
		<p class="s_title">회원정보 수정</p>
	</div>
	<form method="post" id="memId" action="memberEditOk" enctype="multipart/form-data">
		<div id="memDiv1">
			<ul class="form_box choice" id="mem">
				<li><label>아이디</label>
					<input type="text" name="userid" id="Edituserid" value="${vo.userid}" disabled/>
				</li>
				<li><label>변경할 비밀번호</label>
					<input type="password" name="userpwd" id="userpwd" value=""/></li>
				<li><label>비밀번호 확인</label>
					<input type="password" id="userpwd2" value=""/></li>
				<li><label>이름</label>
					<input type="text" name="username" id="username" value="${vo.username}" disabled/></li>
				<li><label>연락처</label>
					<select name="tel1" id="tel1">
						<c:forEach var="i1" items="${arr1}">
							<option value="${i1}">${i1}</option>
						</c:forEach>
					</select>
					<span class="multi">-</span>
					<input type="text" name="tel2" id="tel2" value="${vo.tel2}" maxlength="4"/><span class="multi">-</span>
					<input type="text" name="tel3" id="tel3" value="${vo.tel3}" maxlength="4"/>
				</li>
				<li><label>생년월일</label>
					<input type="date" name="birth" id="birth" value="${vo.birth}" disabled/>
				</li>
				<li><label>성별</label>
					<div class="checks">
						<input type="radio" name="gender" id="gender1" value="1" <c:if test="${vo.gender==1}">checked</c:if> disabled/>
						<label for="gender1">여성</label>
						<input type="radio" name="gender" id="gender2" value="3" <c:if test="${vo.gender==3}">checked</c:if> disabled/>
						<label for="gender2">남성</label>
					</div>
				</li>
				<li id="proli"><label>프로필 사진</label>
					<div class="profile_div">
						<img class="profile_img" id="profileOrg" src="/home/profilePic/${vo.profilePic}" onerror="this.src='<%=request.getContextPath()%>/profilePic/basic.jpg'"/>
						<div>
							<img class="remove_icon" id="profileDel" src="/home/img/choi/trash-can.png"/>
							<input type="hidden" name="" value="${vo.profilePic}"/><br/>
						</div>
						<div style="display:none;" id="profileInput">
							<img class="profile_img" id="profileImg" name="profileImg" src="/home/img/choi/basic.png" alt="upload image"/><br/>
							<input type="hidden" accept="image/*" name="filename" id="profilePic" />
						</div>
					</div>
				</li>
				<li id="a1"><label>&nbsp;희망 지역1</label>
					<div id="area1Div">
						<select class="selectGu" id="gu1Edit">
							<option hidden>구를 선택해주세요</option>
							<c:forEach var="gu" items="${guArr}">
								<option value="${gu}">${gu}</option>
							</c:forEach>
						</select>
						<select id="dong1Edit">
							<option hidden>동을 선택해주세요</option>
							<c:forEach var="dong" items="${selDong1}">
								<option value="${dong}">${dong}</option>
							</c:forEach>
						</select>
					</div>
					<input type="hidden" name="area1" id="area1Edit" value="${vo.area1}" readonly/>
					<a class="white" id="area1Btn">지역1 수정</a>
				</li>
				<li id="a2"><label>&nbsp;희망 지역2</label>
					<div id="area2Div">
						<select class="selectGu" id="gu2Edit">
							<option hidden>구를 선택해주세요</option>
							<c:forEach var="gu" items="${guArr}">
								<option value="${gu}">${gu}</option>
							</c:forEach>
						</select>
						<select id="dong2Edit">
							<option hidden>동을 선택해주세요</option>
							<c:forEach var="dong" items="${selDong2}">
								<option value="${dong}">${dong}</option>
							</c:forEach>
						</select>
					</div>
					<input type="hidden" name="area2" id="area2Edit" value="${vo.area2}" readonly/>
					<a class="white" id="area2Btn">지역2 수정</a>
				</li>					
				<li id="a3"><label>&nbsp;희망 지역3</label>
				<div id="area3Div">
					<select class="selectGu" id="gu3Edit">
						<option hidden>구를 선택해주세요</option>
						<c:forEach var="gu" items="${guArr}">
							<option value="${gu}">${gu}</option>
						</c:forEach>
					</select>
					<select id="dong3Edit">
						<option hidden>동을 선택해주세요</option>
							<c:forEach var="dong" items="${selDong3}">
								<option value="${dong}">${dong}</option>
							</c:forEach>
					</select>
				</div>
					<input type="hidden" name="area3" id="area3Edit" value="${vo.area3}" readonly/>
					<a class="white" id="area3Btn">지역3 수정</a>
				</li>	
				<li><label>이메일</label>
					<input type="text" name="emailid" id="emailid" value="${vo.emailid}" placeholder="이메일" autocomplete="off"/><span>@</span> 
					<select name="emaildomain" id="emaildomain">
						<option value="naver.com" <c:if test="${vo.emaildomain=='naver.com'}">selected</c:if>>naver.com</option>
						<option value="nate.com" <c:if test="${vo.emaildomain=='nate.com'}">selected</c:if>>nate.com</option>
						<option value="hanmail.net" <c:if test="${vo.emaildomain=='hanmail.net'}">selected</c:if>>hamail.net</option>
						<option value="gmail.com" <c:if test="${vo.emaildomain=='gmail.com'}">selected</c:if>>gmail.com</option>
					</select>
					<a class="green" id="emailBtn">인증번호 전송</a>
				</li>
				<li>
					<label></label>
					<input type="text" name="emailCheck" id="emailCheck" value="" disabled placeholder=""/>
					<a class="green" id="emailCheckBtn">인증번호 확인</a>
					<input type="hidden" name="emailResult" id="emailResult" value="Y"/>
				</li>
				<li>
					<button class="q_btn green" id="memNext1">회원정보 수정</button>
				</li>
			</ul>
			
		</div>
	</form>
</div>
</body>
</html>