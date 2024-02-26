<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@page import="kr.apfs.local.common.util.DateUtil"%>
<%@page import="kr.apfs.local.common.util.StringUtil"%>

	<div id="wrap">
		<!-- skip_nav -->
		<div id="skip_nav" tabIndex="0" id="skip_nav">
			<a href="#nav">메인메뉴 바로가기</a>
			<a href="#content">본문내용 바로가기</a>
		</div>
		<!-- //skip -->

		<!-- header -->
		<div id="header">
		<header>
			<!-- topheader_area -->
			<div class="topheader_area">

				<div class="logo_area">
					<h1 class="home_logo">
						<c:set var="clientId" value="${s_clientId == null or s_clientId == ''?SITE.clientId:s_clientId }" />
						<c:set var="siteNm" value="${s_siteNm == null or s_siteNm == ''?SITE.siteNm:s_siteNm }" />
						<a href="#none" onClick="goMain()" ><img src="/images/common/logo.png" alt="${siteNm}" border="0"/></a>
					</h1>
					<span class="logotitle">${Logo.backsub_title}</span>
				</div>
				<!-- hsection -->

				<div class="hsection_area">
					<c:if test="${USER.userCd ge 999 }">
            <div style="float: left;">
               <span class="inpbox">
                  <input type="text" id="s_siteNm" style="width:140px;border: 1px solid #969696; margin:3px;" placeholder="사이트 찾기.." title="사이트 찾기.." onkeyup="findSite(this.value);" />
                  <input type="hidden" id="s_siteId"/>
                  <input type="hidden" id="s_clientId"/>
                  <input type="hidden" id="s_chamCd"/>
                  <input type="hidden" id="test"/>
                  <ul id="s_siteList" style="z-index: 999999; position: absolute; border: 1px solid rgb(150, 150, 150); background-color: rgb(255, 255, 255); list-style-type: none; width: 120px; padding: 5px; display: none;">

                     <li style="display: list-item;">
                        <a href="#none" onclick="setSite('3','창원상공회의소','changwon','B074')">국문</a>
                        <input type="hidden" name="s_selSiteId" value="3">
                        <input type="hidden" name="s_selSiteNm" value="국문페이지">
                        <input type="hidden" name="s_selClientId" value="apfs">
                        <input type="hidden" name="s_selChamCd" value="B005">
                     </li>
                     <li style="display: list-item;">
                        <a href="#none" onclick="setSite('5','창원상공회의소','changwon','B074')">영문</a>
                        <input type="hidden" name="s_selSiteId" value="5">
                        <input type="hidden" name="s_selSiteNm" value="영문페이지">
                        <input type="hidden" name="s_selClientId" value="eng">
                        <input type="hidden" name="s_selChamCd" value="B006">
                     </li>



                  </ul>
               </span>
            </div>
            </c:if>
					<a href="/j_spring_security_logout" class="btn logout" title="로그아웃 하기">
						<span>로그아웃</span>
					</a>
					<a href="/" class="btn homepage" title="홈페이지로 페이지 이동"  target="_blank">
						<span>홈페이지 바로가기</span>
					</a>

				</div>
				<!--// hsection -->
				<div class="login_area" style="float:right; margin:18px 10px 0 0 ; display:none"><span>${USER.loginId}</span></div>
			</div>

			<!--// topheader_area -->
			<!-- gnb_menu -->
			<div id="nav">
			<nav>
				<ul id="TopMenu" class="menu">

				</ul>
			</nav>
			</div>
			<!--// gnb_menu -->
		</header>
		</div>
		<!-- //header -->
		<!-- container -->
		<div id="container">
		<article>
			<!-- left_area -->
			<div class="left_area" id="MenuArea" style="display:<c:if test="${MENU.topMenuId eq '' }">none</c:if>">
				<!-- left_info_area -->
				<div class="left_info_area">
					<ul class="left_info">
						<li>
							<strong class="name">${USER.userNm}</strong>님 반갑습니다.
						</li>
						<li><%=DateUtil.currentDateStr() %></li>
					<!-- 	<li>오늘의 방문자 수 : <em class="number">${s_todayconn_cnt}</em></li> -->
					</ul>
				</div>
				<!--// left_info_area -->
				<!-- lnb_area -->
				<div class="lnb_area">
					<h2 id="topMenuNm" class="title">${MENU.topMenuNm}</h2>
					<ul id="subMenu" class="lnb">

					 </ul>
				</div>
				<!--// lnb_area -->
			</div>
			<!--// left_area -->
			<!-- lnb_split -->
			<div id="lnb_split"  style="display:<c:if test="${MENU.topMenuId eq '' }">none</c:if>">
			</div>
			<!--// lnb_split -->
			<!-- content_area -->
			<div class="content_area">
				<!-- location -->
				<div class="location">
					<ul>
						<li>
						<c:out value="${g:toWEB_BOX(MENU.menuNavi)}" escapeXml="false"/>
						</li>
					</ul>
				</div>
				<!--//  location -->