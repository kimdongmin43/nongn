<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%

	String sSiteCode				= "K564";			// IPIN ���� ����Ʈ �ڵ�		(NICE�ſ����������� �߱��� ����Ʈ�ڵ�)
	String sSitePw					= "Moaf2004";
	/*********************************************************************************************
		NICE�ſ������� Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED

		���񽺸� : �����ֹι�ȣ���� (IPIN) ����
		�������� : �����ֹι�ȣ���� (IPIN) ����� ���� ���� ó�� ������

				   ���Ź��� ������(�������)�� ����ȭ������ �ǵ����ְ�, close�� �ϴ� ��Ȱ�� �մϴ�.
	**********************************************************************************************/
	// ����� ���� �� CP ��û��ȣ�� ��ȣȭ�� ����Ÿ�Դϴ�. (ipin_main.jsp ���������� ��ȣȭ�� ����Ÿ�ʹ� �ٸ��ϴ�.)
	String sResponseData = requestReplace(request.getParameter("enc_data"), "encodeData");

	// ipin_main.jsp ���������� ������ ����Ÿ�� �ִٸ�, �Ʒ��� ���� Ȯ�ΰ����մϴ�.
	String sReservedParam1  = requestReplace(request.getParameter("param_r1"), "");
	String sReservedParam2  = requestReplace(request.getParameter("param_r2"), "");
	String sReservedParam3  = requestReplace(request.getParameter("param_r3"), "");


    // ��ȣȭ�� ����� ������ �����ϴ� ���
    if (!sResponseData.equals("") && sResponseData != null)
    {
    	// CP ��û��ȣ : ipin_main.jsp ���� ���� ó���� ����Ÿ
        String sCPRequest = (String)session.getAttribute("CPREQUEST");

        // ��ü ����
    	Kisinfo.Check.IPINClient pClient = new Kisinfo.Check.IPINClient();

    	int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData);
    	//int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData, sCPRequest);

    	String sRtnMsg				= "";							// ó����� �޼���
    	String sVNumber				= pClient.getVNumber();			// �����ֹι�ȣ (13�ڸ��̸�, ���� �Ǵ� ���� ����)
    	String sName				= replaceNameToAstar(pClient.getName());			// �̸�
    	String sDupInfo				= pClient.getDupInfo();			// �ߺ����� Ȯ�ΰ� (DI - 64 byte ������)
    	String sAgeCode				= pClient.getAgeCode();			// ���ɴ� �ڵ� (���� ���̵� ����)
    	String sGenderCode			= pClient.getGenderCode();		// ���� �ڵ� (���� ���̵� ����)
    	String sBirthDate			= pClient.getBirthDate();		// ������� (YYYYMMDD)
    	String sNationalInfo		= pClient.getNationalInfo();	// ��/�ܱ��� ���� (���� ���̵� ����)
    	String sCPRequestNum		= pClient.getCPRequestNO();		// CP ��û��ȣ

    	// Method ������� ���� ó������
    	if (iRtn == 1)
    	{
    		/*
    			������ ���� ����� ������ ������ �� �ֽ��ϴ�.
    			����ڿ��� �����ִ� ������, '�̸�' ����Ÿ�� ���� �����մϴ�.

    			����� ������ �ٸ� ���������� �̿��Ͻ� ��쿡��
    			������ ���Ͽ� ��ȣȭ ����Ÿ(sResponseData)�� ����Ͽ� ��ȣȭ �� �̿��Ͻǰ��� �����մϴ�. (���� �������� ���� ó�����)

    			����, ��ȣȭ�� ������ ����ؾ� �ϴ� ��쿣 ����Ÿ�� ������� �ʵ��� ������ �ּ���. (����ó�� ����)
    			form �±��� hidden ó���� ����Ÿ ���� ������ �����Ƿ� �������� �ʽ��ϴ�.
    		*/

    		// ����� ���������� ���� ����
    		/*
    		out.println("�����ֹι�ȣ : " + sVNumber + "<BR>");
    		out.println("�̸� : " + sName + "<BR>");
    		out.println("�ߺ����� Ȯ�ΰ� (DI) : " + sDupInfo + "<BR>");
    		out.println("���ɴ� �ڵ� : " + sAgeCode + "<BR>");
    		out.println("���� �ڵ� : " + sGenderCode + "<BR>");
    		out.println("������� : " + sBirthDate + "<BR>");
    		out.println("��/�ܱ��� ���� : " + sNationalInfo + "<BR>");
    		out.println("CP ��û��ȣ : " + sCPRequestNum + "<BR>");
    		out.println("***** ��ȣȭ �� ������ �������� Ȯ���� �ֽñ� �ٶ��ϴ�.<BR><BR><BR><BR>");
    		*/
    		sRtnMsg = "���� ó���Ǿ����ϴ�.";

    	} else if (iRtn == -1 || iRtn == -4) {
    		sRtnMsg =	"iRtn ��, ���� ȯ�������� ��Ȯ�� Ȯ���Ͽ� �ֽñ� �ٶ��ϴ�.";
    	} else if (iRtn == -6) {
    		sRtnMsg =	"���� �ѱ� charset ������ euc-kr �� ó���ϰ� ������, euc-kr �� ���ؼ� ����� �ֽñ� �ٶ��ϴ�.<BR>" +
    					"�ѱ� charset ������ ��Ȯ�ϴٸ� ..<BR><B>iRtn ��, ���� ȯ�������� ��Ȯ�� Ȯ���Ͽ� ���Ϸ� ��û�� �ֽñ� �ٶ��ϴ�.</B>";
    	} else if (iRtn == -9) {
    		sRtnMsg = "�Է°� ���� : fnResponse �Լ� ó����, �ʿ��� �Ķ���Ͱ��� ������ ��Ȯ�ϰ� �Է��� �ֽñ� �ٶ��ϴ�.";
    	} else if (iRtn == -12) {
    		sRtnMsg = "CP ��й�ȣ ����ġ : IPIN ���� ����Ʈ �н����带 Ȯ���� �ֽñ� �ٶ��ϴ�.";
    	} else if (iRtn == -13) {
    		sRtnMsg = "CP ��û��ȣ ����ġ : ���ǿ� ���� sCPRequest ����Ÿ�� Ȯ���� �ֽñ� �ٶ��ϴ�.";
    	} else {
    		sRtnMsg = "iRtn �� Ȯ�� ��, NICE�ſ������� ���� ����ڿ��� ������ �ּ���.";
    	}

%>

<%!    
    public String replaceNameToAstar(String sName){
    	
    	String cName="";
    	
    	char[] chars = sName.toCharArray();
    	for(int i=0 ; i<chars.length ; i++){
    		if(i==0){
    			chars[i] = chars[i];
    		}
    		else{
    			chars[i] = '*';
    		}
    	}
    	
    	cName = String.valueOf(chars);
    	
    	return cName;
    }

%>

<%
		if(iRtn!=1) {
%>
			<script>
				alert('�������� �ý��� �����Դϴ�. ����ڿ��� ���� �ٶ��ϴ�');
				window.close();
			</script>
<%
		} else {
			// ������� : ����Ȯ�� ��ȸ ���� ��ġ �ݿ�
			session.setAttribute("session_sDupInfo" , sDupInfo);
			session.setAttribute("sName", sName);
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

				opener.IPINSuccess();
				window.close();
			</script>
<%
		}
%>


<% } %>
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