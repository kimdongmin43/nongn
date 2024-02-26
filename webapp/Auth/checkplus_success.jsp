<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<spring:eval expression="@siteInfo['sSiteCode']" var="sSiteCode"/>
<spring:eval expression="@siteInfo['sSitePassword']" var="sSitePassword"/>
<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
    String sReserved1  = requestReplace(request.getParameter("param_r1"), "");
    String sReserved2  = requestReplace(request.getParameter("param_r2"), "");
    String sReserved3  = requestReplace(request.getParameter("param_r3"), "");
	
  	//230714 SW���Ⱦ��� �������� ��ȣȭ ó��
    String sSiteCode = (String) pageContext.getAttribute("sSiteCode");		// NICE�κ��� �ο����� ����Ʈ �ڵ�
    String sSitePassword = (String) pageContext.getAttribute("sSitePassword");		// NICE�κ��� �ο����� ����Ʈ �н�����
  	//String sSiteCode = kr.apfs.local.common.util.CryptoUtil.AES_Decode("sSiteCode");
    
    //System.out.println("sSiteCode :" + sSiteCode);
    

    String sCipherTime = "";				 // ��ȣȭ�� �ð�
    String sRequestNumber = "";			 // ��û ��ȣ
    String sResponseNumber = "";		 // ���� ������ȣ
    String sAuthType = "";				   // ���� ����
    String sName = "";							 // ����
    String SAFE_WRITER_NAME = "";							 // ����2 240222 �赿�� ����������ȸ �߰���ġ�� ���� �߰�
    String sDupInfo = "";						 // �ߺ����� Ȯ�ΰ� (DI_64 byte)
    String sConnInfo = "";					 // �������� Ȯ�ΰ� (CI_88 byte)
    String sBirthDate = "";					 // ����
    String sGender = "";						 // ����
    String sNationalInfo = "";       // ��/�ܱ������� (���߰��̵� ����)
    String sMessage = "";
    String sPlainData = "";

    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if( iReturn == 0 )
    {
        sPlainData = niceCheck.getPlainData();
        sCipherTime = niceCheck.getCipherDateTime();

        // ����Ÿ�� �����մϴ�.
        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
        sResponseNumber = (String)mapresult.get("RES_SEQ");
        //20.05.11 �������� ó�� ���뿡 ���� ����X
        //sAuthType 			= (String)mapresult.get("AUTH_TYPE");							
        //sName 					= replaceNameToAstar((String)mapresult.get("NAME"));
        sName 					= (String)mapresult.get("NAME");								//2022.06.21 �赿�� �븮 replaceNameToAstar ����
        sBirthDate 			= (String)mapresult.get("BIRTHDATE");								//2022.06.21 �赿�� �븮 �ּ� ǰ
        SAFE_WRITER_NAME 			= (String)mapresult.get("NAME");								//240222 �赿�� ���������� ���� �߰�
        //sGender 				= (String)mapresult.get("GENDER");
        //sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
        //sDupInfo 				= (String)mapresult.get("DI");
       // sConnInfo 			= (String)mapresult.get("CI");
        sAuthType 			= " ";
        //sName 					= replaceNameToAstar((String)mapresult.get("NAME"));		//2022.06.21 �赿�� �븮 �ּ�ó��
        //sBirthDate 			= " ";															//2022.06.21 �赿�� �븮 �ּ�ó��
        sGender 				= " ";
        sNationalInfo  	= " ";
        sDupInfo 				= " ";
        sConnInfo 			= " ";
        
        
        
        
        //==========================================================�������
	    // �޴��� ��ȣ : MOBILE_NO => (String)mapresult.get("MOBILE_NO");
		// ����� ���� : MOBILE_CO => (String)mapresult.get("MOBILE_CO");
		// checkplus_success ���������� ����� null �� ���, ���� ���Ǵ� ��������ڿ��� �Ͻñ� �ٶ��ϴ�.
        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
        if(!sRequestNumber.equals(session_sRequestNumber))
        {
            sMessage = "���ǰ��� �ٸ��ϴ�. �ùٸ� ��η� �����Ͻñ� �ٶ��ϴ�.";
            sResponseNumber = "";
            sAuthType = "";
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
				alert('�������� �ý��� �����Դϴ�. ����ڿ��� ���� �ٶ��ϴ�');
				window.close();
			</script>
<%
		} else {
			session.setAttribute("session_sDupInfo" , sDupInfo);
			// ������� : ����Ȯ�� ��ȸ ���� ��ġ �ݿ�
			// 240222 �������� ��ȸ ����� ��ġ�� ���� ���� ��ȭ���� 
			session.setAttribute("sName", sName);
			session.setAttribute("SAFE_WRITER_NAME", SAFE_WRITER_NAME);
			session.setAttribute("sBirthDate", sBirthDate);
			// 240222 �������� ��ȸ ����� ��ġ�� ���� ���� ��ȭ��
%>
			<script>
// 				alert('������ ���������� �Ϸ�Ǿ����ϴ�. ȸ������ �������� �̵��մϴ�');

//				2020.05.10 ���� ���� �������� ����Ʈ==================================================================
				window.opener.document.getElementById("sN").value = '<%=sName%>';
				window.opener.document.getElementById("SAFE_WRITER_NAME").value = '<%=sName%>';
				window.opener.document.getElementById("sD").value = '<%=sDupInfo%>';
				window.opener.document.getElementById("sB").value = '<%=sBirthDate%>';

				window.opener.document.getElementById("sName").value = '<%=sName%>';
				window.opener.document.getElementById("sDupInfo").value = '<%=sDupInfo%>';
				window.opener.document.getElementById("sBirthDate").value = '<%=sBirthDate%>';     
//				============================================================================================

// 				window.opener.document.getElementById("autof").action = '/gugak_member/html/member/join.jsp';
// 				window.opener.document.getElementById("autof").submit();
// 				window.close();

				opener.SafeSuccess();
				window.close();
			</script>
<%
		}
%>
