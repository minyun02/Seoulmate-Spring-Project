<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/housemate.css">
<script src="//cdn.ckeditor.com/4.16.0/full/ckeditor.js"></script>
<c:set var="today" value="<%=new java.util.Date()%>"/>
<c:set var="now"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/></c:set>


<!-- <!— include summernote css/js —> -->
<!-- <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script> -->
<script>


$(function(){
	CKEDITOR.replace("houseprofile", {
		height:300,
		width:'100%'
		
	}); //설명글 name 설정 필요
	
	$("#write").on('submit', function(){
		if(CKEDITOR.instances.content.getData()==""){
			alert("내용을 입력해주세요");
			return false;
		}return true;
	});
	
});

function readURL(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#houseImg1').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

function readURL2(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#houseImg2').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

function readURL3(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#houseImg3').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

function readURL4(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#houseImg4').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

function readURL5(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#houseImg5').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}
$(function(){
	
	
//     $('select').change(function(){
//         var option = $(this).val(); //옵션의 value

//         if(option=='value값){
//            $('td:contains("텍스트이름")').parents('tr').css('display','');
//            $('td:contains("텍스트이름")').parents('tr').css('display','none');
//         }         
//      });

// 	if(!$('#selectBoxID > option:selected').val()) { //#->셀렉트 의 id 입력
// 	    alert("선택해주세요");
// 	}
	//
	$("#file b").click(function(){ //파일 업로드 X 버튼 누르면 삭제
      $(this).parent().css("display", "none");
      $(this).parent().next().attr("name", "delFile");
      $(this).parent().next().next().attr('type', 'file');
   	});
	//

	$("#roomPlus").click(function(){
		$("#houseWrite1_ul2").css("display", "block");
	});

	$("#hNext1").click(function(){
		
		if($("#sample4_jibunAddress").val()==""){
			alert("주소를 입력해주세요");
			return false;
		}
		if($("#housename").val()==""){
			alert("하우스 이름을 입력해주세요");
			return false;
		}
		if($("#room").val()==""){
			alert("방 개수를 선택해주세요");
			return false;
		}
		if($("#bathroom").val()==""){
			alert("욕실 수를 선택해주세요");
			return false;
		}
		if($("#nowpeople").val()==""){
			alert("현재 인원을 선택해주세요");
			return false;
		}
		if($("#searchpeople").val()==""){
			alert("찾는 인원을 선택해주세요");
			return false;
		}
		$("#houseWrite1").css("display", "none");
		$("#houseWrite2").css("display", "block");
	});
	$("#hPrev1").click(function(){
		location.href="<%=request.getContextPath()%>/houseIndex"; 
	});
	$("#hIndex1").click(function(){
		location.href="<%=request.getContextPath()%>/houseIndex";
	});

	$("#hNext2").click(function(){
		
		if ($("input[name=publicfacility]:checked").length < 1) {
			alert("1개 이상 선택해주세요")
    		return false;
		}
		
		$("#houseWrite2").css("display", "none");
		$("#houseWrite3").css("display", "block");
	});
	$("#hPrev2").click(function(){
		$("#houseWrite2").css("display", "none");
		$("#houseWrite1").css("display", "block"); 
	});
	$("#hIndex2").click(function(){
		location.href="<%=request.getContextPath()%>/houseIndex";
	});
	
	$("#hNext3").click(function(){
		
		if($("#housepic1").val()==""){
			alert("(첫번째 파일부터)사진을 1장이상 등록해주세요");
			return false;
		}
		
		$("#houseWrite3").css("display", "none");
		$("#houseWrite4").css("display", "block");
	});
	$("#hPrev3").click(function(){
		$("#houseWrite3").css("display", "none");
		$("#houseWrite2").css("display", "block"); 
	});
	$("#hIndex3").click(function(){
		location.href="<%=request.getContextPath()%>/houseIndex";
	});
	
	$("#hNext4").click(function(){
		$("#houseWrite4").css("display", "none");
		$("#houseWrite5").css("display", "block");
	});
	$("#hPrev4").click(function(){
		$("#houseWrite4").css("display", "none");
		$("#houseWrite3").css("display", "block"); 
	});
	$("#hIndex4").click(function(){
		location.href="<%=request.getContextPath()%>/houseIndex";
	});
	
	$("#hNext5").click(function(){
		
		if($("#roomName").val()==""){
			alert("방 이름을 입력해주세요");
			return false;
		}
		if($("#rent").val()==""){
			alert("월세를 입력해주세요");
			return false;
		}
		if($("#deposit").val()==""){
			alert("보증금을 입력해주세요");
			return false;
		}
		if($("#roomPeople").val()==""){
			alert("방 인원을 입력해주세요");
			return false;
		}
		if($("#enterdate").val()==""){
			alert("입주가능일을 입력해주세요");
			return false;
		}
		if($("#minStay").val()==""){
			alert("최소 거주 기간을 선택해주세요");
			return false;
		}
		if($("#maxStay").val()==""){
			alert("최대 거주 기간을 선택해주세요");
			return false;
		}
		//라디오버튼 체크 확인 여부
		if($("input:radio[name='roomVOList[0].furniture']").is(":checked")==true){
// 			if($("input:radio[name='roomVOList[0].furniture']").is(":checked").val()=="2"){
// 				$("#incFurniture").css("display", "none");
// 	}
		}else{
			alert("가구 여부를 선택해주세요");
			return false;
		}
		
		$("#houseWrite5").css("display", "none");
		$("#houseWrite6").css("display", "block");
	});
	$("#hPrev5").click(function(){
		$("#houseWrite5").css("display", "none");
		$("#houseWrite4").css("display", "block"); 
	});
	$("#hIndex5").click(function(){
		location.href="<%=request.getContextPath()%>/houseIndex";
	});
	
	$("#hNext6").click(function(){
		
		if($("input:radio[name='h_noise']").is(":checked")==false){
			alert("생활소음을 선택해주세요");
			return false;
		}
		if($("input:radio[name='h_pattern']").is(":checked")==false){
			alert("생활시간을 선택해주세요");
			return false;
		}
		if($("input:radio[name='h_pet']").is(":checked")==false){
			alert("반려동물 여부를 선택해주세요");
			return false;
		}
		if($("input:radio[name='h_petwith']").is(":checked")==false){
			alert("반려동물 동반 입실 여부를 선택해주세요");
			return false;
		}
		if($("input:radio[name='h_smoke']").is(":checked")==false){
			alert("흡연을 선택해주세요");
			return false;
		}
		
		$("#houseWrite6").css("display", "none");
		$("#houseWrite7").css("display", "block");
	});
	$("#hPrev6").click(function(){
		$("#houseWrite6").css("display", "none");
		$("#houseWrite5").css("display", "block"); 
	});
	$("#hIndex6").click(function(){
		location.href="<%=request.getContextPath()%>/houseIndex";
	});
	
	$("#hNext7").click(function(){
		
		if($("input:radio[name='h_mood']").is(":checked")==false){
			alert("분위기를 선택해주세요");
			return false;
		}
		if($("input:radio[name='h_communication']").is(":checked")==false){
			alert("소통방식을 선택해주세요");
			return false;
		}
		if($("input:radio[name='h_party']").is(":checked")==false){
			alert("모임빈도을 선택해주세요");
			return false;
		}
		if($("input:radio[name='h_enter']").is(":checked")==false){
			alert("모임참가 의무를 선택해주세요");
			return false;
		}
		
		$("#houseWrite7").css("display", "none");
		$("#houseWrite8").css("display", "block");
	});
	$("#hPrev7").click(function(){
		$("#houseWrite7").css("display", "none");
		$("#houseWrite6").css("display", "block"); 
	});
	$("#hIndex7").click(function(){
		location.href="<%=request.getContextPath()%>/houseIndex";
	});
	
	$("#hNext8").click(function(){
		$("#houseWrite8").css("display", "none");
		$("#houseWrite9").css("display", "block");
	});
	$("#hPrev8").click(function(){
		$("#houseWrite8").css("display", "none");
		$("#houseWrite7").css("display", "block"); 
	});
	$("#hIndex8").click(function(){
		location.href="<%=request.getContextPath()%>/houseIndex";
	});
	
	$("#hNext9").click(function(){
		
		if($("input:radio[name='m_pattern']").is(":checked")==false){
			alert("생활시간을 선택해주세요");
			return false;
		}
		if($("input:radio[name='m_personality']").is(":checked")==false){
			alert("성격을 선택해주세요");
			return false;
		}
		if($("input:radio[name='m_pet']").is(":checked")==false){
			alert("반려동물을 선택해주세요");
			return false;
		}
		if($("input:radio[name='m_smoke']").is(":checked")==false){
			alert("흡연을 선택해주세요");
			return false;
		}
		if($("input:radio[name='m_age']").is(":checked")==false){
			alert("연령대를 선택해주세요");
			return false;
		}
		if($("input:radio[name='m_gender']").is(":checked")==false){
			alert("성별을 선택해주세요");
			return false;
		}
		if($("input:radio[name='m_global']").is(":checked")==false){
			alert("외국인입주 가능여부를 선택해주세요");
			return false;
		}
		if($("input:radio[name='m_now']").is(":checked")==false){
			alert("즉시입주 가능여부를 선택해주세요");
			return false;
		}
		
		if(confirm("하우스 정보를 수정하시겠습니까?")){
			$('#houseEditFrm').submit();
			alert("하우스 정보가 수정되었습니다.");
		}
		location.href="<%=request.getContextPath()%>/houseIndex";
	});
	$("#hPrve9").click(function(){
		$("#houseWrite9").css("display", "none");
		$("#houseWrite8").css("display", "block"); 
	});
	$("#hIndex9").click(function(){
		location.href="<%=request.getContextPath()%>/houseIndex";
	});

	
	// input 태그에서 엔터키를 입력해 submit 막기
    $('input[type="text"], input[type="password"], input[type=date]').keydown(function(){
       if(event.keyCode === 13){
          event.preventDefault();
       };
    });
  	//성향 버튼 눌렀을때 가져오기========================================================================
	$('.getPropinfo').click(function(){
		var housename = $(this).text();
		var pno = $(this).attr('id');
		console.log(housename);
		$.ajax({
			url : "/home/getPropensity",
			data : 'userid=${logId}&pno='+pno,
			success : function(result){
				console.log(result);
// 				//1. 생활소음 h_noise
				$('input:radio[name=h_noise]:radio[value='+result.h_noise+']').prop('checked', true);
// 				//2. 생활시간 h_pattern
				$('input:radio[name=h_pattern]:radio[value='+result.h_pattern+']').prop('checked', true);
// 				//3. 반려동물 여부 h_pet
				$('input[name=h_pet]:radio[value='+result.h_pet+']').prop('checked', true);
// 				//4. 반려동물 동반 입주 여부 h_petwith
				$('input[name=h_petwith]:radio[value='+result.h_petwith+']').prop('checked', true);
// 				//5. 흡연 h_smoke
				$('input[name=h_smoke]:radio[value='+result.h_smoke+']').prop('checked', true);
// 				//6. 분위기 h_mood
				$('input[name=h_mood]:radio[value='+result.h_mood+']').prop('checked', true);
// 				//7. 소통방식 h_communication
				$('input[name=h_communication]:radio[value='+result.h_communication+']').prop('checked', true);
// 				//8. 모임빈도 h_party
				$('input[name=h_party]:radio[value='+result.h_party+']').prop('checked', true);
// 				//9. 모임참가 의무 h_enter
				$('input[name=h_enter]:radio[value='+result.h_enter+']').prop('checked', true);
// 				//10. 하우스내 지원서비스 h_support
				if(result.h_support != null){
					for(var i=0; i<result.h_support.length; i++){
						$('input[name=h_support]:checkbox[value='+result.h_support[i]+']').prop('checked', true);
					}
				}
				//11. 메이트 생활시간
				$('input[name=m_pattern]:radio[value='+result.m_pattern+']').prop('checked', true);
				//12. 메이트 성격 m_personality m_personality
				$('input[name=m_personality]:radio[value='+result.m_personality+']').prop('checked', true);
				//13. 메이트 반려동물 선호도 m_pet
				$('input[name=m_pet]:radio[value='+result.m_pet+']').prop('checked', true);
				//14. 메이트 흡연 m_smoke
				$('input[name=m_smoke]:radio[value='+result.m_smoke+']').prop('checked', true);
				//15. 메이트 연령대 m_age
				$('input[name=m_age]:radio[value='+result.m_age+']').prop('checked', true);
				//16. 메이트 성별 m_gender
				$('input[name=m_gender]:radio[value='+result.m_gender+']').prop('checked', true);
				//17. 메이트 외국인입주 가능여부 m_global
				$('input[name=m_global]:radio[value='+result.m_global+']').prop('checked', true);
				//18. 메이트 즉시입주 여부 m_now
				$('input[name=m_now]:radio[value='+result.m_now+']').prop('checked', true);
			},error : function(){
				alert("성향 불러오기 실패.")
			}
		});
	})//성향 버튼 눌렀을때 가져오기========================================================================끝
});
// autocomplete="off" //자동완성 막아줌


</script>
<style>
/* input[type="date"] {width:200px;} */
/* .house_wrap{width:800px; margin:0 auto; } */
.content ul li{word-break:keep-all;}
.form_box li input, .form_box li select{margin:0px; width:300px;}
.form_box{width:800px; margin:0 auto; padding-left: 100px;}
.content label{width:180px;}
.form_box.choice li > label {width: 240px;}
#houseWrite1_ul2{display: none;}
.btnclass{padding-left:50px;}
#roomPlus{margin:0 auto;}
#houseWrite1 .checks { width: 560px;}
#ck{margin:0 auto; width: 60%;}

#houseWrite3 .form_box li{width: 900px;}
#hPic img{width: 250px; height: 250px; }
#houseImg1{width:250px; height:250px; position: relative; margin:0 auto; text-align: center;}
#housepic1, #housepic2, #housepic3, #housepic4, #housepic5 {width:200px; height: 200px; margin:0 auto;}

#houseWrite2, #houseWrite3, #houseWrite4, #houseWrite5, 
#houseWrite6, #houseWrite7, #houseWrite8, #houseWrite9 {display:none; margin: 0 auto;}

#houseWrite2 .form_box.choice li > label {width: 110px;}
#houseWrite2 .checks{height: 21px;}
#houseWrite2 .checks label{height: 21px;}
#hosueWrite5 .checks>label{width:100px;}
#houseWrite5 .checks {width: 295px;}
#houseWrite8{width: 800px;}
#houseWrite8 .checks>label{width:200px;}
#hPic{height:250px; width:250px; text-align: center;}
#HproUl>li{float: right;}

.title_wrap div{min-height:300px;}
.checks{width:800px;}
.checks>label{width:120px;}
/* #houseWrite6 input, #houseWrite6 select{width:230px;} */
</style>
<div class="wrap">
<div class="content">
	<form method="post" id="houseEditFrm" name="houseEditFrm" action="houseEditOk" enctype="multipart/form-data">
	<input type="hidden" name="listSize" value="${rVO_ListSize}">
	<input type="hidden" name="no" value="${hVO.no}">
<%-- 	<input type="hidden" name="no" value="${rVO. hno }"> --%>
	<input type="hidden" name="pno" value="${pVO.pno}">
	<div class="title_wrap">
	<p class="m_title">하우스 수정하기 </p> 
	<p>&nbsp;</p>
	</div>
		
		
		<div id="houseWrite1"> <!-- 등록form 1 -->
		
		<div class="title_wrap">
		<p class="s_title">집 기본 정보 등록 </p> <br/>
		<p>&nbsp;</p>
		</div>
			
			<ul class="form_box">
				<li> <label><span class="red_txt">*</span>주소 </label> <input type="text" id="addr" name="addr" value="${hVO.addr }" readonly/> </li> <!-- 주소 수정 못하게 막아둠 -->
				<li><label><span class="red_txt">*</span>하우스 이름 </label> <input type="text" id="housename" name="housename" value="${hVO.housename }"/></li>
			<li> <label><span class="red_txt">*</span>총 방 개수 </label><select name="room" id="room">
						<option value="">선택하세요</option>
						<option value="1" <c:if test="${hVO.room==1 }">selected </c:if> >1</option>
						<option value="2" <c:if test="${hVO.room==2 }">selected </c:if> >2</option>
						<option value="3" <c:if test="${hVO.room==3 }">selected </c:if> >3</option>
						<option value="4" <c:if test="${hVO.room==4 }">selected </c:if> >4</option>
					</select> </li>
			<li> <label><span class="red_txt">*</span>총 욕실 수</label> <select name="bathroom" id="bathroom">
						<option value="">선택하세요</option>
						<option value="1" <c:if test="${hVO.bathroom==1 }">selected </c:if> >1</option>
						<option value="2" <c:if test="${hVO.bathroom==2 }">selected </c:if> >2</option>
						<option value="3" <c:if test="${hVO.bathroom==3 }">selected </c:if> >3</option>
						<option value="4" <c:if test="${hVO.bathroom==4 }">selected </c:if> >4</option>
					</select> </li>
			<li><label><span class="red_txt">*</span>현재 인원</label> <select name="nowpeople" id="nowpeople">
						<option value="">선택하세요</option>
						<option value="0" <c:if test="${hVO.nowpeople==0 }">selected </c:if> >0</option>
						<option value="1" <c:if test="${hVO.nowpeople==1 }">selected </c:if> >1</option>
						<option value="2" <c:if test="${hVO.nowpeople==2 }">selected </c:if> >2</option>
						<option value="3" <c:if test="${hVO.nowpeople==3 }">selected </c:if> >3</option>
						<option value="4" <c:if test="${hVO.nowpeople==4 }">selected </c:if> >4</option>
					</select> </li>
			<li><label><span class="red_txt">*</span>찾는 인원</label> <select name="searchpeople" id="searchpeople">
						<option value="">선택하세요</option>
						<option value="1" <c:if test="${hVO.searchpeople==1 }">selected </c:if> >1</option>
						<option value="2" <c:if test="${hVO.searchpeople==2 }">selected </c:if> >2</option>
						<option value="3" <c:if test="${hVO.searchpeople==3 }">selected </c:if> >3</option>
						<option value="4" <c:if test="${hVO.searchpeople==4 }">selected </c:if> >4</option>
					</select> </li>
			</ul>
		
				<div class="btnclass">
					<a id="hPrev1" class="green" >이전</a>
					<a id="hNext1" class="green" >다음</a>
					<a id="hIndex1" class="green" >취소</a>
				</div> <!-- 버튼div 종료 -->

		</div> <!-- 등록form1 종료 -->
		
		<div id="houseWrite2"> <!-- 등록form 2 -->
		
		<div class="title_wrap">
		<p class="s_title">공용 시설 정보 등록 </p>
		<p>&nbsp;</p>
		</div>
		
			<ul class="form_box choice">
				<li>
					<label>주방</label>
					<div class="checks">
						<input type="checkbox" id="냉장고" name="publicfacility" value="냉장고" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='냉장고' }">checked</c:if> </c:forEach> > 
						<label for="냉장고">냉장고</label>
						<input type="checkbox" id="정수기" name="publicfacility" value="정수기" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='정수기' }">checked</c:if> </c:forEach> > 
						<label for="정수기">정수기</label>
						<input type="checkbox" id="가스레인지" name="publicfacility" value="가스레인지" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='가스레인지' }">checked</c:if> </c:forEach> > 
						<label for="가스레인지">가스레인지</label>
						<input type="checkbox" id="밥솥" name="publicfacility" value="밥솥" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='밥솥' }">checked</c:if> </c:forEach> > 
						<label for="밥솥">밥솥</label> 
						<input type="checkbox" id="식기세척기" name="publicfacility" value="식기세척기" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='식기세척기' }">checked</c:if> </c:forEach> >  
						<label for="식기세척기">식기세척기</label>
						<input type="checkbox" id="냄비" name="publicfacility" value="냄비" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='냄비' }">checked</c:if> </c:forEach> > 
						<label for="냄비">냄비</label>
						<input type="checkbox" id="프라이팬" name="publicfacility" value="프라이팬" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='프라이팬' }">checked</c:if> </c:forEach> > 
						<label for="프라이팬">프라이팬</label>
						<input type="checkbox" id="토스트기" name="publicfacility" value="토스트기" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='토스트기' }">checked</c:if> </c:forEach> > 
						<label for="토스트기">토스트기</label> 
					</div>
				</li> 
				<p>&nbsp;</p>
				<li>
					<label>거실</label>
					<div class="checks">
						<input type="checkbox" id="소파" name="publicfacility" value="소파" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='소파' }">checked</c:if> </c:forEach> > 
						<label for="소파">소파</label>
						<input type="checkbox" id="티비" name="publicfacility" value="티비" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='티비' }">checked</c:if> </c:forEach> > 
						<label for="티비">티비</label>
						<input type="checkbox" id="탁자" name="publicfacility" value="탁자" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='탁자' }">checked</c:if> </c:forEach> > 
						<label for="탁자">탁자</label>
						<input type="checkbox" id="카펫" name="publicfacility" value="카펫" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='카펫' }">checked</c:if> </c:forEach> > 
						<label for="카펫">카펫</label> <br/>
					</div>
				</li>
		
				<li>
					<label>욕실</label>
					<div class="checks">
						<input type="checkbox" id="욕조" name="publicfacility" value="욕조" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='욕조' }">checked</c:if> </c:forEach> > 
						<label for="욕조">욕조</label>
						<input type="checkbox" id="비데" name="publicfacility" value="비데" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='비데' }">checked</c:if> </c:forEach> > 
						<label for="비데">비데</label>
						<input type="checkbox" id="샴푸" name="publicfacility" value="샴푸" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='샴푸' }">checked</c:if> </c:forEach> > 
						<label for="샴푸">샴푸</label>
						<input type="checkbox" id="린스" name="publicfacility" value="린스" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='린스' }">checked</c:if> </c:forEach> > 
						<label for="린스">린스</label> <br/>
					</div>
				</li>
				
				<li>
					<label>기타</label>
					<div class="checks">
						<input type="checkbox" id="세탁기" name="publicfacility" value="세탁기" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='세탁기' }">checked</c:if> </c:forEach> > 
						<label for="세탁기">세탁기</label>
						<input type="checkbox" id="건조기" name="publicfacility" value="건조기" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='건조기' }">checked</c:if> </c:forEach> > 
						<label for="건조기">건조기</label>
						<input type="checkbox" id="베란다" name="publicfacility" value="베란다" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='베란다' }">checked</c:if> </c:forEach> > 
						<label for="베란다">베란다</label>
						<input type="checkbox" id="WIFI" name="publicfacility" value="WIFI" <c:forEach var="i" items="${hVO.publicfacility }"> <c:if test="${i=='WIFI' }">checked</c:if> </c:forEach> > 
						<label for="WIFI">WIFI</label> 
					</div>
				</li>
			</ul>	
				<div class="btnclass">
					<a class="green" id="hPrev2">이전</a>
					<a class="green" id="hNext2" >다음</a> 
					<a class="green" id="hIndex2" >취소</a>
				</div> <!-- 버튼div 종료 -->
		</div>	<!-- 등록form2 종료 -->
			
		<div id=houseWrite3>
		
		<div class="title_wrap">
		<p class="s_title">사진 등록 </p> <br/> <!-- 사진 5개 등록? -->
		<p>&nbsp;</p>
		</div>
		
			<ul class="form_box">
				<li id="hPic">
					<img id="houseImg1" name="houseImg1" src="/home/housePic/${hVO.housepic1}" />
					<img id="houseImg2" name="houseImg2" src="/home/housePic/${hVO.housepic2}" />
					<img id="houseImg3" name="houseImg3" src="/home/housePic/${hVO.housepic3}" />
					<img id="houseImg4" name="houseImg4" src="/home/housePic/${hVO.housepic4}" />
					<img id="houseImg5" name="houseImg5" src="/home/housePic/${hVO.housepic5}" />
				</li>
				<!-- /////////// -->
				<li id="file">
	               <div>${hVO.housepic1 } <b>X</b> </div>
	               <input type="hidden" name="" value=${hVO.housepic1 }/>
	               <input type="hidden" name="filename" />
	               
	               <c:if test="${hVO.housepic2!=null && hVO.housepic2!='' }"> <!-- 두번째 첨부파일이 있을 경우 -->
	               <div>${hVO.housepic2 } <b>X</b> </div>
	               <input type="hidden" name="" value=${hVO.housepic2 }/>
	               <input type="hidden" name="filename" onchange="readURL2(this);"/>
	               </c:if>
	               
	               <c:if test="${hVO.housepic2==null || hVO.housepic2=='' }"> <!-- 두번째 첨부파일이 없을 경우 -->
	               <input type="file" name="filename" onchange="readURL2(this);"/>
	               </c:if>
	               
	               <c:if test="${hVO.housepic3!=null && hVO.housepic3!='' }"> <!-- 세번째 첨부파일이 있을 경우 -->
	               <div>${hVO.housepic3 } <b>X</b> </div>
	               <input type="hidden" name="" value=${hVO.housepic3 }/>
	               <input type="hidden" name="filename" onchange="readURL3(this);"/>
	               </c:if>
	               
	               <c:if test="${hVO.housepic3==null || hVO.housepic3=='' }"> <!-- 세번째 첨부파일이 없을 경우 -->
	               <input type="file" name="filename" onchange="readURL3(this);"/>
	               </c:if>
	               
	               <c:if test="${hVO.housepic4!=null && hVO.housepic4!='' }"> <!-- 네번째 첨부파일이 있을 경우 -->
	               <div>${hVO.housepic4 } <b>X</b> </div>
	               <input type="hidden" name="" value=${hVO.housepic4 }/>
	               <input type="hidden" name="filename" onchange="readURL4(this);"/>
	               </c:if>
	               
	               <c:if test="${hVO.housepic4==null || hVO.housepic4=='' }"> <!-- 네번째 첨부파일이 없을 경우 -->
	               <input type="file" name="filename" onchange="readURL4(this);"/>
	               </c:if>
	               
	               <c:if test="${hVO.housepic5!=null && hVO.housepic5!='' }"> <!-- 다섯번째 첨부파일이 있을 경우 -->
	               <div>${hVO.housepic5 } <b>X</b> </div>
	               <input type="hidden" name="" value=${hVO.housepic5 }/>
	               <input type="hidden" name="filename" onchange="readURL5(this);"/>
	               </c:if>
	               
	               <c:if test="${hVO.housepic5==null || hVO.housepic5=='' }"> <!-- 다섯번째 첨부파일이 없을 경우 -->
	               <input type="file" name="filename" onchange="readURL5(this);"/>
	               </c:if>
	               
	            <br/> 
	            </li>
				<!-- /////////// -->
			</ul>
				<div class="btnclass">
					<a class="green" id="hPrev3">이전</a>
					<a class="green" id="hNext3">다음</a> 
					<a class="green" id="hIndex3" >취소</a>
				</div> <!-- 버튼div 종료 -->
	
		</div>	<!-- 등록form3 종료 -->
			
		<div id="houseWrite4">
		
		<div class="title_wrap">
		<p class="s_title">우리집설명 </p> <br/>
		<p>&nbsp;</p>
		</div>
		<div id="ck">
			<textarea id="houseprofile" name="houseprofile">${hVO.houseprofile }</textarea><br/>
		</div>	
				<div class="btnclass">
					<a class="green" id="hPrev4" >이전</a>
					<a class="green" id="hNext4" >다음</a> 
					<a class="green" id="hIndex4" >취소</a>
				</div> <!-- 버튼div 종료 -->
		
		</div>	<!-- 등록form4 종료 -->
		
		<div id="houseWrite5">
		
		<c:forEach var="rVO" items="${rVO_List}" varStatus="index">
			<div class="room${index.count}">
				<div class="title_wrap">
					<p class="s_title">${index.count}번 방 임대료 및 입주정보 </p> <br/>
					<input class="hno${index.count}"  type="hidden" name="roomVOList[${index.count-1}].hno" value="${rVO.hno}">
					<p>&nbsp;</p>
				</div>
			<ul class="form_box">
				<li><label><span class="red_txt">*</span>방${index.count} 이름 </label> <input type="text" id="roomName" name="roomVOList[${index.count-1}].roomName" value="${rVO.roomName }" /></li>
				<li><label><span class="red_txt">*</span>월세(관리비포함)</label> <input type="number" id="rent" name="roomVOList[${index.count-1}].rent" value="${rVO.rent }"/> 
				<li><label><span class="red_txt">*</span>보증금(조율) </label><input type="number" id="deposit" name="roomVOList[${index.count-1}].deposit" value="${rVO.deposit }"/> </li>
				<li><label><span class="red_txt">*</span>방 인원</label> <input type="number" id="roomPeople" name="roomVOList[${index.count-1}].roomPeople" value="${rVO.roomPeople }" /> </li>
				<li><label><span class="red_txt">*</span>입주 가능일 </label> <input type="date" id="enterdate" name="roomVOList[${index.count-1}].enterdate" min="${now}" value="${rVO.enterdate}" /> </li>
				<li><label><span class="red_txt">*</span>최소 거주 기간</label>
					<select name="roomVOList[${index.count-1}].minStay" id="minStay" >
						<option value="">선택하세요</option>
						<option value="1-3개월" <c:if test="${rVO.minStay=='1-3개월' }">selected </c:if> >1~3 개월</option>
						<option value="4-6개월" <c:if test="${rVO.minStay=='4-6개월' }">selected </c:if> >4~6 개월</option>
						<option value="7-12개월" <c:if test="${rVO.minStay=='7-12개월' }">selected </c:if> >7~12 개월</option>
						<option value="1년이상" <c:if test="${rVO.minStay=='1년이상' }">selected </c:if> >1년 이상</option>
					</select> 
				<li><label><span class="red_txt">*</span>최대 거주 기간</label>
					<select name="roomVOList[${index.count-1}].maxStay" id="maxStay">
						<option value="">선택하세요</option>
						<option value="1-3개월" <c:if test="${rVO.maxStay=='1-3개월' }">selected </c:if> >1~3 개월</option>
						<option value="4-6개월" <c:if test="${rVO.maxStay=='4-7개월' }">selected </c:if> >4~6 개월</option>
						<option value="7-12개월" <c:if test="${rVO.maxStay=='7-12개월' }">selected </c:if> >7~12 개월</option>
						<option value="1년이상" <c:if test="${rVO.maxStay=='1년이상' }">selected </c:if> >1년 이상</option>
					</select> </li>
					
				<li><label><span class="red_txt">*</span>가구 여부</label> 
					<div class="checks">
							<input type="radio" id="furniture${index.count}" value="1" name="roomVOList[${index.count-1}].furniture" <c:if test="${rVO.furniture==1}">checked</c:if> > 
							<label for="furniture1">있음</label>
							
							<input type="radio" id="furniture${index.count+1}" value="2" name="roomVOList[${index.count-1}].furniture" <c:if test="${rVO.furniture==2}">checked</c:if> > 
							<label for="furniture2">없음</label>
						</div>	</li>
				<li><label>포함된 가구</label><input type="text" name="roomVOList[${index.count-1}].incFurniture"/> </li>
			</ul><br><br>
			</div>
		</c:forEach>
		
			<div class="btnclass">
				<a class="green" id="hPrev5">이전</a>
				<a class="green" id="hNext5" >다음</a> 
				<a class="green" id="hIndex5" >취소</a>
			</div> <!-- 버튼div 종료 -->
		
		</div> <!-- 등록form5 종료 -->
		
			
		<div id=houseWrite6>
		
		<div class="title_wrap">
		<ul class="s_margin" id="HproUl">
		<!-- ?//////////////////////////////// -->
		<c:forEach var="vo" items="${list}" varStatus="index">
			<li>
				<a id="${vo.pno}" class="getPropinfo <c:if test="${pVO.pno==vo.pno}"> green</c:if>">
					<c:if test="${vo.housename!=null}">${vo.housename}</c:if>
					<c:if test="${vo.housename==null}">이름없는 집 ${index.count}</c:if>
				</a>
			</li>
		</c:forEach>
