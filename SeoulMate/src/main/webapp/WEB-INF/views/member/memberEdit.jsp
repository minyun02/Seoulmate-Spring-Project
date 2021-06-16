<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/choi.css"/>
<script>
	function exitCheck(){
		if(${pwdCheck=='불일치'}){
			alert("비밀번호를 정확하게 입력해주세요.");
		}
	}
	exitCheck();
	function pwdCheck(e){
		if($("#userpwd").val()==""){
			alert("비밀번호를 입력하세요");
			return false;
		}
		if(e.id=='memberExitForm'){
			if(confirm("탈퇴하시겠습니까?")){
				return true;
			}else{
				return false;
			}
		}
	}
	function notPwd(){
		if('${notPwd}'=='1'){
			alert("비밀번호가 맞지 않습니다.");
		}
	}
	notPwd();
</script>
<div class="wrap">
	<div class="member_wrap">
		<div class="title_wrap">
			<p class="s_title">회원정보 수정</p>
		</div>
		<br/><br/>
		<div class="title_wrap">
			<form id="memberEditForm" method="post" action="memberEditCheck" onsubmit="return pwdCheck(this)">
				<label>비밀번호</label>
				<input type="password" name="userpwd" id="userpwdCheck" maxlength="12" placeholder="비밀번호를 입력해주세요"/>
				<div class="center">
					<button class="h_btn green" id="editBtn">회원정보 수정하기</button>
				</div>
			</form>
		</div>
		<div class="title_wrap">
			<p class="s_title s_marginTop">회원 탈퇴</p>
		</div>
		<br/><br/>
		<div class="title_wrap">
			<form id="memberExitForm"method="post" action="memberExitOk" id="memberExitForm" onsubmit="return pwdCheck(this)">
				<label>비밀번호</label>
				<input type="password" name="userpwd" id="userpwdCheck" maxlength="12" placeholder="비밀번호를 입력해주세요"/>
				<div class="center">
					<button class="h_btn green" id="editBtn">회원 탈퇴하기</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>