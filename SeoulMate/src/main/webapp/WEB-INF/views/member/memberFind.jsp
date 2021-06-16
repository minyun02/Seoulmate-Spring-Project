<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/choi.css"/>
<script>
	function memberCheck(e){
		if(e.id=="memberFindId"){
			if($("#usernameCheck").val()==""){
				alert("이름을 입력하세요");
				return false;
			}
			if($("#idEmailCheck").val()==""){
				alert("이메일을 입력하세요");
				return false;
			}else{
				if(regExpId()!=false){
					return true;
				}else{
					return false;
				}
			}
		}else{
			if($("#useridCheck").val()==""){
				alert("아이디를 입력하세요");
				return false;
			}
			if($("#pwdEmailCheck").val()==""){
				alert("이메일을 입력하세요");
				return false;
			}else{
				if(regExpPwd()!=false){
					return true;
				}else{
					return false;
				}
			}
		}
	}
	function findResultId(){
		var id="${findId}";
		var idSubstring=id.substring(0,3);
		if("${findId}"!=""){ // 찾은 아이디가 있을 경우
			alert("아이디는 "+idSubstring+"***입니다.");
		}
		if("${findNotId}"=="no"){ // 찾은 아이디가 없는 경우
			alert("아이디를 찾을 수 없습니다.");
		}
	}
	findResultId();
	function regExpId(){
		var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if(!regEmail.test(document.getElementById("idEmailCheck").value)){
			alert("이메일 형식은 아이디@도메인 입니다.");
			return false;
		}
	}
	function regExpPwd(){
		var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if(!regEmail.test(document.getElementById("pwdEmailCheck").value)){
			alert("이메일 형식은 아이디@도메인 입니다.");
			return false;
		}
	}
	$(function(){
		$("#pwdEmailCheckBtn").click(function(){
			if(regExpPwd()==false){
				return false;
			}else{
				var userid=document.getElementById("useridCheck").value;
				var email=document.getElementById("pwdEmailCheck").value;
				
				var url="pwdFind";
				var params="userid="+userid+"&email="+email;
				
				$.ajax({
					url:url,
					data:params,
					success:function(result){
						if(result=="pass"){
							alert("이메일이 전송되었습니다.");
						}else{
							alert("아이디나 이메일을 잘못 입력하셨습니다.");
							return false;
						}
						console.log("이메일 송신 성공");
					}, error:function(){
						console.log("이메일 송신 실패");
					}
				});
			}
		});
	});
</script>
<div class="wrap">
	<div class="member_wrap">
		<div class="title_wrap">
			<p class="s_title margin-bottom50 margin-top50">아이디 찾기</p>
		</div>
		<div class="title_wrap">
			<form method="post" id="memberFindId" action="memberFindId" onsubmit="return memberCheck(this)">
				<label>이름</label>
				<input type="text" name="username" id="usernameCheck" maxlength="4" placeholder="이름을 입력해주세요"/>
				<label>이메일</label>
				<input type="text" name="email" id="idEmailCheck" placeholder="이메일을 입력해주세요"/>
				<div class="center" id="idFindBtn">
					<button class="h_btn green" id="FindIdBtn">아이디 찾기</button>
				</div>
			</form>
		</div>
		<hr/>
		<div class="title_wrap">
			<p class="s_title margin-bottom50 margin-top50">비밀번호 찾기</p>
		</div>
		<div class="title_wrap">
			<form method="post" id="memberFindPwd" action="memberFindPwd" onsubmit="return memberCheck(this)">
				<label>아이디</label>
				<input type="text" name="userid" id="useridCheck" placeholder="아이디를 입력해주세요"/><br/>
				<label>이메일</label>
				<input type="text" name="email" id="pwdEmailCheck" placeholder="이메일을 입력해주세요"/>
				<div class="center">
					<a class="h_btn green" id="pwdEmailCheckBtn">전송</a>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>