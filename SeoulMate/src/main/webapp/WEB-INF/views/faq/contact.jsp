<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/yun.css">
<script>
	//이메일 정규식
	function isEmail(email) {
		//var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var regExp = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		return regExp.test(email); // 형식에 맞는 경우 true 리턴	
	}
	
	
	$(function(){
		$('input[type=text]').attr("autocomplete","off") //text input 자동완성 없애기
		
		if(${result}!=0){
			alert("문의가 접수되었습니다.");
		}
		
		$('.contactBtn').click(function(){
			
			if($('input[name=username]').val()==''){
				alert("이름을 입력해주세요.")
				return false;	
			}
			else if($('input[name=email]').val()==''){
				alert("이메일을 입력해주세요.")
				return false;	
			}
			else if($("#contactCategory option").index($("#contactCategory option:selected"))==0){
				alert("문의 분류를 선택하세요.");
				return false;
			}
			else if($('textarea[name=qContent]').val()==''){
				alert("문의내용을 입력해주세요.")
				return false;	
			}
			else if($("input[name=tel]").val()==''){
				alert("전화번호를 선택하세요.");
				return false;
			}
			else if($('input[name=email]').val()!=''){
				if(isEmail($('input[name=email]').val())){
					if(${logId==null}){
						checkId();
						alert("////")
					}else{
						return true;
					}
				}else{
					alert('이메일을 확인해주세요.')
					return false;
				}
			}
			return false;
		});
		
		function checkId(){
			var url = "/home/contactUseridCheck";
			
			$.ajax({
				url : url,
				data : "userid="+$('input[name=userid]').val(),
				type : 'post',
				success: function(result){
					console.log(result)
					if(result=='yes'){
						goSubmit();
					}else if(result=='no'){
						alert("등록된 아이디가 아닙니다. 다시 확인해주세요.")
						return false;
					}
				},error : function(){
					console.log('아이디 조회 실패..')
					return false;
				}
			});
			return false;
		}
		
		function goSubmit(){
			$("#contactForm").submit();
		}
		
		//이메일 수정 시
		$('#contactEmail').focus(function(){
			var email = '${logEmail}';
			var emailLength = email.length;
			
			if(${logId!=null}){
				$(this).on('keyup', function(){
					if($(this).val() != email){
						if(confirm('이메일을 수정하시겠습니까?')){
							$(this).val('');
							$(this).off();
						}else{
							$(this).val('${logEmail}');
							$(this).blur();
						}
					}
				});
			}
		});
	});
</script>
<div class="wrap">
	<div class="member_wrap">
		<p class="m_title">문의하기</p>
		<br>
		<br>
		<p class="d_title">FAQ에서 궁금증을 해결해보세요. <a href="qna" class="d_title faqATag">자주하는질문 보러가기</a></p>
		<br>
		<br>
		<br>
		<br>
		<p class="d_title">고객님의 정보를 입력해주세요.</p>
		<br>
		<form method="post" action="contactInsert" id="contactForm">
			<input type="text" name="userid" placeholder="아이디" value="${logId}" <c:if test="${logId!=null}">readonly</c:if>>
			<br>
			<br>
			<input type="text" name="username" placeholder="이름" value="${logName}" <c:if test="${logId!=null}">readonly</c:if>>
			<br>
			<br>
			<input id="contactEmail" type="text" name="email" placeholder="이메일" value="${logEmail}">
			<br>
			<br>
			<select id="contactCategory" name="category">
					<option disabled selected hidden>관련 문의사항을 선택하세요.</option>
					<option value="쉐어하우스">쉐어하우스</option>
					<option value="하우스메이트">하우스메이트</option>
					<option value="커뮤니티">커뮤니티</option>
					<option value="프리미엄 결제">프리미엄 결제</option>
					<option value="기타">기타</option>
			</select>
			<br>
			<br>
			<textarea name="qContent" rows="7" placeholder="문의내용을 입력하세요." id="contact"></textarea>
			<br>
			<br>
			<button class="q_btn green contactBtn">문의 보내기</button>
		</form>	
	</div>
</div>