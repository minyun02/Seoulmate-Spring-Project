$(document).ready(function(){
	$('#premiumInfoTable th').addClass('d_title');
});
$(function(){
	$('#premiumPayPopup, #premiumPayBtn').on('click', function(){
		var popWidth = 800;
		var popHeight = 600;
		var popLeft = Math.ceil((window.screen.width - popWidth)/2);
		var popTop = Math.ceil((window.screen.height - popHeight)/2);
		window.open("premiumPay","프리미엄 멤버십 결제 페이지", "width="+popWidth+", height="+popHeight+", left="+popLeft+", top="+popTop);
	});
	
	
});
