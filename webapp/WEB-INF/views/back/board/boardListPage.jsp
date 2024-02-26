<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var selectBoardListUrl = "<c:url value='/back/board/boardPageList.do'/>";
var boardCategoryListUrl = "<c:url value='/back/board/boardCategoryListPage.do'/>";
var selectBoardCategoryListUrl = "<c:url value='/back/board/boardCategoryList.do'/>";
var insertBoardCategoryUrl = "<c:url value='/back/board/insertBoardCategory.do'/>";
var updateBoardCategoryUrl = "<c:url value='/back/board/updateBoardCategory.do'/>";
var deleteBoardCategoryUrl = "<c:url value='/back/board/deleteBoardCategory.do'/>";
var selectBoardCategoryDetailUrl = "<c:url value='/back/board/selectBoardCategoryDetail.do'/>";
var boardContentsListPageUrl = "<c:url value='/back/board/boardContentsListPage.do'/>";

$(document).ready(function(){
	$('#modal-categoty-write').popup();

	$('#board_list').jqGrid({
		datatype: 'json',
		url: selectBoardListUrl,
		mtype: 'post',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', sortable:false, formatter:jsRownumFormmater},
			{ label: '게시판코드', index: 'boardId', name: 'boardId', align : 'center', sortable:false, width:60, hidden:true },
			{ label: '게시판명', index: 'title', name: 'title', align : 'left', sortable:false, width:200 , formatter:jsTitleLink01Formmater},
			//{ label: '타입', index: 'type_nm', name: 'type_nm', width: 60, align : 'center', sortable:false },
			<c:if test="${defaulttype ne 'P' and defaulttype ne 'R' and defaulttype ne 'I' }">{ label: '게시물수', index: 'writeCnt', name: 'writeCnt', align : 'center', sortable:false, width:60},</c:if>
			<c:if test="${defaulttype eq 'P' or defaulttype eq 'R' or defaulttype eq 'I' }">{ label: '게시물수', index: 'writeCntEtc', name: 'writeCntEtc', align : 'center', sortable:false, width:60},</c:if>
			//{ label: 'Detail<br>사용여부', index: 'detail_yn_nm', name: 'detail_yn_nm', align : 'center', sortable:false, width:60},
			//{ label: '사용여부', index: 'useYnNm', name: 'useYnNm', align : 'center', sortable:false, width:60},
			/* { label: '카테고리관리', index: 'category', name: 'category', width: 150, align : 'center', sortable:false, width:80, formatter:jsBtn01Formmater}, */
			{ label: '게시물관리', index: 'mgmnt', name: 'mgmnt', width: 150, align : 'center', sortable:false, width:80, formatter:jsBtn02Formmater }
		],
		postData :{
			defaulttype : $("#defaulttype").val(),
			searchtype : $("#searchtype").val(),
			searchKey : $("#searchKey").val(),
			searchTxt : $("#searchTxt").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#board_pager',
		viewrecords : true,
		sortname : "board_id",
		sortorder : "desc",
		height : "350px",
		viewrecords : true,
		gridview : true,
		autowidth : true,
		//ajaxGridOptions : {async:false},
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },
		loadComplete : function(data) {
			showJqgridDataNon(data, "board_list",9);
		}
	});
	//jq grid 끝

	// jQgrid Header Setting
	// 				관리
	// 카테고리관리 | 게시물관리
	// 20170623 주석처리
	$("#board_list").jqGrid('setGroupHeaders', {
		useColSpanStyle : true,
		groupHeaders : [
		                {startColumnName: 'category', numberOfColumns:2, titleText: '관리'}
		]

	});

	bindWindowJqGridResize("board_list", "board_list_div");
});

// 게시판등록
function boardWrite(){
	var f = document.listFrm;
	var defaulttype = $("#defaulttype").val();

    f.target = "_self";
    f.action = "/back/board/boardWrite.do?mode=W&defaulttype="+defaulttype;
    f.submit();
}

// 게시판 기본정보
function boardDetail(boaridid){
	var f = document.listFrm;

	$("#boardId").val(boaridid);

    f.target = "_self";
    f.action = "/back/board/boardWrite.do?mode=E";
    f.submit();
}

