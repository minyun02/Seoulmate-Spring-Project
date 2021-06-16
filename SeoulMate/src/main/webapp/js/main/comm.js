$(document).ready(function(){
	$(function() {
		var i;
		$('.sub_menu li').hover(function() {
			i = $('.sub_menu li').index(this);
			$('.main_menu li').eq(i).children().addClass('on');
		}, function() {
			$('.main_menu li').eq(i).children().removeClass('on');
		});
		
		
    $(".btn_chat").click(function () {
       if ($("#the_iframe").hasClass("on") == true) {
         $("#the_iframe").css("transition", ".3s");
         $("#the_iframe").removeClass("on");
       } else {
         $("#the_iframe").addClass("on");
         $("#the_iframe").css("transition", ".3s");
       }
     });
		
	});
	
});
