
//nav
function nav_menu(a){
	
	var gnb = $('#gnb'),
		depth1 = $(".topmenu");
	depth1.find(" > li > div").addClass('top2m');
	depth1.find("ul ul").show();

	$("#gnb .topmenu .depth1.part > div").addClass("part_info");
	$("#gnb .topmenu .depth1.part div div > ul > li").each(function(index){
		$(this).addClass("part_icon"+(index+1));
		});


	var depth2 = $('.topmenu .top2m'),
		gnbBg= $(".gnb_bg"),
		gnbLeave = $(".search_btn button, .move_ctrl ul li:first-child a,#side ul li:first a");

	depth2.hide();

	gnb.css("left","");
	depth1.find(" > li > a").off();
	depth1.find(" ul > li a").off();


	var dep1_length = depth1.find(" > li").size();
	for (i=1;i <= dep1_length;i++) {
		depth1.find("> li:nth-child("+i+") .top2m").addClass('m'+i);
	}
	
	depth1.find(" > li > a").on('mouseenter focusin',function(event){
		event.preventDefault ();

		depth2.hide();
		$(this).parent('.depth1').find('.top2m').show();
		var gnb_bg_height=$(this).parent('.depth1').find('.top2m').innerHeight();
		gnbBg.stop().css({'height':gnb_bg_height}).show();
		depth1.addClass('on');

		var $target=$(event.target);
		if($target.is('.depth1:last-child > a')){			
			gnbBg.addClass('part_bg');

		};
	});

	$('.depth1.part').mouseleave(function(){
		gnbBg.removeClass('part_bg');				   
	});

	depth1.mouseleave(function(){
		depth2.stop().hide();
		gnbBg.stop().hide();
		depth1.removeClass('on');
		depth2.prev('a.hover').removeClass('hover');
	});
	$('.depth1').on('mouseleave',function(){ 
	 $(this).find('.top2m').hide(); 
		depth2.prev('a.hover').removeClass('hover'); 
	}); 


	depth2.on('mouseenter focusin',function(event){
		depth2.prev('a.hover').removeClass('hover');
		$(this).prev('a').addClass('hover');
	});

	//gnb 벗어나면 닫기
	gnbLeave.focusin(function(){
		depth2.stop().slideUp();
		gnbBg.stop().slideUp();
		depth1.removeClass('on');
		depth2.prev('a.hover').removeClass('hover');
	});

};

$(function () {
	$(window).on({
		load: function () {
			if ($(window).width() ) {
				nav_menu();
			}

		},
		
	});
});


//LNB 
$(function(){

    
    // LNB sub menu slide Start
    $(".lnb_2depth").siblings("a").addClass("ico_ext");
    $(".lnb_2depth li a.selected").parent().parent(".lnb_2depth").css({"display":"block"});
    $(".lnb_2depth li a.selected").parent("li").parent().siblings("a").addClass("selected");
    
    $(".lnb li a").click(function(){
        if($(this).siblings(".lnb_2depth").css("display") == "none"){
            $(this).siblings(".lnb_2depth").stop().slideDown(300);
            $(this).addClass("selected");
        }else{
            $(this).siblings(".lnb_2depth").stop().slideUp(300);
            $(this).removeClass("selected");
        }
    });
    
});


//메인뉴스tab
$(function() {
	$('.news_area .tit a').each(function(i, o) {
		$(o).bind('mouseover hover focus', function() {
			$('.news_area .news_list').hide();
			$('.news_area .tit a').removeClass('hover');
			$(this).addClass('hover').parent().next().show();
		});
		$('.news_area .tit a').eq(0).mouseover();
	});
});

//팝업존
function popupzone(){
		var param = $(".pzone");
		var btn = param.find(".pzone_menu > span");
		var obj = param.find("ul > li");
		var sum = obj.length-1;
		var elem = 0;
		var movement;

		// setup

		obj.hide();
		obj.eq(0).show();
		// action

		function viewControll(){
			obj.hide();
			obj.eq(elem).fadeIn(500);
		}

		function autoStart(){
			movement = setInterval(function(){
				if(elem == sum){
					elem = 0;
				}else{
					elem++;
				}
				viewControll();
			},5000);
		}
		
		// < prev 
		btn.eq(0).click(function(){
			clearInterval(movement);
			if(elem == 0){
				elem = sum;
			}else{
				elem--;
			}
			viewControll();
			return false;
		});	
		
		// �ъ깮以묒�
		btn.eq(1).click(function(){
			clearInterval(movement);
			return false;
		});

		// > next
		btn.eq(2).click(function(){
			clearInterval(movement);
			if(elem == sum){
				elem = 0;
			}else{
				elem++;
			}
			viewControll();
			return false;
		});

//		btn.eq(3).click(function(){
//			clearInterval(movement);
//			if(elem == sum){
//				elem = 0;
//			}else{
//				elem++;
//			}
//			viewControll();
//			return false;
//		});
		
		obj.find("a").bind("mouseover focus",function(){
			clearInterval(movement);
		});

		obj.find("a").bind("mouseout blur",function(){
			clearInterval(movement);
			//autoStart();
		});

		autoStart();
	}




/** 모바일네비게이션
 * text replaceAll function
 * @param str
 * @param searchStr
 * @param replaceStr
 * @returns
 */
function replaceAll(str, searchStr, replaceStr) {
	return str.split(searchStr).join(replaceStr);
}


