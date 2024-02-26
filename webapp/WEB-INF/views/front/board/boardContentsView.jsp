<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script src="/js/apfs/board.js"></script>
<%
   //치환 변수 선언합니다.
   pageContext.setAttribute("cr", "\r"); //Space
   pageContext.setAttribute("cn", "\n"); //Enter
   pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
   pageContext.setAttribute("br", "<br/>"); //br 태그
   pageContext.setAttribute("lt", "&lt;"); //br 태그
   pageContext.setAttribute("gt", "&gt;"); //br 태그


	//	시작 - 표 형태의 정보 제공 문자열 만들기 - 2020.11.10
	//	답변형 게시판은..."답변" 항목이 빠졌다				boardinfo.boardCd eq 'Q'
	//	strSummary : 번호,제목,첨부파일,작성자,작성일,조회수 - board_id = '20057'
	List<Map<String, Object>> viewSortListTemp = null;
	Map<String, Object> boardinfoTemp = null;
   viewSortListTemp = (List<Map<String, Object>>)request.getAttribute("viewSortList");
   boardinfoTemp = (Map<String, Object>)request.getAttribute("boardinfo");
   String strSummary = "제목,";			//	반드시 포함하는 항목 -> 다음 항목은 "작성일  -> 20230110 김동민 웹품질진단  테이블 설명에 작성자, 내용 추가"
   String strAttach = "N";					//	첨부파일 노출 여부
   ArrayList<String> strNoDateBoardId = new ArrayList<String>();		//	작성일이 노출되지 않는 게시판 ID 저장
   strNoDateBoardId.add("20058");
   strNoDateBoardId.add("20059");
   strNoDateBoardId.add("20064");
   strNoDateBoardId.add("20065");
   strNoDateBoardId.add("20066");
   ArrayList<String> strNoDateBoardItem = new ArrayList<String>();		//	노출하면 안되는 게시판 항목들 저장
   strNoDateBoardItem.add("title");
   strNoDateBoardItem.add("name");
   strNoDateBoardItem.add("contents");
   strNoDateBoardItem.add("attach");
   strNoDateBoardItem.add("number");
   strNoDateBoardItem.add("reg_dt");
   strNoDateBoardItem.add("reply_yn");
   strNoDateBoardItem.add("reply_status");
   strNoDateBoardItem.add("reply_content");
   strNoDateBoardItem.add("reg_mem_nm");

   if (!strNoDateBoardId.contains(boardinfoTemp.get("boardId"))) {
		strSummary += "작성자,작성일,";
	}
   
   for (Map<String, Object> el : viewSortListTemp) {
/*	   for( Map.Entry<String, Object> elem : el.entrySet() ){ 
		   System.out.println( "key : " + elem.getKey() + ", value : " + elem.getValue() ); 
		}    */
	   System.out.println("");
	   if ( el.containsKey("iUser") ) {
			if (el.get("iUser").equals("1")) {
				if ( (el.get("iUse").equals("attach")) ) { 
					strAttach = "Y";
				} else if (!strNoDateBoardItem.contains(el.get("iUse"))) {
					strSummary += el.get("iOut") + ",";
				}
			}
	   }
   }
   if ( boardinfoTemp.get("boardCd").equals("Q") ) {
   	strSummary += "공개여부,상태,";
   }
   if ( strAttach.equals("Y") ) {
   	strSummary += "첨부파일,내용 ";
   }

   strSummary = strSummary.substring(0, strSummary.length() - 1);
	//	끝 - 표 형태의 목록정보 제공 문자열 만들기 - 2020.11.09
//System.out.println("strSummary : " + strSummary);
%>

<style>
div.board-img {
	overflow:hidden;
	padding:0px;
	margin-bottom:20px;
}

div.board-img p.img{
	vertical-align:baseline;
	width:480px;
	height:360px;
	float:left;
	/* margin-right:40px; */
}

div.board-img p.img img {
	width:480px;
	height:360px;
	display:none;
}
div.board-img p.img img.curr {
	display:block;
}

