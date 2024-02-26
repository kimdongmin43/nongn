<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@page import="kr.apfs.local.common.util.ConfigUtil"%>
<!-- 실명제 팝업창 -->
<script>
	/* IE6 일 때 document.domain 이 않되기 때문에 처리
	기존 ` document.domain="seoul.go.kr" `을 아래 붉은글씨로 교체
	*/
	var brower_version = navigator.userAgent.toLowerCase();
	if(brower_version.indexOf('msie 6') < 0){
		document.domain = "seoul.go.kr";
	}
	function BoninCheck_winopen() {
		var frontUrl = "<%=(String)ConfigUtil.getProperty("system.server.frontUrl") %>";
		var port = "<%=(String)ConfigUtil.getProperty("system.server.httpsPort") %>";
		var key = "<%=(String)ConfigUtil.getProperty("realName.key") %>";
		// ?뒤에 SITE_SB 추가, 해당 service 분류로 실명인증 붙일 곳에서는 서울시에 SITE_SB 코드를 할당받아야 합니다. 샘플테스트는 SITE_SB=SB00000 을사용해주세요
		var url = "https://www.seoul.go.kr/seoul/jsp/smem/BoninCheck_winopen.jsp?CHECK_FLAG=SMS&SITE_SB="+key+"&NEXT_URL=";
		// 아래 refresh_url = 쓰기 페이지 주소 입력.
		var refresh_url = "https://"+frontUrl+":"+port+"/front/user/userRegistStep2Page.do";
		window.open(url+refresh_url, 'realName', 'width=590,height=375,top=100,left=100');
	}
</script>

<!-- division40 -->
<div class="division40">
	<!-- division60 -->
	<div class="division60">
		<!-- chapter_area -->
		<div class="chapter_area">
			<img src="/images/front/sub/member_chapter01.png" alt="1. 가입인증" />
		</div>
		<!--// chapter_area -->
		<!-- member_list_txt -->
		<div class="member_list_txt">
			<ul>
				<li>서울시 상공회의소 온라인플랫폼 홈페이지에 오신것을 환영합니다.</li>
				<li>14세 이상 내국인만 회원가입 가능합니다.</li>
				<li>휴대폰 본인인증 선택 후 팝업창이 나타나지 않으면 브라우저의 팝업차단을 해제하여 주시기 바랍니다.</li>
			</ul>
		</div>
		<!--// member_list_txt -->
		<div class="certification_area w100">
			<div class="certification_button_area">
				<button class="btn_certifi" title="휴대폰 본인인증" onclick="BoninCheck_winopen()">
					<span>휴대폰 본인인증</span>
				</button>
			</div>
		</div>
		<!-- button_area
		<div class="button_area">
           	<div class="alignc">
           		<button class="btn save" title="다음단계" onclick="next();">
           			<span>다음단계</span>
           		</button>
           	</div>
		</div>
		// button_area -->
	</div>
	<!--// division60 -->
</div>
<!--// division40 -->