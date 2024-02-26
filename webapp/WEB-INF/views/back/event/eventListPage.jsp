<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>

var selecteventUrl = "<c:url value='/back/event/eventList.do'/>";
var eventWriteUrl =  "<c:url value='/back/event/eventWrite.do'/>";
var eventUrl =  "<c:url value='/back/event/eventPageList.do'/>";

$(document).ready(function(){
	
	
	/* alert(JSON.stringify(intropage)); */
	
	
	$('#intropage_list').jqGrid({
		datatype: 'json',
		url: selecteventUrl,
		mtype: 'POST',
		colModel: [
			//{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', formatter:jsRownumFormmater},
			{ label: '제목', index: 'schdTitle', name: 'schdTitle', align : 'center', width:100 , formatter:jsTitleLinkFormmater},
			{ label: '시작일자', index: 'sedt', name: 'sedt', align : 'center', width:100 },
			{ label: '구분', index: 'class', name: 'class', align : 'center', width:50},
			{ label: '조횟수', index: 'schdView', name: 'schdView', align : 'center', width:50},
			
	
		],
		postData :{	
		 	searchKey : $("#searchKey").val(),
        	searchTxt : $("#searchTxt").val(),

		
		},
 /* 		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#intropage_pager',  */
		viewrecords : true,
		height : "1000px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit: true,
		editable: true,
		edittype :"text",
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
	
	var str = "<a href=\"javascript:eventWrite('"+rowObject.schdIdx+"')\">"+rowObject.schdTitle+"</a>";
	
	return str;
}






function eventWrite(schdIdx) {
    var f = document.listFrm;
    var mode = '';
    mode = 'W';
    if(schdIdx != "") mode = "E";
    
	$("#mode").val(mode);
	$("#schdIdx").val(schdIdx);
	
    f.action = eventWriteUrl;
    f.submit();
  
}

function getSelectValue(frm)
{

 frm.searchTxt.value = frm.searchKey.options[frm.searchKey.selectedIndex].value;

}



function search() {

	var f = document.listFrm;
    f.target = "_self";
    f.action = eventUrl;
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
	<div class="float_right">
			<a href="javascript:eventWrite('')" class="btn acti" title="등록">
				<span>등록</span>
			</a>
	</div>
		
		<!--// main_title -->
		 <jsp:include page="/WEB-INF/views/back/menu/menuDescInclude.jsp"/>
	</div>	
	<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="mode" name='mode' value="W" />
    <input type='hidden' id="schdIdx" name='schdIdx' value="${param.schdIdx}" />
	
	
		<div class="search_area">
			<table class="search_box">
				<caption>코드구분검색</caption>
				<colgroup>
					<col style="width: 80px;" />

				</colgroup>
				<tbody>
					<tr>
						<th><label for="p_searchkey">검색조건</label></th>
						<td><label for="p_searchkey">기준년도: </label> <select
							name="searchKey" id="searchKey" title="검색옵션"
							onChange="getSelectValue(this.form);">
								<option value="" selected>전체</option>
								<option value="01"
									<c:if test="${param.searchTxt == '01'}">selected</c:if>>실무교육</option>
								<option value="02"
									<c:if test="${param.searchTxt == '02'}">selected</c:if>>보수교육</option>
								<option value="03"
									<c:if test="${param.searchTxt == '03'}">selected</c:if>>수시교육</option>

						</select> <input type="hidden" name="searchTxt" id="searchTxt"
							value="${param.searchTxt}"></td>

					</tr>
				</tbody>
			</table>
			<div class="search_area_btnarea">
				<a href="javascript:search();" class="btn sch" title="조회"> <span>조회</span>
				</a>

			</div>
		</div>




		<!-- table 1dan list -->
	<div class="table_area" id="intropage_list_div" >
	    <table id="intropage_list"></table>
        <div id="intropage_pager"></div>
	</div>
	<!--// table 1dan list -->
<!--// content -->
		</form>
	</div>
