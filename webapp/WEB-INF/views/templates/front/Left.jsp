<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

	<!--container-->
	<a id="hiddenFocus" name="hiddenFocus"></a>
    <div id="container">
    	<!--container_area-->
        <div class="container_area">
        	<!--lnb_area-->
        	<c:choose>
				<c:when test="${MENU.topMenuId == '197'}">
        	<div class="lnb_area">
            	<div class="lnb_title_area">
                	<p>Main Business</p>
                    <h2 class="lnb_title">${
                    fn:replace(
	                    fn:replace(
		                    fn:replace(
		                    	fn:replace(
			                    	fn:replace(
				                    	fn:replace(
					                    	fn:replace(
						                    	fn:replace(
						                    		fn:replace(MENU.menuNavi,'주요업무>','')
						                    	,'>','')
					                    	,MENU.menuNm,'')
				                    	,'모태','<br>모태')
			                    	,'크라','<br>크라')
		                    	,'재보','<br>재보')
		                    ,'정책','<br>정책')
	                    ,'융자','<br>융자')
					,'양식수산물','양식수산물<br>')}</h2>
                </div>
                <ul class="lnb leftmenu">
                	<c:set var="tabnum" value="0" />
                	<c:if test="${MENU.upMenuId=='21'}">
                	<c:set var="tabnum" value="1" />
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5320' or savedMenuId == '5320' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=44&menuId=5320" class="${selchk}" title="업무소개 페이지로 이동">
                            업무소개
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5321' or savedMenuId == '5321' ?'selected':''}" />
                        <a href="/front/invest/investListPage.do?contId=45&menuId=5321" class="${selchk}" title="농림수산식품투자조합 페이지로 이동">
                            농림수산식품투자조합
                        </a>
                    </li>
                    <li>
                        <a href="https://assist.apfs.kr" title="ASSIST(농식품 투자정보 플랫폼) 새창 바로가기" target="_blank">
                            ASSIST<br>(농식품 투자정보 플랫폼)&nbsp;<img src="/images/common/ico_new_win.png" alt="새창">
                        </a>
                    </li>
                    <li style="display:none;">
                    	<c:set var="selchk" value="${param.menuId eq '5383' or savedMenuId == '5383' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=20038&menuId=5383" class="${selchk}" title="동영상 자료실 페이지로 이동">
                            동영상 자료실
                        </a>
                    </li>
                    <li style="display:none;">
                    	<c:set var="selchk" value="${param.menuId eq '5384' or savedMenuId == '5384' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=20039&menuId=5384" class="${selchk}" title="펀드투자 우수사례 페이지로 이동">
                            펀드투자 우수사례
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5385' or savedMenuId == '5385' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=97&menuId=5385" class="${selchk}" title="관련 법령 페이지로 이동">
                            관련 법령
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5386' or savedMenuId == '5386' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=5386&selTab=${tabnum}" class="${selchk}" title="공지사항 페이지로 이동">
                            공지사항
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5387' or savedMenuId == '5387' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=51&menuId=5387&selTab=${tabnum}" class="${selchk}" title="질의응답(Q&A) 페이지로 이동">
                            질의응답(Q&amp;A)
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5388' or savedMenuId == '5388' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=52&menuId=5388&selTab=${tabnum}" class="${selchk}" title="FAQ 페이지로 이동">
                            FAQ
                        </a>
                    </li>
		    <li>
                        <a href="https://blog.naver.com/apfs0519" target="_blank" title="농림수산식품모태펀드 홍보 블로그 새창 열림">
                            홍보 블로그&nbsp;<img src="/images/common/ico_new_win.png" alt="새창">
                        </a>
                    </li>
                    </c:if>
                    <c:if test="${MENU.upMenuId=='22'}">
                    <c:set var="tabnum" value="2" />
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5322' or savedMenuId == '5322' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=53&menuId=5322" class="${selchk}" title="업무소개 페이지로 이동">
                            업무소개
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5393' or savedMenuId == '5393' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=5393&selTab=${tabnum}" class="${selchk}" title="공지사항 페이지로 이동">
                            공지사항
                        </a>
                    </li>
                    <li>
                        <a href="https://assist.apfs.kr" title="ASSIST(농식품 투자정보 플랫폼) 새창 바로가기" target="_blank">
                            ASSIST<br>(농식품 투자정보 플랫폼) &nbsp;<img src="/images/common/ico_new_win.png" alt="새창">
                        </a>
                    </li>
                    <li>
                        <a href="http://agrocrowd.kr/" target="_blank" title="농식품 크라우드펀딩 전용관 새창 바로가기">
                            농식품 크라우드펀딩<br>전용관 바로가기 &nbsp;<img src="/images/common/ico_new_win.png" alt="새창">
                        </a>
                    </li>
                    </c:if>
                <c:if test="${MENU.upMenuId=='23'}">
                <c:set var="tabnum" value="3" />
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5324' or savedMenuId == '5324' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=54&menuId=5324" class="${selchk}" title="업무소개 페이지로 이동">
                            업무소개
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5325' or savedMenuId == '5325' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=55&menuId=5325" class="${selchk}" title="상품소개 더보기" onclick="return false;">
                            상품소개
                        </a>
                        <ul class="lnb_2depth"> <!-- 20230510 : style="display: block;" 제거 -->
                            <li><a href="/front/contents/sub.do?contId=55&menuId=5325" class="${param.contId eq '55' ?'selected':''}" title="농작물재해보험 페이지로 이동">농작물재해보험</a></li>
                            <li><a href="/front/contents/sub.do?contId=90&menuId=5325" class="${param.contId eq '90' ?'selected':''}" title="농업수입보장보험 페이지로 이동">농업수입보장보험</a></li>
                            <li><a href="/front/contents/sub.do?contId=91&menuId=5325" class="${param.contId eq '91' ?'selected':''}" title="가축재해보험 페이지로 이동">가축재해보험</a></li>
                            <li><a href="/front/contents/sub.do?contId=92&menuId=5325" class="${param.contId eq '92' ?'selected':''}" title="농업인안전재해보험 페이지로 이동">농업인안전보험</a></li>
                            <li><a href="/front/contents/sub.do?contId=93&menuId=5325" class="${param.contId eq '93' ?'selected':''}" title="농작업근로자보장보험 페이지로 이동">농작업근로자안전보험</a></li>
                            <li><a href="/front/contents/sub.do?contId=94&menuId=5325" class="${param.contId eq '94' ?'selected':''}" title="농기계종합보험 페이지로 이동">농기계종합보험</a></li>
                        </ul>
                    </li>

                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5396' or savedMenuId == '5396' ?'selected':''}" />
                        <a href="/front/contents/disclosurePage.do?&menuId=5396" class="${selchk}" title="기준가격공시 페이지로 이동">
                            기준가격공시
                        </a>
                    </li>
                    <li style="display: none;">
                    	<c:set var="selchk" value="${param.menuId eq '5397' or savedMenuId == '5397' ?'selected':''}" />
                        <a href="#none" class="${selchk}" title="재해보험지도 페이지로 이동">
                            재해보험지도
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5398' or savedMenuId == '5398' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=20046&menuId=5398" class="${selchk}" title="사업시행지침 페이지로 이동">
                            사업시행지침
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5399' or savedMenuId == '5399' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=20058&menuId=5399" class="${selchk}" title="보험금 지급 사례 페이지로 이동">
                            보험금 지급 사례
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5400' or savedMenuId == '5400' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=99&menuId=5400" class="${selchk}" title="관련 법령 페이지로 이동">
                            관련 법령
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5401' or savedMenuId == '5401' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=5401&selTab=${tabnum}" class="${selchk}" title="공지사항 페이지로 이동">
                            공지사항
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5402' or savedMenuId == '5402' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=51&menuId=5402&selTab=${tabnum}" class="${selchk}" title="질의응답(Q&A) 페이지로 이동">
                            질의응답(Q&amp;A)
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5403' or savedMenuId == '5403' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=52&menuId=5403&selTab=${tabnum}" class="${selchk}" title="FAQ 페이지로 이동">
                            FAQ
                        </a>
                    </li>
