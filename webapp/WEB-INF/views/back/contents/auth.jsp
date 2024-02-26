<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page import = "java.util.Map"%>
<%@ page import = "java.util.List"%>
<spring:eval expression="@siteInfo['sSiteCode']" var="sSiteCode"/>
<spring:eval expression="@siteInfo['sSitePassword']" var="sSitePassword"/>
<spring:eval expression="@siteInfo['sIPINSiteCode']" var="sIPINSiteCode"/>
<spring:eval expression="@siteInfo['sIPINPassword']" var="sIPINPassword"/>
<%
	//공유  URL
	String pageURL = "http://"+request.getServerName();
	if(request.getServerPort() != 80){
		pageURL += ":" + request.getServerPort();
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	// SMS 인증 관련 처리
	/////////////////////////////////////////////////////////////////////////////////////////////////////////

    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
	//230714 SW보안약점 진단으로 암호화 처리
    String sSiteCode = (String) pageContext.getAttribute("sSiteCode");			// NICE로부터 부여받은 사이트 코드
    String sSitePassword = (String) pageContext.getAttribute("sSitePassword");	// NICE로부터 부여받은 사이트 패스워드
    String sIPINSiteCode = (String) pageContext.getAttribute("sIPINSiteCode");	// NICE평가정보로부터 부여받은 아이핀사이트 코드
    String sIPINPassword = (String) pageContext.getAttribute("sIPINPassword");	// NICE평가정보로부터 부여받은 아이핀사이트 패스워드
	
    
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
<script src="${ScriptPath}/commonUtil.js"></script>
<script>
		function goAuthPage () {
			
			var term = document.getElementById("terms_chk");
			if(term.checked != true) {
				alert('개인정보 처리방침에 동의하셔야 실명인증이 가능합니다.');
				return;
			} else {
				var bbsForm = document.bbsForm;
				bbsForm.BBS_STATE.value = "list";
				bbsForm.action			= "/GenCMS/gencms/cmsMng.do";
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
				return;
			}else{
				window.open('', 'popup', 'width=500, height=550,toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,top=0,left=0');
				document.frm_main.action = "https://cert.namecheck.co.kr/NiceID2/certpass_input.asp";
				document.frm_main.target = "popup";
				document.frm_main.submit();
			}    	
		}
		
		
		function NameCheckSuccess () {
			alert("인증이 성공적으로 완료되었습니다. 작성 페이지로 이동합니다");
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
				return;
			}else{
				window.open('', 'popupSafe', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
				document.frm_safe.target = "popupSafe";
				document.frm_safe.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
				document.frm_safe.submit();
			}    	
		}
		
		function SafeSuccess () {
			alert("인증이 성공적으로 완료되었습니다. 작성 페이지로 이동합니다");
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
				return;
			}else{
				window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
				document.form_ipin.target = "popupIPIN2";
				document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
				document.form_ipin.submit();
			}
		}
		
		function IPINSuccess () {
			alert("인증이 성공적으로 완료되었습니다. 작성 페이지로 이동합니다");
			//document.visitForm.SAFE_WRITER_NAME.value = document.autof.sN.value;
			goAuthPage();
		}
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
</script>
			<!-- cont_area -->
			<h2>개인정보 처리방침</h2>
				<div class="scroll-wrap">
					<div class="scroll">
				${personalText.CONTENTS}				
					</div>
				</div>
				<div class="btn-list alignR">
					<input type="checkbox" id="terms_chk" class="chk_ty">
					<label for="agree">위의 "약관 및 정책"에 동의합니다.</label>
				</div>
 				<h2>본인인증 서비스</h2>
 				<div class="certi-box">
 					<div class="certi-ipin">
 						<div class="inner">
 							<p class="certi-tit"><img src="../../image/page/icon_ipin.png" alt="공공아이핀 인증(I-PIN)"></p>
 							<p class="text"><span>공공 I-PIN은 인증 시에는 인증센터를 통하여</span><span>회원가입이 되어 있어야 하고, 개인정보 노출방지를 위하여</span><span>공공 I-PIN 사용 권장</span></p>
 							<p class="btn-certi"><a href="#none" onclick="fiPopup()"><img src="../../image/common/btn_certi.png" alt="인증하기"></a></p>
 						</div>
 					</div>
 					<div class="certi-phone">
 						<div class="inner">
 							<p class="certi-tit"><img src="../../image/page/icon_phone.png" alt="휴대폰 본인확인 서비스"></p>
 							<p class="text"><span>사용자의 주민번호를 이용하지 않고</span><span>최소한의 정보를 이용하여 본인 확인이 가능한 인증 서비스</span></p>
 							<p class="btn-certi"><a href="#none" onclick="fnPopup_Safe()"><img src="../../image/common/btn_certi.png" alt="인증하기"></a></p>
 						</div>
 					</div>
 				</div>
			
			<form name="bbsForm" method="post">
				<input type="hidden" name="sub_num" value="${SUB_NUM}">
				<input type="hidden" name="CMS_MENU_IDX" value="${CMS_MENU_IDX}">
				<input type="hidden" name="BBS_STATE">		
				<input type="hidden" name="SAFE_WRITER_NAME"	value="" id="SAFE_WRITER_NAME" >
				<input type="hidden" id="sName" name="sName">
				<input type="hidden" id="sDupInfo" name="sDupInfo">
				<input type="hidden" id="sBirthDate" name="sBirthDate"> 		
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
        
<iframe name="ddTempSave" id="ddTempSave" src="/Auth/NiceID2_Process.jsp" frameborder="0" width="1" height="1" title="iframe">프레임이 지원 되지 않는 환경입니다.</iframe>