div.board-img ul{
	margin:0;
	vertical-align:baseline;
	float:left;
	width:190px;
	height:360px;
	background:url(/images/bg_boardview_img.png) no-repeat;
	padding:20px 29px 0 28px;
}

div.board-img ul li{
	padding-bottom:15px;
}

div.board-img ul li a{
	display:block;
	overflow:hidden;
	width:133px;
	height:100px;
}

div.board-img ul li a.curr{
	border:3px solid #03b1ed;
	width:133px;
	height:100px;
}

div.board-img ul li a img{
	display:block;
	width:133px;
	height:100px;
}

div.board-img ul li a.curr img{
	margin:-3px;
}

.pre_view {
	font-size:12px;
}

.next_view {
	font-size:12px;
}

</style>

<script>
var boardContentsListPageUrl = "<c:url value='/front/board/boardContentsListPage.do'/>";
var boardContentsWriteUrl = "<c:url value='/front/board/boardContentsWrite.do'/>";
var boardContentsViewUrl = "<c:url value='/front/board/boardContentsView.do'/>";
var deleteBoardContentsUrl = "<c:url value='/front/board/deleteBoardContents.do'/>";
var chkCommentUrl = "<c:url value='/front/board/chkComment.do'/>";
var saveCommentUrl = "<c:url value='/front/board/saveComment.do'/>";
var deleteCommentUrl = "<c:url value='/front/board/deleteComment.do'/>";
var boardCommentListUrl = "<c:url value='/front/board/boardCommentList.do'/>";
var saveSatisfyUrl = "<c:url value='/front/board/saveSatisfy.do'/>";
var saveRecommendUrl = "<c:url value='/front/board/saveRecommend.do'/>";
var loadRecommendUrl = "<c:url value='/front/board/loadRecommend.do'/>";
var passPopupUrl = "<c:url value='/front/board/boardContentsPassPopup.do'/>";
var chkCommentUrl = "<c:url value='/front/board/chkComment.do'/>";
var listUrl = "<c:url value='/front/board/boardContentsListPage.do'/>";

var auth_sname = "${MEMBER_AUTH.sName}";


var cmt_el;
var cmt_commentid;
var mode;

<%-- 2018.07.13(금)
function contentsEdit(){
  var f = document.writeFrm;
	
  $("#mode").val("E");

    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
}

function contentsReply(){
  var f = document.writeFrm;
	
  $("#mode").val("R");

    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
}

function contentsDelete() {
	if (confirm('게시물을 삭제하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: deleteBoardContentsUrl,
			data :jQuery("#writeFrm").serialize(),
			dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true") {					
					$("#writeFrm").attr("target", "_self");
					$("#writeFrm").attr("action", boardContentsListPageUrl);
					$("#writeFrm").submit();
				}
			}
		});
    }
}

// 만족도 저장
function saveSatisfy(){

	// 로그인 여부 확인하기
	var sid = "${s_user_no }";
	var yn = "${contentsinfo.satisfy_yn}";
	if(sid == ""){
		alert("로그인이 후 참여 가능합니다.");
		goPage('7d8de154663840ad83ae6d93bf539c5c', '', '');
		return;
	}

	if(yn == "Y"){
		alert("이미 참여하였습니다.");
		return;
	}

	var url = saveSatisfyUrl;
	if (confirm('만족도를 저장하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: url,
			data :jQuery("#satisfyFrm").serialize(),
			dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					$(".satisfaction_area").hide();
				}
			}
		});
    }
}

// 추천하기
function saveRecommend(){

	// 로그인 여부 확인하기
	var sid = "${s_user_no }";
	if(sid == ""){
		alert("로그인이 후 참여 가능합니다.");
		goPage('7d8de154663840ad83ae6d93bf539c5c', '', '');
		return;
	}

	var url = saveRecommendUrl;
	$.ajax({
		type: "POST",
		url: url,
		data : {
			contId : "${param.contId}",
			recommend_yn : $("#recommend_yn").val()
		},
		dataType: 'json',
		success:function(data){
			alert(data.message);
			// 추천가져오기
			//loadRecommend();
		}
	});
}

