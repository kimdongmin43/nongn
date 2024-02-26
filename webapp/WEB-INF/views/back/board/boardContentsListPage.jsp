<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="today" value="<%=new java.util.Date()%>" />
<fmt:formatDate value="${today}" pattern="yyyy" var="todayYear"/>
<fmt:formatDate value="${today}" pattern="MM" var="todayMonth"/>
<fmt:formatDate value="${today}" pattern="dd" var="todayDay"/>

<script>
var boardCategoryListUrl = "<c:url value='/back/board/boardCategoryListPage.do'/>";
var selectBoardCategoryListUrl = "<c:url value='/back/board/boardCategoryList.do'/>";
var insertBoardCategoryUrl = "<c:url value='/back/board/insertBoardCategory.do'/>";
var updateBoardCategoryUrl = "<c:url value='/back/board/updateBoardCategory.do'/>";
var deleteBoardCategoryUrl = "<c:url value='/back/board/deleteBoardCategory.do'/>";
var selectBoardCategoryDetailUrl = "<c:url value='/back/board/selectBoardCategoryDetail.do'/>";
var boardContentsListPageUrl = "<c:url value='/back/board/boardContentsListPage.do'/>";
var boardContentsWriteUrl = "<c:url value='/back/board/boardContentsWrite.do'/>";
var boardContentsListUrl = "<c:url value='/back/board/boardContentsList.do'/>";
var boardContentsViewUrl = "<c:url value='/back/board/boardContentsView.do'/>";
var boardContentsListReorderUrl = "<c:url value='/back/board/boardContentsListReorder.do'/>";
var downloadExcelUrl = "<c:url value='/back/board/selectDownloadExcelBoardList.do'/>";

$(document).ready(function(){
	$("#board_list_div").html("");
	if($("#boardId").val() != ""){
		if("${param.miv_pageNo}" != null && $("#searchYn").val()=="Y" ){
			goPage("${param.miv_pageNo}");
		}else{
			searchYn();
		}
	}
	
	//$("#beginDate").val(${todayYear}+""+${todayMonth}+""+${todayDay});
	//$("#endDate").val(${todayYear}+""+${todayMonth}+""+${todayDay});

});

// 게시판 선택
function changeBoard(){
	var f = document.listFrm;

	$("#defaulttype").val("");

    f.target = "_self";
    f.action = boardContentsListPageUrl;
    f.submit();
}

// 게시물 등록
function contentsWrite(){
	var f = document.listFrm;

	$("#mode").val("W");
	//$("#contId").val("");

    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
}

// 게시물 등록 및 수정
function contentsEdit(contId){
	var f = document.listFrm;

	$("#mode").val("E");
	$("#contId").val(contId);

    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
}

//게시물 뷰
function contentsView(contId){
	var f = document.listFrm;

	$("#contId").val(contId);

    f.target = "_self";
    f.action = boardContentsViewUrl;
    f.submit();
}

