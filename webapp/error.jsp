<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
     String url = request.getRequestURL().toString();
     String frontYn = "Y";
     if(url.indexOf("eseoul") > -1) frontYn = "N";
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<title>${SITE.siteNm}</title>
		<link rel="stylesheet" type="text/css" href="../../../css/front/error.css" />
		<link rel="stylesheet" type="text/css" href="../../../css/front/nanumgothic.css" />
		<link rel="stylesheet" type="text/css" href="../../../css/front/default.css" />
		<link rel="stylesheet" type="text/css" href="../../../css/front/common.css" />
	</head>

	<body>
	<div id="wrap">
		<!-- error_area -->
		<div class="error_area">
			<!-- content start -->
			<div class="error_box">
				<h1 class="logo"><span>${SITE.siteNm}</span></h1>
				<strong class="title">잘못된 주소이거나 일시적으로 사용할 수 없습니다.</strong>
				<p class="txt">
					찾으시는 페이지의 주소가 잘못되었거나 현재 시스템의 문제상의 문제로 인해 사용하실 수 없는 상태입니다.<br />
					잠시 후 접속하여 주시거나 다시 한번 확인하여 주시기 바랍니다.
				</p>
				<% if(frontYn.equals("Y")){ %>
				<div class="button_area">
					<a href="/front/user/main.do" class="btn save" title="메인 바로가기">
						<span>메인 바로가기</span>
					</a>
					<a href="javascript:history.back(-1)" class="btn cancel" title="이전으로">
						<span>이전으로</span>
					</a>
				</div>
				<% }else{ %>
				<div class="button_area">
					<a href="/login.do" class="btn save" title="관리자 로그인페이지 바로가기">
						<span>관리자 로그인페이지 바로가기</span>
					</a>
					<a href="javascript:history.back(-1)" class="btn cancel" title="이전으로">
						<span>이전으로</span>
					</a>
				</div>
				<% } %>
			</div>
			<!--// content end -->
		</div>
		<!--// error_area -->
		<div class="error_footer_area">
			<strong class="title">${SITE.siteNm}</strong>
			<div class="error_address">
			<address>
				<ul>
					<li>(우)35235 대전광역시 서구 대덕대로 176번길 51 (둔산동) </li>
				</ul>
			</address>
			</div>
			<p class="error_copyright">© Seoul Metropolitan Government All rights reserved.</p>
		</div>
	</div>
	</body>
</html>