// 추천가져오기
function loadRecommend(){
	return;
	var url = loadRecommendUrl;
	$.ajax({
		type: "POST",
		url: url,
		data : {
			contId : "${param.contId}",
		},
		dataType: 'json',
		success:function(data){
			if(data.recommend_yn == "Y"){
				$("#recommend_cnt").html(data.recommend_cnt);
				$("#recommend_yn").val(data.recommend_yn);
				$(".btn_recommend").addClass("pick");
			}else{
				$("#recommend_cnt").html(data.recommend_cnt);
				$("#recommend_yn").val(data.recommend_yn);
				$(".btn_recommend").removeClass("pick");
			}
		}
	});
}

function down(url,ofn){
	var sp = url.split('|');
	url2 = sp[0]
	for ( var i in sp ) {
        if (i>0 && i<sp.length-1){
        	url2 += '/'+sp[i];
        }else{
        	fn = sp[i];
        }
      }
	//var downlosd = '/commonfile/fileDownLoad.do?file_path='+url2+'&file_nm='+fn+'&orignl_file_nm='+ofn;
	//window.open(downlosd);

	var f = document.writeFrm;

	$("#file_path").val(url);
	$("#orignl_file_nm").val(ofn);
	$("#file_nm").val(ofn);

    f.target = "_open";
    f.action = '/downloadUrl.do';
    f.submit();
}
--%>
function boardUpdate(){


}

function fileIdd(){
	alert("a");
	history.replaceState({}, null, location.pathname);
}

</script>
<form id="writeFrm" name="writeFrm" method="post">
	<input type='hidden' id="mode" name='mode' value="E" />
	<input type='hidden' id="boardId" name='boardId' value="${contentsinfo.boardId}" />
	<input type='hidden' id="contId" name='contId' value="${param.contId}" />
	<input type='hidden' id="pwdContId" name='pwdContId' value="${param.pwdContId}" />
	<input type='hidden' id="recommend_yn" name='recommend_yn' value="" />
	<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${param.miv_pageNo }" />
	<input type='hidden' id="s_reply_ststus" name='s_reply_ststus' value="${param.reply_ststus }" />
	<input type='hidden' id="attachId" name='attachId' value="${contentsinfo.attachId}" />
	<input type='hidden' id="searchKey" name='searchKey' value="${param.searchKey }" />
	<input type='hidden' id="searchTxt" name='searchTxt' value="${param.searchTxt }" />
	<input type='hidden' id="s_cate_id" name='s_cate_id' value="${param.cate_id }" />
	<input type='hidden' id="selTab" name='selTab' value="${param.selTab }" />
	<input type='hidden' id="file_path" name='file_path' value="" />
	<input type='hidden' id="file_nm" name='file_nm' value="" />
	<input type='hidden' id="orignl_file_nm" name='orignl_file_nm' value="" />
	<input type='hidden' id="requestUrl" name='requestUrl'  />
	
	<c:forEach items="${fileList}" var="list">
	<input type='hidden' id="fileId_${list.fileId }" name='fileId' value="${list.fileId }" /><!-- 2개 이상 파일이 첨부된 경우 ID 값 중복 마크업 오류 발생 수정 - 2022.02.03 -->
	</c:forEach>
</form>

