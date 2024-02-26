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
			<div class="table_search_left">
				<p class="totalcnt">총 <span>${totalcnt }</span>건 <em>${pageNo}</em>/<em><fmt:formatNumber value="${pages>1?pages+(1-(pages%1))%1:1}" type="number"/></em> 페이지</p>
			</div>
			<div class="table_search_right">
				<label for="searchKey" class="hide2">구분 선택</label>
				<select title="검색범위 선택" name="searchKey" id="searchKey" class="three_member80"><option value="A" <c:if test="${param.searchKey eq 'A' }" >selected</c:if> >전체</option><option value="T" <c:if test="${param.searchKey eq 'T' }" >selected</c:if> >제목</option><option value="C" <c:if test="${param.searchKey eq 'C' }" >selected</c:if> >내용</option></select>
				<div class="search_input"><input type="text" class="txt" title="검색어 입력" id="searchTxt" name="searchTxt" value="${param.searchTxt}"  onKeyDown="enter();"/></div>
				<button type="button" class="btn_search" title="조회" onclick="search();">검색</button>
				<!-- <button  type="button" class="btn_total b_right" title="초기화" onclick="searchAll();">전체보기</button> -->
			</div>
		</div>
		<!-- <span class="search_btn_area">
			<button class="btn sch" title="조회" onclick="changePageSize();"><span>보기</span></button>
		</span> -->
		<!--// table_count_area -->

		<!--// list_table_area -->




	
					
					
					    <div class="ir">
					    <c:forEach var="list" items="${boardList}" varStatus="i">
                        <dl>
                            <dt>${list.companyNm}</dt>
                            <dd>
                                <p class="thumb">
                                    <a href="#;" class="gallaylist_txt etc_detail_view" contentsid="${list.contId }"  boardid="${list.boardId }"> <img src="${list.imgPath}${list.imgNm}" alt="${list.imgNm}"> </a>
                                </p>
                                <ul>
                                    <li>
                                        <span>기 업 명 :</span>
                                        <em>${list.companyNm}</em>
                                    </li>
                                    <li>
                                        <span>대표자 :</span>
                                        <em>${list.ceo}</em>
                                    </li>
                                    <li>
                                        <span>주요품목 :</span>
                                        <em>${list.title}</em>
                                    </li>
                                    <li>
                                        <span>연락처 :</span>
                                        <em>${list.tel} </em>
                                    </li>
                                    <li>
                                        <span>이메일 :</span>
                                        <em>${list.email} </em>
                                    </li>
                                    <li>
                                        <span>조회수 :</span>
                                        <em>${list.hit}</em>
                                    </li>
                                </ul>
                          <%--       <p class="pdf_btn">
                                    <a href="/commonfile/fileidDownLoad.do?fileId=${list.imgId}" class="btn_download" alt="${list.imgNm2}" >PDF 다운로드</a>
                                <p> --%>
                                 <p class="pdf_btn">
                                    <a href="${list.imgPath}${list.imgNm2}" class="btn_download" alt="${list.imgNm2}" >PDF 다운로드</a>
                                <p>
                            </dd>
                           
                        </dl>
                        	</c:forEach>
                       
                        
                    </div>
					



		<!-- paging_area -->
		${boardPagging}
		<!--// paging_area -->
		
		<script src="/js/apfs/board.js"></script>