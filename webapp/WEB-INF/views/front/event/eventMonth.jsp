<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ page import="java.util.*"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="thisDt"/>
<c:set var="TODAY" value="${now}"  scope="request"/>
<c:set var="NowYear" value="${SEARCHYEAR}"  scope="request"/>
<c:set var="NowMonth" value="${SEARCHMONTH}"  scope="request"/>
<%

%>
		<!-- tab_menu -->
        <div class="tab_menu">
            <ul>
                <li class="w3"><a href="javascript: eventSearch('01')" class="<c:if test="${param.SCHD_CLASS eq '01'}">active</c:if>">실무교육</a></li>
                <li class="w3"><a href="javascript: eventSearch('02')" class="<c:if test="${param.SCHD_CLASS eq '02'}">active</c:if>">보수교육</a></li>
                <li class="w3"><a href="javascript: eventSearch('03')" class="<c:if test="${param.SCHD_CLASS eq '03'}">active</c:if>">수시교육</a></li>
            </ul>
        </div>
        <!-- //tab_menu -->

        <!--tab_schedule-->
        <h4 class="hidden" id="hiddenString">실무교육</h4>
        <h5 id="hiddenYM"class="hidden hiddenYM">월간</h5>
        <div class="tab_style3">
        	<ul>
            	<li class="w2"><a href="javascript: eventList()" id="schedule_y">연간</a></li>
                <li class="w2"><a href="#none" class="active" id="schedule_m">월간</a></li>
            </ul>
        </div>
        <!--tab_schedule-->

		<!--연간 schedule_control-->
        <div class="schedule_control">
            <a href="javascript: monMove(-1);">
                <img src="/images/common/btn_schdule_prev.png" alt="이전 ${(SEARCHMONTH)==1?12:(SEARCHMONTH-1)}월로 이동">   
            </a>
            <span><em>${SEARCHYEAR}</em>년 <em>${SEARCHMONTH}</em>월</span>
            <a href="javascript: monMove(1);">
                <img src="/images/common/btn_schdule_next.png" alt="다음 ${(SEARCHMONTH)==12?1:(SEARCHMONTH+1)}월로 이동" />
            </a>
     	</div>
        <!--//연간 schedule_control도-->
		<!--연간 일정 리스트-->

				<div class="calendar">
                    <table width="100%">
                       <caption>${SEARCHMONTH}월 일별 일정표.요일,날짜별로 확인할 수 있는 ${SEARCHMONTH}월 일별 교육일정안내입니다.</caption>
                       <colgroup>
                           <col width="14.2857%" />
                           <col width="14.2857%" />
                           <col width="14.2857%" />
                           <col width="14.2857%" />
                           <col width="14.2857%" />
                           <col width="14.2857%" />
                           <col width="14.2857%" />
                       </colgroup>
                       <thead>
                           <tr>
                               <th scope="col">일</th>
                               <th scope="col">월</th>
                               <th scope="col">화</th>
                               <th scope="col">수</th>
                               <th scope="col">목</th>
                               <th scope="col">금</th>
                               <th scope="col">토</th>
                           </tr>
                       </thead>
                       <tbody>
                       	<tr class="calendar_week">
