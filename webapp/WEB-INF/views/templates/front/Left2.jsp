<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

	<!-- S: midarea -->
	<div id="sub_midarea">
		<!-- S: maincontents -->
		<div class="nav">
			<div class="nav_box">
				<a href="/"><img src="/images/nav_home.png" alt="home" /></a>
				<c:choose>
					<c:when test="${leftNm eq '회원가입'}">
					<a href="#none">회원가입</a>
					</c:when>
					<c:when test="${leftNm eq '로그인'}">
					<a href="#none">로그인</a>
					</c:when>
					<c:when test="${leftNm eq '사이트맵'}">
					<a href="#none">사이트맵</a>
					</c:when>
				</c:choose>
			</div>
		</div>
		<div class="sub_contents">
			<!-- S: leftarea -->
			<div class="leftarea page-sidebar navbar-collapse collapse">
				<!--<h2 tabindex="0"><span>${MENU.menuNm}</span></h2>-->
				<h2><span>${leftNm}</span></h2>
				<ul class="leftmenu2 topnav">
					<c:choose>
					<c:when test="${leftNm eq '회원가입'}">
					<li><a href="/front/user/login.do">로그인</a></li>
					<li class="active"><a href="/common/front/join.do">회원가입</a></li>
					</c:when>
					<c:when test="${leftNm eq '로그인'}">
					<li class="active"><a href="/front/user/login.do">로그인</a></li>
					<li><a href="/common/front/join.do">회원가입</a></li>
					</c:when>
					<c:when test="${leftNm eq '사이트맵'}">
					<li class="active"><a href="/common/front/siteMap.do">사이트맵</a></li>
					</c:when>
				</c:choose>
				</ul>
			</div>
			<!--//E: leftarea -->
			<!--//S: contentsarea -->
			<div class="contentsarea" id="contentsarea">