$(function(){

    // header
	$('header, header a').on('mouseover focus',function(){
		$('header').addClass('hover');
	});
	$('header, header a').on('mouseleave blur',function(){
		$('header').removeClass('hover');
	});	

	// depth02 메뉴
	$('#gnb .depth01 > li').on('mouseover',function(){
		$('header').removeClass('hover');
		$('.header_search_box').stop().fadeOut(100);
		$('#gnb .depth02_wrap').stop().fadeOut(100);
		$(this).children('.depth02_wrap').stop().fadeIn(100);
		$('.header_bg').stop().fadeIn(200);
	});
	$('#gnb .depth01 > li > a').on('focus',function(){
		$('.header_search_box').stop().fadeOut(100);
		$('#gnb .depth02_wrap').stop().fadeOut(100);
		$(this).parent().children('.depth02_wrap').stop().fadeIn(100);
		$('.header_bg').stop().fadeIn(200);
	});
	
	$('#gnb .depth01 > li').on('mouseleave blur',function(){
		$(this).children('#gnb .depth02_wrap').stop().fadeOut(100);
		$('.header_bg').stop().fadeOut(100);
	});
	$('nav .logo a').on('focus',function(){
		$('#gnb .depth02_wrap').stop().fadeOut(100);
		$('.header_bg').stop().fadeOut(200);
	});
	$('nav .utile_allmenu a').on('focus',function(){
		$('#gnb .depth02_wrap').stop().fadeOut(100);
		$('.header_bg').stop().fadeOut(200);
	});

	// 통합검색 버튼
	$('.header_search').click(function(){
		$('header').addClass('active');
		$('#gnb .depth02_wrap').stop().fadeOut(100);
		$('.header_search_box').stop().fadeIn(200);
		$('.header_bg').stop().fadeIn(200);
		$('.search_keyword').focus();
	});
	$('.header_search_box .search_close').click(function(){
		if($(window).scrollTop() == 0){
			$('header').removeClass('active');
			$('.header_search_box').stop().fadeOut(200);
			$('.header_bg').stop().fadeOut(200);
			$('.header_search').focus();
		}else{ 
			$('.header_search_box').stop().fadeOut(200);
			$('.header_bg').stop().fadeOut(200);
			$('.header_search').focus();
		} 
	});
	$('.allmenu_open').focus(function(){
		if($(window).scrollTop() == 0){
			$('header').removeClass('active');
			$('.header_search_box').stop().fadeOut(200);
			$('.header_bg').stop().fadeOut(200);
		}else{ 
			$('.header_search_box').stop().fadeOut(200);
			$('.header_bg').stop().fadeOut(200);
		} 	
	});

	// allmenu(sitemap)
	$('.allmenu_open').click(function(){
		$('.allmenu').stop().fadeIn(200);
		$('html').addClass('allmenu_view scroll_hidden');
		$('header').addClass('active');
		$('.header_search_box').slideUp();
		$('.allmenu .depth01 li:nth-child(1) > a').addClass('active');
		$('.top_popup').css('z-index', '0');
		$('firstFocus').focus();	//2023년 웹접근성
	});
	$('.allmenu_close').click(function(){
		if($(window).scrollTop() == 0){
			$('.allmenu').stop().fadeOut(200);
			$('html').removeClass('allmenu_view scroll_hidden');
			$('header').removeClass('active');
			$('.allmenu .depth01 li > a').removeClass('active');
			$('.top_popup').css('z-index', '120');
			$('.allmenu_open').focus();
		}else{ 
			$('.allmenu').stop().fadeOut(200);
			$('html').removeClass('allmenu_view scroll_hidden');
			$('.allmenu .depth01 li > a').removeClass('active');
			$('.top_popup').css('z-index', '120');
			$('.allmenu_open').focus();		
		} 
			
	});
	$(window).resize(function(){ 
		if (window.innerWidth < 1200) { 
			$('.allmenu .depth01 > li > a').click(function(){
				$('.allmenu .depth01 > li > a').removeClass('active');
				$(this).addClass('active');
			});
			$('.allmenu .depth03').parent('li').addClass('depth03_wrap');
			$('.allmenu .depth03').prev('a').attr({
				href:'javascript:void(0)',
				target: '',
				title: '',
			}).removeClass('linkWindow');
			
		} else { 
			$('.utile_linkbox .link').on('focus',function(){
				if($(window).scrollTop() == 0){
					$('.allmenu').stop().fadeOut(200);
					$('html').removeClass('allmenu_view scroll_hidden');
					$('header').removeClass('active');
					$('.allmenu .depth01 li > a').removeClass('active');
					$('.top_popup').css('z-index', '120');
				}else{ 
					$('.allmenu').stop().fadeOut(200);
					$('html').removeClass('allmenu_view scroll_hidden');
					$('.allmenu .depth01 li > a').removeClass('active');
					$('.top_popup').css('z-index', '120');
				} 
			});
		
		} 
	}).resize();
	$('.allmenu .depth03_wrap a').click(function(){
		if($(this).parent('.depth03_wrap').hasClass("active") === true) {
			$(this).siblings('.depth03').slideUp();
			$('.allmenu .depth03_wrap').removeClass('active');
			return true;
		} else {
			$('.allmenu .depth03_wrap a + .depth03').slideUp();
			$(this).siblings('.depth03').slideDown();
			$('.allmenu .depth03_wrap').removeClass('active');
			$(this).parent('.depth03_wrap').addClass('active');
		}
	});

});


// 접근성 관련 포커스 강제 이동
function accessibilityFocus() { 
	$(document).on('keydown', '[data-focus-prev], [data-focus-next]', function(e){ 
		var next = $(e.target).attr('data-focus-next'), 
			prev = $(e.target).attr('data-focus-prev'),
			target = next || prev || false; 
		if(!target || e.keyCode != 9) { 
			return; 
		} 
		if( (!e.shiftKey && !!next) || (e.shiftKey && !!prev) ) { 
			setTimeout(function(){ 
				$('[data-focus="' + target + '"]').focus();
			}, 1);
		}
	});
};
$(document).ready(function(){
	accessibilityFocus();
});