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
	
	//230714 SW���Ⱦ��� �������� ��ȣȭ ó��
    String sSiteCode = (String) pageContext.getAttribute("sSiteCode");
    String sSitePassword = (String) pageContext.getAttribute("sSitePassword");
    String sIPINSiteCode = (String) pageContext.getAttribute("sIPINSiteCode");	// NICE�������κ��� �ο����� �����ɻ���Ʈ �ڵ�
    String sIPINPassword = (String) pageContext.getAttribute("sIPINPassword");	// NICE�������κ��� �ο����� �����ɻ���Ʈ �н�����


	String sCipherTime = "";						// ��ȣȭ�� �ð�
	String sRequestNO = "";						// ��û ��ȣ
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
		sMessage = "�������� �����Ͽ����ϴ�.";
	    sPlainData = niceCheck.getPlainData();
	    sCipherTime = niceCheck.getCipherDateTime();

	    // ����Ÿ�� �����մϴ�.
	    java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

	    sRequestNO	= (String)mapresult.get("REQ_SEQ");
	    sResult		= (String)mapresult.get("NC_RESULT");

// 	    out.println("[�Ǹ�Ȯ�ΰ�� : " + (String)mapresult.get("NC_RESULT")+ "]<br>");
// 	    out.println("[�̸� : " + (String)mapresult.get("NAME")+ "]<br>");
// 	    out.println("[���� : " + (String)mapresult.get("GENDER")+ "]<br>");
// 	    out.println("[������� : " + (String)mapresult.get("BIRTHDATE")+ "]<br>");

// 	    out.println("[�Ƚ�KEY :" + (String)mapresult.get("SAFEID")+ "]<br>");
// 	    out.println("[VNO_NUM : " + (String)mapresult.get("VNO_NUM")+ "]<br>");
// 	    out.println("[IPIN_DI : " + (String)mapresult.get("IPIN_DI")+ "]<br>");
// 	    out.println("[��û������ȣ : " + sRequestNO + "]<br>");

// 	    out.println("[RESERVED1 : " + (String)mapresult.get("RESERVED1") + "]<br>");
// 	    out.println("[RESERVED2 : " + (String)mapresult.get("RESERVED2") + "]<br>");
// 	    out.println("[RESERVED3 : " + (String)mapresult.get("RESERVED3") + "]<br>");

	    String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
	    if(!sRequestNO.equals(session_sRequestNumber))
	    {
	        sMessage = "���ǰ��� �ٸ��ϴ�. �ùٸ� ��η� �����Ͻñ� �ٶ��ϴ�.";
	        sRequestNO = "";

	    }
	}
	else if( iReturn == -1)
	{
	    sMessage = "��ȣȭ �ý��� �����Դϴ�.";
	}
	else if( iReturn == -4)
	{
	    sMessage = "��ȣȭ ó�������Դϴ�.";
	}
	else if( iReturn == -5)
	{
	    sMessage = "��ȣȭ �ؽ� �����Դϴ�.";
	}
	else if( iReturn == -6)
	{
	    sMessage = "��ȣȭ ������ �����Դϴ�.";
	}
	else if( iReturn == -9)
	{
	    sMessage = "�Է� ������ �����Դϴ�.";
	}
	else if( iReturn == -12)
	{
	    sMessage = "����Ʈ �н����� �����Դϴ�.";
	}
	else
	{
	    sMessage = "�˼� ���� ���� �Դϴ�. iReturn : " + iReturn;
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
// 				alert('������ ���������� �Ϸ�Ǿ����ϴ�. ȸ������ �������� �̵��մϴ�');
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
