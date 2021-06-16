<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/yun.css">
<script>
	//글삭제
	function communityDel(){
		if(confirm('해당 글을 삭제하나요?')){
			location.href="communityDel?no=${vo.no}";
		}
	}
	
	//댓글===============================================
	//1. 댓글 목록 불러오기
	function replyList(){
		var url = "/home/replyList";
		var params = "no=${vo.no}";
		
		$.ajax({
			url : url,
			data : params,
			success : function(result){
				var $result = $(result);
				var tag = "";
				$result.each(function(idx, obj){
						//댓글 사진 div
						tag += "<li><div class='communityView_user_porfile'>";
							tag += '<img src="/home/profilePic/'+obj.profilePic+'"';
							tag += 'onerror="this.src=\'<%=request.getContextPath()%>/profilePic/basic.jpg\'"/>';
						tag += '</div>'
						
						//아이디랑 등록시간 div
						tag += '<div class="communityView_comment_user_detail">';
							tag += obj.userid+'<br>';
						tag += obj.writedate + '</div>';
						
						//수정취소, 수정, 답글, 신고 버튼 div
						tag += '<div class="communityView_comment_btn">';
						//로그인 아이디랑 댓글 작성자 아이디랑 같으면
						if(obj.userid == '${logId}'){
							tag += '<button class="white" style="display:none">수정취소</button>'
							tag += '<button class="white">수정</button>'
							tag += '<button class="white" href="">삭제</button>'
							tag += '<button id="'+idx+'" class="white">답글</button>'
							tag += '<input type="hidden" value="'+obj.userid+'">'
							tag += '<input type="hidden" value="'+obj.num+'">'
							tag += '<button class="report white" style="display:none">신고</button></div>'
						}else if(obj.userid != '$logId' && ${logId != null}){
							//로그인 아이디랑 댓글 작성자 아이디랑 안같으면 => 버튼의 순번으로 클릭 이벤트를 처리하기 때문에 visibility로 처리함
							tag += '<button class="white" style="display:none">수정취소</button>'
							tag += '<button class="white" style="visibility:hidden">수정</button>'
							tag += '<button class="white" style="visibility:hidden" href="">삭제</button>'
							tag += '<button id="'+idx+'" class="white">답글</button>'
							tag += '<input type="hidden" value="'+obj.userid+'">'
							tag += '<input type="hidden" value="'+obj.num+'">'
							if(obj.state=='공개'){
								tag += '<button class="replyReport white">신고</button></div>'	
							}else{
								tag += '<button class="report white" style="display:none">신고</button></div>'				
							}
						}else{
							//로그인 안했으면 . 공간 메꾸기 용 버튼
							tag += '<button class="white" style="visibility:hidden">수정취소</button>'
						}						
						
						
						//댓글 공개 상태 체크 
						if(obj.state=='공개'){
							tag += '<li id="'+obj.num+'" class="communityView_comment_content">'
							tag += obj.content
							tag += '</li>';
						}else{
							tag += '<li id="'+obj.num+'" class="communityView_comment_content">'
							tag += '해당 댓글은 숨김 처리되었습니다.'
							tag += '</li>';
						}
						
						//댓글 수정폼
						if(obj.userid=="${logId}"){
							tag += '<form class="replyEditForm"><div style="display:none">'
							tag += '<input type="hidden" name="num" value="'+obj.num+'">'; //댓글 번호
							tag += '<input type="hidden" name="no" value="${vo.no}">'; // 원글 번호
							tag += '<input type="hidden" name="userid" value="'+obj.userid+'">';
							tag += "<li class='communityView_comment_content_edit' style='background-color:#eee;'><textarea name='content' style='width: 100%; height:100px; border-radius: 20px; background-color:#fff;'>"+obj.content+"</textarea>"
							tag += "<button class='green'>완료</button></li></div>";
							tag += '</form></li>'
						}
				});
				$("#replyList").html(tag);
				
				//신고관리 접근일때 댓글 아이디값으로 바로가기.
				if(${reply} != '0'){
					moveToReply(${reply});
				}
				
			},error : function(){
				console.log("댓글 목록 실패...");
			}
		});//ajax end
	}//1.end
	
	function moveToReply(num){
		document.getElementById(num).scrollIntoView();
		document.getElementById(num).style.backgroundColor = '#d0d9e8';
		
		//var replyNum = '#'+${reply};
        //var offset = $('#commen.offset();
        //$('html').animate({scrollTop : offset.top}, 400);
	}
	
	$(function(){
		
		//댓글 목록 출력 함수
		replyList();
		
		//댓글이 등록 삭제 되었을때 페이지에 댓글 수 변화시키는 함수
		function replyCntChange(plusOrMinus){
			if(plusOrMinus=='plus'){//댓글 추가됨
				$('.replyCnt').text(${replyCnt+1});
			}else if(plusOrMinus=='minus'){//댓글 삭제됨
				$('.replyCnt').text(${replyCnt-1});
			}
		}
		
		//2. 댓글 쓰기
		$("#replyBtn").click(function(){
			if($("#comment_content").val()!=''){
				var url = "/home/replyWriteOk";
				var params = $("#commentForm").serialize();
				
				$.ajax({
					url : url,
					data : params,
					success : function(result){
						replyList();
						replyCntChange('plus');
						console.log("댓글등록 성공!!");
					},error : function(){
						console.log("댓글 등록 실패...");
					}
				});//ajax end
				$("#comment_content").val(" ");
				$("#replyBtn").text('댓글 등록');
				$("#taggedNum").val(' ');
				return false;
			}else{
				alert("댓글내용을 입력해야 등록이 가능합니다.");
				return false;
			}
		});//2.end
		
		//3.댓글 수정하기
		$(document).on('click','.communityView_comment_btn>button:nth-child(2)', function(){ //수정버튼 클릭시
			$(this).parent().parent().next().next().children().css("display","block"); //수정창 열리기
			$(this).parent().parent().next().next().children().focus();
			$(this).parent().parent().next().css("display","none");//원래 댓글 숨기기
			$(this).prev().css("display","inline"); //수정취소 버튼 나오기
			$(this).css("display","none"); //수정버튼 숨기기
		});
		$(document).on('click','.communityView_comment_btn>button:nth-child(1)', function(){ //수정취소 버튼 클릭시
			$(this).parent().parent().next().next().children().css("display","none"); //수정창 숨기기
			$(this).parent().parent().next().css("display","block"); //원래 댓글 나오기
			$(this).next().css("display","inline"); //수정버튼 나오기
			$(this).css("display","none"); //수정취소 버튼 숨기기
		});
		$(document).on('submit','.replyEditForm', function(){
			var url = "/home/replyEdit";
			var params = $(this).serialize();
			$.ajax({
				url : url,
				data : params,
				type : "POST",
				success : function(result){
					replyList();
				}, error : function(){
					console.log("댓글 수정 실패...");
				}
			});
			return false;
		});
		
		//4. 댓글 삭제하기
		$(document).on('click','.communityView_comment_btn>button:nth-child(3)', function(){ //삭제버튼 클릭시
			if(confirm('해당 댓글을 삭제하시겠습니까?')){
				var url = '/home/replyDel';
				var num = $(this).parent().parent().next().next().children().children().eq(0).val();
				var no = $(this).parent().parent().next().next().children().children().eq(1).val();
				var userid = $(this).parent().parent().next().next().children().children().eq(2).val();
				var params = 'num='+num+"&userid="+userid+"&no="+no;
		
				$.ajax({
					url : url,
					data : params,
					type : "post",
					success : function(result){
						replyList();
						replyCntChange('minus');
					}, error : function(){
						console.log("댓글 삭제 실패...");
					}
				});
			} //confirm end
		});//4 end
	
		//5. 답글 달기
		$(document).on('click','.communityView_comment_btn>button:nth-child(4)', function(){
			var replyid = $(this).next().val();
			var taggedId = '@'+$(this).next().val()+' ';
			var replyidCnt = taggedId.length;
			var taggedNum = $(this).next().next().val();
			
			reReply(replyid, taggedId, replyidCnt, taggedNum);
			$("#comment_content").keyup(function(e){ //답글기능 해제시키기
				if(e.keyCode==8 || e.keyCode == 46){	//backspace or delte 키
					if($(this).val().length<replyidCnt && $(this).val().length>0) {
						if(confirm("답글 달기를 취소하시겠습니까?")){
							$(this).val(" ");
							$("#replyBtn").text('댓글 등록');
							$("#taggedNum").val(' ');
						}else{
							reReply(replyid, taggedId, replyidCnt, taggedNum);
						}
					}
				}	
			});
		});
		function reReply(replyid, taggedId, replyidCnt, taggedNum){//대댓글시 아이디값 넣어주는 함수
			$("#taggedNum").val(taggedNum);
			$("#comment_content").val(taggedId);
			$("#replyBtn").text(replyid+'님에게 답글 달기');
			//아이디뒤에 커서 위치하게 만들기 위한 제이쿼리 플러그인
			$.fn.setCursorPosition = function( pos )
			{
			  this.each( function( index, elem ) {
			    if( elem.setSelectionRange ) {
			      elem.setSelectionRange(pos, pos);
			    } else if( elem.createTextRange ) {
			      var range = elem.createTextRange();
			      range.collapse(true);
			      range.moveEnd('character', pos);
			      range.moveStart('character', pos);
			      range.select();
			    }
			  });
			  return this;
			};
			$("#comment_content").focus().setCursorPosition(replyidCnt); // 아이디 뒤에 커서 위치시키기
		}
		
		//글 신고하기=========================================
		$(document).on('click','.reportBtn', function(){
			var	reportid = '${vo.userid}';
			var category = '커뮤니티';
			var no = ${vo.no};
			report(reportid, category, no);
		});
		//댓글 신고하기
		$(document).on('click','.replyReport', function(){
			var	reportid = $(this).prev().prev().val();
			var category = '댓글';
			var no = $(this).prev().val();
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
		$('.popupClose').click(function(){
			reportFormReset();
		});
		function reportFormReset(){
			//값 초기화
			$(".userid").val("");
			$(".reportCategory").val("");
			$(".reportNum").val("");
			$("#reportcontent").val("");
			$("#reportcategory option:eq(0)").prop('selected', true);
			//$("#category").val('${list.category}').prop('selected', true);
			$('.reportpopup').css('display','none');
			$('body').css('overflow','auto');
		}
		//신고하기 서브밋
		$('#reportForm').submit(function(){
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
	});
</script>
<div class="wrap">
	<div class="content">
		<p class="m_title">커뮤니티</p>
		<ul class="content_menu" style="margin:10px 0;">
			<li><a class="on">${vo.category}</a></li>
		</ul>
		<c:if test="${vo.userid != logId && logId != null}">
			<a class="reportBtn" style="float:left;">
				<img title="신고" alt="신고" src="<%=request.getContextPath()%>/img/comm/ico_report.png" >
			</a>
		</c:if>
		<div style="text-align:right; border-bottom: 1px solid #13a89e; padding-bottom:10px; margin-bottom:10px;">
			<c:if test="${pVO.prevNo != 0}">		
				<a class="white aTagReset" href="communityView?no=${pVO.prevNo}<c:if test="${pVO.category != null}">&category=${pVO.category}</c:if><c:if test="${category != null}">&category=${category}</c:if><c:if test="${pVO.searchKey != null}">&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">이전글</a>
			</c:if>
			<c:if test="${pVO.nextNo != 0}">
				<a class="white aTagReset" href="communityView?no=${pVO.nextNo}<c:if test="${pVO.category != null}">&category=${pVO.category}</c:if><c:if test="${category != null}">&category=${category}</c:if><c:if test="${pVO.searchKey != null}">&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">다음글</a>
			</c:if>
			<a class="white aTagReset" href="communityList">전체목록</a>
		</div>
		<ul>
			<li>
				<span class="communityViewSubject">${vo.subject}</span>
				<c:if test="${vo.userid==logId}">
					<a href="communityEdit?no=${vo.no}">수정</a>
					<a href="javascript:communityDel()">삭제</a>
				</c:if>
			</li>
			<li>
				<div class="communityView_user_porfile">
					<img src="/home/profilePic/${vo.profilePic}" onerror="this.src='<%=request.getContextPath()%>/profilePic/basic.jpg'"/>
				</div>
				<div class="communityView_user_detail">
					${vo.userid}<br>
					${vo.writedate}
				</div>
				<div class="communityView_user_detail">	
					조회수 : <span>&nbsp;${vo.hit}</span><br>
					댓글수 : &nbsp;<span class="replyCnt">${replyCnt}</span>
				</div>
			</li>
			
			<li class="communityView_content">
				${vo.content}
			</li>
		</ul>
		<!-- 댓글 -->
		<p class="d_title" style="margin:15px 0; padding-bottom:10px; border-bottom:1px solid #eee">댓글 <span class="replyCnt">${replyCnt}</span></p>
		<ul id="replyList">
			<!-- 댓글이 들어올 부분 -->
		</ul>
		<p class="d_title"style="margin:15px 0;padding-bottom:10px; border-bottom:1px solid #eee">댓글 쓰기</p>
		<c:if test="${logId != null}">
			<form method="post" id="commentForm">
				<ul>
					<li style=" min-height:50px; margin:0 auto;">
						<input type="hidden" name="no" value="${vo.no}"> <!-- 가져갈 원글번호 -->
						<input id="taggedNum" type="hidden" name="taggedNum" value=""> <!-- 답글 달때 원댓글 번호 -->
						<textarea id="comment_content" name="content" style="height: 150px; width: 100%"></textarea>
						<button id="replyBtn" class="q_btn green">댓글 등록</button>
					</li>
				</ul>
			</form>
		</c:if>
		<c:if test="${logId==null}">
			<ul>
				<li style=" min-height:50px; margin:0 auto;">
					<textarea id="comment_content" name="content" style="height: 150px; width: 100%" placeholder="댓글쓰기는 로그인 후 이용 가능합니다." readonly></textarea>
					<a href="login" class="q_btn green">로그인</a>
					${logStatus}
				</li>
			</ul>
		</c:if>
	</div>
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
							<div>분류</div> <input class="reportCategory" type="text" name="category" readonly>
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
				<a href="javascript:$('#reportForm').submit()" id="reportBtn" class="btn_save">접수</a>
			</div>
			<a class="pup_btn_close popupClose">닫기</a>
		</form>
	</div>
</div>