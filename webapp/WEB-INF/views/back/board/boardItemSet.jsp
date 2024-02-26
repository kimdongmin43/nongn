<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%--
	1. 번호, 제목,  작성자(이름), 작성일(현재, 지정중 선택), IP, 추천수는 시스템 필수값 단 게시판유형이 QnA일경우 답변상태 출력여부, 답변상태, 답변내용, 답변일이 추가 필수값
	2. 고정공지 및 첨부파일은 1~5개 설정할 수 있다. 최대용량 (20Mb)
--%>
<style>
.usrView {display:none;}
</style>
<script>
var listUrl = "<c:url value='/back/board/boardList.do'/>";
var boardWriteUrl = "<c:url value='/back/board/boardWrite.do'/>";
var boardItemSetUrl = "<c:url value='/back/board/boardItemSet.do'/>";
var boardViewSetUrl = "<c:url value='/back/board/boardViewSet.do'/>";
var updateBoardItemSetUrl = "<c:url value='/back/board/updateBoardItemSet.do'/>";



//목록
function list(){
    var f = document.writeFrm;

    f.target = "_self";
    f.action = boardItemSetUrl;
    f.submit();
}

//탭이동
function tabLink(tab){
	var f = document.writeFrm;
	var url = "";

	if(tab == "I"){	// 항목설정
		// 현재페이지
	}else if(tab == "V"){ // 목록뷰설정
		url = boardViewSetUrl;
	}else{ // 기본정보
		url = boardWriteUrl;
	}

    f.target = "_self";
    f.action = url;
    f.submit();
}

