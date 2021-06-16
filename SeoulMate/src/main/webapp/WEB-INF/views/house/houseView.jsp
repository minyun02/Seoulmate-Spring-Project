<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.2.0/chart.min.js" integrity="sha512-VMsZqo0ar06BMtg0tPsdgRADvl0kDHpTbugCBBrL55KmucH6hP9zWdLIWY//OTfMnzz6xWQRxQqsUFefwHuHyg==" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/yun.css">
<script>
$(function(){
	var logId = '<c:out value="${logId}"/>';
	var logGrade = '<c:out value="${logGrade}"/>';
	
	var life = '<c:out value="${graph_matching.life}"/>';
	var pet = '<c:out value="${graph_matching.pet}"/>';
	var communicate= '<c:out value="${graph_matching.communicate}"/>';
	var smoke= '<c:out value="${graph_matching.smoke}"/>';
	var personality= '<c:out value="${graph_matching.personality}"/>';
	var now = '<c:out value="${graph_matching.now}"/>';

	var ctx = document.getElementById('matchingChart'); 
	var chartData = {
		labels : ['생활', '반려동물', '소통,모임', '흡연', '성격', '입주'],
		datasets : [{
			label : 'matching',
			fill: true,
		    backgroundColor: 'rgba(19, 168, 158, 0.2)',
		    borderColor: 'rgb(19, 168, 158)',
		    pointBackgroundColor: 'rgb(19, 168, 158)',
		    pointBorderColor: '#fff',
		    pointHoverBackgroundColor: '#fff',
		    pointHoverBorderColor: 'rgb(19, 168, 158)',
			data : [life, pet, communicate, smoke, personality, now]
		}]
	};
	var chartOptions = {
		scale : {
			gridLines : {
				color : "black",
				lineWidth : 1
			},
			r: {
	            angleLines: {
	                display: false
	            },
	            suggestedMin: 0,
	            suggestedMax: 2
	        }
		},legend : {
			position : 'left'
		}	
	};
	var matchingChart = new Chart(ctx, {
		type : 'radar',
		data : chartData,
		options : chartOptions
	});
	//신청하기.
	$(document).on('click', '.applyInsert', function(){
		
		var userid = '<c:out value="${logId }"/>';
		var checkId = '<c:out value="${pVO.userid}"/>';
		var msg = '신청';
		var no =  '<c:out value="${hVO.no }"/>';
		
		if(userid==checkId){
			alert('본인이 작성한 글입니다.\n신청이 불가합니다.');
		}else{
			var url = '/home/applyInsert';
			var data = {"no":no, "msg":msg, "userid":userid};
			$.ajax({
				url : url,
				data : data,
				success : function(result){
					if(result==-1){
						alert('로그인 후 이용해 주세요');
						location.href="login";
					}else if(result>0){
						console.log('신청 완료 되었습니다.');
						alert('신청 완료 되었습니다.');
					}else if(result==0){
						console.log('이미 신청한 하우스입니다.');
						alert('이미 신청한 하우스입니다.');
					}
				},error : function(){
					console.log('신청 insert 에러 ');
				}
			});
		}
	});
	
	$(document).on('click','.likeInsert', function(){
		// 하우스no , 로그인한 유저아이디를 사용하여 찜목록에 내역이 있는지 확인하기. 
		var no = '<c:out value="${hVO.no }"/>';
		var userid = '<c:out value="${logId }"/>';
		var checkId = '<c:out value="${pVO.userid }"/>';
		var msg = '하우스';
		// 로그인한 경우에만 실행한다. 
		if(userid ==null || userid==''){
			alert('찜하기는 로그인 후 이용이 가능합니다.');
			location.href='/home/login';
		}else if(userid == checkId ){
			alert('본인이 작성한 글입니다.\n찜하기가 불가합니다.');
		}else {
			var url = '/home/likemarkerInsert';
			var data = {"no":no, "userid":userid, "msg":msg};
			$.ajax({
				url : url,
				data : data,
				success : function(result){
					console.log(2);
					if(result == 0){
						alert('이미 찜등록이 되어있는 하우스입니다.');
					}else if(result == 1){
						alert('찜등록이 되었습니다. ');
					}else if(result==2){
						console.log('찜등록 insert 실패함');
					}
				},error : function(){
					console.log('찜하기 insert 에러 ');
				}
			});
		}
	});
});

</script>
<style>
#topDiv{ width: 1229px; margin-bottom: 30px; height: 620px; position: relative;}
#topDiv>img{height: 200px; width: 200px;}
.houseViewContent{width: 1230px; margin: 40px auto; overflow: hidden;}
#dateDiv{float: left; height: 50px; line-height: 50px; }
#btnDiv{float: right;
    height: 90px;
    overflow: auto;
    line-height: 90px;}
