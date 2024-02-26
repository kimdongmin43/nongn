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
				<option value="9" <c:if test="${param.miv_pageSize eq 9 }" >selected</c:if> >9개씩</option>
				<option value="15" <c:if test="${pageSize eq 15 }" >selected</c:if>>15개씩</option>
				<option value="21" <c:if test="${param.miv_pageSize eq 21 }" >selected</c:if>>21개씩</option>
				<option value="30" <c:if test="${param.miv_pageSize eq 30 }" >selected</c:if>>30개씩</option>
				<option value="60" <c:if test="${param.miv_pageSize eq 60 }" >selected</c:if>>60개씩</option>
			</select>
			</span>
		</fieldset>
<!--// table_count_area -->

		<div class="gallaylist_type1">
			<ul>
				<c:forEach items="${boardList }" var="list">
				<li>
					<div class="gallaylist_img">
					<c:if test="${not empty list.fileNm}">
						<a href="javascript:contentsView('${list.contId }')"><img src="<c:url value="http://www.korcham.net/FileWebKorcham/PhotoNews/Image/${list.fileNm}" />" alt="썸네일" class="info_img" width="100%" height="100%" /></a>
					</c:if>
					<c:if test="${empty list.fileNm}">
						<img src="/images/front/common/detail_no_img.png" alt="이미지 없음" class="info_img" />
					</c:if>
					</div>
					<a href="javascript:contentsView('${list.contId }')" class="gallaylist_txt">
						<h4>${list.title }</h4>
						<div class="date">[${fn:substring(fn:replace(list.regDt,'-','.'),0,10)}]</div>
						<div class="txt">${list.contents }</div>
					</a>
				</li>
				</c:forEach>
			</ul>
		</div>

<!-- paging_area -->
${boardPagging}
<!--// paging_area -->