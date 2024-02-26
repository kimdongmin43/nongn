
//메뉴 스크립트

StringBuilder = function () {
    this._buffer = new Array();
}
StringBuilder.prototype =
    {
        // This method appends the string into an array 
        Append: function (text) {
            this._buffer[this._buffer.length] = text;
        },

        // This method does concatenation using JavaScript built-in function
        toString: function () {
            return this._buffer.join("");
        }
    };
//StringBuffer 배열 선언
function StringBuffer() {
    this.__strings__ = [];
}

//StringBuffer에 append 속성부여
StringBuffer.prototype.Append = function (str) {
    this.__strings__.push(str);
}

//StringBuffer에 toString 송성 부여
StringBuffer.prototype.toString = function (delimiter) {
    return this.__strings__.join(delimiter);
}


function createTopMenu(list){

	 var str = new StringBuilder();
     var upMenuId = "", subCnt =0, sizepos = "";
	
     
	
	var menu;
	var j=0;
	var url="";
	for(var i=0;i < list.length;i++){
		menu = list[i];
		sizepos = jsNvl(menu.width)+"/"
		+jsNvl(menu.height)+"/"
		+jsNvl(menu.left)+"/"
		+jsNvl(menu.top);

		if (menu.level==1){

			if(upMenuId != menu.upMenuId){
				if(i > 0){
					str.Append('    </ul>');
					str.Append('    </div></div>');
					str.Append('</li>');
				}
				str.Append('<li class="depth1">');

				str.Append('<a href="javascript:goTopMenu(\'');
				str.Append(menu.refUrl+'\',\'');
				str.Append(menu.menuId+'\',\'');
				str.Append(	menu.menuNm+'\',\'');
				str.Append(menu.refMenuId+'\',\'');
				str.Append(menu.targetCd+'\',\'');
				str.Append(sizepos+'\');" class="tit" title="');
				str.Append(menu.menuNm+'">');				
				str.Append(menu.menuNm+'</a>\n<div>');

					        if(menu.subCnt > 0){
					        	str.Append('    <div><ul class="clearfix"');
					if(menu.menuId==61){str.Append(' style="margin-left:350px"');}
					str.Append('>');
					subCnt = menu.subCnt;
					        }else{
					        	subCnt = 0;
					        }

					        j++;
			}
			upMenuId = menu.upMenuId;
		}
		if (menu.level==2){
			url = makeUrl(menu,sizepos);
			if(upMenuId != menu.upMenuId){
				str.Append( '      </ul></li>');
			}

			str.Append( '<li');
			if(menu.upMenuId==181 || menu.upMenuId==91 || menu.upMenuId==93){str.Append(' class="split_line"');}
			str.Append('><a href="'+url+'" title="');
			str.Append(menu.menuNm+'">');
			str.Append(menu.menuNm.replace('농림수산식품모태펀드 온라인사업설명회(IR)','농림수산식품모태펀드<br> 온라인사업설명회(IR)').replace('농림수산식품모태펀드 상담신청','농림수산식품모태펀드<br> 상담신청').replace('농림수산정책자금 부당사용 신고센터','농림수산정책자금<br> 부당사용 신고센터')+'</a>');
			 if(menu.subCnt > 0){
				 str.Append('       <ul');
					if(menu.menuId==5365){str.Append(' style="height:200px;"');}
					str.Append( '>');
					subCnt = menu.subCnt;
					        }else{
					        	str.Append('       </li>');
					        	subCnt = 0;
					        }
			upMenuId = menu.upMenuId;
		}
		if (menu.level==3){
			url = makeUrl(menu,sizepos);
			if(menu.menuId=="5323"){
				linkimg = '&nbsp;<img src="/images/common/icon_new_win.png" alt="전용관 바로가기 새창열림">';
			}
			else if(menu.menuId=="5466"){
				linkimg = '&nbsp;<img src="/images/common/icon_new_win.png" alt="2018검사사례집 새창열림">';
			}else{
				linkimg = '';
			}
			//linkimg = menu.menuId=='5323'?'&nbsp;<img src="/images/common/icon_new_win.png" alt="전용관 바로가기 새창열림">':'5466'?'&nbsp;<img src="/images/common/icon_new_win.png" alt="2018검사사례집 새창열림">':'';
			str.Append('<li><a href="'+url+'" title="');
			str.Append(menu.menuNm+'">');
			str.Append(menu.menuNm+linkimg+'</a></li>');
			upMenuId = menu.upMenuId;
		}

	}
	if (menu.level==3){
		str.Append('       </ul>');
		str.Append( '     </li>');
	}
	str.Append('</ul>');
	str.Append('    </div></div>');
	str.Append( '</li>');
	
	$(".topmenu").html(str);

	nav_menu();
}

