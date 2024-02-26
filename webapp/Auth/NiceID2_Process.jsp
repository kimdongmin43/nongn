<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<spring:eval expression="@siteInfo['sSiteCode']" var="sSiteCode"/>
<spring:eval expression="@siteInfo['sSitePassword']" var="sSitePassword"/>
<spring:eval expression="@siteInfo['sIPINSiteCode']" var="sIPINSiteCode"/>
<spring:eval expression="@siteInfo['sIPINPassword']" var="sIPINPassword"/>
<%
	NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

	//공유  URL
	String pageURL = "https://"+request.getServerName();
	if(request.getServerPort() != 80){
		pageURL += ":" + request.getServerPort();
	}
	
	//230714 SW보안약점 진단으로 암호화 처리
    String sSiteCode = (String) pageContext.getAttribute("sSiteCode");
    String sSitePassword = (String) pageContext.getAttribute("sSitePassword");
    String sIPINSiteCode = (String) pageContext.getAttribute("sIPINSiteCode");	// NICE평가정보로부터 부여받은 아이핀사이트 코드
    String sIPINPassword = (String) pageContext.getAttribute("sIPINPassword");	// NICE평가정보로부터 부여받은 아이핀사이트 패스워드
	

	String sReturnURL = pageURL + "/Auth/NiceID2_return.jsp";	//결과 수신 URL
	String sRequestNO		= "";												// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 필요시 사용
	String sClientImg		= "";												//서비스 화면 로고 선택: default 는 null 입니다.(full 경로 입력해 주세요.)

	String sReserved1		= "";
	String sReserved2		= "";
	String sReserved3		= "";

	sRequestNO = niceCheck.getRequestNO(sSiteCode);	//요청고유번호 / 비정상적인 접속 차단을 위해 필요
		session.setAttribute("REQ_SEQ" , sRequestNO);	//해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
	out.println ("sRequestNO : " + sRequestNO + "<br>");

	// 입력될 plain 데이타를 만든다.
	String sPlainData = "7:RTN_URL" + sReturnURL.getBytes().length + ":" + sReturnURL +
	                    "7:REQ_SEQ" + sRequestNO.getBytes().length + ":" + sRequestNO +
	                    "7:IMG_URL" + sClientImg.getBytes().length + ":" + sClientImg +
	                    "9:RESERVED1" + sReserved1.getBytes().length + ":" + sReserved1 +
	                    "9:RESERVED2" + sReserved2.getBytes().length + ":" + sReserved2 +
	                    "9:RESERVED3" + sReserved3.getBytes().length + ":" + sReserved3 +
	                    "13:IPIN_SITECODE" + sIPINSiteCode.getBytes().length + ":" + sIPINSiteCode +
	                    "17:IPIN_SITEPASSWORD" + sIPINPassword.getBytes().length + ":" + sIPINPassword ;

	String sMessage = "";
	String sEncData = "";

	int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
	if( iReturn == 0 ) {
	    sEncData = niceCheck.getCipherData();
	    out.println ("요청정보_암호화_성공[ : " + sEncData + "]");
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

%>
<script>

	function initEncData () {

		parent.document.frm_main.enc_data.value = "<%=sEncData%>";

	}
</script>
<body onload="initEncData();">
</body>
</html>