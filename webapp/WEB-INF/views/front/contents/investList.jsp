<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
$(document).ready(function(){

});

function popHome(str){
	window.open('/pop/invest/pop.jsp?investId='+str,'POPINFO','width=500,height=150');
}
function popInfo(str){
	window.open('/pop/invest/pop_cate.jsp?Category='+encodeURI(str),'POPINFO','width=580,height=250');
}
</script>
		<h4 class="hidden">농림수산식품투자조합결성현황</h4>
		<p class="tar">(기준일 : <span id="standard"></span>)</p>
		<div class="table_area table_wrap scroll">
			<table class="table_style">
	            <caption>농림수산식품투자조합결성현황 정보표로 조성년도,운용사,펀드명,투자분야,투자기간,전화,펀드규모 합계 정보를 제공함.</caption>
	            <colgroup>
	                <col width="6%" />
	                <col span="2" />
	                <col width="14%" />
	                <col width="9%" />
	                <col width="15%" />
	                <col width="11%" />
	            </colgroup>
	            <thead>
	                <tr>
	                    <th scope="col">조성년도</th>
	                    <th scope="col">운용사</th>
	                    <th scope="col">펀드명</th>
	                    <th scope="col">투자분야</th>
	                    <th scope="col">투자기간</th>
	                    <th scope="col">전화</th>
	                    <th scope="col">펀드규모</th>
	                </tr>
	            </thead>
	            <tbody>
	            	<c:set var="totalScale" value="0" />
	            	<c:forEach items="${boardList }" var="list">
					<tr>
						<input type="hidden" id="addr${list.investId}" value="${list.addr}" />
						<input type="hidden" id="phone${list.investId}" value="${list.phone}" />
						<input type="hidden" id="nm${list.investId}" value="${list.company}" />
	                    <td class="borLNone">${list.investYear}</td>
	                    <td class="txt_left"><c:if test="${list.homepage eq '' or list.homepage eq null}"><a href="javascript: popHome('${list.investId}');"></c:if>${list.company}</a></td> <%-- 웹 접근성 검사를 위해 잠시 주석 <c:if test="${list.homepage ne '' and list.homepage ne null}"><a href="http://${fn:replace(list.homepage,'http://','')}" target="_blank"></c:if> --%>
	                    <td class="txt_left">${list.copart}</td>
	                    <td><a title="새창" href="javascript: popInfo('${fn:replace(list.departCd,'&','!')}')">${list.departCd}</a></td>
	                    <td>${list.investSdt}~<br>${list.investEdt}</td>
	                    <td>${list.phone}</td>
	                    <td>${list.scale}억</td>
	                </tr>
	                <c:set var="totalScale" value="${totalScale + list.scale}" />
					</c:forEach>
	                <tr>
	                    <th colspan="6"><strong>합계</strong></th>
	                    <th><span class="fc_blue"><fmt:formatNumber value="${totalScale }" pattern="#,###" /> 억</span></th>
	                </tr>
	            </tbody>
	        </table>

		</div>
