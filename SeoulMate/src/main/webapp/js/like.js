//찜 등록
function likeInsert(no, category, userid, obj){
	$.ajax({
		url : "/home/likemarkInsert",
		data : 'no='+no+'&category='+category+'&userid='+userid,
		success : function(result){
			$(obj).addClass("on");
			$('.btn_star[value='+no+']').addClass('on');
		}, error : function(){
			alert('찜하기가 실패했습니다. 다시 시도해주세요.')
		}
	});
}

// 찜 삭제
function likeDelete(no, userid, obj){
	$.ajax({
		url : "/home/likemarkDelete",
		data : "no="+no+"&userid="+userid,
		success : function(){
			$(obj).removeClass('on');
			$('.btn_star[value='+no+']').removeClass('on');
		}, error : function(){
			alert('찜하기 삭제가 실패했습니다. 다시 시도해주세요.')
		}
	});
}

//로그인 후 페이지가 로딩되면 찜한 글 불 들어오기
function likeButtonOn(result){
	$('.btn_star').each(function(idx, item){
		if(result.houseNum != null){
			if(result.houseNum.indexOf($(item).val()) != -1){ //내 하우스글 별 없애기
				$(item).css('display','none');
			}
		}
		if(result.mateNum != null){
			if(result.mateNum.indexOf($(item).val()) != -1){ //내 하우스글 별 없애기
				$(item).css('display','none');
			}
		}
		//찜한거 불 넣기
		if(result.userLikeNum.indexOf($(item).val()) != -1){
			$(item).addClass('on');
		}
	});
}