<%
	Calendar cal = Calendar.getInstance();
	String strNowYear = request.getAttribute("NowYear").toString();
	String strNowMonth = request.getAttribute("NowMonth").toString();
	String TODAY = request.getAttribute("TODAY").toString();

	int NowYear = strNowYear.equals("") ? cal.get(Calendar.YEAR) : Integer.parseInt(strNowYear);
	int NowMonth = strNowMonth.equals("") ? cal.get(Calendar.MONTH) : Integer.parseInt(strNowMonth)-1;

	cal.set(NowYear, NowMonth, 1);
	int bgnWeek = cal.get(Calendar.DAY_OF_WEEK);

	String SITE_IDX = "1";
	String visible = "Y";

	String chkDate		= "";

	String dayDisp = "";
	String dayDisp1 = "";
	String chkfDate = "";

	String DispYear 	= String.valueOf(NowYear);
	String DispMonth 	= "";

    // 시작요일까지 이동
    for (int i=1; i<bgnWeek; i++) {
    	out.println("<td>");
    	out.println("</td>");
    }

	while ( cal.get(Calendar.MONTH) == NowMonth) {
		chkDate		= "";
		chkfDate	= "";
		dayDisp 	= "";
		dayDisp1 	= "";

    	if (cal.get(Calendar.DATE) < 10) {
    		chkDate= chkDate + "0" + String.valueOf(cal.get(Calendar.DATE));
    	} else {
    		chkDate= chkDate + String.valueOf(cal.get(Calendar.DATE));
    	}

    	if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
    		dayDisp = "sun";
    		dayDisp1 = "SUN";
    	} else if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
    		dayDisp = "sat";
    		dayDisp1 = "SAT";
    	} else if (cal.get(Calendar.DAY_OF_WEEK) == 2) {
    		dayDisp = "mon";
    		dayDisp1 = "MON";
    	} else if (cal.get(Calendar.DAY_OF_WEEK) == 3) {
    		dayDisp = "the";
    		dayDisp1 = "THE";
    	} else if (cal.get(Calendar.DAY_OF_WEEK) == 4) {
    		dayDisp = "wed";
    		dayDisp1 = "WED";
    	} else if (cal.get(Calendar.DAY_OF_WEEK) == 5) {
    		dayDisp = "thu";
    		dayDisp1 = "THU";
    	} else if (cal.get(Calendar.DAY_OF_WEEK) == 6) {
    		dayDisp = "fri";
    		dayDisp1 = "FRI";
    	}

    	chkfDate = DispYear + DispMonth + chkDate;

    	if (chkfDate.equals(TODAY)) {
    		out.println("<td class=\"bg_today\">");
    	} else {
    		out.println("<td>");
    	}

    	out.println("        "+chkDate+" ");
    	out.println("        <ul class='calendar_name'>");
    	pageContext.setAttribute("chkDate", chkDate) ;

%>
	<c:forEach items="${MONTH}" var="month" varStatus="status">
		<c:if test="${fn:substring(month.schdStDt, 8, 10) eq chkDate}">
		<li><a href='javascript: eventView(${month.schdIdx});'>${month.schdTitle}</br><p style="color:blue;">(시작일)</p></a></li>
		</c:if>		
		<c:if test="${fn:substring(month.schdEdDt, 8, 10) eq chkDate}">
		<li><a href='javascript: eventView(${month.schdIdx});'>${month.schdTitle}</br><p style="color:red;">(종료일)</p></a></li>
		</c:if>
	</c:forEach>
<%

    	out.println("        </ul>");
						    	out.println("</td>");

						        // 토요일인 경우 다음줄로 생성
						        if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
							    	out.println("</tr><tr>");
						        }

						        // 날짜 증가시키지
						        cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE)+1);

							}

// 							System.out.println("last ["+cal.get(Calendar.DAY_OF_WEEK)+"]");

							if (cal.get(Calendar.DAY_OF_WEEK) != 1) {
							    // 끝날부터 토요일까지 빈칸으로 처리
							    for (int i=cal.get(Calendar.DAY_OF_WEEK); i<=7; i++) {
							    	out.println("<td>");
							    	out.println("</td>");
							    }
							}

%>
							</tr>
                       </tbody>
                   </table>
               </div>
               <br/><br/><br/><br/>
            <!--//table_list-->
        <!--//연간 일정 리스트-->
		<script>
			$(document).ready( function() {
				var strSelTab = $("#SCHD_CLASS").val();
				var hiddenString = "";
				switch (strSelTab) {
					case "02" :
						hiddenString = "보수교육";
						break;
					case "03" :
						hiddenString = "수시교육";
						break;
					default :
						hiddenString = "실무교육";
				}
				$("#hiddenString").text(hiddenString);
			});
		</script>		                