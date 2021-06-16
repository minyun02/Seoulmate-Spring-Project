<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.header_wrap{display: none;}
.chat_wrap{display: none;}
.foot_wrap{display: none;}
#payPopup{width: 600px;margin: 0 auto; overflow: hidden;}
#payPopup>p{margin-top: 80px;}
#payPopup>ul{margin-bottom: 40px;}
#payMonthCheck{overflow: auto; height: 45px; line-height: 45px;}
#payMonthLabel{width: 100px; font-weight: bold;}
#payMoney>label{width: 110px; font-weight: bold;}
#payMoney>div{height: 45px; line-height: 45px;}
#returnPolicy>div:first-of-type::before{background-color: #d2d2d2;}
#returnPolicy>div:first-of-type{font-size: 1.2em; margin: 0; margin-top: 40px;}
#premiumPay{font-size: 1em; margin-left: 100px; height: 40px; line-height: 40px;}
#returnPolicy>p>a{box-shadow: 0px 0px 0px 0px rgb(0 0 0 / 0%); display: inline; margin: 0; padding: 0; }
#returnPolicy>p{width: 600px;}
#returnPolicy>p:nth-of-type(3) {height: 30px; }
</style>
<script>
	var payMonthCheck = 0;
	var payMoney = 0;
	var msg ='';
	$(document).ready(function(){
		$('input[type="radio"]:checked').each(function() {
			payMonthCheck = $(this).val();
		});
		payMoney = 15 * payMonthCheck;
		msg = payMoney+",000 원"
		$('#payMoney>div').text(msg);
		
		$(".chat_wrap").css({"display":"none"});
		$(".btn_chat").css({"display":"none"});
	});
	$(function(){
		$('input[type="radio"]').on('click',function(){
			$('input[type="radio"]:checked').each(function() {
				payMonthCheck = $(this).val();
				payMoney = 15 * payMonthCheck;
			});
			msg = payMoney+",000 원"
			$('#payMoney>div').text(msg);
		});
		$('#premiumPay').on('click', function(){
			var username = '${memberVO.username}';
			var tel = '${memberVO.tel}';
			var email = '${memberVO.email}';
			
			console.log(username);
			console.log(tel);
			console.log(email);
			
			if(username!=null){
				IMP.init("imp58467820"); // 가맹점 식별코드 
				IMP.request_pay({
					pg : 'html5_inicis',
					pay_method: 'card',
					merchant_uid : 'merchant_' + new Date().getTime(),
					name : '프리미엄멤버십 '+payMonthCheck+"개월", //주문명
					amount : 150, //payMoney*1000, //결제할 금액
					buyer_name : username,
					buyer_tel : tel,
					buyer_email : email,
				},function(rsp){
					console.log(rsp);
					
					if(rsp.success){
						var msg = '프리미엄멤버십 '+payMonthCheck+"개월\n"
						msg += payMoney+",000원 결제가 완료되었습니다.";
						alert(msg);
						
						$.ajax({
							url : "premiumPayOk",
							type : "POST",
							dataType : "json",
							data : {
								"userid" : '${memberVO.userid}',
								"username" : '${memberVO.username}',
								"imp_uid" : rsp.imp_uid,
								"merchant_uid": rsp.merchant_uid,
								"amount" : payMoney*1000,  // rsp.paid_amount,
								"payMethod" : rsp.pay_method,
								"payMonth" : payMonthCheck
							},success :function(result){
								console.log(result);
								if(result=='200'){
									//결제 및 DB저장 성공
									window.open('','_self').close(); 
								}else if(result=='300'){
									window.open('','_self').close(); 
								}
							},error : function(){
								console.log("DB저장 에러");
								window.open('','_self').close(); 
							}
						});
					}else{
						alert(rsp.error_msg);
					}
				});
			}else{
				location.href="login";
			}
		});
	})
	
</script>
<div id="payPopup">
	<p class="m_title">${memberVO.userid }님 프리미엄 멤버십 결제</p>
	<ul class="form_box choice">
		<li>
			<label class="d_title" id="payMonthLabel">멤버십 기간</label>
			<div class="checks">
				<input type="radio" id="payMonth1" name="character1" value="1" checked> 
				<label for="payMonth1">1개월</label>
				
				<input type="radio" id="payMonth2" value="2" name="character1"> 
				<label for="payMonth2">2개월</label>
				
				<input type="radio" id="payMonth3" value="3" name="character1"> 
				<label for="payMonth3">3개월</label>
			</div>
			<button class="b_btn green" id="premiumPay">결제하기</button>
		</li>
		<li id="payMoney">
			<label class="d_title">결제 금액</label>
			<div></div>
		</li>
	</ul>
	<hr />
	<div id="returnPolicy">
		<p>멤버십 결제 후 바로 프리미엄 멤버십 기능을 모두 사용할 수 있습니다.</p>
		<p>결제 취소는 문의로만 이루어지고 있으니 정확히 확인 후 결제하시길 바랍니다.</p>
		<div class="s_title">환불 정책</div>
		<p>서울메이트 프리미엄 멤버십을 취소하고 환불 받으려면 <a href="">고객센터에 문의</a>해 주세요.</p>
		<p> 구매 시 사용한 결제 수단으로 환불됩니다. 환불에 소요되는 시간은 결제 수단에 따라 다릅니다.</p>
		<p>참고 : 환불이 처리되면 더 이상 혜택을 이용할 수 없습니다.<br/>
		프리미엄 멤버십의 추가 기능을 이용하고 계시던 이력이 있으면 작성하셨던 글이나,
		메세지 등이 자동으로 비활성화 및 삭제 처리 될 수 있습니다. </p>
	</div>
</div>