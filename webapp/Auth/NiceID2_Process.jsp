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

	//����  URL
	String pageURL = "https://"+request.getServerName();
	if(request.getServerPort() != 80){
		pageURL += ":" + request.getServerPort();
	}
	
	//230714 SW���Ⱦ��� �������� ��ȣȭ ó��
    String sSiteCode = (String) pageContext.getAttribute("sSiteCode");
    String sSitePassword = (String) pageContext.getAttribute("sSitePassword");
    String sIPINSiteCode = (String) pageContext.getAttribute("sIPINSiteCode");	// NICE�������κ��� �ο����� �����ɻ���Ʈ �ڵ�
    String sIPINPassword = (String) pageContext.getAttribute("sIPINPassword");	// NICE�������κ��� �ο����� �����ɻ���Ʈ �н�����
	

	String sReturnURL = pageURL + "/Auth/NiceID2_return.jsp";	//��� ���� URL
	String sRequestNO		= "";												// ��û ��ȣ, �̴� ����/�����Ŀ� ���� ������ �ǵ����ְ� �ǹǷ� �ʿ�� ���
	String sClientImg		= "";												//���� ȭ�� �ΰ� ����: default �� null �Դϴ�.(full ��� �Է��� �ּ���.)

	String sReserved1		= "";
	String sReserved2		= "";
	String sReserved3		= "";

	sRequestNO = niceCheck.getRequestNO(sSiteCode);	//��û������ȣ / ���������� ���� ������ ���� �ʿ�
		session.setAttribute("REQ_SEQ" , sRequestNO);	//��ŷ���� ������ ���Ͽ� ������ ���ٸ�, ���ǿ� ��û��ȣ�� �ִ´�.
	out.println ("sRequestNO : " + sRequestNO + "<br>");

	// �Էµ� plain ����Ÿ�� �����.
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
	    out.println ("��û����_��ȣȭ_����[ : " + sEncData + "]");
	} else if( iReturn == -1) {
	    sMessage = "��ȣȭ �ý��� �����Դϴ�.";
	} else if( iReturn == -2) {
	    sMessage = "��ȣȭ ó�������Դϴ�.";
	} else if( iReturn == -3) {
	    sMessage = "��ȣȭ ������ �����Դϴ�.";
	} else if( iReturn == -9) {
	    sMessage = "�Է� ������ �����Դϴ�.";
	} else {
	    sMessage = "�˼� ���� ���� �Դϴ�. iReturn : " + iReturn;
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