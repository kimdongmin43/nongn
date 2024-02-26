<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%
	//	시작 - 표 형태의 목록정보 제공 문자열 만들기 - 2020.11.09
	List<Map<String, Object>> viewSortListTemp = null;
	Map<String, Object> boardinfoTemp = null;
    viewSortListTemp = (List<Map<String, Object>>)request.getAttribute("viewSortList");
    boardinfoTemp = (Map<String, Object>)request.getAttribute("boardinfo");

    String strSummary = "";
    for (Map<String, Object> el : viewSortListTemp) {
    	if ( (el.get("vSize") != "") && (el.get("vSize") != null) ) { 
    		if ( (el.get("vPrint").equals("title")) && (boardinfoTemp.get("boardCd").equals("Q")) ) {
    			strSummary += el.get("iOut") + ",답변,";
    		} else {
    			if (el.get("vPrint").equals("reg_dt")) {
    				strSummary += "작성일,";
    			} else {
    				strSummary += el.get("iOut") + ",";
    			}
    		}
    	}
    }
    strSummary = strSummary.substring(0, strSummary.length() - 1);
	//	끝 - 표 형태의 목록정보 제공 문자열 만들기 - 2020.11.09
	
	//		2021.12.21 XSS 방지를 위해 검색어 값을 처리한다.
	//		이 화면 내에서 param.searchTxt 이름을 strSearchTxt 변수로 대체한다.
	String strSearchTxt = request.getParameter("searchTxt");
	strSearchTxt = strSearchTxt.replaceAll("'", ""); 
	strSearchTxt = strSearchTxt.replaceAll("\"", "");
	strSearchTxt = strSearchTxt.replaceAll("&#34", "");
	strSearchTxt = strSearchTxt.replaceAll("&#40", "");
	strSearchTxt = strSearchTxt.replaceAll("&#39", "");
	strSearchTxt = strSearchTxt.replaceAll("&quot", "");
	strSearchTxt = strSearchTxt.replaceAll("&amp", "");
	strSearchTxt = strSearchTxt.replaceAll("&#38", "");	
	strSearchTxt = strSearchTxt.replaceAll("<", "");	
	strSearchTxt = strSearchTxt.replaceAll("&#60", "");	
	strSearchTxt = strSearchTxt.replaceAll("&lt", "");	
%>

<jsp:useBean id="toDay" class="java.util.Date" />
<!-- table_count_area-->
<c:set var="pageNo" value="1" />
<c:if test="${param.miv_pageNo!=''}">
	<c:set var="pageNo" value="${param.miv_pageNo}" />
</c:if>
<c:set var="pageSize" value="${LISTOP.ht.miv_pageSize}" />
<c:if test="${param.miv_pageSize!=''}">
	<c:set var="pageSize" value="${param.miv_pageSize}" />
</c:if>
<fmt:parseNumber var="pages" value="${totalcnt/pageSize}"/>
<%
//	농업정책보험 > 보험금지급사례 메뉴의 경우 탭으로 이루어져 있어서 이 메뉴일 경우 숨김문자 처리해주어야 함   - 2020.11.10
//	알림마당 > 공지사항 동일함
%>


<!-- <h4 class="hidden" id="hiddenString"></h4>	 -->	<!-- 2024 웹 접근성 -->
<div class="table_search_area">
	<div class="table_search_wrap">
		<label for="searchKey" class="hide2">구분 선택</label>
		<select title="검색범위 선택" name="searchKey" id="searchKey" class="three_member70 select_style"><option value="A" <c:if test="${param.searchKey eq 'A' }" >selected</c:if> >전체</option><option value="T" <c:if test="${param.searchKey eq 'T' }" >selected</c:if> >제목</option><option value="C" <c:if test="${param.searchKey eq 'C' }" >selected</c:if> >내용</option></select>
		<div class="search_input"><input type="text" class="txt" title="검색어 입력" id="searchTxt" name="searchTxt" placeholder="검색어를 입력하세요" value="<%= strSearchTxt %>"  onKeyDown="enter();"/></div>
		<button type="button" class="btn_search" onclick="searchBtn();">검색</button>
		<!-- <button  type="button" class="btn_total b_right" title="초기화" onclick="searchAll();">전체보기</button> -->
	</div>
	<div class="table_cnt_wrap">
		<p class="totalcnt">총 <span>${totalcnt }</span>건</p>
		<p class="totalpage"><em>${pageNo}</em>/<em><fmt:formatNumber value="${pages>1?pages+(1-(pages%1))%1:1}" type="number"/></em> 페이지</p>
	</div>
