/* 전역 변수 */
var ua = navigator.userAgent;
var windowWidth = $(window).width();
var windowHeight = $(window).height();

$('.3depth').click(function(){
	if($(this).hasClass('on')){
		$(this).removeClass('on');
		$(this).next().slideUp();
	}else{
		$(this).addClass('on');
		$(this).next().slideDown();
	}


});
var flip = 0;
function toglePop(id){
	$("#"+id).toggle( flip++ % 2 == 0);
}
function showPop(id){
	$("#"+id).show();
}
function hidePop(id) {
	$("#"+id).hide();
}

/* useagent check */
function userAgentChk(){
	if(ua.match(/iPhone|iPod|LG|Android|SAMSUNG|Samsung/i) != null){
		if (windowWidth > 720){
			$("body").addClass("device").addClass("tablet");
			switch(window.orientation){
				case -90:
				$("body").addClass("tablet_landscape");
				$("body").addClass("pc").removeClass("tablet");
				break;
				case 90:
				$("body").addClass("tablet_landscape");
				$("body").addClass("pc").removeClass("tablet");
				break;
				case 0:
				$("body").addClass("tablet_portrait");
				$("body").removeClass("pc").removeClass("normal").addClass("tablet");
				break;
				case 180:
				$("body").addClass("tablet_portrait");
				$("body").removeClass("pc").removeClass("normal").addClass("tablet");
				break;
			 }
		}else{
			$("body").addClass("mobile").addClass("device");
			switch(window.orientation){
				case -90:
				$("body").addClass("mobile_landscape")
				break;
				case 90:
				$("body").addClass("mobile_landscape");
				break;
				case 0:
				$("body").addClass("mobile_portrait");
				break;
				case 180:
				$("body").addClass("mobile_portrait");
				break;
			 }
		}
	}else if (ua.match(/iPad|GallaxyTab/i) != null){
		$("body").addClass("device").addClass("tablet");
		switch(window.orientation){
			case -90:
			$("body").addClass("tablet_landscape");
			$("body").addClass("pc").removeClass("tablet");
			break;
			case 90:
			$("body").addClass("tablet_landscape");
			$("body").addClass("pc").removeClass("tablet");
			break;
			case 0:
			$("body").addClass("tablet_portrait");
			$("body").removeClass("pc").removeClass("normal").addClass("tablet");
			break;
			case 180:
			$("body").addClass("tablet_portrait");
			$("body").removeClass("pc").removeClass("normal").addClass("tablet");
			break;
		 }
	}else{
		bodyClassChange();

		$(window).resize(function(){
			windowWidth = $(window).width();
			windowHeight = $(window).height();
			bodyClassChange();
		}).resize();

		if(ua.indexOf("MSIE 8.0") > -1 || ua.indexOf("Trident/4.0") > -1){ //IE8 이하일 경우
			$("body").addClass("pc").addClass("pc_ie8");
			if(ua.indexOf("Windows NT 6.2") > -1){
			}else if (ua.indexOf("Windows NT 6.1") > -1){
				$("body").addClass("pc").addClass("pc_ie8").addClass("w7"); //window7, IE8
			}else if (ua.indexOf("Windows NT 5.1") > -1){
				$("body").addClass("pc").addClass("pc_ie8").addClass("xp"); //windowXP, IE8
			}
		}else if(ua.indexOf("MSIE 7.0") > -1 || ua.indexOf("MSIE 6.0") > -1){
			$("body").addClass("pc").addClass("pc_ie8");
		}else if(ua.indexOf("Trident") > -1){
			$("body").addClass("pc").addClass("ie");
		}else{ //IE9 PC
			if (ua.indexOf("Chrome") > -1){
				$("body").addClass("pc").addClass("chrome");
			}else if(ua.indexOf("Mac") > -1){
				$("body").addClass("mac");
			}else{
				$("body").addClass("pc");
			}
		}
	}
}
userAgentChk();

