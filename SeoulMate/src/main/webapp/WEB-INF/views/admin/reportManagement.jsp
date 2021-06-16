<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	//페이징
	function pageClick(state, grade, page, searchKey, searchWord){
		var f=document.go;
		f.state.value=state;
		f.grade.value=grade;
		f.pageNum.value=page; // post 방식을 넘길 값
		f.searchKey.value=searchKey; // post 방식을 넘길 값
		f.searchWord.value=searchWord; // post 방식을 넘길 값
		f.action="/home/admin/reportManagement"; // 이동할 페이지
		f.method="post"; // post 방식
		f.submit();
	}
	$(function(){
		var selected = "";
		//신고 상세보기
		$(".admin_ReportManagement_DetailInfo").on('click', function(){
			var deletedPost = $(this).children().eq(7).text();
			if(deletedPost=='삭제됨'){
				alert('해당글은 사용자에의해 삭제되어 조회가 불가능합니다.');
			}else{
				var params = 'num='+$(this).children().eq(0).text()+'&category='+$(this).children().eq(3).text()+'&no='+$(this).children().eq(4).text();
				var url = "/home/admin/reportDetailInfo"
				selected = $(this);
				
				$.ajax({
					url : url,
					data : params,
					success : function(result){
						console.log(result)
						reportFormFill(result);
					},error : function(){
						alert("신고 데이터 에러")
					}
				});
			}
		});
		//신고 상세보기 값 넣기
		function reportFormFill(result){
// 			var no = parseInt(result.no);
			
			$("#numR").val(result.num);
			$('#useridR').val(result.userid);
			$('#reportidR').val(result.reportid);
			$('#categoryR').val(result.category);
			$('#noR').val(result.no);
			$('#reportdateR').val(result.reportdate);
			$('#reportcategoryR').val(result.reportcategory);
			$('#reportcontentR').val(result.reportcontent);
			
			//게시글 공개 상태
			if(result.vState=='비공개'){
				$('#toggle_1').prop('checked',true);
			}else{
				$('#toggle_1').prop('checked',false);
			}
			//블랙리스트 상태
			if(result.bState=='블랙'){
				$('#toggle_2').prop('checked',true);
			}else{
				$('#toggle_2').prop('checked',false);
			}
			//탈퇴 상태
			if(result.bState=='탈퇴'){
				$('#toggle_1').prop('disabled',true);
				$('#toggle_2').prop('disabled',true);
			}
			
			$("input:radio[name ='state']:input[value='"+result.state+"']").attr("checked", true);

			//신고 글 링크 걸기
			if(result.category=='하우스'){
				$('#reportLink').attr('href', '/home/houseView?no='+result.no+'&admin=true')
			}else if(result.category=='메이트'){
				$('#reportLink').attr('href', '/home/mateView?no='+result.no+'&admin=true')
			}else if(result.category=='커뮤니티'){
				$('#reportLink').attr('href', '/home/communityView?no='+result.no+'&admin=true')
			}else if(result.category=='댓글'){
				//댓글의 원글번호가 필요하다
				$.ajax({
					url : '/home/replyOriNum',
					data : 'no='+result.no,
					success : function(replyOriNum){
						$('#reportLink').attr('href', '/home/communityView?no='+replyOriNum+'&reply='+result.no+'&admin=true');
					}, error :function(){
						console.log('댓글 원번호 가져오기 에러')
					}
				});
			}else if(result.category=='채팅'){
				$('#reportLink').attr('href', 'http://192.168.0.118:9091/chatView?no='+result.no+'&userid='+result.reportid+'&otherid='+result.userid+'&userpic='+result.profilepic1+'&otherpic='+result.profilepic2+'&admin=true');
				$('#toggle_1').prop('checked',true);
				$('#showOrNOt').css('display','none');
				$('.pup_body').css('height','510px');
			}

			//팝업 열기
			$(".report_popup").css('display','block');
			$(document.body).css('overflow','hidden');
		}
		
		//신고처리하기
		$('#reportAdmin').submit(function(){
			
			var num = $('#noR').val();
			$.ajax({
				url : '/home/admin/reportAdmin',
				data : $(this).serialize(),
				success : function(result){
					if(result=='failed'){
						alert('신고 처리에 실패했습니다.');
					}else{//신고처리 성공
						alert('신고가 처리되었습니다.');
						//게시글 공개 여부
						var state = $('input[name=visibility]').is(':checked');
						//블랙리스트 등록 여부
						var blacklist = $('input[name=blacklist]').is(':checked');
						//처리 상태
						var reportState = $('input[name=state]:checked').val();
						updateReportTable(state, blacklist, reportState);
					}
					
					$('.report_popup').css('display','none'); //창닫기
				},error : function(){
					console.log('신고 실패')
					alert('신고 처리에 실패했습니다.ajax');
				}
			})
			return false;
		});
		
		//신고처리하고 신고테이블 바뀐 정보로 보여주기 함수
		function updateReportTable(state, blacklist, reportState){
			//블랙리스트 상태 수정
			if(blacklist){
				$(selected).children().eq(5).text('블랙');
			}else{
				$(selected).children().eq(5).text('일반')
			}
			//상태 수정
			$(selected).children().eq(7).text(reportState);
			$(selected).children().eq(7).css('color','black');
		}
		
		//필터 기능 
		$('select[name=grade]').change(function(){
			$('.managementSearchForm').submit();
		});
		$('select[name=state]').change(function(){
			$('.managementSearchForm').submit();
		});
		//검색창 리셋
		$("#searchWord").click(function(){
			$("#searchWord").val("");
		});
		
		//검색어 자동완성============================================================================================================
// 		jQuery.curCSS = function(element, prop, val) {//jquery a.Cur샬라샬라에러떠서
// 		    return jQuery(element).css(prop, val);
// 		};
// 		$('input[name=searchWord]').autocomplete({
// 			source : function(req, res){
// 				$.ajax({
// 					type: 'get',
// 					url : '/home/admin/json',
// 					dataType: 'json',
// 					data : "keyword="+$("input[name=searchWord]").val(),
// 					success: function(data){
// 						res(
// 							$.map(data, function(item){
// 								return {
// 									label : item, //뷰단에서 보여지는 글자
// 									value : item, //사용자 설정값.
// 									test : item+'test'
// 								}//return end
// 							})//map end	
// 						)//res end
// 					}
// 				});// ajax end
// 			},//source end source는 자동 완성 대상
// 			select : function(event, ui){
// 				console.log(ui)
// 				console.log(ui.item.label);
// 				console.log(ui.item.value);
// 				console.log(ui.item.test);
// 			},
// 			focus : function(event, ui){
// 				return false;
// 			},
// 			minLength : 1,//최소 글자수
// 			autoFocus: true,
// 			classes : {
// 				'ui-autocomplete' : 'highlight'	
// 			},
// 			delay : 500,
// 			position : {my : 'right top', at : 'right bottom'},
// 			close : function(event){
// 				console.log(event);
// 			}
// 		}).autocomplete("instance")._renderItem = function(ul, item){//input에 자동완성 걸어주기
// 			return $('<li>')
// 			.attr('data-value', item.value)
// 			.append(item.label)
// 			.appendTo(ul);
// 		}
		//============================================================================================================
	});
