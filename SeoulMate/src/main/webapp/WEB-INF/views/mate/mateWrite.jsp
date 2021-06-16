<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="//cdn.ckeditor.com/4.16.0/basic/ckeditor.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/housemate.css">
<c:set var="today" value="<%=new java.util.Date()%>"/>
<c:set var="now"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/></c:set>
<script>
$(function(){
	console.log("${mVO.gender}");
	CKEDITOR.replace("mateProfile", {
		height:300,
		width:'100%'
		
	}); //설명글 name 설정 필요
	
	$("#write").on('submit', function(){
		if(CKEDITOR.instances.content.getData()==""){
			alert("내용을 입력해주세요");
			return false;
		}return true;
	});
	
// });

	

$(function(){
	
	
	
	$("#mNext1").click(function(){
		
		if($("#rent").val()==""){
			alert("월세를 입력해주세요");
			return false;
		}
		if($("#deposit").val()==""){
			alert("보증금을 입력해주세요");
			return false;
		}
		if($("#gu1Edit").val()==""){
			alert("주소를 입력해주세요");
			return false;
		}
		if($("#dong1Edit").val()==""){
			alert("주소를 입력해주세요");
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
		
		$("#mateWrite1").css("display", "none");
		$("#mateWrite2").css("display", "block");
	});
	$("#mPrev1").click(function(){
		$("#mateWrite1").css("display", "none");
		$("#mateWrite1").css("display", "block"); //등록form1에서 이전 어디로?
	});
	$("#mIndex1").click(function(){
		location.href="<%=request.getContextPath()%>/mateIndex";
	});
	
	$("#mNext2").click(function(){
		
		if($("#matePic1").val()==""){
			alert("(첫번째 파일부터)사진을 1장이상 등록해주세요");
			return false;
		}
		
		$("#mateWrite2").css("display", "none");
		$("#mateWrite3").css("display", "block");
	});
	$("#mPrev2").click(function(){
		$("#mateWrite2").css("display", "none");
		$("#mateWrite1").css("display", "block"); 
	});
	$("#mIndex2").click(function(){
		location.href="<%=request.getContextPath()%>/mateIndex";
	});
	
	$("#mNext3").click(function(){
		$("#mateWrite3").css("display", "none");
		$("#mateWrite4").css("display", "block");
	});
	$("#mPrev3").click(function(){
		$("#mateWrite3").css("display", "none");
		$("#mateWrite2").css("display", "block"); 
	});
	$("#mIndex3").click(function(){
		location.href="<%=request.getContextPath()%>/mateIndex";
	});
	
	$("#mNext4").click(function(){
		
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
		
		$("#mateWrite4").css("display", "none");
		$("#mateWrite5").css("display", "block");
	});
	$("#mPrev4").click(function(){
		$("#mateWrite4").css("display", "none");
		$("#mateWrite3").css("display", "block"); 
	});
	$("#mIndex4").click(function(){
		location.href="<%=request.getContextPath()%>/mateIndex";
	});
	
	$("#mNext5").click(function(){
		
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
		
		$("#mateWrite5").css("display", "none");
		$("#mateWrite6").css("display", "block");
	});
	$("#mPrev5").click(function(){
		$("#mateWrite5").css("display", "none");
		$("#mateWrite4").css("display", "block"); 
	});
	$("#mIndex5").click(function(){
		location.href="<%=request.getContextPath()%>/mateIndex";
	});
	
	$("#mNext6").click(function(){
		$("#mateWrite6").css("display", "none");
		$("#mateWrite7").css("display", "block"); 
	});
	$("#mPrev6").click(function(){
		$("#mateWrite6").css("display", "none");
		$("#mateWrite5").css("display", "block"); 
	});
	$("#mIndex6").click(function(){
		location.href="<%=request.getContextPath()%>/mateIndex";
	});
	$("#mNext7").click(function(){
		
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
		
		var hopeGender = document.mateFrm.m_gender.value;
		console.log(hopeGender);
		if(hopeGender==${mVO.gender}||hopeGender==2){ //자신과 다른 성별 선택불가
			if(confirm("메이트 정보를 등록하시겠습니까?")){
				$("#mateFrm").submit();
				return true;
			}
		}else if(hopeGender!=${mVO.gender}&&hopeGender!=2){
			alert("희망성별은 자신과 다른 성별을 선택할 수 없습니다.");
			return false;
		}
		
		
		
		
		location.href="<%=request.getContextPath()%>/mateIndex";
	});
	$("#mPrev7").click(function(){
		$("#mateWrite7").css("display", "none");
		$("#mateWrite6").css("display", "block"); 
	});
	$("#mIndex7").click(function(){
		location.href="<%=request.getContextPath()%>/mateIndex";
	});
	
		// 희망 지역1
		var area1=$("#gu1Edit").val();
		// alert(area1);
		if(area1=="구를 선택해주세요"){
			area1="";
		}else{
			area1+=" "+$("#dong1Edit").val();
		}
		document.getElementById("area1Edit").value=area1;
		
		// 희망 지역2
		var area2=$("#gu2Edit").val();
		// alert(area2);
		if(area2=="구를 선택해주세요"){
			area2="";
		}else{
			area2+=" "+$("#dong2Edit").val();
		}
		document.getElementById("area2Edit").value=area2;
		
		// 희망 지역3
		var area3=$("#gu3Edit").val();
		
		// alert(area3);
		if(area3=="구를 선택해주세요"){
			area3="";
		}else{
			area3+=" "+$("#dong3Edit").val();
		}
		document.getElementById("area3Edit").value=area3;
	
		areaEdit(); // 희망 지역 수정을 위한 함수
	});
		//희망 지역 수정
		$("select.selectGu").change(function(){
			var temp=$(this);
			var url="memberDong";
			var params="gu="+$(this).val();
			$.ajax({
				url:url,
				data:params,
				success:function(result){
					var $result=$(result);
					
					temp.next().text("");
					$result.each(function(idx, dong){
						temp.next().append("<option>"+dong+"</option>");
					});
				}, error:function(){
					console.log("동 들고오기 에러 발생");
				}
			});
		});
	});	
	// 희망 지역 1,2,3에 구,동 넣기
	function areaInput(){
		
		var a1=$("#area1Edit").val().indexOf(" "); // 희망 지역1의 띄어쓰기 위치 구하기
		var a2=$("#area2Edit").val().indexOf(" "); // 희망 지역2의 띄어쓰기 위치 구하기
		var a3=$("#area3Edit").val().indexOf(" "); // 희망 지역3의 띄어쓰기 위치 구하기
		
		// alert(typeof a1); // 변수의 데이터 타입을 확인
		
		if(a1!=-1){ // 희망 지역 1이 있을 때
			
			var gu1=$("#area1Edit").val().substring(0,a1);
// 			alert("gu1->"gu1)
			var dong1=$("#area1Edit").val().substring(a1+1);
			$("#gu1Edit>option[value='"+gu1+"']").attr('selected', true);
// 			$("#dong1Edit").append("<option value='"+dong1+"' selected>"+dong1+"</option>");
			$("#dong1Edit>option[value='"+dong1+"']").attr('selected', true);
		}
		if(a2!=-1){ // 희망 지역 2가 있을 때
			var gu2=$("#area2Edit").val().substring(0,a2);
			var dong2=$("#area2Edit").val().substring(a2+1);
			$("#gu2Edit>option[value='"+gu2+"']").attr('selected', true);
// 			$("#dong2Edit").append("<option value='"+dong2+"' selected>"+dong2+"</option>");
			$("#dong2Edit>option[value='"+dong2+"']").attr('selected', true);
		}
		if(a3!=-1){ // 희망 지역 3이 있을 때
			var gu3=$("#area3Edit").val().substring(0,a3);
			var dong3=$("#area3Edit").val().substring(a3+1);
			$("#gu3Edit>option[value='"+gu3+"']").attr('selected', true);
// 			$("#dong3Edit").append("<option value='"+dong3+"' selected>"+dong3+"</option>");
			$("#dong3Edit>option[value='"+dong3+"']").attr('selected', true);
		}
	}
	
	$(window).ready(function(){
		areaInput();
		
	});
	
	function areaEdit(){
		var gu1=$("#gu1Edit").val();
		var dong1=$("#dong1Edit").val();
		var gu2=$("#gu2Edit").val();
		var dong2=$("#dong2Edit").val();
		var gu3=$("#gu3Edit").val();
		var dong3=$("#dong3Edit").val();
		
		if(dong1!="동을 선택해주세요"){
			document.getElementById("area1Edit").value=gu1+" "+dong1;
		}
		if(dong2!="동을 선택해주세요"){
			document.getElementById("area2Edit").value=gu2+" "+dong2;
		}
		if(dong3!="동을 선택해주세요"){
			document.getElementById("area3Edit").value=gu3+" "+dong3;
		}
		
	}
	
	
	function readURL1(input) {
	    if (input.files && input.files[0]) {
	    var reader = new FileReader();
	
	    reader.onload = function (e) {
	            $('#mateImg1').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
    function readURL2(input) {
	    if (input.files && input.files[0]) {
	    var reader = new FileReader();
	
	    reader.onload = function (e) {
	            $('#mateImg2').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
    }
    
    function readURL3(input) {
	    if (input.files && input.files[0]) {
	    var reader = new FileReader();
	
	    reader.onload = function (e) {
	            $('#mateImg3').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
    }
    
	
	
	
	

</script>
<div class="wrap">
<div class="content">
	
	<div class="title_wrap">
	<p class="m_title">메이트 등록하기 </p> 
	<p>&nbsp;</p>
	</div>
	
	<form method="post" id="mateFrm" name="mateFrm" action="mateWriteOk" enctype="multipart/form-data">
	
	<div id="mateWrite1">
	
	<div class="title_wrap">
	<p class="s_title">기본 정보 등록 </p>
	<p>&nbsp;</p>
	</div>
		<input type="hidden" name="pno" value="${pVO.pno }"/>
		
		<ul class="form_box">
			<li><label><span class="red_txt">*</span>월세(관리비)</label> <input type="number" id="rent" name="rent"/> </li>	
			<li><label><span class="red_txt">*</span>보증금(조율) </label><input type="number" id="deposit" name="deposit"/> </li>			
<!-- 			<li> <label><span class="red_txt">*</span> 희망 지역 </label> -->
<!-- 					<input type="text" name="area" id="area"/>  -->
<!-- 					<input type="text" name="area" id="area2"/> <input type="text" name="area" id="area3"/> </li> -->
			<li id="a1"><label>&nbsp;희망 지역1</label>
					<div id="area1Div">
						<select class="selectGu" id="gu1Edit">
							<option hidden>구를 선택해주세요</option>
							<c:forEach var="gu" items="${guArr}">
								<option value="${gu}">${gu}</option>
							</c:forEach>
						</select>
						<select id="dong1Edit">
							<option hidden>동을 선택해주세요</option>
							<c:forEach var="dong" items="${selDong1}">
								<option value="${dong}">${dong}</option>
							</c:forEach>
						</select>
					</div>
					<input type="hidden" name="area1" id="area1Edit" value="${mVO.area1}" readonly/>
					
				</li>
				<li id="a2"><label>&nbsp;희망 지역2</label>
					<div id="area2Div">
						<select class="selectGu" id="gu2Edit">
							<option hidden>구를 선택해주세요</option>
							<c:forEach var="gu" items="${guArr}">
								<option value="${gu}">${gu}</option>
							</c:forEach>
						</select>
						<select id="dong2Edit">
							<option hidden>동을 선택해주세요</option>
							<c:forEach var="dong" items="${selDong2}">
								<option value="${dong}">${dong}</option>
							</c:forEach>
						</select>
					</div>
					<input type="hidden" name="area2" id="area2Edit" value="${mVO.area2}" readonly/>
					
				</li>					
				<li id="a3"><label>&nbsp;희망 지역3</label>
				<div id="area3Div">
					<select class="selectGu" id="gu3Edit">
						<option hidden>구를 선택해주세요</option>
						<c:forEach var="gu" items="${guArr}">
							<option value="${gu}">${gu}</option>
						</c:forEach>
					</select>
					<select id="dong3Edit">
						<option hidden>동을 선택해주세요</option>
							<c:forEach var="dong" items="${selDong3}">
								<option value="${dong}">${dong}</option>
							</c:forEach>
					</select>
				</div>
					<input type="hidden" name="area3" id="area3Edit" value="${mVO.area3}" readonly/>
					
				</li>
			<li> <label><span class="red_txt">*</span>입주가능일 </label><input type="date" id="enterdate" min=${now } name="enterdate" > </li>
			<li> <label><span class="red_txt">*</span>최소 거주 기간</label>
				 	<select name="minStay" id="minStay">
				 		<option value="">선택하세요</option>
						<option value="1-3개월">1~3 개월</option>
						<option value="4-6개월">4~6 개월</option>
						<option value="7-12개월">7~12 개월</option>
						<option value="1년 이상">1년 이상</option> 
					</select> </li>
			<li> <label><span class="red_txt">*</span>최대 거주 기간</label>
					<select name="maxStay" id="maxStay">
						<option value="">선택하세요</option>
						<option value="1-3개월">1~3 개월</option>
						<option value="4-6개월">4~6 개월</option>
						<option value="7-9개월">7~12 개월</option>
						<option value="1년 이상">1년 이상</option>
					</select> </li>
		</ul>
			<div class="btnclass">
				<a id="mPrev1" class="green" >이전</a>
				<a id="mNext1" class="green" >다음</a>
				<a id="mIndex1" class="green" >취소</a>
			</div> <!-- 버튼div 종료 -->
	</div>	<!-- 등록form1 종료 -->
	
		
	<div id="mateWrite2">
	
	<div class="title_wrap">
	<p class="s_title">사진 등록 </p>
	<p>&nbsp;</p>
	</div>
	
		<ul class="form_box">
				<li id="mPic">
					<img id="mateImg1" name="mateImg1" src="#" alt="upload image" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_house_pic.png'"  />
					<img id="mateImg2" name="mateImg2" src="#" alt="upload image" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_house_pic.png'"  />
					<img id="mateImg3" name="mateImg3" src="#" alt="upload image" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_house_pic.png'"  />
				</li>
				<li> 
					<input type="file" accept="image/*" name="filename" id="matePic1" onchange="readURL1(this);"/> 
					<input type="file" accept="image/*" name="filename" id="matePic2" onchange="readURL2(this);"/> 
					<input type="file" accept="image/*" name="filename" id="matePic3" onchange="readURL3(this);"/> 
				<br/> </li>
				
		</ul>
			<div class="btnclass">
				<a id="mPrev2" class="green" >이전</a>
				<a id="mNext2" class="green" >다음</a>
				<a id="mIndex2" class="green" >취소</a>
			</div> <!-- 버튼div 종료 -->
		
	</div> <!-- 등록form2 종료 -->
	
	<div id="mateWrite3"> 
	
	<div class="title_wrap">
	<p class="s_title">내 소개 등록 </p>
	<p>&nbsp;</p>
	</div>
	<div id="ck">
		<textarea id="write" name="mateProfile" id="mateProfile"></textarea><br/>
	</div>		
			<div class="btnclass">
				<a id="mPrev3" class="green" >이전</a>
				<a id="mNext3" class="green" >다음</a>
				<a id="mIndex3" class="green" >취소</a>
			</div> <!-- 버튼div 종료 -->
			
	</div> <!-- 등록form3 종료 -->
	
	<div id="mateWrite4">
		<div class="title_wrap">
		<p class="s_title">선호하는 하우스성향 선택 </p>
		<p>&nbsp;</p>
		</div>	
		<ul class="form_box choice">
				<li>
					<label><span class="red_txt">*</span>생활소음</label>
					<div class="checks">
						<input type="radio" id="h_noise1" value="1" name="h_noise" <c:if test="${pVO.h_noise==1}">checked</c:if>> 
						<label for="h_noise1">매우 조용함</label>
						
						<input type="radio" id="h_noise2" value="2" name="h_noise" <c:if test="${pVO.h_noise==2}">checked</c:if>> 
						<label for="h_noise2">보통</label>
						
						<input type="radio" id="h_noise3" value="3" name="h_noise" <c:if test="${pVO.h_noise==3}">checked</c:if>> 
						<label for="h_noise3">조용하지 않음</label>
					</div>
				</li>
				
				<li>
					<label><span class="red_txt">*</span>생활시간</label>
					<div class="checks">
						<input type="radio" id="h_pattern1" value="1" name="h_pattern" <c:if test="${pVO.h_pattern==1}">checked</c:if> > 
						<label for="h_pattern1">주행성</label>
						
						<input type="radio" id="h_pattern3" value="3" name="h_pattern" <c:if test="${pVO.h_pattern==3}">checked</c:if> > 
						<label for="h_pattern3">야행성</label>
					</div>
				</li>
				
					<li>
					<label><span class="red_txt">*</span>반려동물 여부</label>
					<div class="checks">
						<input type="radio" id="h_pet3" value="3" name="h_pet" <c:if test="${pVO.h_pet==3}">checked</c:if> > 
						<label for="h_pet3">있음</label>	
						
						<input type="radio" id="h_pet1" value="1" name="h_pet" <c:if test="${pVO.h_pet==1}">checked</c:if> > 
						<label for="h_pet1">없음</label>
					</div>
				</li>
				
				<li>
					<label><span class="red_txt">*</span>반려동물 동반 입실 여부</label>
					<div class="checks">
						<input type="radio" id="h_petwith3" value="3" name="h_petwith" <c:if test="${pVO.h_petwith==3}">checked</c:if> > 
						<label for="h_petwith3">가능</label>
						
						<input type="radio" id="h_petwith1" value="1" name="h_petwith" <c:if test="${pVO.h_petwith==1}">checked</c:if> > 
						<label for="h_petwith1">불가능</label>
					</div>
				</li>
				
				<li>
					<label><span class="red_txt">*</span>흡연</label>
					<div class="checks">
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
				<a id="mPrev4" class="green" >이전</a>
				<a id="mNext4" class="green" >다음</a>
				<a id="mIndex4" class="green" >취소</a>
			</div> <!-- 버튼div 종료 -->
	
	</div> <!-- 등록form4 종료 -->
		
	<div id="mateWrite5">
	
	<div class="title_wrap">
	<p class="s_title">원하는 하우스 성향 등록(소통정보) </p> 
	<p>&nbsp;</p>
	</div>
		<ul class="form_box choice">
			
				<li>
					<label><span class="red_txt">*</span>분위기</label>
					<div class="checks">
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
					<div class="checks">
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
					<div class="checks">
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
					<div class="checks">
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
				<a id="mPrev5" class="green" >이전</a>
				<a id="mNext5" class="green" >다음</a>
				<a id="mIndex5" class="green" >취소</a>
			</div> <!-- 버튼div 종료 -->

	</div> <!-- 등록form5 종료 -->

	<div id="mateWrite6">
	
	<div class="title_wrap">
	<p class="s_title">원하는 하우스 성향 등록(하우스 지원 정보) </p> 
	<p>&nbsp;</p>
	</div>
		<ul class="form_box choice">
			<li>
			<label><span class="red_txt">*</span>하우스 내 지원서비스</label>
				<div class="checks">
					<input type="checkbox" id="h_support1" value="1" name="h_support" <c:forEach var="i" items="${pVO.h_support}"><c:if test="${i=='1'}">checked</c:if></c:forEach> > 
					<label for="h_support1">공용공간 청소지원</label>
								
					<input type="checkbox" id="h_support2" value="2" name="h_support" <c:forEach var="i" items="${pVO.h_support}"><c:if test="${i=='2'}">checked</c:if></c:forEach> > 
					<label for="h_support2">공용생필품 지원</label> <br/>
								
					<input type="checkbox" id="h_support3" value="3" name="h_support" <c:forEach var="i" items="${pVO.h_support}"><c:if test="${i=='3'}">checked</c:if></c:forEach> > 
					<label for="h_support3">기본 식품 지원</label>
				</div>
			</li> <br/><br/>
			<li><label><span class="red_txt">*</span>기타</label>
						<div class="checks checkbox">
							<input type="checkbox" name="h_etc" id="h_etc1" value="1" <c:forEach var="i" items="${pVO.h_etc}"><c:if test="${i=='1'}">checked</c:if></c:forEach> />
							<label for="h_etc1">보증금 조절 가능</label>
							<input type="checkbox" name="h_etc" id="h_etc3" value="3" <c:forEach var="i" items="${pVO.h_etc}"><c:if test="${i=='3'}">checked</c:if></c:forEach> />
							<label for="h_etc3">즉시 입주 가능</label>
						</div>
					</li>
		</ul>
			<div class="btnclass">
				<a id="mPrev6" class="green" >이전</a>
				<a id="mNext6" class="green" >다음</a>
				<a id="mIndex6" class="green" >취소</a>
			</div> <!-- 버튼div 종료 -->
	
	</div> <!-- 등록form6 종료 -->		
	
	<div id="mateWrite7">
	
	<div class="title_wrap">
	<p class="s_title">나의 (메이트)성향 선택 </p> <br/>
	<p>&nbsp;</p>
	</div>
		<ul class="form_box choice">
			<li>
				<label><span class="red_txt">*</span>생활 시간</label>
				<div class="checks">
					<input type="radio" id="m_pattern1" value="1" name="m_pattern" <c:if test="${pVO.m_pattern==1}">checked</c:if> > 
					<label for="m_pattern1">주행성</label>
					<input type="radio" id="m_pattern3" value="3" name="m_pattern" <c:if test="${pVO.m_pattern==3}">checked</c:if> > 
					<label for="m_pattern3">야행성</label>
				</div>
			</li>
				
			<li>
				<label><span class="red_txt">*</span>성격</label>
				<div class="checks">
					<input type="radio" id="m_personality1" value="1" name="m_personality" <c:if test="${pVO.m_personality==1}">checked</c:if> > 
					<label for="m_personality1">내향적</label>
					<input type="radio" id="m_personality3" value="3" name="m_personality" <c:if test="${pVO.m_personality==3}">checked</c:if> > 
					<label for="m_personality3">외향적</label>
					<input type="radio" id="m_personality2" value="2" name="m_personality" <c:if test="${pVO.m_personality==2}">checked</c:if> > 
					<label for="m_personality2">상관없음</label>
				</div>
			</li>
			
			<li>
				<label><span class="red_txt">*</span>반려동물</label>
				<div class="checks">
					<input type="radio" id="m_pet1" value="1" name="m_pet" <c:if test="${pVO.m_pet==1}">checked</c:if> > 
					<label for="m_pet1">긍정적</label>
					<input type="radio" id="m_pet3" value="3" name="m_pet" <c:if test="${pVO.m_pet==3}">checked</c:if> > 
					<label for="m_pet3">부정적</label>
				</div>
			</li>
				
			<li>
				<label><span class="red_txt">*</span>흡연</label>
				<div class="checks">
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
				<div class="checks">
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
				<div class="checks">
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
				<div class="checks">
					<input type="radio" id="m_now1" value="1" name="m_now" <c:if test="${pVO.m_now==1}">checked</c:if> > 
					<label for="m_now1">가능</label>
					<input type="radio" id="m_now3" value="3" name="m_now" <c:if test="${pVO.m_now==3}">checked</c:if> > 
					<label for="m_now3">불가능</label>
				</div>
			</li>		
		</ul>	
	
			<div class="btnclass">
				<a id="mPrev7" class="green" >이전</a>
				<a id="mNext7" class="green" >등록</a>
			</div> <!-- 버튼div 종료 -->
	</div> <!--  등록form7 종료 --> 
	
	
	</form>
	</div> <!-- content 종료 -->

</div>
