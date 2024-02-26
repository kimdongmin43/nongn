<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>

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
				<option value="10" <c:if test="${param.miv_pageSize eq 10 }" >selected</c:if> >10개씩</option>
				<option value="15" <c:if test="${pageSize eq 15 }" >selected</c:if>>15개씩</option>
				<option value="20" <c:if test="${param.miv_pageSize eq 20 }" >selected</c:if>>20개씩</option>
				<option value="30" <c:if test="${param.miv_pageSize eq 30 }" >selected</c:if>>30개씩</option>
				<option value="50" <c:if test="${param.miv_pageSize eq 50 }" >selected</c:if>>50개씩</option>
			</select>
			</span>
		</fieldset>
		<!-- <span class="search_btn_area">
			<button class="btn sch" title="조회" onclick="changePageSize();"><span>보기</span></button>
		</span> -->
		<!--// table_count_area -->

		<!--// list_table_area -->
		<div class="boardlist">
		<table cellspacing="0" cellpadding="0">
			<caption>게시판 리스트 화면.공지사항 게시글을 번호, 제목, 작성일, 첨부, 조회 순으로 정보를 확인하실 수 있습니다.</caption>
			<colgroup>
				<col style="width: 8%;" />
				<col style="width: *;" />
				<col style="width: 8%;" />
				<col style="width: 12%;" />
			</colgroup>
			<thead>
			 <tr>
			 	<th scope="col">
					번호
				</th>
				<th scope="col">
					제목
				</th>
				<th scope="col">
					출처
				</th>
				<th scope="col">
					등록일
				</th>
			</tr>
			</thead>
			<tbody>
				<c:forEach items="${boardList }" var="list">
				<tr>
					<td>
						${list.totalCnt - (list.rnum-1)}
					</td>
					<td class="title">
						<a href="javascript:contentsView('${list.contId }')" >${list.title }</a>
					</td>
					<td>
						${list.author}
					</td>
					<td>
						${fn:substring((list.regDt),0,4)}.${fn:substring((list.regDt),4,6)}.${fn:substring((list.regDt),6,8)}
					</td>
				</tr>
				</c:forEach>
				<c:if test="${empty boardList }">
				<tr>
					<td colspan="4" class="first last">조회된 내용이 없습니다.</td>
				</tr>
				</c:if>
			</tbody>
		</table>
		</div>
		<!--// list_table_area -->

		<!-- paging_area -->
		${boardPagging}
		<!--// paging_area -->