<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>


<script>
var listUrl = "<c:url value='/back/board/boardList.do'/>";
var boardWriteUrl = "<c:url value='/back/board/boardWrite.do'/>";
var boardItemSetUrl = "<c:url value='/back/board/boardItemSet.do'/>";
var boardViewSetUrl = "<c:url value='/back/board/boardViewSet.do'/>";
var updateBoardViewSetUrl = "<c:url value='/back/board/updateBoardViewSet.do'/>";

$(document).ready(function(){




	$(".onlynum").keyup( setNumberOnly );

	// 요약형, 앨범형은 disabled 처리
	if($("#boardCd").val() == "A" || $("#boardCd").val() == "W"){
		$(".onlyNum").attr("disabled", true);
	}
});

//목록
function list(){
    var f = document.writeFrm;

    f.target = "_self";
    f.action = boardViewSetUrl;
    f.submit();
}

//탭이동
function tabLink(tab){
	var f = document.writeFrm;
	var url = "";

	if(tab == "I"){	// 항목설정
		url = boardItemSetUrl;
	}else if(tab == "V"){ // 목록뷰설정
		// 현재페이지
	}else{ // 기본정보
		url = boardWriteUrl;
	}

    f.target = "_self";
    f.action = url;
    f.submit();
}

//체크박스 처리
function chkbox(idx){
	var boardCd = $("#boardCd").val();

	if(boardCd == "N" || boardCd == "Q"){
		// 출력선택 해제시 나머지 항목 Disabled 및 초기화
		if(!$("#viewPrint"+idx).is(":checked")) {
			$("#viewSize"+idx).val("");
			$("#viewSort"+idx).val("");
			$("#viewSize"+idx).attr("disabled", true);
			$("#viewSort"+idx).attr("disabled", true);
		}else{
			$("#viewSize"+idx).attr("disabled", false);
			$("#viewSort"+idx).attr("disabled", false);
		}
	}
}