#peopleExplain{    position: relative;
	background-color: #fff;
    float: right;
    top: -430px;
    width: 300px;
    height: 520px;
    border: 1px solid #ddd;
    border-radius: 3px; }
#peopleExplain img{width: 270px; height: 270px;}
#peopleExplain li{width: 90%;
    margin: 5px auto;
    text-align: center;}
#peopleExplain li>button{height: 45px; line-height: 45px;}
#peopleExplain li:first-of-type{ margin: 10px auto;}
#peopleExplain li:nth-of-type(2){font-size: 1.5em;}
#profilePic1{width:150px; height:150px; margin-top: 5px;}
#map_Div{background-color:skyblue;}
#reportBtn {display: inline-block; margin-right:20px;}
#middle_Div{overflow: auto; 
	border-radius: 3px; border: 1px solid #ddd;
    position: relative;
    left: 0px;
    top: -420px;
    width: 100%;}
.middle_houseInfo, #propensity_info, .matchin_Graph{
    width: 80%;
    margin: 40px auto;
}
#house_profile {margin: 40px auto;}
.matchin_Graph{overflow: auto;}
.matchin_Graph>div:first-of-type{width: 54%; height: 560px; float: left; border:1px solid #ddd; border-radius: 5px;}
.matchin_Graph>div:first-of-type>div:last-of-type{width: 430px; height: 430px; margin: auto;}
.matchin_Graph>div>div:first-of-type{margin-left: 30px;}
.matching_result{width: 45%;height: 560px; float: right; border:1px solid #ddd; border-radius: 5px;}
.matching_result>ul{margin-left: 30px;}
.matching_result>ul>li{height: 40px; line-height: 40px; width: 80%; margin: 0px auto; }
.matching_result>ul>li>span:first-of-type{display: inline-block; width: 80px; text-align: justify; text-align-last: justify;
	font-weight: bold; font-weight: bold; font-size: 1.1em;}
.matching_result>ul>li>span:nth-of-type(2){display: inline-block; width: 20px; text-align: center;}
.matching_result>ul>li:last-of-type{ width: 60%; border:1px solid #13a89e; border-radius: 10px; margin: 30px auto;
height:140px; line-height: 140px; font-size:4em; text-align: center; font-weight:bold; color:#fff;  background-color: #13a89e;}
#propensity_info{overflow: auto;}
#propensity_info ul>li{
	float: left;
    height: 40px;
    line-height: 40px;
    padding: 0;
    width: 22%;
    text-align: center;
}
#propensity_info ul>li:first-of-type{width: 34%; text-align: left; font-weight: bold;}
/* #propensity_info ul>li:nth-of-type(4){width: 22%;} */
#propensity_info p{margin: 40px 0px 10px 30px;}
#propensity_info ul {width: 90%; margin: 0 auto; overflow: auto; padding: 0;}
.propensity_info_house,  .propensity_info_mate{border: 1px solid #ddd; border-radius: 3px; }
.propensity_info_house{width: 54%; float: left;}
.propensity_info_mate{width: 45%; float: right;}
.checkSvg{  width: 15px;
    height: 15px;line-height:40px;
	filter: invert(51%) sepia(100%) saturate(1626%) hue-rotate(137deg) brightness(88%) contrast(85%);}
#facility_info img{width: 70px; height: 70px;}
#facility_info div{width: 100%; overflow: auto;}
#facility_info ul{float: left; margin: 10px 20px;}
#facility_info li{text-align: center;}
.facility_info_title{font-size: 1.2em; font-weight: bold;}
/* 슬라이드 */
.slide_Img{
    position: relative;
    top: 90px;
    width: 920px;
    height: 520px; border-radius: 3px; border: 1px solid #ddd;}
.slide_wraper{height: 500px;
    width: 4200px;
    overflow: hidden;
    top: 10px;
    left: 40px;
    position: absolute;}
.slides{
   position: absolute; top:0; left:0; width:100%; height:100%;
   transition: left 0.5s ease-out; margin:0 auto;
}
.slides>ul>li:not(:last-child){ float:left; }
.slides>ul>li>img{ width:840px;  height:500px; display:block; padding: 0px 120px;}
.controlls_prev:hover, .controlls_next:hover{background-color: #f3f3f3; border-radius: 3px}
.controlls_prev, .controlls_next{    
	font-size: 25px;
    width: 40px;
    height: 518px;
    line-height: 320px;
    text-align: center;
    position: relative;
    top: 0px;}
.controlls_next{
        float: left;
    left: 878px;
    top: -520px;
    line-height: 520px;
    height: 518px;}
.reportpopup{display: none;}
#pup_wrap_report{display: none;}
#pup_wrap_share{display: none;}
#pup_wrap_share .list_title{width: 100%;}
#snsList li{float: left;}
#vIconTw, #vIconTg, #vIconFb, #vIconKs{ position: relative; box-shadow: none; border: none;
	border-radius: inherit; margin: 0; padding: 0; line-height: inherit; height: inherit;
	width: 40px; height: 40px; font-size:0; }
.snsList li {margin:0 10px;}
.pup_body{height: inherit;}
#pup_wrap_share .list_title{margin: 0 auto; width: max-content}
.snsList li a::before { content: ""; display: block; position: absolute; width: 40px; height: 40px; }
#vIconTw::before { background: url(/home/img/house/twt.png) no-repeat; background-size: cover;}
#vIconTg::before { background: url(/home/img/house/telegram.png) no-repeat; background-size: cover; }
#vIconFb::before { background: url(/home/img/house/facebook.png) no-repeat; background-size: cover; }
#vIconKs::before { background: url(/home/img/house/kakaostory.jpg) no-repeat; background-size: cover; }
</style>    	
<div class="wrap">
 <div class="houseViewContent">
 	<div id="topDiv">
 		<div id="dateDiv" class="m_title"> ${hVO.housename } </div>
	 	<input type="hidden" value="${hVO.userid }"/>
	 	<input type="hidden" value="${logId }"/>
	 	<div id="btnDiv"> <!-- 수정, 삭제는 본인의 글을 볼 경우에만 -->
		 	<c:if test="${logId==hVO.userid }">
	 		<a id="hEdit" class="white" href="houseEdit?no=${hVO.no }" >수정</a> 
	 		<a class="white" id="houseDel" >삭제</a> 
	 		</c:if>
	 		<c:if test="${logId!=null }">
	 		<c:if test="${logId!=hVO.userid }">
	 		 <a class="reportBtn" id="reportBtn">
				<img style="margin: 0px 10px;" title="신고" alt="신고" src="<%=request.getContextPath()%>/img/comm/ico_report.png">
			</a>
			</c:if>
			</c:if>
 		</div>
 		<div class="slide_Img">
 			<div class="controlls_prev">◀</div>
	      	<div class="slide_wraper">
	         	<div class="slides">
	            	<ul>
		               <li><img src="/home/housePic/${hVO.housepic1}" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_house_pic.png'"></li>
		               <c:if test="${hVO.housepic2 != null}">
		               <li><img src="/home/housePic/${hVO.housepic2}" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_house_pic.png'"></li>
		               </c:if>
		                <c:if test="${hVO.housepic3 != null}">
		               <li><img src="/home/housePic/${hVO.housepic3}" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_house_pic.png'"></li>
		               </c:if>
		                <c:if test="${hVO.housepic4 != null}">
		               <li><img src="/home/housePic/${hVO.housepic4}" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_house_pic.png'"></li>
		               </c:if>
		                <c:if test="${hVO.housepic5 != null}">
		               <li><img src="/home/housePic/${hVO.housepic5}" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_house_pic.png'"></li>
		               </c:if>
	           		</ul>
	         	</div> <!-- "slides" -->
			</div> <!--slide_wraper -->
			<div class="controlls_next">▶</div>
		</div>
		<div  id="peopleExplain">
			<ul>
				<li ><img src="/home/profilePic/${memProfilePic}" id="profilepic" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_mate_pic.png'"/> </li>
				<li>${hVO.userid }</li>
				<c:if test="${logGrade != null }">
				<c:if test="${pVO_log.pcase == 'm' }">
				<li><button class="q_btn green applyInsert" >신청하기</button></li>
				</c:if>
				</c:if>
				<c:if test="${logId!=null }">
				<c:if test="${logId!=hVO.userid }">
				<li><button class="q_btn white likeInsert">찜하기</button> </li>
				</c:if>
				</c:if>
				<li><button class="q_btn white" id="shareBtn" >공유하기</button></li>
			</ul>
		</div> <!-- peopleExplain div 종료 -->
 	</div> <!-- topDiv 종료 -->
	
	<div id="middle_Div">
		<div class="middle_houseInfo" id="house_profile">
			<p class="s_title">하우스 소개</p>
			<div>
				${hVO.houseprofile }
			</div>
		</div>
		<div class="middle_houseInfo" id="room_info">
			<p class="s_title">룸 정보</p>
			<table class="tb">
			<thead>
				<tr>
					<th>룸</th>
					<th>보증금</th>
					<th>월세</th>
					<th>입주가능일</th>
					<th>최소거주기간</th>
					<th>최대거주기간</th>
					<th>가구</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="r" items="${rVO_List }">
					<tr>
						<td>${r.roomName } / ${r.roomPeople}인실</td>
						<td>${r.deposit }</td>
						<td>${r.rent }</td>
						<td>${r.enterdate }</td>
						<td>${r.minStay }</td>
						<td>${r.maxStay }</td>
						<td>
							<c:if test="${r.furniture == 1 }">${r.incFurniture }</c:if>
							<c:if test="${r.furniture == 2 }">포함가구 없음</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			</table>
		</div>
		<div class="middle_houseInfo" id="facility_info">
			<p class="s_title">시설 정보</p>
			<c:set var="publicfacility" value="${fn:split(hVO.publicfacility,',')}"/>
			<div>
			<c:forEach var="p1" items="${publicfacility }">
				<c:if test="${p1 == '냉장고'}">
				<ul>
					<li><img src="/home/img/houseView/refrigerator_icon.svg"/></li>
					<li>냉장고</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '정수기'}">
				<ul>
					<li><img src="/home/img/houseView/cooler_icon.svg"/></li>
					<li>정수기</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '가스레인지'}">
				<ul>
					<li><img src="/home/img/houseView/stove_icon.svg"/></li>
					<li>가스레인지</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '밥솥'}">
				<ul>
					<li><img src="/home/img/houseView/ricecooker_icon.svg"/></li>
					<li>밥솥</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '식기세척기'}">
				<ul>
					<li><img src="/home/img/houseView/dishwasher_icon.svg"/></li>
					<li>식기세척기</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '냄비'}">
				<ul>
					<li><img src="/home/img/houseView/cookingpot_icon.svg"/></li>
					<li>냄비</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '프라이팬'}">
				<ul>
					<li><img src="/home/img/houseView/frying_pan_icon.svg"/></li>
					<li>프라이팬</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '토스트기'}">
				<ul>
					<li><img src="/home/img/houseView/toaster_icon.svg"/></li>
					<li>토스트기</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '소파'}">
				<ul>
					<li><img src="/home/img/houseView/sofa_icon.svg"/></li>
					<li>소파</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '티비'}">
				<ul>
					<li><img src="/home/img/houseView/television_icon.svg"/></li>
					<li>티비</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '탁자'}">
				<ul>
					<li><img src="/home/img/houseView/dinning_table_icon.svg"/></li>
					<li>탁자</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '카펫'}">
				<ul>
					<li><img src="/home/img/houseView/carpet_icon.svg"/></li>
					<li>카펫</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '욕조'}">
				<ul>
					<li><img src="/home/img/houseView/bathtub_icon.svg"/></li>
					<li>욕조</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '비데'}">
				<ul>
					<li><img src="/home/img/houseView/toilet_icon.svg"/></li>
					<li>비데</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '샴푸'}">
				<ul>
					<li><img src="/home/img/houseView/liquid_icon.svg"/></li>
					<li>샴푸</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '린스'}">
				<ul>
					<li><img src="/home/img/houseView/liquid_icon.svg"/></li>
					<li>린스</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '세탁기'}">
				<ul>
					<li><img src="/home/img/houseView/washing_machine_icon.svg"/></li>
					<li>세탁기</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '건조기'}">
				<ul>
					<li><img src="/home/img/houseView/drying_machine_icon.svg"/></li>
					<li>건조기</li>
				</ul>
				</c:if>
				<c:if test="${p1 == '베란다'}">
				<ul>
					<li><img src="/home/img/houseView/balcony_icon.svg"/></li>
					<li>베란다</li>
				</ul>
				</c:if>
				<c:if test="${p1 == 'WIFI'}">
				<ul>
					<li><img src="/home/img/houseView/wifi_icon.svg"/></li>
					<li>WIFI</li>
				</ul>
				</c:if>
				</c:forEach>
			</div>
		</div>
		<div id="propensity_info">
			<div class="propensity_info_house">
				<p class="s_title"> [${hVO.housename }] 하우스 성향</p>
				<ul>
					<li>생활 소음</li>
					<li><c:if test="${pVO.h_noise=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						매우 조용함</li>
					<li><c:if test="${pVO.h_noise=='2' }"> <img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						보통</li>
					<li><c:if test="${pVO.h_noise=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						조용하지 않음</li>
				</ul>
				<ul>
					<li>생활 시간</li>
					<li><c:if test="${pVO.h_pattern=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						주행성</li>
					<li><c:if test="${pVO.h_pattern=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						야행성</li>
					<li></li>
				</ul>
				<ul>
					<li>반려동물 여부</li>
					<li><c:if test="${pVO.h_pet=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						없음</li>
					<li><c:if test="${pVO.h_pet=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						있음</li>
					<li></li>
				</ul>
				<ul>
					<li>반려동물 동반 입실 여부</li>
					<li><c:if test="${pVO.h_petwith=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						불가능</li>
					<li><c:if test="${pVO.h_petwith=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						가능</li>
					<li></li>
				</ul>
				<ul>
					<li>흡연 여부</li>
					<li><c:if test="${pVO.h_smoke=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						비흡연</li>
					<li><c:if test="${pVO.h_smoke=='2' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						실외흡연</li>
					<li><c:if test="${pVO.h_smoke=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						실내흡연</li>
				</ul>
				<ul>
					<li>분위기</li>
					<li><c:if test="${pVO.h_mood=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						화목함</li>
					<li><c:if test="${pVO.h_mood=='2' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						보통</li>
					<li><c:if test="${pVO.h_mood=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						독립적</li>
				</ul>
				<ul>
					<li>소통방식</li>
					<li><c:if test="${pVO.h_communication=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						메신저</li>
					<li><c:if test="${pVO.h_communication=='2' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						기타</li>
					<li><c:if test="${pVO.h_communication=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						대화</li>
				</ul>
				<ul>
					<li>모임빈도</li>
					<li><c:if test="${pVO.h_party=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						없음</li>
					<li><c:if test="${pVO.h_party=='2' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						상관없음</li>
					<li><c:if test="${pVO.h_party=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						있음</li>
				</ul>
				<ul>
					<li>모임참가 의무</li>
					<li><c:if test="${pVO.h_enter=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						없음</li>
					<li><c:if test="${pVO.h_enter=='2' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						상관없음</li>
					<li><c:if test="${pVO.h_enter=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						있음</li>
				</ul>
				<ul>
				<c:forEach var="i" items="${pVO.h_support }">
					<c:if test="${i == 1}"><c:set var='support1' value="${i }"></c:set></c:if>
					<c:if test="${i == 2}"><c:set var='support2' value="${i }"></c:set></c:if>
					<c:if test="${i == 3}"><c:set var='support3' value="${i }"></c:set></c:if>
				</c:forEach>
					<li>하우스 지원</li>
					<c:if test="${support1!=null }">
						<li><img src="/home/img/comm/check-mark.svg" class="checkSvg"/>공용공간청소</li>
					</c:if>
					<c:if test="${support1==null }">
						<li>공용공간청소</li>
					</c:if>
					<c:if test="${support2!=null }">
						<li><img src="/home/img/comm/check-mark.svg" class="checkSvg"/>공용생필품</li>
					</c:if>
					<c:if test="${support2==null }">
						<li>공용생필품</li>
					</c:if>
					<c:if test="${support3!=null }">
						<li><img src="/home/img/comm/check-mark.svg" class="checkSvg"/>기본 식품</li>
					</c:if>
					<c:if test="${support3==null }">
						<li>기본 식품</li>
					</c:if>
				</ul>
				<ul>
					<c:forEach var="j" items="${pVO.h_etc }">
					<c:if test="${j == 1}"><c:set var='etc1' value="${j }"></c:set></c:if>
					<c:if test="${j == 3}"><c:set var='etc3' value="${j }"></c:set></c:if>
				</c:forEach>
					<li>기타 사항</li>
					<c:if test="${etc1!=null }">
						<li><img src="/home/img/comm/check-mark.svg" class="checkSvg"/>보증금조절</li>
					</c:if>
					<c:if test="${etc1==null }">
						<li>보증금조절</li>
					</c:if>
					<c:if test="${etc3!=null }">
						<li><img src="/home/img/comm/check-mark.svg" class="checkSvg"/>즉시입주</li>
					</c:if>
					<c:if test="${etc3==null }">
						<li>즉시입주</li>
					</c:if>					
				</ul>
			</div>
			<div class="propensity_info_mate">
				<p class="s_title">희망 메이트</p>
				<ul>
					<li>생활 시간</li>
					<li><c:if test="${pVO.m_pattern=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						주행성</li>
					<li><c:if test="${pVO.m_pattern=='2' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						야행성</li>
					<li></li>
				</ul>
				<ul>
					<li>성격</li>
					<li><c:if test="${pVO.m_personality=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						내향적</li>
					<li><c:if test="${pVO.m_personality=='2' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						상관없음</li>
					<li><c:if test="${pVO.m_personality=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						외향적</li>
				</ul>
				<ul>
					<li>반려동물</li>
					<li><c:if test="${pVO.m_pet=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						긍정적</li>
					<li><c:if test="${pVO.m_pet=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						부정적</li>
					<li></li>
				</ul>
				<ul>
					<li>흡연여부</li>
					<li><c:if test="${pVO.m_smoke=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						비흡연</li>
					<li><c:if test="${pVO.m_smoke=='2' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						상관없음</li>
					<li><c:if test="${pVO.m_smoke=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						흡연</li>
				</ul>
				<ul>
					<li>나이대</li>
					<li><c:if test="${pVO.m_age=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						20~30대</li>
					<li><c:if test="${pVO.m_age=='2' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						상관없음</li>
					<li><c:if test="${pVO.m_age=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						40대 이상</li>
				</ul>
				<ul>
					<li>성별</li>
					<li><c:if test="${pVO.m_gender=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						여성</li>
					<li><c:if test="${pVO.m_gender=='2' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						상관없음</li>
					<li><c:if test="${pVO.m_gender=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						남성</li>
				</ul>
				<ul>
					<li>외국인 입주여부</li>
					<li><c:if test="${pVO.m_global=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						가능</li>
					<li><c:if test="${pVO.m_global=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						불가능</li>
					<li></li>
				</ul>
				<ul>
					<li>즉시입주여부</li>
					<li><c:if test="${pVO.m_now=='1' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						가능</li>
					<li><c:if test="${pVO.m_now=='3' }"><img src="/home/img/comm/check-mark.svg" class="checkSvg"/></c:if>
						불가능</li>
					<li></li>
				</ul>
				<ul><li></li><li></li><li></li><li></li></ul>
				<ul><li></li><li></li><li></li><li></li></ul>
				<ul><li></li><li></li><li></li><li></li></ul>
			</div>
		</div>
		<!--1.본인 글이 아닐것 (pVO.userid != logId)  ,  -->
		<!-- 2.로그인한 사람이 grade-2 일것( mVO_log.grade ) , -->
		<!-- 3.로그인한 사람이 mate로 pno가 있을 것. (pVO_log.pno != null ) -->
		<c:if test="${pVO.userid != logId}">
			<c:if test="${mVO_log.grade==2 }">
			<c:if test="${logGrade == null }">
			<c:if test="${pVO_log.pno != null }">
			<div class="matchin_Graph">
				<div>
					<div>
						<p class="s_title">[ ${logId }  -  ${hVO.housename } ] 매칭</p>
					</div>
					<div>
						<canvas id="matchingChart" height="300" width="300" ></canvas>
					</div>
				</div>
				<div class="matching_result">
					<div><p class="s_title">매칭 결과</p></div>
					<ul>
						<li>
							<span>생 활</span> <span> : </span><c:if test="${graph_matching.life == 0}">맞지 않음</c:if>
								<c:if test="${graph_matching.life == 1}">보통</c:if>
								<c:if test="${graph_matching.life == 2}">잘 맞음</c:if>
						</li>
						<li>
							<span>반 려 동 물</span> <span> : </span> <c:if test="${graph_matching.pet == 0}">맞지 않음</c:if>
								<c:if test="${graph_matching.pet == 1}">보통</c:if>
								<c:if test="${graph_matching.pet == 2}">잘 맞음</c:if>
						</li>
						<li>
							<span>소 통, 모 임</span> <span> : </span> <c:if test="${graph_matching.communicate == 0}">맞지 않음</c:if>
								<c:if test="${graph_matching.communicate == 1}">보통</c:if>
								<c:if test="${graph_matching.communicate == 2}">잘 맞음</c:if>
						</li>
						<li>
							<span>흡 연</span> <span> : </span> <c:if test="${graph_matching.smoke == 0}">맞지 않음</c:if>
								<c:if test="${graph_matching.smoke == 1}">보통</c:if>
								<c:if test="${graph_matching.smoke == 2}">잘 맞음</c:if>
						</li>
						<li>
							<span>성 격</span> <span> : </span> <c:if test="${graph_matching.personality == 0}">맞지 않음</c:if>
								<c:if test="${graph_matching.personality == 1}">보통</c:if>
								<c:if test="${graph_matching.personality == 2}">잘 맞음</c:if>
						</li>
						<li>
							<span>입 주</span> <span> : </span> <c:if test="${graph_matching.now == 0}">입주일 조정 필요</c:if>
								<c:if test="${graph_matching.now == 1}">보통</c:if>
								<c:if test="${graph_matching.now == 2}">잘 맞음</c:if>
						</li>
						<li>${graph_matching.score } %</li>
					</ul>
				</div>
			</div>
			</c:if>
			</c:if>
			</c:if>
		</c:if>
	</div> <!-- middleFrm div 종료 -->
