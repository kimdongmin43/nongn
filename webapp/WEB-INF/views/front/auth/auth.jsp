﻿<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page import = "java.util.Map"%>
<%@ page import = "java.util.List"%>
<%
	//공유  URL
	
	//수정 : 2018-01-30 
	//https환경에서 실명인증 호출시 아래 http 를 https로 수정하면 됩니다	
	String pageURL = "https://"+request.getServerName();
	if(request.getServerPort() != 80){
		pageURL += ":" + request.getServerPort();
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	// SMS 인증 관련 처리
	/////////////////////////////////////////////////////////////////////////////////////////////////////////

    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
    String sSiteCode = "G7435";				// NICE로부터 부여받은 사이트 코드
    String sSitePassword = "UM0UNX4SSJAS";		// NICE로부터 부여받은 사이트 패스워드
    
    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
  	
   	String sAuthType = "";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
   	
   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize 	= "";			//없으면 기본 웹페이지 / Mobile : 모바일페이지
		
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    String sReturnUrl = pageURL + "/Auth/checkplus_success.jsp";      // 성공시 이동될 URL
    String sErrorUrl = pageURL + "/Auth/checkplus_fail.jsp";          // 실패시 이동될 URL

    // 입력될 plain 데이타를 만든다.
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
    
    String sMessage = "";
    String sEncData = "";
    
    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
    if( iReturn == 0 ) {
        sEncData = niceCheck.getCipherData();
    } else if( iReturn == -1) {
        sMessage = "암호화 시스템 에러입니다.";
    } else if( iReturn == -2) {
        sMessage = "암호화 처리오류입니다.";
    } else if( iReturn == -3) {
        sMessage = "암호화 데이터 오류입니다.";
    } else if( iReturn == -9) {
        sMessage = "입력 데이터 오류입니다.";
    } else {
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
    
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	//	IPIN 
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	String iSiteCode				= "K564";			// IPIN 서비스 사이트 코드		(NICE신용평가정보에서 발급한 사이트코드)
	String iSitePw					= "Moaf2004";			// IPIN 서비스 사이트 패스워드	(NICE신용평가정보에서 발급한 사이트패스워드)
	
	String iReturnURL				= pageURL + "/Auth/ipin_process.jsp";
	String iCPRequest				= "";
	
	// 객체 생성
	Kisinfo.Check.IPINClient pClient = new Kisinfo.Check.IPINClient(); 
	
	// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
	iCPRequest = pClient.getRequestNO(iSiteCode);
	
	// CP 요청번호를 세션에 저장합니다.
	// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
	// 필수사항은 아니며, 보안을 위한 권고사항입니다. 
	session.setAttribute("CPREQUEST" , iCPRequest);
	
	
	// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
	int iRtn = pClient.fnRequest(iSiteCode, iSitePw, iCPRequest, iReturnURL);
	
	String iRtnMsg					= "";			// 처리결과 메세지
	String iEncData					= "";			// 암호화 된 데이타
	
	// Method 결과값에 따른 처리사항
	if (iRtn == 0){
		// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
		// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
		iEncData = pClient.getCipherData();		//암호화 된 데이타
		iRtnMsg = "정상 처리되었습니다."; 
	} else if (iRtn == -1 || iRtn == -2) {
		iRtnMsg =	"배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<BR>" +
					"귀사 서버환경에 맞는 모듈이 없다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
	} else if (iRtn == -9) {
		iRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
	} else {
		iRtnMsg = "iRtn 값 확인 후, NICE신용평가정보 개발 담당자에게 문의해 주세요."; 
	}

	
%>
<jsp:include page="/adins_web/main/init.do"></jsp:include>
<script>
	
	
		function goAuthPage() {
			
			var term = document.getElementById("terms_chk");
			var url  = "";
			
			if ($("#boardId").val() == '20072' || $("#boardId").val() == '20075') {
				
				url = "/front/board/boardContentsListPage.do";
			}			
			else if(($("#boardId").val() == '51' || $("#boardId").val() == '20057' || $("#boardId").val() == '20062') && ( $("#contId").val() == null || $("#contId").val() == '') )		//	실명인증 후 작성하기 화면 - 20062 추가 - 2020.10.08
			{
				url = "/front/board/boardContentsWrite.do";
				
			}
			else if(($("#boardId").val() == '51' || $("#boardId").val() == '20057') && $("#contId").val() != null)
			{			
				
				url = $("#requestUri").val(); 
			}
			
			if(term.checked != true) {
				alert('개인정보 처리방침에 동의하셔야 실명인증이 가능합니다.');
				term.focus();
				return;
			} else {
				var bbsForm = document.bbsForm;
				bbsForm.BBS_STATE.value = "list";
				bbsForm.action			= url;
				bbsForm.submit();
			}
			
		}
		
		/* function fiPopup() {
			window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			document.form_ipin.target = "popupIPIN2";
			document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
			document.form_ipin.submit();
		} */

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//  실명 확인 서비스 관련 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		function fnPopup_Nice(){
		    var term = document.getElementById("terms_chk");
			if(term.checked != true) {
				alert('개인정보 처리방침에 동의하셔야 실명인증이 가능합니다.');
				term.focus();
				return;
			}else{
				window.open('', 'popup', 'width=500, height=550,toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,top=0,left=0');
				document.frm_main.action = "https://cert.namecheck.co.kr/NiceID2/certpass_input.asp";
				document.frm_main.target = "popup";
				document.frm_main.submit();
			}    	
		}
		
		
		function NameCheckSuccess () {
			alert("인증이 성공적으로 완료되었습니다.");
			//document.visitForm.SAFE_WRITER_NAME.value = document.frm_mainResult.sName.value;
			goAuthPage();
		}	
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//  휴대폰 보인 확인 서비스 관련 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		function fnPopup_Safe(){
		    var term = document.getElementById("terms_chk");
			if(term.checked != true) {
				alert('개인정보 처리방침 약관 및 정책에 동의하셔야 본인인증이 가능합니다.');
				term.focus();
				return;
			}else{
				window.open('', 'popupSafe', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
				document.frm_safe.target = "popupSafe";
				document.frm_safe.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
				document.frm_safe.submit();
			}    	
		}
		
		function SafeSuccess () {
			alert("인증이 성공적으로 완료되었습니다.");
			//document.visitForm.SAFE_WRITER_NAME.value = document.autof.sN.value;
			goAuthPage();
		}
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//  아이핀 인증관련 서비스 관련 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		function fiPopup(){
		    var term = document.getElementById("terms_chk");
			if(term.checked != true) {
				alert('개인정보 처리방침 약관 및 정책에 동의하셔야 본인인증이 가능합니다.');
				term.focus();
				return;
			}else{
				window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
				document.form_ipin.target = "popupIPIN2";
				document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
				document.form_ipin.submit();
			}
		}
		
		function IPINSuccess () {
			alert("인증이 성공적으로 완료되었습니다.");
			//document.visitForm.SAFE_WRITER_NAME.value = document.autof.sN.value;
			goAuthPage();
		}
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
</script>