<div id="location_area">
	<div class="content_tit" id="containerContent">
        <h3>${MENU.menuNm}</h3>
    </div>
    <div class="content">
		<c:set var="pageNo" value="1" />
		<c:if test="${param.miv_pageNo!=''}">
			<c:set var="pageNo" value="${param.miv_pageNo}" />
		</c:if>
		<c:set var="pageSize" value="${LISTOP.ht.miv_pageSize}" />
		<c:if test="${param.miv_pageSize!=''}">
			<c:set var="pageSize" value="${param.miv_pageSize}" />
		</c:if>
		<fmt:parseNumber var="pages" value="${totalcnt/pageSize}"/>
		<% /* div class="table_search_area" style="display:none">
			<div class="table_search_left">
				<p class="totalcnt">총 <span>${totalcnt }</span>건 <em>${pageNo}</em>/<em><fmt:formatNumber value="${pages+(1-(pages%1))%1}" type="number"/></em> 페이지</p>
			</div>
			<div class="table_search_right">
				<label for="searchKey" class="hide2">구분 선택</label>
				<select title="검색범위 선택" name="searchKey" id="searchKey" class="three_member80"><option value="A" <c:if test="${param.searchKey eq 'A' }" >selected</c:if> >전체</option><option value="T" <c:if test="${param.searchKey eq 'T' }" >selected</c:if> >제목</option><option value="C" <c:if test="${param.searchKey eq 'C' }" >selected</c:if> >내용</option></select>
				<div class="search_input"><input type="text" class="txt" title="검색어 입력" id="searchTxt" name="searchTxt" value="${param.searchTxt}"  onKeyDown="enter();"/></div>
				<button type="button" class="btn_search" title="조회" onclick="search();">검색</button>
				<button  type="button" class="btn_total b_right" title="초기화" onclick="searchAll();">전체보기</button>
			</div>
		</div */ %>

	<div class="contents_detail">
		<!--//S: 게시판 형식 보기 -->
		<div class="table_area table_wrap scroll">
			<table class="tstyle_view">
				<caption>'${contentsinfo.title }' 게시물의 상세 보기 화면으로 <%= strSummary %> 정보를 제공함.</caption>
				<colgroup>
					<col style="width:20%" />
					<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" id="tstyle_view2">제목</th>
						<td headers="tstyle_view2"><strong>
						<c:if test="${fn:indexOf(boardinfo.itemUse, 'cate') != -1}">
							<c:if test="${not empty contentsinfo.cateNm}">[${contentsinfo.cateNm }]</c:if>
						</c:if>
						${contentsinfo.title }</strong></td>
					</tr>
					 
					<tr>	<!-- 20220929 김동민 대리 웹 품질진단 -->
						<th scope="row" id="tstyle_view3">작성자</th>
						<td headers="tstyle_view3">
						<c:if test = "${boardinfo.boardId eq '51' }">${fn:substring(contentsinfo.regMemNm,0,1)}**</c:if>
						<c:if test = "${boardinfo.boardId ne '51' }">${contentsinfo.regMemNm}</c:if>
						</td>

					</tr>
					
					<tr>
					<th scope="row" id="tstyle_view4">작성일</th>	<!-- 20221014 김동민 웹 품질진단 -->
					<td headers="tstyle_view4">${fn:substring((contentsinfo.regDt),0,4)}-${fn:substring((contentsinfo.regDt),4,6)}-${fn:substring((contentsinfo.regDt),6,8)}</td>
					</tr>
					
					<%-- <tr>