function viewSave(){
	var url = "";
    var viewPrints = "";
    var viewSizes = "";
    var viewSorts = "";
    var totalSize = 0;
    var totalCnt = 0;
    var chkSize = true;
    var chkSort = true;
	var itemUses = "";
	var itemRequireds = "";
	var itemOuts ="";
	var itemUsrs = [];
	var jj = 0;

    var val = "";
    if ( $("#writeFrm").parsley().validate() ){
		url = updateBoardViewSetUrl;
	    $("[id^=viewPrint]:checked").each(function(){

	    	val = $(this).val();
	    	viewPrints = viewPrints + val + ",";

	    	// 제목링크, 비밀글, 답변상태, 댓글은 사이즈와 순서를 지정하지 않습니다.
	    	if(val != "open_yn" && val != "reply_status" && val != "link" && val != "comment"){
	    		size_val = $("[name=viewSize_"+val+"]").val();
		    	sort_val = $("[name=viewSort_"+val+"]").val();

		    	if(size_val == ""){
		    		chkSize = false;
		    		$("[name=viewSize_"+val+"]").focus();
		    	}

		    	if(sort_val == ""){
		    		chkSort = false;
		    		$("[name=viewSort_"+val+"]").focus();
		    	}

		    	viewSizes = viewSizes + size_val + ",";
				viewSorts = viewSorts +  sort_val + ",";
				totalSize = totalSize+parseInt(size_val);
		    	totalCnt++;
	    	}
		});

	    if($("#boardCd").val() == "N" || $("#boardCd").val() == "Q"){
		    if (!chkSize) {
	            alert('가로 크기를 입력해주세요');
	            return;
	        }

		    if (!chkSort) {
	            alert('순서를 입력해주세요');
	            return;
	        }

		    if (totalSize != 100) {
	            alert('가로 크기의 합이 100이 되어야 합니다.[현재:'+totalSize+']');
	            return;
	        }

		    if (totalCnt > 8) {
	            alert('목록 뷰는 8개까지 설정이 가능합니다.[현재:'+totalCnt+']');
	            return;
	        }
	    }

	 	// 비밀글, 답변상태는 사이즈와 순서를 지정하지 않습니다.
	    if($("#secret_chk").is(":checked")) viewPrints = viewPrints + "open_yn,";
	    if($("#reply_status_chk").is(":checked")) viewPrints = viewPrints + "reply_status,";
	    if($("#link_chk").is(":checked")) viewPrints = viewPrints + "link,";
	    if($("#comment_chk").is(":checked")) viewPrints = viewPrints + "comment,";

	    viewPrints = viewPrints.substring(0, viewPrints.length-1);
	    viewSizes = viewSizes.substring(0, viewSizes.length-1);
	    viewSorts = viewSorts.substring(0, viewSorts.length-1);

	    $("#viewPrint").val(viewPrints);

	    if($("#boardCd").val() == "N" || $("#boardCd").val() == "Q"){
	    	$("#viewSize").val(viewSizes);
	    	$("#viewSort").val(viewSorts);
	    }

	   /* itemUse 체크된 항목중 itemUsr 체크여부에 따라 1,0으로 돌려준다 */
		$("[id^=itemUsr]").each(function(index){

				//var usrNm = $(this).attr('id').replace('viewPrint','itemUsr');
				if($(this).prop("checked")){
					itemUsrs[jj] = 1;
					jj++;
				}else{
					itemUsrs[jj] = 0;
					jj++;
				}

		});
		intemUsrsJoin = itemUsrs.join();
		$("#itemUser").val(intemUsrsJoin);



	 	// 데이터를 등록 처리해준다.
		$("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
				//	list();
				}
			},
			dataType: "json",
			url: url
		});
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
			<li><a href="javascript:tabLink('I')"><span>사용항목설정</span></a></li>
			<li class="on"><a href="#none"><span>표시항목설정</span></a></li>
		</ul>
	</div>
	<!--// area_tab -->

	<!-- title_area -->
	<div class="title_area">
		<h4 class="title">게시판명 : <span class="color_pointr">${boardinfo.title}</span></h4>
	</div>
	<!--// title_area -->
	<!-- title_area -->
	<div class="title_area">
		<h4 class="title">Front 목록 뷰설정</h4>
	</div>
	<!--// title_area -->
	<!-- division20 -->
	<div class="division20">
		<p class="txt01">- 선택한 항목만 목록에 표시되며, 가로사이즈, 순서는 일반형, Q&A형 게시판 타입의 PC버전에서만 적용됩니다.<br/></p>
		<p class="txt01">- 최대 8개 항목만 출력 설정할 수 있습니다.<br/></p>
	</div>
	<!--// division20 -->

	<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
		<input type='hidden' id="boardId" name="boardId" value="${param.boardId}" />
		<input type='hidden' id="boardCd" name="boardCd" value="${boardinfo.boardCd}" />
		<input type='hidden' id="defaulttype" name='defaulttype' value="${defaulttype}" />
		<input type='hidden' id="mode" name="mode" value="E" />
		<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
		<input type='hidden' id="viewPrint" name="viewPrint" value="" />
		<input type='hidden' id="viewSize" name="viewSize" value="" />
		<input type='hidden' id="viewSort" name="viewSort" value="" />
		<input type='hidden' id="itemUser" name='itemUser' value="" />

		<!-- table 1dan list -->
		<div class="table_area">
			<table class="list fixed">
				<caption>항목설정 화면</caption>
				<colgroup>
					<col style="width: 5%;" />
					<%-- <col style="width: 15%;" /> --%>
					<col style="width: 5%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />

				</colgroup>
				<thead>
				 <tr>
					<th class="first" scope="col" colspan="2">출력선택</th>
					<!-- <th scope="col">항목코드</th> -->
					<th scope="col" rowspan="2">항목명</th>
					<th scope="col" rowspan="2">목록가로사이즈(%)</th>
					<th class="last" rowspan="2" scope="col">목록순서</th>
				</tr>
				<tr>
					<th>목록화면출력여부</th>
					<th>상세화면출력여부</th>
				</tr>
				<!-- <tr>
					<th class="first" scope="colgroup" colspan="2">사용선택</th>
					<th scope="col" rowspan="2">항목코드</th>
					<th scope="col" rowspan="2">항목명</th>
					<th scope="col" rowspan="2">출력명</th>
					<th scope="col" rowspan="2">설정</th>
					<th class="last" scope="col" rowspan="2">필수체크</th>
				</tr>
				<tr>
					<th scope="col" >관리자</th>
					<th scope="col" >사용자</th>
				</tr> -->
				</thead>
				<tbody>

				<c:set var="arr_num" value="0" />
				<c:set var="out_num" value="0" />
				<c:set var="arr_size" value="${fn:split(boardinfo.viewSize, ',') }" />
				<c:set var="arr_sort" value="${fn:split(boardinfo.viewSort, ',') }" />
				<c:set var="arr_out" value="${fn:split(boardinfo.itemOut, '|') }" />
				<c:set var="array_user" value="${ fn:split(boardinfo.itemUser, ',') }" />
				<c:set var="result" value="0" />
				<c:set var="array_item" value="${ fn:split(boardinfo.itemUse, ',') }" />
				<c:set var="array_view" value="${ fn:split(boardinfo.itemOut, '|') }" />
				<c:set var="array_user" value="${ fn:split(boardinfo.itemUser, ',') }" />

				<%-- 고정공지는 목록형게시판에만 적용 --%>
				<c:if test="${boardinfo.boardCd eq 'N'}">
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'noti_yn') != -1}">

				<tr style='background:#e9e9e9; display: none;'>

					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'noty_yn'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td>
						<input type="checkbox" id="itemUsr00" value="1" onclick="chkbox('00')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<td class="first"><input type="checkbox" id="noti_chk" value="noti_yn" onclick="return false;"/></td>
					<!-- <td>noti_yn</td> -->
					<td class="alignl">상단공지</td>
					<td><input type="text" class="in_w100 onlyNum" id="viewSize05" name="viewSize_noti" style="text-align:center;ime-mode:disabled"  maxlength="3" value=""  disabled />	</td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="viewSort05" name="viewSort_noti" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'noti_yn') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
					<c:if test="${fn:indexOf(boardinfo.itemUse, 'noti_yn') != -1}"><c:set var="out_num" value="${out_num+1 }" /></c:if>


				</c:if>

				<%-- 비밀글 --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'open_yn') != -1}">
				<tr>
					<td class="first"><input type="checkbox" id="secret_chk" value="open_yn" <c:if test="${fn:indexOf(boardinfo.viewPrint, 'open_yn') != -1}">checked</c:if> /></td>
					<!-- <td>open_yn</td> -->
					<td class="alignl">비밀글</td>
					<td><input type="text" class="in_w100 onlyNum" id="viewSize06" style="text-align:center;ime-mode:disabled"  maxlength="3" value="" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="viewSort06" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>
				<%-- 번호 --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'number') != -1}">
				<tr <c:if test="${boardinfo.boardCd eq 'A' }">style='background:#e9e9e9'</c:if>>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'number'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first">
						<input type="checkbox" id="viewPrint01" value="number"
							<c:choose>
						    	<c:when test="${boardinfo.boardCd eq 'A' }">onclick="return false;"</c:when>
						    	<c:otherwise>
						    		onclick="chkbox('01')"
						    		<c:if test="${fn:indexOf(boardinfo.viewPrint, 'number') != -1}">checked="checked"</c:if>
						    	</c:otherwise>
						    </c:choose>
						/>
					</td>
					<td>
						<input type="checkbox" id="itemUsr01" value="1" onclick="chkbox('01')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>

					<!-- <td>number</td> -->
					<td class="alignl">${arr_out[out_num]}<!-- 번호 --></td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize01" name="viewSize_number" style="text-align:center;ime-mode:disabled"  maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'number') != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'number') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort01" name="viewSort_number" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'number') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'number') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'number') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
					<c:if test="${fn:indexOf(boardinfo.itemUse, 'number') != -1}"><c:set var="out_num" value="${out_num+1 }" /></c:if>
				</c:if>

				<%-- 카테고리 --%>
				<%-- <c:if test="${fn:indexOf(boardinfo.itemUse, 'cate') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox"  id="viewPrint02" value="cate" onclick="chkbox('02')"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'cate') != -1}">checked</c:if>
						/>
					</td>


					<td>cate</td>
					<td class="alignl">${arr_out[out_num]}<!-- 카테고리 --></td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize02" name="viewSize_cate" style="text-align:center;ime-mode:disabled"  maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'cate') != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'cate') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort02" name="viewSort_cate" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'cate') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'cate') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'cate') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
					<c:if test="${fn:indexOf(boardinfo.itemUse, 'cate') != -1}"><c:set var="out_num" value="${out_num+1 }" /></c:if>
				</c:if> --%>

				<%-- 제목 --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'title') != -1}">
				<tr>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'title'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first">
						<input type="checkbox"  id="viewPrint03" value="title" onclick="return false;" checked="checked"
							<%-- <c:if test="${fn:indexOf(boardinfo.viewPrint, 'title') != -1}">checked</c:if> --%>
						/>(고정)
					</td>
					<!--  -->
					<td>
						<input type="checkbox" id="itemUsr03" value="1" onclick="return false;" checked="checked"
							<%-- <c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose> --%>
						/>(고정)
					</td>
					<!--  -->
					<!-- <td>title</td> -->
					<td class="alignl">${arr_out[out_num]}<!-- 제목 --></td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize03" name="viewSize_title" style="text-align:center;ime-mode:disabled"  maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'title') != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'title') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort03" name="viewSort_title" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'title') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'title') == -1}">disabled="disabled"</c:if>
						/>
					</td>

				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'title') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
					<c:if test="${fn:indexOf(boardinfo.itemUse, 'title') != -1}"><c:set var="out_num" value="${out_num+1 }" /></c:if>
				</c:if>

				<%-- 제목링크 --%>
				<%--
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'link') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="link_chk" value="link"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'link') != -1}">checked</c:if>
						/>
					</td>
					<td>link</td>
					<td class="alignl">제목링크</td>
					<td><input type="text" class="in_w100 onlyNum" id="viewSize04" name="viewSize_link" style="text-align:center;ime-mode:disabled"  maxlength="3" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="viewSort04" name="viewSort_link" style="text-align:center" maxlength="3" disabled /></td>
				</tr>
				</c:if>
 				--%>
				<%-- 작성자(이름) --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'reg_mem_nm') != -1}">
				<tr>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'reg_mem_nm'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first">
						<input type="checkbox" id="viewPrint16" value="reg_mem_nm" onclick="chkbox('16')"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_mem_nm') != -1}">checked</c:if>
						/>
					</td>
					<%-- <td class="first">
						<input type="checkbox" id="viewPrint16" value="reg_mem_nm" onclick="chkbox('16')"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_mem_nm') != -1}">checked</c:if>
						/>
					</td> --%>
					<!-- <td>reg_mem_nm</td> -->
					<td>
						<input type="checkbox" id="itemUsr16" value="1" onclick="return false;" checked="checked"
							<%-- <c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose> --%>
						/>(고정)
					</td>
					<td class="alignl">${arr_out[out_num]}<!-- 작성자(이름) --></td>

					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize16" name="viewSize_reg_mem_nm" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_mem_nm') != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_mem_nm') == -1}">disabled="disabled"</c:if>
						/>
					</td>

					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort16" name="viewSort_reg_mem_nm" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_mem_nm') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_mem_nm') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_mem_nm') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
					<c:if test="${fn:indexOf(boardinfo.itemUse, 'reg_mem_nm') != -1}"><c:set var="out_num" value="${out_num+1 }" /></c:if>
				</c:if>

				<%-- URL --%>
				<%--
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'url') != -1}">
				<tr <c:if test="${boardinfo.boardCd eq 'A' }">style='background:#e9e9e9'</c:if>>
				<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'url'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first">
						<input type="checkbox" id="viewPrint07" value="url"
							<c:choose>
						    	<c:when test="${boardinfo.boardCd eq 'A' }">onclick="return false;"</c:when>
						    	<c:otherwise>
						    		onclick="chkbox('07')"
						    		<c:if test="${fn:indexOf(boardinfo.viewPrint, 'url') != -1}">checked="checked"</c:if>
						    	</c:otherwise>
						    </c:choose>
						/>
					</td>
					<td>
						<input type="checkbox" id="itemUsr07" value="1" onclick="chkbox('07')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<td>url</td>
					<td class="alignl">URL</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize07" name="viewSize_url" style="text-align:center;ime-mode:disabled"  maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'url') != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'url') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort07" name="viewSort_url" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'url') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'url') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'url') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				 --%>
				<%-- 출처 --%>
				<%--
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'source') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="viewPrint08" value="source" onclick="chkbox('08')"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'source') != -1}">checked</c:if>
						/>
					</td>
					<td>source</td>
					<td class="alignl">출처</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize08" name="viewSize_source" style="text-align:center;ime-mode:disabled"  maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'source') != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'source') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort08" name="viewSort_source" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'source') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'source') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'source') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				 --%>
				<%-- 내용 --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'contents') != -1}">
				<tr <c:if test="${boardinfo.boardCd eq 'A' }">style='background:#e9e9e9'</c:if>>
				<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'contents'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first">
						<input type="checkbox" id="viewPrint09" value="contents"
							<c:choose>
						    	<c:when test="${boardinfo.boardCd eq 'A' }">onclick="return false;"</c:when>
						    	<c:otherwise>
						    		onclick="chkbox('09')"
						    		<c:if test="${fn:indexOf(boardinfo.viewPrint, 'contents') != -1}">checked="checked"</c:if>
						    	</c:otherwise>
						    </c:choose>
						/>
					</td>
					<td>
						<input type="checkbox" id="itemUsr09" value="1" onclick="return false;" checked="checked"
							<%-- <c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose> --%>
						/>(고정)
					</td>
					<!-- <td>contents</td> -->
					<td class="alignl">${arr_out[out_num]}<!-- 내용 --></td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize09" name="viewSize_contents" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'contents') != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'contents') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort09" name="viewSort_contents" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'contents') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'contents') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'contents') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
					<c:if test="${fn:indexOf(boardinfo.itemUse, 'contents') != -1}"><c:set var="out_num" value="${out_num+1 }" /></c:if>
				</c:if>

				<%-- 등록기관 --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'organization') != -1}">
				<tr>
				<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'organization'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first">
						<input type="checkbox" id="viewPrint26" value="organization" onclick="chkbox('26')"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'organization') != -1}">checked</c:if>
						/>
					</td>
					<td>
						<input type="checkbox" id="itemUsr26" value="1" onclick="chkbox('26')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<!-- <td>organization</td> -->
					<td class="alignl">${arr_out[out_num]}<!-- 등록기관 --></td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize26" name="viewSize_organization" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'organization') != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'organization') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort26" name="viewSort_organization" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'organization') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'organization') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'organization') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
					<c:if test="${fn:indexOf(boardinfo.itemUse, 'organization') != -1}"><c:set var="out_num" value="${out_num+1 }" /></c:if>
				</c:if>

				<%-- 작성일 --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'reg_dt') != -1}">
				<tr>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'reg_dt'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first">
						<input type="checkbox" id="viewPrint18" value="reg_dt" onclick="chkbox('18')"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_dt') != -1}">checked</c:if>
						/>
					</td>
					<td>
						<input type="checkbox" id="itemUsr18" value="1" onclick="return false;" checked="checked"
							<%-- <c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose> --%>
						/>(고정)
					</td>

					<!-- <td>reg_dt</td> -->
					<td class="alignl">${arr_out[out_num]}<!-- 작성일(현재, 지정중 선택) --></td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize18" name="viewSize_reg_dt"  style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_dt') != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_dt') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort18" name="viewSort_reg_dt" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_dt') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_dt') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_dt') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
					<c:if test="${fn:indexOf(boardinfo.itemUse, 'reg_dt') != -1}"><c:set var="out_num" value="${out_num+1 }" /></c:if>
				</c:if>

				<%-- 조회수 --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'hit') != -1}">
				<tr>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'hit'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first">
						<input type="checkbox" id="viewPrint25" value="hit" onclick="chkbox('25')"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'hit') != -1}">checked</c:if>
						/>
					</td>
					<td>
						<input type="checkbox" id="itemUsr25" value="1" onclick="chkbox('25')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<!-- <td>hit</td> -->
					<td class="alignl">${arr_out[out_num]}<!-- 조회수 --></td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize25" name="viewSize_hit" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'hit') != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'hit') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort25" name="viewSort_hit" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'hit') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'hit') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'hit') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
					<c:if test="${fn:indexOf(boardinfo.itemUse, 'hit') != -1}"><c:set var="out_num" value="${out_num+1 }" /></c:if>
				</c:if>
				<%-- 첨부파일 --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'attach') != -1}">
				<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq 'attach'}">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
				<tr>
					<td class="first">
						<input type="checkbox" id="viewPrint15" value="attach" onclick="chkbox('15')"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'attach') != -1}">checked</c:if>
						/>
					</td>
					<td>
						<input type="checkbox" id="itemUsr15" value="1" onclick="chkbox('15')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>
					<!-- <td>attach</td> -->
					<td class="alignl">${arr_out[out_num]}<!-- 첨부파일 --></td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize15" name="viewSize_attach" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'attach') != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'attach') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort15" name="viewSort_attach" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'attach') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'attach') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'attach') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
					<c:if test="${fn:indexOf(boardinfo.itemUse, 'attach') != -1}"><c:set var="out_num" value="${out_num+1 }" /></c:if>
				</c:if>

				<%-- 답변상태 사용여부 --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'reply_yn') != -1}">
				<tr style='background:#e9e9e9'>

					<td class="first"><input type="checkbox" id="viewPrint10" value="reply_yn" onclick="return false;" /></td>
					<!-- <td>reply_yn</td> -->
					<td class="alignl">답변상태 사용여부</td>
					<td><input type="text" class="in_w100 onlyNum" id="viewSize10" name="viewSize_reply_yn" style="text-align:center" maxlength="3" value="" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="viewSort10" name="viewSort_reply_yn" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>

				<%-- 답변상태 --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'reply_status') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="reply_status_chk" value="reply_status"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reply_status') != -1}">checked</c:if>
						/>
					</td>
					<!-- <td>reply_status</td> -->
					<td class="alignl">답변상태(답변을 사용한 게시판에서 자동출력)</td>
					<td><input type="text" class="in_w100 onlyNum" id="viewPrint11" style="text-align:center" maxlength="3" value="" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="viewSort11" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>

				<%-- 답변내용 --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'reply_content') != -1}">
				<tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox" id="viewPrint12" value="reply_content" onclick="return false;" /></td>
					<!-- <td>reply_content</td> -->
					<td class="alignl">답변내용</td>
					<td><input type="text" class="in_w100 onlyNum" id="viewSize12" name="viewSize_reply_content" style="text-align:center" maxlength="3" value="" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="viewSort12" name="viewSort_reply_content" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>

				<%-- 답변일 --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'reply_date') != -1}">
				<tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox" id="viewPrint13" value="reply_date" onclick="return false;" /></td>
					<!-- <td>reply_date</td> -->
					<td class="alignl">답변일</td>
					<td><input type="text" class="in_w100 onlyNum" id="viewSize13" name="viewSize_reply_date" style="text-align:center" maxlength="3" value="" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="viewSort13" name="viewSort_reply_date" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>

				<%-- 아이피 --%>
				<%-- <c:if test="${fn:indexOf(boardinfo.itemUse, 'reg_ip') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="viewPrint19" value="reg_ip" onclick="chkbox('19')"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_ip') != -1}">checked</c:if>
						/>
					</td>
					<td>reg_ip</td>
					<td class="alignl">IP</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize19" name="viewSize_reg_ip" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_ip') != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_ip') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort19" name="viewSort_reg_ip" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_ip') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_ip') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reg_ip') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
					<c:if test="${fn:indexOf(boardinfo.itemUse, 'reg_ip') != -1}"><c:set var="out_num" value="${out_num+1 }" /></c:if>
				</c:if> --%>

				<%-- 추천 --%>
				<%--
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'recommend') != -1}">
				<tr <c:if test="${boardinfo.boardCd eq 'A' }">style='background:#e9e9e9'</c:if>>
					<td class="first">
						<input type="checkbox" id="viewPrint20" value="recommend"
							<c:choose>
						    	<c:when test="${boardinfo.boardCd eq 'A' }">onclick="return false;"</c:when>
						    	<c:otherwise>
						    		<c:if test="${fn:indexOf(boardinfo.viewPrint, 'recommend') != -1}">onclick="chkbox('20')" checked="checked"</c:if>
						    	</c:otherwise>
						    </c:choose>
						/>
					</td>
					<td>recommend</td>
					<td class="alignl">추천</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize20" name="viewSize_recommend" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'recommend') != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'recommend') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort20" name="viewSort_recommend" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'recommend') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'recommend') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, 'recommend') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				 --%>

				<%-- 댓글 --%>
				<%-- <c:if test="${fn:indexOf(boardinfo.itemUse, 'comment') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="comment_chk" value="comment"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, 'comment') != -1}">checked</c:if>
						/>
					</td>
					<td>comment</td>
					<td class="alignl">댓글</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize22" style="text-align:center" maxlength="3" disabled />
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort22" style="text-align:center" maxlength="3" disabled />
					</td>
				</tr>
				</c:if> --%>

				<%-- ETC1~10 --%>
				<c:forEach var="j" begin="0" end="9" varStatus="jstatus">
				<c:set var="v_etc" value="etc${j}" />
				<c:if test="${fn:indexOf(boardinfo.itemUse, v_etc) != -1}">
				<tr>
					<c:forEach var="i" items="${array_item}" varStatus="status">
						<c:if test="${i eq v_etc }">
							<c:set var="result" value="${status.index}" />
						</c:if>
					</c:forEach>
					<td class="first">
						<input type="checkbox" id="viewPrint${j+27}" value="${v_etc}" onclick="chkbox('${j+27}')"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, v_etc) != -1}">checked</c:if>
						/>
					</td>
					<td>
						<input type="checkbox" id="itemUsr${j+27}" value="1" onclick="chkbox('${j+27}')"
							<c:choose>
						    	<c:when test="${result >= '0'}">
						    		<c:if test="${array_user[result] eq '1'}">checked="checked"</c:if>
						    	</c:when>
						    </c:choose>
						/>
					</td>

					<%-- <td>etc${jstatus.index+1}</td> --%>
					<td class="alignl">${arr_out[out_num]}</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="viewSize${j+27}" name="viewSize_${v_etc}" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, v_etc) != -1}">value="${arr_size[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, v_etc) == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="viewSort${j+27}" name="viewSort_${v_etc}" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.viewPrint, v_etc) != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.viewPrint, v_etc) == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.viewPrint, v_etc) != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
					<c:if test="${fn:indexOf(boardinfo.itemUse, v_etc) != -1}"><c:set var="out_num" value="${out_num+1 }" /></c:if>
				</c:if>
				</c:forEach>

				</tbody>
			</table>
		</div>
		<!--// table 1dan list -->

		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button onclick="viewSave()" class="btn save" title="저장하기">
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