</div>
<!-- <span class="search_btn_area">
	<button class="btn sch" title="조회" onclick="changePageSize();"><span>보기</span></button>
</span> -->
<!--// table_count_area -->

<!-- list_table_area -->
<c:if test="${boardinfo.boardId eq 51 and param.menuId eq 51 and param.selTab eq 1}">
<div class="note_box_area mt15 mb15">
	<div class="note_box">이곳은 농림수산식품모태펀드 질의응답 게시판입니다.<br />
	보험 관련 질의 글은 "농업정책보험 질의응답" 게시판에, 손해평가사 관련 질의 글은 "손해평가사 질의응답" 게시판에 작성 부탁드립니다.</div>
</div>
</c:if>
<div class="table_area table_wrap scroll">
	<table class="tstyle_list">
		<caption>${boardinfo.title} 게시글 목록을 <%= strSummary %> 순으로 정보를 제공함</caption>
		<colgroup>
			<c:forEach items="${viewSortList }" var="view">
				<c:if test="${view.vSize ne '' and view.vSize ne null}">
					<c:if test="${view.vPrint eq 'title' and boardinfo.boardCd eq 'Q'}">
						<col style="width: ${view.vSize - 12}%;" />
						<col style="width:12%;" />
					</c:if>
					<c:if test="${view.vPrint ne 'title' and boardinfo.boardCd eq 'Q'}">
						<col style="width: ${view.vSize}%;" />
					</c:if>
					<c:if test="${ boardinfo.boardCd ne 'Q'}">
						<col style="width: ${view.vSize}%;" />
					</c:if>
				</c:if>
			</c:forEach>
		</colgroup>
		<thead>
		 <tr>
		 
		<c:set var="ttcnt" value="0"/>
		<c:forEach items="${viewSortList }" var="view" varStatus="i">
			<c:set var="totcnt" value="${view.totalCnt }" />
			<c:if test="${view.vSize ne '' and view.vSize ne null}">
				<c:set var="ttcnt" value="${ttcnt+1 }"/>	<%	//	이거 왜 하는 거임? %>
					<th scope="col">
					<c:if test="${view.vPrint eq 'title' and boardinfo.boardCd eq 'Q'}">
						<c:set var="ttcnt" value="${ttcnt+1 }"/>	<%	//	이거 왜 하는 거임? %>
						${view.iOut }
					</th>
					<th scope="col">답변
					</c:if>
					<c:if test="${view.vPrint ne 'title' and boardinfo.boardCd eq 'Q'}">
						<c:if test="${view.vPrint eq 'reg_dt'}">작성일</c:if>
						<c:if test="${view.vPrint ne 'reg_dt'}">${view.iOut }</c:if>
					</c:if>
					<c:if test="${ boardinfo.boardCd ne 'Q'}">
						${view.iOut }
					</c:if>
					</th>
			</c:if>
		</c:forEach>

		</tr>
		</thead>
		<tbody>
			<c:forEach items="${boardList }" var="list">
			<tr>
				<c:forEach items="${viewSortList }" var="view" varStatus="i">
				<%-- <if test="${view.vPrint ne 'secret' &&  view.vPrint ne 'reply_status' && view.vPrint ne 'link' && view.vPrint ne 'comment'}"> --%>
				<c:if test="${view.vSize ne '' and view.vSize ne null}">
				<td class="<c:if test="${view.vPrint eq 'title'}"> subject</c:if><c:if test="${view.vPrint eq 'title' && list.relevelSeq > 0}"> reply</c:if> c_${view.vPrint}">
				<c:if test="${view.vPrint eq 'number'}"><%-- 번호 --%>
					<c:if test="${list.notiYn eq 'Y'}"><img src="/images/icon/ico_noti.png" alt="공지" /></c:if>
					<c:if test="${list.notiYn ne 'Y'}">${list.totalCnt - (list.rnum-1)}</c:if>
				</c:if>
				<%-- 제목 --%>
				<c:if test="${view.vPrint eq 'title'}">


				<c:if test="${list.relevelSeq > 0}"><span>답글</span></c:if><%-- 답글 여부 --%>

					<c:if test="${empty list.titleLink}"><%-- 제목링크 사용안함 --%>
						<c:if test="${boardinfo.detailYn eq 'Y'}"><%-- 디테일 사용 --%>
							<c:if test="${list.secret eq 'Y' }"><%-- 비밀글 --%>
								<c:if test="${empty list.regUserno }"><%-- 비밀글이면서 비회원글인경우 --%>
									<c:if test= "${empty sUserNo }"><a href="#;"  class="detail_view"  viewId="${list.contId}"  openYn="${list.openYn}">${list.title }</a></c:if>
									<c:if test= "${not empty sUserNo }">${list.title }</c:if>
								</c:if>
								<c:if test="${not empty list.regUserno }"><%-- 비밀글이면서 회원글 인경우 --%>
									<c:if test= "${s_user_no eq list.regUserno }"><a href="#;"  class="detail_view"  viewId="${list.contId}"  openYn="${list.openYn}">${list.title }</a></c:if>
									<c:if test= "${s_user_no ne list.regUserno }">${list.title }</c:if><%-- 비밀글은 관리자 페이지에서 확인가능 --%>
								</c:if>
							</c:if>
							
							<c:if test="${list.openYn eq 'N' && boardinfo.boardCd eq 'Q' }">
								<a href="#;" class="detail_view"  viewId="${list.contId}"  openYn="${list.openYn}">${list.title } <img src="/images/icon/ico_lock.png" alt="비밀글" class="ml5" /></a>
							</c:if>
							
							<c:if test="${list.openYn ne  'N' }">
								<a href="#;" class="detail_view"  viewId="${list.contId}"  openYn="${list.openYn}">${list.title }</a>
							</c:if>
							<c:if test="${list.commentCnt > 0 }">
								<span class="re_count" id="comment_cnt">[<strong>${list.commentCnt }</strong>]</span><%-- 댓글수 --%>
							</c:if>
							<c:if test="${list.secret eq 'Y'}"><img src="/images/icon/ico_lock.png" alt="비밀글" class="ml5" /></c:if><%-- 비밀글 여부 아이콘 --%>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reply_status') != -1}">
			<%-- 					<c:if test="${list.replyYn eq 'Y'}">
									<span id="reply_status"><img src="/images/front/icon/reply.gif" alt="답변완료" /></span>답변 사용여부 아이콘
								</c:if>
								<c:if test="${list.replyYn eq 'N'}">
									<span id="reply_status"><img src="/images/front/icon/standby.gif" alt="답변대기" /></span>답변 사용여부 아이콘
								</c:if> --%>
							</c:if>
						</c:if>
						<c:if test="${boardinfo.detailYn ne 'Y'}"><%-- 디테일 사용안함 --%>
							${list.title }
						</c:if>
					</c:if>
					<c:if test="${not empty list.titleLink}"><%-- 제목링크 사용 --%>
						<a href="${list.titleLink }" target="_blank">${list.title }</a>
					</c:if>
					<fmt:formatDate value='${toDay}' pattern='yyyyMMdd' var="nowDate"/>		
					<c:if test = '${fn:substring(list.regDt,0,8) eq nowDate}'><img src="/images/main/icon_new.gif" alt="새글"></c:if>	
				</c:if>
									
				<%-- // 제목 --%>
				<%-- 첨부파일 --%>
				<c:if test="${view.vPrint eq 'attach'}">
					<c:if test="${boardinfo.detailYn ne 'Y'}"><%-- 디테일 사용안함 --%>
						<c:if test="${not empty list.attachId}"><%-- 첨부파일이 있는경우 --%>
							<c:if test="${not empty list.attachId}"><%-- 첨부파일이 1개인경우 다운로드 --%>
							</c:if>
							<img src="/images/front/icon/icon_file.png" alt="${list.originImgNm}" />
							<c:if test="${empty list.path}">
							</c:if>
						</c:if>
					</c:if>
					<c:if test="${boardinfo.detailYn eq 'Y'}"><%-- 디테일 사용 --%>
						<c:if test="${not empty list.path}"><%-- 첨부파일이 있는경우 --%>
						 <img src="/images/icon/ico_file.png" alt="${list.originImgNm}" />
						</c:if>
					</c:if>
				</c:if>
				<%-- // 첨부파일 --%>
				<c:if test="${view.vPrint eq 'reg_dt'}">${fn:substring((list.regDt),0,4)}-${fn:substring((list.regDt),4,6)}-${fn:substring((list.regDt),6,8)}</c:if><%-- 작성일 --%>
				<%-- 썸네일 --%>
				<c:if test="${view.vPrint eq 'thumb'}">
					<c:if test="${not empty list.imgPath}">
						<img src="${list.imgPath}${list.imgNm}" width="56" alt="썸네일" />
					</c:if>
					<c:if test="${empty list.imgPath}">
						<img src="/images/front/common/no_img.png" alt="첨부 이미지 없음" />
					</c:if>
				</c:if>
				<%-- //썸네일 --%>
				<c:if test="${view.vPrint eq 'reg_mem_nm'}"><c:if test="${boardinfo.boardCd eq 'Q'}">${fn:substring(list.regMemNm,0,1) }**</c:if><c:if test="${boardinfo.boardCd ne 'Q'}">${list.regMemNm }</c:if></c:if><%-- 조회수 --%>
				<c:if test="${view.vPrint eq 'hit'}">${list.hit }</c:if><%-- 조회수 --%>
				</td>
				</c:if>
				<c:if test="${view.vPrint eq 'title' and  boardinfo.boardCd eq 'Q'}">
				<td>
	<%-- 				<c:if test="${list.replyYn eq 'Y'}">
						답변완료
					</c:if>
					<c:if test="${list.replyYn eq 'N'}">
						답변대기
					</c:if> --%>
					<c:if test="${param.boardId ne '20083'}">
						<c:if test="${list.replyYn eq 'Y'}">
							<span id="reply_status" class="reply_status perfect">답변완료</span><%-- 답변 사용여부 아이콘 --%>
						</c:if>
						<c:if test="${list.replyYn eq 'N'}">
							<span id="reply_status" class="reply_status wait">답변대기</span><%-- 답변 사용여부 아이콘 --%>
						</c:if>
					</c:if>
					<c:if test="${param.boardId eq '20083'}">
						<c:if test="${list.replyYn eq 'Y'}">
							<span id="reply_status"><img src="/images/front/icon/done.gif" alt="처리완료" /></span><%-- 답변 사용여부 아이콘 --%>
						</c:if>
						<c:if test="${list.replyYn eq 'N'}">
							<span id="reply_status"><img src="/images/front/icon/doneby.gif" alt="처리대기" /></span><%-- 답변 사용여부 아이콘 --%>
						</c:if>
					</c:if>
				</td>
				</c:if>
				</c:forEach>
			</tr>
			</c:forEach>
			<c:if test="${empty boardList }">
			<tr>
				<td colspan="${ttcnt }" class="">게시글이 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>

