<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<!-- table_search_area -->
<div class="table_search_area">
	<div class="float_left">
		<span><strong class="color_pointo" id="tot_cnt">${totalcnt }</strong>건</span>
	</div>
	<div class="float_right">
		<select class="in_wp100" title="보기 선택" onchange="changePageSize(this.value)">
			<option value="15" <c:if test="${param.miv_pageSize eq 15 }" >selected</c:if> >15개씩 보기</option>
			<option value="20" <c:if test="${param.miv_pageSize eq 20 }" >selected</c:if>>20개씩 보기</option>
			<option value="50" <c:if test="${param.miv_pageSize eq 50 }" >selected</c:if>>50개씩 보기</option>
			<option value="100" <c:if test="${param.miv_pageSize eq 100 }" >selected</c:if>>100개씩 보기</option>
		</select>
	</div>
</div>
<!--// table_search_area -->

<!-- table 1dan list -->
<div class="album_list_area">
	<ul class="album_list_hor">
		<c:forEach items="${boardList }" var="list">
		<li>
			<c:if test="${not empty list.filePath}">
				<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${list.filePath}" alt="썸네일" class="info_img" />
			</c:if>
			<c:if test="${empty list.filePath}">
				<img src="/images/back/common/detail_no_img.png" alt="${list.filePath}" class="info_img" />
			</c:if>
			<div class="list_info">
				<c:if test="${fn:indexOf(boardinfo.viewPrint, 'title') != -1}"><%-- 제목 --%>
					<strong class="title">
					<%-- 제목링크 확인 --%>
					<c:if test="${empty list.titleLink}">
					<%-- 디테일 사용여부 확인 --%>
					<c:if test="${boardinfo.detailYn eq 'Y'}">
						<a href="javascript:contentsEdit('${list.contId }')" >${list.title }</a>
					</c:if>
					<c:if test="${boardinfo.detailYn eq 'N'}">${list.title }</c:if>
						<c:if test="${fn:indexOf(boardinfo.viewPrint, 'comment') != -1}"><%-- 댓글 사용여부 확인 --%>
							<c:if test="${list.commentCnt > 0}">
								[<strong class="color_pointr">${list.commentCnt }</strong>]
							</c:if>
						</c:if>
					</c:if>
					</strong>
					<c:if test="${not empty list.titleLink}">
						<a href="javascript:contentsEdit('${list.titleLink}')" >${list.title}</a>
					</c:if>
				</c:if>
				<%-- 내용 --%>
				<%-- <c:if test="${fn:indexOf(boardinfo.viewPrint, 'comment') != -1}">
					<p class="memo">
						<c:choose>
							<c:when test="${fn:length(list.contents) > 200}">
								<c:out value="${fn:substring(list.contents,0,200)}"/><c:out value="..."/>
							</c:when>
							<c:otherwise>
								${list.contents }
							</c:otherwise>
						</c:choose>
					</p>
				</c:if> --%>
				<%-- //내용 --%>
				<dl class="view">
					<c:set var="array_item" value="${ fn:split(boardinfo.itemUse, ',') }" />
					<c:set var="array_view" value="${ fn:split(boardinfo.itemOut, '|') }" />
					<c:set var="result" value="" />
					<%-- 카테고리 --%>
					<%-- <c:if test="${fn:indexOf(boardinfo.viewPrint, 'cate') != -1}">
						<dt class="vdt"><span>카테고리</span></dt>
						<dd class="vdd">${list.cateNm }</dd>
					</c:if> --%>

					<%-- 작성자 --%>
					<%-- <c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_mem_nm') != -1}">
						<dt class="vdt"><span>작성자</span></dt>
						<dd class="vdd">${list.regMemNm }</dd>
					</c:if> --%>
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'reg_mem_nm'}">
								<c:set var="result" value="${status.index}" />
							</c:if>
						</c:forEach>
						<dt class="vdt"><span>${fn:trim(array_view[result])}</span></dt>
						<dd class="vdd">${list.regMemNm }</dd>
						<c:set var="result" value="" />

					<%-- 핸드폰 --%>
					<%-- <c:if test="${fn:indexOf(boardinfo.viewPrint, 'phone') != -1}">
						<dt class="vdt"><span>휴대전화</span></dt>
						<dd class="vdd">${list.mobile }</dd>
					</c:if> --%>

					<%-- 작성일 --%>
					<%-- <c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_dt') != -1}">
						<dt class="vdt"><span>작성일</span></dt>
						<dd class="vdd">${list.bookDt }</dd>
					</c:if> --%>
					<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'reg_dt'}">
								<c:set var="result" value="${status.index}" />
							</c:if>
						</c:forEach>
						<dt class="vdt"><span>${fn:trim(array_view[result])}</span></dt>
						<dd class="vdd">${list.regDt }</dd>
						<c:set var="result" value="" />

					<%-- 아이피 --%>
					<%-- <c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_ip') != -1}">
						<dt class="vdt"><span>IP</span></dt>
						<dd class="vdd">${list.regIp }</dd>
					</c:if> --%>
				</dl>
				<c:if test="${fn:indexOf(boardinfo.viewPrint, 'contents') != -1}">
					<p class="memo">
						<c:choose>
							<c:when test="${fn:length(list.contents) > 200}">
								<c:out value="${fn:substring(list.contents,0,200)}"/><c:out value="..."/>
							</c:when>
							<c:otherwise>
								${list.contents}
							</c:otherwise>
						</c:choose>
					</p>
				</c:if>
				<%-- <dl class="view">
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'url') != -1}">URL
						<dt class="vdt"><span>URL</span></dt>
						<dd class="vdd"><a href=" ${list.url_link }" title="해당 url로 새창이동" target="_blank">${list.url_nm }</a></dd>
					</c:if>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'source') != -1}">출처
						<dt class="vdt"><span>출처</span></dt>
						<dd class="vdd">${list.source }</dd>
					</c:if>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'recommend') != -1}">추천수
						<dt class="vdt"><span>추천</span></dt>
						<dd class="vdd">${list.recommend }</dd>
					</c:if>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'satisfy') != -1}">만족도
						<dt class="vdt"><span>만족도</span></dt>
						<dd class="vdd">${list.satisfy }</dd>
					</c:if>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'hit') != -1}">조회수
						<dt class="vdt"><span>조회수</span></dt>
						<dd class="vdd">${list.hit }</dd>
					</c:if>
				</dl> --%>
				<c:if test="${fn:indexOf(boardinfo.viewPrint, 'attach') != -1}"><%-- 첨부파일 --%>
				<c:if test="${not empty list.attachId }">
				<dl class="view">
					<dt class="vdt"><span>첨부파일</span></dt>
					<dd class="vdd"><img src="/images/back/icon/icon_file.png" alt="파일" /></dd>
				</dl>
				</c:if>
				</c:if>
			</div>
		</li>
		</c:forEach>
		<c:if test="${empty boardList }">
			<li><div class="list_info">등록된 게시물이 없습니다.</div></li>
		</c:if>
	</ul>
</div>
<!--// table 1dan list -->
<!-- paging_area -->
${boardPagging}
<!--// paging_area -->