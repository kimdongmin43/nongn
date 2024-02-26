<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<style>
nav.cont-tab {margin-bottom:20px;}
.snd_only {display:none;}
nav.cont-tab ul {overflow:hidden; width:100%;}
nav.cont-tab ul li {float:left; height:43px; width:175.5px; background:#f5f5f5; border:1px solid #cfcfcf; border-width:1px 1px 1px 0; position:relative;}
nav.cont-tab ul li {font-size:11px; line-height:20px;}
nav.cont-tab ul > li.first, nav.cont-tab ul > li:first-child {border-left-width:1px;}
a {text-decoration:none;}
nav.cont-tab ul li a {display:block; line-height:43px; padding:0 16px; font-weight:700;}
nav.cont-tab ul li a:hover, nav.cont-tab ul li a.curr {position:absolute; top:-1px; left:-1px; width:175.5px; height:45px;}
nav.cont-tab ul li a.curr {background:#4f5459; color:#fff;}

.icon {background:url(/images/sprite.png?v=14)no-repeat; text-indent:-9999px; font-size:0; line-height:0;}
.icon.d-arrow {background-position:-3px -34px; width:13px; height:8px;}
nav.cont-tab ul li a .icon {float:right; margin-top:17px; display:none;}
nav.cont-tab ul li a.curr .icon, nav.cont-tab ul li a:hover .icon {display:block;}
</style>
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
		<p class="totalcnt">총 <span><fmt:formatNumber value="${totalcnt }" pattern="#,###" /></span>건 <em>${pageNo}</em>/<em><fmt:formatNumber value="${pages+(1-(pages%1))%1}" type="number"/></em> 페이지</p>
		<fieldset class="boardschbox">
			<legend>게시글 검색</legend>
			<span class="optionbox"><select title="검색범위 선택" name="searchKey" id="searchKey"><option value="A" <c:if test="${param.searchKey eq 'A' }" >selected</c:if> >전체</option><option value="T" <c:if test="${param.searchKey eq 'T' }" >selected</c:if> >제목</option><option value="C" <c:if test="${param.searchKey eq 'C' }" >selected</c:if> >내용</option></select></span>
			<p><span class="inpbox"><input type="text" class="txt" title="검색어 입력" id="searchTxt" name="searchTxt" value="${param.searchTxt}"  onKeyDown="enter();" /></span><button type="button" class="btn-search" title="조회" onclick="search();">검색</button><button type="button" class="btn-search b_right" title="초기화" onclick="formReset();" style="display:none">초기화</button></p>
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
		<c:if test="${param.boardId == '14' or param.boardId == '8' or param.boardId == '9' or param.boardId == '10'}">
		<nav class="cont-tab">
			<p class="snd_only">선택하시면 해당 카테고리로 정렬됩니다.</p>
			<ul>
				<li><a href="/front/boardlink/boardlinkContentsListPage.do?boardId=14&menuId=${MENU.menuId}"<c:if test="${param.boardId=='14' }"> class=" curr"</c:if> >글로벌시장		<span class="icon d-arrow"><c:if test="${param.boardId=='14' }">선택됨</c:if></span></a></li>
				<li><a href="/front/boardlink/boardlinkContentsListPage.do?boardId=8&menuId=${MENU.menuId}"<c:if test="${param.boardId=='8' }"> class=" curr"</c:if> >			일일중국경제	<span class="icon d-arrow"><c:if test="${param.boardId=='8' }">선택됨</c:if></span></a></li>
				<li><a href="/front/boardlink/boardlinkContentsListPage.do?boardId=9&menuId=${MENU.menuId}"<c:if test="${param.boardId=='9' }"> class=" curr"</c:if> >	베트남 주요뉴스 <span class="icon d-arrow"><c:if test="${param.boardId=='9' }">선택됨</c:if></span></a></li>
				<li><a href="/front/boardlink/boardlinkContentsListPage.do?boardId=10&menuId=${MENU.menuId}"<c:if test="${param.boardId=='10' }"> class=" curr"</c:if>  >	일본 경기동향	<span class="icon d-arrow"><c:if test="${param.boardId=='10' }">선택됨</c:if></span></a></li>
			</ul>
		</nav>
		</c:if>

		<!--// list_table_area -->
		<div class="boardlist">
		<table cellspacing="0" cellpadding="0">
			<caption>게시판 리스트 화면.공지사항 게시글을 번호, 제목, 작성일, 첨부, 조회 순으로 정보를 확인하실 수 있습니다.</caption>
			<colgroup>
				<c:set var="ttcnt" value="4"/>
				<col style="width: 8%;" />
				<col style="width: *;" />
				<col style="width: 14%;" />
				<c:if test="${param.boardId != '12' }">
				<col style="width: 8%;" />
				<c:set var="ttcnt" value="3"/>
				</c:if>
			</colgroup>
			<thead>
			 <tr>
			 	<th scope="col">
					번호1111
				</th>
				<th scope="col">
					제목
				</th>
				<th scope="col">
					등록일
				</th>
				<c:if test="${param.boardId != '12' }">
				<th scope="col">
					조회수
				</th>
				</c:if>
			</tr>
			</thead>
			<tbody>
				<c:forEach items="${boardList }" var="list">
				<tr>
					<td class="c_number">
						${list.totalCnt - (list.rnum-1)}
					</td>
					<td class="title">
						<a href="javascript:contentsView('${list.contId }')" >${list.title }</a> 	
					</td>
					<td class="c_reg_dt">
						${fn:substring(fn:replace(list.regDt,'-','.'),0,10)}
					</td>
					<c:if test="${param.boardId != '12' }">
					<td class="c_hit">
						<fmt:formatNumber value="${list.hit }" pattern="#,###" />
					</td>
					</c:if>
				</tr>
				</c:forEach>
				<c:if test="${empty boardList }">
				<tr>
					<td colspan="${ttcnt }" class="first last">조회된 내용이 없습니다.</td>
				</tr>
				</c:if>
			</tbody>
		</table>
		</div>
		<!--// list_table_area -->

		<!-- paging_area -->
		${boardPagging}
		<!--// paging_area -->