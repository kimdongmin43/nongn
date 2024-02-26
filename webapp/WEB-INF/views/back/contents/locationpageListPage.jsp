<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var savedRow = null;
var savedCol = null;
var selectLocationpageUrl = "<c:url value='/back/contents/locationpagePageList.do'/>";
var locationpageWriteUrl =  "<c:url value='/back/contents/locationpageWrite.do'/>";

$(document).ready(function(){

	$('#locationpage_list').jqGrid({
		datatype: 'json',
		url: selectLocationpageUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', formatter:jsRownumFormmater},
			<c:if test = "${listSize gt 1}">{ label: '명칭', index: 'branchNm', name: 'branchNm', align : 'center', width:100},</c:if>
			{ label: '주소', index: 'addr2', name: 'addr2', align : 'left', width:200, formatter:jsTitleLinkFormmater},
			{ label: '연락처', index: 'tel', name: 'tel', width: 40, align : 'center', sortable:false },
		],

		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#locationpage_pager',
		viewrecords : true,
		sortname : "sort",
		sortorder : "asc",
		height : "350px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit : false,
		cellsubmit : 'clientArray',
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow;
			savedCol = iCol;
		},
		onSelectRow : function(rowid, status, e) {
			var ret = jQuery("#locationpage_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "locationpage_list");
		   return 'stop';
		},
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },
		//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
		loadComplete : function(data) {

			showJqgridDataNon(data, "locationpage_list",7);

		}
	});
	//jq grid 끝

	jQuery("#locationpage_list").jqGrid('navGrid', '#locationpage_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});

	bindWindowJqGridResize("locationpage_list", "locationpage_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {

	var str = $("#total_cnt").val()-(rowObject.rnum-1);

	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {

	var str = "<a href=\"javascript:locationpageEdit('"+rowObject.locId+"')\">"+rowObject.addr2+"</a>";

	return str;
}

function jsUseynLinkFormmater(cellvalue, options, rowObject) {

	var str = "사용";

	if(cellvalue == "N") str = "미사용";

	return str;
}

function search() {

	jQuery("#locationpage_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectLocationpageUrl,
		page : 1,
		postData : {
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val(),
			satis_yn : $("#p_satis_yn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");

}

function locationpageEdit(locId) {

	var url = null;
	url = "${listSize}" > 1?"<c:url value='/back/contents/locationpageEdit.do?gubun=B'/>":"<c:url value='/back/contents/locationpageEdit.do?gubun=N'/>";
	var f = document.listFrm;
	$("#locId").val(locId);
    f.action = url;
    f.submit();

}

function locationpageWrite() {

	var url = null;
	url = "${listSize}" >= 1?"<c:url value='/back/contents/locationpageWrite.do?gubun=B'/>":"<c:url value='/back/contents/locationpageWrite.do?gubun=N'/>";
	var f = document.listFrm;
    f.action = url;
    f.submit();

}

function formReset(){
	$("#p_searchtxt").val("");
	$("select[name=p_satis_yn] option[value='']").attr("selected",true);
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
	<form id="listFrm" name="listFrm" method="post">
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="locId" name='locId'/>
	<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />

	<!-- tabel_search_area -->
	<div class="table_search_area">
		<div class="float_right">

		<c:set var="listSize" value="${listSize}" />
			<c:choose>
			    <c:when test="${listSize  lt 1}">
					<a href="javascript:locationpageWrite()" class="btn acti" title="등록">
						<span>등록</span>
					</a>
			    </c:when>
			    <c:otherwise>
			        <a href="javascript:locationpageWrite()" class="btn acti" title="지부등록">
			        	<span>등록</span>
					</a>
			    </c:otherwise>
			</c:choose>
		</div>
	</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="locationpage_list_div" >
	    <table id="locationpage_list"></table>
        <div id="locationpage_pager"></div>
	</div>
	<!--// table 1dan list -->
	</form>
</div>
<!--// content -->