function itemSave(){

	var url = "";
	var itemUses = "";
	var itemRequireds = "";
	var itemOuts ="";
	var itemUsrs = [];
	var jj = 0;

	if ( $("#writeFrm").parsley().validate() ){
		url = updateBoardItemSetUrl;

		$("[id^=itemUse]:checked").each(function(){
			itemUses = itemUses + $(this).val() + ",";
		});

		/* itemUse 체크된 항목중 itemUsr 체크여부에 따라 1,0으로 돌려준다 */
		$("[id^=itemUse]").each(function(index){
			if ($(this).prop("checked")){
				var usrNm = $(this).attr('id').replace('Use','Usr');
				if($("#"+usrNm).prop("checked")){
					itemUsrs[jj] = 1;
					jj++;
				}else{
					itemUsrs[jj] = 0;
					jj++;
				}
			}
		});
		intemUsrsJoin = itemUsrs.join();


		$("[id^=itemOuttxt]:input:enabled").each(function(){
			if ($(this).val()=="") {
				itemOuts +=" ";
			}
			itemOuts = itemOuts + $(this).val() + "|";
		});
		$("[id^=itemRequired]:checked").each(function(){
			itemRequireds = itemRequireds + $(this).val() + ",";
		});

		itemUses = itemUses.substring(0, itemUses.length-1);
		itemRequireds = itemRequireds.substring(0, itemRequireds.length-1);
		itemOuts = itemOuts.substring(0, itemOuts.length-1);

		$("#itemUse").val(itemUses);
		$("#itemRequired").val(itemRequireds);
		$("#itemOut").val(itemOuts);
		$("#itemUser").val(intemUsrsJoin);

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

// 체크박스 처리
function chkbox(idx){
	// 사용선택 해제시 필수체크도 해제
	if(!$("#itemUse"+idx).is(":checked")) {
		$("#itemRequired"+idx).prop('checked', false) ;
		$("#itemUsr"+idx).prop('checked', false) ;
		$("#itemOuttxt"+idx).prop('disabled', true) ;
	}else{
		if($("#itemOuttxt"+idx).val()=="상단공지"){
			$("#itemOuttxt"+idx).prop('disabled', false) ;
			$("#itemOuttxt"+idx).prop('readonly', true) ;
		}
		$("#itemOuttxt"+idx).prop('disabled', false) ;
		//$("#itemUsr"+idx).prop('checked', true) ;
	}
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

	<!-- area_tab -->
	<div class="tab_area">
		<ul class="tablist">
			<li><a href="javascript:tabLink('B')"><span>기본정보</span></a></li>
			<c:if test="${boardinfo.boardCd ne 'L' and boardinfo.boardCd ne 'P' and boardinfo.boardCd ne 'R' and boardinfo.boardCd ne 'I'}">
			<li class="on"><a href="#none"><span>사용항목설정</span></a></li>
			<li><a href="javascript:tabLink('V')"><span>표시항목설정</span></a></li>
			</c:if>
		</ul>
	</div>
	<!--// area_tab -->

	<!-- title_area -->
	<div class="title_area">
		<h4 class="title">게시판명 : <span class="color_pointr">${boardinfo.title}</span></h4>
	</div>
	<!--// title_area -->
	<!-- division20 -->
	<div class="division20">
		<p class="txt01">- 선택한 항목만 입력 가능하며, 필수체크 된 항목은 필수 입력 정보입니다.</p>
	</div>
	<!--// division20 -->

	<!-- title_area -->
	<div class="title_area">
		<h4 class="title">항목설정</h4>
	</div>
	<!--// title_area -->

	<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
		<input type='hidden' id="boardId" name='boardId' value="${param.boardId}" />
		<input type='hidden' id="defaulttype" name='defaulttype' value="${defaulttype}" />
		<input type='hidden' id="mode" name='mode' value="E" />
		<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
		<input type='hidden' id="itemUse" name='itemUse' value="" />
		<input type='hidden' id="itemRequired" name='itemRequired' value="" />
		<input type='hidden' id="itemOut" name='itemOut' value="" />
		<input type='hidden' id="itemUser" name='itemUser' value="" />

		<!-- table 1dan list -->
		<div class="table_area">

			<c:set var="array_item" value="${ fn:split(boardinfo.itemUse, ',') }" />
			<c:set var="array_view" value="${ fn:split(boardinfo.itemOut, '|') }" />
			<c:set var="array_user" value="${ fn:split(boardinfo.itemUser, ',') }" />

			<c:set var="result" value="" />
			<table class="list fixed">
				<caption>항목설정 화면</caption>
				<colgroup>
					<col style="width: 1%;"/>
					<col style="width: 10%;"/>
					<%-- <col style="width: 20%;" /> --%>
					<%-- <col style="width: 40%;" /> --%>
					<%-- <col style="width: 20%;" /> --%>
					<col style="width: 25%;" />
					<col style="width: 25%;" />
					<col style="width: 20%;" />
					<%-- <col style="width: 10%;" /> --%>
				</colgroup>
				<thead>
				<tr>
					<th class="first" scope="colgroup" colspan="2" rowspan="2">사용여부</th>
					<!-- <th scope="col" rowspan="2">항목코드</th> -->
					<th scope="col" rowspan="2">항목명</th>
					<th scope="col" rowspan="2">출력명</th>
					<th scope="col" rowspan="2">설정</th>
					<!-- <th class="last" scope="col" rowspan="2">필수체크</th> -->
				</tr>
				</thead>
				<tbody>

				<%-- 상단공지 --%>
				<%-- 상단공지는 목록형게시판에만 적용 --%>
				<c:if test="${boardinfo.boardCd eq 'N' }">
				<c:forEach var="i" items="${array_item}" varStatus="status">
					<c:if test="${i eq 'noti_yn'}">
						<c:set var="result" value="${status.index}" />
					</c:if>
				</c:forEach>
				<tr>
					<td class="first" colspan="2">
						<input type="checkbox" id="itemUse05" value="noti_yn" onclick="chkbox('05')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, 'noti_yn') != -1}">checked="checked"</c:if>
						/>
					</td>
					 <td class="usrView">
						<input type="checkbox" id="itemUsr05" value="1" onclick="chkbox('05')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<!-- <td>noti_yn</td> -->
					<td class="alignl">상단공지</td>
					<td>
						<%-- <input type="text" id="itemOuttxt05" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" > --%>
						<input type="text" id="itemOuttxt05" value="상단공지" <c:if test="${result >= '0'}">readonly=readonly</c:if><c:if test="${result < '0'}">disabled="disabled"</c:if>/>
						<c:set var="result" value="" />
					</td>

					<td>개수
						<select class="in_wp40" id="notiCnt" name="notiCnt">
							<option value="1" <c:if test="${boardinfo.notiCnt eq 1 }">selected</c:if>>1</option>
							<option value="2" <c:if test="${boardinfo.notiCnt eq 2 }">selected</c:if>>2</option>
							<option value="3" <c:if test="${boardinfo.notiCnt eq 3 }">selected</c:if>>3</option>
							<option value="4" <c:if test="${boardinfo.notiCnt eq 4 }">selected</c:if>>4</option>
							<option value="5" <c:if test="${boardinfo.notiCnt eq 5 }">selected</c:if>>5</option>
							<option value="6" <c:if test="${boardinfo.notiCnt eq 6 }">selected</c:if>>6</option>
							<option value="7" <c:if test="${boardinfo.notiCnt eq 7 }">selected</c:if>>7</option>
							<option value="8" <c:if test="${boardinfo.notiCnt eq 8 }">selected</c:if>>8</option>
							<option value="9" <c:if test="${boardinfo.notiCnt eq 9 }">selected</c:if>>9</option>
							<option value="10" <c:if test="${boardinfo.notiCnt eq 10 }">selected</c:if>>10</option>
						</select>
					</td>
					<%-- <td class="last">
						<input type="checkbox" id="itemRequired05" value="noti_yn" onclick="if(!$('#itemUse05').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'noti_yn') != -1}">checked="checked"</c:if>
						/>
					</td> --%>
				</tr>
				</c:if>

				<%-- 번호 --%>
				<tr style='background:#e9e9e9'>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'number'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first" colspan="2"><input type="checkbox" id="itemUse01" onclick="return false;" value="number" checked /></td>
					<td class ="usrView">
						<input type="checkbox" id="itemUsr01" value="1" onclick="chkbox('01')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<!-- <td>number</td> -->
					<td class="alignl">번호</td>
					<td>
						<%-- <input type="text" id="itemOuttxt01" value="<c:if test="${result >= '0'}"> ${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >--%>
						<input type="text" id="itemOuttxt01" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<td></td>
					<!-- <td class="last"><input type="checkbox" id="itemRequired01" onclick="return false;" value="number" checked />	</td> -->
				</tr>

				<%-- 카테고리 --%>
				<%-- <tr>
					<td class="first">
						<input type="checkbox"  id="itemUse02" value="cate" onclick="chkbox('02')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, 'cate') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td>cate</td>
					<td class="alignl">카테고리</td>
					<td>
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'cate'}">
								<c:set var="result" value="${status.index}" />
							</c:if>
						</c:forEach>
						<input type="text" id="itemOuttxt02" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<td class="last">
						<input type="checkbox" id="itemRequired02" value="cate" onclick="if(!$('#itemUse02').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'cate') != -1}">checked="checked"</c:if>
						/>
					</td>
				</tr> --%>

				<%-- 제목 --%>
				<tr style='background:#e9e9e9'>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'title'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first" colspan="2"><input type="checkbox"  id="itemUse03" onclick="return false;" value="title" checked /></td>
					<td class="usrView">
						<input type="checkbox" id="itemUsr03" value="1" onclick="chkbox('03')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<!-- <td>title</td> -->
					<td class="alignl">제목</td>
					<td>
						<input type="text" id="itemOuttxt03" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<td></td>
					<!-- <td class="last"><input type="checkbox" id="itemRequired03" onclick="return false;" value="title" checked /></td> -->
				</tr>

				<%-- 제목링크 --%>
				<%-- 제목링크는 링크형게시판에만 적용 --%>
				<c:if test="${boardinfo.boardCd eq 'L' }">
				<tr>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'link'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first" colspan="2">
						<input type="checkbox" id="itemUse04" value="link" onclick="chkbox('04')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, 'link') != -1}">checked="checked"</c:if>
						/>
					</td>
					 <!-- <td class="first"><input type="checkbox" id="itemUsr04" onclick="return false;" value="1" checked /></td>  -->-
					<!-- <td>link</td> -->
					<td class="alignl">제목링크</td>
					<td>
						<input type="text" id="itemOuttxt04" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<%-- <td class="last">
						<input type="checkbox" id="itemRequired04" value="link" onclick="if(!$('#itemUse04').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'link') != -1}">checked="checked"</c:if>
						/>
					</td> --%>
				</tr>
				</c:if>

				<%-- 비밀글 --%>
				<%-- <tr>
					<td class="first">
						<input type="checkbox" id="itemUse06" value="open_yn" onclick="chkbox('06')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, 'open_yn') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td>open_yn</td>
					<td class="alignl">비밀글</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="itemRequired06" value="open_yn" onclick="if(!$('#itemUse06').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'open_yn') != -1}">checked="checked"</c:if>
						/>
					</td>
				</tr> --%>

				<%--URL --%>
				<%-- <tr>
				<c:if test="${boardinfo.boardCd eq 'L' }">
					<td class="first">
						<input type="checkbox" id="itemUse07" value="url" onclick="chkbox('07')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, 'url') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td>url</td>
					<td class="alignl">URL</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="itemRequired07" value="url" onclick="if(!$('#itemUse07').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'url') != -1}">checked="checked"</c:if>
						/>
					</td>
				</c:if>
				</tr> --%>

				<%--출처 --%>
				<%-- <tr>
					<td class="first">
						<input type="checkbox" id="itemUse08" value="source" onclick="chkbox('08')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, 'source') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td>source</td>
					<td class="alignl">출처</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="itemRequired08" value="source" onclick="if(!$('#itemUse08').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'source') != -1}">checked="checked"</c:if>
						/>
					</td>
				</tr> --%>

				<%-- 작성자 --%>
				<tr>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'reg_mem_nm'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first" colspan="2">
						<input type="checkbox" id="itemUse16" name="use_name" value="reg_mem_nm" onclick="chkbox('16')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, 'reg_mem_nm') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td class="usrView">
						<input type="checkbox" id="itemUsr16" value="1" onclick="chkbox('16')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<!-- <td>name</td> -->
					<td class="alignl">작성자(이름)</td>
					<td>
						<input type="text" id="itemOuttxt16" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<td></td>
					<%-- <td class="last">
						<!-- <input type="checkbox" id="itemRequired16" onclick="return false;" value="reg_mem_nm" checked /> -->
						<input type="radio" id="itemRequired16" name="req_name" value="reg_mem_nm" onclick="if(!$('#itemUse16').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'reg_mem_nm') != -1}">checked="checked"</c:if>
						/>
					</td> --%>
				</tr>

				<%--내용 --%>
				<!-- <tr style='background:#e9e9e9'> -->
				<tr>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'contents'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first" colspan="2">
						<!-- <input type="checkbox" id="itemUse09" value="contents" onclick="return false;" checked /> -->
						<input type="checkbox" id="itemUse09" value="contents" onclick="chkbox('09')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, 'contents') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td class="usrView">
						<input type="checkbox" id="itemUsr09" value="1" onclick="chkbox('09')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<!-- <td>contents</td> -->
					<td class="alignl">내용</td>
					<td>
						<input type="text" id="itemOuttxt09" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<td></td>
					<%-- <td class="last">
						<input type="checkbox" id="itemRequired09" value="contents" onclick="if(!$('#itemUse09').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'contents') != -1}">checked="checked"</c:if>
						/>
					</td> --%>
				</tr>

				<%-- 등록기관 --%>
				<tr>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'organization'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first" colspan="2">
						<input type="checkbox" id="itemUse26" name="use_name" value="organization" onclick="chkbox('26')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, 'organization') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td class="usrView">
						<input type="checkbox" id="itemUsr26" value="1" onclick="chkbox('26')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<!-- <td>organization</td> -->
					<td class="alignl">등록기관</td>
					<td>
						<input type="text" id="itemOuttxt26" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<td></td>
					<%-- <td class="last">
						<input type="radio" id="itemRequired26" name="req_name" value="organization" onclick="if(!$('#itemUse26').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'organization') != -1}">checked="checked"</c:if>
						/>
					</td> --%>
				</tr>


				<%-- 작성일 --%>
				<tr style='background:#e9e9e9'>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'reg_dt'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first" colspan="2"><input type="checkbox" id="itemUse18" onclick="return false;" value="reg_dt" checked /></td>
					<td class="usrView">
						<input type="checkbox" id="itemUsr18" value="1" onclick="chkbox('18')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<!-- <td>reg_dt</td> -->
					<td class="alignl">작성일(현재, 지정중 선택)</td>
					<td>
						<input type="text" id="itemOuttxt18" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<td></td>
					<!-- <td class="last"><input type="checkbox" id="itemRequired18" onclick="return false;" value="reg_dt" checked /></td> -->
				</tr>

				<%-- 조회수 --%>
				<tr>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'hit'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first" colspan="2">
						<input type="checkbox" id="itemUse25" value="hit" onclick="chkbox('25')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, 'hit') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td class="usrView">
						<input type="checkbox" id="itemUsr25" value="1" onclick="chkbox('25')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<!-- <td>hit</td> -->
					<td class="alignl">조회수</td>
					<td>
						<input type="text" id="itemOuttxt25" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<td></td>
					<%-- <td class="last">
						<input type="checkbox" id="itemRequired25" value="hit" onclick="if(!$('#itemUse25').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'hit') != -1}">checked="checked"</c:if>
						/>
					</td> --%>
				</tr>

				<%--첨부파일 --%>
				<tr>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'attach'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first" colspan="2">
						<input type="checkbox" id="itemUse15" value="attach" onclick="chkbox('15')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, 'attach') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td class="usrView">
						<input type="checkbox" id="itemUsr15" value="1" onclick="chkbox('15')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<!-- <td>attach</td> -->
					<td class="alignl">첨부파일</td>
					<td>
						<input type="text" id="itemOuttxt15" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<td>개수
						<select class="in_wp40" id="fileCnt" name="fileCnt">
							<option value="1" <c:if test="${boardinfo.fileCnt eq 1 }">selected</c:if>>1</option>
							<option value="2" <c:if test="${boardinfo.fileCnt eq 2 }">selected</c:if>>2</option>
							<option value="3" <c:if test="${boardinfo.fileCnt eq 3 }">selected</c:if>>3</option>
							<option value="4" <c:if test="${boardinfo.fileCnt eq 4 }">selected</c:if>>4</option>
							<option value="5" <c:if test="${boardinfo.fileCnt eq 5 }">selected</c:if>>5</option>
						</select>
					</td>
					<%-- <td class="last">
						<input type="checkbox" id="itemRequired15" value="attach" onclick="if(!$('#itemUse15').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'attach') != -1}">checked="checked"</c:if>
						/>
					</td> --%>
				</tr>

				<c:if test="${boardinfo.boardCd eq 'Q' }">
				<%--답변상태 사용여부 --%>
				<tr <c:if test="${boardinfo.boardCd eq 'Q' }">style='background:#e9e9e9'</c:if>>
					<td class="first" colspan="2">
						<input type="checkbox" id="itemUse10" value="reply_yn"
							<c:choose>
						    	<c:when test="${boardinfo.boardCd eq 'Q' }">onclick="return false;" checked="checked"</c:when>
						    	<c:otherwise>
						    		<c:if test="${fn:indexOf(boardinfo.itemUse, 'reply_yn') != -1}">onclick="chkbox('10')"  checked="checked"</c:if>
						    	</c:otherwise>
						    </c:choose>
						/>
					</td>
					<!-- <td>
						<input type="checkbox" id="itemUsr10" value="1" onclick="return false;" checked="checked" />
					</td> -->
					<!-- <td>reply_yn</td> -->
					<td class="alignl">답변상태 사용여부</td>
					<td></td>
					<td>
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'reply_yn'}">
								<c:set var="result" value="${status.index}" />
							</c:if>
						</c:forEach>
						<input type="hidden" id="itemOuttxt10" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<%-- <td class="last">
						<input type="checkbox" id="itemRequired10" value="reply_yn" onclick="if(!$('#itemUse10').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'reply_yn') != -1}">checked="checked"</c:if>
						/>
					</td> --%>
				</tr>

				<%--답변상태 --%>
				<tr <c:if test="${boardinfo.boardCd eq 'Q' }">style='background:#e9e9e9'</c:if>>
					<td class="first" colspan="2">
						<input type="checkbox" id="itemUse11" value="reply_status"
							<c:choose>
						    	<c:when test="${boardinfo.boardCd eq 'Q' }">onclick="return false;" checked="checked"</c:when>
						    	<c:otherwise>
						    		<c:if test="${fn:indexOf(boardinfo.itemUse, 'reply_status') != -1}">onclick="chkbox('11')" checked="checked"</c:if>
						    	</c:otherwise>
						    </c:choose>
						 />
					</td>
					<!-- <td>
						<input type="checkbox" id="itemUsr11" value="1" onclick="return false;" checked="checked" />
					</td> -->
					<!-- <td>reply_status</td> -->
					<td class="alignl">답변상태(답변을 사용한 게시판에서 자동출력)</td>
					<td>
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'reply_status'}">
								<c:set var="result" value="${status.index}" />
							</c:if>
						</c:forEach>
						<input type="hidden" id="itemOuttxt11" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<td></td>
					<%-- <td class="last">
						<input type="checkbox" id="itemRequired11" value="reply_status" onclick="if(!$('#itemUse11').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'reply_status') != -1}">checked="checked"</c:if>
						/>
					</td> --%>
				</tr>

				<%--답변내용 --%>
				<tr <c:if test="${boardinfo.boardCd eq 'Q' }">style='background:#e9e9e9'</c:if>>
					<td class="first" colspan="2">
						<input type="checkbox" id="itemUse12" value="reply_content"
							<c:choose>
						    	<c:when test="${boardinfo.boardCd eq 'Q' }">onclick="return false;" checked="checked"</c:when>
						    	<c:otherwise>
						    		<c:if test="${fn:indexOf(boardinfo.itemUse, 'reply_content') != -1}">onclick="chkbox('12')" checked="checked"</c:if>
						    	</c:otherwise>
						    </c:choose>
						 />
					</td>
					<!-- <td>
						<input type="checkbox" id="itemUsr12" value="1" onclick="return false;" checked="checked" />
					</td> -->
					<!-- <td>reply_content</td> -->
					<td class="alignl">답변내용</td>
					<td>
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'reply_content'}">
								<c:set var="result" value="${status.index}" />
							</c:if>
						</c:forEach>
						<input type="text" id="itemOuttxt12" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<td></td>
					<%-- <td class="last">
						<input type="checkbox" id="itemRequired12" value="reply_content" onclick="if(!$('#itemUse12').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'reply_content') != -1}">checked="checked"</c:if>
						/>
					</td> --%>
				</tr>

				<%--답변일 --%>
				<tr <c:if test="${boardinfo.boardCd eq 'Q' }">style='background:#e9e9e9'</c:if>>
					<td class="first" colspan="2">
						<input type="checkbox" id="itemUse13" value="reply_date"
							<c:choose>
						    	<c:when test="${boardinfo.boardCd eq 'Q' }">onclick="return false;" checked="checked"</c:when>
						    	<c:otherwise>
						    		<c:if test="${fn:indexOf(boardinfo.itemUse, 'reply_date') != -1}">onclick="chkbox('13')" checked="checked"</c:if>
						    	</c:otherwise>
						    </c:choose>
						/>
					</td>
					<!-- <td>
						<input type="checkbox" id="itemUsr13" value="1" onclick="return false;" checked="checked" />
					</td> -->
					<!-- <td>reply_date</td> -->
					<td class="alignl">답변일</td>
					<td>
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'reply_date'}">
								<c:set var="result" value="${status.index}" />
							</c:if>
						</c:forEach>
						<input type="text" id="itemOuttxt13" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<td></td>
					<%-- <td class="last">
						<input type="checkbox" id="itemRequired13" value="reply_date" onclick="if(!$('#itemUse13').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'reply_date') != -1}">checked="checked"</c:if>
						/>
					</td> --%>
				</tr>
				</c:if>

				<%-- 아이피 --%>
				<!-- <tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox" id="itemUse19" onclick="return false;" value="reg_ip" checked /></td>
					<td>reg_ip</td>
					<td class="alignl">IP</td>
					<td></td>
					<td class="last"><input type="checkbox" id="itemRequired19" onclick="return false;" value="reg_ip" checked /></td>
				</tr> -->

				<%-- 추천 --%>
				<%-- <tr>
					<td class="first">
						<input type="checkbox" id="itemUse20" value="recommend" onclick="chkbox('20')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, 'recommend') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td>recommend</td>
					<td class="alignl">추천</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="itemRequired20" value="recommend" onclick="if(!$('#itemUse20').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'recommend') != -1}">checked="checked"</c:if>
						/>
					</td>
				</tr> --%>

				<%-- 댓글 --%>
				<%-- <tr>
					<td class="first">
						<input type="checkbox" id="itemUse22" value="comment" onclick="chkbox('22')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, 'comment') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td>comment</td>
					<td class="alignl">댓글</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="itemRequired22" value="comment" onclick="if(!$('#itemUse22').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'comment') != -1}">checked="checked"</c:if>
						/>
					</td>
				</tr> --%>

				<%-- ETC1~10 --%>
				<c:forEach var="j" begin="0" end="9" varStatus="jstatus">
				<c:set var="v_etc" value="etc${j}" />
				<tr>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq v_etc}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first" colspan="2">
						<input type="checkbox" id="itemUse${j+27}" value="${v_etc}" onclick="chkbox('${j+27}')"
							<c:if test="${fn:indexOf(boardinfo.itemUse, v_etc) != -1}">checked="checked"</c:if>
						/>
					</td>
					<td class="usrView">
						<input type="checkbox" id="itemUsr${j+27}" value="1" onclick="chkbox('${j+27}')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<%-- <td>etc${jstatus.index+1}</td> --%>
					<td class="alignl">추가항목 ${jstatus.index+1}</td>
					<td>
						<input type="text" id="itemOuttxt${j+27}" value="<c:if test="${result >= '0'}">${fn:trim(array_view[result])}</c:if>" <c:if test="${result < '0'}">disabled="disabled"</c:if> data-parsley-type="etc" >
						<c:set var="result" value="" />
					</td>
					<td></td>
					<%-- <td class="last">
						<input type="checkbox" id="itemRequired${j+27}" value="${v_etc}" onclick="if(!$('#itemUse${j+27}').is(':checked')) return false;"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, v_etc) != -1}">checked="checked"</c:if>
						/>
					</td> --%>
				</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<!--// table 1dan list -->

		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button onClick="itemSave()" class="btn save" title="저장하기">
					<span>저장</span>
				</button>
				<a href="javascript:list()" class="btn list" title="목록 페이지로 이동">
					<span>목록</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->

	</form>

</div>