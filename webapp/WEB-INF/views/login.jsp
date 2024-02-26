<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
     //치환 변수 선언합니다.
   pageContext.setAttribute("cr", "\r"); //Space
   pageContext.setAttribute("cn", "\n"); //Enter
   pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
   pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<title>로그인 &gt; ${SITE.siteNm}</title>
		<script src="/assets/jquery/jquery-1.9.1.min.js"></script>
	    <script src="/assets/jquery-ui/ui/minified/jquery-ui.min.js"></script>
	    <script src="/assets/jquery/jquery.form.js"></script>
	    <script src="/assets/parsley/dist/parsley.js"></script>
	    <script src="/assets/parsley/dist/i18n/ko.js"></script>
	    <script src="/js/common.js"></script>
	    <script src="/js/apfs/common.js"></script>

		<link rel="stylesheet" type="text/css" href="/css/back/login.css" />
		<link rel="stylesheet" type="text/css" href="/assets/parsley/src/parsley.css" />
		<!--[if lt IE 9]>
			<script src="/js/html5.js"></script>
		<![endif]-->

		<script>

		function enterKey(){
			  if(window.event.keyCode == 13){
				  login();
			  }
		}

		 function login(){
		      var f = document.	login_form;
			
// 		      230907 중복로그인 방지를 위해 테스트중...
		      var loginId = '<%=(String)session.getAttribute("loginId")%>';
			  var j_username = $("#j_username").val();
			  
				if(loginId == j_username){
					 alert("해당 아이디는 현재 로그인 중입니다.");
				 }
//	 		  230907 중복로그인 방지를 위해 테스트중 끝...		      
		      if ( $("#login_form").parsley().validate() ){
		    	    f.submit();
		      }
		 }

		</script>
	</head>

	<body>
		<!-- wrap -->
		<div id="wrap">
		<!-- container -->
			<div id="container">
				<article>
					<div id="content">
						<div id="article">
						<article>
		                	<div class="login_area">
		                	 <div class="logo_area">
		                	    <h1 class="logo">
				                    <img src="/images/common/logo.png" alt="농업정책보험금융원" />			                
			         	         </h1>
			         	        <span class="logo_txt" style = "float:right; padding-top: 33px;">관리자 페이지</span> 
			         	       </div>
								<div class="login_form">
			                        <form id="login_form" name="login_form" action="/j_spring_security_check" method="POST" class="margin-bottom-0" data-parsley-validate="true">
			                        <input type="hidden" name="siteCd" value="B" />
			                        	<fieldset>
			                            	<legend>${SITE.siteNm} 로그인화면</legend>
			                                <label for="j_username">아이디 입력</label>
			                                <input type="text" value="" id="j_username" name="j_username" class="login_id" placeholder="아이디" data-parsley-required="true" onkeyup="enterKey()" />
			                                <label for="j_password">비밀번호</label>
			                                <input type="password" value="" id="j_password" name="j_password" class="login_pw" placeholder="비밀번호" data-parsley-required="true" onkeyup="enterKey()" title="비밀번호" />
			                                <a href="javascript:login()" class="btn_login" title="로그인">
			                                	<span>로그인</span>
			                                </a>
			                            </fieldset>
			                        </form>
		                        </div>
		                        <div class="login_txt_list">
		                        	<ul>
		                        		<li>
		                        			${fn:replace(Logo.back_refer, cn, br)}
		                        		</li>
		                        	</ul>
		                        </div>
							</div>
						</article>
						</div>
					</div>
				</article>
			</div>
			<!-- //container -->
			<!-- footer -->
			<div id="footer">
			<footer>

			</footer>
			</div>
			<!-- //footer -->
		</div>
		<!-- //wrap -->
	</body>
	  <script>
	  <c:if test="${!empty errorMessage}">
	  	alert("${errorMessage}");
	  </c:if>
	  </script>
</html>