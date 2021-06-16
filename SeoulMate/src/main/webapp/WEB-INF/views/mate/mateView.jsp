<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.2.0/chart.min.js" integrity="sha512-VMsZqo0ar06BMtg0tPsdgRADvl0kDHpTbugCBBrL55KmucH6hP9zWdLIWY//OTfMnzz6xWQRxQqsUFefwHuHyg==" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/yun.css">
<style>
#topDiv{ width: 1229px; margin-bottom: 30px; height: 620px; position: relative;}
#topDiv>img{height: 200px; width: 200px;}
.mateViewContent{width: 1230px; margin: 40px auto; overflow: hidden;}
#dateDiv{float: left; height: 50px; line-height: 50px; }
#btnDiv{float: right;
    height: 90px;
    overflow: auto;
    line-height: 90px;}
#peopleExplain{    position: relative;
    float: right;
    top: -430px;
    width: 300px;
    height: 520px;
    border: 1px solid #ddd;
    border-radius: 3px;
    background-color: #fff; }
#peopleExplain img{width: 270px; height: 270px;}
#peopleExplain li{width: 90%;
    margin: 5px auto;
    text-align: center;}
#peopleExplain li>button{height: 45px; line-height: 45px;}
#peopleExplain li:first-of-type{ margin: 10px auto;}
#peopleExplain li:nth-of-type(2){font-size: 1.5em;}
#profilePic1{width:150px; height:150px; margin-top: 5px;}

#middle_Div{overflow: auto; 
	border-radius: 3px; border: 1px solid #ddd;
    position: relative;
    left: 0px;
    top: -420px;
    width: 100%;}