// 게시판 리스트 불러오기
function boardLiat(boardId){
	$.ajax({
        url: boardContentsListUrl,
        dataType: "html",
        type: "post",
        data: jQuery("#listFrm").serialize(),
        success: function(data) {
        	$("#contentslist").html(data);
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}
//페이지 이동
function go_Page(page){
	$("#miv_pageNo").val(page);
	search();
}
// boardListPage에서 boardContentsListPage 진입 시 페이징 처리를 위한 임시 searchYn()함수 생성
function searchYn(){
	$("#searchYn").val("Y");
	search();
}

function search(){
	boardLiat($("#boardId").val());
}

//초기화
function formReset(){
	$("#reply_ststus").val("");
	$("#cateId").val("");
	$("#searchKey").val("T");
	$("#searchTxt").val("");
}

// 페이지 이동
function goPage(page){
	$("#miv_pageNo").val(page);
	search();
}

//원본/삭제글 선택
function changeDelyn(){
	var delYn = $("#searchdelyn").val();
	$("#searchYn").val("Y");
	$("#delYn").val(delYn);

	search();
}

// 상단공지순서관리
function boardContentsListReorder(boardId){

	var title = "";
	var url = "";

	title = "상단공지순서관리";

	$("#boardreorder_title").html(title);

    $.ajax({
        url: boardContentsListReorderUrl,
        dataType: "html",
        type: "post",
        data: {
        	boardId : boardId
		},
        success: function(data) {
        	$('#pop_boardreorder').html(data);
        	popupShowReorder();
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}
//상단공지순서관리 팝업 열기
function popupShowReorder(){
	$("#modal-boardreorder-list").modal('show');
}
//상단공지순서관리 팝업 닫기
function popupCloseReorder(){
	$("#modal-boardreorder-list").modal("hide");
}


// 카테고리관리 페이지
function boardCategoryList(boardId) {
	$('#contentsArea').html("");

    $.ajax({
        url: boardCategoryListUrl,
        dataType: "html",
        type: "post",
        data: {
  		   boardId : boardId
		},
        success: function(data) {
        	$('#contentsArea').html(data);
        	popupShow();
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });

}

// 카테고리관리 팝업 열기
function popupShow(){
	$("#modal-category-write").popup("show");
}

// 카테고리관리 팝업 닫기
function popupClose(){
	$("#modal-category-write").popup("hide");
}

// 카테고리 폼
function categoryFrm(arg){
	if(arg == "W"){
		// 초기화
		$("#cateId").val("");
		$("#cateNm").val("");
		$("#mode").val("W");

		$("#regTd").hide();
		$("#deleteA").hide();
		$("#categoryWriteDiv").show();
	}else{
		$("#regTd").show();
		$("#deleteA").show();
		$("#categoryWriteDiv").show();
	}
}

// 카테고리 등록
function categorySave(){
	var url = "";
	if ( $("#listFrm2").parsley().validate() ){
		url = insertBoardCategoryUrl;
		if($("#mode").val() == "E") url = updateBoardCategoryUrl;
			// 데이터를 등록 처리해준다.
			$("#listFrm2").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						category_search();
					}
				},
				dataType: "json",
				url: url
		    });
	   }
}

//카테고리 삭제
function categoryDelete(){
	var url = "";
	if ( $("#listFrm2").parsley().validate() ){
		url = deleteBoardCategoryUrl;
			// 데이터를 삭제 처리해준다.
			$("#listFrm2").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						category_search();
					}
				},
				dataType: "json",
				url: url
		    });
	   }
}

// 카테고리 리스트 검색
function category_search() {
	$("#category_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectBoardCategoryListUrl,
		page : 1,
		postData : {
			boardId : $("#boardId").val()
		},
		mtype : "POST"
	}).trigger("reloadGrid");
}

// 카테고리 상세링크
function jsCateNmLinkFormmater(cellvalue, options, rowObject) {
	var str = "<a href=\"javascript:categoryDetail('"+rowObject.cateId+"')\">"+rowObject.cateNm+"</a>";
	return str;
}

// 카테고리 상세내용
function categoryDetail(cateId){
	$("#cateId").val(cateId);
	$("#mode").val("E");

	$.ajax({
		url : selectBoardCategoryDetailUrl,
		cache : false,
		type: 'POST',
		dataType : 'json',
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		data : {
			boardId : $("#boardId").val(),
			cateId : cateId
		},
		success : function(result){
			// 상세내용 처리
			categoryDetailInfo(result.data);
		},
		error : function(err){
		}
	});
}

function categoryDetailInfo(data){
	var isData = (data != undefined);

	$("#cateNm1").val(data.cateNm); //카테고리명
	$("#regUsernm").html(isData ? data.regUsernm+"("+data.regUserId+")" : ''); //등록자
	$("#regDt").html(isData ? data.regDt : ''); //등록일
	$("#sort").val(isData ? data.sort : ''); //순서
	$("input[name='useYn']:radio:input[value='"+(isData ? data.useYn : 'Y')+"']").prop("checked", true); //사용여부

	categoryFrm('E');
}

function changePageSize(size){
	$("#miv_pageSize").val(size);
	$("#miv_pageNo").val(1);

	search();
}
/*
function excelDown(boardId){
	
	$.ajax({
        url: downloadExcelUrl,
        dataType: "html",
        type: "post",
        data: jQuery("#listFrm").serialize(),
        success: function(result) {
        	
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
		
}
*/

