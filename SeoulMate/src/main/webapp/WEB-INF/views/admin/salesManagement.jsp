<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="//cdn.rawgit.com/rainabba/jquery-table2excel/1.1.0/dist/jquery.table2excel.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.2.0/chart.min.js" integrity="sha512-VMsZqo0ar06BMtg0tPsdgRADvl0kDHpTbugCBBrL55KmucH6hP9zWdLIWY//OTfMnzz6xWQRxQqsUFefwHuHyg==" crossorigin="anonymous"></script>
<style>
	.sales_Management_List ul, .sales_Management_List li{list-style-type: none; margin: 0; padding: 0;}
	.sales_Management_List{    width: 95%;  margin: 10px auto; overflow: auto;}
	.sales_Management_List ul{width: 100%; overflow: auto;}
	.sales_Management_List li{float: left;}
	.sales_Management_List>ul:first-of-type>li{height: 50px; line-height: 50px; background-color: #576e9485; color:#495057; 
		border-top: 1px solid #dee2e6; border-bottom: 1px solid #dee2e6; font-size: 1.2em; font-weight: bold;}
	.sales_Management_List>ul:first-of-type>li:first-of-type{font-size: 1em;}
	.sales_Management_List ul>li{text-align: center; height: 40px; line-height: 40px;}
	.sales_Management_List li:first-of-type { width: 5%;}
	.sales_Management_List li:nth-of-type(2) { width: 0%;}
	.sales_Management_List li:nth-of-type(3) { width: 15%;}
	.sales_Management_List li:nth-of-type(4) { width: 15%;}
	.sales_Management_List li:nth-of-type(5) { width: 15%;}
	.sales_Management_List li:nth-of-type(6) { width: 15%;}
	.sales_Management_List li:nth-of-type(7) { width: 15%;}
	.sales_Management_List li:nth-of-type(8) { width: 10%;}
	.sales_Management_List li:last-of-type { width: 10%;}
	#total_Sales_List{border-bottom: 1px solid #dee2e6; background-color: #fff; color: #2d4364;
  			 font-weight: bold; font-size: 1.3em; }
 	.bgc_1{background-color: #d4d4d4;}
  	.bgc_2{background-color: #eee;}
</style>
		<section class="admin_Section">
			<div class="admin_Content">
				<div class="m_title managementTitle">?????? ??????</div>
				<form method="post" action="/home/admin/salesManagement" name="salesManagementForm">
					<input type="hidden" name="orderCondition" value="payStart"/>
					<input type="hidden" name="orderUpDown" value="desc"/>
					<div id="salesManagementDiv">
						<div class="managementDatePicker" id="salesDatePicker">
							<div class="dateChoose">
								<span class="managementSpan3">?????? ??????</span>
								<select name="selectYearMonthDate" id="selectYearMonthDate" class="custom-select">
									<c:if test="${payVO.selectYearMonthDate=='??????' }">
										<option value="??????" selected>??????</option>
									</c:if>
									<c:if test="${payVO.selectYearMonthDate!='??????' }">
										<option value="??????" >??????</option>
									</c:if>
									<c:if test="${payVO.selectYearMonthDate=='??????' }">
										<option value="??????" selected>??????</option>
									</c:if>
									<c:if test="${payVO.selectYearMonthDate!='??????' }">
										<option value="??????" >??????</option>
									</c:if>
									<c:if test="${payVO.selectYearMonthDate=='??????'}">
										<option value="??????" selected>??????</option>
									</c:if>
									<c:if test="${payVO.selectYearMonthDate!='??????' }">
										<option value="??????" >??????</option>
									</c:if>
								</select>
							</div>
							<div class="selectDateChoose">
								<c:if test="${payVO.selectYearMonthDate==null || payVO.selectYearMonthDate=='??????' }">
										<input type="date" name="selectStartDate" <c:if test="${payVO.selectStartDate != null && payVO.selectStartDate != ''}">value="${payVO.selectStartDate}"</c:if>/>
										<input type="date" name="selectEndDate" <c:if test="${payVO.selectEndDate != null && payVO.selectEndDate != ''}">value="${payVO.selectEndDate}"</c:if>/>
									</c:if>
									<c:if test="${payVO.selectYearMonthDate=='??????'}">
										<input type="month" name="selectStartDate" <c:if test="${payVO.selectStartDate != null && payVO.selectStartDate != ''}">value="${payVO.selectStartDate}"</c:if>/>
										<input type="month" name="selectEndDate"  <c:if test="${payVO.selectEndDate != null && payVO.selectEndDate != ''}">value="${payVO.selectEndDate}"</c:if>/>
									</c:if>
									<c:if test="${payVO.selectYearMonthDate=='??????' }">
										<input type="month" name="selectStartDate" <c:if test="${payVO.selectStartDate != null && payVO.selectStartDate != ''}">value="${payVO.selectStartDate}-01"</c:if>/>
										<input type="month" name="selectEndDate"  <c:if test="${payVO.selectEndDate != null && payVO.selectEndDate != ''}">value="${payVO.selectEndDate}-12"</c:if>/>
									</c:if>
							</div>
							<div>
								<input type="submit" value="Search" class="btn btn-custom"/>
							</div>
							<div id="salesGrapeBtn">
								<a href="javascript:printPage('salesExcel')" id="excelBtn" class="btn btn-custom">??????</a>
								<a href="#" class="btn btn-custom" id="graphBtn">
								<img src="<%=request.getContextPath()%>/img/fi-rr-stats.svg" alt="????????? ??????" id="graphImgSvg"/>
								</a>
								<a href="javascript:printPage('sales')" class="btn btn-custom" id="printBtn">?????????</a>
							</div>
						</div>
					</div>
				</form>
	
				<div class="sales_Management_List managementList">
					<ul id="sales_List_Header">
						<c:if test="${payVO.selectYearMonthDate!='??????' }"><li>?????????</li></c:if>
						<c:if test="${payVO.selectYearMonthDate=='??????' }"><li></li></c:if>
						<li></li>
						<li>??????</li>
						<li>??? ?????????</li>
						<li>??????</li>
						<li>??? ???</li>
						<li>????????????</li>
						<li>?????? ??????</li>
						<li>?????? ??????</li>
					</ul>
					<ul id='total_Sales_List'>
						<li></li>
						<li></li>
						<li>???  ???</li>
						<fmt:formatNumber var="totalAmount" value="${totalVO.amount-totalVO.amountRefund}" />
						<li>${totalAmount}</li>
						<fmt:formatNumber var="totalAmountCard" value="${totalVO.amountCard}" />
						<li>${totalAmountCard }</li>
						<fmt:formatNumber var="totalAmountCash" value="${totalVO.amountCash}" />
						<li>${totalAmountCash }</li>
						<fmt:formatNumber var="totalAmountRefund" value="${totalVO.amountRefund}" />
						<li>${totalAmountRefund }</li>
						<fmt:formatNumber var="totalAmountNum" value="${(totalVO.amount-totalVO.amountRefund)/15000 }" />
						<li>${totalAmountNum }</li>
						<fmt:formatNumber var="totalRefundNum" value="${totalVO.amountRefund/15000 }" />
						<li>${totalAmountNum }</li>
					</ul>
					<c:if test="${payVO.selectYearMonthDate==null || payVO.selectYearMonthDate=='??????'  || payVO.selectYearMonthDate==''}">
					<c:forEach var="year" items="${yearList }">
						<ul class="adminSalesManagementList cuser_Pointer list_year">
							<li>
								<input type="checkbox" name="openList_year"/>
							</li>
							<li></li>
							<li style="border-bottom: 1px solid #dee2e6;  padding-right: 30px;">${year.payStart }???<span class="objectHidden">${year.payStart }</span></li>
							<fmt:formatNumber var="amount" value="${year.amount }" />
							<li style="border-bottom: 1px solid #dee2e6;" class="salesPopup">${amount}</li>
							<fmt:formatNumber var="amountCard" value="${year.amountCard }" />
							<li style="border-bottom: 1px solid #dee2e6;" class="salesPopup">${amountCard}</li>
							<fmt:formatNumber var="amountCash" value="${year.amountCash }" />
							<li style="border-bottom: 1px solid #dee2e6;" class="salesPopup">${amountCash }</li>
							<fmt:formatNumber var="amountRefund" value="${year.amountRefund }" />
							<li style="border-bottom: 1px solid #dee2e6;" class="salesPopup">${amountRefund }</li>
							<fmt:formatNumber var="amountNum" type="number" value="${(year.amount-year.amountRefund)/15000 }" />
							<li style="border-bottom: 1px solid #dee2e6;" class="salesPopup">${amountNum }</li>
							<fmt:formatNumber var="refundNum" type="number" value="${year.amountRefund/15000 }" />
							<li style="border-bottom: 1px solid #dee2e6;" class="salesPopup">${refundNum }</li>
						</ul>
					</c:forEach>
					</c:if>
					<c:if test="${payVO.selectYearMonthDate=='??????'}">
						<c:forEach var="month" items="${monthList }">
							<ul class="adminSalesManagementList cuser_Pointer list_month">
								<li>
									<input type="checkbox" name="openList_month"/>
								</li>
								<li></li>
								<li class="salesPopup">${month.payStart }<span class="objectHidden">${month.payStart }</span></li>
								<fmt:formatNumber var="amount" value="${month.amount }" />
								<li class="salesPopup">${amount}</li>
								<fmt:formatNumber var="amountCard" value="${month.amountCard }" />
								<li class="salesPopup">${amountCard}</li>
								<fmt:formatNumber var="amountCash" value="${month.amountCash }" />
								<li class="salesPopup">${amountCash }</li>
								<fmt:formatNumber var="amountRefund" value="${month.amountRefund }" />
								<li class="salesPopup">${amountRefund }</li>
								<fmt:formatNumber var="amountNum" type="number" value="${(month.amount-month.amountRefund)/15000 }" />
								<li class="salesPopup">${amountNum }</li>
								<fmt:formatNumber var="refundNum" type="number" value="${month.amountRefund/15000 }" />
								<li class="salesPopup">${refundNum }</li>
							</ul>
						</c:forEach>
					</c:if>
					<c:if test="${payVO.selectYearMonthDate=='??????' }">
						<c:if test="${fn:length(dateList) < 31 }">
						<c:forEach var="date" items="${dateList }">
							<ul class="adminSalesManagementList salesManagement_date cuser_Pointer list_date">
								<li></li>
								<li></li>
								<li class="salesPopup">${date.payStart }<span class="objectHidden">${date.payStart }</span></li>
								<fmt:formatNumber var="amount" value="${date.amount }" />
								<li class="salesPopup">${amount}</li>
								<fmt:formatNumber var="amountCard" value="${date.amountCard }" />
								<li class="salesPopup">${amountCard}</li>
								<fmt:formatNumber var="amountCash" value="${date.amountCash }" />
								<li class="salesPopup">${amountCash }</li>
								<fmt:formatNumber var="amountRefund" value="${date.amountRefund }" />
								<li class="salesPopup">${amountRefund }</li>
								<fmt:formatNumber var="amountNum" type="number" value="${(date.amount-date.amountRefund)/15000 }" />
								<li class="salesPopup">${amountNum }</li>
								<fmt:formatNumber var="refundNum" type="number" value="${date.amountRefund/15000 }" />
								<li class="salesPopup">${refundNum }</li>
							</ul>
						</c:forEach>
						</c:if>
					</c:if>
				</div>
			</div>
			<div class="admin_Management_popup popup_hidden">
				<div class="admin_Management_popup_head">?????? ?????? ?????????<span class="admin_Management_popup_head_close popup_Close">X</span></div>
				<div class="admin_Management_popup_body" id="admin_Management_popup_print" style="overflow-y: scroll;">
					<div class="admin_Management_popup_title" id="salesManagementView"></div>
					<div>
						<canvas id="salesChart"style="height:55vh; width:55vw" ></canvas>
					</div>
				</div>
				<div class="admin_Management_popup_table_btn" id="sales_popupBtn">
					<a href="javascript:printPage('popSalesExcel')" class="btn btn-custom">??????</a>
					<a href="javascript:printPage('pop')" class="btn btn-custom">?????????</a>
					<a href="#" class="btn btn-custom popup_Close">??????</a>
				</div>
			</div>
			<div class="myPage_HouseAndMate_Popup_FullScreen popup_Close popup_hidden" id="myPage_popup_FullScreen"></div>
		</section>
	</body>
<script>
	$(function(){
		$(document).on('click', '#graphBtn', function(){
			var selectYearMonthDate ='<c:out value="${payVO.selectYearMonthDate}"/>';
			//????????? 
			var tag = '<canvas id="salesChart"style="height:55vh; width:55vw" ></canvas>';
			$('#salesManagementView').next().empty();
			$('#salesManagementView').next().append(tag);
			
			//?????? ?????? 
			$('#sales_popupBtn').empty();
			var btnTag = '';
			btnTag += '<a href="#" class="btn btn-custom popup_Close">??????</a>';
			$('#sales_popupBtn').html(btnTag);
			
			var payStart=[]; //?????????
			var amount=[]; //?????????????????? 
			var amountCard=[]; //????????????
			var amountCash=[]; //????????????  
			var amountRefund=[]; //????????????
			var totalAmount = [];
			if(selectYearMonthDate=='??????'){
				<c:forEach items="${yearList}" var="item">
					payStart.push("${item.payStart}");
					amount.push("${item.amount}");
					amountCard.push("${item.amountCard}");
					amountCash.push("${item.amountCash}");
					amountRefund.push("${item.amountRefund}");
				</c:forEach>
			}else if(selectYearMonthDate=='??????'){
				<c:forEach items="${monthList}" var="item">
					payStart.push("${item.payStart}");
					amount.push("${item.amount}");
					amountCard.push("${item.amountCard}");
					amountCash.push("${item.amountCash}");
					amountRefund.push("${item.amountRefund}");
				</c:forEach>
			}else if(selectYearMonthDate=='??????' || selectYearMonthDate=='' || selectYearMonthDate==null){
				<c:forEach items="${dateList}" var="item">
					payStart.push("${item.payStart}");
					amount.push("${item.amount}");
					amountCard.push("${item.amountCard}");
					amountCash.push("${item.amountCash}");
					amountRefund.push("${item.amountRefund}");
				</c:forEach>
			}
			for(var ii=0; ii<amount.length; ii++){
				totalAmount.push(amount[ii]-amountRefund[ii]);
			}
			
			console.log(payStart.length);
			var title='';
			if(payStart.length>1){
				var start = payStart[0];
				var end = payStart[payStart.length-1];
				title = start+' ~ '+end+' ?????? ??????';
			}else{
				title = payStart[0]+' ?????? ??????';
			}
			
			$('#salesManagementView').text(title);
			//????????? ?????????
			var ctx = document.getElementById('salesChart'); 
			var salesChart = new Chart(ctx, {
				data : {
					labels : payStart,
					datasets : [{
						type : 'line',
						label : '?????????',
						data : totalAmount,
						borderColor:  'rgba(194, 0, 0, 1)'
					},{
						type : 'bar',
						label : '????????????',
						data : amountCash,
						backgroundColor: 'rgba(75, 192, 192, 1)',
					},{
						type : 'bar',
						label : '????????????',
						data : amountCard,
						backgroundColor: 'rgba(54, 162, 235, 1)'
					},{
						type : 'line',
						label : '????????????',
						data : amountRefund,
						borderColor:  'rgba(255, 193, 7, 1)'
					}]
				},options : {
					responsive: false,
					scales: {
		                yAxes: [{
		                    ticks: {
		                        beginAtZero: true
		                    }
		                }]
		            }
				}
			});
			//???????????????
			openPopup();
		});
		
		$(document).on('click','.salesPopup' ,function(){
			var selectYearMonthDate ='<c:out value="${payVO.selectYearMonthDate}"/>';
			var checkDate = $(this).parent().children().eq(2).children().text();
			console.log('checkDate' + checkDate);
			
			
			
			var excelTag = '';
			excelTag += '<a href="javascript:printPage("popSalesExcel")" class="btn btn-custom">??????</a>';
			excelTag += '<a href="javascript:printPage("pop")" class="btn btn-custom">?????????</a>';
			excelTag+= '<a href="#" class="btn btn-custom popup_Close">??????</a>';
			$('#sales_popupBtn').empty();
			$('#sales_popupBtn').html(excelTag);
			$(".admin_Management_popup_head").text('?????? ?????? ?????? ?????????');
			
			var url = "/home/admin/salesUserList";
			var data = { "date" : checkDate };
			var tag = '';
			$.ajax({
				url : url,
				data : data,
				success : function(result){
					$result = $(result);
					var titleTag ='';
					if(checkDate.length==4){
						titleTag = '['+checkDate+' ???]';
					}else if(checkDate.length==7){
						titleTag ='['+checkDate.substr(0,4)+'??? '+Number(checkDate.substr(5,2))+'??? ]';
					}else if(checkDate.length==10){
						titleTag = '['+checkDate.substr(0,4)+'??? '+Number(checkDate.substr(5,2))+'??? '+Number(checkDate.substr(8,2))+'??? ]';
					}
					$('#salesManagementView').text(titleTag);
					console.log(titleTag);
					//?????? div ???????????? 
					$('#salesManagementView').next().empty();
					tag += '<table class="table table-hover table-sm table-bordered, managementTable" id="popExcel">';
					tag += '<thead class="thead-light">';
					tag += '<tr class="orderConditionTable">';
					tag += '<th>?????????</th><th>??????</th><th>????????????</th><th>?????????</th><th>?????????</th><th>????????????</th><th>????????????</th></tr></thead><tbody>';
					$result.each(function(idx, obj){
						tag += '<tr class="adminSalesManagementList">';
						tag += '<td>'+obj.userid+'</td>';
						tag += '<td>'+obj.username+'</td>';
						tag += '<td>'+Number(obj.amount).toLocaleString('ko-KR')+'</td>';
						tag += '<td>'+obj.payStart+'</td>';
						tag += '<td>'+obj.payEnd+'</td>';
						tag += '<td>'+obj.payMethod+'</td>';
						if(obj.refund==null){
							tag += '<td>X</td></tr>';
						}else{
							tag += '<td>O</td></tr>';
						}
					});
					tag += '</tbody></table>'
					
					$('#salesManagementView').next().html(tag);
				},error : function(){
					console.log("sales user ?????????  ????????????????????? ?????? ");
				}
			});
			//???????????????
			openPopup();
		});
		//?????? ???????????? ???????????? ??? ??????
		$(document).on('click', "input[name='openList_year']", function(){
			console.log('adasd');
			var checkDate = $(this).parent().next().next().children().text();
			// 2021   ?????? ????????? ?????????. 
			var payStart = []; var amount =[]; var amountCard = []; var amountCash = []; var amountRefund = [];
			// jstl ????????????????????? ??????.. 
			<c:forEach items="${monthList}" var="item">
				payStart.push("${item.payStart}");
				amount.push("${item.amount}");
				amountCard.push("${item.amountCard}");
				amountCash.push("${item.amountCash}");
				amountRefund.push("${item.amountRefund}");
			</c:forEach>
			console.log(payStart);
			if($(this).context.checked==true){
				//?????? ???????????????  (????????? ?????????, ???????????? ???????????????. )
				// ?????????????????? ?????? ????????? ?????????.. (?????????)
				$('.list_month').remove(); 
				$('.list_date').remove();
				$('.list_year').removeClass('bgc_1');
				$(this).parent().parent().addClass('bgc_1');
				//???????????? ????????? ?????? ????????????. 
				
				//???????????? ?????????
				$("input:checkbox[name='openList_year']").prop("checked", false);
				$(this).prop("checked", true);
				
				
				var tag = '';
				for(var i=0; i<payStart.length; i++){
 					if(checkDate.substr(0,4) == payStart[i].substr(0,4)){
						tag += '<ul style="font-"class="adminSalesManagementList cuser_Pointer list_month">';
						tag += '<li style="padding-left:30px;"><input type="checkbox" name="openList_month"/></li>';
						tag += '<li style="width:7%; text-align: right;">???</li>'
						tag += '<li style="width:8%; text-align: left; padding-left:10px; border-bottom: 1px solid #dee2e6;">'+Number(payStart[i].substr(5,7))+'???<span class="objectHidden">'+payStart[i]+'</span></li>';
						tag += '<li style="width:15%; border-bottom: 1px solid #dee2e6;" class="salesPopup">'+Number(amount[i]).toLocaleString('ko-KR')+'</li>';
						tag += '<li style="width:15%; border-bottom: 1px solid #dee2e6;" class="salesPopup">'+Number(amountCard[i]).toLocaleString('ko-KR')+'</li>';
						tag += '<li style="width:15%; border-bottom: 1px solid #dee2e6;" class="salesPopup">'+Number(amountCash[i]).toLocaleString('ko-KR')+'</li>';
						tag += '<li style="width:15%; border-bottom: 1px solid #dee2e6;" class="salesPopup">'+Number(amountRefund[i]).toLocaleString('ko-KR')+'</li>';
						tag += '<li style="width:10%; border-bottom: 1px solid #dee2e6;" class="salesPopup">'+Number(amount[i]-amountRefund[i])/15000+'</li>';
						tag += '<li style="width:10%; border-bottom: 1px solid #dee2e6;" class="salesPopup">'+Number(amountRefund[i])/15000+'</li></ul>';
 					}
 				}
				//????????? ?????? tr??? ??????????????? ?????? ???????????? 
				$(this).parent().parent().after(tag);
				
			}else{
				//?????? X 
				$('.list_month').remove(); 
				$('.list_date').remove();
				$('.list_year').removeClass('bgc_1');
			}
		}); //?????????????????? ?????? end
			
		//??? ????????? ????????? ?????? 
		$(document).on('click', "input[name='openList_month']", function(){
			var checkDate = $(this).parent().next().next().children().text();
			
			var payStart = []; var amount =[]; var amountCard = []; var amountCash = []; var amountRefund = [];
			<c:forEach items="${dateList}" var="item">
				payStart.push("${item.payStart}");
				amount.push("${item.amount}");
				amountCard.push("${item.amountCard}");
				amountCash.push("${item.amountCash}");
				amountRefund.push("${item.amountRefund}");
			</c:forEach>
			console.log(payStart);
			if($(this).context.checked==true){
				//????????? ????????? ?????? 
				//??????????????? ?????? ????????? 
				$('.list_date').remove();
				$('.list_month').removeClass('bgc_2');
				$(this).parent().parent().addClass("bgc_2");
				//???????????? ?????????
				$("input:checkbox[name='openList_month']").prop("checked", false);
				$(this).prop("checked", true);
				//???????????? ????????? ?????? ????????????
				var tag = '';
				for(var i=0; i<payStart.length; i++){
					if(checkDate == payStart[i].substr(0,7)){
						tag += '<ul class="adminSalesManagementList cuser_Pointer list_date">';
						tag += '<li></li>';
						tag += '<li style="width:10%; text-align: right;">';
						if(i==0){ tag += '???'; }
						tag+= '</li>';
						tag += '<li style="width:5%; text-align: left; padding-left:20px; border-bottom: 1px solid #dee2e6;" class="salesPopup">'+Number(payStart[i].substr(8,10))+'???<span class="objectHidden">'+payStart[i]+'</span></li>';
						tag += '<li style="width:15%; border-bottom: 1px solid #dee2e6;" class="salesPopup">'+Number(amount[i]).toLocaleString('ko-KR')+'</;i>';
						tag += '<li style="width:15%; border-bottom: 1px solid #dee2e6;" class="salesPopup">'+Number(amountCard[i]).toLocaleString('ko-KR')+'</li>';
						tag += '<li style="width:15%; border-bottom: 1px solid #dee2e6;" class="salesPopup">'+Number(amountCash[i]).toLocaleString('ko-KR')+'</li>';
						tag += '<li style="width:15%; border-bottom: 1px solid #dee2e6;" class="salesPopup">'+Number(amountRefund[i]).toLocaleString('ko-KR')+'</li>';
						tag += '<li style="width:10%; border-bottom: 1px solid #dee2e6;" class="salesPopup">'+Number(amount[i]-amountRefund[i])/15000+'</li>';
						tag += '<li style="width:10%; border-bottom: 1px solid #dee2e6;" class="salesPopup">'+Number(amountRefund[i])/15000+'</li></ul>';
					}
				}
 				$(this).parent().parent().after(tag);
			}else{
				//????????? ????????? ?????? 
				$('.list_date').remove();
				$('.list_month').removeClass('bgc_2');
			}
		});//??? ???????????? ?????? end
		
	});
</script>
</html>