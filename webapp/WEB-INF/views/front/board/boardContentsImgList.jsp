<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

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
<div class="table_search_area">
	<div class="table_search_wrap">
		<label for="searchKey" class="hide2">구분 선택</label>
		<select title="검색범위 선택" name="searchKey" id="searchKey" class="three_member70 select_style"><option value="A" <c:if test="${param.searchKey eq 'A' }" >selected</c:if> >전체</option><option value="T" <c:if test="${param.searchKey eq 'T' }" >selected</c:if> >제목</option><option value="C" <c:if test="${param.searchKey eq 'C' }" >selected</c:if> >내용</option></select>
		<div class="search_input"><input type="text" class="txt" title="검색어 입력" id="searchTxt" name="searchTxt" placeholder="검색어를 입력하세요" value="${param.searchTxt}"  onKeyDown="enter();"/></div>
		<button type="button" class="btn_search" title="조회" onclick="search();">검색</button>
		<!-- <button  type="button" class="btn_total b_right" title="초기화" onclick="searchAll();">전체보기</button> -->
	</div>
	<div class="table_cnt_wrap">
		<p class="totalcnt">총 <span>${totalcnt }</span>건</p>
		<p class="totalpage"><em>${pageNo}</em>/<em><fmt:formatNumber value="${pages>1?pages+(1-(pages%1))%1:1}" type="number"/></em> 페이지</p>
	</div>
</div>
<!-- table_count_area -->
<c:if test="${boardinfo.boardCd eq 'W'}"><div class="album_list_area"></c:if>
<c:if test="${boardinfo.boardCd eq 'A'}"><div class="album_list_area"></c:if>
	<ul class="album_list">

		<c:forEach items="${boardList }" var="list">
		<li>
			<div class="album">
				<div class="album_img">
				<c:if test="${list.imgPath != null}">
					<img src="${list.imgPath}${list.imgNm}" width="100%" height="100%" alt="${list.title }" />	<%-- 20230303 웹접근성 2차 --%>
				</c:if>
				<c:if test="${list.imgPath == null}">
					<img src="/images/common/bg_album_none.png" alt="이미지 없음" class="info_img" />
				</c:if>
				</div>
				<div class="album_txt">
					<a href="#none" class="gallaylist_txt detail_view" viewId="${list.contId}"  openYn="${list.openYn}">
						${list.title }
					</a>
				</div>
				<div class="album_date">
					${fn:substring(list.regDt,0,4) }-${fn:substring(list.regDt,4,6) }-${fn:substring(list.regDt,6,8) } <%-- / 조회수 ${list.hit} --%>
				</div>
			</div>
		</li>
		</c:forEach>

	</ul>
</div>
<!-- //table_count_area -->

<!-- paging_area -->
${boardPagging}
<!--// paging_area -->

<script src="/js/apfs/board.js"></script>