$(function(){

	//mobile search
	$(".open_kw").click(function(){
		if ($(this).hasClass("open open_kw")) {
			//$(this).attr("class","open close_kw").children().attr("src","/portal/images/common/mobile_close.png").attr("alt","검색 닫기");
			$(this).attr("class","open close_kw");
			$("#mask_kw").fadeTo("fast", 1);
			$(".search").show();
		} else if ($(this).hasClass("open close_kw")) {
			//$(this).attr("class","open open_kw").children().attr("src","/portal/images/common/open_kw.png").attr("alt","검색 열기");
			$(this).attr("class","open open_kw");
			$("#mask_kw").fadeOut();
			$(".search").hide();
		}
		return false;
	});

	$("#mask_kw").click(function(){
		$("#header_wrap2").find("a.close_kw").attr("class","open open_kw").children("img").attr("src","/portal/images/common/open_kw.png").attr("alt","검색 열기");
		$("#mask_kw").fadeOut();
		$(".mb_search_box").hide();
		$(".search").hide();
	});

	//mobile navigation
	$(".open_mn").click(function(){
		$("#mask_mn").fadeTo("fast", 1);
		$("#mobileNavi").animate({right:"0"});
		$("body").addClass("stop_scrolling");
		return false;
	});

	$("#mobileNavi .close").click(function(){
		$("#mask_mn").fadeOut();
		$("#mobileNavi").animate({right:"-100%"});
		$("body").removeClass("stop_scrolling");
		return false;
	});

	if ($(".side_menu li").hasClass("on"))
	{
		$(this).find("ul").find("li.on").children("ul").show();
	}

	$(".side_menu a").bind('click', function(){
		var aParent = $(this).parent("li").parent("ul");
		var aClass = $(this).parent().attr("class");
		var aLink = $(this).attr("href");

		if (typeof aLink != "undefined") {
			return true;
		}

		if (aClass == "on")
		{
			$(this).parent().removeClass("on");
			$(this).next("ul").hide();
			return false;
		} else {
			if ($(this).next("ul").length == 0)
			{
				var url = $(this).attr("href");
				$(location).attr('href',url);

			} else {
				$(this).parent("li").addClass("on");
				$(this).parent("li").siblings("li").removeClass("on");
				$(this).next("ul").show();
				$(this).parent("li").siblings("li").find("ul").not($(this).next("ul")).hide();
				return false;
			}
		}

	});
});


//레이업팝업_전체메뉴
$(document).ready(function() {
	$("#popupButton1").click(function() {goPopUp1();});  
	$("#popupButton2").click(function() {goPopUp2();});  
	$("#popupButton3").click(function() {goPopUp3();});    
})

var goPopUp1 = function() {
	//전체메뉴
	$('#allmenu').bPopup();
}
var goPopUp2 = function() {
	$('#popup2').bPopup();
}
var goPopUp3 = function() {
	$('#popup3').bPopup();
}



//관련사이트
function footersitelink(param,btn,obj){
	var param = $(param);
	var btn = param.find(btn);
	var obj = param.find(obj);

	btn.bind("click",function(event){
		var t = $(this);

		if(t.next().css('display') == 'none'){
			obj.hide(); 
			t.next().show();
			btn.removeClass("ov");
			$(this).find('span').text('-');
			$(this).addClass("ov");
		}else{
			obj.hide();
			btn.find('span').text('+');
			btn.removeClass("ov");
		}

		event.preventDefault();
	});
	
}


//자동 높이값



//FAQ 펼침
		
if (typeof console === "undefined" || console === null) {
    console = {
      log: function() {}
    };
  }

var APP = APP || {};

APP.register = function(ns_name){
    var parts = ns_name.split('.'),
    parent = APP;    
    for(var i = 0; i < parts.length; i += 1){
        if(typeof parent[parts[i]] === "undefined"){
               parent[parts[i]] = {};
        }
        parent = parent[parts[i]];
    }
    return parent;
};


APP.isAlphaTween = true;

(function(ns, $,undefined){  
    ns.register('ui.faqAcMenu');           
    ns.ui.faqAcMenu = function(ele, otherC){
    	
		var element, btn, isOpen=false, listArr, titleTxt;
		var otherC = otherC || false;
		var i, max;
		
		element=ele;
 		listArr = $(element).find('>li>dl');
 		
 		btn = $(listArr).find('>dt>a');
 		titleTxt = String(btn.attr('title')).split(" 보기")[0];		
 		btn.on('click', openList);
 		
        function listHandler(e) {
      		switch ( e.type ) {
                case 'mouseenter':
                case 'focusin':                  	     	
                                                               
                    break;                    
                case 'focusout':
                case 'mouseleave':
                   
                    break;
			}
      	}   
      	
       function openList(e){
	       	var parent = $(e.currentTarget).parent().parent()
	       	var viewCon = parent.find('>dd')
	       	if(parent.hasClass('on')){
	       		parent.removeClass('on');
	       		viewCon.css('display', 'none');
	       		if(titleTxt != 'undefined')$(e.currentTarget).attr('title', titleTxt+' 보기');
	       	}else{
	       		if(otherC){
	       			listArr.removeClass('on');
	       			$(listArr).removeClass('on')
	       			$(listArr).find('>dd').css('display', 'none');
	       			if(titleTxt != 'undefined')$(btn).attr('title', titleTxt+' 보기');
	       		}
	       		
	       		parent.addClass('on');       		
	       		viewCon.css('display', 'block');
	       		TweenLite.from(viewCon, 0.3, {css:{opacity:0}});  
	       		if(titleTxt != 'undefined')$(e.currentTarget).attr('title', titleTxt+' 닫기');
	       	}
       	
       
        }
    };
    
    
    
    
}(APP || {}, jQuery));