</div>
<!--// list_table_area -->

<!-- paging_area -->
${boardPagging}
<!--// paging_area -->
	
<!-- button_area -->
<div class="btn_area btn_board">
<!--     // 2019.04.05 개인정보 처리 지적 후속 조치     // 20062 추가 - 2020.10.19 -->
	<% // <c:if test = "${MEMBER_AUTH.sName eq null and (boardinfo.boardId eq 51 or boardinfo.boardId eq 20057)}"> </c:if> %>
	<c:if test = "${MEMBER_AUTH.sName eq null and ( (boardinfo.boardId eq 51) or (boardinfo.boardId eq 20062) or (boardinfo.boardId eq 20075))}">
		<a href="#;" class="btn_submit btn_diskey_pass_submit" id="diskey_pass_btn"   title="글쓰기">글쓰기</a>
	</c:if>
<!-- 	20230825 실명인증시 공지사항 페이지 글쓰기 버튼 노출 문제 : sName에 값이 생겨버려서 버튼이 보였던것. -->
	<%-- 	<c:if test="${MEMBER_AUTH.sName ne null or boardinfo.boardId eq 20072 or boardinfo.boardId eq 20075}"> --%>
<%-- `	<c:if test="${MEMBER_AUTH.sName ne null or boardinfo.boardId eq 20072}"> --%>
	<c:choose>
		<c:when test="${MEMBER_AUTH.sName ne null and ( (boardinfo.boardId eq 51) or (boardinfo.boardId eq 20062) or (boardinfo.boardId eq 20075))}">
			<a href="#;" class="btn_insert_submit" title="글쓰기">글쓰기</a>
		</c:when>
		<c:when test="${boardinfo.boardId eq 20072}">
			<a href="#;" class="btn_insert_submit" title="글쓰기">글쓰기</a>		
		</c:when>
		<c:when test="${boardinfo.boardId eq 52}">
			<%-- FAQ 글쓰기 버튼 않보이게 --%>
		</c:when>
	</c:choose>
	
		<%-- 개발에서 본인인증 없이 사용하기 위해 만듬--%>
<!-- 			<a href="#;" class="btn_insert_submit" title="글쓰기" style="background:red;">본인인증 없이<br/>글쓰기</a>		 -->
		<%-- 개발에서 본인인증 없이 사용하기 위해 만듬--%>
</div>
<!--// button_area -->
<div class="board_bot_info">
	<p class="text">우리원 홈페이지는 개인정보를 수집을 하고 있지 않음을 알려드립니다.</p>
	<c:if test="${param.menuId ne 5362 && param.menuId ne 5472 && param.menuId ne 5363}"><%	//	기존 5470, 5471은 가온누리인베지움 개설로 필요 없음. 2021.05.21 이외 추가한 menuId	%>
	<p class="text mb5">2019.4.8. 이전에 작성하신 게시판 글 확인이 필요하신 분은 아래 부서로 연락주시면 성실히 답변 드리겠습니다.</p>
	<ul class="list_style1">
		<li>농식품모태펀드 관련 : <span name="telPC">02-3775-6775</span><span name="telMO" style="display:none;"><a href="tel:02-3775-6775" title="전화걸기">02-3775-6775</a></span></li>
		<li>재해보험(가축) : <span name="telPC">02-3771-6841</span><span name="telMO" style="display:none;"><a href="tel:02-3771-6841" title="전화걸기">02-3771-6841</a></span><span class="slash">/</span>
			 재해보험(안전) : <span name="telPC">02-3771-6845</span><span name="telMO" style="display:none;"><a href="tel:02-3771-6845" title="전화걸기">02-3771-6845</a></span><span class="slash">/</span>
			 손해평가사 : <span name="telPC">02-3771-6816</span><span name="telMO" style="display:none;"><a href="tel:02-3771-6816" title="전화걸기">02-3771-6816</a></span></li>
	</ul>
	</c:if>
	<c:if test="${param.menuId eq 5470 || param.menuId eq 5471}">
	<ul class="list_type_daopen">
		<li>농식품크라우드펀딩 관련 : <span name="telPC">02-3775-6787</span><span name="telMO" style="display:none;"><a href="tel:02-3775-6787" title="전화걸기">02-3775-6787</a></span></li>
	</ul>
	</c:if>
</div>
	
<script src="/js/apfs/board.js"></script>
<script>
	$(document).ready( function() {
		var strSelTab = $("#selTab").val();
		var strMenuId = $("#menuId").val();

		makeTabString(strSelTab, strMenuId)
		changeTelLink();			//	전화번호 링크 만들기 - 2021.03.08
	});
</script>		