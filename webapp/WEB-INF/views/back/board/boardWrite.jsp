<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var insertBoardUrl = "<c:url value='/back/board/insertBoard.do'/>";
var updateBoardUrl = "<c:url value='/back/board/updateBoard.do'/>";
var deleteBoardUrl = "<c:url value='/back/board/deleteBoard.do'/>";
var listUrl = "<c:url value='/back/board/boardList.do'/>";
var boardItemSetUrl = "<c:url value='/back/board/boardItemSet.do'/>";
var boardViewSetUrl = "<c:url value='/back/board/boardViewSet.do'/>";

$(document).ready(function(){

	if($("#mode").val() == "E"){
		$("[id^=boardCd]").attr("disabled", true); //설정
	}else{
		$("#boardCd").attr("checked", true); //설정
		$("[name=detailYn]").eq(0).attr("checked", true); //설정
		$("[name=useYn]").eq(0).attr("checked", true); //설정
	}

});

// 게시판 생성
function boardInsert(){
	var url = "";
	var writeMemCds = "";
	var readMemCds = "";

	if ( $("#writeFrm").parsley().validate() ){
		url = insertBoardUrl;
		if($("#mode").val() == "E") url = updateBoardUrl;

		// 글쓰기, 답글쓰기 처리
		$("[id^=gwrite]:checked").each(function(){
			writeMemCds = writeMemCds + $(this).val() + ",";
		});
		$("[id^=gread]:checked").each(function(){
			readMemCds = readMemCds + $(this).val() + ",";
		});

		writeMemCds = writeMemCds.substring(0, writeMemCds.length-1);
		readMemCds = readMemCds.substring(0, readMemCds.length-1);

		$("#writeMemCd").val(writeMemCds);
		$("#readMemCd").val(readMemCds);
		// 글쓰기, 답글쓰기 처리 끝

		// 데이터를 등록 처리해준다.
		$("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					list();
				}
			},
			dataType: "json",
			url: url
		});
	}
}

// 게시판 삭제
function boardDelete(){
	var url = deleteBoardUrl;
	if(!confirm("게시판이 삭제됩니다. 정말 삭제하시겠습니까?")) return;

	// 데이터를 삭제 처리해준다.
	$("#writeFrm").ajaxSubmit({
		success: function(responseText, statusText){
			alert(responseText.message);
			if(responseText.success == "true"){
				list();
			}
		},
		dataType: "json",
		url: url
	});
}

// 목록
function list(){
    var f = document.writeFrm;
    //var defaulttype = $("#defaulttype").val();

    f.target = "_self";
    f.action = listUrl;//+"?defaulttype="+defaulttype;
    f.submit();
}

// 탭이동
function tabLink(tab){
	var f = document.writeFrm;
	var url = "";

	if(tab == "I"){	// 항목설정
		url = boardItemSetUrl;
	}else if(tab == "V"){ // 목록뷰설정
		url = boardViewSetUrl;
	}else{ // 기본정보
		// 현재페이지
	}

    f.target = "_self";
    f.action = url;
    f.submit();
}

</script>