<!-- 	<div id="map_Div"> -->
<!-- 	지도 부분 -->
	<div id="map_Div" style="height: 350px; width: 100%;  border-radius: 3px; border: 1px solid #ddd; position: relative; 
	 top: -410px;"></div> <!-- map_Div div종료 -->
<!-- 	</div> map_Div div종료 -->
</div> <!-- content div 종료 -->
</div> <!-- 전체div 종료 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6bad1d8e9a1449ac5fb2b238e99a32ed&libraries=clusterer,services"></script>
<script>
	var mapContainer = document.getElementById('map_Div'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	var geocoder = new kakao.maps.services.Geocoder();
	// 주소로 좌표를 검색합니다
    geocoder.addressSearch('${hVO.addr}', function(result, status) {
        // 정상적으로 검색이 완료됐으면
         if (status === kakao.maps.services.Status.OK) {
          var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
          map.setCenter(coords);
          
          var imageSrc = '<%=request.getContextPath()%>/img/comm/map_marker.png', // 마커이미지의 주소입니다
          imageSize = new kakao.maps.Size(29, 41), // 마커이미지의 크기입니다
          imageOption = {
             offset : new kakao.maps.Point(15, 30)
          }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

          // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
          var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
          imageOption), markerPosition = coords; // 마커가 표시될 위치입니다

            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                image: markerImage,
                zIndex : 11,
                position: coords
            });
        }
      	// min값만큼 확대
         map.setMinLevel(3); // 50m
         // max값만큼 확대
         map.setMaxLevel(7); // 1km
    });
    
    