<c:choose>
<c:when test = "${boardinfo.boardId eq '20058' }">style="display:none;"></c:when>
<c:when test = "${boardinfo.boardId eq '20059' }">style="display:none;"></c:when>
<c:when test = "${boardinfo.boardId eq '20064' }">style="display:none;"></c:when>
<c:when test = "${boardinfo.boardId eq '20065' }">style="display:none;"></c:when>
<c:when test = "${boardinfo.boardId eq '20066' }">style="display:none;"></c:when>
<c:when test = "${param.menuId eq '5395' }">style="display:none;"></c:when>
<c:otherwise>
><th scope="row">작성일</th>
<td>${fn:substring((contentsinfo.regDt),0,4)}-${fn:substring((contentsinfo.regDt),4,6)}-${fn:substring((contentsinfo.regDt),6,8)}</td>
</c:otherwise>
</c:choose>
</tr> --%>
					<c:forEach var="itemFront" items="${viewSortList}" varStatus="status">
					<c:if test="${itemFront.iUser eq '1' and itemFront.iUse eq 'attach'}">
						<c:set var="attachUse" value="Y"/>
					</c:if>
					<c:if test="${itemFront.iUser eq '1' and itemFront.iUse ne 'title' and itemFront.iUse ne 'name' and itemFront.iUse ne 'contents' and itemFront.iUse ne 'attach' and itemFront.iUse ne 'number' and itemFront.iUse ne 'reg_dt' and itemFront.iUse ne 'reply_yn' and itemFront.iUse ne 'reply_status' and itemFront.iUse ne 'reply_content' and itemFront.iUse ne 'reg_mem_nm'}">
					<tr>
						<th scope="row" id="tstyle_view5">${itemFront.iOut}</th>
						<td headers="tstyle_view5">${contentsinfo[itemFront.iUse]}<c:if test="${itemFront.iUse eq 'reply_date' and !empty contentsinfo.contentsTxt}">${contentsinfo['replyDate']}</c:if></td>
					</tr>
					</c:if>
					</c:forEach>
					<c:if test="${boardinfo.boardCd eq 'Q'}">
					<tr>
						<th scope="row" id="tstyle_view6">공개여부</th>
						<td headers="tstyle_view6"><c:if test="${contentsinfo.openYn eq 'Y' }">공개</c:if><c:if test="${contentsinfo.openYn ne 'Y' }">비공개</c:if></td>
					</tr>
					<tr>
					<th scope="row" id="tstyle_view7">상태</th>
						<td headers="tstyle_view7"><c:if test="${empty contentsinfo.contentsTxt }">답변대기</c:if><c:if test="${!empty contentsinfo.contentsTxt}">답변완료</c:if></td>
					</tr>
					</c:if>
					<%-- <c:if test="${attachUse eq 'Y'}"> --%>		<!-- 20221014 김동민 웹 품질진단 -->
					<tr>
						<th scope="row" id="tstyle_view8">첨부파일</th>
							<%-- <c:if test="${empty contentsinfo.attach_id}">	<!-- 20221014 김동민 웹 품질진단 -->
								<td>-</td>
							</c:if> --%>
						<td headers="tstyle_view8">
							<ul class="file_view">
								<%-- ${list.fileId}', '${list.originFileNm}', '${list.filePath}', '${list.fileSize}', '${list.attachId}' --%>

								<c:forEach items="${fileList}" var="list">
									<li>