function createMobileMenu(list){

	var str = "", url = "",upMenuId = "", subCnt =0, sizepos = "";
	var menu;
	var tempLevel = 0;
	var bgNum = 0;
	str += '<h2>농업정책보험금융원</h2>';
	str += '<ul class="depth1">';
	for(var i =0; i < list.length;i++){
		menu = list[i];

		url = "";

		if(menu.level=='1'){
			if(tempLevel=='3'){
				str += '				</ul>'
				str += '			</li>'
			}
			if(bgNum>0){
				str += '		</ul>'
				str += '</li>'
			}
			bgNum++;
			str += '\n<li>'
			str += '	<a href="#none">'+menu.menuNm+'</a>'
			str += '		<ul class="depth2">'
		}else if(menu.level=='2'){
			if(tempLevel>menu.level){
				str += '				</ul>'
				str += '			</li>'
			}
			if(tempLevel==menu.level){
				str += '			</li>'
			}
			if(menu.subCnt>0){
			str += '			<li><a href="#none">'
					+menu.menuNm+'</a>'
			}else{
			url = makeUrl(menu,sizepos);
			str += '			<li><a href="'+url+'" title="'
				+menu.menuNm+'">'
				+menu.menuNm+'</a>'
			}
		}else if(menu.level=='3'){
			if(tempLevel<menu.level){
				str += '				<ul class="depth3">'
			}
			url = makeUrl(menu,sizepos);
			str += '			<li><a href="'+url+'" title="'
				+menu.menuNm+'">'
				+menu.menuNm+'</a></li>'
		}
		tempLevel = menu.level;
	}
		str += '	</li>';
		str += '	</ul>';

	$("#slide_menu").html(str);

}

function makeUrl(menu,sizepos){
	var url ='';
	url = 'javascript:goSubMenu(\''
		+menu.refUrl+'\',\''
		+(menu.menuId == undefined ? menu.refMenuId : menu.menuId )+'\',\''
		+menu.targetCd+'\',\''
		+sizepos+'\');'
	return url;
}

function goTopMenu(url, topMenu, topMenuNm, subMenu, targetCd, sizepos){

	if(targetCd=="_blank"){
		window.open(url, targetCd);
		return;
	}

	goPage(subMenu,"",url);

}

function goSubMenu(url, subMenu, targetCd, sizepos){
	if(url == "undefined"){
		alert("준비중입니다.");
		return;
	}
	goPage(subMenu, '', url);
}

function goPage(menuId, param, linkurl){

	$.ajax
	({
		type: "POST",
           url: "/front/common/sessionPage.do",
           data:{
        	   menuId : menuId
           },
           dataType: 'json',
		success:function(data){

			  var url = linkurl == undefined || linkurl == ""? data.menu.refUrl:linkurl;

			  if(param != "") url += (url.indexOf("?") > -1?"&":"?")+param;
			 	goUrl(data.menu.targetCd , url, data.menu.width,data.menu.height, data.menu.left, data.menu.top,menuId);
		}
	});
}

function goUrl(target, url, width,height, xPos, yPos, menuId){
	
	if(menuId == "5466") target = "_blank";
	
	if(target == "_self"){
		if(url.indexOf("menuId") < 0){
			url += (url.indexOf("?") > -1 ?"&":"?") + 'menuId='+menuId;
		}
		document.location.href = url;
	}else if(target == "_blank"){
		window.open(url);
	}else if(target == "_popup"){
		openPosPopUp(url, "kochamPopup", width, height, xPos, yPos);
	}else{
		if(url.indexOf("menuId") < 0){
			url += (url.indexOf("?") > -1 ?"&":"?") + 'menuId='+menuId;
		}
		document.location.href = url;
	}
}
function goExternalUrl(target, url){

	if(target == "_self"){
		document.location.href = url;
	}else if(target == "_blank"){
		window.open(url);
	}else{
		consol.log("현재창 또는 새창열기 이외에는 지원되지 않습니다.");
		return;
	}
}

$(document).ready(function() {
	$("[id^='tab']").click(function(){
	    var num = $(this).attr('id');
	    type_list(num.replace('tab',''));
	});
	if (document.location.protocol == 'http:') {
        //document.location.href = document.location.href.replace('http:', 'https:');
    }
});
function type_list(type){
console.log("common.js type_list()" + type);		      

	$('.sections').hide();
	$("[id^='tab'] a").attr("class","").removeAttr("title");			//	웹 접근성 removeAttr 추가 - 2022.02.22
	//alert(type);
	$('#section'+type).show();
	$('#tab'+type+' a').attr("class","active").attr("title", "선택됨");			//	웹 접근성 attr 추가 - 2022.02.22
	//alert(type);
}