</script>
<!-- 		<div class="pup_wrap" id="pup_wrap_report"> -->
		
<!-- 		<div class="pup_form"> -->
<!-- 			<div class="pup_head">신고하기</div> -->
<!-- 			<div class="pup_body"> -->
			
<!-- 			<div class="pup_list"> -->
<!-- 				<div class="list_img"> -->
<%-- 					<img src="<%=request.getContextPath()%>/img/house/house01.jfif" id="reportPic" /> --%>
<!-- 				</div> -->
<!-- 				<div class="list_title"> -->
<!-- 						<p class="s_title">house addr</p> -->
<!-- 						<p class="d_title">즉시입주 가능 / 1명 구해요</p> -->
<!-- 						<p class="d_title">월세 가격 / 보증금</p>  -->
<!-- 						<p class="d_title">신고사유  -->
<!-- 							<select> -->
<!-- 								<option> 허위매물 </option> -->
<!-- 								<option> 기간만료 </option> -->
<!-- 								<option> 광고물 </option> -->
<!-- 							</select> </p> -->
<!-- 						<p class="d_title">상세 사유 <textarea cols="30"></textarea></p> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="pup_bottom"> -->
<!-- 				<a href="" class="btn_cancel">닫기</a> -->
<!-- 				<a href="" class="btn_save">신고하기</a> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 			<a href="" class="btn_close">닫기</a> -->
<!-- 		</div> -->
<!-- 	</div> -->


	<!--  팝업창///////////////////////////////////////////// -->