<!--                     <li> -->
<%--                     	<c:set var="selchk" value="${param.menuId eq '5483' or savedMenuId == '5482' ?'selected':''}" /> --%>
<%--                         <a href="/front/contents/sub.do?contId=50&menuId=5483&selTab=${tabnum}" class="${selchk}" title="이의신청 페이지로 이동"> --%>
<!--                             이의신청 -->
<!--                         </a> -->
<!--                     </li> -->
                </c:if>
                <c:if test="${MENU.upMenuId=='5473'}"><!-- 양식수산물재해보험 -->
                <c:set var="tabnum" value="7" />
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5474' or savedMenuId == '5474' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=137&menuId=5474" class="${selchk}" title="업무소개 페이지로 이동">
                            업무소개
                        </a>
                    </li>
<!--                     <li> -->
<%--                     	<c:set var="selchk" value="${param.menuId eq '5475' or savedMenuId == '5475' ?'selected':''}" /> --%>
<%--                         <a href="/front/contents/sub.do?contId=138&menuId=5475" class="${selchk}" title="상품소개 페이지로 이동"> --%>
<!--                             상품소개 -->
<!--                         </a> -->
<!--                     </li> -->
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5476' or savedMenuId == '5476' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=20087&menuId=5476" class="${selchk}" title="사업시행지침 페이지로 이동">
                            사업시행지침
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5477' or savedMenuId == '5477' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=139&menuId=5477" class="${selchk}" title="관련 법령 페이지로 이동">
                            관련 법령
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5478' or savedMenuId == '5478' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=5478&selTab=${tabnum}" class="${selchk}" title="공지사항 페이지로 이동">
                            공지사항
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5479' or savedMenuId == '5479' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=51&menuId=5479&selTab=${tabnum}" class="${selchk}" title="질의응답(Q&A) 페이지로 이동">
                            질의응답(Q&amp;A)
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5480' or savedMenuId == '5480' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=52&menuId=5480&selTab=${tabnum}" class="${selchk}" title="FAQ 페이지로 이동">
                            FAQ
                        </a>
                    </li>
                </c:if>                
                <c:if test="${MENU.upMenuId=='5326'}">
                <c:set var="tabnum" value="4" />
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5327' or savedMenuId == '5327' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=57&menuId=5327" class="${selchk}" title="업무소개 페이지로 이동">
                            손해평가사 안내
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5369' or savedMenuId == '5369' ?'selected':''}" />
                        <a href="/front/event/eventList.do?menuId=5369" class="${selchk}" title="교육 페이지로 이동">
                            교육
                        </a>
                    </li>
                    <%-- <li>
                        <c:set var="selchk" value="${param.menuId eq '5378' or savedMenuId == '5378' ?'selected':''}" />
                        <a href="#none" class="${selchk}" title="마이페이지 페이지로 이동">
                            마이페이지
                        </a>
                        <ul class="lnb_2depth">
                           	
							<li>
								<a href="/front/mypage/mypageCheck.do?menuId=5378&menuDesc=1111" class="${param.menuDesc eq '1111' ?'selected':''}" title="내 정보 수정 페이지로 이동">내 정보 수정</a>	                        	
                        	</li>
                        	<li><a href="/front/mypage/myEdupageCheck.do?menuId=5378&menuDesc=1112" class="${param.menuDesc eq '1112' ?'selected':''}" title="교육신청 및 이력 페이지로 이동">교육신청 및 이력</a></li>
                        </ul>
                    </li>--%>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5404' or savedMenuId == '5404' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=20061&menuId=5404" class="${selchk}" title="동영상 자료실 페이지로 이동">
                            손해평가사 자료실
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5405' or savedMenuId == '5405' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=5405&selTab=${tabnum}" class="${selchk}" title="공지사항 페이지로 이동">
                            공지사항
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5406' or savedMenuId == '5406' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=51&menuId=5406&selTab=${tabnum}" class="${selchk}" title="질의응답(Q&A) 페이지로 이동">
                            질의응답(Q&amp;A)
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5407' or savedMenuId == '5407' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=52&menuId=5407&selTab=${tabnum}" class="${selchk}" title="FAQ 페이지로 이동">
                            FAQ
                        </a>
                    </li>
                    <!-- 2018.04.04 : 손해평가사 조회 메뉴 추가 -->
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5458' or savedMenuId == '5458' ?'selected':''}" />
                        <a href="/front/agrInsClaAdj/selectAgrInsClaAdj.do?menuId=5458" class="${selchk}" title="손해평가사 조회 페이지로 이동">
                            손해평가사조회
                        </a>
                    </li>
                </c:if>
                <c:if test="${MENU.upMenuId=='24'}">
                <c:set var="tabnum" value="0" />
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5456' or savedMenuId == '5456' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=58&menuId=5456"  class="${selchk}" title="기금공시 페이지로 이동">
                            기금공시
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5329' or savedMenuId == '5329' or param.menuId eq '5328' or savedMenuId == '5328' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=59&menuId=5329" class="${selchk}" title="개요 페이지로 이동">
                            개요
                        </a>
                    </li>
                    <li>
                        <c:set var="selchk" value="${param.menuId eq '5330' or savedMenuId == '5330' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=60&menuId=5330" class="${selchk}" title="설치 목적 및 근거 페이지로 이동">
                            설치 목적 및 근거
                        </a>
                    </li>
                    <li>
                        <c:set var="selchk" value="${param.menuId eq '5331' or savedMenuId == '5331' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=61&menuId=5331" class="${selchk}" title="기금의 조성 및 용도 페이지로 이동">
                            기금의 조성 및 용도
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5332' or savedMenuId == '5332' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=62&menuId=5332" class="${selchk}" title="동영상 자료실 페이지로 이동">
                            기금운용체계 및 관리 기관
                        </a>
                    </li>
                </c:if>
                <c:if test="${MENU.upMenuId=='25'}"><!-- 농림수산정책자금 검사 -->
                <c:set var="tabnum" value="5" />
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5333' or savedMenuId == '5333' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=63&menuId=5333" class="${selchk}" title="업무소개 페이지로 이동">
                            업무소개
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5481' or savedMenuId == '5334' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=64&menuId=5334" class="${selchk}" title="검사절차 페이지로 이동">
                            검사절차
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5408' or savedMenuId == '5408' ?'selected':''}" />
                        <!-- a target="_blank" href="http://www.apfs.kr/html/exam/index.html" title="검사사례 바로가기 새창 열림">검사사례&nbsp;<img src="/images/common/ico_new_win.png" alt="검사사례 바로가기 새창 열림"></a -->
                        <a target="_blank" href="/file/inspectExample/2021_Inspect_Examples.pdf" title="농림수산정책자금 검사사례집 pdf파일 새창" class="nongPdf">검사사례 &nbsp;<img src="/images/common/ico_new_win.png" alt="새창"></a>
                    </li> 
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5411' or savedMenuId == '5411' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=100&menuId=5411" class="${selchk}"  title="관련 법규 페이지로 이동">
                            관련 법규
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5413' or savedMenuId == '5413' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=51&menuId=5413&selTab=${tabnum}" class="${selchk}" title="질의응답(Q&A) 페이지로 이동">
                            질의응답(Q&amp;A)
                        </a>
                    </li>
                </c:if>
                <c:if test="${MENU.upMenuId=='26'}">
                <c:set var="tabnum" value="6" />
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5335' or savedMenuId == '5335' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=65&menuId=5335" class="${selchk}" title="업무소개 페이지로 이동">
                            업무소개
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5336' or savedMenuId == '5336' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=66&menuId=5336" class="${selchk}" title="사업현황 페이지로 이동">
                            사업현황
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5417' or savedMenuId == '5417' ?'selected':''}" />
                        <a href="/front/contents/sub.do?contId=101&menuId=5417" class="${selchk}" title="관련 법령 페이지로 이동">
                            관련 법령
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5418' or savedMenuId == '5418' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=5418&selTab=${tabnum}" class="${selchk}" title="공지사항 페이지로 이동">
                            공지사항
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5419' or savedMenuId == '5419' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=51&menuId=5419&selTab=${tabnum}" class="${selchk}" title="질의응답(Q&A) 페이지로 이동">
                            질의응답(Q&amp;A)
                        </a>
                    </li>
                    <li>
                    	<c:set var="selchk" value="${param.menuId eq '5420' or savedMenuId == '5420' ?'selected':''}" />
                        <a href="/front/board/boardContentsListPage.do?boardId=52&menuId=5420&selTab=${tabnum}" class="${selchk}" title="FAQ 페이지로 이동">
                            FAQ
                        </a>
                    </li>
                </c:if>
                </ul>
            </div>
            	</c:when>
				<c:otherwise>
			<div class="lnb_area">
            	<div class="lnb_title_area">
                    <h2 class="lnb_title">${MENU.topMenuNm}</h2>
                </div>
				<ul class="lnb leftmenu topnav"><!-- 여기에 좌측메뉴 -->
				</ul>
			</div>
				</c:otherwise>
            </c:choose>
            <!--//lnb_area-->
 
            <!--content_area--> 
            <div class="content_area">
            	<!--location_area-->
            	<div class="location_area">
                	<div class="location">
						<div class="lineMap"><!-- 웹접근성 문제로 수정 20.10.21 -->
							<span><a href="/front/user/main.do" title="메인으로 이동"><img src="/images/sub/ico_home.gif" alt="홈"></a></span>&nbsp;>
							<span id="lnb"></span>
						</div>
                           <script>
                           	var str = "${MENU.menuNavi}";
                           	var strArr = str.split(">");
                           	var $returnStr = "";
                           	var str2 = "${param.menuId}";
                           	var str3 = "${MENU.refUrl}";
                           	var str4 = "${MENU.topMenuId}";
                           	var str5 = "${MENU.topMenuNm}";
                           	var menuNm = "${MENU.menuNm}";
                           	var MENU = "${MENU}";
                           	//console.log("MENU==="+MENU);
                           	//console.log("menuId==="+str2);
                           	//console.log("refUrl==="+str3);
                           	//console.log("topMenuId==="+str4);
                           	//console.log("topMenuMn==="+str5);
                           	//console.log("menuNm==="+menuNm);
                           	//console.log("aaa==="+strArr);
                           	//console.log("bbb==="+strArr.indexOf('농식품전문 크라우드펀딩'));
                           	for(var i=0; i<strArr.length; i++){		/* 20220929 김동민 대리 웹 품질진단 */
                           		if(i==strArr.length-1){
                           			$returnStr += "<span text style='text-decoration: underline'>" + strArr[i] + "</span>";
                           		}
                           		else if(menuNm == '정보공개 안내'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=48&menuId=11' title=정보공개(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	
                           		}
                           		else if(menuNm == '사전공개정보'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=48&menuId=11' title=정보공개(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	
                           		}
                           		else if(menuNm == '정보공개 목록'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=48&menuId=11' title=정보공개(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	
                           		}
                           		else if(menuNm == '정보공개 청구'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=48&menuId=11' title=정보공개(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';
                           		}
                           		else if(menuNm == '공공데이터 개방'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=48&menuId=11' title=정보공개(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';
                           		}
                           		else if(menuNm == '사업실명제'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=48&menuId=11' title=정보공개(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';
                           		}
                           		else if(strArr == '주요업무,농림수산식품모태펀드,업무소개'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=44&menuId=5320' title=농림수산식품모태펀드(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                  			
                           		}
                           		else if(strArr == '주요업무,농림수산식품모태펀드,농림수산식품투자조합'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=44&menuId=5320' title=농림수산식품모태펀드(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                   			
                           		}
                           		else if(strArr == '주요업무,농림수산식품모태펀드,관련 법령'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=44&menuId=5320' title=농림수산식품모태펀드(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                    			
                           		}
                           		else if(strArr == '주요업무,농림수산식품모태펀드,공지사항'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=44&menuId=5320' title=농림수산식품모태펀드(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                   			
                           		}
                           		else if(strArr == '주요업무,농림수산식품모태펀드,질의응답(Q&A)'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=44&menuId=5320' title=농림수산식품모태펀드(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                     			
                           		}
                           		else if(strArr == '주요업무,농림수산식품모태펀드,FAQ'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=44&menuId=5320' title=농림수산식품모태펀드(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                     			
                           		}
                           		else if(strArr == '주요업무,농식품전문 크라우드펀딩,업무소개'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=53&menuId=5322' title=농식품전문크라우드펀딩(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                         			
                           		}
                           		else if(strArr == '주요업무,농식품전문 크라우드펀딩,공지사항'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=53&menuId=5322' title=농식품전문크라우드펀딩(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                       			
                           		}
                           		else if(strArr == '주요업무,농업정책보험,업무소개'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=54&menuId=5324' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,농업정책보험,상품소개'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=54&menuId=5324' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,농업정책보험,기준가격공시'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=54&menuId=5324' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,농업정책보험,사업시행지침'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=54&menuId=5324' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,농업정책보험,보험금 지급 사례'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=54&menuId=5324' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,농업정책보험,관련 법령'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=54&menuId=5324' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,농업정책보험,공지사항'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=54&menuId=5324' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,농업정책보험,질의응답(Q&A)'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=54&menuId=5324' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,농업정책보험,FAQ'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=54&menuId=5324' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,농업정책보험,이의신청'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=54&menuId=5324' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,양식수산물 재해보험,업무소개'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=137&menuId=5474' title=양식수산물 재해보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,양식수산물 재해보험,상품소개'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=137&menuId=5474' title=양식수산물 재해보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,양식수산물 재해보험,사업시행지침'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=137&menuId=5474' title=양식수산물 재해보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,양식수산물 재해보험,관련 법령'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=137&menuId=5474' title=양식수산물 재해보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,양식수산물 재해보험,공지사항'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=137&menuId=5474' title=양식수산물 재해보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,양식수산물 재해보험,질의응답(Q&A)'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=137&menuId=5474' title=양식수산물 재해보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,양식수산물 재해보험,FAQ'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=137&menuId=5474' title=양식수산물 재해보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,손해평가사,손해평가사 안내'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=57&menuId=5327' title=손해평가사(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                          			
                           		}
                           		else if(strArr == '주요업무,손해평가사,교육'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=57&menuId=5327' title=손해평가사(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                           			
                           		}
                           		else if(strArr == '주요업무,손해평가사,마이페이지'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=57&menuId=5327' title=손해평가사(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                           			
                           		}
                           		else if(strArr == '주요업무,손해평가사,손해평가사 자료실'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=57&menuId=5327' title=손해평가사(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                 			
                           		}
                           		else if(strArr == '주요업무,손해평가사,공지사항'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=57&menuId=5327' title=손해평가사(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                    			
                           		}
                           		else if(strArr == '주요업무,손해평가사,질의응답(Q&A)'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=57&menuId=5327' title=손해평가사(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                     			
                           		}
                           		else if(strArr == '주요업무,손해평가사,FAQ'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=57&menuId=5327' title=손해평가사(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';         			
                           		}
                           		else if(strArr == '주요업무,손해평가사,손해평가사조회'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=57&menuId=5327' title=손해평가사(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농어업재해재보험기금,기금공시'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=58&menuId=5456' title=농어업재해재보험기금(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농어업재해재보험기금,개요'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=58&menuId=5456' title=농어업재해재보험기금(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농어업재해재보험기금,설치 목적 및 근거'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=58&menuId=5456' title=농어업재해재보험기금(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농어업재해재보험기금,기금의 조성 및 용도'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=58&menuId=5456' title=농어업재해재보험기금(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농어업재해재보험기금,기금운용체계 및 관리 기관'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=58&menuId=5456	' title=농어업재해재보험기금(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농림수산정책자금 검사,업무소개'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=63&menuId=5333' title=농림수산정책자금 검사(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농림수산정책자금 검사,검사절차'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=63&menuId=5333' title=농림수산정책자금 검사(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농림수산정책자금 검사,관련 법규'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=63&menuId=5333' title=농림수산정책자금 검사(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농림수산정책자금 검사,질의응답(Q&A)'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=63&menuId=5333' title=농림수산정책자금 검사(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농특회계 융자금 관리,업무소개'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=65&menuId=5335' title=농특회계 융자금 관리(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농특회계 융자금 관리,사업현황'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=65&menuId=5335' title=농특회계 융자금 관리(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농특회계 융자금 관리,관련 법령'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=65&menuId=5335' title=농특회계 융자금 관리(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농특회계 융자금 관리,공지사항'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=65&menuId=5335' title=농특회계 융자금 관리(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농특회계 융자금 관리,질의응답(Q&A)'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=65&menuId=5335' title=농특회계 융자금 관리(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '주요업무,농특회계 융자금 관리,FAQ'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=65&menuId=5335' title=농특회계 융자금 관리(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	       			
                           		}
                           		else if(strArr == '자료실,농림수산식품모태펀드,투자유치 자료실'){
                           			$returnStr += "<a href='/front/board/boardContentsListPage.do?boardId=20076&menuId=5347' title=농림수산식품모태펀드(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                      			
                           		}
                           		else if(strArr == '자료실,농림수산식품모태펀드,동영상 자료실'){
                           			$returnStr += "<a href='/front/board/boardContentsListPage.do?boardId=20076&menuId=5347' title=농림수산식품모태펀드(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	               			
                           		}
                           		else if(strArr == '자료실,농림수산식품모태펀드,관련 법령'){
                           			$returnStr += "<a href='/front/board/boardContentsListPage.do?boardId=20076&menuId=5347' title=농림수산식품모태펀드(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '자료실,농업정책보험,기준가격공시'){
                           			$returnStr += "<a href='/front/contents/disclosurePage.do?&menuId=5361' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                        			
                           		}
                           		else if(strArr == '자료실,농업정책보험,사업시행지침'){
                           			$returnStr += "<a href='/front/contents/disclosurePage.do?&menuId=5361' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                        			
                           		}
                           		else if(strArr == '자료실,농업정책보험,농업재해보험심의회'){
                           			$returnStr += "<a href='/front/contents/disclosurePage.do?&menuId=5361' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                        			
                           		}
                           		else if(strArr == '자료실,농업정책보험,보험금 지급 사례'){
                           			$returnStr += "<a href='/front/contents/disclosurePage.do?&menuId=5361' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                        			
                           		}
                           		else if(strArr == '자료실,농업정책보험,관련 법령'){
                           			$returnStr += "<a href='/front/contents/disclosurePage.do?&menuId=5361' title=농업정책보험(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                        			
                           		}
                           		else if(strArr == '자료실,농업정책보험 실적집계,주요지표'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=133&menuId=5365' title=농업정책보험실적집계(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                			
                           		}
                           		else if(strArr == '자료실,농업정책보험 실적집계,농작물재해보험'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=133&menuId=5365' title=농업정책보험실적집계(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';		
                           		}
                           		else if(strArr == '자료실,농업정책보험 실적집계,가축재해보험'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=133&menuId=5365' title=농업정책보험실적집계(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';
                           		}
                           		else if(strArr == '자료실,농업정책보험 실적집계,보험료 수준'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=133&menuId=5365' title=농업정책보험실적집계(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';
                           		}
                           		else if(strArr == '자료실,손해평가사 자료실'){
                           			$returnStr += "<a href='/front/board/boardContentsListPage.do?boardId=20061&menuId=5370' title=자료실(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                    			
                           		}
                           		else if(strArr == '자료실,농림수산정책자금 검사,관련 법규'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=100&menuId=5358' title=농림수산정책자금검사(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                  			
                           		}
                           		else if(strArr == '자료실,농특회계 융자금 관리,관련 법령'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=101&menuId=5376' title=농특회계융자금 관리(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';              			
                           		}
                           		else if(strArr == '알림마당,공지사항'){
                           			$returnStr += "<a href='/front/board/boardContentsListPage.do?boardId=10026&menuId=41' title=알림마당(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                    			
                           		}
                           		else if(strArr == '알림마당,보도자료'){
                           			$returnStr += "<a href='/front/board/boardContentsListPage.do?boardId=10026&menuId=41' title=알림마당(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                      			
                           		}
                           		else if(strArr == '알림마당,채용·행사'){
                           			$returnStr += "<a href='/front/board/boardContentsListPage.do?boardId=10026&menuId=41' title=알림마당(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';             			
                           		}
                           		else if(strArr == '알림마당,해명·설명'){
                           			$returnStr += "<a href='/front/board/boardContentsListPage.do?boardId=10026&menuId=41' title=알림마당(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                       			
                           		}
                           		else if(strArr == '알림마당,포토뉴스'){
                           			$returnStr += "<a href='/front/board/boardContentsListPage.do?boardId=10026&menuId=41' title=알림마당(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                      			
                           		}
                           		else if(strArr == '알림마당,입찰정보'){
                           			$returnStr += "<a href='/front/board/boardContentsListPage.do?boardId=10026&menuId=41' title=알림마당(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                 			
                           		}
                           		else if(strArr == '알림마당,개인정보처리방침'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=46&menuId=5483' title=알림마당(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                 			
                           		}
                           		else if(strArr == '고객참여,고객헌장,전문'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=129&menuId=5462' title=고객참여(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '고객참여,고객헌장,핵심서비스 이행표준'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=129&menuId=5462' title=고객참여(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '고객참여,고객헌장,고객응대서비스 이행표준'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=129&menuId=5462' title=고객참여(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '고객참여,질의응답&#40;Q&A&#41;'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=129&menuId=5462' title=고객참여(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '고객참여,FAQ'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=129&menuId=5462' title=고객참여(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '고객참여,고객제안'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=129&menuId=5462' title=고객참여(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '고객참여,국민신문고'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=129&menuId=5462' title=고객참여(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '고객참여,국민제안'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=129&menuId=5462' title=고객참여(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '고객참여,부정부패&nbsp;&middot;&nbsp;공익 신고마당'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=129&menuId=5462' title=고객참여(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '고객참여,농림수산정책자금 부당사용 신고센터'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=129&menuId=5462' title=고객참여(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '기관 소개,농업정책보험금융원 소개,임무'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=68&menuId=5338' title=농금원개요(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '기관 소개,농업정책보험금융원 소개,인사말'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=68&menuId=5338' title=농금원개요(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '기관 소개,농업정책보험금융원 소개,연혁'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=68&menuId=5338' title=농금원개요(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '기관 소개,농업정책보험금융원 소개,미션/비전'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=68&menuId=5338' title=농금원개요(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '기관 소개,농업정책보험금융원 소개,조직 및 직원'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=68&menuId=5338' title=농금원개요(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '기관 소개,농업정책보험금융원 소개,CI소개'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=68&menuId=5338' title=농금원개요(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '기관 소개,농업정책보험금융원 소개,찾아오시는 길'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=68&menuId=5338' title=농금원개요(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';	                			
                           		}
                           		else if(strArr == '기관 소개,열린경영,경영공시(알리오)'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=75&menuId=5345' title=열린경영(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';    
                           		}
                           		else if(strArr == '기관 소개,열린경영,윤리경영'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=75&menuId=5345' title=열린경영(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';    
                           		}
                           		else if(strArr == '기관 소개,열린경영,청렴한 농금원'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=75&menuId=5345' title=열린경영(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                       			
                           		}
                           		else if(strArr == '기관 소개,열린경영,사회공헌'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=75&menuId=5345' title=열린경영(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';               			
                           		}
                           		else if(strArr == '기관 소개,열린경영,인권경영'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=75&menuId=5345' title=열린경영(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                      			
                           		}
                           		else if(strArr == '기관 소개,열린경영,ESG경영'){
                           			$returnStr += "<a href='/front/contents/sub.do?contId=152&menuId=5345' title=열린경영(으)로이동>" + strArr[i] + "</a>" + '&nbsp;>&nbsp;';                      			
                           		}
                           	}
                           	$("#lnb").html($returnStr);
                           	
                         // LNB sub menu slide Start
            			    $(".lnb_2depth").siblings("a").addClass("ico_ext");
            			    $(".lnb_2depth li a.selected").parent().parent(".lnb_2depth").css({"display":"block"});
            			    $(".lnb_2depth li a.selected").parent("li").parent().siblings("a").addClass("selected");
//             			    $(".lnb li a.selected").attr("title","하위메뉴 펼치기");		/*23년 웹접근성*/
            			    $(".lnb li a.ico_ext").attr("title","하위메뉴 펼치기");
            			    $(".lnb li a.selected").attr("title","선택됨");
            			    if($(".lnb li a").hasClass('selected ico_ext') == true){	
            			    	$(".lnb li a.selected").attr("title","하위메뉴 접기");		
            			    }
            			    $(".lnb_2depth li a.selected").attr("title","선택됨");
            			    $(".lnb li a").click(function(){
            			        if($(this).siblings(".lnb_2depth").css("display") == "none"){
            			            $(this).siblings(".lnb_2depth").stop().slideDown(300);
            			            $(this).addClass("selected");
            			            $(this).attr("title","하위메뉴 접기");		/*23년 웹접근성*/
//             			            $(".lnb_2depth li a.selected").attr("title","선택됨");
            			        }else{
            			            $(this).siblings(".lnb_2depth").stop().slideUp(300);
            			            $(this).removeClass("selected");
            			            $(this).removeAttr("title");		/*23년 웹접근성*/
            			            $(this).attr("title","하위메뉴 펼치기");
//             			            $(".lnb_2depth li a").removeAttr("title");
            			        }
            			    });
            			    
            			    $(".lnb_2depth li a").click(function(){			//2024 웹 접근성
            			        if($(this).hasClass("selected") != true){	//2024 웹 접근성
            			        	$(this).addClass("selected");			//2024 웹 접근성
            			        	if($(this).hasClass("nongPdf") == true){
            			        		$(this).removeClass("selected");
            				    		$(this).removeAttr("title");
            				    		$(this).attr("title","농림수산정책자금 검사사례집 pdf파일 새창");
            				    	}else{
            				    		$(this).attr("title","선택됨");			//2024 웹 접근성
            				    	}
            			        }else{										//2024 웹 접근성
            			            $(this).removeClass("selected");		//2024 웹 접근성
            			            $(this).removeAttr("title");			//2024 웹 접근성
            			        }
            			    });												//2024 웹 접근성
                           	
                           </script>
                    </div>
               </div>
                <!--//location_area-->