<%-- 			<c:forEach var="vo" items="${list}"> --%>
<%-- 				<li><a href="#">${vo.housename}</a></li> --%>
<%-- 			</c:forEach> --%>
		<!-- ?//////////////////////////////// -->
		</ul>
		<p class="s_title">하우스 성향 등록 (생활정보)</p> <br/>
		
		<p>&nbsp;</p>
		</div>
		
			<ul class="form_box choice">
				<li>
					<label><span class="red_txt">*</span>생활소음</label>
					<div class="checks propDiv">
						<input type="radio" id="h_noise1" value="1" name="h_noise" <c:if test="${pVO.h_noise==1}">checked</c:if> >   
						<label for="h_noise1">매우 조용함</label>
						
						<input type="radio" id="h_noise2" value="2" name="h_noise" <c:if test="${pVO.h_noise==2}">checked</c:if> > 
						<label for="h_noise2">보통</label>
						
						<input type="radio" id="h_noise3" value="3" name="h_noise" <c:if test="${pVO.h_noise==3}">checked</c:if> > 
						<label for="h_noise3">조용하지 않음</label>
					</div>
				</li>
				
				<li>
					<label><span class="red_txt">*</span>생활시간</label>
					<div class="checks propDiv">
						<input type="radio" id="h_pattern1" value="1" name="h_pattern" <c:if test="${pVO.h_pattern==1}">checked</c:if> > 
						<label for="h_pattern1">주행성</label>
						
						<input type="radio" id="h_pattern3" value="3" name="h_pattern" <c:if test="${pVO.h_pattern==3}">checked</c:if> > 
						<label for="h_pattern3">야행성</label>
					</div>
				</li>
				
					<li>
					<label><span class="red_txt">*</span>반려동물 여부</label>
					<div class="checks propDiv">
						<input type="radio" id="h_pet3" value="3" name="h_pet" <c:if test="${pVO.h_pet==3}">checked</c:if> > 
						<label for="h_pet3">있음</label>	
						
						<input type="radio" id="h_pet1" value="1" name="h_pet" <c:if test="${pVO.h_pet==1}">checked</c:if> > 
						<label for="h_pet1">없음</label>
					</div>
				</li>
				
				<li>
					<label><span class="red_txt">*</span>반려동물 동반 입주 여부</label>
					<div class="checks propDiv">
						<input type="radio" id="h_petwith3" value="3" name="h_petwith" <c:if test="${pVO.h_petwith==3}">checked</c:if> > 
						<label for="h_petwith3">가능</label>
						
						<input type="radio" id="h_petwith1" value="1" name="h_petwith" <c:if test="${pVO.h_petwith==1}">checked</c:if> > 
						<label for="h_petwith1">불가능</label>
					</div>
				</li>
				
				<li>
					<label><span class="red_txt">*</span>흡연</label>
					<div class="checks propDiv">
						<input type="radio" id="h_smoke1" value="1" name="h_smoke" <c:if test="${pVO.h_smoke==1}">checked</c:if> > 
						<label for="h_smoke1">비흡연</label>
						
						<input type="radio" id="h_smoke2" value="2" name="h_smoke" <c:if test="${pVO.h_smoke==2}">checked</c:if> > 
						<label for="h_smoke2">실외흡연</label>
						
						<input type="radio" id="h_smoke3" value="3" name="h_smoke" <c:if test="${pVO.h_smoke==3}">checked</c:if> > 
						<label for="h_smoke3">실내흡연</label>
					</div>
				</li>
			</ul>
				<div class="btnclass">
					<a class="green" id="hPrev6" >이전</a>
					<a class="green" id="hNext6" >다음</a> 
					<a class="green" id="hIndex6" >취소</a>
				</div> <!-- 버튼div 종료 -->
			
		</div> <!-- 등록form6 종료 -->
			
		<div id="houseWrite7">
		
		<div class="title_wrap">
		<p class="s_title">하우스 성향 등록 (소통정보) </p>
		<p>&nbsp;</p>
		</div>
			
			<ul class="form_box choice">
			
				<li>
					<label><span class="red_txt">*</span>분위기</label>
					<div class="checks propDiv">
						<input type="radio" id="h_mood1" value="1" name="h_mood" <c:if test="${pVO.h_mood==1}">checked</c:if> > 
						<label for="h_mood1">화목함</label>
						
						<input type="radio" id="h_mood2" value="2" name="h_mood" <c:if test="${pVO.h_mood==2}">checked</c:if> > 
						<label for="h_mood2">보통</label>
						
						<input type="radio" id="h_mood3" value="3" name="h_mood" <c:if test="${pVO.h_mood==3}">checked</c:if> > 
						<label for="h_mood3">독립적</label>
					</div>
				</li>
				
					<li>
					<label><span class="red_txt">*</span>소통방식</label>
					<div class="checks propDiv">
						<input type="radio" id="h_communication3" value="3" name="h_communication" <c:if test="${pVO.h_communication==3}">checked</c:if> > 
						<label for="h_communication3">대화</label>
						<input type="radio" id="h_communication1" value="1" name="h_communication" <c:if test="${pVO.h_communication==1}">checked</c:if> > 
						<label for="h_communication1">메신저</label>
						<input type="radio" id="h_communication2" value="2" name="h_communication" <c:if test="${pVO.h_communication==2}">checked</c:if> > 
						<label for="h_communication2">기타</label>
					</div>
				</li>
				
					<li>
					<label><span class="red_txt">*</span>모임빈도</label>
					<div class="checks propDiv">
						<input type="radio" id="h_party3" value="3" name="h_party" <c:if test="${pVO.h_party==3}">checked</c:if> > 
						<label for="h_party3">자주</label>
						<input type="radio" id="h_party2" value="2" name="h_party" <c:if test="${pVO.h_party==2}">checked</c:if> > 
						<label for="h_party2">가끔</label>
						<input type="radio" id="h_party1" value="1" name="h_party" <c:if test="${pVO.h_party==1}">checked</c:if> > 
						<label for="h_party1">없음</label>
					</div>
				</li>
				
					<li>
					<label><span class="red_txt">*</span>모임참가 의무</label>
					<div class="checks propDiv">
						<input type="radio" id="h_enter1" value="1" name="h_enter" <c:if test="${pVO.h_enter==1}">checked</c:if> > 
						<label for="h_enter1">없음</label>
						<input type="radio" id="h_enter2" value="2" name="h_enter" <c:if test="${pVO.h_enter==2}">checked</c:if> > 
						<label for="h_enter2">상관없음</label>
						<input type="radio" id="h_enter3" value="3" name="h_enter" <c:if test="${pVO.h_enter==3}">checked</c:if> > 
						<label for="h_enter3">있음</label>
					</div>
				</li>
			</ul>		
				<div class="btnclass">
					<a class="green" id="hPrev7" >이전</a>
					<a class="green" id="hNext7" >다음</a> 
					<a class="green" id="hIndex7" >취소</a>
				</div> <!-- 버튼div 종료 -->
		</div> <!-- 등록form7 종료 -->
		
		<div id="houseWrite8">
		
		<div class="title_wrap">
		<p class="s_title">하우스 성향 등록 (하우스지원 정보) </p> 
		<p>&nbsp;</p>
		</div>
		
			<ul class="form_box choice">
			
				<li>
					<label><span class="red_txt">*</span>하우스 내 지원서비스</label>
					<div class="checks propDiv">
						<input type="checkbox" id="h_support1" value="1" name="h_support" <c:forEach var="i" items="${pVO.h_support}"><c:if test="${i=='1'}">checked</c:if></c:forEach> > 
						<label for="h_support1">공용공간 청소지원</label>
									
						<input type="checkbox" id="h_support2" value="2" name="h_support" <c:forEach var="i" items="${pVO.h_support}"><c:if test="${i=='2'}">checked</c:if></c:forEach> > 
						<label for="h_support2">공용생필품 지원</label> <br/>
									
						<input type="checkbox" id="h_support3" value="3" name="h_support" <c:forEach var="i" items="${pVO.h_support}"><c:if test="${i=='3'}">checked</c:if></c:forEach> > 
						<label for="h_support3">기본 식품 지원</label>
					</div>
				</li> <br/><br/>
				<li><label><span class="red_txt">*</span>기타</label>
						<div class="checks checkbox propDiv">
							<input type="checkbox" name="h_etc" id="h_etc1" value="1" <c:forEach var="i" items="${pVO.h_etc}"><c:if test="${i=='1'}">checked</c:if></c:forEach> >
							<label for="h_etc1">보증금 조절 가능</label>
							<input type="checkbox" name="h_etc" id="h_etc3" value="3" <c:forEach var="i" items="${pVO.h_etc}"><c:if test="${i=='3'}">checked</c:if></c:forEach> >
							<label for="h_etc3">즉시 입주 가능</label>
						</div>
					</li>
			</ul>
				<div class="btnclass">
					<a class="green" id="hPrev8" >이전</a>
					<a class="green" id="hNext8" >다음</a> 
					<a class="green" id="hIndex8" >취소</a>
				</div> <!-- 버튼div 종료 -->
		</div> <!-- 등록form8 종료 -->
		
		<div id="houseWrite9">
		
		<div class="title_wrap">
		<p class="s_title">선호하는 메이트성향 선택 </p> <br/>
		
		<p>&nbsp;</p>
		</div>
		
			<ul class="form_box choice">
				<li>
					<label><span class="red_txt">*</span>생활 시간</label>
					<div class="checks propDiv">
						<input type="radio" id="m_pattern1" value="1" name="m_pattern" <c:if test="${pVO.m_pattern==1}">checked</c:if> > 
						<label for="m_pattern1">주행성</label>
						
						<input type="radio" id="m_pattern3" value="3" name="m_pattern" <c:if test="${pVO.m_pattern==3}">checked</c:if> > 
						<label for="m_pattern3">야행성</label>
					</div>
				</li>
				
				<li>
					<label><span class="red_txt">*</span>성격</label>
					<div class="checks propDiv">
						<input type="radio" id="m_personality1" value="1" name="m_personality" <c:if test="${pVO.m_personality==1}">checked</c:if> > 
						<label for="m_personality1">내향적</label>
						<input type="radio" id="m_personality3" value="3" name="m_personality" <c:if test="${pVO.m_personality==3}">checked</c:if> > 
						<label for="m_personality3">외향적</label>
						<input type="radio" id="m_personality2" value="2" name="m_personality" <c:if test="${pVO.m_personality==2}">checked</c:if> > 
						<label for="m_personality2">상관없음</label>
					</div>
				</li>
				
				<li>
					<label><span class="red_txt">*</span>반려동물 선호도</label>
					<div class="checks propDiv">
						<input type="radio" id="m_pet1" value="1" name="m_pet" <c:if test="${pVO.m_pet==1}">checked</c:if> > 
						<label for="m_pet1">긍정적</label>
						<input type="radio" id="m_pet3" value="3" name="m_pet" <c:if test="${pVO.m_pet==3}">checked</c:if> > 
						<label for="m_pet3">부정적</label>
					</div>
				</li>
				
				<li>
					<label><span class="red_txt">*</span>흡연</label>
					<div class="checks propDiv">
						<input type="radio" id="m_smoke1" value="1" name="m_smoke" <c:if test="${pVO.m_smoke==1}">checked</c:if> > 
						<label for="m_smoke1">비흡연</label>
						<input type="radio" id="m_smoke3" value="3" name="m_smoke" <c:if test="${pVO.m_smoke==3}">checked</c:if> > 
						<label for="m_smoke3">흡연</label>
						<input type="radio" id="m_smoke2" value="2" name="m_smoke" <c:if test="${pVO.m_smoke==2}">checked</c:if> > 
						<label for="m_smoke2">상관없음</label>
					</div>
				</li>
				
				<li>
					<label><span class="red_txt">*</span>연령대</label>
					<div class="checks propDiv">
						<input type="radio" id="m_age1" value="1" name="m_age" <c:if test="${pVO.m_age==1}">checked</c:if> > 
						<label for="m_age1">20~30대</label>
						<input type="radio" id="m_age3" value="3" name="m_age" <c:if test="${pVO.m_age==3}">checked</c:if> > 
						<label for="m_age3">40대 이상</label>
						<input type="radio" id="m_age2" value="2" name="m_age" <c:if test="${pVO.m_age==2}">checked</c:if> > 
						<label for="m_age2">상관없음</label>
					</div>
				</li>	
				
				<li>
					<label><span class="red_txt">*</span>성별</label>
					<div class="checks propDiv">
						<input type="radio" id="m_gender1" value="1" name="m_gender" <c:if test="${pVO.m_gender==1}">checked</c:if> > 
						<label for="m_gender1">여성</label>
						<input type="radio" id="m_gender3" value="3" name="m_gender" <c:if test="${pVO.m_gender==3}">checked</c:if> > 
						<label for="m_gender3">남성</label>
						<input type="radio" id="m_gender2" value="2" name="m_gender" <c:if test="${pVO.m_gender==2}">checked</c:if> > 
						<label for="m_gender2">상관없음</label>
					</div>
				</li>	
				
				<li>
					<label><span class="red_txt">*</span>외국인입주 가능여부</label>
					<div class="checks">
						<input type="radio" id="m_global3" value="3" name="m_global" <c:if test="${pVO.m_global==3}">checked</c:if> > 
						<label for="m_global3">가능</label>
						<input type="radio" id="m_global1" value="1" name="m_global" <c:if test="${pVO.m_global==1}">checked</c:if> > 
						<label for="m_global1">불가능</label>
					</div>
				</li>
				
				<li>
					<label><span class="red_txt">*</span>즉시입주 가능여부</label>
					<div class="checks propDiv">
						<input type="radio" id="m_now1" value="1" name="m_now" <c:if test="${pVO.m_now==1}">checked</c:if> > 
						<label for="m_now1">가능</label>
						<input type="radio" id="m_now3" value="3" name="m_now" <c:if test="${pVO.m_now==3}">checked</c:if> > 
						<label for="m_now3">불가능</label>
					</div>
				</li>		
			</ul>	
				<div class="btnclass">
					<a class="green" id="hPrve9" >이전</a>
					<button class="green" id="hNext9" >수정</button> 
					<a class="green" id="hIndex9" >취소</a>
				</div> <!-- 버튼div 종료 -->
		</div> <!-- 등록form9 종료 -->	
	
	</form> <!-- 방등록 form  -->

</div> <!-- content 종료 -->
</div> <!-- wrap -->