<div class="pup_wrap reportpopup">
	<div class="pup_form">
		<form id="reportForm" method="post">
			<div class="pup_head">신고 정보</div>
			<div class="pup_body">
				<div class="pup_list">
					<ul>
						<li><div>신고 ID</div><input class="userid" type="text" name="userid" readonly></li>
						<li><div>신고자 ID</div> <input type="text" name="reportid" value="${logId}" readonly> </li>
						<li>
							<div>분류</div> <input class="reportCategory" type="text" name="category" value="하우스" readonly>
							<input type="hidden" class="reportNum" name="no"><!-- 글/댓글번호 -->
						</li>
						<li><div>신고 사유</div>
							<select id="reportcategory" name="reportcategory">
								<option disabled selected hidden>신고사유를 선택하세요</option>
								<option>홍보,광고</option>
								<option>음란</option>
								<option>욕설</option>
								<option>기타</option>
							</select>
						</li>
						<li><div>상세내용</div> <textarea rows="5" id="reportcontent" name="reportcontent"></textarea></li>
					</ul>
				
				</div>
			</div>
			<div class="pup_bottom">
				<a class="btn_cancel popupClose">닫기</a>
				<a href="javascript:$('#reportForm').submit()" id="reportSubmit" class="btn_save">접수</a>
