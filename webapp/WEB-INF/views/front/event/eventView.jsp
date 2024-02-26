<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%
     //치환 변수 선언합니다.
   pageContext.setAttribute("cr", "\r"); //Space
   pageContext.setAttribute("cn", "\n"); //Enter
   pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
   pageContext.setAttribute("br", "<br/>"); //br 태그
%>

<script>
var eventListPageUrl = "<c:url value='/front/event/eventList.do?menuId=${param.menuId}'/>";


//목록으로
function list(){
	var f = document.writeFrm;
    f.target = "_self";
    f.action = eventListPageUrl;
    f.submit();
}
</script>


<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="mode" name='mode' value="${param.mode}" />
	<input type='hidden' id="state" name='state' value="" />
	<input type='hidden' id="SCHD_CLASS" name='SCHD_CLASS' value="${param.SCHD_CLASS}" />
	<input type='hidden' id="SEARCH_YEAR" name='SEARCH_YEAR' value="${param.SEARCH_YEAR}" />
	<input type='hidden' id="SEARCH_MONTH" name='SEARCH_MONTH' value="${param.SEARCH_MONTH}" />
	<input type='hidden' id="mvM" name='mvM' value="${param.mvM}" />
</form>
<div id="location_area">
	<div class="content_tit" id="containerContent">
		<h3><c:if test="${param.SCHD_CLASS eq '01'}">실무</c:if><c:if test="${param.SCHD_CLASS eq '02'}">보수</c:if><c:if test="${param.SCHD_CLASS eq '03'}">수시</c:if>교육</h3>
	</div>
	<div class="content">
	<div class="contents_detail">
		<!--//S: 공지사항보기 -->
		<div class="table_area">
			<table cellspacing="0" cellpadding="0" class="tstyle_view">
				<caption>교육 상세보기 정보표.교육 상세보기 정보표로 제목, 작성자, 작성일, 첨부 순으로 보실 수 있습니다.</caption>
				<colgroup>
					<col style="width:20%" />
					<col style="width:30%" />
					<col style="width:20%" />
					<col style="width:30%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">제목</th>
						<td colspan="3">	${eventinfo.schdTitle }</td>
					</tr>
					<tr>
						<th scope="row">작성자</th>
						<td>${eventinfo.regName }</td>
						<th scope="row">등록일</th>
						<td>${eventinfo.regDate }</td>
					</tr>
					<tr>
						<th scope="row">일정</th>
						<td>${fn:replace(eventinfo.schdStDtTxt,'-','.') } ~ ${fn:replace(eventinfo.schdEdDtTxt,'-','.') }</td>
						<th scope="row">조회수</th>
						<td>${eventinfo.schdView}</td>
					</tr>
					<tr>
						<td scope="row" colspan="4" class="td_p">
							${fn:replace(eventinfo.schdContents, cn, br)}
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btn_area fl_right">
			<a href="#none"  onclick="list()" class="btn_list">목록</a>
		</div>
	</div>
	</div>
</div>