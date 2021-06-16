<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	.admin_ul, .admin_ul>li{margin:0 0 20px 0; padding:0; list-style-type:none;}
	#subMenu{display:none;}
	.admin_login{width:400px; height:400px; margin:150px auto 0;}
	#admin_form{margin:50px 0 0 25px;}
	.admin_ul>li>label{width:80px; height:40px;}
	#admin_id, #admin_pwd{width:268px; height:40px;}
	#loginBtn{width:350px;}
</style>
<div class="admin_login">
	<div class="m_title managementTitle">관리자 로그인</div>
	<form method="post" action="/home/admin/loginOk" id="admin_form">
		<ul class="admin_ul">
			<li><label>아이디</label>
			<input type="text" name="userid" id="admin_id" autocomplete="off"/></li>
			<li><label>비밀번호</label>
			<input type="password" name="userpwd" id="admin_pwd"/></li>
			<li><button class="btn btn-custom" id="loginBtn">로그인</button></li>
		</ul>
	</form>
</div>
</body>
</html>