<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	body{overflow:hidden;}
	.wrap{margin:0; padding:25px; min-height:0; overflow:hidden;}
	.wrap>.s_title{margin:10px 0 20px 0; font-size:1.2em;}
	.form_box.choice li>label{width:80px;}
	.header_wrap, .foot_wrap, .chat_wrap{display:none;}
	#l_margin{margin-left:120px;}
</style>
<script>
	$(function(){
		$("#setId").click(function(){
			opener.document.getElementById("userid").value=$("#checkId").text();
			opener.document.getElementById("hiddenCheck").value="Y";
			window.close();
		});
		
		$("#idFrame").submit(function(){
			if($("#userid").val()==""){
				alert("아이디를 입력 후 중복 검사 버튼을 눌러주세요");
				return false;
			}
			if(regExpCheck()==false){
				return false;
			}
		});
	});
	function regExpCheck(){
		// 아이디
		var regId=/^[a-zA-Z]{1}[a-zA-Z0-9]{5,11}$/;
		if(!regId.test(document.getElementById("userid").value)){
			alert("아이디는 영문과 숫자를 조합한 6~12자리여야 합니다.");
			return false;
		}
	}
</script>

<div class="wrap">
	<c:if test="${checkResult==0}"> <!-- 가입된 아이디가 없는 경우 -->
		<div class="member_wrap">
			<label><span class="red_txt" id="checkId">${userid}</span>은 사용가능한 아이디입니다.</label>
			<button class="green" id="setId">아이디 사용하기</button>
		</div>
	</c:if>
	<c:if test="${checkResult>0}"> <!-- 가입된 아이디가 있는 경우 -->
		<div class="member_wrap">
			<label><span>${userid}</span>은 사용 불가능한 아이디입니다.</label>
		</div>
	</c:if>
	<c:if test="${checkResult>0}">
		<br/>
	</c:if>
	<p class="s_title" id="l_margin">아이디를 입력 후 중복 검사 버튼을 누르세요</p>
	<div class="member_wrap">
		<form method="post" id="idFrame" action="idCheck">
			<ul class="form_box choice">
				<li><label>아이디</label>
					<input type="text" name="userid" id="userid" maxlength="12" placeholder="영문과 숫자를 조합한 6~12자리"/>
					<button class="green">아이디 중복 확인</button>
				</li>
			</ul>
		</form>
	</div>
</div>
</body>
</html>