<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/yun.css">
<script>
	$(function(){
		//카테고리 클릭시 class on 바꾸기
		var category = '${category}';
		//카테고리가 null이면 '전체'에 불들어오기
		if(category==''){
			$(".content_menu a").first().addClass('on');
		}else{
			$(".content_menu li a").removeClass("on");
			if(category=='우리집 자랑'){
				$(".content_menu>li>a").eq(1).addClass('on');
			}else if(category=='중고장터'){
				$(".content_menu>li>a").eq(2).addClass('on');
			}else if(category=='쉐어TIP'){
				$(".content_menu>li>a").eq(3).addClass('on');
			}else if(category=='자유게시판'){
				$(".content_menu>li>a").eq(4).addClass('on');
			}
		}
		if($(".content_menu a").first().hasClass('on')){ //전체에서 글을 볼때는 카테고리를 들고다니지 않아야해서 필요한 조건문....
			var recordNum = $('.commSubject').length; //게시판에 몇개의 글이 나오는지 
			var url = $('.commSubject').attr('href'); // url을 담아준
			var indexofQ = url.indexOf('?'); // url에서 ?의 위치를 구한다.
			var indexofAnd = url.indexOf('&'); // 첫번째 & 위치를 구해서 category=...의 길이를 구한다
			var list= new Array();
			for(var i=0; i<recordNum; i++){
				list.push($('.commSubject').eq(i).attr('href'));
// 				console.log(list[i]+"/"+i+"=====")
				var cateRemove1 = list[i].substring(0,indexofQ+1) //communityView? 까지를 담아준다.
				var cateRemove2 = list[i].substring(indexofAnd)
				var cateRemove3 = cateRemove1+cateRemove2;
// 				console.log(cateRemove3+"///"+i)
				$('.commSubject').eq(i).attr('href', cateRemove3);
			}
		}
		//검색어 유효성 검사
		$(".searchBtn").click(function(){
			if($("#comSearch").val()==''){
				alert("검색어를 입력해주세요.")
				return false;
			}else{
				$("#searchFrm").submit();
// 						function(){
// 					alert($("select[name=searchKey]").val())
// 					alert($("input[name=searchWord]").val())
// 				});
			}
		});
	});
</script>
<div class="wrap">
	<div class="content">
		<p class="m_title">커뮤니티</p>
		<ul class="content_menu">
			<li><a href="communityList" class="">전체</a></li>
			<li><a href="communityList?category=우리집 자랑" class="">우리집 자랑</a></li>
			<li><a href="communityList?category=중고장터" class="">중고장터</a></li>
			<li><a href="communityList?category=쉐어TIP" class="">쉐어TIP</a></li>
			<li><a href="communityList?category=자유게시판" class="">자유게시판</a></li>
		</ul>
			<ul class="searchUl">
					<li id="comSearchLi">
						<form id="searchFrm" method="post" action="communityList">
							<input type="hidden" id="category" name="category" value="${category}">
							<select id="searchKey" name="searchKey">
								<option value="subject">제목</option>
								<option value="content">글내용</option>
								<option value="userid">사용자</option>
							</select>
							<input name="searchWord" id="comSearch" type="text" placeholder="검색어을 입력해주세요" autocomplete="off">
							<button class="searchBtn" href="">
								<img alt="검색하기" src="<%=request.getContextPath()%>/img/yun/ico_search_black.png">
							</button>
						</form>	
					</li>
					
					<!-- <li id="searchKeySelect">
						<form id="searchFrm" method="post" action="communityList">
							<input type="hidden" name="category" value="${category}">
							<select id="searchKey" name="searchKey">
								<option value="subject">제목</option>
								<option value="content">글내용</option>
								<option value="userid">사용자</option>
						</select>
						</form>	
					</li>	
					<li id="comSearchLi">
						<input name="searchWord" id="comSearch" type="text" placeholder="검색어을 입력해주세요">
						<a class="searchBtn" href="">
							<img alt="검색하기" src="</img/yun/ico_search_black.png">
						</a>
						검색버튼 == <button class="searchBtn">검색</button>                                                   
					</li> -->
				<c:if test="${logId!=null}">
					<li><a href="communityWrite" class="green" id="communityWrite">글쓰기</a></li>
				</c:if>
			</ul>
		<table class="tb">
			<caption>테이블명</caption>
			<colgroup>
				<col width="80"/>
				<col width="120"/>
				<col />
				<col width="100"/>
				<col width="80"/>
				<col width="120"/>
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>카테고리</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody id="test">
				<c:forEach var="vo" items="${list}">
					<tr>
						<td>${vo.no}</td>
						<td>${vo.category}</td>
						<td class="t_title">
							<input type="hidden" value="${vo}">
							<a class="commSubject" href="communityView?category=${vo.category}&no=${vo.no}<c:if test="${pageVO.searchKey != null && pageVO.searchWord != null}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>">${vo.subject} </a>
							<c:if test="${vo.replyCnt>0}">
								<span class="commentNum" style="color: #13a89e">&nbsp;[ ${vo.replyCnt} ]</span>
							</c:if>	
						</td>
						<td>${vo.userid}</td>
						<td>${vo.hit}</td>
						<td>${vo.writedate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="paging pagingTextAlign">
			<c:if test="${pageVO.totalPage>1}">
				<a class="first_page" href="communityList?pageNum=1<c:if test="${pageVO.category != null && pageVO.category != '' }">&category=${pageVO.category}</c:if><c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>"></a>
				<c:if test="${pageVO.pageNum != 1 }">
					<a class="prev_page" href="communityList?pageNum=${pageVO.pageNum-1}<c:if test="${pageVO.category != null && pageVO.category != '' }">&category=${pageVO.category}</c:if><c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>"></a>
				</c:if>
			</c:if>

			<c:forEach var="p" begin="${pageVO.startPageNum}" end="${pageVO.startPageNum+pageVO.onePageNum-1}">
				<c:if test="${p<=pageVO.totalPage}">
					<c:if test="${p==pageVO.pageNum}">
						<a class="on" href="communityList?pageNum=${p}<c:if test="${pageVO.category != null && pageVO.category != '' }">&category=${pageVO.category}</c:if><c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>">${p}</a>
					</c:if>
					<c:if test="${p!=pageVO.pageNum}">
						<a href="communityList?pageNum=${p}<c:if test="${pageVO.category != null && pageVO.category != '' }">&category=${pageVO.category}</c:if><c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>">${p}</a>
					</c:if>
				</c:if>
			</c:forEach>
				
			<c:if test="${pageVO.totalPage>1}">
				<c:if test="${pageVO.totalPage!=pageVO.pageNum}">
					<a class="next_page" href="communityList?pageNum=${pageVO.pageNum+1}<c:if test="${pageVO.category != null && pageVO.category != '' }">&category=${pageVO.category}</c:if><c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>"></a>
				</c:if>
				<a class="last_page" href="communityList?pageNum=${pageVO.totalPage}<c:if test="${pageVO.category != null && pageVO.category != '' }">&category=${pageVO.category}</c:if><c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>"></a>
			</c:if>	
		</div>
	</div>
</div>