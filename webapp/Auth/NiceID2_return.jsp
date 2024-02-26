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

	String sEncodeData = requestReplace(request.getParameter("enc_data"), "encodeData");
	
	//230714 SW보안약점 진단으로 암호화 처리
    String sSiteCode = (String) pageContext.getAttribute("sSiteCode");
    String sSitePassword = (String) pageContext.getAttribute("sSitePassword");
    String sIPINSiteCode = (String) pageContext.getAttribute("sIPINSiteCode");	// NICE평가정보로부터 부여받은 아이핀사이트 코드
    String sIPINPassword = (String) pageContext.getAttribute("sIPINPassword");	// NICE평가정보로부터 부여받은 아이핀사이트 패스워드


	String sCipherTime = "";						// 복호화한 시간
	String sRequestNO = "";						// 요청 번호
	String sPlainData = "";

	String sMessage = "";
	String sResult = "";

	String sName		= "";
	String sGender		= "";
	String sBirthDate	= "";
	String sDupInfo		= "";

	int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

	if( iReturn == 0 )
	{
		sMessage = "본인인증 성공하였습니다.";
	    sPlainData = niceCheck.getPlainData();
	    sCipherTime = niceCheck.getCipherDateTime();

	    // 데이타를 추출합니다.
	    java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

	    sRequestNO	= (String)mapresult.get("REQ_SEQ");
	    sResult		= (String)mapresult.get("NC_RESULT");

// 	    out.println("[실명확인결과 : " + (String)mapresult.get("NC_RESULT")+ "]<br>");
// 	    out.println("[이름 : " + (String)mapresult.get("NAME")+ "]<br>");
// 	    out.println("[성별 : " + (String)mapresult.get("GENDER")+ "]<br>");
// 	    out.println("[생년월일 : " + (String)mapresult.get("BIRTHDATE")+ "]<br>");

// 	    out.println("[안심KEY :" + (String)mapresult.get("SAFEID")+ "]<br>");
// 	    out.println("[VNO_NUM : " + (String)mapresult.get("VNO_NUM")+ "]<br>");
// 	    out.println("[IPIN_DI : " + (String)mapresult.get("IPIN_DI")+ "]<br>");
// 	    out.println("[요청고유번호 : " + sRequestNO + "]<br>");

// 	    out.println("[RESERVED1 : " + (String)mapresult.get("RESERVED1") + "]<br>");
// 	    out.println("[RESERVED2 : " + (String)mapresult.get("RESERVED2") + "]<br>");
// 	    out.println("[RESERVED3 : " + (String)mapresult.get("RESERVED3") + "]<br>");

	    String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
	    if(!sRequestNO.equals(session_sRequestNumber))
	    {
	        sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
	        sRequestNO = "";

	    }
	}
	else if( iReturn == -1)
	{
	    sMessage = "복호화 시스템 에러입니다.";
	}
	else if( iReturn == -4)
	{
	    sMessage = "복호화 처리오류입니다.";
	}
	else if( iReturn == -5)
	{
	    sMessage = "복호화 해쉬 오류입니다.";
	}
	else if( iReturn == -6)
	{
	    sMessage = "복호화 데이터 오류입니다.";
	}
	else if( iReturn == -9)
	{
	    sMessage = "입력 데이터 오류입니다.";
	}
	else if( iReturn == -12)
	{
	    sMessage = "사이트 패스워드 오류입니다.";
	}
	else
	{
	    sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
	}

%>
<%!
	public static String requestReplace (String paramValue, String gubun) {
	    String result = "";

	    if (paramValue != null) {

	    	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

	    	paramValue = paramValue.replaceAll("\\*", "");
	    	paramValue = paramValue.replaceAll("\\?", "");
	    	paramValue = paramValue.replaceAll("\\[", "");
	    	paramValue = paramValue.replaceAll("\\{", "");
	    	paramValue = paramValue.replaceAll("\\(", "");
	    	paramValue = paramValue.replaceAll("\\)", "");
	    	paramValue = paramValue.replaceAll("\\^", "");
	    	paramValue = paramValue.replaceAll("\\$", "");
	    	paramValue = paramValue.replaceAll("'", "");
	    	paramValue = paramValue.replaceAll("@", "");
	    	paramValue = paramValue.replaceAll("%", "");
	    	paramValue = paramValue.replaceAll(";", "");
	    	paramValue = paramValue.replaceAll(":", "");
	    	paramValue = paramValue.replaceAll("-", "");
	    	paramValue = paramValue.replaceAll("#", "");
	    	paramValue = paramValue.replaceAll("--", "");
	    	paramValue = paramValue.replaceAll("-", "");
	    	paramValue = paramValue.replaceAll(",", "");

	    	if(gubun != "encodeData"){
	    		paramValue = paramValue.replaceAll("\\+", "");
	    		paramValue = paramValue.replaceAll("/", "");
	        	paramValue = paramValue.replaceAll("=", "");
	    	}

	    	result = paramValue;

	    }
	    return result;
	}
%>
<%
		if(iReturn!=0) {
%>
			<script>
				alert('<%=sMessage%>');
				window.close();
			</script>
<%
		} else {
%>
			<script>
// 				alert('인증이 성공적으로 완료되었습니다. 회원가입 페이지로 이동합니다');
				window.opener.document.getElementById("sName").value = '<%=sName%>';
				window.opener.document.getElementById("sDupInfo").value = '<%=sDupInfo%>';
				window.opener.document.getElementById("sBirthDate").value = '<%=sBirthDate%>';
				window.opener.document.getElementById("SAFE_WRITER_NAME").value = '<%=sName%>';
				
// 				window.opener.document.getElementById("autof").action = '/gugak_member/html/member/join.jsp';
// 				window.opener.document.getElementById("autof").submit();
// 				window.close();

				opener.NameCheckSuccess();
				window.close();
			</script>
<%
		}
%>
