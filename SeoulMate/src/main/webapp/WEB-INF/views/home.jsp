<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src = "<%=request.getContextPath()%>/js/like.js"></script>
<c:set var ="mateArrList" value="mateMapList"/>
<script>
	$(function(){
		$("#hPnoSelect>a").click(function(){
			var hpno=$(this).attr("id");
			location.href="hpnoDefault?pno="+hpno;
		});
		$("#select_house").click(function(){
			$("#addr_search").attr("type","text");
			$("#area_search").attr("type","hidden");
		});
		$("#select_mate").click(function(){
			$("#area_search").attr("type","text");
			$("#addr_search").attr("type","hidden");
		});
	});
	
	function pcase(){
		var pcase = $('input[name="main_search"]:checked').val();
		if(pcase=="h"){
			$("#homeSearchForm").attr("action","houseIndex");
		}else if(pcase=="m"){
			$("#homeSearchForm").attr("action","mateIndex");
		}
	}
	function exitCheck(){
		if(${pwdCheck=='일치'}){
			alert("그동안 서울 메이트를 이용해주셔서 감사합니다.");
		}
	}
   exitCheck();
   //console.log(${logGrade});
   $(function(){
	   //=============================================================세트
	   if(${logId != null}){ // 로그인 했을때만 실행
			//내가 찜한 글은 별버튼에 불 들어오기 & 내가 올린 글은 별 버튼 숨기기
		   $.ajax({
			   url : '/home/likemarkCheck',
			   data : {'userid': '${logId}'},
			   traditional : true,
			   success : function(result){
				   console.log(result.mateNum)
				   likeButtonOn(result); // 찜한거 불 넣기 & 자기글 버튼 안보이게 하기
			   },error : function(){
				   console.log('찜 목록 불러오기 실패');
			   }
		   });
	   }
		// 찜하기 등록 + 삭제
		$('.btn_star').click(function(){
			var obj = $(this);
			var no = $(this).val();
			var userid = '${logId}'
			var category = '';
			if($(obj).hasClass('on')){// 이미 등록한 버튼 눌리면 찜목록에서 삭제
				likeDelete(no, userid, obj)
			}else{
				if($(this).hasClass('houselike')){ // 찜하는 글이 하우스 글일때
					category = '하우스';
				}else{ //메이트 글일때.
					category = '메이트';
				}
				likeInsert(no, category, userid, obj); // 찜 등록 ajax함수.
			}
		});
		//=====================================================================세트
});

