<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page import="kr.apfs.local.common.util.StringUtil"%>
<%@ page import="kr.apfs.local.common.util.ConfigUtil"%>
<%
/*
	menuId = 5325 일 경우 하위 메뉴가 있어서, <title> 태그에 포함시켜 보여줘야 함
*/
String thisMenuId = request.getParameter("menuId");
pageContext.setAttribute("thisMenuId", thisMenuId) ;
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--[if lt IE 9]><script src="/js/html5.js"></script><![endif]-->
<title id="txtTitle">농업정책보험금융원 > ${fn:replace(MENU.menuNavi,'>',' > ')}<c:if test='${thisMenuId eq "5325"}'> > ${memlist.title}</c:if></title>  
<link rel="shortcut icon" href="/images/common/kr.ico" /><!--즐겨찾기 아이콘-->
<meta name="description" content="모태펀드, 크라우드펀딩, 농업정책보험, 재해재보험기금, 농림수산정책자금 검사, 농특회계, 관련법령 안내">
<meta name="keywords" content="농업정책보험금융원">
<link rel="shortcut icon" href="/images/common/favicon.ico" type="image/x-icon">
<link rel="apple-touch-icon" href="/images/common/apple_touch_icon.png">
<link rel="stylesheet" type="text/css" href="/css/default.css" />
<link rel="stylesheet" type="text/css" href="/css/common.css?ver=24.1" />
<link rel="stylesheet" type="text/css" href="/css/layout.css?ver=24.1" />
<link rel="stylesheet" type="text/css" href="/css/table.css?ver=24.1" />
<link rel="stylesheet" type="text/css" href="/css/gov30.css?ver=231108" />
<link rel="stylesheet" type="text/css" href="/css/sub.css?ver=24.1" />
<link rel="stylesheet" type="text/css" href="/css/main_business.css?ver=24.1" />
<link rel="stylesheet" type="text/css" href="/css/site_guide.css?ver=24.1" />
<link rel="stylesheet" type="text/css" href="/css/modal.css" />
<link rel="stylesheet" type="text/css" href="/css/back/popup.css" />
<link rel="stylesheet" type="text/css" href="/css/about_apfs.css?ver=24.1" />
<link rel="stylesheet" type="text/css" href="/css/data.css" />
<link rel="stylesheet" type="text/css" href="/css/participation.css" />
<link rel="stylesheet" type="text/css" href="/assets/jqgrid/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="/assets/jqgrid/css/ui.jqgrid-bootstarp.css" />
<!-- <link rel="stylesheet" type="text/css" href="/css/main.css" /> -->


<!--[if lt IE 9]>
	<script src="/js/html5.js"></script>
<![endif]-->
<script src="/js/jquery-1.11.3.min.js"></script>
<script src="/js/apfs/common.js"></script>
<script src="/js/apfs/layout.js"></script> <!-- 20230419 신규추가 -->
<script src="/js/apfs/pzone.js?ver=24.1"></script>	<!-- 240216 신규추가 -->
<script src="/assets/jquery/jquery.form.js"></script>
<script src="/assets/jquery/jquery.popupoverlay.js"></script>
<script src="/js/jquery.bpopup.min.js"></script>
<script src="/assets/parsley/dist/parsley.js"></script>
<script src="/assets/parsley/dist/i18n/ko.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-113401964-1"></script>
<script>
	var boardId = "${param.boardId}";
	if (boardId == "20083") {		//	농식품전문 크라우드펀딩 > 지원사업 신청 리다이렉트
		location.replace("http://inveseum.apfs.kr/goal-cms/supportCrowdCoach/req4List.do");
	} else if (boardId == "20082") {		//	농림수산식품 모태펀드 > 컨설팅 지원사업 신청 리다이렉트
		location.replace("http://inveseum.apfs.kr/goal-cms/supportBeforeIntro.do");
	} else if (boardId == "20057") {		//	농림수산식품 모태펀드 > 상담신청 리다이렉트
		location.replace("http://inveseum.apfs.kr/goal-cms/fundCounsel/req1List.do");
	}


	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	
	gtag('config', 'UA-113401964-1');
