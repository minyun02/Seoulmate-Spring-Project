<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="//cdn.ckeditor.com/4.16.1/basic/ckeditor.js"></script>
<script>
	$(function(){
		// 레코드 출력
		function faqList(){
			var url="/home/admin/faqList";
			
			$.ajax({
				url:url,
				success:function(result){
					var $result=$(result);
					var tag="";
					
					$result.each(function(idx, obj){
						tag+="<tr>";
						tag+="<td>"+obj.no+"</td>";
						tag+="<td>"+obj.subject+"</td>";
						tag+="<td>"+obj.userid+"</td>";
						tag+="<td>"+obj.writedate+"</td>";
						tag+="<tr>";
						
						$("#faqTbody").html(tag);
					});
				}, error:function(){
					console.log("faq 목록 가져오기 에러 발생...");
				}
			});
		}
		faqList();
		
		// 레코드 선택
		var select;
		$(document).on('click', '#faqTbody>tr', function(){
			select=$(this);
			$("#faqInfo").css("display", "block");
			$("#faqEditBtn").css("display", "inline-block"); // 수정 버튼 보이기
			$("#faqInsertBtn").css("display", "none"); // 추가 버튼 숨기기
			$("#faqDelBtn").css("display", "inline-block"); // 삭제 버튼 보이기
			$(document.body).css("overflow","hidden");
			$('.pup_body').scrollTop(0);
			var selectNo=select.children().eq(0).text(); // 선택한 행의 no
			
			var url="/home/admin/faqInfo";
			var params="no="+selectNo;
			
			$.ajax({
				url:url,
				data:params,
				success:function(data){
					$("#faqId").val(data.userid);
					$("#faqNo").val(data.no);
					$("#faqSubject").val(data.subject);
					CKEDITOR.instances.faqContent.setData(data.content);
				},error(){
					console.log("자주하는 질문 데이터 읽어오기 에러 발생");
				}
			});
		});
		
		// 수정 버튼을 누를 때 유효성 검사
		$(document.getElementById("faqEditBtn")).click(function(){
			if(regExp()!=false){
				var txt=CKEDITOR.instances.faqContent.getData();
				$("#faqContent").val(txt);
				
				var url="/home/admin/faqEdit";
				var params=$("#faqInfoForm").serialize();
				
				$.ajax({
					url:url,
					data:params,
					success:function(result){
						if(result==1){
							close(); // 팝업창 닫는 함수
							faqList(); // faq 목록을 출력하는 함수
						}
					}, error:function(){
						console.log("faq 수정 에러 발생...");	
					}
				});				
			}
		});
		
		// 추가 버튼 이벤트
		$("#faqAddBtn").click(function(){
			CKEDITOR.instances.faqContent.setData();
			$("#faqInfo").css("display", "block");
			$("#faqInsertBtn").css("display", "inline-block"); // 추가 버튼 보이기
			$("#faqEditBtn").css("display", "none"); // 수정 버튼 숨기기
			$("#faqDelBtn").css("display", "none"); // 삭제 버튼 숨기기
			$(document.body).css("overflow","hidden");
			$('.pup_body').scrollTop(0);
			
			$(document.getElementById("faqId")).val('${adminId}');
			$(document.getElementById("faqNo")).val(0);
		});
		
		// faq를 등록하는 이벤트
		$("#faqInsertBtn").click(function(){
			if(regExp()!=false){
				var txt=CKEDITOR.instances.faqContent.getData();
				$("#faqContent").val(txt);
				
				var url="/home/admin/faqInsert";
				var params=$("#faqInfoForm").serialize();
				
				
				$.ajax({
					url:url,
					data:params,
					success:function(result){
						if(result==1){
							faqList();
							close();
						}
					}, error:function(){
						console.log("faq 등록 에러 발생...");	
					}
				});
			} // 유효성 검사
			
			
		});
		
		// 팝업창을 닫는 이벤트
		$("#faqClose, .pup_btn_close").click(function(){
			close();
		});
		
		// faq를 삭제하는 이벤트
		$("#faqDelBtn").click(function(){
			var url="/home/admin/faqDel";
			var params=$("#faqInfoForm").serialize();
			
			$.ajax({
				url:url,
				data:params,
				success:function(result){
					if(result==1){
						faqList();
						close();
					}
				}, error:function(){
					console.log("faq 수정 에러 발생...");	
				}
			});
		});
		
		// 유효성 검사 함수
		function regExp(){
			if($("#faqSubject").val()==""){
				alert("질문을 입력하세요.");
				return false;
			}
			var txt=CKEDITOR.instances.faqContent.getData();
			if(txt=="" || txt==null){
				alert("답변을 입력하세요.");
				return false;
			}
		}
		
		// close 함수
		function close(){
			$("#faqInfo").css("display", "none");
			$(document.body).css("overflow","visible");
			
			// 창을 닫으면 value를 지움
			$(document.getElementById("faqId")).val("");
			$(document.getElementById("faqNo")).val("");
			$(document.getElementById("faqSubject")).val("");
			$(document.getElementById("faqContent")).val("");
		}
	});
</script>
		<section class="admin_Section">
			<div class="admin_Content">
				<div class="m_title managementTitle">자주하는 질문<a class="btn btn-custom" id="faqAddBtn">질문 작성하기</a></div>
				<div class="table-responsive, managementList">
					<table class="table table-hover table-sm table-bordered" id="faqTable"> <!-- style="table-layout: fixed" -->
						<thead class="thead-light">
							<tr>
								<th width="10%">No.</th>
								<th width="60%">제목</th>
								<th width="15%">작성자</th>
								<th width="15%">작성일</th>
							</tr>
						</thead>
						<tbody id=faqTbody></tbody>
<%-- 							<c:forEach var="list" items="${faqList}"> --%>
<!-- 								<tr> -->
<%-- 									<td>${list.no}</td> --%>
<%-- 									<td>${list.subject}</td> --%>
<%-- 									<td>${list.userid}</td> --%>
<%-- 									<td>${list.writedate}</td> --%>
<!-- 								</tr> -->
<%-- 							</c:forEach> --%>
						
					</table>
				</div>
			</div>
		</section>
<!-- 팝업창*********************************************** -->
		<div class="pup_wrap" id="faqInfo">
			<div class="pup_form">
				<div class="pup_head">자주하는 질문</div>
				<form method="post" id="faqInfoForm">
					<div class="pup_body">
						<div class="pup_list">
							<input type="hidden" name="userid" id="faqId" value=""/>
							<input type="hidden" name="no" id="faqNo" value=""/>
							<ul class="faqUl">
								<li><div class="faq_label"><span class="red_txt">*</span>질문</div><textarea name="subject" id="faqSubject" maxlength="100"></textarea></li>
								<li>
									<div class="faq_label"><span class="red_txt">*</span>답변</div><textarea name="content" id="faqContent"></textarea>
									<script>CKEDITOR.replace("content");</script>
								</li>
							</ul>
						</div>
					</div>
					<div class="pup_bottom" id="pup_bottom">
						<a class="btn btn-custom" id="faqDelBtn">삭제</a>
						<a class="btn btn-custom" id="faqEditBtn">수정</a>
						<a class="btn btn-custom" id="faqInsertBtn">등록</a>
						<a class="btn btn-custom" id="faqClose">닫기</a>
					</div>
				</form>
				<a class="pup_btn_close">닫기</a>
			</div>
		</div>
	</body>
</html>