$( function (){

	initMainPage();

});

var view_put = [0,0]; // : 팝업이 위치할곳
var layer_popup = function(type) {
var layerObj = document.getElementById("mnav");

	switch(type) {
		case "open":
		layerObj.style.top = view_put[0];
		layerObj.style.left = view_put[1];
		break;
		default:
		layerObj.style.top = "-10000px";
		layerObj.style.left = "-10000px";
		break;
	};

};

$(".slidebanner > ul").slick({
	slidesToShow: 5,
	slidesToScroll: 1,
	speed: 400,
	autoplay: true,
	autoplaySpeed:5000,
	arrows: true,
	dots:false,
	responsive: [{
      breakpoint: 768,
      settings: {
        slidesToShow: 6
      }
    },
    {
      breakpoint: 480,
      settings: {
        slidesToShow: 3
      }
    }]
});

$(".slick-pause").click(function(){
	if ($(".slidebanner").hasClass("pause") == false){
		$(".slidebanner > ul").slick('slickPause');
		$(".slidebanner").addClass("pause");
	}else{
		$(".slidebanner > ul").slick('slickPlay');
		$(".slidebanner").removeClass("pause");
	}
});

function initMainPage(){

	var mySlider = $('.bxslider').bxSlider({
		mode:'horizontal', //default : 'horizontal', options: 'horizontal', 'vertical', 'fade'
		speed:1000, //default:500 이미지변환 속도
		auto: true, //default:false 자동 시작
		captions: false, // 이미지의 title 속성이 노출된다.
		autoControls: false, //default:false 정지,시작 콘트롤 노출, css 수정이 필요
		controls : false,
		pagerCustom: '#bx-pager'
	});
	$( '#slide_prev' ).on( 'click', function () {
		mySlider.goToPrevSlide();  //이전 슬라이드 배너로 이동
		return false;              //<a>에 링크 차단
	} );
	$( '#slide_next' ).on( 'click', function () {
		mySlider.goToNextSlide();  //이전 슬라이드 배너로 이동
		return false;              //<a>에 링크 차단
	} );
	$( '.bx-start' ).on( 'click', function () {
		mySlider.startAuto();
		return false;
	} );
	$( '.bx-stop' ).on( 'click', function () {
		mySlider.stopAuto();
		return false;
	} );
	$(document).on('click','#bx-pager',function() {
		mySlider.stopAuto();
	    mySlider.startAuto();
	});
	$(".liMn").each(function(idx, obj){

		$(".Depth1_area").eq(idx).hide();
		// 토글버튼
		$(this).children("[name=aTag]").click(function(){
			if($(this).parent().attr("class").indexOf("on")){
				$(this).parent().attr("class","on liMn");
			}else{
				$(this).parent().attr("class","liMn");
			}
			$(this).next("ul").slideToggle();
		});
	});
	$('.gnb nav').on({
		mouseenter:function(){
			$(this).addClass('on');
			$('.gnb nav').append('<div class="nav_bg"><span></span></div>')
			$('.gnb div').show();
			$('html').css('overflow-x','hidden')
		},
		keydown:function(){
			$(this).addClass('on');
			$('.gnb nav').append('<div class="nav_bg"><span></span></div>')
			$('.gnb div').show();
			$('html').css('overflow-x','hidden')
		}
	});
	$('.gnb nav > ul > li > div').each(function(i, e){
		$(e).mouseenter(function(){
			$(this).prev().addClass('on');
			$(this).parent().siblings().children('a').removeClass('on');
		});
		$(e).prev().mouseleave(function(){
			$(this).removeClass('on');
		});
	});
	$('.gnb').mouseleave(function(){
		$('.gnb nav div').hide();
		$('.gnb nav a').removeClass('on');
			$('html').css('overflow-x','auto');
	});

	$('#mnav').css('min-height', $(document).height() - 0 );
}

function menuBlur(){

	$(".sub_menu").css("display","none");
	$(".nav_bg").css("display","none");
}

function showSubmenu(){
	if($("#NaviSubMenu").css("display") == "none")
		$("#NaviSubMenu").show();
	else
		$("#NaviSubMenu").hide();
}

function showSubMenu(idx){
	$("#submenu_"+idx).show();
}

function hideSubMenu(idx){
	$("#submenu_"+idx).hide();
}

function notiClose(num){
	$('#layerPop_'+num).hide();
	self.close();
}


//회원가입등 외부링크 연결
function goKocham(url) {
	//var url = "https://regist.korcham.net/join/finduser_id.jsp?loginUrl=aHR0cDovL3d3dy5rb3JjaGFtLm5ldC9tYWluL21lbWJlci9sb2dpbi5hc3A/bV9BY3Q9Y2VydGlmaV9GYWxzZTA2";
	window.open(url, "srchId", "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=445,height=652");
}


//팝업관련
function loadNotiPop(){
	$.ajax({
		type: "POST",
		url: "/front/popnoti/popnotiList.do",
		dataType: 'json',
		success:function(data){
			makeNotiPop(data.list, data.fileList);
		}
	});
}

function weekNotShow(id, num){
	setCookie(id , "done" , 1);
	notiClose(num);
}
var htmlArr = [];
function makeNotiPop(data, file){
	var html = "";
	var cnt = 0;
	var file_cnt = 0;
	var popNoti = null;

	if(data != ""){
		$.each(data,function(key,obj){

			if (getCookie(obj.notiId) != "done"){

				html = "";
				html += '<div id="layerPop_'+cnt+'" style="position:absolute; top:0px; left:0px; width: '+obj.width+'px; height: '+obj.height+'px;z-index:1100; border:1px solid #dedede; background-color:#fff;" >';
				html += '	<div id="pop_header" >';
				html += '		<header>';
				html += '			<h3 class="pop_title">'+obj.title+'</h3>';

				html += '		</header>';
				html += '	</div>';
				html += '	<div id="pop_container" style="background-color: #ffffff;">';
				html += '	<article>';
				html += '		<div class="pop_content_area">';
				html += '			<div id="pop_content" style="overflow:auto;">'+obj.contents+'</div>';
				html += '		</div>';
				if(file != undefined){
					$.each(file,function(key1,obj1){
						html += '		<div class="file_area">';
						if(obj.attachId == obj1.attachId ){
							file_cnt++;
							html += '			<p> 첨부파일 #'+file_cnt+' : <a href="'+obj1.filePath+'" target="_blank">'+obj1.originFileNm+'</a></p>';
						}
						html += '		</div>';
					});
				}
				html += '		<div class="popbtn_today">';
				html += '			<input type="checkbox" id="chk" name="chk" value="Y" onClick="weekNotShow(\''+obj.notiId+'\',\''+cnt+'\')">&nbsp;&nbsp;<span>오늘하루 동안 보지 않기</span>';
				html += '		</div>';
				html += '	</article>';
				html += '	<a href="#none" class="pop_close" title="페이지 닫기" onClick="notiClose('+cnt+')">';
				html += '		<span>닫기</span>';
				html += '	</a>&nbsp;&nbsp;&nbsp;';
				html += '	</div>';
				html += '</div>';
				htmlArr[cnt] = html;
				popNoti = window.open('/html/notice.html','POPNOTI'+cnt,'top='+obj.top+',left='+obj.left+',width='+obj.width+',height='+obj.height);
				cnt++;
			}

		});

	}
}