<div class="content_tit" id="containerContent">	<!-- 2024 웹 접근성 -->
	<h3>${MENU.menuNm}</h3>
</div>
	
<div class="content"><!-- 화면이 안나오는 현상 -->
	<h4 class="title_h4">개인정보 수집 및 이용 동의서</h4>
                    
	<!--개인정보 동의부분-->
	<div class="agree_area">		 
		<div class="agree_list">
			<ul class="list_style3">
				<li>개인정보의 수집·이용 목적
					<ul class="list_style2">
						<li>농업정책보험금융원에 대한 고객 질의 접수 및 처리결과 회신 등 업무처리를 위하여 개인정보를 수집·이용합니다.</li>
					</ul>
				</li>
				<li>수집·이용하는 개인정보의 항목
					<ul class="list_style2">
						<li>[필수적 정보] 실명인증정보, 성명, 생년월일, 이메일주소, 휴대폰번호</li>
					</ul>
				</li>
				<li>개인정보의 보유·이용 기간
					<ul class="list_style2">
						<li><strong>본인 확인 목적으로 개인정보를 이용 후 즉시 파기하며, 개인정보를 수집하지 않습니다.</strong></li>
					</ul>
				</li>
				<li>동의를 거부할 권리 및 동의를 거부할 경우의 불이익
					<ul class="list_style2">
						<li>귀하는 위 필수적 정보의 수집·이용 동의를 거부하실 수 있습니다. 단, 동의하지 않으시는 경우 질의응답(Q&A) 서비스 이용이 제한됩니다.</li>
					</ul>
				</li>
			</ul>
		</div>
		<div class="agree_btn">
			<input type="checkbox" name="chk" id="terms_chk" />
			<label for="terms_chk"> 위의 "약관 및 정책"에 동의합니다.</label>
		</div> 
	</div>
	<!--//개인정보 동의부분-->
                    
	<!--real_name_area-->
	<div class="real_name_area">
		<ul>
			<li class="real_name bg_ipin">
				<p class="tit_real_name">아이핀인증</p>