var jq=true;

function excelDown(){
	
	if($("#beginDate").val().length != 8){
		alert("검색시작일을 yyyyMMdd 형식으로 입력해주세요.");
		return;
	}
	if($("#endDate").val().length != 8){
		alert("검색종료일을 yyyyMMdd 형식으로 입력해주세요.");
		return;
	}
	
	if(jq){dn()};
	setTimeout("exportExcel('Chart2')",1000);
}
function dn(){
	 $('#event_list').jqGrid({
			datatype: 'json',
			url: downloadExcelUrl,
			mtype: 'POST',
			colModel: [
				{ label: '번호', index: '번호', name: '번호',  align : 'right', sortable:false},
				{ label: '제목', index: '제목', name: '제목',  align : 'left', sortable:false},
				{ label: '답변상태', index: '답변상태', name: '답변상태',  align : 'center', sortable:false},
				{ label: '작성일', index: '작성일', name: '작성일',  align : 'center', sortable:false},
				{ label: '공개여부', index: '공개여부', name: '공개여부', align : 'center', sortable:false},
				{ label: '질의내용', index: '질의내용', name: '질의내용',  align : 'left', sortable:false},
				{ label: '답변내용', index: '답변내용', name: '답변내용', align : 'left', sortable:false},
				{ label: '답변일자', index: '답변일자', name: '답변일자',  align : 'center', sortable:false}
			],
			postData :{
				cateId : $('#cateId').val(),
				beginDate : $("#beginDate").val(),
				endDate : $("#endDate").val(),
				reply_ststus : $("select[name='reply_ststus']").val()
			},

			viewrecords : true,
			height : "350px",
			gridview : true,
			autowidth : true,
			forceFit : false,
			rowNum:-1,
			shrinkToFit : true,
			cellEdit : false,
			cellsubmit : 'clientArray',
			beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
				savedRow = iRow;
				savedCol = iCol;
			},
			onSelectRow : function(rowid, status, e) {
				var ret = jQuery("#event_list").jqGrid('getRowData', rowid);
			},
			onSortCol : function(index, iCol, sortOrder) {
				 jqgridSortCol(index, iCol, sortOrder, "event_list");
			   return 'stop';
			},
			beforeProcessing: function (data) {
				$("#LISTOP").val(data.LISTOPVALUE);
				$("#miv_pageNo").val(data.page);
				$("#miv_pageSize").val(data.size);
				$("#totalCnt").val(data.records);
	        },
			//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
			loadComplete : function(data) {
				//showJqgridDataNon(data, "event_list",8);
				//jq=false;
				//exportExcel ('Chart1');
			}
		});
		//jq grid 끝

		jQuery("#event_list").jqGrid('navGrid', '#event_list_pager', {
				add : false,
				search : false,
				refresh : false,
				del : false,
				edit : false
			});
}

//excel로 출력
function exportExcel ( pFileName ) {
	 var pGridObj = $('#event_list');
     var mya = pGridObj.getDataIDs();
     var data = pGridObj.getRowData(mya[0]);
     var colNames=new Array();
     var ii=0;
     for (var d in data){ colNames[ii++] = d; }

     //컬럼 헤더 가져오기
     var columnHeader = pGridObj.jqGrid('getGridParam','colNames') + '';
     var arrHeader = columnHeader.split(',');
     var html = "";

     html+="<table border=1><tr>";
     for ( var y = 0; y < arrHeader.length; y++ ) {
          html = html + "<td><b>" + encodeURIComponent(arrHeader[y])  + "</b></td>";
     }
     html = html + "</tr>";
     //값 불러오기
     for(var i=0;i< mya.length;i++) {
          var datac= pGridObj.getRowData(mya[i]);
          html = html +"<tr>";
          for(var j=0; j< colNames.length;j++) html=html + '<td>' + encodeURIComponent(datac[colNames[j]])+"</td>";
          html = html+"</tr>";
     }
     html=html+"</table>";  // end of line at the end

     document.EXCEL_.csvBuffer.value = html;
     document.EXCEL_.fileName.value = encodeURIComponent(pFileName);
     document.EXCEL_.target='_blank';
     document.EXCEL_.submit();
}
</script>

