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

		if($("#mode").val() == "P" && $("#user_nm").val() == ""){
			alert("아이디를 입력하여야 합니다.");
			$("#user_nm").focus();
			return;
		}
		var frontUrl = "<%=(String)ConfigUtil.getProperty("system.server.frontUrl") %>";
		var port = "<%=(String)ConfigUtil.getProperty("system.server.httpsPort") %>";
		var key = "<%=(String)ConfigUtil.getProperty("realName.key") %>";
		// ?뒤에 SITE_SB 추가, 해당 service 분류로 실명인증 붙일 곳에서는 서울시에 SITE_SB 코드를 할당받아야 합니다. 샘플테스트는 SITE_SB=SB00000 을사용해주세요
		var url = "https://www.seoul.go.kr/seoul/jsp/smem/BoninCheck_winopen.jsp?CHECK_FLAG=SMS&SITE_SB="+key+"&NEXT_URL=";
		// 아래 refresh_url = 쓰기 페이지 주소 입력.
		var refresh_url = "https://"+frontUrl+":"+port+"/front/user/findIdPassPage.do?mode=${param.mode}";
		window.open(url+refresh_url, 'realName', 'width=490,height=275,top=100,left=100');
	}
</script>

<form id="schFrm" name="schFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="mode" name='mode' value="${param.mode}" />


<!-- division40 -->
<div class="division40">
	<!-- division60 -->
	<div class="division60">
		<c:if test="${param.mode eq 'P'}">
		<div class="find_id_box">
			<input type="text" id="user_nm" name="user_nm" placeholder="아이디를 입력하세요." />
			<label for="user_nm" class="hidden">아이디 입력</label>
		</div>
		</c:if>
		<c:if test="${realNameChk eq 'yes'  }">
			<div class="find_id_box">
				<c:if test="${mode2 eq 'P'}"><input type="text" value="회원님의 패스워드를 SMS로 발송하였습니다." readonly /></c:if>
				<c:if test="${mode2 eq 'E'}"><input type="text" value="회원님의 패스워드 찾기에 실패하였습니다." readonly /></c:if>
				<c:if test="${mode2 eq 'I'}"><input type="text" value="회원님의 아이디는 ${user_id } 입니다." readonly /></c:if>
				<c:if test="${mode2 eq 'N'}"><input type="text" value="입력하신 정보로 사용자를 찾을 수 없습니다." readonly /></c:if>
			</div>
		</c:if>
		<div class="certification_area">
			<div class="certification_button_area">
				<button class="btn_certifi" title="휴대폰 본인인증" onclick="BoninCheck_winopen()">
					<span>휴대폰 본인인증</span>
				</button>
			</div>
		</div>
	</div>
	<!--// division60 -->
</div>
<!--// division40 -->
</form>
