<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.1.1/dist/chart.min.js"></script>
	<script>
		$(function(){
			$('.va').css('vertical-align','middle')
			$('body').css('overflow','hidden')
			
			$('#dashUl li').click(function(){
				var whereTo = $(this).children().eq(0).text();
				
					if(whereTo == '하우스 신고'){
						submitAndGo('하우스');
					}else if(whereTo == '메이트 신고'){
						submitAndGo('메이트');
					}else if(whereTo == '커뮤니티 신고'){
						submitAndGo('커뮤니티');
					}else if(whereTo == '문의'){
						location.href = '/home/admin/contactManagement';
					}else if(whereTo == '프리미엄 가입'){
						location.href = '/home/admin/payManagement';
					}else if(whereTo == '매출'){
						location.href = '/home/admin/salesManagement';
					}
			});
			function submitAndGo(category){
				var form = document.createElement('form'); // 폼객체 생성
				var objs = document.createElement('input'); // 값이 들어있는 녀석의 형식
				objs.type = 'text';
				objs.name = 'grade';
				objs.value = category;
				form.appendChild(objs);
				form.setAttribute('action', "/home/admin/reportManagement"); //보내는 url
				form.setAttribute('method', 'post'); //get,post 가능
				document.body.appendChild(form);
				form.submit();
			}
			
			var date = getToday(new Date());
			$('.todayDiv').text('당일 요약 정보 - '+date);
			var findMonth = date.split('-');
			$('.chartDiv').text(findMonth[1]+'월 요약 정보');
			
			
			function getToday(date){
			    var year = date.getFullYear();
			    var month = ("0" + (1 + date.getMonth())).slice(-2);
			    var day = ("0" + date.getDate()).slice(-2);

			    return year + "-" + month + "-" + day;
			}
		});
	</script>
	<section class="admin_Section">
		<div class="admin_Content">
				<div class="m_title managementTitle todayDiv"></div>
				<div id="dashUl">
					<ul>
						<li>
							
							<span>하우스 신고</span><br>
							<span><img alt="하우스신고" src="<%=request.getContextPath()%>/img/yun/dashboard/fi-rr-home.svg"></span>
							<a><span class="va">${houseReport}건</span></a>
						</li>
						<li>
							<span>메이트 신고</span><br>
							<span><img alt="메이트신고" src="<%=request.getContextPath()%>/img/yun/dashboard/fi-rr-user.svg"></span>
							<a><span class="va">${mateReport}건</span></a>
						</li>
						<li>
							<span>커뮤니티 신고</span><br>
							<span><img alt="커뮤니티신고" src="<%=request.getContextPath()%>/img/yun/dashboard/fi-rr-screen.svg"></span>
							<a><span class="va">${communityReport}건</span></a>
						</li>
						<li>
							<span>문의</span><br>
							<span><img alt="문의" src="<%=request.getContextPath()%>/img/yun/dashboard/fi-rr-interrogation.svg"></span>
							<a><span class="va">${contactCnt}건</span></a>
						</li>
						<li>
							<span>프리미엄 가입</span><br>
							<span><img alt="프리미엄가입" src="<%=request.getContextPath()%>/img/yun/dashboard/fi-rr-shopping-cart-check.svg"></span>
							<a><span class="va">${premiumCnt}건</span></a>
						</li>	
						<li>
							<span>프리미엄 매출</span><br>
							<span><img alt="매출" src="<%=request.getContextPath()%>/img/yun/dashboard/fi-rr-dollar.svg"></span>
							<a><span class="va">
								<c:if test="${salesAmount==null}">0원</c:if>
								<c:if test="${salesAmount!=null}">${salesAmount}원</c:if>
							</span></a>
						</li>	
					</ul>
				</div>
				<div class="m_title managementTitle chartDiv"></div>	
				<div style="margin-top:50px;">
					<table>
						<tr style="width:100%">
							<td id="chartTd"><canvas id="myChart" width="400" height="400"></canvas></td>
		        			<td><canvas id="chart1" width="200" height="200"></canvas></td>
		        			<td><canvas id="chart2" width="400" height="400"></canvas></td>
						</tr>
					</table>
				</div>
					
				<script>
				var test = '${guName}'
				var str = test.indexOf('[');
				var str1 = test.indexOf(']');
				var str2 = test.slice(str+1, str1);
				var str3 = str2.split(',');
				var ctx = document.getElementById('myChart').getContext('2d');
				var myChart = new Chart(ctx, {
				    type: 'bar',
				    data: {
				        labels: str3, //구이름
				        datasets: [{
				            label: '지역별 하우스 분포 TOP5',
				            data: ${guNum}, // 구에 맞는 데이터
				            backgroundColor: [
				                'rgba(54, 162, 235, 0.2)',
				                'rgba(255, 99, 132, 0.2)',
				                'rgba(255, 206, 86, 0.2)',
				                'rgba(75, 192, 192, 0.2)',
				                'rgba(153, 102, 255, 0.2)',
				            ],
				            borderColor: [
				                'rgba(54, 162, 235, 1)',
				                'rgba(255, 99, 132, 1)',
				                'rgba(255, 206, 86, 1)',
				                'rgba(75, 192, 192, 1)',
				                'rgba(153, 102, 255, 1)',
				            ],
				            borderWidth: 1
				        }]
				    },
				    options: {
				        scales: {
				            y: {
				                beginAtZero: true
				            }
				        }
				    }
				});
				
				////
// 				var ctx2 = document.getElementById('chart1').getContext('2d');
// 				var myChart2 = new Chart(ctx2, {
// 				    type: 'bar',
// 				    data: {
// 				        labels: ['강남구', '마포구', '양천구', '영등포구', '서대문구'], //구이름
// 				        datasets: [{
// 				            label: '지역별 하우스 분포 TOP5',
// 				            data: [12, 19, 3, 5, 2, 3], // 구에 맞는 데이터
// 				            backgroundColor: [
// 				                'rgba(54, 162, 235, 0.2)',
// 				                'rgba(255, 99, 132, 0.2)',
// 				                'rgba(255, 206, 86, 0.2)',
// 				                'rgba(75, 192, 192, 0.2)',
// 				                'rgba(153, 102, 255, 0.2)',
// 				            ],
// 				            borderColor: [
// 				                'rgba(54, 162, 235, 1)',
// 				                'rgba(255, 99, 132, 1)',
// 				                'rgba(255, 206, 86, 1)',
// 				                'rgba(75, 192, 192, 1)',
// 				                'rgba(153, 102, 255, 1)',
// 				            ],
// 				            borderWidth: 1
// 				        }]
// 				    },
// 				    options: {
// 				        scales: {
// 				            y: {
// 				                beginAtZero: true
// 				            }
// 				        }
// 				    }
// 				});
				//파이차트//////////////////////////////////////////////////////////
				const data = {
					  labels: [
					    '일반',
					    '프리미엄',
					  ],
					  datasets: [{
					    label: '회원 비율',
					    data: ${grade},
					    backgroundColor: [
					      'rgb(255, 99, 132)',
					      'rgb(54, 162, 235)',
				   	 ],
				    hoverOffset: 4
				  }]
				};
				const config = {
					  type: 'doughnut',
					  data: data,
				};
				var myChart2 = new Chart(
					document.getElementById('chart2'),
				    config
				);
				</script>
		</div>
	</section>
</body>
</html>