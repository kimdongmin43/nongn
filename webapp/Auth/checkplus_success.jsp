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
	
  	//230714 SW보안약점 진단으로 암호화 처리
    String sSiteCode = (String) pageContext.getAttribute("sSiteCode");		// NICE로부터 부여받은 사이트 코드
    String sSitePassword = (String) pageContext.getAttribute("sSitePassword");		// NICE로부터 부여받은 사이트 패스워드
  	//String sSiteCode = kr.apfs.local.common.util.CryptoUtil.AES_Decode("sSiteCode");
    
    //System.out.println("sSiteCode :" + sSiteCode);
    

    String sCipherTime = "";				 // 복호화한 시간
    String sRequestNumber = "";			 // 요청 번호
    String sResponseNumber = "";		 // 인증 고유번호
    String sAuthType = "";				   // 인증 수단
    String sName = "";							 // 성명
    String SAFE_WRITER_NAME = "";							 // 성명2 240222 김동민 본인인증우회 추가조치를 위해 추가
    String sDupInfo = "";						 // 중복가입 확인값 (DI_64 byte)
    String sConnInfo = "";					 // 연계정보 확인값 (CI_88 byte)
    String sBirthDate = "";					 // 생일
    String sGender = "";						 // 성별
    String sNationalInfo = "";       // 내/외국인정보 (개발가이드 참조)
    String sMessage = "";
    String sPlainData = "";

    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if( iReturn == 0 )
    {
        sPlainData = niceCheck.getPlainData();
        sCipherTime = niceCheck.getCipherDateTime();

        // 데이타를 추출합니다.
        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
        sResponseNumber = (String)mapresult.get("RES_SEQ");
        //20.05.11 개인정보 처리 적용에 의한 저장X
        //sAuthType 			= (String)mapresult.get("AUTH_TYPE");							
        //sName 					= replaceNameToAstar((String)mapresult.get("NAME"));
        sName 					= (String)mapresult.get("NAME");								//2022.06.21 김동민 대리 replaceNameToAstar 제거
        sBirthDate 			= (String)mapresult.get("BIRTHDATE");								//2022.06.21 김동민 대리 주석 품
        SAFE_WRITER_NAME 			= (String)mapresult.get("NAME");								//240222 김동민 본인인증을 위해 추가
        //sGender 				= (String)mapresult.get("GENDER");
        //sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
        //sDupInfo 				= (String)mapresult.get("DI");
       // sConnInfo 			= (String)mapresult.get("CI");
        sAuthType 			= " ";
        //sName 					= replaceNameToAstar((String)mapresult.get("NAME"));		//2022.06.21 김동민 대리 주석처리
        //sBirthDate 			= " ";															//2022.06.21 김동민 대리 주석처리
        sGender 				= " ";
        sNationalInfo  	= " ";
        sDupInfo 				= " ";
        sConnInfo 			= " ";
        
        
        
        
        //==========================================================여기까지
	    // 휴대폰 번호 : MOBILE_NO => (String)mapresult.get("MOBILE_NO");
		// 이통사 정보 : MOBILE_CO => (String)mapresult.get("MOBILE_CO");
		// checkplus_success 페이지에서 결과값 null 일 경우, 관련 문의는 관리담당자에게 하시기 바랍니다.
        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
        if(!sRequestNumber.equals(session_sRequestNumber))
        {
            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
            sResponseNumber = "";
            sAuthType = "";
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
				alert('본인인증 시스템 오류입니다. 담당자에게 문의 바랍니다');
				window.close();
			</script>
<%
		} else {
			session.setAttribute("session_sDupInfo" , sDupInfo);
			// 웹취약점 : 본인확인 우회 가능 조치 반영
			// 240222 본인인증 우회 취약점 조치를 위한 인증 강화시작 
			session.setAttribute("sName", sName);
			session.setAttribute("SAFE_WRITER_NAME", SAFE_WRITER_NAME);
			session.setAttribute("sBirthDate", sBirthDate);
			// 240222 본인인증 우회 취약점 조치를 위한 인증 강화끝
%>
			<script>
// 				alert('인증이 성공적으로 완료되었습니다. 회원가입 페이지로 이동합니다');

//				2020.05.10 까지 저장 개인정보 리스트==================================================================
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