</script>
<div class="main_wrap">
   <div class="content">
      <h2 class="main_title">
         당신과 가장 잘 맞는<br>
         쉐어하우스 & 메이트
      </h2>
      <form class="main_search_form" id="homeSearchForm" method="get" action="/home" onsubmit="return pcase();">
         <div class="checks">
            <input type="radio" id="select_house" name="main_search" value="h" checked> 
            <label for="select_house">쉐어하우스</label>
            <input type="radio" id="select_mate" name="main_search" value="m"> 
            <label for="select_mate">하우스메이트</label>
         </div>
         <div class="search_box">
            <input class="search_text" name="addr" id="addr_search" type="text" placeholder="지역명을 입력하세요.">
            <input class="search_text" name="area" id="area_search" type="hidden" placeholder="지역명을 입력하세요.">
            <button type="submit" class="green"></button>
         </div>
      </form>
   </div>
   <c:if test="${myHousePnoCnt>1}">
	   <c:if test="${logGrade==2}"> <!-- 프리미엄인 하우스의 성향 고르기 -->
	   		<div class="title_wrap" id="hPnoSelect">
	   			<p class="s_title">어느 집의 메이트를 구하시나요?</p><br/>
				<c:forEach var="housePno" items="${myHousePno}" varStatus="index">
					<a class="<c:if test='${hPno==housePno.pno}'>green</c:if>" id="${housePno.pno}">
						<c:if test="${housePno.housename!=null}">${housePno.housename}</c:if>
						<c:if test="${housePno.housename==null}">이름없는 집 ${index.count}</c:if>
					</a>
				</c:forEach>
			</div>
   	   </c:if>
   </c:if>
   <!-- 프리미엄 추천 쉐어하우스 -->
   <c:if test="${logGrade==2}">
	   <c:if test="${matePnoCheck>0}">
		   <section class="content recommend_list">
		      <div class="list_head">
			       <p class="m_title">${logName}님과 잘 어울리는 집이예요!</p>
			       <a href="houseMatching">더보기</a>
		      </div>
		      <c:if test="${phList!=null}">
			      <ul class="list_content">
			         <c:forEach var="phList" items="${phList}">
			            <li>
			               <div class="list_img">
			                  <p><span>매칭</span>${phList.score}<b>%</b></p>
			                   <c:if test="${logId != null}">
	                  				<button class="btn_star houselike" value="${phList.no}"></button>
	                		  </c:if>
			                  <a href="houseView?no=${phList.no}">
			                     <img alt="${phList.housename}" src="<%=request.getContextPath()%>/housePic/${phList.housepic1}" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_house_pic.png'">
			                  </a>
			               </div>
			               <div class="list_title">
			                  <span class="address">${phList.addr}</span>
			                  <span class="pay">￦ ${phList.deposit} / ${phList.rent}</span>
			               </div>
			               <ol class="list_icon">
			                  <li><p>${phList.room}</p></li>
			                  <li><p>${phList.bathroom}</p></li>
			                  <li><p>${phList.nowpeople}</p></li>
			               </ol>
			            </li>
			         </c:forEach>
			      </ul>
		      </c:if>
		      <c:if test="${phList==null}">
		      	<div class="empty_div">
			      	<img class="empty" src="<%=request.getContextPath()%>/img/empty.png" onerror="this.src='<%=request.getContextPath()%>/img/empty.png'"/>
			      	<p style="text-align:center;">매칭에 맞는 결과가 없습니다.</p>
		      	</div>
		      </c:if>
		   </section>
	   </c:if>
   </c:if>

   <!-- 신규 쉐어하우스 -->
   <section class="content recommend_list">
      <div class="list_head">
         <p class="m_title">NEW 쉐어하우스</p>
         <a href="houseIndex">더보기</a>
      </div>
      <c:if test="${newHouseListCnt>0}">
      <ul class="list_content">
         <c:forEach items="${newHouseList}" var="newHouseVO">
            <li>
               <div class="list_img">
               	<c:if test="${logGrade==2}">
               	  <c:if test="${matePnoCheck>0}"> <!-- 등록된 메이트 성향이 없으면 매칭을 안보여줌 -->
                  <p><span>매칭</span>${newHouseVO.score}<b>%</b></p>
                  </c:if>
                </c:if>
                  <c:if test="${logId != null}">
      				<button class="btn_star houselike" value="${newHouseVO.no}"></button>
    		  	  </c:if>
                  
                  <a href="houseView?no=${newHouseVO.no}">
                     <img alt="" src="<%=request.getContextPath()%>/housePic/${newHouseVO.housepic1}" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_house_pic.png'">
                  </a>
               </div>
               <div class="list_title">
                  <span class="address">${newHouseVO.addr}</span>
                  <span class="pay">￦ ${newHouseVO.deposit} / ${newHouseVO.rent}</span>
               </div>
               <ol class="list_icon">
                  <li><p>${newHouseVO.room}</p></li>
                  <li><p>${newHouseVO.bathroom}</p></li>
                  <li><p>${newHouseVO.nowpeople}</p></li>
               </ol>
            </li>
         </c:forEach>
      </ul>
      </c:if>
      <c:if test="${newHouseListCnt==0}">
	  	<div class="empty_div">
      		<img class="empty" src="<%=request.getContextPath()%>/img/empty.png" onerror="this.src='<%=request.getContextPath()%>/img/empty.png'"/>
      		<p style="text-align:center;">필터에 맞는 결과가 없습니다.</p>
     	</div>
	</c:if>
   </section>

   <c:if test="${myHousePnoCnt>0}">
	   <c:if test="${logGrade==2}">
		   <!-- 프리미엄 추천 하우스메이트 -->
		   <section class="content recommend_list mate_list">
		      <div class="list_head">
		         <p class="m_title">${logName}님과 잘 어울리는 메이트예요!</p>
		         <a href="mateMatching">더보기</a>
		      </div>
		      <c:if test="${pmList!=null}">
			      <ul class="list_content">
			         <c:forEach var="pmList" items="${pmList}">
			            <li>
			               <div class="list_img">
			                  <p><span>매칭</span>${pmList.score}<b>%</b></p>
			                  
			                  <c:if test="${logId != null}">
			      				<button class="btn_star matelike" value="${pmList.no}"></button>
			    		  	  </c:if>
			                  
			                  <a href="mateView?no=${pmList.no}">
			                     <img alt="" src="<%=request.getContextPath()%>/matePic/${pmList.matepic1}" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_mate_pic.png'">
			                  </a>
			               </div>
			               <div class="list_title">
			                  <span class="mate_id">${pmList.userid}</span>
			                  <span class="pay">￦ ${pmList.deposit} / ${pmList.rent}</span>
			               </div>
			               <span class="address">
			               		${pmList.area1}
			               		<c:if test="${pmList.area2 != null }"> |  ${pmList.area2}</c:if>
			               		<c:if test="${pmList.area3 != null }"> |  ${pmList.area3}</c:if>
