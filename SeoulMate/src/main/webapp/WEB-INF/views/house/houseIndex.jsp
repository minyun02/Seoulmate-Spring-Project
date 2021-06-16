<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src = "<%=request.getContextPath()%>/js/like.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/doo.css">

<script>
	$(function(){
		//=============================================================세트
	   if(${logId != null}){ // 로그인 했을때만 실행
			//내가 찜한 글은 별버튼에 불 들어오기 & 내가 올린 글은 별 버튼 숨기기
		   $.ajax({
			   url : '/home/likemarkCheck',
			   data : {'userid': '${logId}'},
			   traditional : true,
			   success : function(result){
				   console.log(result)
				   likeButtonOn(result); // 찜한거 불 넣기 & 자기글 버튼 안보이게 하기
			   },error : function(){
				   alert('찜 목록 불러오기 실패')
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
		$("#searchBox").click(function(){ // 해줘야하나 아직 모르겠음 뒤로가기했을 때 값이 그대로있는지 모름
			$("#searchBox").val("");
		});
	});
	function search(){
		var addr='${pVO.addr}';
		var rent=${pVO.rent};
		var deposit=${pVO.deposit};
		var m_gen=${pVO.m_gen};
		
		if(addr==$("#searchBox").val() && (rent==$("#searchRent").val() || $("#searchRent")==null) && (deposit==$("#searchDeposit").val() || $("#searchDeposit").val()==null) && (m_gen==$('input[name="m_gen"]:checked').val() || $('input[name="m_gen"]:checked').val()==null)){
			
		}else{
			$("#hiddenPageNum").val("1");
		}
	}
	//페이징
	function pageClick(msg){
		var addr='${pVO.addr}';
		var rent=${pVO.rent};
		var deposit=${pVO.deposit};
		var m_gen=${pVO.m_gen};
		
		var pageNum = '<c:out value="${pVO.pageNum }"/>';  //현재 눌려있는 페이지
		var startPageNum = '<c:out value="${pVO.startPageNum }"/>'; // 페이징 시작 페이지
		var totalPage = '<c:out value="${pVO.totalPage }"/>'; //마지막 페이징
		var changePageNum = 0;
		if(msg=='next_page'){
			changePageNum = Number(pageNum)+1;
		}else if(msg=='last_page'){
			changePageNum = Number(totalPage);
		}else if(msg=='first_page'){
			changePageNum = 1;
		}else if(msg=='prev_page'){
			changePageNum = Number(pageNum)-1;
		}else{
			changePageNum = Number(msg);
		}
		
		// 페이징을 할 때 바뀐 검색값을 들고가는 것을 방지
		if(addr!=$('#searchBox').val() || rent!=$('#searchRent').val() || deposit!=$('#searchDeposit').val() || m_gen!=$('input[name="m_gen"]:checked').val()){
			console.log(addr);
			console.log($('#searchBox').val());
			console.log(rent);
			console.log($('#searchRent').val());
			console.log(deposit);
			console.log($('#searchDeposit').val());
			
			$('#searchBox').val(addr);
			$('#searchRent').val(rent);
			$('#searchDeposit').val(deposit);
			$('input:radio[name=m_gen]:input[value='+m_gen+']').prop("checked", true);
		}
		
		// 히든에 값넣고
		$('#hiddenPageNum').val(changePageNum);
		// 서브밋 실행 
		$('#houseIndexForm').submit();
		
	}
	
	$(function(){
		console.log("${bCnt}");
		$("#roomWrite").click(function(){
// 			if(pCnt=='Y'){
// 				alert("글 작성개수를 초과하였습니다.");
// 				return false;
// 			}
// 			if(bCnt=='Y'){
// 				alert("글 작성개수를 초과하였습니다.");
// 				return false;
// 			}
// 			else{
// 				return true;
// 			}
			location.href="<%=request.getContextPath()%>/houseWrite";
		});
});
</script>
<div class="wrap houseSearch_wrap">
	<div class="boxClass"> <!-- 상단부분 div -->
		<p class="d_title">조건검색</p>
		<form method="get" action="houseIndex" id="houseIndexForm" onsubmit="return search();">
			<input type="hidden" name="pageNum" id="hiddenPageNum" value="${pVO.pageNum}"/>
			<ul class="searchClass">
				<li>
					<p>지역</p>
					<input type="text" name="addr" id="searchBox" value="${pVO.addr}" placeholder="지역명을 입력하세요"/> 
					<label><button id="iconPic1"></button></label> 
				</li> 
				<li>
					<p>최대 월세</p>
					<input type="number" id="searchRent" name="rent" value="<c:if test='${pVO.rent!=0}'>${pVO.rent}</c:if>" min="0" placeholder="0"/>
					<label>만원</label> 
				</li>
				<li>
					<p>최대 보증금</p>
					<input type="number" id="searchDeposit" name="deposit" value="<c:if test='${pVO.deposit!=0}'>${pVO.deposit}</c:if>" min="0" placeholder="0"/>
					<label>만원</label> 
				</li>
				<li>
					<p>성별</p>
					<div class="checks">
						<input type="radio" id="radio1" name="m_gen" value="0" <c:if test='${pVO.m_gen==0}'>checked</c:if>/> 
						<label for="radio1">전체</label> 
						<input type="radio" id="radio2" name="m_gen" value="1" <c:if test='${pVO.m_gen==1}'>checked</c:if>/> 
						<label for="radio2">여성</label> 
						<input type="radio" id="radio3" name="m_gen" value="3" <c:if test='${pVO.m_gen==3}'>checked</c:if>/> 
						<label for="radio3">남성</label> 
						<input type="radio" id="radio4" name="m_gen" value="2" <c:if test='${pVO.m_gen==2}'>checked</c:if>/> 
						<label for="radio4">상관없음</label> 
					</div>
				</li>
				<li><button class="green search"></button></li>
			</ul>
		</form>
		<button class="green room" id="roomWrite">방 등록하기</button><br/>
	</div>
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
								<a href="houseView?no=${phList.no}
									<c:if test='${pVO.pageNum!=null}'>&pageNum=${pVO.pageNum}</c:if>
									<c:if test='${pVO.addr!=null}'>&addr=${pVO.addr}</c:if>
									<c:if test='${pVO.rent!=null}'>&rent=${pVO.rent}</c:if>
									<c:if test='${pVO.deposit!=null}'>&deposit=${pVO.deposit}</c:if>
									<c:if test='${pVO.m_gen!=null}'>&m_gen=${pVO.m_gen}</c:if>
								">
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
					<a href="houseView?no=${newHouseVO.no}
						<c:if test='${pVO.pageNum!=null && pVO.pageNum!=1}'>&pageNum=${pVO.pageNum}</c:if>
						<c:if test='${pVO.addr!=null && pVO.addr!=""}'>&addr=${pVO.addr}</c:if>
						<c:if test='${pVO.rent!=null && pVO.rent!=0}'>&rent=${pVO.rent}</c:if>
						<c:if test='${pVO.deposit!=null && pVO.deposit!=0}'>&deposit=${pVO.deposit}</c:if>
						<c:if test='${pVO.m_gen!=null && pVO.m_gen!=0}'>&m_gen=${pVO.m_gen}</c:if>
					">
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
	<div class="paging">
		<c:if test="${pVO.pageNum>1  && pVO.totalPage>0}">
			<a href="javascript:pageClick('first_page')" class="first_page"></a>
			<a href="javascript:pageClick('prev_page')"  class="prev_page"></a>
		</c:if>
		<c:if test="${pVO.pageNum==1 && pVO.totalPage>0}">
			<a href="#" class="first_page"></a>
			<a href="#" class="prev_page"></a>
		</c:if>
		<c:forEach var="pageNum" begin="${pVO.startPageNum}" end="${pVO.startPageNum + pVO.onePageNum-1}">
			<c:if test="${pageNum<=pVO.totalPage }">
				<c:if test="${pageNum==pVO.pageNum }">
					<a href="javascript:pageClick('${pageNum}')" class="on">${pageNum }</a>
				</c:if>
				<c:if test="${pageNum!=pVO.pageNum}">
					<a href="javascript:pageClick('${pageNum}')">${pageNum}</a>
				</c:if>
			</c:if>
		</c:forEach>
		<c:if test="${pVO.pageNum < pVO.totalPage}">
			<a href="javascript:pageClick('next_page')" class="next_page"></a>
			<a href="javascript:pageClick('last_page')" class="last_page"></a>
		</c:if>
		<c:if test="${pVO.pageNum == pVO.totalPage}">
			<a href="#" class="next_page"></a>
			<a href="#" class="last_page"></a>
		</c:if>
	</div>
</section>
</div>