.middle_mateInfo, #propensity_info, .matchin_Graph{
    width: 80%;
    margin: 40px auto;
}
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
#mate_profile, #room_info{padding-bottom: 40px;}
.propensity_info_house,  .propensity_info_mate{border: 1px solid #ddd; border-radius: 3px; }
.propensity_info_house{width: 54%; float: right;}
.propensity_info_mate{width: 45%; float: left;}
.checkSvg{  width: 15px;
    height: 15px;line-height:40px;
	filter: invert(51%) sepia(100%) saturate(1626%) hue-rotate(137deg) brightness(88%) contrast(85%);}
.matchin_Graph{overflow: auto;}
.matchin_Graph>div:first-of-type{width: 54%; height: 560px; float: left; border:1px solid #ddd; border-radius: 5px;}
.matchin_Graph>div:first-of-type>div:last-of-type{width: 430px; height: 430px; margin: auto;}
.matchin_Graph>div>div:first-of-type{margin-left: 30px; overflow: auto;}
.matching_result{width: 45%;height: 560px; float: right; border:1px solid #ddd; border-radius: 5px;}
.matching_result>ul{margin-left: 30px;}
.matching_result>ul>li{height: 40px; line-height: 40px; width: 80%; margin: 0px auto; }
.matching_result>ul>li>span:first-of-type{display: inline-block; width: 80px; text-align: justify; text-align-last: justify;
	font-weight: bold; font-weight: bold; font-size: 1.1em;}
.matching_result>ul>li>span:nth-of-type(2){display: inline-block; width: 20px; text-align: center;}
.matching_result>ul>li:last-of-type{ width: 60%; border:1px solid #13a89e; border-radius: 10px; margin: 30px auto;
height:140px; line-height: 140px; font-size:4em; text-align: center; font-weight:bold; color:#fff;  background-color: #13a89e;}
.alert_pop{width: 350px; height: 200px; background-color: #fff; border-radius: 20px;
	position: absolute; top:20%; left:40%; box-shadow: 4px 3px 10px 0px rgb(0 0 0 / 15%); z-index: 12; }
.alert_pop_Title{padding-left: 20px; width: 100%; height: 30px; line-height: 30px; 
	background-color: #fff; border-radius: 20px 20px 0px 0px; font-size: 1.2em;
    box-shadow: 0px 6px 10px 0px rgb(0 0 0 / 10%);
	}
.alert_pop_footer{text-align: center; height: 50px; box-shadow: 0px -5px 11px 0px rgb(0 0 0 / 10%); 
	border-radius: 0px 0px 20px 20px; background-color: #fff; }
.alert_pop_footer>p { width: 100px; height: 30px; line-height: 30px; font-size:1em; background-color: #ddd; border-radius: 5px;
	box-shadow: 4px 3px 10px 0px rgb(0 0 0 / 15%); margin-top: 10px; display: inline-block; cursor: pointer;}
.alert_pop_Title>span{float: right; padding-right: 20px;  cursor: pointer;}
.alert_pop_Content{ width: 100%; height: 120px;	padding:20px; }
#inviteInsertBtn{height: 40px; line-height: 40px; margin-left: 10px; position: absolute;}
#invitetTitle{font-size: 1.2em; font-weight: bold; margin-bottom: 10px;}
#sendInvitehousename{margin-right: 10px; width: 200px;}
.objectHidden{display: none;}
.popup_Stop_Scroll{overflow: hidden; height: 100%; }
.myPage_HouseAndMate_Popup_FullScreen{width: 100%; height: 100%; background-color: #ddd; opacity: 0.5;
	position: fixed; top:0; left: 0; z-index: 10;}
/* 슬라이드 */
.slide_Img{
    position: relative;
    top: 90px;
    width: 920px;
    height: 520px; border-radius: 3px; border: 1px solid #ddd;}
.slide_wraper{height: 500px;
    width: 840px;
    overflow: hidden;
    top: 10px;
    left: 40px;
    position: absolute;}
.slides{
   position:relative; top:0; left:0; width:100%; height:100%;
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
#selectHousename{float: right; margin: 30px 20px 40px 0px;}
#matchin_housename{float:left;}
 /* 신고하기 */
.reportpopup{display: none;}

.report{
    position: absolute;
    right: 250px;
    bottom: 50px;
    margin: 0 auto;
}
#reportS{width: 135px; height: 35px;}
#pup_wrap_report{display: none;}
#pup_wrap_share{display: none;}
#pup_wrap_share .list_title{width: 100%;}
#snsList li{float: left;}

#vIconTw, #vIconTg, #vIconFb, #vIconKs{
	position: relative;
	box-shadow: none;
	border: none;
	border-radius: inherit;
	margin: 0;
	padding: 0;
	line-height: inherit;
	height: inherit;
	width: 40px;
	height: 40px;
	font-size:0;
}
.snsList li {margin:0 10px;}
.pup_body{height: inherit;}
#pup_wrap_share .list_title{margin: 0 auto; width: max-content}
.snsList li a::before {
	content: "";
	display: block;
	position: absolute;
	width: 40px;
	height: 40px;
}
#vIconTw::before {
	background: url(/home/img/house/twt.png) no-repeat;
	background-size: cover;
}
#vIconTg::before {
	background: url(/home/img/house/telegram.png) no-repeat;
	background-size: cover;
}
#vIconFb::before {
	background: url(/home/img/house/facebook.png) no-repeat;
	background-size: cover;
}
#vIconKs::before {
	background: url(/home/img/house/kakaostory.jpg) no-repeat;
	background-size: cover;
}
</style>
<script>
$(()=>{
		
	$("#mateDel").click(()=>{
		if(confirm("삭제하시겠습니까?")){
			location.href="mateDel?no=${mVO.no }" 
		};
	});
	var houselistSize = '<c:out value="${fn:length(pVO_log)}"/>';
	var checkPno = 0;
	if(houselistSize>0){
		var checkPno = '<c:out value="${pVO_log[0].pno}"/>';
		MatchingGraph(checkPno);
	}
	$(document).on('change', '#selectHousename', function(){
		console.log($(this).val());
		checkPno = $(this).val(); 
		$('#matchingChartDiv').empty();
		var tag = '<canvas id="matchingChart" height="300" width="300" ></canvas>';
		$('#matchingChartDiv').html(tag);
		MatchingGraph(checkPno);
	});
	function MatchingGraph(checkPno){
		var logId = '<c:out value="${logId}"/>';
		var logGrade = '<c:out value="${logGrade}"/>';
		
		var housePnoList = [];
		var listSize = '<c:out value="${fn:length(graph_matching_List)}"/>';
		var pnoList = []; var housenameList = []; var lifeList = []; var petList=[]; var smokeList = [];
		var communicateList = []; var personalityList = []; var nowList = [];
		<c:forEach items="${graph_matching_List}" var="list" >
			pnoList.push("${list.pno}");
			housenameList.push("${list.housename}");
			lifeList.push("${list.life}");
			petList.push("${list.pet}");
			communicateList.push("${list.communicate}");
			smokeList.push("${list.smoke}");
			personalityList.push("${list.personality}");
			nowList.push("${list.now}");
		</c:forEach>
		
		var scorePnoList = []; var scoreList = [];
		<c:forEach items="${score_List}" var="sList" >
			scorePnoList.push("${sList.pno}");
			scoreList.push("${sList.score}");
		</c:forEach>
		
		console.log('scorePnoList='+scorePnoList);
		console.log('scoreList='+scoreList);
		var GraphIdx = 0;
		var scoreIdx = 0;
		for (var i = 0; i < listSize; i++) {
			if(pnoList[i] == checkPno){
				GraphIdx=i;
			}
			if(scorePnoList[i] == checkPno){
				scoreIdx=i;
			}
		}
		
		var housename = housenameList[GraphIdx];
		var life = lifeList[GraphIdx];
		var pet = petList[GraphIdx];
		var communicate=communicateList[GraphIdx];
		var smoke= smokeList[GraphIdx];
		var personality= personalityList[GraphIdx];
		var now = nowList[GraphIdx];
		var score = scoreList[scoreIdx];
console.log(housename);
console.log(score);
		if(housename.length>13){
			housename = housename.substr(0,13)+"...";
		}
		$('#housenameText').text(housename);
		$('#scoreText').text(score);
		
		if(life==0){ $('#lifeText').text('맞지 앉음');}
		else if(life==1){$('#lifeText').text('보통');}
		else if(life==2){$('#lifeText').text('잘맞음');}
		
		
		
		if(pet==0){ $('#petText').text('맞지 앉음');}
		else if(pet==1){$('#petText').text('보통');}
		else if(pet==2){$('#petText').text('잘맞음');}
		
		if(communicate==0){ $('#communicateText').text('맞지 앉음');}
		else if(communicate==1){$('#communicateText').text('보통');}
		else if(communicate==2){$('#communicateText').text('잘맞음');}
		
		if(smoke==0){ $('#smokeText').text('맞지 앉음');}
		else if(smoke==1){$('#smokeText').text('보통');}
		else if(smoke==2){$('#smokeText').text('잘맞음');}
		
		if(personality==0){ $('#personalityText').text('맞지 앉음');}
		else if(personality==1){$('#personalityText').text('보통');}
		else if(personality==2){$('#personalityText').text('잘맞음');}
		
		if(now==0){ $('#nowText').text('입주일 조정 필요');}
		else if(now==1){$('#nowText').text('보통');}
		else if(now==2){$('#nowText').text('잘맞음');}
		
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
  	}
	
	$(document).on('click','#sendInviteBtn', function(){
		// 초대하기 버튼 눌렀을 경우. 
		${pVO.userid != logId }
		var userid = '<c:out value="${pVO.userid}"/>';
		var logId = '<c:out value="${logId }"/>';
		if(userid == logId){
			alert('본인이 작성한 글입니다.\n초대가 불가합니다.');
		}else{
			$("#alert_pop").removeClass("objectHidden");
			$("#myPage_popup_FullScreen").removeClass('objectHidden');
			$('body').addClass('popup_Stop_Scroll');
		}
		
	});
	$(document).on('click','#inviteInsertBtn', function(){
		var userid = '<c:out value="${mVO.userid}"/>';; //메이트의 아이디
		var msg = '초대';
		var housename =  $("select[name='sendInvitehousename']").val(); //셀렉트박스에 클릭한 하우스네임. 
		
		var url = '/home/inviteInsert';
		var data = {"msg":msg, "userid":userid, "housename":housename};
		$.ajax({
			url : url,
			data : data,
			success : function(result){
				if(result>0){
					console.log('초대 완료 되었습니다.');
					alert('[ '+housename+' ]으로 초대 완료 되었습니다.');
					$('#myPage_popup_FullScreen').addClass('objectHidden');
					$(".myPage_HouseAndMate_Popup").addClass('objectHidden');
					$(".alert_pop").addClass('objectHidden');
					$('body').removeClass('popup_Stop_Scroll');
				}else if(result==0){
					console.log('이미 신청한 메이트입니다.');
					alert('이미 초대한 메이트입니다.');
				}
			},error : function(){
				console.log('초대 insert 에러 ');
			}
		});
	});
	$(document).on('click', '.popup_Close', function(){
		$('#myPage_popup_FullScreen').addClass('objectHidden');
		$(".myPage_HouseAndMate_Popup").addClass('objectHidden');
		$(".alert_pop").addClass('objectHidden');
		$('body').removeClass('popup_Stop_Scroll');
	});
	$(document).on('click','.likeInsert', function(){
		// 하우스no , 로그인한 유저아이디를 사용하여 찜목록에 내역이 있는지 확인하기. 
		var no = '<c:out value="${mVO.no }"/>';
		var userid = '<c:out value="${logId }"/>';
		var checkid = '<c:out value="${pVO.userid}"/>';
		var msg = '메이트';
		// 로그인한 경우에만 실행한다. 
		if(userid ==null || userid==''){
			alert('찜하기는 로그인 후 이용이 가능합니다.');
			location.href='/home/login';
		}else if(userid == checkid ){
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
	$(function(){
		 $('#mEdit').click(function(){ //수정하기 버튼
	        location.href="mateEdit"; //메이트등록하기 form 으로 이동
        	
        });
		$("#reportBtn").click(function(){
			$("#pup_wrap_report").css("display", "block");
			
		});
		$("#shareBtn").click(function(){
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
     
     slides.style.width = (slideWidth + slideMargin)*slideCount - slideMargin +'px';//슬라이드의 넓이
     
     function moveSlide(num){
        slides.style.left = -num * 840 +'px';
        currentIdx = num;
     }
     
     //버튼이벤트
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
   $(window).ready(function(){ 	  //공유하기 창
       $(".snsList li a").click(function(){
		shareAct(this);
 		});
  
 });
   function shareAct(a){
 
       var snsCode = $(a).attr('id');
       var cUrl = document.location.href; console.log(cUrl);
 
       switch(snsCode){
 
           case"vIconTw":
               //트위터
               cUrl = 'https://twitter.com/intent/tweet?text=페이지제목:&url='+cUrl;
           break;
 
           case"vIconTg":
               //텔레그램
               cUrl = 'https://telegram.me/share/url?url='+cUrl;
           break;
                 
           case"vIconFb":
               //페이스북
               cUrl = 'http://www.facebook.com/sharer/sharer.php?u='+cUrl;
           break;
 
           case"vIconKs":
               //카카오스토리
               cUrl = 'https://story.kakao.com/share?url='+cUrl;
           break;
 			}
 		window.open(cUrl,'','width=700,height=500,top=300,left=450,scrollbars=yes')
 		}

  //신고하기=================================================
	$(document).on('click','#reportBtn', function(){
		var	reportid = '${mVO.userid}';
		var category = '메이트';
		var no = '${mVO.no}';
		report(reportid, category, no);
	});
	
	//신고하기 창 띄우고 값 가져오는 함수
	function report(reportid, category, no){
		//값 가져오기
		console.log(reportid);
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
	
</script>
<div class="wrap">
<div class="mateViewContent">
	<div id="topDiv">
	 	<div id="dateDiv" class="m_title"> ${mVO.userid } </div>
	 	<div id="btnDiv"> <!-- 수정, 삭제는 본인의 글을 볼 경우에만 -->
		 	<c:if test="${logId==mVO.userid }">
	 		<a id="mEdit" class="white" href="mateEdit?no=${mVO.no }" >수정</a> 
	 		<a class="white" id="mateDel" >삭제</a> 
	 		</c:if>
	 		<c:if test="${logId!=null }">
	 		<c:if test="${logId!=mVO.userid }">
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
						<li><img src="/home/matePic/${mVO.matePic1}" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_mate_pic.png'"></li>
						<c:if test="${mVO.matePic2 != null}">
						<li><img src="/home/matePic/${mVO.matePic2}" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_mate_pic.png'"></li>
						</c:if>
						<c:if test="${mVO.matePic3 != null}">
						<li><img src="/home/matePic/${mVO.matePic3}" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_mate_pic.png'"></li>
						</c:if>
	           		</ul>
	         	</div> <!-- "slides" -->
			</div> <!--slide_wraper -->
			<div class="controlls_next">▶</div>
		</div>
		<div  id="peopleExplain">
			<ul>
				<li ><img src="/home/profilePic/${memProfilePic}" id="profilepic" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_mate_pic.png'"/> </li>
				<li>${mVO.userid }</li>
				<c:forEach var="hPcaseCheck" items="${pVO_log }">
					<c:if test="${hPcaseCheck.pcase == 'h' }">
						<c:set var="hPcase" value="Y"/>
					</c:if>
				</c:forEach>
				<c:if test="${hPcase=='Y' }">
				<li><button class="q_btn green" id="sendInviteBtn">초대하기</button></li>
				</c:if>
				<c:if test="${logId!=null }">
				<c:if test="${logId!=mVO.userid }">
				<li><button class="q_btn white likeInsert" id="likemark">찜하기</button> </li>
				</c:if>
				</c:if>
				<li><button class="q_btn white" id="shareBtn" >공유하기</button></li>
			</ul>
		</div> <!-- peopleExplain div 종료 -->
 	</div> <!-- topDiv 종료 -->
	<div id="middle_Div">
		<div class="middle_mateInfo" id="mate_profile">
			<p class="s_title">메이트 소개</p>
			<div>
				${mVO.mateProfile }
			</div>
		</div>
		<div class="middle_mateInfo" id="room_info">
			<p class="s_title">메이트 정보</p>
			<table class="tb">
				<thead>
					<tr>
						<th style="width: 30%;">희망 지역</th>
						<th>보증금</th>
						<th>월세</th>
						<th>입주가능일</th>
						<th>최소거주기간</th>
						<th>최대거주기간</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:set var="l" value="${fn:length(mVO.area) }"></c:set>
						<td>${fn:substring(mVO.area, 0, l-1)}</td>
						<td>${mVO.deposit }</td>
						<td>${mVO.rent }</td>
						<td>${fn:substring(mVO.enterdate, 0,10) }</td>
						<td>${mVO.minStay }</td>
						<td>${mVO.maxStay }</td>
					</tr>
				</tbody>
			</table>
		</div>
	<div id="propensity_info">
		<div class="propensity_info_mate">
				<p class="s_title">${mVO.userid }의 성향</p>
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
			<div class="propensity_info_house">
				<p class="s_title"> 희망 하우스 성향</p>
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
		</div>
		<!--1.본인 글이 아닐것 (pVO.userid != logId)  ,  -->
		<!-- 2.로그인한 사람이 grade-2 일것( mVO_log.grade ) , -->
		<!-- 3.로그인한 사람이 house로 pno가 1개이상 있을 것. List<PropensityVO> graph_matching_List  -->
		<c:if test="${pVO.userid != logId }">
		<c:if test="${mVO_log.grade == 2 }">
		<c:if test="${fn:length(pVO_log) >0}">
		<div class="matchin_Graph">
			<div>
				<div>
					<p class="s_title" id="matchin_housename">[<span id="housenameText"></span>]</p>
					<select name="housename" id="selectHousename">
						<c:set var="listsize" value="${fn:length(pVO_log)}"/>
						<c:if test="${listsize>0 }">
							<c:forEach var="ii" begin="0" end="${listsize }" step="1">
								<c:if test="${pVO_log[ii].housename != null }">
									<option value="${pVO_log[ii].pno }">${pVO_log[ii].housename }</option>
								</c:if>
							</c:forEach>
						</c:if>
					</select>
				</div>
				<div id="matchingChartDiv">
					<canvas id="matchingChart" height="300" width="300" ></canvas>
				</div>
			</div>
			<div class="matching_result">
				<div><p class="s_title">매칭 결과</p></div>
				<ul>
					<li>
						<span>생 활</span> <span> : </span><span id="lifeText"></span>
					</li>
					<li>
						<span>반 려 동 물</span> <span> : </span><span id="petText"></span>
					</li>
					<li>
						<span>소 통, 모 임</span> <span> : </span><span id="communicateText"></span>
					</li>
					<li>
						<span>흡 연</span> <span> : </span><span id="smokeText"></span>
					</li>
					<li>
						<span>성 격</span> <span> : </span><span id="personalityText"></span>
					</li>
					<li>
						<span>입 주</span> <span> : </span><span id="nowText"></span>
					</li>
					<li><span id="scoreText"></span>%</li>
				</ul>
			</div>
		</div>
		</c:if>
		</c:if>
		</c:if>
	</div> <!-- middleFrm div 종료 -->
</div> <!-- content div 종료 -->
</div>

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

<!-- 집 고르는 팝업.. -->
<div class="alert_pop objectHidden" id="alert_pop">
	<div class="alert_pop_Title"><span class="popup_Close">✕</span></div>
	<div class="alert_pop_Content">
		<p id="invitetTitle">초대할 하우스를 선택해 주세요</p>
		<select name="sendInvitehousename" id="sendInvitehousename">
			<c:set var="hlist" value="${fn:length(pVO_log)}"/>
			<c:if test="${hlist>0 }">
				<c:forEach var="iii" begin="0" end="${hlist }" step="1">
					<c:if test="${pVO_log[iii].housename != null }">
						<c:choose>
							<c:when test="${fn:contains(pVO_log[iii].housename, '등록 성향')}" >
							</c:when>
							<c:otherwise>
								<option value="${pVO_log[iii].housename }">${pVO_log[iii].housename }</option>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:forEach>
			</c:if>
		</select>
		<a href="#" class="b_btn green inviteInsert" id="inviteInsertBtn">확인</a>
	</div>
	<div class="alert_pop_footer">
		<p class="b_btn white popup_Close" >닫기</p>
	</div>
</div>
<div class="myPage_HouseAndMate_Popup_FullScreen popup_Close objectHidden" id="myPage_popup_FullScreen"></div>

		<div class="pup_wrap" id="pup_wrap_share">
			<div class="pup_form">
				<div class="pup_head">공유하기</div>
				<div class="pup_body">
						<div class="list_title">
							<ul id="snsList" class="snsList">
							<li><a href="#" id="vIconTw" onclick="return false;">트위터</a></li>
							<li><a href="#" id="vIconTg" onclick="return false;">텔레그램</a></li>
							<li><a href="#" id="vIconFb" onclick="return false;">페이스북</a> </li>
							<li><a href="#" id="vIconKs" onclick="return false;">카카오스토리</a> </li>
							</ul>
						</div>
					</div>
					<div class="pup_bottom">
						<a class="btn_cancel pup_wrap_share_close">닫기</a>
					</div>
				<a href="" class="btn_close pup_wrap_share_close">닫기</a>
			</div>
		</div>