</script>
<section class="admin_Section">
	<div class="admin_Content">
		<div class="m_title managementTitle">신고 관리</div>
		<form method="post" action="/home/admin/reportManagement" class="managementSearchForm">
			<div class="reportSearchCategory">
				<span class="reportSpan" id="categorySpan">분류</span>
				<select name=grade class="custom-select input">
					<option value="" selected>전체</option>
					<option value="하우스" <c:if test="${pVO.grade=='하우스'}">selected</c:if>>하우스 신고 목록</option>
					<option value="메이트" <c:if test="${pVO.grade=='메이트'}">selected</c:if>>메이트 신고 목록</option>
					<option value="커뮤니티" <c:if test="${pVO.grade=='커뮤니티'}">selected</c:if>>커뮤니티 신고 목록</option>
					<option value="댓글"<c:if test="${pVO.grade=='댓글'}">selected</c:if>>댓글 신고 목록</option>
				</select>
				<span class="reportSpan" id="stateSpan"> 상태</span>
				<select name="state" class="custom-select">
					<option value="" selected>전체</option>
					<option value="미처리" <c:if test="${pVO.state=='미처리'}">selected</c:if>>미처리</option>
					<option value="처리완료" <c:if test="${pVO.state=='처리완료'}">selected</c:if>>처리완료</option>
					<option value="허위신고" <c:if test="${pVO.state=='허위신고'}">selected</c:if>>허위신고</option>
					<option value="삭제됨" <c:if test="${pVO.state=='삭제됨'}">selected</c:if>>삭제됨</option>
				</select>
			</div>	
			<div class="reportSearch">
				<select name="searchKey" class="custom-select reportSearchKey">
					<option value="userid"<c:if test="${pVO.searchKey=='userid'}">selected</c:if>>아이디</option>
					<option value="reportid"<c:if test="${pVO.searchKey=='reportid'}">selected</c:if>>신고자</option>
				</select>
				<input type="text" id="searchWord" name="searchWord" class="form-control" <c:if test="${pVO.searchWord!=null}">value="${pVO.searchWord}"</c:if>/>
				<input type="submit" value="Search" class="btn btn-custom"/>
			</div>
		</form>
		<div class="table-responsive, managementList">
			<table class="table table-hover table-sm table-bordered">
				<thead class="thead-light">
					<tr>
						<th>No.</th>
						<th>회원 ID</th>
						<th>신고자 ID</th>
						<th>신고분류</th>
						<th>신고글번호</th>