<!-- 				 -->
			</div>
			<a class="pup_btn_close popupClose">닫기</a>
		</form>
	</div>
</div>
		<div class="pup_wrap" id="pup_wrap_share">
			<div class="pup_form">
				<div class="pup_head">공유하기</div>
				<div class="pup_body">
					
						<div class="list_title">
							<ul id="snsList" class="snsList">
							<li><a href="#" id="vIconTw" onclick="return false;">트위터</a></li>
							<li><a href="#" id="vIconTg" onclick="return false;">텔레그램</a> </li>
							<li><a href="#" id="vIconFb" onclick="return false;">페이스북</a></li>
							<li><a href="#" id="vIconKs" onclick="return false;">카카오스토리</a></li>
							</ul>
						</div>
					</div>
					<div class="pup_bottom">
						<a class="btn_cancel shareClose">닫기</a>
					</div>
				<a class="btn_close shareClose">닫기</a>
			</div>
		</div>
<script>
    $(function(){

    	$("#houseDel").click(()=>{
			if(confirm("하우스를 삭제하시겠습니까?")){
				location.href="houseDel?no=${hVO.no }" 
				alert("하우스가 삭제되었습니다.");
			}else{
				alert("삭제가 취소되었습니다.");
			};
		});
        $('#hEdit').click(function(){ //수정하기 버튼
        	location.href="houseEdit"; //방수정하기 form 으로 이동
        });
        
		$("#shareBtn").click(function(){ //공유하기 버튼 공유하기팝업창
			$("#pup_wrap_share").css("display", "block");
		});
		$(".pup_wrap_share_close").click(function(){ //공유하기 버튼 공유하기팝업창
			$("#pup_wrap_share").css("display", "none");
		});
		
     var slides = document.querySelector('.slides'),
     slide = document.querySelectorAll('.slides li'),
     currentIdx =0,   //현재인덱스
     slideCount = slide.length, //슬라이드의 갯수
     prevBtn = document.querySelector('.controlls_prev'),
     nextBtn = document.querySelector('.controlls_next');
     slideWidth = 840,
     slideMargin = 0,

     
     slides.style.width = (slideWidth + slideMargin)*slideCount - slideMargin +'px'; //슬라이드의 넓이
     
     function moveSlide(num){
        slides.style.left = -num * 840 +'px';
        currentIdx = num;
     }
     
     //이미지 슬라이드 버튼이벤트
     nextBtn.addEventListener('click',function(){
        console.log(currentIdx);
        if(currentIdx < slideCount - 1){
           moveSlide(currentIdx + 1);
        }
     });
     prevBtn.addEventListener('click',function(){
        if(currentIdx >0){
           moveSlide(currentIdx - 1);
        }
     });
     
   });

    //공유하기================================================
    	$(document).on('click', '.shareClose', function(){
    		$("#pup_wrap_share").css('display', 'none');
	});
    	
    	
	//신고하기=================================================
	$(document).on('click','#reportBtn', function(){
		var	reportid = '${hVO.userid}';
		var category = '하우스';
		var no = '${hVO.no}';
		report(reportid, category, no);
	});
	
	//신고하기 창 띄우고 값 가져오는 함수
	function report(reportid, category, no){
		//값 가져오기
		$(".userid").val(reportid);
		$(".reportCategory").val(category);
		$(".reportNum").val(no);
		$('.reportpopup').css('postion','relative');
		$('.reportpopup').css('z-index','999');
		$('.reportpopup').css('display','block');
		$('body').css('overflow','hidden');
	}
	//신고하기 팝업창 닫기
	$(document).on('click', '.popupClose', function(){
		reportFormReset();
	});
	function reportFormReset(){
		//값 초기화
		$(".userid").val("");
		$(".reportCategory").val("");
		$(".reportNum").val("");
		$("#reportcontent").val("");
		$("#reportcategory option:eq(0)").prop('selected', true);
		$('.reportpopup').css('display','none');
		$('body').css('overflow','auto');
	}
	//신고하기 서브밋
	$(document).on('submit','#reportForm',function(){
		if($("#reportcategory option").index($("#reportcategory option:selected"))==0){
			alert("신고사유를 선택하세요.");
			return false;
		}
		if($("#reportcontent").val()==''){
			alert("상세내용을 입력해주세요.");
			return false;
		}
		var url = '/home/reportInsert'
		var params = $(this).serialize();
		
		$.ajax({
			url : url,
			data : params,
			success : function(result){
				alert("신고가 정상적으로 접수되었습니다.");
				reportFormReset();
			},error : function(){
				alert("신고접수에 실패했습니다..");
			}
		});//ajax end
		return false;
	});

    

    $(window).ready(function(){  //공유하기 팝업창
        $(".snsList li a").click(function(){
			shareAct(this);
  		});
  });
    
    function shareAct(a){ //공유하기
  
        var snsCode = $(a).attr('id');
        var cUrl = document.location.href; console.log(cUrl);
  
        switch(snsCode){
  
            case"vIconTw": //트위터
                cUrl = 'https://twitter.com/intent/tweet?text=페이지제목:&url='+cUrl;
            break;
  
            case"vIconTg": //텔레그램
                cUrl = 'https://telegram.me/share/url?url='+cUrl;
            break;
                  
            case"vIconFb": //페이스북
                cUrl = 'http://www.facebook.com/sharer/sharer.php?u='+cUrl;
            break;
  
            case"vIconKs": //카카오스토리
                cUrl = 'https://story.kakao.com/share?url='+cUrl;
            break;
  			}
  		window.open(cUrl,'','width=700,height=500,top=300,left=450,scrollbars=yes');
		}
    

</script>