<!-- 				<p class="txt">공공 I-PIN은 인증 시에는 인증센터를<br /> -->
<!-- 				통하여 회원가입이 되어 있어야 하고,<br /> -->
<!-- 				개인정보 노출방지를 위하여<br /> -->
<!-- 				공공 I-PIN 사용 권장</p> -->
				<p class="btn"><a href="javascript:fiPopup()" title="새창열림">인증하기</a></p>
			</li>
			<li class="real_name bg_phone">
				<p class="tit_real_name">휴대폰 본인확인 서비스</p>
<!-- 				<p class="txt">사용자의 주민번호를 이용하지<br /> -->
<!-- 				않고 최소한의 정보를<br /> -->
<!-- 				이용하여 본인 확인이<br /> -->
<!-- 				가능한 인증 서비스</p> -->
				<p class="btn"><a href="javascript:fnPopup_Safe()" title="새창열림">인증하기</a></p>
			</li>
		</ul>
	</div>
	<!--//real_name_area-->
</div>
                
                
			
			<form name="bbsForm" method="post">
				<input type="hidden" name="sub_num" value="${SUB_NUM}">
				<input type="hidden" name="CMS_MENU_IDX" value="${CMS_MENU_IDX}">
				<input type="hidden" name="BBS_STATE">		
				<input type="hidden" name="SAFE_WRITER_NAME"	value="" id="SAFE_WRITER_NAME" >
				<input type="hidden" id="sName" name="sName">
				<input type="hidden" id="sDupInfo" name="sDupInfo">
				<input type="hidden" id="sBirthDate" name="sBirthDate">
				<input type="hidden" id="boardId" name="boardId" value = "${s_boardId}">
				<input type="hidden" id="menuId" name="menuId" value = "${s_menuId}">
				<input type="hidden" id="contId" name="contId" value = "${s_contId}">
				<input type="hidden" id="requestUri" name="requestUrl" value = "${requestUrl}">
				<input type="hidden" id="selTab" name="selTab" value = "${param.selTab}">		<!-- 2021.03.25 -->
			</form>
			
	<!-- 실명확인 확인 서비스 관련 -->
	
	<form method="post" name="frm_main">
		<input type="hidden" name="enc_data" value="">
	</form>
	<!--  
	<form id="frm_mainResult" method="post">
		<input type="hidden" id="sName" name="sName">
		<input type="hidden" id="sDupInfo" name="sDupInfo">
		<input type="hidden" id="sBirthDate" name="sBirthDate"> 
	</form>
	-->
	<!-- 실명확인 확인 서비스 관련 -->
	
	<!-- 휴대폰 보인 확인 서비스 관련 -->
	<form method="post" name="frm_safe">
		<input type="hidden" name="m" value="checkplusSerivce"> 
		<input type="hidden" name="EncodeData" value="<%=sEncData%>">
		<input type="hidden" name="param_r1" value="">
		<input type="hidden" name="param_r2" value="">
		<input type="hidden" name="param_r3" value="">
	</form>
	
	<form id="autof" method="post">
		<input type="hidden" id="sN" name="sN">
		<input type="hidden" id="sD" name="sD">
		<input type="hidden" id="sB" name="sB"> 
	</form>
	<!-- 휴대폰 보인 확인 서비스 관련 -->
	
	<!-- IPIN 인증 서비스 관련 -->
	<form name="form_ipin" method="post">
		<input type="hidden" name="m" value="pubmain">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
	    <input type="hidden" name="enc_data" value="<%= iEncData %>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
	    <input type="hidden" name="param_r1" value="">
	    <input type="hidden" name="param_r2" value="">
	    <input type="hidden" name="param_r3" value="">
	</form>
	
	<form id="form_ipinResult" method="post">
		<input type="hidden" id="sIName" name="sIName">
		<input type="hidden" id="sIDupInfo" name="sIDupInfo">
		<input type="hidden" id="sIBirthDate" name="sIBirthDate"> 
	</form>
	<!-- IPIN 인증 서비스 관련 -->
        
<iframe tabindex="-1" name="ddTempSave" id="ddTempSave" src="/Auth/NiceID2_Process.jsp" frameborder="0" width="1" height="1" title="IPIN 인증 서비스">프레임이 지원 되지 않는 환경입니다.</iframe>

<script>
$(document).ready(function(){
	$("#skip_nav").focus();
	
	var strTitle = $(document).find("title").text() + " > 실명인증하기";
	$(document).find("title").text(strTitle);
});
</script>