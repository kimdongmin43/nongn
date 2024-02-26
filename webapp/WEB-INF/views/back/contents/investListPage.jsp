<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var savedRow = null;
var savedCol = null;
var selectIntropageUrl = "<c:url value='/back/contents/investGridData.do'/>";
var intropageWriteUrl =  "<c:url value='/back/contents/intropageWrite.do'/>";

$(document).ready(function(){
	
	
	/* alert(JSON.stringify(intropage)); */
	
	
	$('#intropage_list').jqGrid({
		datatype: 'json',
		url: selectIntropageUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', formatter:jsRownumFormmater},
			{ label: '아이디', index: 'investId', name: 'investId', width: 50, align : 'center', hidden : true},			
			{ label: '운용사', index: 'company', name: 'company', align : 'center', width:200, formatter:jsTitleLinkFormmater},
			{ label: '펀드명', index: 'copart', name: 'copart', align : 'center', width:200},
			{ label: '투자분야', index: 'departCd', name: 'departCd', align : 'center', width:200},
			{ label: '투자기간', index: 'seDy', name: 'seDy', align : 'center', width:200},
			{ label: '전화', index: 'phone', name: 'phone', align : 'center', width:200},
			{ label: '펀드규모', index: 'scale', name: 'scale', align : 'center', width:200,formatter:jsScaleFormmater}		
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
		sortname : "invest_id",
		sortorder : "desc",
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
	
	var str = "<a href=\"javascript:investPageWrite('"+rowObject.investId+"')\">"+rowObject.company+"</a>";
	
	return str;
}

function jsScaleFormmater(cellvalue, options, rowObject) {
	
	var str = cellvalue+"억";	
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

function investPageWrite(investId) {
    var f = document.listFrm;
    var mode = "W";
    if(investId != "") mode = "E";
    
	$("#mode").val(mode);
	$("#investId").val(investId);
	
    f.action = "/back/contents/investWritePage.do";
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
	<input type='hidden' id="investId" name='investId' value="" />
	<input type='hidden' id="mode" name='mode' value="W" />
	<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
	
	
	<!-- search_area -->
	<%-- <div class="search_area">
		 <table class="search_box">
			<caption>코드구분검색</caption>
			<colgroup>
				<col style="width: 80px;" />
				 
			</colgroup>
			<tbody>
			<tr>
				<th>
					<label for="p_searchkey">검색조건</label>
				</th>
				<td>
				 
                  <select id="p_searchkey" name="p_searchkey" class="form-control input-sm">
                       <option value="title" >콘텐츠명</option>
                       <option value="code" >콘텐츠코드</option>
                  </select>
                  <label for="p_searchtxt" class="hidden">검색어 입력</label>
                  <input type="text" class="in_wp200" id="p_searchtxt" name="p_searchtxt" value="<c:out value="${param.p_searchtxt}" escapeXml="true" />"  placeholder="">
				</td>	
				<th>만족도여부</th>
				<td>
                  <select id="p_satis_yn" name="p_satis_yn" class="form-control input-sm">
                       <option value="">- 전체 -</option>
                       <option value="Y" <c:if test="${param.p_satis_yn == 'Y'}">selected</c:if>>사용</option>
                       <option value="N" <c:if test="${param.p_satis_yn == 'N'}">selected</c:if>>미사용</option>
                  </select>
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
	 --%><!--// search_area -->
	
	<!-- tabel_search_area -->
	<div class="table_search_area">
		<div class="float_right">
			<a href="javascript:investPageWrite('')" class="btn acti" title="등록">
				<span>등록</span>
			</a>
			</div>
		</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="intropage_list_div" >
	    <table id="intropage_list"></table>
        <div id="intropage_pager"></div>
	</div>
	<!--// table 1dan list -->
<!--// content -->
		</form>
	</div>