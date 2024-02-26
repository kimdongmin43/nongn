<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@page import="kr.apfs.local.common.util.StringUtil"%>
<%@page import="kr.apfs.local.common.util.ConfigUtil"%>
<%!
    public static String cutStr(String str,int cutByte)
    {
      byte [] strByte = str.getBytes();
      if( strByte.length < cutByte )
        return str;
      int cnt = 0;
      for( int i = 0; i < cutByte; i++ )
      {
         if( strByte[i] < 0 )
         cnt++;
      }

     String r_str;
     if(cnt%2==0) r_str = new String(strByte, 0, cutByte );
     else r_str = new String(strByte, 0, cutByte + 1 );

     return r_str;
    }
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--[if lt IE 9]><script src="/js/html5.js"></script><![endif]-->
<title>농업정책보험금융원</title>
<link rel="shortcut icon" href="/images/common/kr.ico" /><!--즐겨찾기 아이콘-->
<meta name="description" content="모태펀드, 크라우드펀딩, 농업정책보험, 재해재보험기금, 농림수산정책자금 검사, 농특회계, 관련법령 안내">
<meta name="keywords" content="농업정책보험금융원">
<link rel="stylesheet" type="text/css" href="/css/default.css" />
<link rel="stylesheet" type="text/css" href="/css/common.css" />
<link rel="stylesheet" type="text/css" href="/css/layout.css" />
<link rel="stylesheet" type="text/css" href="/css/main.css" />
<script src="/js/jquery-1.11.3.min.js"></script>
<script src="/js/apfs/common.js"></script>
<script src="/js/apfs/pzone.js"></script>
<script src="/js/jquery.bpopup.min.js"></script>

</head>

<body>
<!-- skipNav -->
<div class="skip_nav" id="skip_nav">
    <ul>
    	<li><a href="#gnb">메뉴 바로가기</a></li>
        <li><a href="#containerContent">본문 바로가기</a></li>
    </ul>
</div>
<!-- //skipNav -->

<!--warp-->
<div id="warp">
	<!-- header -->
	<header id="header">
    	<div class="header_inner">
        	<h1><img src="/images/common/logo.png" alt="농업정책보험금융원" /></h1>
            <div class="search_box">
            	<form action="" method="get">
                <dl>

                	<dd><input name="total_searchkey" title="검색박스" class="input_search" type="text" value=""></dd>
                    <dt><input type="image" class="search_btn" alt="검색하기" src="/images/common/search_btn.png" border="0"></dt>

                </dl>
                </form>
            </div>
            <div class="topUtil">
            	<ul>
                	<li><a href="/front/user/main.do" title="메인으로 이동">HOME</a></li>
                </ul>
            </div>
            <button class="mobile_btn_outer open_mn">
                <span class="hide">모바일 메뉴 열기</span>
                <span class="mobile_btn"></span>
            </button>

        </div>

        <nav>
            <h2 class="skip">주메뉴</h2>
            <div class="gnb_m_nav"><button type="button" class="open">주메뉴 열기</button></div>
            <div class="gnb_close"><button type="button" >주메뉴 닫기</button></div>
            <div class="mask"></div>
            <div id="gnb">
                <div class="gnb_wrap">
                    <ul class="topmenu clearfix">

                    </ul>
                    <div class="allmenu_btn">
                        <a href="#;" title="전체메뉴로 이동"><img src="/images/common/icon_sitemap.png" alt="전체메뉴" id="popupButton1"></a>
                    </div>

                </div>
                <!--//wrap-->
            </div>
            <!--//gnb-->
        </nav>
    </header>
    <!-- //header -->

    <!--mobileNavi-->
    <div id="mobileNavi">
		<div>
			<nav class="side_menu" id="slide_menu">
				<h2>농업정책보험금융원</h2>
				<ul class="depth1">
				</ul>
			</nav>
			<!-- 안성맞춤아트홀일 경우 추가 하위 아이콘 적용 -->

		</div>
		<ul class="btn_wrap">
			<li><a href="#none" class="btn_pop_open">팝업열기</a></li>
			<li><a href="#none" class="close">메뉴 닫기</a></li>
		</ul>
	</div>
    <!--//mobileNavi-->
	<div id="mask_mn"></div>



	<!--container-->
    <div id="container">

        내용 입력

    </div>
    <!--//container-->

    <!--footer-->
    <div id="footer">
    	<!--footer_warp-->
    	<div class="footer_warp">
        	<!--fLink-->
        	<div class="fLink">
                <ul>
                	<li><a href="/front/contents/sub.do?contId=46&menuId=5372" title="개인정보처리방침">개인정보처리방침</a></li>
                    <!-- <li><a href="#none" title="">이용약관</a></li> -->
                    <li><a href="/front/contents/sub.do?contId=47&menuId=5373" title="이메일무단수집거부">이메일무단수집거부</a></li>
                    <li><a href="/front/contents/sub.do?contId=74&menuId=5344" title="찾아오시는길">찾아오시는길</a></li>
                </ul>
            </div>
            <!--//fLink-->

            <!--site_url_area-->
            <div class="site_url_area">
                <div class="site_url">
                    <button class="title" type="button" title="펼치기">유관기관 바로가기<span>+</span></button>
                    <ul class="select">
                    	<c:forEach  var="row" items="${BANNER}" varStatus="status">
						<c:if test="${row.sectionCd eq '7'}">
						<li><a href="${row.url}" target="${row.targetCd}" title="새창열림">${row.title}</a></li>
						</c:if>
						</c:forEach>
                    </ul>
                </div>
                <div class="site_url">
                    <button class="title" type="button" title="펼치기">관련사이트 바로가기<span>+</span></button>
                    <ul class="select">
                    	<c:forEach  var="row" items="${BANNER}" varStatus="status">
						<c:if test="${row.sectionCd eq '3'}">
						<li><a href="${row.url}" target="${row.targetCd}" title="새창열림">${row.title}</a></li>
						</c:if>
						</c:forEach>
                    </ul>
                </div>
                <div class="site_url">
                    <button class="title" type="button" title="펼치기">해외 사이트 바로가기<span>+</span></button>
                    <ul class="select">
                    	<c:forEach  var="row" items="${BANNER}" varStatus="status">
						<c:if test="${row.sectionCd eq '5'}">
						<li><a href="${row.url}" target="${row.targetCd}" title="새창열림">${row.title}</a></li>
						</c:if>
						</c:forEach>
                    </ul>
                </div>
                <script>
					(function(){
						var param = ".site_url";
						var btn = ".title";
						var obj = ".select";
						footersitelink(param,btn,obj);
					}());
				</script>
            </div>
            <!--//site_url_area-->

            <!--copy_wrap-->
            <div class="copy_wrap">
            	<address>
                	${footerInfopage.addr} <br />
                    ${footerInfopage.tel}<br>
                     webmaster:helpdesk@apfs.kr
                </address>
                <p class="copyright">Copyright ⓒ 농업정책보험금융원 All rights reserved.</p>
            </div>
            <!--//copy_wrap-->

        </div>
        <!--//footer_warp-->
    </div>
    <!--//footer-->

</div>
<!--//warp-->


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
	});
</script>
</body>
</html>
