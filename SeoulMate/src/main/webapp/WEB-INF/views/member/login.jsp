<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	userCheck();
	// 로그인 계정 검사
	function userCheck() {
		if ('${logState}' == '블랙') {
			alert('정지된 계정입니다. 관리자에게 문의해주세요.');
		}else if('${logState}' == '탈퇴'){
			alert('탈퇴한 계정입니다.');
		}else if('${logState}' == 'fail'){
			console.log('${logState}');
			alert('아이디 혹은 비밀번호가 맞지 않습니다.');
		}
	}
	
	$(function() {
		$('form').submit(function () {
			if($("#userid").val()==""){
				alert("아이디를 입력하세요");
				return false;
			}
			if($("#userpwd").val()==""){
				alert("비밀번호를 입력하세요");
				return false;
			}
			return true;
		});
	});
</script>
<div class="member_wrap login_wrap wrap">
	<p class="m_title">로그인</p>
	<p class="d_title">로그인 하시면 더 많은 서비스를 즐길 수 있어요!</p>
	<form method="post" action="loginOk">
		<ul class="form_box">
			<li>
				<input type="text" id="userid" name="userid" placeholder="아이디를 입력해주세요"/> 
			</li>
			<li>
				<input type="password" id="userpwd" name="userpwd" placeholder="비밀번호를 입력해주세요"/> 
			</li>
		</ul>
		<button type="submit" class="q_btn green">로그인</button>
	</form>
	<hr>
	<a class="white" href="memberForm">회원가입</a>
	<a class="white" href="memberFind">아이디/비밀번호 찾기</a>
</div>
