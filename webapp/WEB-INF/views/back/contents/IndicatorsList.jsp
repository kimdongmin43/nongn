<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
var savedRow = null;
var savedCol = null;
var selectIndicatorsUrl = "<c:url value='/back/contents/IndicatorsPageList.do'/>";
var IndicatorWriteUrl =  "<c:url value='/back/contents/IndicatorsWrite.do'/>";
var insertIndicatorsUrl = "<c:url value='/back/contents/insertIndicators.do'/>";
var updateIndicatorUrl =  "<c:url value='/back/contents/updateIndicators.do'/>";
var IndicatorsUrl =  "<c:url value='/back/contents/IndicatorsListPage.do'/>";


$(document).ready(function(){
	
	
	/* alert(JSON.stringify(intropage)); */
	
	
	$('#intropage_list').jqGrid({
		datatype: 'json',
		url: selectIndicatorsUrl,
		mtype: 'POST',
		colModel: [
			//{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', formatter:jsRownumFormmater},
			{ label: '연도', index: 'year', name: 'year', align : 'center', width:50 , formatter:jsTitleLinkFormmater},
			{ label: '구분', index: 'gu', name: 'gu', align : 'center', width:50},
			{ label: '대상품목(축종)수', index: 'itemNum', name: 'itemNum', align : 'center', width:60},
			{ label: '가입면적(두수)', index: 'joinNum', name: 'joinNum', align : 'left', width:100},
			{ label: '가입농가수', index: 'houseNum', name: 'houseNum', align : 'left', width:100},
			{ label: '가입금액', index: 'subFee', name: 'subFee', align : 'left', width:100},
			{ label: '순보험료', index: 'premium', name: 'premium', align : 'left', width:100},
			{ label: '가입률', index: 'subRate', name: 'subRate', align : 'left', width:100},
	
		],
		postData :{	 	searchKey : $("#searchKey").val(),
        				searchTxt : $("#searchTxt").val()
		
		},
/* 		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#intropage_pager', */
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
	
	var str = "<a href=\"javascript:IndicatorWrite('"+rowObject.farmId+"')\">"+rowObject.year+"</a>";
	
	return str;
}



/* function search() {		
	
	jQuery("#intropage_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectIndicatorsUrl,
		page : 1,
		postData : {
			
			searchtxt : $("#p_searchtxt").val(),
		
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
} */



function IndicatorWrite(farmId) {
    var f = document.listFrm;
    var mode = '';
    mode = 'W';
    if(farmId != "") mode = "E";
    
	$("#mode").val(mode);
	$("#farmId").val(farmId);
	
    f.action = IndicatorWriteUrl;
    f.submit();
  
}



 function getSelectValue(frm)
{

 frm.searchTxt.value = frm.searchKey.options[frm.searchKey.selectedIndex].value;
}


function search() {

	var f = document.listFrm;
    f.target = "_self";
    f.action = IndicatorsUrl;
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
			<a href="javascript:IndicatorWrite('')" class="btn acti" title="등록">
				<span>등록</span>
			</a>
	</div>
		
		<!--// main_title -->
		 <jsp:include page="/WEB-INF/views/back/menu/menuDescInclude.jsp"/>
	</div>	
	<form id="listFrm" name="listFrm" method="post">
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="mode" name='mode' value="W" />
    <input type='hidden' id="farmId" name='farmId' value="${param.farmId}" />
	
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
								<option value="2020"
									<c:if test="${param.searchTxt == '2020'}">selected</c:if>>2020</option>
								<option value="2019"
									<c:if test="${param.searchTxt == '2019'}">selected</c:if>>2019</option>
								<option value="2018"
									<c:if test="${param.searchTxt == '2018'}">selected</c:if>>2018</option>
								<option value="2017"
									<c:if test="${param.searchTxt == '2017'}">selected</c:if>>2017</option>
								<option value="2016"
									<c:if test="${param.searchTxt == '2016'}">selected</c:if>>2016</option>
								<option value="2015"
									<c:if test="${param.searchTxt == '2015'}">selected</c:if>>2015</option>
								<option value="2014"
									<c:if test="${param.searchTxt == '2014'}">selected</c:if>>2014</option>
								<option value="2013"
									<c:if test="${param.searchTxt == '2013'}">selected</c:if>>2013</option>
								<option value="2012"
									<c:if test="${param.searchTxt == '2012'}">selected</c:if>>2012</option>
								<option value="2011"
									<c:if test="${param.searchTxt == '2011'}">selected</c:if>>2011</option>
								<option value="2010"
									<c:if test="${param.searchTxt == '2010'}">selected</c:if>>2010</option>
								<option value="2009"
									<c:if test="${param.searchTxt == '2008'}">selected</c:if>>2009</option>
								<option value="2008"
									<c:if test="${param.searchTxt == '2008'}">selected</c:if>>2008</option>
								<option value="2007"
									<c:if test="${param.searchTxt == '2007'}">selected</c:if>>2007</option>
								<option value="2006"
									<c:if test="${param.searchTxt == '2006'}">selected</c:if>>2006</option>
								<option value="2005"
									<c:if test="${param.searchTxt == '2005'}">selected</c:if>>2005</option>
								<option value="2004"
									<c:if test="${param.searchTxt == '2004'}">selected</c:if>>2004</option>
								<option value="2003"
									<c:if test="${param.searchTxt == '2003'}">selected</c:if>>2003</option>
								<option value="2002"
									<c:if test="${param.searchTxt == '2002'}">selected</c:if>>2002</option>
								<option value="2001"
									<c:if test="${param.searchTxt == '2001'}">selected</c:if>>2001</option>
					</select> <input type="hidden" name="searchTxt" id="searchTxt" value="${param.searchTxt}"></td>

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