<!--// content -->
<div id="content">
	<!-- title_and_info_area -->
	<div class="title_and_info_area">
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title" id="headTitle">
				<%-- <c:if test="${gubun eq 'M'}" >${MENU.menuNm}</c:if> --%>
				<%-- <c:if test="${gubun ne 'M'}" >${boardinfo.title}</c:if> --%>
				${boardinfo.title}
			</h3>
		</div>
		<!--// main_title -->
		<jsp:include page="/WEB-INF/views/back/menu/menuDescInclude.jsp"/>
	</div>
	<!--// title_and_info_area -->

	<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
		<input type='hidden' id="total_cnt" name='total_cnt' value="" />
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		<input type='hidden' id="mode" name='mode' value="W" />
		<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
		<input type='hidden' id="contId" name='contId' value="" />
		<input type='hidden' id="gubun" name='gubun' value="${gubun }" />
		<input type='hidden' id="defaulttype" name='defaulttype' value="${boardinfo.boardCd }" />
		<input type='hidden' id="delYn" name="delYn" value="N" />
		<input type='hidden' id="searchYn" name="searchYn" value="N" />
		<input type='hidden' id="siteCd" name="siteCd" value="B" />
		<input type='hidden' id="boardId" name='boardId' value="<c:if test='${not empty param.boardId}'>${param.boardId}</c:if><c:if test='${empty param.boardId}'>${defaultBoardId}</c:if>" />
	<!-- search_area -->
	<div class="search_area">
		<table class="search_box">
			<caption>게시물관리 검색</caption>
			<colgroup>
				<col style="width: 60px;" />
				<col style="width: *;" />
				<col style="width: 60px;" />
				<col style="width: *;" />
				<c:if test='${boardinfo.boardId eq "51"}'>
				<col style="width: 60px;" />
				<col style="width: *;" />
				</c:if>				
			</colgroup>
			<tbody>
			<%-- <c:if test="${gubun eq 'M' }" >
			<tr style="display: none;">
				<th>게시판</th>
				<td>${list }
                    <select class="in_wp200" id="boardId" name="boardId" onChange="changeBoard()">
						<c:forEach items="${boardList }" var="list">
							<option value="${list.boardId }"<c:if test="${list.boardId == param.boardId}">selected</c:if> >
								${list.boardId}/${list.title }/
								<c:choose>
									<c:when test="${list.boardCd eq 'N'}">목록형</c:when>
									<c:when test="${list.boardCd eq 'A'}">앨범형</c:when>
									<c:when test="${list.boardCd eq 'W'}">요약형</c:when>
									<c:when test="${list.boardCd eq 'Q'}">QnA형</c:when>
									<c:otherwise></c:otherwise>
								</c:choose>
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			</c:if>
			<c:if test="${gubun ne 'M' }" >
				<input type='hidden' id="boardId" name='boardId' value="${param.boardId }" />
			</c:if> --%>
			<c:if test="${!empty boardinfo}">
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'cate') != -1}">
				<tr>
					<th>분류</th>
					<td>
						<select class="in_wp200" id="cateId" name="cateId">
						<option value="">- 전체 -</option>
						<c:forEach items="${category}" var="list">
							<option value="${list.cateId}" >${list.cateNm}</option>
						</c:forEach>
						</select>
					</td>
				</tr>
				</c:if>
				<%-- <c:if test="${boardinfo.boardCd eq 'Q'}">
				<tr>
					<th>답변상태</th>
					<td>
						<select class="in_wp80" id="reply_ststus" name="reply_ststus" >
							<option value="">- 전체 -</option>
							<option value="S" <c:if test="${param.s_reply_ststus eq 'S' }" >selected</c:if> >답변완료</option>
							<option value="W" <c:if test="${param.s_reply_ststus eq 'W' }" >selected</c:if> >답변대기</option>
						</select>
					</td>
				</tr>
				</c:if> --%>
			<tr> 
				<%-- <th>검색어</th>
				<td>
					<select class="in_wp80" title="검색 값 구분 선택" id="searchKey" name="searchKey" >
						<option value="T" <c:if test="${param.s_searchKey eq 'T' }" >selected</c:if>>제목</option>
						<option value="C" <c:if test="${param.s_searchKey eq 'C' }" >selected</c:if>>내용</option>
						<option value="U" <c:if test="${param.s_searchKey eq 'U' }" >selected</c:if>>작성자</option>
					</select>
					<label for="input_text" class="hidden">검색어 입력</label>
					<input type="text" class="in_w50" id="searchTxt" name="searchTxt" value="${param.s_searchTxt}"   placeholder="검색어 입력">
				</td> --%>
				<th>검색어</th>
				<td>
					<select title="검색 값 구분 선택" id="searchKey" name="searchKey" >
						<option value="T" <c:if test="${param.s_searchKey eq 'T' }" >selected</c:if>>제목</option>
						<option value="C" <c:if test="${param.s_searchKey eq 'C' }" >selected</c:if>>내용</option>
						<option value="U" <c:if test="${param.s_searchKey eq 'U' }" >selected</c:if>>작성자</option>
					</select>
					<label for="input_text" class="hidden">검색어 입력</label>
					<input type="text" class="in_w50" id="searchTxt" name="searchTxt" value="${param.s_searchTxt}" onkeypress="if(event.keyCode==13){return false;}"  placeholder="검색어 입력">
				</td>
				<c:if test="${boardinfo.boardCd eq 'Q'}">
				<th scope="row">
					<label for="answer">답변상태</label>
				</th>
				<td>
					<select id="reply_ststus" name="reply_ststus"  title="답변상태 선택" >
						<option value="">- 전체 -</option>
						<option value="S" <c:if test="${param.reply_ststus eq 'S' }" >selected</c:if> >답변완료</option>
						<option value="W" <c:if test="${param.reply_ststus eq 'W' }" >selected</c:if> >답변대기</option>
					</select>
				</td>
				<c:if test='${boardinfo.boardId eq "51"}'>
				<th scope="row">
					<label for="etc0">구분</label>
				</th>
				<td>
					<select id="etc0" name="etc0"  title="구분 선택" >
						<option value="">- 전체 -</option><!-- Front 에서는 구분 값을 메뉴에 따라 다르게 계산하나, 여기서는 고정 값으로 설정 -->
						<option value="1" <c:if test="${param.etc0 eq '1' }" >selected</c:if> >농림수산식품모태펀드</option>
						<option value="2" <c:if test="${param.etc0 eq '2' }" >selected</c:if> >농식품전문 크라우드펀딩</option>
						<option value="3" <c:if test="${param.etc0 eq '3' }" >selected</c:if> >농업정책보험</option>
						<option value="4" <c:if test="${param.etc0 eq '4' }" >selected</c:if> >손해평가사</option>
						<option value="5" <c:if test="${param.etc0 eq '5' }" >selected</c:if> >농림수산정책자금 검사</option>
						<option value="6" <c:if test="${param.etc0 eq '6' }" >selected</c:if> >농특회계 융자금 관리</option>
						<option value="9" <c:if test="${param.etc0 eq '9' }" >selected</c:if> >기타</option>
					</select>
				</td>
				</c:if>
				</c:if>

			</tr>
		</c:if>
		</tbody>
		</table>
		<div class="search_area_btnarea">
			<a href="javascript:searchYn();" class="btn sch" title="조회">
				<span>조회</span>
			</a>
			<a href="javascript:formReset();" class="btn clear" title="초기화">
				<span>초기화</span>
			</a>
		</div>
	</div>
	<!--// search_area -->

	<!-- tabel_search_area -->
	<div class="table_search_area">
		<div class="float_right">
			<c:if test="${!empty boardinfo}">
			<select class="in_wp90" id="searchdelyn" name="searchdelyn" onchange="changeDelyn()">
				<option value="N">현재글보기</option>
				<option value="Y">삭제글보기</option>
			</select>
			</c:if>
		</div>
	</div>
	<!--// tabel_search_area -->

	<c:if test="${!empty boardinfo}">
	<%-- 게시판 유형별 리스트  --%>
	<!-- table 1dan list -->
	<div class="table_area" id="contents_list_div">
		<div id="contentslist"></div>
	</div>
	<%--// 게시판 유형별 리스트 --%>

	<!-- button_area -->

	<div class="button_area">
		<div class="float_right">
			<!-- noti -->
			<c:if test="${boardinfo.boardCd eq 'P' or boardinfo.boardCd eq 'R' or boardinfo.boardCd eq 'I'}">
			<a title="분류등록" class="btn basic" href="javascript:boardCategoryList(${param.boardId });"><span>분류등록</span></a>
			</c:if>
			<c:if test="${fn:indexOf(boardinfo.itemUse, 'noti_yn') != -1}">
			<a title="상단공지순서관리" class="btn basic" href="javascript:boardContentsListReorder(${param.boardId});"><span>상단공지순서관리</span></a>
			</c:if>
			<button onclick="contentsWrite()" class="btn save" title="등록하기">
				<span>등록</span>
			</button>
		</div>
	</div>
	<!--// button_area -->
	</c:if>
	</form>