<%-- 										<a href="/commonfile/fileidDownLoad.do?fileId=${list.fileId}" download="${list.originFileNm}">${list.originFileNm}</a> --%>
										<a href="/commonfile/fileidDownLoad.do?fileId=${list.fileId}&attachId=${list.attachId}" download="${list.originFileNm}">${list.originFileNm}</a>
										<%-- <a href="/commonfile/fileidDownLoad.do?fileId=${list.fileId}"  target="_blank" class="download" title="다운받기">${list.originFileNm}</a> --%>

									</li>
								</c:forEach>

								<!-- <li><a href="#none">첨부파일제목이노출됩니다.pdf </a></li> -->
							</ul>
						</td>
					</tr>
					<%-- </c:if> --%>
					<tr>
						<td colspan="2" class="td_p">
							<%-- <c:if test="${boardinfo.boardCd=='A' or  boardinfo.boardCd=='W' }">
							<div class="board-img">
								<p class="img">
									<c:forEach items="${fileList}" var="list" varStatus="stauts">
									<img src="${list.filePath}" alt="" id="boardimg0${stauts.index+1}" class="<c:if test="${stauts.index==0}">curr</c:if>" width='334' height='250'/>
									</c:forEach>
								</p>
								<ul>
									<c:forEach items="${fileList}" var="list" varStatus="stauts">
									<li>
										<a href="#boardimg0${stauts.index+1}" class="<c:if test="${stauts.index==0}">curr</c:if>"><img src="${list.filePath}" alt="" id="boardimg0${stauts.index+1}" class="" width='334' height='250'/></a>
									</li>
									</c:forEach>
								</ul>
							</div>
							</c:if> --%>
							<c:set var="text" value="${fn:replace(fn:replace(contentsinfo.contents, cn, br),'iffm','iframe')}"  scope="request"/>
	                    	<% String Txt = request.getAttribute("text").toString().replaceAll("&lt;", "<").replaceAll("&gt;", ">"); %>

							<%=Txt %>
						</td>
					</tr>
					<c:if test="${boardinfo.boardCd eq 'Q' and !empty contentsinfo.contentsTxt}">
					<tr>
						<td colspan="2" class="td_p">
							<h4>[답변]</h4>
							<c:set var="text" value="${fn:replace(contentsinfo.contentsTxt, cn, br)}"  scope="request"/>
	                    	<% String Txt2 = request.getAttribute("text").toString().replaceAll("&lt;", "<").replaceAll("&gt;", ">"); %>

							<%=Txt2 %>
						</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		
		<%-- 230511 김동민 공공누리 1유형--%>
		<c:if test="${boardinfo.boardId eq '10026' or boardinfo.boardId eq '42' or boardinfo.boardId eq '43' or boardinfo.boardId eq '44' or boardinfo.boardId eq '45'}">
		<div style='position: relative;'><div style='position: absolute;'><a href='http://www.kogl.or.kr/info/licenseType3.do' target='_blank' title="새창"><img alt='제3유형' src='http://www.kogl.or.kr/open/web/images/images_2014/codetype/new_img_opentype03.png' /></a></div><div style='padding-left:235px;'> 본 저작물은 "공공누리" <a title="새창" href='http://www.kogl.or.kr/info/licenseType3.do' target='_blank'>제3유형:출처표시+변경금지</a> 조건에 따라 이용 할 수 있습니다.</div></div>
		</c:if>
		<%-- 230511 김동민 공공누리 1유형--%>
		
		<div class="btn_area btn_board">
			<%-- 회원이면서 답글쓰기 권한이 있는경우 --%>
			<c:if test="${not empty MEMBER.memberId }">
				<c:if test="${MEMBER.memberId  eq contentsinfo.regMemId}">
				<a href="#none" class="btn_reply">답변</a>
				<a href="#none" class="btn_modify">수정</a>
				<a href="#none" class="btn_cancel">삭제</a>
				</c:if>
			</c:if>
			<c:if test = "${editYn eq 'Y' and (boardinfo.boardCd eq 'Q' or boardinfo.boardId eq 20075 or boardinfo.boardId eq 20072 or boardinfo.boardId eq 20057  ) and empty contentsinfo.contentsTxt}">
			<a href="#none" class="btn_modify">수정</a>
			<a href="#none" class="btn_cancel">삭제</a>
			</c:if>
			<a href="#none"  class="btn_list_submit">목록</a>
		</div>
		<!-- 
		<c:if test = "${boardinfo.boardId ne 20075 and boardinfo.boardId ne 20072 and boardinfo.boardId ne 20057}">
		<div class="nextprev_area" >
			<ul class="nextprev_list">
				<li><strong class="prev_list">다음글</strong><c:if test="${prenext.preId ne null}"><a href="#none" class="prev_view" preId="${prenext.preId }"  preOpenYn="${prenext.preOpenYn }" >${prenext.preTitle }</a></c:if><c:if test="${prenext.preId eq null}">다음글이 없습니다.</c:if></li>
				<li><strong class="next_list">이전글</strong><c:if test="${prenext.nextId ne null}"><a href="#none"  class="next_view" nextId="${prenext.nextId }"  nextOpenYn="${prenext.nextOpenYn }" >${prenext.nextTitle }</a></c:if><c:if test="${prenext.nextId eq null}">이전글이 없습니다.</c:if></li>
			</ul>
		</div>
		</c:if>
		 -->
		</div>
		<!--//E: 공지사항보기 -->
	</div>
</div>


<script>
$(document).ready(function(){		//	웹 품질 진단 조치 - 2021.04.30
	var strTitleText = $("#txtTitle").text();
	$("#txtTitle").text(strTitleText + " 상세보기");
});
</script>