$.fn.rowspan = function(colIdx, isStats) {
	return this.each(function(){
	var that;
	$('tr', this).each(function(row) {
	$('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {

	if ($(this).html() == $(that).html()
	&& (!isStats
	|| isStats && $(this).prev().html() == $(that).prev().html()
	)
	) {
	rowspan = $(that).attr("rowspan") || 1;
	rowspan = Number(rowspan)+1;

	$(that).attr("rowspan",rowspan);

	// do your action for the colspan cell here
	$(this).hide();

	//$(this).re();
	// do your action for the old cell here

	} else {
	that = this;
	}

	// set the that if not already set
	that = (that == null) ? this : that;
	});
	});
	});
	};


	$.fn.colspan = function(rowIdx) {
		return this.each(function(){

		var that;
		$('tr', this).filter(":eq("+rowIdx+")").each(function(row) {
		$(this).find('th').filter(':visible').each(function(col) {
		if ($(this).html() == $(that).html()) {
		colspan = $(that).attr("colSpan") || 1;
		colspan = Number(colspan)+1;

		$(that).attr("colSpan",colspan);
		$(this).hide(); // .re();
		} else {
		that = this;
		}

		// set the that if not already set
		that = (that == null) ? this : that;

		});
		});
		});
		}

function ifmhe(i){
	//$('.ifmHeight').height();

	var iframeHeight=
	    (i).contentWindow.document.body.scrollHeight;
	//alert(iframeHeight);
	    (i).height=iframeHeight+20;

}


function resizeHeight(num){
	document.getElementById('IFFM').height=num+80;
}




function jsNvl(str) {
	var result = "";
	if (str == undefined || str == null || str == "null" || str == "NULL") {
		result = "";
	} else {
		result = str;
	}

	return result;
}


//iframe 높이 조절
function init(){
  var doc = document.getElementById("infodoc");
  doc.style.top=0;
  doc.style.left=0;
  pageheight = doc.offsetHeight;
  pagewidth = doc.offsetWidth;
  parent.resizeHeight(pageheight);

 }

//nav
function nav_menu(a){	//	이 파일의 createTopMenu(), 웹브라우저 로딩 완료 시 실행

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


//LNB 230808
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
			$('.news_area .more').hide();
			$('.news_area .tit a').removeClass('hover');
			$(this).addClass('hover').parent().next().show();
			$(this).addClass('hover').parent().next().next().show();
		});
		$('.news_area .tit a').eq(0).mouseover();
	});
	
	$('.news_area .tit a').on("touchstart", function() {
		$('.news_area .tit a').removeAttr("href");
	});
	$('.news_area .tit a').on("touchend", function(i, o) {
		$('.news_area .news_list').hide();
		$('.news_area .more').hide();
		$('.news_area .tit a').removeClass('hover');
		$(this).addClass('hover').parent().next().show();
		$(this).addClass('hover').parent().next().next().show();
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
			$(this).find('span').text('접기');
			$(this).addClass("ov");
			$(this).attr('title','접기');
		}else{
			obj.hide();
			btn.find('span').text('펼치기');
			btn.removeClass("ov");
			$(this).attr('title','펼치기');
		}

		event.preventDefault();
	});

}

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



//=================	2021.03.08   기기구분, 모바일 전화링크 기능 추가
function findOutDevice() {
	var filter = "win16|win32|win64|mac|macintel"; 

	if ( navigator.platform ) { 
		if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) {
			return "MO";
		} else {
			return "PC";
		}
	}	
}

function changeTelLink() {
	var strDevice = findOutDevice();

	cntTel = $("span[data-tel=telPC]").length;		//	name 속성 사용 불가 -> data-tel 로 변경
	cntMo = $("span[data-tel=telMO]").length;

	if ( (cntTel > 0) && (strDevice == "MO") ) 	 {	//	전화번호가 있으면 기기판별을 해서 해당 기기의 span을 display 한다
		for (var i = 0; i < cntTel; i++) {
			$("span[data-tel=telPC]").eq(i).css("display", "none");
		}
		for (var i = 0; i < cntMo; i++) {
			$("span[data-tel=telMO]").eq(i).css("display", "inline");
			$("span[data-tel=telMO]").eq(i).css("color", "#535353");
		}
	} else {
		for (var i = 0; i < cntTel; i++) {
			$("span[data-tel=telPC]").eq(i).css("display", "inline");
			$("span[data-tel=telPC]").eq(i).css("color", "#535353");
		}
		for (var i = 0; i < cntMo; i++) {
			$("span[data-tel=telMO]").eq(i).css("display", "none");
		}
	}
}