<div class="button_area" align="right">
	<c:if test="${param.boardId eq '51'}">
		<div class="btn_area fl_right">
			<label>검색시작일</label>
			<input type="text" id="beginDate"  placeholder="yyyymmdd" pattern="yyyymmdd"/>
			<label>검색종료일</label>
			<input type="text" id="endDate"  placeholder="yyyymmdd" pattern="yyyymmdd"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<label>게시글 분류</label>
			<select class="in_wp180" id="cateId" name="cateId" >
				<option value="">- 전체 -</option>
				<option value="1">농림수산식품모태펀드</option>
				<option value="2">농식품전문 크라우드펀딩</option>
				<option value="3">농업정책보험</option>
				<option value="9">기타</option>
				<option value="4">손해평가사</option>
				<option value="5">농림수산정책자금 검사</option>
				<option value="6">농특회계 융자금 관리</option>
			</select>
            <a href="javascript:excelDown();" style="display:inline-block; padding:8px 40px; color:#fff; font-weight:600; border-radius:5px;  background:#07a7e3; background:#07a7e3 url('../images/btn/bg_icon_down.png') no-repeat 10% 8px;" title="엑셀 다운로드">엑셀 다운로드</a>
            <br>
            <br>
            <label>※ 조회된 데이터는 최신순으로 100건 한정되며, 데이터가 없는 경우 엑셀파일이 정상적으로 보이지 않습니다. <br>
                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 엑셀 다운 후 다른 조건의 엑셀을 받기 위해서는 화면 새로고침 후 실행하셔야 합니다.</label>
        </div>
	</c:if>
</div>
	
<div class="modal fade" id="modal-boardreorder-list" >
	<div class="modal-dialog modal-size-small">
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 id="boardreorder_title" class="pop_title">상단공지순서관리</h1>
			<a href="javascript:popupCloseReorder()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area" style="text-align:center">
			    <div  id="pop_boardreorder"  style="margin:10px;">
			    </div>
			</div>
		</article>
		</div>
		<!-- //container -->
	</div>
</div>
<div id="modal-category-write" style="width:600px;background-color:white;display:none">
	<div id="wrap">
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 class="pop_title">카테고리 관리</h1>
			<a href="javascript:popupClose()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area">
			    <div  id="contentsArea" >
			    </div>
			</div>
		</article>
		</div>
		<!-- //container -->
	</div>
 </div>

<div class="table_area" id="event_list_div" style="display: none;">
	<table id="event_list"></table>
	<div class="table_search_area" style="margin-top:10px;">
	</div>
</div>

<form id="EXCEL_" name="EXCEL_" action="/excel/down_excel.jsp"  method="post">
     <input type="hidden" name="csvBuffer" id="csvBuffer" value="">
     <input type="hidden" name="fileName" id="fileName" value="">
</form>