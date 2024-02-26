<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="thisDt"/>


		<!-- tab_menu -->
        <div class="tab_menu">
            <ul>
                <li class="w3"><a href="javascript: eventSearch('01')" <c:if test="${param.SCHD_CLASS eq '01'}"><c:out value="class=active  title=선택됨"/></c:if>>실무교육</a></li>
                <li class="w3"><a href="javascript: eventSearch('02')" <c:if test="${param.SCHD_CLASS eq '02'}"><c:out value="class=active  title=선택됨" /></c:if>>보수교육</a></li>
                <li class="w3"><a href="javascript: eventSearch('03')" <c:if test="${param.SCHD_CLASS eq '03'}"><c:out value="class=active  title=선택됨" /></c:if>>수시교육</a></li>
            </ul>
        </div>
        <!-- //tab_menu -->

        <!--tab_schedule-->
        <h4 class="hidden" id="hiddenString">실무교육</h4>
        <h5 id="hiddenYM"class="hidden hiddenYM">연간</h5>
        <div class="tab_style3">
        	<ul>
            	<li class="w2"><a href="#none" class="active" id="schedule_y" onclick="eventYM('Y');">연간</a></li>
                <li class="w2"><a href="javascript: eventMonth()" id="schedule_m" onclick="eventYM('M');">월간</a></li>
            </ul>
        </div>
        <!--tab_schedule-->
		<!--연간 schedule_control-->
        <div class="schedule_control">
            <a href="javascript: yearMove(${SEARCHYEAR-1});">
                <img src="/images/common/btn_schdule_prev.png" alt="이전 ${SEARCHYEAR-1}년으로 이동">
            </a>
            <span><em>${SEARCHYEAR}</em>년</span>
            <a href="javascript: yearMove(${SEARCHYEAR+1});">
                <img src="/images/common/btn_schdule_next.png" alt="다음 ${SEARCHYEAR+1}년으로 이동" /> 
            </a>
     	</div>
        <!--//연간 schedule_control도-->
		<!--연간 일정 리스트-->
		<div class="schedule_year_table">
		<c:choose>
	 	<c:when test="${MONTH.size() eq 0}">
		 		<div class="table_area table_wrap scroll">
                	<table class="tstyle_list">
		 				<tr>
		 					<td>연간 일정이 없습니다.</td>
		 				</tr>
		 			</table>
		 		</div>
	 	</c:when>
	 	<c:otherwise>
	 		<c:forEach items="${MONTH}" var="month" varStatus="status">
                         <h4 class="title_h4 mt0">${month.m }월 일정</h4>
                         <!-- board_ty -->
                         <div class="table_area pt10">
                			<table class="tstyle_list">
                                 <caption> ${month.m }월 연간 교육일정 안내표.제목,일정 별로 확인할 수 있는 ${month.m }월 교육일정 안내표.</caption>
                                 <colgroup>
                                     	<col style="width: 8%;" />
				                        <col style="width: *;" />
				                        <col style="width: 20%;" />
                                 </colgroup>
                                 <thead>
                                     <tr>
                                         <th scope="col">번호</th>
                                         <th scope="col">제목</th>
                                         <th scope="col">일정</th>
                                     </tr>
                                 </thead>
                                 <tbody>
                             <c:choose>
							 	<c:when test="${MONTH eq null }">
						 				<tr>
						 					<td colspan="3">월 일정이 없습니다.</td>
						 				</tr>
							 	</c:when>
							 	<c:otherwise>
							 		<c:forEach items="${scheduleInfo}" var="monthlist" varStatus="status">
							 			<c:if test="${monthlist.m eq month.m}">
										<tr>
                                            <td>${status.index+1}</td>
                                            <td class="subject">
                                                <div class="tab_wp">
                                                    <a href="javascript: eventView(${monthlist.schdIdx});" class="link_t">${monthlist.schdTitle }</a>
                                                </div>
                                            </td>
                                            <td>
                                            	${fn:replace(monthlist.schdStDtTxt,'-','.') }
                                            	<c:if test="${monthlist.schdStDt != monthlist.schdEdDt}"> ~ ${fn:replace(monthlist.schdEdDtTxt,'-','.') }</c:if>
                                            </td>
                                        </tr>
                                        </c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
                                 </tbody>
                             </table>
                         </div>
                         <!-- //board_ty -->
			</c:forEach>
		</c:otherwise>
	</c:choose>
            </div>
            <!--//table_list-->
        </div>
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
			
			function eventYM(YM) {
				var hiddenYM = "";
				switch (YM) {
				case "Y" :
					hiddenYM = "연간";
					break;
				case "M" :
					hiddenYM = "월간";
					break;
				default :
					hiddenYM = "연간";
			}
			$("#hiddenYM").text(hiddenYM);
			}
		</script>		        