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

<!-- album_list_area -->
<div class="album_list_area">
	<ul class="album_list">
	<c:forEach items="${boardList}" var="list">
	<li>
		<div class="album">
			<div class="album_img_area">
				<%-- <c:if test="${not empty list.imageFileNm}"> --%>
				<c:if test="${not empty list.filePath}">
					<%-- <img src="/upload/board/${list.imageFileNm}" alt="썸네일" class="info_img" /> --%>
					<c:if test="${empty list.titleLink}">
						<%-- 디테일 사용여부 확인 --%>
						<c:if test="${boardinfo.detailYn eq 'Y'}">
							<%-- <a href="javascript:contentsEdit('${list.contId }')" ><img src="/upload/board/${list.imageFileNm}" alt="썸네일" class="info_img" /></a> --%>
							<a href="javascript:contentsEdit('${list.contId }')" ><img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${list.filePath}"  alt="썸네일" class="info_img" /></a>
						</c:if>
						<c:if test="${boardinfo.detailYn eq 'N'}">
							<%-- <img src="/upload/board/${list.imageFileNm}" alt="썸네일" class="info_img" /> --%>
							<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${list.filePath}" alt="썸네일" class="info_img" />
						</c:if>
					</c:if>
					<c:if test="${not empty list.titleLink}">
						<a href="javascript:contentsEdit('${list.titleLink}')" >
							<%-- <img src="/upload/board/${list.imageFileNm}" alt="썸네일" class="info_img" /> --%>
							<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${list.filePath}" alt="썸네일" class="info_img" />
						</a>
					</c:if>
				</c:if>

				<c:if test="${empty list.filePath}">
					<!-- <img src="/images/back/common/detail_no_img.png" alt="이미지 없음" class="info_img" /> -->
					<c:if test="${empty list.titleLink}">
						<%-- 디테일 사용여부 확인 --%>
						<c:if test="${list.imgPath != null}">
							<a href="javascript:contentsEdit('${list.contId }')" ><img src="${list.imgPath}${list.imgNm}" alt="이미지 없음" class="info_img" /></a>
						</c:if>
						
						
						<c:if test="${list.imgPath == null}">
							<a href="javascript:contentsEdit('${list.contId }')" ><img src="/images/back/common/detail_no_img.png" alt="이미지 없음" class="info_img1" /></a>
						</c:if>
						<c:if test="${boardinfo.detailYn eq 'N'}">
							<img src="/images/back/common/detail_no_img.png" alt="이미지 없음" class="info_img2" />
						</c:if>
					</c:if>
					<c:if test="${not empty list.titleLink}">
						<a href="javascript:contentsEdit('${list.titleLink}')" >
							<img src="/images/back/common/detail_no_img.png" alt="이미지 없음" class="info_img3" />
						</a>
					</c:if>
				</c:if>
				-->
			</div>
			<div class="album_txt_area">

				<!-- <div class="album_name_area"> -->
					<%-- 카테고리 --%>
					<%-- <c:if test="${fn:indexOf(boardinfo.viewPrint, 'cate') != -1}">
						<span class="album_name">${list.cate_nm }</span>
					</c:if> --%>
					<%-- 조회수 --%>
					<%-- <c:if test="${fn:indexOf(boardinfo.viewPrint, 'hit') != -1}">
						<span class="album_number">${list.hit }</span>
					</c:if> --%>
				<!-- </div> -->

				<div class="album_title_area">
				<c:if test="${fn:indexOf(boardinfo.viewPrint, 'title') != -1}"><%-- 제목 --%>
					<%-- 제목링크 확인 --%>
					<c:if test="${empty list.titleLink}">
						<%-- 디테일 사용여부 확인 --%>
						<c:if test="${boardinfo.detailYn eq 'Y'}">
							<span class="album_title">
								<a href="javascript:contentsEdit('${list.contId }')" >${list.title }</a>
							</span>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'comment') != -1}"><%-- 댓글 사용여부 확인 --%>
								<c:if test="${list.commentCnt > 0}">
									<span class="color_pointr">${list.commentCnt }</span>
								</c:if>
							</c:if>
						</c:if>
						<c:if test="${boardinfo.detailYn eq 'N'}">
							<span class="album_title">${list.title }</span>
						</c:if>
					</c:if>
					<c:if test="${not empty list.titleLink}">
						<a href="javascript:contentsEdit('${list.titleLink}')" >
							<span class="album_title">${list.title }</span>
						</a>
					</c:if>
				</c:if>
				</div>
				<div class="album_register_area">
					<ul>
						<li>
							<%-- 작성자 --%>
							<%-- <c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_mem_nm') != -1}">
								<span class="register_name">${list.name }</span>
							</c:if> --%>
							<%-- 작성일 --%>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_dt') != -1}">
								<span>${list.regDt }</span>
							</c:if>
						</li>
						<!-- <li> -->
							<%-- 아이피 --%>
							<%-- <c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_ip') != -1}">
								<span>${list.reg_ip }</span>
							</c:if> --%>
							<%-- 첨부파일 --%>
							<%-- <c:if test="${fn:indexOf(boardinfo.viewPrint, 'attach') != -1}">
							<span class="album_file">
 								<img src="/images/back/icon/icon_file.png" alt="첨부파일">
							</span>
							</c:if> --%>
						<!-- </li> -->
					</ul>
				</div>
			</div>
		</div>
	</li>
	</c:forEach>
	<c:if test="${empty boardList }">
		<li><div class="album">등록된 게시물이 없습니다.</div></li>
	</c:if>
	</ul>
</div>
<!--// table 1dan list -->
<!-- paging_area -->
${boardPagging}
<!--// paging_area -->