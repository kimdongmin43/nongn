<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<c:forEach items="${boardlist }" var="list">
	<tr>
	<c:forEach items="${viewSortList }" var="view">
		<%-- <c:if test="${view.v_print ne 'open_yn' &&  view.v_print ne 'reply_status' && view.v_print ne 'link'}"> --%>
			<td class="
				<%-- <c:if test="${view.v_sort eq 1 }">first</c:if>
				<c:if test="${view.v_sort eq view.total_cnt }"> last</c:if> --%>
				<c:if test="${view.v_print eq 'title' || view.v_print eq 'contents'}"> alignl</c:if>
			">
			<%-- 번호 --%>
			<c:if test="${view.v_print eq 'number'}">
				<c:if test="${list.noti_yn eq 'Y'}">공지</c:if>
				<c:if test="${list.noti_yn ne 'Y'}">[버노]</c:if>
			</c:if>
			<%-- 카테고리 --%>
			<c:if test="${view.v_print eq 'cate'}">${list.cate_nm }</c:if>
			<c:if test="${view.v_print eq 'title'}"><%-- 제목 --%>
				<%-- 제목링크 확인 --%>
				<c:if test="${empty list.title_link}">
					<%-- 디테일 사용여부 확인 --%>
					<c:if test="${boardinfo.detail_yn eq 'Y'}">
						<a href="javascript:contentsView('${list.cont_id }')" >${list.title }</a>
						<%-- 비밀글 여부 아이콘 --%>
						<c:if test="${list.open_yn eq 'Y'}">[비밀글]</c:if>
					</c:if>
					<c:if test="${boardinfo.detail_yn eq 'N'}">${list.title }</c:if>
				</c:if>
				<c:if test="${not empty list.title_link}"><%-- 제목링크 --%>
					<a href="${list.title_link }" >${list.title }</a>
				</c:if>
			</c:if>
			<c:if test="${view.v_print eq 'url'}">${list.url_nm } ${list.url_link }</c:if><%-- URL --%>
			<c:if test="${view.v_print eq 'source'}">${list.source }</c:if><%-- 출처 --%>
			<c:if test="${view.v_print eq 'contents'}">${list.contents }</c:if><%-- 내용 --%>
			<c:if test="${view.v_print eq 'thumb'}">썸네일</c:if><%-- 썸네일 --%>
			<c:if test="${view.v_print eq 'attach'}">첨부파일</c:if><%-- 첨부파일 --%>
			<c:if test="${view.v_print eq 'reg_mem_nm'}">${list.reg_mem_nm }</c:if><%-- 작성자 --%>
			<c:if test="${view.v_print eq 'phone'}">${list.mobile }</c:if><%-- 핸드폰 --%>
			<c:if test="${view.v_print eq 'reg_dt'}">${list.book_dt }</c:if><%-- 작성일 --%>
			<c:if test="${view.v_print eq 'reg_ip'}">아이피</c:if><%-- 아이피 --%>
			<c:if test="${view.v_print eq 'recommend'}">추천수</c:if><%-- 추천수 --%>
			<c:if test="${view.v_print eq 'satisfy'}">만족도</c:if><%-- 만족도 --%>
			<c:if test="${view.v_print eq 'hit'}">${list.hit }</c:if><%-- 조회수 --%>
			</td>
		<%-- </c:if> --%>
	</c:forEach>
	</tr>
</c:forEach>