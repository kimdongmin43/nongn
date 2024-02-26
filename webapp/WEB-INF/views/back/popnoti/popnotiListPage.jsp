<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var savedRow = null;
var savedCol = null;
var selectPopnotiUrl   = "<c:url value='/back/main/popnotiPageList.do'/>";

var popnotiWriteUrl    =  "<c:url value='/back/main/popnotiWrite.do'/>";
var popnotiallWriteUrl =  "<c:url value='/back/popnoti/popnotiallWrite.do'/>";

var insertPopnotiUrl   = "<c:url value='/back/main/insertPopnoti.do'/>";
var updatePopnotiUrl   = "<c:url value='/back/main/updatePopnoti.do'/>"
var deletePopnotiUrl   = "<c:url value='/back/main/deletePopnoti.do'/>";

$(document).ready(function(){
	$('#popnoti_list').jqGrid({
		datatype: 'json',
		url: selectPopnotiUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', formatter:jsRownumFormmater},
			{ label: '제목', index: 'title', name: 'title', align : 'left', width:200, formatter:jsTitleLinkFormmater},
			{ label: '사용여부', index: 'useYn', name: 'useYn', align : 'left', width:30, align : 'center', sortable:false },
		  //{ label: '첨부파일', index: 'attachId', name: 'attachId', width: 60, align : 'center', formatter:jsImageLinkFormmater},
		  //{ label: '등록자', index: 'regUserNm', name: 'regUserNm', width: 40, align : 'center', sortable:false },
		  //{ label: '등록일', index: 'regDt', name: 'regDt', width: 60, align : 'center', sortable:false },
			{ label: 'notiId', index: 'notiId', name: 'notiId', width: 80, align : 'center', hidden:true }
		],
		postData :{
			searchKey : $("#p_searchKey").val(),
			searchTxt : $("#p_searchTxt").val(),
			useYn : $("#p_useyn").val(),
			tabGbn : $("#tabGbn").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#popnoti_pager',
		viewrecords : true,
		sortname : "sort",
		sortorder : "desc",
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
			var ret = jQuery("#popnoti_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "popnoti_list");
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
			showJqgridDataNon(data, "popnoti_list",5);
		}
	});
	//jq grid 끝

	jQuery("#popnoti_list").jqGrid('navGrid', '#popnoti_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});

	bindWindowJqGridResize("popnoti_list", "popnoti_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {

	var str = $("#total_cnt").val()-(rowObject.rnum-1);

	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {

	var str = "<a href=\"javascript:popnotiWrite('"+rowObject.notiId+"')\">"+rowObject.title+"</a>";

	return str;
}

function jsImageLinkFormmater(cellvalue, options, rowObject) {
	var str = "";
	if(cellvalue != undefined) {
		//str = "<a class=\"btn btn-xs btn-info\" href=\"/commonfile/fileidDownLoad.do?attachId="+ cellvalue +"\" ><image src=\"/images/back/icon/icon_file.png\" /></a>";
		str = '<img src="/images/back/icon/icon_file.png" alt="첨부파일" />';
		if(cellvalue ==""){
			str = "";
		}
	}

	return str;
}

function search() {

	jQuery("#popnoti_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectPopnotiUrl,
		page : 1,
		postData : {
			searchKey : $("#p_searchKey").val(),
			searchTxt : $("#p_searchTxt").val(),
			useYn : $("#p_useyn").val(),
			tabGbn : $("#tabGbn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");

}

function popnotiWrite(popnoti) {

	
	var f = document.listFrm;
    var mode = "W";
    if(popnoti != "") mode = "E";

	$("#mode").val(mode);
	$("#notiId").val(popnoti);

    f.action = popnotiWriteUrl;
    f.submit();
}



function formReset(){
	$("#p_searchTxt").val("");
	//$("select[name=p_use_yn] option[value='']").attr("selected",true);

	$("#p_searchKey").val("NM");
}

function goTab(id, obj){
	//id = tabA / tabB
	//$("#tabGbn").val("A");
	
	if (id == "tabA"){
		$("#tabGbn").val("A");
	}else if (id == "tabB"){
		$("#tabGbn").val("B");
	}
	
	$(obj).parents(".tablist").find("li").removeClass("on");
	$(obj).parent().addClass("on");
	
	jQuery("#popnoti_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectPopnotiUrl,
		page : 1,
		postData : {
			searchKey : $("#p_searchKey").val(),
			searchTxt : $("#p_searchTxt").val(),
			useYn : $("#p_useyn").val(),
			tabGbn : $("#tabGbn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
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
	<input type='hidden' id="notiId" name='notiId' value="" />
	<input type='hidden' id="mode" name='mode' value="W" />
	<input type='hidden' id="tabGbn" name='tabGbn' value="A" />

		<!-- search_area -->




	<!-- tabel_search_area -->

		<div class="float_right">
		
			<%-- <c:if test="${USER.userCd eq '999'}">
			<a href="javascript:popnotiallWrite('')" class="btn acti" title="일괄등록">
				<span>일괄등록</span>
			</a>
			</c:if> --%>
			<a href="javascript:popnotiWrite('')" class="btn acti" title="등록">
				<span>등록</span>
			</a>
		</div>


	<!--// tabel_search_area -->

	<!--// title_and_info_area -->
    <!-- tab_area -->
	<div class="tab_area">
		<ul class="tablist">
			<li >
				<a href="mainListPage.do"  title="지역">
					<span>메인이미지</span>
				</a>
			</li>
			
			<li class="on">
				<a href="popnotiListPage.do"  title="팝업">
					<span>팝업</span>
				</a>
			</li>
			<%-- <c:if test="${USER.userCd eq '999'}">
			<li>
				<a href="#none" onclick="goTab('tabB',this);" title="일괄">
					<span>일괄</span>
				</a>
			</li>
			</c:if> --%>
		</ul>
	</div>
	</form>
	<!-- table 1dan list -->
	<div class="table_area" id="popnoti_list_div" >
	    <table id="popnoti_list"></table>
        <div id="popnoti_pager"></div>
	</div>
	<!--// table 1dan list -->

	</div>

</div>
<!--// content -->