</script>



		<script src="/assets/jqgrid/i18n/grid.locale-kr.js"></script>
		<script src="/assets/jqgrid/jquery.jqGrid.js"></script>
		<script src="/assets/jqgrid/jquery.jqGrid.ext.js"></script>
		<script src="/assets/jqgrid/jquery.loadJSON.js"></script>
		<script src="/assets/jqgrid/jquery.tablednd.js"></script>




		<script>
			//document.title = "${MENU.menuNm}" ;
			var mi = "${MENU.menuId}";
			var menulist = "181,90,91,92,93,5371";
			var getSubPG = true;
			var getSubCK = true;
	        	// ready
			$(document).ready(function(){

				if('${MENU.menuId}'!=''){
					getSubPG = false;
					$.ajax
					({
						type: "POST",
				          // url: "/front/common/naviSubmenuList.do",		이 주소로 안되어서 아래행의 주소로(차이가 없는데 왜 에러나는지 원)	2021.11.26
				           url: "/testNavi.do",
				           dataType: "json",
				           data: {
				           	topMenuId : "${MENU.topMenuId}",
				           	upMenuId : "${MENU.menuId}",
				           	siteId : "${SITE.siteId}"
				   		},
						  success:function(data){
							  if (menulist.indexOf("${MENU.topMenuId}")>-1){

							createNaviSubmenu(data.naviSubmenuList);
							getSubCK = false;
							  }
					      }
				   	   , error: function (request, status, error){	        
				           var msg = "ERROR : " + request.status + "<br>"
				           msg +=  + "내용 : " + request.responseText + "<br>" + error;
				   	   }
					});
				}else{
				}

			});

	        // mobile nav
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

			// full bg
			$(document).ready(function(){
				$('#mnav').css('min-height', $(document).height() - 0 );

				$("#lastItem").focusout( function(e) {		//	키보드로 이동 시, 주메뉴 팝업 닫기 - 2020.10.20
					$(".top2m").css("display", "none");	
				});
				
				
				$("#allMenuLastItem").focusout( function(e) {		//	키보드로 이동 시, 전체메뉴 팝업 닫기 - 2020.10.20		//	아래 함수와 연동
					e.preventDefault();
					closePopup()
				});

				//	Enter 키 입력 이벤트 감지	- Enter 키 입력해야 전체메뉴 펼침
				window.addEventListener("keydown", function(e) {
					if(event.keyCode == 13)
				     {
						if (document.activeElement.id == "hrefAllMenu") {
							e.preventDefault();
							$('#allmenu').bPopup();
							$("#allMenuItem1").focus();			//	첫 번째 요소로 포커스 이동
						}
				     }
				});
			});

			function closePopup(){
				$('#allmenu').removeAttr("tabindex");
				$('#allmenu').bPopup().close();
				$("#hiddenFocus").focus();
				document.location.href = "#container";
			}


			function getSubmenu(){
				getSubPG = false;
				$.ajax
				({
					type: "POST",
			           //url: "/front/common/naviSubmenuList.do",
			           url: "/testNavi.do",
			           dataType: 'json',
			           data: {
			           	topMenuId : "${MENU.topMenuId}",
			           	upMenuId : "${MENU.menuId}",
			           	siteId : "${SITE.siteId}"
			   		},
					  success:function(data){

						  if (menulist.indexOf("${MENU.topMenuId}")>-1){

						createNaviSubmenu(data.naviSubmenuList);
						getSubCK = false;
						  }
				      }
				});
			}


			function createNaviSubmenu(list){
				var mstr = "";
				$(".leftmenu").html("");
				var menu;
				var cmenu;
				var premenu;
				var url ='';
				for(var i =0; i < list.length;i++){
					menu = list[i];
					cmenu = list[i+1];
					if (i>0){premenu=list[i-1];}
					var j=0;
					if(menu.navi.indexOf('${MENU.topMenuId}/')>-1){
						j++;
						if(menu.lvl==2){
							if(menu.lvl<premenu.lvl) mstr += '</ul>';
							if(j>1) mstr += '</li>';
							mstr += '<li>';

								if(menu.subCnt>0){
									mstr += '    <a href="#none" onclick="return false;"';
									(menu.navi.indexOf(mi)>-1 || menu.menuId=='${MENU.upMenuId}')?mstr +=' class="selected"':mstr +='';
									mstr += '>'+menu.menuNm+'</a> ';
								}else{
									mstr += '    <a href="javascript:goPage(\''+menu.menuId+'\',\'\',\'\');" title="'+menu.menuNm+'"';
									(menu.navi.indexOf(mi)>-1 || menu.menuId=='${MENU.upMenuId}')?mstr +=' class="selected"':mstr +='';
									mstr += '>'+menu.menuNm.replace('농림수산식품모태펀드 온라인사업설명회(IR)','농림수산식품모태펀드<br> 온라인사업설명회(IR)').replace('농림수산식품모태펀드 상담신청','농림수산식품모태펀드<br> 상담신청').replace('농림수산정책자금 부당사용 신고센터','농림수산정책자금<br> 부당사용 신고센터')+'</a>';
								}
						}
						if(menu.lvl==3){
							var openSub = '';
							if(menu.upMenuId=='${MENU.upMenuId}'){openSub = ' style="display:block"';}
							if(menu.lvl>premenu.lvl) mstr += '<ul class="lnb_2depth"'+openSub+'>';

							mstr += '<li';
							(menu.navi.indexOf(mi)>-1)?mstr +=' class="selected">':mstr +='>';
							mstr += '	<a href="javascript:goPage(\''+menu.menuId+'\',\'\',\'\');"';
							if(menu.menuId=='${MENU.menuId}'){mstr += ' class="selected"';}
							if (menu.menuId == '5466') {
								mstr += ' title="농림수산정책자금 검사사례집 pdf파일 새창" class="nongPdf"'; 
							} else {
								mstr += ' title="'+menu.menuNm+' 바로가기"';
							}
							mstr += '>'+menu.menuNm+'</a>';
							mstr += '</li>';
							if(menu.menuId=='5357'){
								mstr += '<div class="lnb_3depth"><dl>';
								mstr += '    <dt>-</dt><dd><a href="/front/board/boardContentsListPage.do?boardId=20059&amp;menuId=5357" title="농업정책자금 페이지로 이동">농업정책자금</a></dd>';
								mstr += '    <dt>-</dt><dd><a href="/front/board/boardContentsListPage.do?boardId=20064&amp;menuId=5357" title="수산정책자금 페이지로 이동">수산정책자금</a></dd>';
								mstr += '    <dt>-</dt><dd><a href="/front/board/boardContentsListPage.do?boardId=20065&amp;menuId=5357" title="임업정책자금 페이지로 이동">임업정책자금</a></dd>';
								mstr += '    <dt>-</dt><dd><a href="/front/board/boardContentsListPage.do?boardId=20066&amp;menuId=5357" title="대손보전 페이지로 이동">대손보전</a></dd>';
								mstr += '</dl></div>';
							}
						}
					}
				}
				mstr += '</li>';
				$(".leftmenu").html(mstr);


				// LNB sub menu slide Start
			    $(".lnb_2depth").siblings("a").addClass("ico_ext");
			    $(".lnb_2depth li a.selected").parent().parent(".lnb_2depth").css({"display":"block"});
			    $(".lnb_2depth li a.selected").parent("li").parent().siblings("a").addClass("selected");
			    $(".lnb li a.ico_ext").attr("title","하위메뉴 펼치기");		/*23년 웹접근성*/
			    $(".lnb li a.selected").attr("title","선택됨");
			    if($(".lnb li a").hasClass('selected ico_ext') == true){	
			    	$(".lnb li a.selected").attr("title","하위메뉴 접기");		
			    }
			    $(".lnb_2depth li a.selected").attr("title","선택됨");
			    $(".lnb li a").click(function(){
			        if($(this).siblings(".lnb_2depth").css("display") == "none"){
			            $(this).siblings(".lnb_2depth").stop().slideDown(300);
			            $(this).addClass("selected");
			            $(this).attr("title","하위메뉴 접기");		/*23년 웹접근성*/
// 			            $(".lnb_2depth li a.selected").attr("title","선택됨");
			        }else{
			            $(this).siblings(".lnb_2depth").stop().slideUp(300);
			            $(this).removeClass("selected");
			            $(this).removeAttr("title");		/*23년 웹접근성*/
			            $(this).attr("title","하위메뉴 펼치기");
// 			            $(".lnb_2depth li a").removeAttr("title");
			        }
			    });
			    
			    $(".lnb_2depth li a").click(function(){			//2024 웹 접근성
			        if($(this).hasClass("selected") != true){	//2024 웹 접근성
			        	$(this).addClass("selected");			//2024 웹 접근성
				    	if($(this).hasClass("nongPdf") == true){
				    		$(this).removeClass("selected");
				    		$(this).removeAttr("title");
				    		$(this).attr("title","농림수산정책자금 검사사례집 pdf파일 새창");
				    	}else{
				    		$(this).attr("title","선택됨");			//2024 웹 접근성
				    	}
			        }else{										//2024 웹 접근성
			            $(this).removeClass("selected");		//2024 웹 접근성
			            $(this).removeAttr("title");			//2024 웹 접근성
			        }
			    });												//2024 웹 접근성
			    
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

			function menuBlur(){
					$(".sub_menu").css("display","none");
					$(".nav_bg").css("display","none");
			}

	    </script>

	</head>

<body>

<div class="skip_nav" id="skip_nav">
    <ul>
    	<li><a href="#gnb">주메뉴 바로가기</a></li>
        <li><a href="#containerContent">본문 바로가기</a></li>
    </ul>
</div>




<div id="wrap_main">		<!-- 20220928 김동민 대리 웹 품질진단 -->
	<tiles:insertAttribute name="header"/>
	<tiles:insertAttribute name="left"/>
	<tiles:insertAttribute name="body"/>
	<tiles:insertAttribute name="footer"/>
</div>	<!-- 23년 웹품질진단 /div를 제자리로 돌려놓음 -->


<%-- <c:import url = "/WEB-INF/views/front/user/inc/allMenu.jsp"/> --%>

	<script>
		$(function() {

			//$(".tab_style ul li:eq(0) a").addClass("active");
			//$(".tab_style ul li:eq(0) a").css("color", "#fff")

			$(".tab_style ul li a").click(function() {		// 탭1구역 : 정보공개 > 정보공개 안내
				$(".tab_style ul li a").removeClass("active").removeAttr("title", "");
				$(this).addClass("active");
				$(this).attr("title", "선택됨");								//	웹 품질 진단 조치 - 2022.02.22				
				$(".tab_style ul li a").css("color", "#666");
				$(this).css("color", "#fff")
				tabno = $(".tab_style ul li a").index($(this)) + 1;
				for (i = 1; i < 9; i++) {
					$("#daopen_content_" + i).hide()
				}
				$("#daopen_content_" + tabno).show()
			})

		})
	</script>

	<script>
		$(function() {

			//$(".tab_style ul li:eq(0) a").addClass("active");
			//$(".tab_style ul li:eq(0) a").css("color", "#fff")

			$(".tab_style ul li a").click(function() {		// 탭2구역 : 
				$(".tab_style ul li a").removeClass("active").removeAttr("title", "");
				$(this).addClass("active");
				$(this).attr("title", "선택됨");								//	웹 품질 진단 조치 - 2022.02.22				
				$(".tab_style ul li a").css("color", "#666");
				$(this).css("color", "#fff")
				tabno = $(".tab_style ul li a").index($(this)) + 1;
				for (i = 1; i < 9; i++) {
					$("#history_content_" + i).hide()
				}
				$("#history_content_" + tabno).show()
			})

		})
	</script>

	<script>
		$(function() {

			//$(".tab_style2 ul li:eq(0) a").addClass("active");
			//$(".tab_style2 ul li:eq(0) a").css("color", "#369bc3")

			$(".tab_style2 ul li a").click(function() {		// 탭3구역 : 
				$(".tab_style2 ul li a").removeClass("active").removeAttr("title", "");
				$(this).addClass("active");
				$(this).attr("title", "선택됨");								//	웹 품질 진단 조치 - 2022.02.22				
				$(".tab_style2 ul li a").css("color", "#666");
				$(this).css("color", "#369bc3")
				tabno = $(".tab_style2 ul li a").index($(this)) + 1;
				for (i = 1; i < 9; i++) {
					$("#history_content_" + i).hide()
				}
				$("#history_content_" + tabno).show()
			})

		})
	</script>

	<script>
		$(function() {

			//$(".tab_style ul li:eq(0) a").addClass("active");
			//$(".tab_style ul li:eq(0) a").css("color", "#369bc3")

			$(".tab_style ul li a").click(function() {		// 탭4구역 : 
				$(".tab_style ul li a").removeClass("active").removeAttr("title", "");
				$(this).addClass("active");
				$(this).attr("title", "선택됨");								//	웹 품질 진단 조치 - 2022.02.22				
				$(".tab_style ul li a").css("color", "#666");
				$(this).css("color", "#369bc3")
				tabno = $(".tab_style ul li a").index($(this)) + 1;
				for (i = 1; i < 9; i++) {
					$("#aapfs_tcont_" + i).hide()
				}
				$("#aapfs_tcont_" + tabno).show()
			})

		})
	</script>

	<script>
		$(function() {

			$(".tab_style ul li a").click(function() {		// 탭5구역 : 
console.log("탭5구역");				
				$(".tab_style ul li a").removeClass("active").removeAttr("title", "");
				$(this).addClass("active");
				$(this).attr("title", "선택됨");								//	웹 품질 진단 조치 - 2022.02.22				
				$(".tab_style ul li a").css("color", "#666");				
				$(this).css("color", "#369bc3")   //	클릭이 일어난 <a> 태그
				tabno = $(".tab_style ul li a").index($(this)) + 1;
				for (i = 1; i < 17; i++) {
					$("#pfarm_content_" + i).hide()
				}
				$("#pfarm_content_" + tabno).show()
			})

		})
	</script>
	
	<script>
		$(function() {

			//$(".tab_style3 ul li:eq(0) a").addClass("active");
			//$(".tab_style3 ul li:eq(0) a").css("color", "#369bc3")
			$(".tab_style3 ul li a.active").attr("title", "선택됨");	//2024 웹 접근성
			
			$(".tab_style3 ul li a").click(function() {		// 탭6구역 : 
				$(".tab_style3 ul li a").removeClass("active").removeAttr("title", "");
				$(this).addClass("active");
				$(this).attr("title", "선택됨");								//	웹 품질 진단 조치 - 2022.02.22				
				$(".tab_style3 ul li a").css("color", "#666");
				$(this).css("color", "#369bc3")
				tabno = $(".tab_style3 ul li a").index($(this)) + 1;
				for (i = 1; i < 9; i++) {
					$("#history_content_" + i).hide()
				}
				$("#history_content_" + tabno).show()
			})

		})
	</script>
	
	<script>
		$(function() {

			//$(".tab_style3 ul li:eq(0) a").addClass("active");
			//$(".tab_style3 ul li:eq(0) a").css("color", "#369bc3")
			$(".tab_style3 ul li a.active").attr("title", "선택됨");	//2024 웹 접근성
			
			$(".tab_style3 ul li a").click(function() {		// 탭6구역 :
				$(".tab_style3 ul li a").removeClass("active").removeAttr("title", "");
				$(this).addClass("active");
				$(this).attr("title", "선택됨");								//	웹 품질 진단 조치 - 2022.02.22				
				$(".tab_style3 ul li a").css("color", "#666");
				$(this).css("color", "#369bc3")
				tabno = $(".tab_style3 ul li a").index($(this)) + 1;
				for (i = 1; i < 17; i++) {
					$("#pfarm_content_" + i).hide()
				}
				$("#pfarm_content_" + tabno).show()
			})

		})
		
	</script>





</body>
</html>