<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.*"%>
<%
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy.MM.dd");
String now = formatter.format(new java.util.Date());
String devServer = "";
pageContext.setAttribute("now",now);
pageContext.setAttribute("devServer",devServer);
%>
<script>

</script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="/css/needpopup.min.css">

	  <!-- Styles just for demo -->
		<style>
			.wrapper {
				padding: 40px 60px;
			}

			a[data-needpopup-show] {
				display: inline-block;
				margin: 0 10px 10px 0;
				padding: 10px 15px;
				font-weight: bold;
				letter-spacing: 1px;
				text-decoration: none;
	/* 			color: #fff;
				background: #7B5207; */
/* 			  border-radius: 3px;
			  box-shadow: 0 1px 1px 1px rgba(0, 0, 0, 0.2); */
			}

/* 			p {
				font-size: 1.2em;
				line-height: 1.4;
				color: #343638;
				margin: 20px 0;
			} */

			.needpopup {
			  border-radius: 6px;
			  box-shadow: 0 1px 5px 1px rgba(0, 0, 0, 1);
			}

			.needpopup p {
				margin: 0;
			}
			.needpopup p + p {
				margin-top: 10px;
			}
		</style>

				<div class="bottomarea">
					<c:if test="${mainMap.mainCd!='C' }">
					<div class="bottom_top">

					</div>
					</c:if>
					<div class="innerbox">
						<h1><img src="/images/logo/logo_bottom/${SITE.clientId}_footer_logo.png" alt="${SITE.siteNm}" border="0"/></h1>
						<div class="address_box">
							<ul class="footer_menu">
								<li >
								<a href="javascript:window.open('http://www.korcham.net/nCham/Service/Private/lhtml/PersonalInfo_popup.html','개인정보처리방침','width=910, height=700, menubar=no, toolbar=no, location=no, status=no, scrollbars=yes, resizable=no'); void(0)" style="color:#0033CC;">개인정보처리방침</a></li>
								<li><a href="${SITE.menuLocation }">찾아오시는길</a></li>
						<!-- 		<li class="none" ><a href="#none" data-needpopup-show="#custom-popup">이메일무단추출금지</a></li> -->

							</ul>
							<p class="address">${mainMap.addr}</p>
							<p class="copyright">대표전화 : ${mainMap.tel}   문의 : ${mainMap.email}</p>
							<p class="address"> Copyright (c) 2017 ${SITE.clientId}, All Right Reserved.</p>
						</div>
						<div class="select_box" id="linkBanner">
							<select title="관련사이트">
								<option value="">관련사이트</option>
								<c:forEach  var="row" items="${BANNER}" varStatus="status">
								<c:if test="${row.sectionCd eq '3'}">
								<option value="${row.url}" data-target="${row.targetCd}">${row.title}</option>
								</c:if>
								</c:forEach>
							</select>
							<button id="btnBanner">이동</button>
						</div>
					</div>
				</div>



<!-- <div id='custom-popup' class="needpopup" data-needpopup-options="custom">
	<p>
	<div class="basic_txt">
		<p style="text-align: center;">
			<span style="font-family: 맑은 고딕;"><b>&nbsp;<span
					style="color: rgb(0, 118, 200); font-size: 18pt;">이메일무단수집거부</span></b></span>
		</p>
		<p style="text-align: center;">
			<span style="font-family: 맑은 고딕;"><b><span
					style="color: rgb(0, 118, 200); font-size: 18pt;"><br></span></b></span>
		</p>
		<hr
			style="border: 0px; border-image: none; height: 2px; color: rgb(133, 133, 133); background-color: rgb(133, 133, 133);">
		<p>
			<span style="font-size: 10pt;">본 웹사이트에 게시된 이메일 주소가 전자우편 수집
				프로그램이나 그 밖의 기술적 장치를 이용하여 무단으로 수집되는 것을 거부하며, 이를 위반시 `정보통신망 이용촉진 및
				정보보호 등에 관한 법률` 에 의해 처벌됨을 유념하시기 바랍니다. </span>
		</p>
		<p>
			<br>
		</p>
		<h2>
			<span
				style="color: rgb(0, 118, 200); font-family: 맑은 고딕; font-size: 14pt;">정보통신망법
				제50조의 2</span>
		</h2>
		<h2>
			<span
				style="color: rgb(0, 118, 200); font-family: 맑은 고딕; font-size: 14pt;">(전자우편주소의
				무단 수집행위 등 금지)</span>
		</h2>
		<div>
			<span
				style="color: rgb(0, 118, 200); font-family: 맑은 고딕; font-size: 14pt;"><br></span>
		</div>
		<p style="line-height: 1.5;">
			<span style="font-family: 맑은 고딕; font-size: 10pt;">① 누구든지 인터넷
				홈페이지 운영자 또는 관리자의 사전 동의 없이 인터넷 홈페이지에서 자동으로 전자우편주소를 수집하는 프로그램이나 그 밖의
				기술적 장치를 이용하여 전자우편주소를 수집하여서는 아니 된다.<br>② 누구든지 제1항을 위반하여 수집된
				전자우편주소를 판매ㆍ유통하여서는 아니 된다.<br>③ 누구든지 제1항과 제2항에 따라 수집ㆍ판매 및 유통이 금지된
				전자우편주소임을 알면서 이를 정보 전송에 이용하여서는 아니 된다.
			</span>
		</p>
	</div>
</div>

 -->