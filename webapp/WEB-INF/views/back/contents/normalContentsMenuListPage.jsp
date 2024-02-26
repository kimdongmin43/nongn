<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var savedRow = null;
var savedCol = null;
var  selectNormalContentsMenuUrl = "<c:url value='/back/contents/NormalContentsMenuPageList.do'/>";
var intropageWriteUrl =  "<c:url value='/back/contents/intropageWrite.do'/>";

$(document).ready(function(){
	
	
	/* alert(JSON.stringify(intropage)); */
	
	
	$('#intropage_list').jqGrid({
		datatype: 'json',
		url: selectNormalContentsMenuUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', sortable: false},
			{ label: '콘텐츠코드', index: 'menuId', name: 'menuId', align : 'center', width:100 ,hidden:true},
			{ label: '콘텐츠명', index: 'menuNm', name: 'menuNm', align : 'left', width:200, formatter:jsTitleLinkFormmater},
			//{ label: '만족도사용여부', index: 'satis_yn', name: 'satis_yn', width: 120, align : 'center', formatter:jsUseynLinkFormmater},
			//{ label: '만족도점수', index: 'satis_score', name: 'satis_score', align : 'center', width:80}, 
			{ label: '등록자', index: 'regUserNm', name: 'regUserNm', width: 40, align : 'center', sortable:false }
			//{ label: '등록일', index: 'regdt', name: 'regdt', width: 60, align : 'center', sortable:false } 
		],
		postData :{	
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val(),
			satis_yn : $("#p_satis_yn").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#intropage_pager',
		viewrecords : true,		
		height : "100%",
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
			var ret = jQuery("#intropage_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "intropage_list");
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
			
			showJqgridDataNon(data, "intropage_list",7);

		}
	});
	//jq grid 끝 
	
	jQuery("#intropage_list").jqGrid('navGrid', '#intropage_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("intropage_list", "intropage_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:goSubMenu('"+rowObject.refUrl+"','"+rowObject.menuId+"','"+rowObject.targetCd+"','"+"////"+"')\">"+rowObject.menuNm+"</a>";
	/* var str = "<a href=\"javascript:goSubMenu('"+rowObject.refUrl+"','"+menuId+",'"+targetCd+"','"////')\">"+rowObject.menuNm+"</a>"; */
	
	return str;
}

function jsUseynLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "사용";
	
	if(cellvalue == "N") str = "미사용";
	
	return str;
}

function search() {		
	
	jQuery("#intropage_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectIntropageUrl,
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

function intropageWrite(contId) {
    var f = document.listFrm;
    var mode = "W";
    if(contId != "") mode = "E";
    
	$("#mode").val(mode);
	$("#contId").val(contId);
	
    f.action = intropageWriteUrl;
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
	<input type='hidden' id="contId" name='contId' value="" />
	<input type='hidden' id="mode" name='mode' value="W" />

	<!-- table 1dan list -->
	<div class="table_area" id="intropage_list_div" >
	    <table id="intropage_list"></table>
    
	</div>
	<!--// table 1dan list -->
<!--// content -->
		</form>
	</div>