function bodyClassChange(){
	if (windowWidth > 1200){
		$("body").removeClass("mobile_portrait").removeClass("mobile").removeClass("tablet").removeClass("smallbrowser").addClass("normal");
		$(".midarea").css("min-height", (windowHeight-$(".toparea").height()-$(".bottomarea").height())+"px");
		$(".btn-mobilesearch").hide();
		$(".topmenu").css("left","0");
	}else if (windowWidth <= 1200 && windowWidth > 1000){
		$("body").removeClass("mobile_portrait").removeClass("normal").removeClass("mobile").removeClass("tablet").addClass("smallbrowser");
		$(".midarea").css("min-height", (windowHeight-$(".toparea").height()-$(".bottomarea").height())+"px");
		$(".btn-mobilesearch").hide();
		$(".topmenu").css("left","0");
	}else if (windowWidth <= 1000 && windowWidth > 768){
		$("body").removeClass("mobile_portrait").removeClass("normal").removeClass("mobile").removeClass("smallbrowser").addClass("tablet");
		$(".toparea .mobile-category").css("width", "50px").css("height", "50px");
	}else if (windowWidth <= 768){
		$("body").removeClass("mobile_portrait").removeClass("normal").removeClass("tablet").removeClass("smallbrowser").addClass("mobile");
		if (windowWidth < 481) {
			$("body").addClass("mobile_portrait");
			$(".toparea .mobile-category").css("width", "38px").css("height", "38px");
		}
	}
}

function firstLoad(){
	setTimeout(function(){
		$("#wrap").animate({opacity:1}, 100);
	}, 100);
}
firstLoad();

if ($("body").attr("id") != "global"){
	$(".topmenu > ul > li > a").focus(function(){
		var Idx = $(this).parent().index()+1;
		if ($("body").hasClass("normal")){
			var logoPositionLeft = (((windowWidth-1200)/2)-220);
			$(".topmenu > ul > li").removeClass("on");
			$(".topmenu > ul > li.topmenu_"+Idx+"").addClass("on");
			$(".toparea").append("<div class='bg-topmenu-on'><span class=logo style='left:"+logoPositionLeft+"px'></span></div>");
			$(".topmenu > ul > li ul").show();
			$(".topmenu").addClass("menuOpen");
		}else if ($("body").hasClass("smallbrowser")){
			$(".topmenu > ul > li").removeClass("on");
			$(".topmenu > ul > li.topmenu_"+Idx+"").addClass("on");
			$(".toparea").append("<div class='bg-topmenu-on'><span class=logo style='left:0'></span></div>");
			$(".topmenu > ul > li ul").show();
			$(".topmenu").addClass("menuOpen");
		}else{
			return false;
		}
	});
}

function topmenuOpen(Idx){
	if ($("body").hasClass("normal")){
		var logoPositionLeft = (((windowWidth-1200)/2)-220);
		$(".topmenu > ul > li").removeClass("on");
		$(".topmenu > ul > li.topmenu_"+Idx+"").addClass("on");
		//$(".toparea").append("<div class='bg-topmenu-on'><div class='menu_title'>상공회의소는 회원기업의<h3>경제적. 사회적 지위향샹</h3>을 위해 최선의 노력을<br />다하겠습니다.</div></div>");
		$(".topmenu > ul > li ul, .bg-topmenu-on").stop().slideDown();
		$(".topmenu").addClass("menuOpen");
	}else if ($("body").hasClass("smallbrowser")){
		$(".topmenu > ul > li").removeClass("on");
		$(".topmenu > ul > li.topmenu_"+Idx+"").addClass("on");
		//$(".toparea").append("<div class='bg-topmenu-on'><div class='menu_title5'>상공회의소는 회원기업의</div><h3>경제적. 사회적 지위향샹</h3><div class='menu_title5'>을 위해 최선의 노력을<br />다하겠습니다.</div></div>");
		$(".topmenu > ul > li ul").stop().slideDown();
		$(".topmenu").addClass("menuOpen");
	}else{
		return false;
	}
}

function topmenuClose(Idx){
	if (Idx>-1){
		if ($("body").hasClass("normal") || $("body").hasClass("smallbrowser")){
			$(".topmenu > ul > li.topmenu_"+Idx+"").removeClass("on");

			$(".topmenu > ul > li ul, .bg-topmenu-on").stop().slideUp();
			$(".topmenu").removeClass("menuOpen");
		}else{
			return false;
		}
	}else{
		$(".toparea .bg-topmenu-on").remove();
		$(".topmenu > ul > li ul").stop().slideUP();
		$(".topmenu").removeClass("menuOpen");
	}
}

if ($("body").hasClass("mobile") || $("body").hasClass("tablet")){
	if ($(".toparea").hasClass("mobileOpen") == false){
		$(".toparea .mobile-category > div").css("left", -(windowWidth+100)+"px").css("height",$(window).height()+"px");
	}
}

$(window).resize(function(){
	windowWidth = $(window).width();
	windowHeight = $(window).height();
	if ($("body").hasClass("mobile") || $("body").hasClass("tablet")){
		if ($(".toparea").hasClass("mobileOpen") == false){
			$(".toparea .mobile-category > div").css("left", -(windowWidth+100)+"px").css("height",$(window).height()+"px");
		}
	}
}).resize();


