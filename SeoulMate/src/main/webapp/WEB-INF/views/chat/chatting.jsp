<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>SEOULMATE</title>
		<meta name="viewport" content="width=device-width, initial-scale=1"/>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reset.css">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/comm.css">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/main/comm.js"></script>
	</head>
<body>
	<div class="chat_wrap">
		<div class="chat_window">
			<div class="chat_head">
				<p>김두별님</p>
				<p>소중한 약속을 잡아보세요!</p>
			</div>
			<ul class="chat_body">
				<c:forEach var="i" begin="0" end="2">
					<li>
						<a href="#">
							<p>서울시 마포구 합정동</p>
							<div>
								<div class="chat_text">
									<img alt="" src="<%=request.getContextPath()%>/img/comm/sample_mate03.png">
									<p>doobyeol</p>
									<p>안녕하세요!</p>
								</div>
								
								<div class="chat_notic">
									<p>10분전</p>
									<p>1</p>
								</div>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="chat_window chat_on">
			<div class="chat_head">
				<a href="" class="back_btn"></a>
				<p>doobyeol</p>
				<button class="close_btn"></button>
				<button class="report_btn"></button>
			</div>
			<ul class="chat_body">
				<li class="right">
					<img alt="" src="<%=request.getContextPath()%>/img/comm/sample_mate03.png">
					<p>doobyeol</p>
					<div class="chat_text">
						<p>안녕하세요!</p>
						<p>10분전</p>
					</div>
				</li>
				<c:forEach var="i" begin="0" end="4">
					<li>
						<img alt="" src="<%=request.getContextPath()%>/img/comm/sample_mate03.png">
						<p>doobyeol</p>
						<div class="chat_text">
							<p>안녕하세요!</p>
							<p>10분전</p>
						</div>
					</li>
				</c:forEach>
			</ul>
			<div class="chat_msg">
				<input type="text" placeholder="메세지를 입력하세요">
				<button class="btn_send"></button>
			</div>
		</div>
		<button class="btn_chat"></button>
	</div>
</body>
</html>