// 검색
function search() {
	$("#board_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectBoardListUrl,
		page : 1,
		//ajaxGridOptions : {async:false},
		postData : {
			defaulttype : $("#defaulttype").val(),
			searchtype : $("#searchtype").val(),
			searchKey : $("#searchKey").val(),
			searchTxt : $("#searchTxt").val()
		},
		mtype : "POST"
	}).trigger("reloadGrid");
}

// 초기화
function formReset(){
	$("#searchtype").val("");
	$("#searchKey").val("NM");
	$("#searchTxt").val("");
}

// 카테고리 관리
/* function jsBtn01Formmater(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.cate_yn == 'Y'){
 		str ="   <a class=\"btn look\" title=\"카테고리 관리\" href=\"javascript:boardCategoryList('"+rowObject.boardId+"')\"'>카테고리관리</a>  ";
	}
	return str;
} */

// 카테고리 관리 페이지
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

// 번호 정렬
function jsRownumFormmater(cellvalue, options, rowObject) {
	var str = $("#total_cnt").val() - (rowObject.rnum-1);
	return str;
}

// 게시판 상세정보
function jsTitleLink01Formmater(cellvalue, options, rowObject) {
	var str = "<a href=\"javascript:boardDetail('"+rowObject.boardId+"')\">"+rowObject.title+"</a>";
	return str;
}

//게시물 관리
function jsBtn02Formmater(cellvalue, options, rowObject) {
	var str = "";
 	str ="   <a class=\"btn look\" title=\"게시물 관리\" href=\"javascript:boardContentsListPage('"+rowObject.boardId+"')\"'>게시물관리</a>  ";
	return str;
}

// 게시물 관리 페이지 이동
function boardContentsListPage(boaridid){
	var f = document.listFrm;

	$("#boardId").val(boaridid);

    f.target = "_self";
    f.action = boardContentsListPageUrl;
    f.submit();
}

// 팝업 열기
function popupShow(){
	$("#modal-category-write").popup("show");
}

// 팝업 닫기
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

	<form id="listFrm" name="listFrm" method="post">
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="boardId" name='boardId' value="" />
	<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
	<input type='hidden' id="gubun" name='gubun' value="${param.gubun}" />
	<input type='hidden' id="defaulttype" name='defaulttype' value="${defaulttype}" />
	<!-- search_area -->
	<div class="search_area">
		<table class="search_box">
			<caption>코드구분검색</caption>
			<colgroup>
				<%-- <col style="width: 80px;" />
				<col style="width: 20%;" /> --%>
				<col style="width: 70px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<tr>
				<!-- <th>타입</th> -->
				<!-- <td>
                    <select id="searchtype" name="searchtype" class="form-control input-sm">
						<option value="">- 전체 -</option>
						<option value="N">목록형</option>
						<option value="A">앨범형</option>
						<option value="W">요약형</option>
						<option value="Q">QnA형</option>
					</select>
				</td> -->
				<th>검색구분</th>
				<td>
					<select id="searchKey" name="searchKey" class="form-control input-sm">
						<option value="NM">게시판명</option>
						<option value="CD">게시판코드</option>
					</select>
				<input type="text" class="form-control input-sm" id="searchTxt" name="searchTxt" value="${param.p_searchTxt}"  placeholder="입력">
				</td>
			</tr>
			</tbody>
		</table>
		<div class="search_area_btnarea">
			<a href="javascript:search();" class="btn sch" title="조회">
				<span>조회</span>
			</a>
			<a href="javascript:formReset();" class="btn clear" title="초기화">
				<span>초기화</span>
			</a>
		</div>
	</div>
	<!--// search_area -->
	</form>

	<!-- tabel_search_area -->
	<div class="table_search_area">
		<div class="float_right">
			<a href="javascript:boardWrite()" class="btn acti" title="등록">
				<span>등록</span>
			</a>
		</div>
	</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="board_list_div" >
	    <table id="board_list"></table>
        <div id="board_pager"></div>
	</div>
	<!--// table 1dan list -->

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