<%-- 			               		<c:if test="${pmList.area2!=null}">${pmList.area2}</c:if> --%>
<%-- 			               		<c:if test="${pmList.area3!=null}">${pmList.area3}</c:if> --%>
			               </span>
			               <ol class="list_icon">
			                  <li>
			                  	<p>
				                  	<c:if test="${pmList.gender==1}">여</c:if>
	                  				<c:if test="${pmList.gender==3}">남</c:if>
                  				</p>
							  </li>
			                  <li><p>${pmList.birth}세</p></li>
			                  <li><p>${pmList.enterdate}</p></li>
			               </ol>
			            </li>
			         </c:forEach>
			      </ul>
		      </c:if>
		      <c:if test="${pmList==null}">
				<div class="empty_div">
	      			<img class="empty" src="<%=request.getContextPath()%>/img/empty.png" onerror="this.src='<%=request.getContextPath()%>/img/empty.png'"/>
	      			<p style="text-align:center;">매칭에 맞는 결과가 없습니다.</p>
      			</div>
		      </c:if>
		   </section>
	   </c:if>
   </c:if>
   <!-- 신규 하우스메이트 -->
   <section class="content recommend_list mate_list">
      <div class="list_head">
         <p class="m_title">NEW 하우스메이트</p>
         <a href="mateIndex">더보기</a>
      </div>
      <c:if test="${newMateListCnt!=0}">
	      <ul class="list_content">
	         <c:forEach items="${newMateList}" var="newMateVO">
	            <li>
	               <div class="list_img">
	               	 <c:if test="${myHousePnoCnt>0}"> <!-- 등록된 하우스 성향이 없으면 매칭을 안보여줌 -->
	               	 	<c:if test="${logGrade==2}"> <!-- 프리미엄만 매칭을 보여줌 -->
	                  		<p><span>매칭</span>${newMateVO.score}<b>%</b></p>
	                  	</c:if>
	                 </c:if>
	                 
	                  <c:if test="${logId != null}">
	      				<button class="btn_star matelike" value="${newMateVO.no}"></button>
	    		  	  </c:if>
	                 
	                  <a href="mateView?no=${newMateVO.no}">
	                     <img alt="" src="<%=request.getContextPath()%>/matePic/${newMateVO.matePic1}" onerror="this.src='<%=request.getContextPath()%>/img/comm/no_mate_pic.png'">
	                  </a>
	               </div>
	               <div class="list_title">
	                  <span class="mate_id">${newMateVO.userid}</span>
	                  <span class="pay">￦ ${newMateVO.deposit} / ${newMateVO.rent}</span>
	               </div>
	               <span class="address">
	               	${newMateVO.listVO.area1} 
	               	<c:if test="${newMateVO.listVO.area2 != null}">
	                	| ${newMateVO.listVO.area2} 
	               	</c:if>
	               	<c:if test="${newMateVO.listVO.area3 != null}">
	                	| ${newMateVO.listVO.area3}
	               	</c:if>
	               </span>
	               <ol class="list_icon">
	                  <li>
	                  	<p>
	                  		<c:if test="${newMateVO.gender==1}">여</c:if>
	                  		<c:if test="${newMateVO.gender==3}">남</c:if>
	                  	</p>
	                  </li>
	                  <li>
	                  	<p>
	                  		${newMateVO.birth}세
	                  	</p>
	                  </li>
	                  <li>
	                  	<p>
	                  		${newMateVO.enterdate}
	                  	</p>
	                  </li>
	               </ol>
	            </li>
	         </c:forEach>
	      </ul>
	  </c:if>
	  <c:if test="${newMateListCnt==0}">
	  	<div class="empty_div">
      		<img class="empty" src="<%=request.getContextPath()%>/img/empty.png" onerror="this.src='<%=request.getContextPath()%>/img/empty.png'"/>
      		<p style="text-align:center;">필터에 맞는 결과가 없습니다.</p>
     	</div>
	  </c:if>
   </section>
   
   <!-- 지도 -->
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6bad1d8e9a1449ac5fb2b238e99a32ed&libraries=clusterer,services"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <section class="content map_content">
      <div class="list_head">
      	 <c:if test="${logId==null && logArea==null}">
      	 	<p class="m_title">서울메이트 둘러보기</p>
      	 </c:if>
      	 
      	 <c:if test="${logId!=null && logArea!=null}">
      	 	<p class="m_title">나의 지역 둘러보기</p>
      	 </c:if>
      </div>
      <div class="main_map" id="map"></div>
   </section>
   <script>
      // =============== 지도생성  =============== //
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      mapOption = {
         center : new kakao.maps.LatLng(37.5640455, 126.834005), // 지도의 중심좌표
         //draggable: false,
         //level : 4
         level : 6
      // 지도의 확대 레벨 
      };
      var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
      
      // min값만큼 확대
      map.setMinLevel(4); // 100m
      // max값만큼 확대
      map.setMaxLevel(7); // 1km
	  <c:if test="${logId==null}">
      madeMap();
  	  </c:if>
      // =============== default 서울시 =============== //
      function madeMap() {
         
         var lat, lon, locPosition;
         lat = 37.5662994, // 위도
         lon = 126.9757564; // 경도 
         locPosition = new kakao.maps.LatLng(37.5662994, 126.9757564); // 서울특별시
         map.setCenter(locPosition);   
         map.setLevel(9);
         getHouseMap();
      }
      var oay = null;
      var selectedMarker = null;
      var coay = null;
      var cselectedMarker = null;
      // =============== 쉐어하우스 마커 찍기 =============== //
      function getHouseMap() {
	      <c:forEach items="${houseMapList}" var="hmVO">
	         // 주소-좌표 변환 객체를 생성합니다
	         var geocoder = new kakao.maps.services.Geocoder();
	         
	         // 주소로 좌표를 검색합니다
	         geocoder.addressSearch('${hmVO.addr}', function(result, status) {
	             // 정상적으로 검색이 완료됐으면 
	             console.log('${hmVO.addr}');
	              if (status === kakao.maps.services.Status.OK) {
	                 var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	                 
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
	                     position: coords,
                         clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트
	                 });
		           // 커스텀 오버레이에 표시할 컨텐츠 입니다
		           // 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
		           // 별도의 이벤트 메소드를 제공하지 않습니다 
		           var content = '<div class="map_wrap">' +  
		                       '    <div class="info">' + 
		                       '        <div class="title">' + 
		                       '            ${hmVO.housename}' + 
		                       '            <div class="close" onclick="closeOverlay(this)" title="닫기"></div>' + 
		                       '        </div>' + 
		                       '        <div class="body">' + 
		                       '            <div class="img">' +
		                       '                <img alt="" src="<%=request.getContextPath()%>/housePic/${hmVO.housepic1}" onerror="this.src=' + "'<%=request.getContextPath()%>/img/comm/no_house_pic.png'" + '" width="73" height="70">' +
		                       '           </div>' + 
		                       '            <div class="desc">' + 
		                       '                <div class="ellipsis">${hmVO.short_addr}</div>' + 
		                       '                <div class="jibun ellipsis">${hmVO.deposit} / ${hmVO.rent}</div>' + 
		                       '                <div><a href="houseView?no=${hmVO.no}" target="_blank" class="link">자세히보기</a></div>' + 
		                       '            </div>' + 
		                       '        </div>' + 
		                       '    </div>' +    
		                       '</div>';
	
		           // 마커 위에 커스텀오버레이를 표시합니다
		           // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
		           var overlay = new kakao.maps.CustomOverlay({
		               content: content,
	                   zIndex : 15,
		               position: marker.getPosition()       
		           });
		           
		           kakao.maps.event.addListener(marker, 'click', function() {
		        	   
		               // 클릭된 마커가 없고, click 마커가 클릭된 마커가 아니면
		               // 오버레이를 표시합니다.
					   if (cselectedMarker != null){
						   coay.setMap(null);
					   }
	                   // 클릭된 마커 객체가 null이 아니면
	                   // 이전에 표시된 오버레이를 표시하지 않습니다.
	                   if(oay != null){
	                	   oay.setMap(null);
	                   }
	                   
                       if(coay != null){
                     	   coay.setMap(null);
                       }
					   // 현재 오버레이를 표시합니다.
		        	   overlay.setMap(map);
					   // 현재 마커를 중심으로 맵을 이동합니다.
		        	   map.setCenter(marker.getPosition());   
					   // 이전 오버레이에 현재 오버레이를 대입합니다.
		        	   oay = overlay;
					   // 클릭된 마커를 변경합니다.
		        	   selectedMarker = marker;
		        	   cselectedMarker = null;
		           });
	             } 
	            });    
	      </c:forEach>
	      <c:if test="${logId==null}">
     	  	getMateAddr();
     	  </c:if>
      }
      
      // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
      function closeOverlay(a) {
    	  oay.setMap(null);
      }
      
      <c:if test="${logId!=null}">
     	var area = "${logArea}";
     	if(area!=null){
     		getNowMap(area);
     	}else{
     		madeMap();
     	}
     </c:if>
      function getNowMap(area) {
          var geocoder = new kakao.maps.services.Geocoder();
          geocoder.addressSearch(area, function(result, status) {
             if (status === kakao.maps.services.Status.OK) {
             	setHopeArea(result[0].x, result[0].y)
             }
          });
  	}
     
  	function setHopeArea(x, y) {
          var locPosition = new kakao.maps.LatLng(y, x);
          map.setCenter(locPosition);
          getMateAddr();
  	}
  	  // =============== 하우스메이트 희망지역 리스트 구하기 =============== //
      function getMateAddr() {
         var mateArrList = ${mateMapList};
         // 메이트 리스트 JSON
         var data = {"positions": []}
         
         //var xObject = {}; // 각 주소에 대한 x 좌표를 담을 객체
         //var yObject = {}; // 각 주소에 대한 x 좌표를 담을 객체
         var total = mateArrList.length;
         var counter = 0;
         var geocoder = new kakao.maps.services.Geocoder();

         mateArrList.forEach(function (item) {
           geocoder.addressSearch(item, function(result, status) {
              if (status === kakao.maps.services.Status.OK) {
                 data.positions.push({
                     "lat": result[0].y,
                     "lng": result[0].x
                 });
              }
             counter++; // 비동기 콜백이 수행되었으면 하나 업 카운트
			
             if (total === counter) { // 모든 비동기 콜백이 수행되었다면
            	 getMateMap(data); // 다음 로직으로 넘어갑니다.
             }
           });
         });
         
      }
      // =============== 하우스메이트 마커 찍기 =============== //
      function getMateMap(data) {
    	  console.log(data);
          var clusterer = new kakao.maps.MarkerClusterer({
              map: map, 
              averageCenter: true, 
              minLevel: 1,
              minClusterSize : 1,
              texts: getTexts, 
              disableClickZoom : true,
              styles: [{ 
                      width : '150px', height : '150px',
                      background: 'rgba(19, 168, 158, .3)',
                      borderRadius: '150px',
                      color: '#fff',
                      textAlign: 'center',
                      fontSize: '1.4rem',
                      fontWeight: 'bold',
                      lineHeight: '150px',
                      textShadow: '0px 0px 6px #0e7770',
                      zIndex : -11
                  }
              ]
          });
          var markers = data.positions.map(function(position) {
              return new kakao.maps.Marker({
                  position : new kakao.maps.LatLng(position.lat, position.lng)
              });
          });

          // 클러스터러에 마커들을 추가합니다
          clusterer.addMarkers(markers);
          clusterer.setMap(map);
          // 클러스터 내부에 삽입할 문자열 생성 함수입니다 
          function getTexts( count ) {
            return count + "명";       
          }
          
          // 마커 위에 커스텀오버레이를 표시합니다
          // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
        
          kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
       	   	  console.log('마커의 좌표 : ');
       	   	  console.log(cluster.getMarkers());
       	   	  //var b =  clusterer.getCenter();
       	   	  console.log('클러스터의 좌표 : ');
       	   	  console.log(cluster.getCenter());
       	   	  searchDetailAddrFromCoords(cluster.getCenter(), function(result, status) {
       	   		  	console.log(result);
       	            //var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
       	            var detailAddr = ' ' +  result[0].address.region_1depth_name + ' ' + result[0].address.region_2depth_name + ' ' + result[0].address.region_3depth_name + ' ';
       	            

 	                 var content = '<div class="map_wrap mate">' + 
                     '    <div class="info">' + 
                     '        <div class="title">' + detailAddr + 
                     '            <div class="close" onclick="closeCoverlay(this)" title="닫기"></div>' + 
                     '        </div>' + 
                     '        <div class="body">' + 
                     '            <div class="">' + 
                     '                <p>' + result[0].address.region_3depth_name + '에서 집을 구하고 있어요!</p>' + 
                     '                <div><a href="mateIndex?area=' + result[0].address.region_3depth_name + '" target="_blank" class="link">자세히보기</a></div>' + 
                     '            </div>' + 
                     '        </div>' + 
                     '    </div>' +    
                     '</div>';
                     
/*                      var content = '<div class="customoverlay">' +
                     '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
                     '    <span class="title">' + detailAddr + ' 메이트 보러가기 </span>' +
                     '  </a>' +
                     '</div>'; */
                     var overlay = new kakao.maps.CustomOverlay({
 	                      content: content,
 	                      zIndex : 15,
 	                      position: cluster.getCenter()       
 	                  });
                        // 클릭된 마커 객체가 null이 아니면
                        // 이전에 표시된 오버레이를 표시하지 않습니다.
					   if (selectedMarker != null){
						   oay.setMap(null);
						   selectedMarker == null;
					   }
                       if(coay != null){
                     	   coay.setMap(null);
                       }
      				   // 현재 오버레이를 표시합니다.
      	        	   overlay.setMap(map);
      				   // 현재 마커를 중심으로 맵을 이동합니다.
      	        	   map.setCenter(cluster.getCenter());   
      				   // 이전 오버레이에 현재 오버레이를 대입합니다.
      	        	   coay = overlay;
      				   // 클릭된 마커를 변경합니다.
      	        	   cselectedMarker = clusterer;
			  });
              //alert('클러스터 클릭');
          });
          function searchDetailAddrFromCoords(coords, callback) {
        	    // 좌표로 법정동 상세 주소 정보를 요청합니다
        	    // 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();
        	    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
       	  }
          
          <c:if test="${logId!=null}">
         	getHouseMap();
       	  </c:if>
      }
      // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
      function closeCoverlay(a) {
    	  coay.setMap(null);
      }
   </script>
   
</div>