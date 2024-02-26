<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@page import="kr.apfs.local.common.util.StringUtil"%>
<%@page import="kr.apfs.local.common.util.ConfigUtil"%>
<% java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy.MM.dd");
	String now = formatter.format(new java.util.Date());
	String devServer = "";
	pageContext.setAttribute("now",now);
	pageContext.setAttribute("devServer",devServer);

%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta name="viewport" content="width=device-width, user-scalable=yes, target-densitydpi=medium-dpi" />
		<title>${siteRow.siteNm}</title>

		<link type="text/css" rel="stylesheet" href="/css/front/reset.css" />
		<link type="text/css" rel="stylesheet" href="/css/front/contents.css" />
		<link type="text/css" rel="stylesheet" href="/css/front/bootstrap.css" />
		<link type="text/css" rel="stylesheet" href="/css/front/reveal.css">

		<script src="/js/jquery-1.11.3.min.js"></script>
		<!--[if lt IE 9]><script src="/js/html5.js"></script><![endif]-->
	    <script src="/assets/bootstrap/js/bootstrap.js"></script>
	    <script src="/assets/parsley/dist/parsley.js"></script>
	    <script src="/assets/parsley/dist/i18n/ko.js"></script>
	    <script src="/assets/jquery-ui/ui/minified/jquery-ui.min.js"></script>
		<script src="/assets/jquery/jquery.form.js"></script>
		<script src="/assets/jquery/jquery.popupoverlay.js"></script>
	    <script src="/assets/jqgrid/i18n/grid.locale-kr.js"></script>
		<script src="/assets/jqgrid/jquery.jqGrid.js"></script>
		<script src="/assets/jqgrid/jquery.jqGrid.ext.js"></script>
		<script src="/assets/jqgrid/jquery.loadJSON.js"></script>
		<script src="/assets/jqgrid/jquery.tablednd.js"></script>

		<script src="/js/common.js"></script>
		<script src="/js/jquery.bpopup.min.js"></script>
		<script src="/js/jquery.bxslider.min.js"></script>
		<script src="/js/bootstrap.min.js" ></script>
		<script src="/js/slick.js"></script>
	</head>
	<body id="main"> <!-- 메인페이지에 body에 id값 있습니다 -->

		<dl class="skipnavi">
			<dt>메뉴 건너띄기</dt>
			<dd>
				<a href="javascript:skipNavi('#topmenu')">상단메뉴 바로가기</a>
				<a href="javascript:skipNavi('#maincontents')">메인 본문 바로가기</a>
			</dd>
		</dl>

		<div id="wrap">
			<!-- S: toparea -->
			<div class="toparea back_none">
				<div class="top_line3">
					<ul class="top_right3">
						<c:if test="${USER.userCd ge 999 }">
						<li>
							<span class="inpbox">
								<input type="text" id="s_siteNm" style="width:140px;border: 1px solid #969696; margin:3px;" placeholder="지역상공 찾기.." title="지역상공 찾기.." onkeyup="findSite(this.value);" />
								<input type="hidden" id="s_siteId"/>
								<input type="hidden" id="s_clientId"/>
								<input type="hidden" id="s_chamCd"/>
								<ul id="siteList" style="z-index: 999999; position:absolute;border: 1px solid #969696;background-color: #fff;list-style-type: none;display:none; width:140px; padding:5px;margin:-5px 0 0 3px;">
									<c:forEach  var="row" items="${SITE_LIST}" varStatus="status">
									<li>
										<a href="#none" onclick="setSite('${row.siteId}','${row.siteNm}','${row.clientId}','${row.chamCd}')">${row.siteNm}</a>
										<input type="hidden" id="siteId_${row.siteId }" name="selSiteId" value="${row.siteId }"/>
										<input type="hidden" id="siteNm_${row.siteNm }" name="selSiteNm" value="${row.siteNm }"/>
										<input type="hidden" id="clientId_${row.clientId }" name="selClientId" value="${row.clientId }"/>
										<input type="hidden" id="chamCd_${row.chamCd }" name="selChamCd" value="${row.chamCd }"/>
									</li>
									</c:forEach>
								</ul>
							</span>
						</li>
						</c:if>
						<li class="home"><a href="#none"><img src="/images/home2.png" alt="home" /></a></li>
						<c:choose>
						<c:when test="${MEMBER.memId eq null}">
						<li class="login"><a href="/front/user/login.do">로그인</a></li>
						<li class="join"><a href="/common/front/join.do">회원가입</a></li>
						</c:when>
						<c:otherwise>
						<li class="login"><a href="#none" onclick="logout();">로그아웃</a></li>
						</c:otherwise>
						</c:choose>
						<li class="sitemap"><a href="#none">사이트맵</a></li>
					</ul>
				</div>
				<!-- nav -->
				<!--  PC 메뉴 -->
				<div class="gnb_line">
				<div class="gnb3">
					<h1><a href="/" style="background:url('/images/logo/logo_top/${SITE.clientId}_top_logo.png') no-repeat 0 center;"><img src="/images/logo/logo_top/${SITE.clientId}_top_logo.png" alt="${SITE.siteNm}" border="0"/></a></h1>
					<div class="topmenu" id="topmenu">
					<div class="topmenu_bg"></div>
					<ul class="mobileoff">

					</ul>
				</div>
				</div>
				</div>
				<div class='bg-topmenu-on' style="display:none" onmouseover="topmenuOpen(5)" onmouseout="topmenuClose(5)">
					<div class='menu_title'>
						상공회의소는 회원기업의<h3>경제적·사회적 지위향상을</h3> 위해 최선의 노력을 다하겠습니다.
					</div>
				</div>
				<!-- // PC 메뉴 -->
				<!--  모바일 메뉴 -->
				<div class="mobile-category">
					<button type="button" class="btn-category-holder" onclick="mobileMenuToggle('open')">모바일 메뉴 열림</button>
					<div class="mobild_menu">
						<button type="button" class="btn btn-blue2" onclick="mobileMenuToggle('close')">닫기</button>
						<ul class="acc" id="acc">

						</ul>
					</div>
				</div>
				<!-- // 모바일 메뉴 -->
			</div>
			<!-- //E: toparea -->

			<!-- S: midarea -->
			<div class="midarea main3">
				<!-- S: maincontents -->
				<div class="maincontents main3">
					<div class="board_box board_box3" id="maincontents">
						<!-- mainBoardList1  -->
						<c:set var="mainMap" value="${mainMap}" scope="request"/>
						<c:set var="mainBoardList" value="${mainBoardList1}" scope="request"/>
						<c:set var="mainBoardContentsList" value="${mainBoardContentsList}" scope="request"/>
						<c:import url = "/WEB-INF/views/front/user/inc/mainSection.jsp"/>

						<!-- mainBoardList2  -->
						<c:set var="mainBoardList" value="${mainBoardList2}" scope="request"/>
						<c:import url = "/WEB-INF/views/front/user/inc/mainSection.jsp"/>

						<!-- 상단 -->
						<!-- mainBoardList5  -->
						<c:set var="mainBoardList" value="${mainBoardList5}" scope="request"/>
						<c:import url = "/WEB-INF/views/front/user/inc/mainSection.jsp"/>
					</div>
					<div class="contents_center">
						<!-- 메인 이미지  -->
						<c:set var="mainPhotoList" value="${mainPhotoList}" scope="request"/>
						<c:forEach  var="row" items="${mainPhotoList}" varStatus="status">
						<c:if test="${status.index eq 0 }">
						<img class="center_img" src="${devServer }${row.filePath}" alt="${row.title}" />
						</c:if>
						</c:forEach>
						<!-- 바로가기  -->
						<ul class="center_icon_box">
							<c:forEach  var="row" items="${mainBannerList}" varStatus="status">
								<c:set var="i" value="${i+1}" />
							<c:if test="${row.sectionCd eq '5'}">
							<li>
								<a href="${row.url}" target="${row.targetCd}" >
									<div class="center_icon bg${i}"  style="background: url(' ${devServer }${row.filePath}) center 0 no-repeat;"><span>${row.title}</span></div>
								</a>
							</li>
							</c:if>
							</c:forEach>

						</ul>
					</div>
					<div class="board_box board_box3" id="maincontents">
						<!-- mainBoardList3  -->
						<c:set var="mainBoardList" value="${mainBoardList3}" scope="request"/>
						<c:import url = "/WEB-INF/views/front/user/inc/mainSection.jsp"/>

						<!-- mainBoardList4  -->
						<c:set var="mainBoardList" value="${mainBoardList4}" scope="request"/>
						<c:import url = "/WEB-INF/views/front/user/inc/mainSection.jsp"/>

						<!-- 하단 -->
						<!-- mainBoardList6  -->
						<c:set var="mainBoardList" value="${mainBoardList6}" scope="request"/>
						<c:import url = "/WEB-INF/views/front/user/inc/mainSection.jsp"/>
					</div>
				</div>

			</div>
			<!-- //E: midarea -->
			<!--//E: maincontents -->
			<div class="relativesite2">
				<!--배너 슬라이드 -->
				<c:set var="mainBannerList" value="${mainBannerList}" scope="request"/>
				<c:import url = "/WEB-INF/views/front/user/inc/mainBanner.jsp"/>
			</div>
			<!-- S: bottomarea -->
			<c:set var="mainMap" value="${mainMap}" scope="request"/>
			<c:import url = "/WEB-INF/views/front/user/inc/mainBottom.jsp"/>
			<!-- //E: bottomarea -->
		</div>

	<script src="/js/common_ui.js"></script>
	<script src="/js/script.js"></script>
	<script src="/js/kcci/main.js"></script>

	<script>
	$(document).ready(function(){

		$.ajax({
			type: "POST",
           	url: "/front/user/homepageMenuList.do",
           	dataType: 'json',
			success:function(data){
				createTopMenu(data.topMenuList);
				createMobileMenu(data.topMenuList);
			}
		});

		// 팝업 불러오기
		loadNotiPop();

		//관련사이트
		$("#btnBanner").click(function(){

			var url = $("#linkBanner option:selected").val();
			var target = $("#linkBanner option:selected").data("target");

			if(url ==""){
				return;
			}

			goExternalUrl(target,url);

		});
		/* 일반 게시판 상위 탭메뉴 */
		$(".tab_type2").children("li").children("a").each(function(){

			$(this).click(function(){
					if($(this).closest("li").hasClass("active")){
						if($(this).closest("li").children(".more").attr("href").indexOf("http")<0){
							location.href = $(this).closest("li").children(".more").attr("href");
							return;
						}else{
							if($(this).data("toggle")=='tab'){
							window.open( $(this).closest("li").children(".more").attr("href"));
							return;
							}
						}
					}
			});

		});
		/* 경제지표, E-CONTENTS 하위 탭메뉴 */
		$(".tab_type1").children("li").each(function(){


			$(this).mouseover(function(){

				if($(this).hasClass("active")){

				}else{
					tab = $(this).children("a").data("href");
					$(this).closest("ul").children("li").removeClass("active");
					$(this).closest("div").children(".tab-content").children(".tab-pane").removeClass("active");
					$(this).closest("li").addClass("active");
					$(this).closest("div").children(".tab-content").children(tab).addClass("active");
				}

			});

		});
	});
	var parentAccordion=new TINY.accordion.slider("parentAccordion");
	</script>

<!-- 		<script src="/js/needpopup.min.js"></script>
		<script>
			needPopup.config.custom = {
				'removerPlace': 'outside',
				'closeOnOutside': false,
				onShow: function() {
					console.log('needPopup is shown');
				},
				onHide: function() {
					console.log('needPopup is hidden');
				}
			};
			needPopup.init();
		</script> -->
	</body>
</html>