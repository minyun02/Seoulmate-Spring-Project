$(function(){	 
	 //팝업 닫기
	$(document).on('click','.popup_Close',function(){
		$('.admin_Management_popup').addClass('popup_hidden');
		$('#myPage_popup_FullScreen').addClass('popup_hidden');
		$('body').removeClass('popup_Stop_Scroll');
	});
	//일,월,년도별 클릭..
	$(document).on('change', 'select[name=selectYearMonthDate]', function(){
		//초기화
		console.log('일별월별년별? = ' + $(this).val());
		var selectYearMonthDate = $(this).val();
		var selectStartDate = $('input[name=selectStartDate]').val();
		var selectEndDate = $('input[name=selectEndDate]').val();
		console.log("selectStartDate = "+selectStartDate);
		console.log("selectEndDate = "+selectEndDate);
		var tag = '';
		$('.selectDateChoose').empty();
		if(selectYearMonthDate=='일별'|| selectYearMonthDate=='' || selectYearMonthDate==null){
			if(selectStartDate==null || selectStartDate==''){
				console.log('start 일별선택 -> 기존 월별 or 년별 이었음 / 날짜는 선택안함');
				tag += '<input type="date" name="selectStartDate"/>';
				
			}else{
				if(selectStartDate.length==10){
					console.log('start 일별선택 -> 기존 일별 날짜 선택되어 있었음. ');
					tag += '<input type="date" name="selectStartDate" value="'+selectStartDate+'"/>';
				}else if(selectStartDate.length==7){
					console.log('start 일별선택 -> 기존 월별 or 년별 날짜 선택되어 있었음. ');
					tag += '<input type="date" name="selectStartDate" value="'+selectStartDate+'-01'+'"/>';
				}
			}
			
			if(selectEndDate==null || selectEndDate==''){
				console.log('end 일별선택 -> 기존 월별 or 년별 이었음 / 날짜는 선택안함');
				tag += '<input type="date" name="selectEndDate"/>';
			}else{
				if(selectEndDate.length==10){
					console.log('end 일별선택 -> 기존 일별 날짜 선택되어 있었음. ');
					tag += '<input type="date" name="selectEndDate" value="'+selectEndDate+'"/>';
				}else if(selectEndDate.length==7){
					var lastDay = ( new Date( selectEndDate.substr(0,4), selectEndDate.substr(6, 2), 0) ).getDate();
					console.log('end 일별선택 -> 기존 월별 or 년별 날짜 선택되어 있었음. ');
					tag += '<input type="date" name="selectEndDate" value="'+selectEndDate+'-'+lastDay+'"/>';
				}
			}
		}else if(selectYearMonthDate=='월별' || selectYearMonthDate=='년별'){
			if(selectStartDate==null || selectStartDate==''){
				console.log('start 월별선택 -> 기존 월별 or 년별 이었음 / 날짜는 선택안함');
				tag += '<input type="month" name="selectStartDate"/>';
			}else{
				if(selectStartDate.length==10){
					console.log('start 월별선택 or 년별 선택 -> 기존 일별 날짜 선택되어 있었음. ');
					tag += '<input type="month" name="selectStartDate" value="'+selectStartDate.substr(0,7)+'"/>';
					console.log(selectStartDate.substr(0,7));
				}else if(selectEndDate.length==7){
					console.log('start 월별선택 -> 기존 월별 or 년별 날짜 선택되어 있었음. ');
					tag += '<input type="month" name="selectStartDate" value="'+selectStartDate+'"/>';
				}
			}
			if(selectEndDate==null || selectEndDate==''){
				console.log('end 월별선택 -> 기존 월별 or 년별 이었음 / 날짜는 선택안함');
				tag += '<input type="month" name="selectEndDate"/>';
			}else{
				if(selectEndDate.length==10){
					console.log('end 월별선택 -> 기존 일별 날짜 선택되어 있었음. ');
					tag += '<input type="month" name="selectEndDate" value="'+selectEndDate.substr(0,7)+'"/>';
				}else if(selectEndDate.length==7){
					console.log('end 월별선택 -> 기존 월별 or 년별 날짜 선택되어 있었음. ');
					tag += '<input type="month" name="selectEndDate" value="'+selectEndDate+'"/>';
				}
			}
		}
		$('.selectDateChoose').html(tag);
	});
});
//팝업 띄우기 
function openPopup(){
	//팝업 보이도록 클래스 삭제, 추가
	$('body').addClass('popup_Stop_Scroll');
	$('#myPage_popup_FullScreen').removeClass('popup_hidden');
	$('.admin_Management_popup').removeClass('popup_hidden');
}
//자료 프린트하기 
function printPage(msg){
	var printWidth = 800;
	var printHeghit = 800;
	var state ='';
	var grade = 0;
	var searchKey = '';
	var searchWord = '';
	var selectYearMonthDate = '';
	var selectStartDate = '';
	var selectEndDate = '';
	if(msg == 'mateWrite' || msg == 'mateExcel'){
		state =  $("#matestate option:selected").val();
		grade = $("#grade option:selected").val();
		searchKey = $("#searchKey option:selected").val();
		searchWord = $("input[name=searchWord]").val();
		window.open("/home/admin/adminPrintPage?msg="+msg+"&matestate="+state+"&grade="+grade+"&searchKey="+searchKey+"&searchWord="+searchWord, "PopPage", "width=800, height=800");
	}
	if(msg == 'houseWrite' || msg == 'houseExcel'){
		state =  $("#housestate option:selected").val();
		grade = $("#grade option:selected").val();
		searchKey = $("#searchKey option:selected").val();
		searchWord = $("input[name=searchWord]").val();
		window.open("/home/admin/adminPrintPage?msg="+msg+"&housestate="+state+"&grade="+grade+"&searchKey="+searchKey+"&searchWord="+searchWord, "PopPage", "width=800, height=800");
	}
	var selectYearMonthDate = '';
	var selectStartDate = '';
	var selectEndDate = '';
	if(msg == 'pay' || msg=='sales' || msg == 'payExcel' || msg == 'salesExcel'){
		selectYearMonthDate = $("#selectYearMonthDate option:selected").val();
		selectStartDate = $("input[name=selectStartDate]").val();
		selectEndDate = $("input[name=selectEndDate]").val();
		if(msg == 'pay' || msg == 'payExcel'){
			searchKey = $("#searchKey option:selected").val();
			searchWord = $("input[name=searchWord]").val();
			window.open("/home/admin/adminPrintPage?msg="+msg+"&selectYearMonthDate="+selectYearMonthDate+"&selectStartDate="+selectStartDate+"&selectEndDate="+selectEndDate+"&searchKey="+searchKey+"&searchWord="+searchWord, "PopPage", "width=800, height=800");
		}else if(msg=='sales' || msg == 'salesExcel'){
			window.open("/home/admin/adminPrintPage?msg="+msg+"&selectYearMonthDate="+selectYearMonthDate+"&selectStartDate="+selectStartDate+"&selectEndDate="+selectEndDate, "PopPage", "width=800, height=800");
		}
	}
	if(msg == 'pop'){
		var p_body = document.body.innerHTML;
		window.onbeforeprint = function(){
			document.body.innerHTML = document.getElementById('admin_Management_popup_print').innerHTML;	
		}
		window.onafterprint = function(){
			document.body.innerHTML = p_body;
		}
		window.print();
	}
	if(msg == 'popSalesExcel'){
		var date = new Date();
		var filename = 'salesDetail_'+date.getFullYear()+(date.getMonth()+1)+date.getDate()+date.getHours()+date.getMinutes()+date.getSeconds();
		$("#popExcel").table2excel({ 
			exclude: ".noExl", 
			name: "Excel Document Name", 
			filename: filename,
			fileext: ".xls", 
			exclude_img: true, 
			exclude_links: true, 
			exclude_inputs: true 
		});
	}
}
//페이징
function pageClick(msg){
	var pageNum = '<c:out value="${pagingVO.pageNum }"/>';  //현재 눌려있는 페이지
	var startPageNum = '<c:out value="${pagingVO.startPageNum }"/>'; // 페이징 시작 페이지
	var totalPage = '<c:out value="${pagingVO.totalPage }"/>'; //마지막 페이징
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
	// 히든에 값넣고
	$('#hiddenPageNum').val(changePageNum);
	// 서브밋 실행 
	$('.management_SearchForm').submit();
}