<!-- 						<th>게시글 공개</th>게시글 공개여부랑 블랙리스트 상태는 ajax로 페이지 실행될때 가져와야할거같은데 왜냐면 신고목록 select 할때 글번호, 어디 게시판인지도 모르잖아 -->
						<th>블랙리스트</th>
						<th>신고일</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="report" items="${report}">
						<tr class="admin_ReportManagement_DetailInfo">
							<td>${report.num}</td>
							<td>${report.userid}</td>
							<td>${report.reportid}</td>
							<td>${report.category}</td>
							<td>${report.no}</td>
<%-- 							<td>${report.vState}</td> --%>
							<td>${report.bState}</td>
							<td>${report.reportdate}</td>
							
							<c:if test="${report.state=='미처리'}">
								<td style="color:#007bff;">${report.state}</td>
							</c:if>
							<c:if test="${report.state!='미처리'}">
								<td>${report.state}</td>
							</c:if>
						</tr>
					</c:forEach>	
				</tbody>
			</table>
			<div class="paging">
				<form name="go"> <!-- 자바스크립트로 submit 시키려면 form을 추가하고 name을 지정해야 한다. -->
					<input type="hidden" name="state" value="${state}"/>
					<input type="hidden" name="grade" value="${grade}"/>
					<input type="hidden" name="pageNum"/> <!-- 폼에 post로 값을 보내주기 위해 hidden -->
					<input type="hidden" name="searchKey"/> <!-- 폼에 post로 값을 보내주기 위해 hidden -->
					<input type="hidden" name="searchWord"/> <!-- 폼에 post로 값을 보내주기 위해 hidden -->
					<c:if test="${pVO.pageNum>1}">
					<c:if test="${pVO.searchWord==null}">
						<a class="first_page" href="reportManagement?pageNum=1"></a>
						<a class="prev_page" href="reportManagement?pageNum=${pVO.pageNum-1}"></a>
					</c:if>
					
					<c:if test="${pVO.searchWord!=null}">
						<a href="javascript:pageClick('${state}', '${grade}', 1, '${pVO.searchKey}', '${pVO.searchWord}')" class="first_page"></a>
						<a href="javascript:pageClick('${state}', '${grade}', ${pVO.pageNum-1}, '${pVO.searchKey}', '${pVO.searchWord}')" class="prev_page"></a>
					</c:if>
					</c:if>
					<c:if test="${pVO.pageNum==1}">
						<a class="first_page"></a>
						<a class="prev_page"></a>
					</c:if>
					<c:forEach var="pageNum" begin="${pVO.startPageNum}" end="${pVO.startPageNum + pVO.onePageNum-1}">
						<c:if test="${pageNum<=pVO.totalPage }">
						<c:if test="${pVO.searchWord==null}">
							<c:if test="${pageNum==pVO.pageNum }"><!-- 1 -->
								<a href="reportManagement?pageNum=${pVO.pageNum}" class="nowPageNum on">${pageNum}</a>
							</c:if>
							<c:if test="${pageNum!=pVO.pageNum}">
								<a href="reportManagement?pageNum=${pageNum}">${pageNum}</a>
							</c:if>
						</c:if>
						<c:if test="${pVO.searchWord!=null}"><!-- 2 -->
							<c:if test="${pageNum==pVO.pageNum }">
								<a href="javascript:pageClick('${state}', '${grade}', ${pageNum}, '${pVO.searchKey}', '${pVO.searchWord}')" class="nowPageNum on">${pageNum}</a>
							</c:if>
							<c:if test="${pageNum!=pVO.pageNum }">
								<a href="javascript:pageClick('${state}', '${grade}', ${pageNum}, '${pVO.searchKey}', '${pVO.searchWord}')">${pageNum}</a>
							</c:if>
						</c:if>
						</c:if>
					</c:forEach>
					<c:if test="${pVO.pageNum < pVO.totalPage}">
						<c:if test="${pVO.searchWord==null}"> <!-- 검색어가 없는 경우 -->
							<a class="next_page" href="reportManagement?pageNum=${pVO.pageNum+1}"></a>
							<a class="last_page" href="reportManagement?pageNum=${pVO.totalPage}"></a>
						</c:if>
						<c:if test="${pVO.searchWord!=null}"> <!-- 검색어가 있는 경우 -->
							<a class="next_page" href="javascript:pageClick('${state}', '${grade}', ${pVO.pageNum+1}, '${pVO.searchKey}', '${pVO.searchWord}')" class="next_page"></a>
							<a class="last_page" href="javascript:pageClick('${state}', '${grade}', ${pVO.totalPage}, '${pVO.searchKey}', '${pVO.searchWord}')" class="last_page"></a>
						</c:if>
					</c:if>
					<c:if test="${pVO.totalPage==0}">
						<a class="nowPageNum on">1</a>
					</c:if>
					<c:if test="${pVO.pageNum == pVO.totalPage || pVO.totalPage == 0}">
						<a class="next_page"></a>
						<a class="last_page"></a>
					</c:if>
				</form>
			</div>
		</div>
	</div>
