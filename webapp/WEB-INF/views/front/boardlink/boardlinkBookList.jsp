<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
$(document).ready(function(){

});
</script>

<!-- table_count_area -->
		<c:set var="pageNo" value="1" />
		<c:if test="${param.miv_pageNo!=''}">
			<c:set var="pageNo" value="${param.miv_pageNo}" />
		</c:if>
		<c:set var="pageSize" value="${LISTOP.ht.miv_pageSize}" />
		<c:if test="${param.miv_pageSize!=''}">
			<c:set var="pageSize" value="${param.miv_pageSize}" />
		</c:if>
		<fmt:parseNumber var="pages" value="${totalcnt/pageSize}"/>
		<p class="totalcnt">총 <span>${totalcnt }</span>건 <em>${pageNo}</em>/<em><fmt:formatNumber value="${pages+(1-(pages%1))%1}" type="number"/></em> 페이지</p>
		<fieldset class="boardschbox">
			<legend>게시글 검색</legend>
			<span class="optionbox"><select title="검색범위 선택" name="searchKey" id="searchKey"><option value="A" <c:if test="${param.searchKey eq 'A' }" >selected</c:if> >전체</option><option value="T" <c:if test="${param.searchKey eq 'T' }" >selected</c:if> >제목</option><option value="C" <c:if test="${param.searchKey eq 'C' }" >selected</c:if> >내용</option></select></span>
			<p><span class="inpbox"><input type="text" class="txt" title="검색어 입력" id="searchTxt" name="searchTxt" value="${param.searchTxt}" /></span><button type="button" class="btn-search" title="조회" onclick="search();">검색</button><button type="button" class="btn-search b_right" title="초기화" onclick="formReset();" style="display:none">초기화</button></p>
			<span class="optionbox ml_5">
			<select title="보기 선택" id="pageSize" onchange="changePageSize();" >
				<option value="10" <c:if test="${pageSize eq 10 }" >selected</c:if>>10개씩</option>
				<option value="20" <c:if test="${param.miv_pageSize eq 20 }" >selected</c:if>>20개씩</option>
				<option value="30" <c:if test="${param.miv_pageSize eq 30 }" >selected</c:if>>30개씩</option>
				<option value="50" <c:if test="${param.miv_pageSize eq 50 }" >selected</c:if>>50개씩</option>
			</select>
			</span>
		</fieldset>
<!--// table_count_area -->


		<ul class="gallaylist_type3">
			<c:forEach items="${boardList }" var="list">
			<li>
				<a href="javascript:bookView('${list.contId }')" class="gallaylist_img"><img src="http://www.korcham.net/FileWebKorcham/PublishData/Image/${list.fileNm}" alt="썸네일" width="100%" height="100%" /></a>
				<a href="javascript:bookView('${list.contId }')" class="gallaylist_txt">
					<h4 class="gallaytitle">${list.title }</h4>
					<h4 class="gallayinfo"><span class="">발간상의 :</span> ${list.author }</h4>
					<h4 class="gallayinfo"><span class="">발간일 :</span> ${fn:substring(fn:replace(list.regDt,'-','.'),0,10)}</h4>
					<ul class="txt">
						<li>-${fn:replace(fn:substring(list.contents,1,fn:length(list.contents)),'-','<br>-') }</li>
					</ul>
				</a>
			</li>
			</c:forEach>
		</ul>


<!-- paging_area -->
${boardPagging}
<!--// paging_area -->