<!--// content -->
<div id="content">
	<!-- title_and_info_area -->
	<div class="title_and_info_area">
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title">${MENU.menuNm}</h3>
		</div>
		<!--// main_title -->
		<jsp:include page="/WEB-INF/views/back/menu/menuDescInclude.jsp"/>
	</div>
	<!--// title_and_info_area -->

	<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
		<input type='hidden' id="writeMemCd" name='writeMemCd' value="" />
		<input type='hidden' id="readMemCd" name='readMemCd' value="" />
		<input type='hidden' id="mode" name='mode' value="${param.mode}" />
		<input type='hidden' id="boardId" name='boardId' value="${param.boardId}" />
		<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		<input type='hidden' id="defaulttype" name='defaulttype' value="${defaulttype}" />
		<input type='hidden' id="useYn" name='useYn' value="${boardinfo.useYn}" />
		<input type="hidden" name="detailYn"  value="${boardinfo.detailYn}" /><!-- detailYn항목 미사용으로 인한 input 히든태그 추가 -->

		<c:if test="${param.mode == 'E' }">
		<!-- area_tab -->
		<div class="tab_area">
			<ul class="tablist">
				<li class="on"><a href="#none"><span>기본정보</span></a></li>
				<c:if test="${defaulttype ne 'P' and defaulttype ne 'R' and defaulttype ne 'I'}">
				<c:if test="${boardinfo.boardCd ne 'L' and boardinfo.boardCd ne 'P' and boardinfo.boardCd ne 'R' and boardinfo.boardCd ne 'I' and boardinfo.boardCd ne 'Q' and boardinfo.boardCd ne 'W' and boardinfo.boardCd ne 'A'}">
				<li><a href="javascript:tabLink('I')"><span>사용항목설정</span></a></li>
				<li><a href="javascript:tabLink('V')"><span>표시항목설정</span></a></li>
				</c:if>
				</c:if>

			</ul>
		</div>
		<!--// area_tab -->
		</c:if>

		<!-- write_basic -->
		<div class="table_area">
			<table class="write">
				<caption>게시판 등록 화면</caption>
				<colgroup>
					<col style="width: 125px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<c:if test="${param.mode == 'E' }">
				<tr>
					<th scope="row">등록자</th>
					<td>
						${boardinfo.regUsernm }(${boardinfo.regMemId })
					</td>
				</tr>
				<tr>
					<th scope="row">등록일</th>
					<td>
						${boardinfo.regDt}
					</td>
				</tr>
				</c:if>

				<%-- <tr>
					<th scope="row">게시판코드 <span class="asterisk">*</span></th>
					<td>
						<c:if test="${param.mode == 'W' }">
							(등록시 자동생성)
						</c:if>
						<c:if test="${param.mode == 'E' }">
							${boardinfo.boardId }
						</c:if>
					</td>
				</tr> --%>
				<!-- <tr>
					<th scope="row">타입  <span class="asterisk">*</span></th>
					<td> -->
						<%-- <g:radio id="boardCd" name="boardCd" codeGroup="BOARD_TYPE" checked="30" cls="text-middle" curValue="${boardinfo.boardCd }"  /> --%>
						<%-- <input type="hidden" id="boardCd" name="boardCd" value="${boardinfo.boardCd }" /> --%>
					<!-- </td>
				</tr> -->
				<tr>
					<th scope="row">게시판명  <span class="asterisk">*</span></th>
					<td>
						<input class="form-control" type="text" id="title" name="title" value="${boardinfo.title}" placeholder="게시판명"  style="width:100%" data-parsley-required="true" data-parsley-maxlength="100" />
					</td>
				</tr>
				<tr>
					<th scope="row">설명</th>
					<td>
						<textarea class="form-control" id="contents" name="contents" placeholder="게시판설명" rows="3" style="width:100%" data-parsley-maxlength="1000" >${boardinfo.contents}</textarea>
					</td>
				</tr>
				<%-- <tr>
					<th scope="row">Detail 사용여부</th>
					<td>
						<input name="detailYn" type="radio" value="Y" <c:if test="${boardinfo.detailYn != 'N'}">checked="checked"</c:if> />
						<label for="use">사용</label>
						<input name="detailYn" type="radio" value="N" <c:if test="${boardinfo.detailYn == 'N'}">checked="checked"</c:if> class="marginl15" />
						<label for="not">미사용</label>
						<p class="color_point margint10">* “미사용”인 경우 사용모드(Frontend)는 제공되지 않으며, 첨부파일이 있는 경우 목록에서 다운로드 가능합니다.</p>
					</td>
				</tr> --%>
				<c:if test="${defaulttype eq 'P'}">
				<tr>
					<th scope="row">게시판 타입  <span class="asterisk">*</span></th>
					<td>
						<%-- <g:radio id="boardCd" name="boardCd" codeGroup="BOARD_TYPE" checked="30" cls="text-middle" curValue="${boardinfo.boardCd }"  /> --%>
						<input type="radio" id="boardCd1" name="boardCd" value="P" <c:if test="${boardinfo.boardCd eq 'P'}">checked="checked"</c:if> />상품홍보
						<label for="boardCd1" class="hidden">상품홍보</label>
						<input type="radio" id="boardCd3"  name="boardCd" value="I" <c:if test="${boardinfo.boardCd eq 'I'}">checked="checked"</c:if> />추천사이트
						<label for="boardCd3" class="hidden">추천사이트</label>
					</td>
				</tr>
				</c:if>
				<c:if test="${defaulttype ne 'P'}">
					<input type="hidden" id="boardCd" name="boardCd" value="${boardinfo.boardCd }" />
				</c:if>
				<tr>
					<th scope="row">읽기 권한사용여부</th>
					<td>
						<div class="table_area">
                            <table class="list fixed">
                                <%-- <caption>권한 리스트 화면</caption> --%>
                                <colgroup>
                                    <col style="width: 10%;">
                                    <col style="width: 15%;">
                                    <col style="width: 13%;">
                                    <col style="width: *;">
                                </colgroup>
                                <tbody>
                                <tr>
                                    <td  class="alignc">전체 <input type="radio" id="gread01" name="readMemCd[]" value="A"  <c:if test="${fn:indexOf(boardinfo.readMemCd, 'A') != -1 or boardinfo.readMemCd eq null}">checked="checked"</c:if>></td>
                                    <td  class="alignc">온라인회원 <input type="radio" id="gread01" name="readMemCd[]" value="G"  <c:if test="${fn:indexOf(boardinfo.readMemCd, 'G') != -1}">checked="checked"</c:if>></td>
                                    <td  class="alignc">실명인증 <input type="radio" id="gread01" name="readMemCd[]" value="N"  <c:if test="${fn:indexOf(boardinfo.readMemCd, 'N') != -1}">checked="checked"</c:if>></td>
                                    <td>“전체” 인 경우 비회원 읽기 권한이 부여됩니다.</td>
                                </tr>
                                </tbody>
							</table>
						</div>
					</td>
				</tr>
				<tr>

					<c:set var="sdafqa4atwsegf" value="${ true }"/>

					<th scope="row">쓰기 권한사용여부<c:if test="${a or sdafqa4atwsegf}"><span class="${sdafqa4atwsegf}"></span></c:if></th>
					<td>
						<div class="table_area">
                            <table class="list fixed">
                                <%-- <caption>권한 리스트 화면</caption> --%>
                                <colgroup>
                                    <col style="width: 10%;">
                                    <col style="width: 15%;">
                                    <col style="width: 13%;">
                                    <col style="width: *;">
                                </colgroup>
                                <tbody>
                                <tr>
                                    <td class="alignc">없음 <input type="radio" id="gwrite01" name="writeMemCd[]" value="A" <c:if test="${fn:indexOf(boardinfo.writeMemCd, 'A') != -1 or boardinfo.readMemCd eq null}">checked="checked"</c:if>></td>
                                    <td class="alignc">온라인회원 <input type="radio" id="gwrite01" name="writeMemCd[]" value="G" <c:if test="${fn:indexOf(boardinfo.writeMemCd, 'G') != -1}">checked="checked"</c:if>></td>
                                    <td class="alignc">실명인증 <input type="radio" id="gwrite01" name="writeMemCd[]" value="N" <c:if test="${fn:indexOf(boardinfo.writeMemCd, 'N') != -1}">checked="checked"</c:if>></td>
                                    <td>“체크” 인 경우 사용모드(Frontend)에 등록/수정/삭제 권한이 부여됩니다.</td>
                                </tr>
                                </tbody>
							</table>
						</div>
					</td>
				</tr>
				<%--
				<tr>
					<th scope="row">사용여부</th>
					<td>
						<input name="useYn" type="radio" value="Y" <c:if test="${boardinfo.useYn != 'N'}">checked="checked"</c:if> />
						<label for="use">사용</label>
						<input name="useYn" type="radio" value="N" <c:if test="${boardinfo.useYn == 'N'}">checked="checked"</c:if> class="marginl15" />
						<label for="not">미사용</label>
					</td>
				</tr>
				 --%>
				</tbody>
			</table>
		</div>
		<!--// write_basic -->

		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button onclick="boardInsert()" class="btn save" title="저장하기">
					<span>저장</span>
				</button>
				<c:if test="${param.mode == 'E' }">
				<button onclick="boardDelete()" class="btn cancel" title="삭제">
					<span>삭제</span>
				</button>
				</c:if>
				<a href="javascript:list()" class="btn list" title="목록 페이지로 이동">
					<span>목록</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->

	</form>
</div>