</section>
<!--  팝업창///////////////////////////////////////////// -->
<div class="pup_wrap report_popup">
		<div class="pup_form">
			<div class="pup_head">신고 처리</div>
			<div class="pup_body">
				<div class="pup_list">
					<form id="reportAdmin" method="post">	
						<input id="numR" type="hidden" name="num">
						<input id="enddate" type="hidden" name="enddate">
						<ul>
							<li><div>회원ID</div><input id="useridR" type="text" name="userid" readonly></li>
							<li><div>신고자ID</div> <input id="reportidR" type="text" name="reportid" readonly> </li>
							<li><div>분류</div> <input id="categoryR" type="text" name="category" readonly> </li>
							<li><div>글번호</div> <input id="noR" type="text" name="no" readonly> </li>
							<li><div>신고일</div> <input id="reportdateR" type="text" name="reportdate" readonly> </li>
							<li><div>신고 사유</div> <input id="reportcategoryR" type="text" name="reportcategory" readonly> </li>
							<li>
								<div>
									신고상세내용<br>
									<a id="reportLink" target="blank">신고글보기</a>
								</div> 
								<textarea id="reportcontentR" rows="5" name="reportcontent" readonly></textarea> 
							</li>
							<li id="showOrNOt"><div>*게시글 공개</div>
								<div class="toggle_cont">
								<input id="toggle_1" class="cmn_toggle cmn_toggle_round" type="checkbox" name="visibility">
								<label for="toggle_1"></label>
								</div><br>
							</li>
							<li><div>*블랙리스트</div>
								<div class="toggle_cont">
								<input id="toggle_2" class="cmn_toggle cmn_toggle_round" type="checkbox" name="blacklist">
								<label for="toggle_2"></label>
								<input id="originalState" type="hidden">
								</div><br>
							</li>
							<li><div>*처리 상태</div>
								<div id="radioDiv" class="reportState">
									<input type="radio" name="state" value="미처리">미처리
									<input type="radio" name="state" value="처리완료">처리완료
									<input type="radio" name="state" value="허위신고">허위신고
								</div>
							</li>
						</ul>
					</form>	
				</div>
			</div>
			<div class="pup_bottom">
				<a href="" class="btn_cancel">닫기</a>
				<a href="javascript:$('#reportAdmin').submit()" class="btn_save">처리</a>
<!-- 				<a href="" class="btn_del">삭제</a> -->
			</div>
			<a href="" class="pup_btn_close">닫기</a>
		</div>
	</div>
</body>
</html>