/* 모바일 왼쪽 메뉴 열림  */
function mobileMenuToggle(type){
	if (type == "open"){
		$(".toparea").addClass("mobileOpen");
		$(".toparea .mobile-category").css("width", $(window).width()+"px").css("height", $(window).height()+"px");
		if ($("body").hasClass("mobile")){
			$(".toparea .mobile-category > div > ul").css("min-height", $(window).height()-($(".mobile-category h2").height()+$(".mobile-category dl").height()+$(".mobile-category .email-reject").height()+40)+"px");
		}else if ($("body").hasClass("tablet")){
			$(".toparea .mobile-category > div > ul").css("min-height", $(window).height()-($(".mobile-category h2").height()+$(".mobile-category dl").height()+100)+"px");
		}
		$(".btn-category-holder").hide();
		$(".toparea .mobile-category > div").animate({left:"0"}, 500, function(){
			if ($("body").hasClass("device")){
				$("body").css("overflow-y", "hidden");
			}
		});
		$(".toparea").append("<div class='transparents-layer'></div>");
	}else{
		$(".toparea .mobile-category > div").animate({left:-(windowWidth+100)+"px"}, 500, function(){
			if ($("body").hasClass("device")){
				$("body").css("overflow-y", "visible");
			}
			if ($("body").hasClass("mobile")){
				$(".toparea .mobile-category").css("width", "38px").css("height", "38px");
			}else if ($("body").hasClass("tablet")){
				$(".toparea .mobile-category").css("width", "50px").css("height", "50px");
			}
			$(".toparea").removeClass("mobileOpen");
			$(".toparea .mobile-category > div > ul").css("min-height", "auto");
			$(".toparea .transparents-layer").remove();
			$(".btn-category-holder").show();
		});
	}
}

/* 모바일 왼쪽 메뉴 슬라이드 토글 함수  */
function slideToggle(Idx){
	if ($(".mobile-category > div > ul >li.topmenu_"+Idx+"").hasClass("slideOpen") == false){
		$(".mobile-category > div > ul >li.topmenu_"+Idx+" > ul").slideDown("slow");
		$(".mobile-category > div > ul >li.topmenu_"+Idx+"").addClass("slideOpen");
	}else{
		$(".mobile-category > div > ul >li.topmenu_"+Idx+" > ul").slideUp("slow");
		$(".mobile-category > div > ul >li.topmenu_"+Idx+"").removeClass("slideOpen");
	}
}

function skipNavi(skipName){
	if (skipName == "#topmenu"){
		$("#topmenu li.topmenu_1 > a").focus();
		topmenuOpen(1);
	}else if (skipName == "#maincontents"){
		$("#maincontents .event .board_tit_box h3").focus();
	}else if (skipName == "#contentsarea"){
		$("#contentsarea .contents_title h2").focus();
	}else if (skipName == "#leftarea"){
		$("#leftarea h2").focus();
	}
}


$(".leftmenu > li.on").prev().css("background","#f2f2f2").css("border-left","1px solid #aaa").css("border-right","1px solid #aaa");

var yOffset;
function modalView(modalName){
	yOffset = window.pageYOffset;
	$(".transparents-layer").remove();
	$("#wrap").append("<div class='transparents-layer' style='position:fixed'></div>");
	if ($("body").hasClass("mobile") == true){
		$(".modalpop .popupwrap."+modalName).css("top", (yOffset+200)+"px").css("left","50%").animate({opacity:1}, 500);
	}else{
		$(".modalpop .popupwrap."+modalName).addClass("active").css("top", "50%").css("margin-top", -($(".modalpop .popupwrap."+modalName).height()/2)+"px").animate({opacity:1}, 500);
	}
}

function modalHide(modalName){
	$(".modalpop .popupwrap."+modalName).animate({opacity:0}, 400, function(){
		$(".modalpop .popupwrap."+modalName).css("top", "-99999px").css("left","-99999px");
	})
	$(".transparents-layer").animate({opacity:0}, 400, function(){
		$(this).remove();
	});
	yOffset = 0;
}

$(".iradio").click(function(){
	if ($(this).hasClass("on") == false){
		$(this).parent().parent().find(".iradio").removeClass("on");
		$(this).parent().parent().find(".iradio input").attr("checked", false);
		$(this).addClass("on");
		$(this).find("input").attr("checked", true);
	}
});

function popOpen(target){
	_target = target
	$('#popup_wrap').addClass('on')
	_target.addClass('on')
}
function popClose(){
	$('#popup_wrap').removeClass('on')
	_target.removeClass('on')
}