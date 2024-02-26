<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
$(document).ready(function(){

});
</script>

<!-- table_count_area -->	
<div class="table_count_area">
	<div class="count_area float_left">
		<strong id="tot_cnt">${totalcnt }</strong>건
	</div>
	<div class="float_right">
		<label for="select_num" class="hidden">출력 구분 선택</label>
		<select class="in_wp100" title="보기 선택" id="pageSize">
			<option value="15" <c:if test="${param.miv_pageSize eq 15 }" >selected</c:if> >15개</option>
			<option value="20" <c:if test="${param.miv_pageSize eq 20 }" >selected</c:if>>20개</option>
			<option value="50" <c:if test="${param.miv_pageSize eq 50 }" >selected</c:if>>50개</option>
			<option value="100" <c:if test="${param.miv_pageSize eq 100 }" >selected</c:if>>100개</option>
		</select>
		<span class="search_btn_area">
			<button class="btn sch" title="조회" onclick="changePageSize();"><span>보기</span></button>
		</span>
	</div>
</div>
<!--// table_count_area -->

<!-- album_list_hor_area -->	
<div class="album_list_hor_area marginb30">
	<ul class="album_list_hor">
	<c:forEach items="${boardList }" var="list">
		<li> <!-- class="announce" -->
			<c:if test="${not empty list.image_file_nm}">
				<img src="/upload/board/${list.image_file_nm}" alt="썸네일" class="info_img" />
			</c:if>
			<c:if test="${empty list.image_file_nm}">
				<img src="/images/front/common/detail_no_img.png" alt="이미지 없음" class="info_img" />
			</c:if>
			
			<div class="list_info">
				<c:if test="${fn:indexOf(boardinfo.view_print, 'cate') != -1}"><%-- 카테고리 --%>
				<dl class="view">
					<dt class="vdt"><span>카테고리</span></dt>
					<dd class="vdd">${list.cate_nm }</dd>
				</dl>
				</c:if>
				<%-- 제목 --%>
				<c:if test="${fn:indexOf(boardinfo.view_print, 'title') != -1}">
					<strong class="title">
					<c:if test="${empty list.title_link}"><%-- 제목링크 사용안함 --%>
						<c:if test="${boardinfo.detail_yn eq 'Y'}"><%-- 디테일 사용 --%>
							<a href="javascript:contentsView('${list.contents_id }')" >${list.title }</a>
						</c:if>
						<c:if test="${boardinfo.detail_yn eq 'N'}"><%-- 디테일 사용안함 --%>
							${list.title }
						</c:if>
						<c:if test="${fn:indexOf(boardinfo.view_print, 'comment') != -1}"><%-- 댓글 사용여부 확인 --%>
							<c:if test="${list.comment_cnt > 0}">
								[<strong class="color_pointr">${list.comment_cnt }</strong>]
							</c:if>
						</c:if>
					</c:if>
					<c:if test="${not empty list.title_link}"><%-- 제목링크 사용 --%>
						<a href="javascript:contentsView('${list.title_link }')" >${list.title }</a>
					</c:if>
					</strong>
				</c:if>
				<%--// 제목 --%>
				
				<%-- 내용 --%>
				<c:if test="${fn:indexOf(boardinfo.view_print, 'comment') != -1}">
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
				</c:if>
				<%-- //내용 --%>
				<dl class="view">
					<c:if test="${fn:indexOf(boardinfo.view_print, 'name') != -1}"><%-- 작성자 --%>
						<dt class="vdt"><span>작성자</span></dt>
						<dd class="vdd">${list.name }</dd>
					</c:if>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'phone') != -1}"><%-- 핸드폰 --%>
						<dt class="vdt"><span>휴대전화</span></dt>
						<dd class="vdd">${list.handphone }</dd>
					</c:if>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'reg_date') != -1}"><%-- 작성일 --%>
						<dt class="vdt"><span>작성일</span></dt>
						<dd class="vdd">${list.reservation_date }</dd>
					</c:if>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'ip_addr') != -1}"><%-- 아이피 --%>
						<dt class="vdt"><span>IP</span></dt>
						<dd class="vdd">${list.ip_addr }</dd>
					</c:if>
				</dl>
				
				<c:if test="${fn:indexOf(boardinfo.view_print, 'url') != -1}"><%-- URL --%>
				<dl class="view">
					<dt class="vdt"><span>URL</span></dt>
					<dd class="vdd"><a href=" ${list.url_link }" title="해당 url로 새창이동" target="_blank">${list.url_title }</a></dd>
				</dl>
				</c:if>
				
				<c:if test="${fn:indexOf(boardinfo.view_print, 'origin') != -1}"><%-- 출처 --%>
				<dl class="view">
					<dt class="vdt"><span>출처</span></dt>
					<dd class="vdd">${list.origin }</dd>
				</dl>
				</c:if>
				
				<dl class="view">
					<c:if test="${fn:indexOf(boardinfo.view_print, 'recommend') != -1}"><%-- 추천수 --%>
						<dt class="vdt"><span>추천</span></dt>
						<dd class="vdd">${list.recommend }</dd>
					</c:if>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'satisfy') != -1}"><%-- 만족도 --%>
						<dt class="vdt"><span>만족도</span></dt>
						<dd class="vdd">${list.satisfy }</dd>
					</c:if>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'hits') != -1}"><%-- 조회수 --%>
						<dt class="vdt"><span>조회수</span></dt>
						<dd class="vdd">${list.hits }</dd>
					</c:if>
				</dl>
				
				<%-- 첨부파일 --%>
				<c:if test="${fn:indexOf(boardinfo.view_print, 'attach') != -1}">
				<dl class="view">
					<dt class="vdt"><span>첨부파일</span></dt>
					<dd class="vdd">
					<c:if test="${boardinfo.detail_yn ne 'Y'}"><%-- 디테일 사용안함 --%>
						<c:if test="${not empty list.group_id}"><%-- 첨부파일이 있는경우 --%>
							<c:if test="${not empty list.file_id}"><%-- 첨부파일이 1개인경우 다운로드 --%>
							<a href="/commonfile/fileidDownLoad.do?file_id=${list.file_id}"  target="_blank" title="다운받기">
							</c:if>
								<img src="/images/front/icon/icon_file.png" alt="첨부파일" />
							<c:if test="${not empty list.file_id}">
							</a>
							</c:if>
						</c:if>
					</c:if>
					<c:if test="${boardinfo.detail_yn eq 'Y'}"><%-- 디테일 사용 --%>
						<c:if test="${not empty list.group_id}"><%-- 첨부파일이 있는경우 --%>
							<img src="/images/front/icon/icon_file.png" alt="첨부파일" />
						</c:if>
					</c:if>
					</dd>
				</dl>
				</c:if>
				<%-- // 첨부파일 --%>
			</div>
		</li>
	</c:forEach>
	<c:if test="${empty boardList }">
		<li>등록된 게시물이 없습니다.</li>
	</c:if>
	</ul>
</div>
<!--// album_list_hor_area -->

<!-- button_area -->
<div class="button_area">
	<div class="float_right">
		<%-- 회원이면서 글쓰기 권한이 있는경우 --%>
		<c:if test="${not empty param.s_auth_id }">
			<c:if test="${fn:indexOf(boardinfo.grant_write, 'M') != -1}">
				<button class="btn save" onclick="contentsWrite()" title="등록"><span>등록</span></button>
			</c:if>
		</c:if>
		<%-- 비회원이면서 글쓰기 권한이 있는경우 --%>
		<c:if test="${empty param.s_auth_id }">
			<c:if test="${fn:indexOf(boardinfo.grant_write, 'G') != -1}">
				<button class="btn save" onclick="contentsWrite()" title="등록"><span>등록</span></button>
			</c:if>
		</c:if>
	</div>
</div>
<!--// button_area -->

<!-- paging_area -->
${boardPagging}
<!--// paging_area -->