<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<jsp:useBean id="toDay" class="java.util.Date" />
<%@ page import="java.io.IOException" %>
<%!
private String subString(String strData, int iStartPos, int iByteLength) throws Exception{
	byte[] bytTemp = null;
	int iRealStart = 0;
	int iRealEnd = 0;
	int iLength = 0;
	int iChar = 0;

	try {
		// UTF-8로 변환하는경우 한글 2Byte, 기타 1Byte로 떨어짐
		bytTemp = strData.getBytes("EUC-KR");
		iLength = bytTemp.length;

		for(int iIndex = 0; iIndex < iLength; iIndex++) {
			if(iStartPos <= iIndex) {
				break;
			}
			iChar = (int)bytTemp[iIndex];
			if((iChar > 127)|| (iChar < 0)) {
				// 한글의 경우(2byte 통과처리)
				// 한글은 2Byte이기 때문에 다음 글자는 볼것도 없이 스킵한다
				iRealStart++;
				iIndex++;
			} else {
				// 기타 글씨(1Byte 통과처리)
				iRealStart++;
			}
		}

		iRealEnd = iRealStart;
		int iEndLength = iRealStart + iByteLength;
		for(int iIndex = iRealStart; iIndex < iEndLength; iIndex++)
		{
			iChar = (int)bytTemp[iIndex];
			if((iChar > 127)|| (iChar < 0)) {
				// 한글의 경우(2byte 통과처리)
				// 한글은 2Byte이기 때문에 다음 글자는 볼것도 없이 스킵한다
				iRealEnd++;
				iIndex++;
			} else {
				// 기타 글씨(1Byte 통과처리)
				iRealEnd++;
			}
		}
	} catch(IOException e) {
		System.out.println("IOException 에러!" + e);
	}
	finally{
		return strData.substring(iRealStart, iRealEnd);
	}
}



%>


		<div class="search_item">
        	<div class="search_tit">
                <h4>관련콘텐츠 [ <span id="Ccnt">${totalcnt}</span>건 ]</h4>
                <c:if test="${totalcnt>3}">
                <a href="javascript: searchAll('C')" class="btn_search_add" id="more" title="관련콘텐츠 더보기">
                    <span>더보기 +</span>
                </a>
                </c:if>
            </div>
            <ul>
            	<c:choose>
            	<c:when test='${empty boardList}'>
            	<li>&#183; "<span style="color:#f47251; font-weight:bold;">${param.searchTxt}</span>"에 대한 검색결과가 없습니다.<br><%  // 검색결과 없음 %>
            	     &#183; 철자나 맞춤법 오류가 있는지 확인해주세요.<br>
            	     &#183; 보다 일반적인 단어로 검색하거나 다른 검색어로 검색해주세요.</li>
            	</c:when>
            	<c:when test='${not empty boardList}'>
            	<c:forEach items="${boardList }" var="searchinfo" varStatus="i">
            	<li>
                    <a href="${searchinfo.refUrl}<c:if test="${fn:indexOf(searchinfo.refUrl,'menuId')<0}">&menuId=${searchinfo.menuId}</c:if>" target="_blank" title="해당 컨텐츠로 새창 이동" style="display:block;">
                    	<p class="search_ctn_tit">[${searchinfo.menuNmPath}] ${searchinfo.title}</p><!--검색단어가 들어간 메뉴명-->
                        <p class="search_word">
                        	<c:set var="text" value="${fn:replace(searchinfo.contents, cn, br)}"  scope="request"/>
	                    	<% String Txt = request.getAttribute("text").toString().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");%>
							<%=subString(Txt,0,500)%>
                        </p>
                    </a>
                </li>
                </c:forEach>
                </c:when>
                </c:choose>
            </ul>
        </div>
		<!--// list_table_area -->
		<div id="Cpage" style="display:none;">
		<!-- paging_area -->
		${boardPagging}
		<!--// paging_area -->
		</div>