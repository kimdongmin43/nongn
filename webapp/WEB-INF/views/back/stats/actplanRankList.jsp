<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var selectActplanRankPageListUrl = "<c:url value='/back/apply/actplanRankPageList.do'/>";

$(document).ready(function(){

	$('#apply_list').jqGrid({
		datatype: 'json',
		url: selectActplanRankPageListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '순위', index: 'rank', name: 'rank',  align : 'center', sortable:false, width:60},
			{ label: '활동목표', index: 'activ_targetnm', name: 'activ_targetnm', align : 'center', sortable:false, width:100, formatter:jsNvlFormmater},
			{ label: '비율(%)', index: 'activ_rate', name: 'activ_rate', align : 'center', sortable:false, width:60, formatter:jsNvlFormmater},
			{ label: '희망프로그램', index: 'wish_prognm', name: 'wish_prognm', align : 'center', sortable:false, width:100, formatter:jsNvlFormmater},
			{ label: '비율(%)', index: 'wish_rate', name: 'wish_rate', align : 'center', sortable:false, width:60, formatter:jsNvlFormmater}
		],
		postData :{	
	           year : $("#p_year").val(),
	           seq : $("#p_seq").val()
	     },
		rowNum : -1,
		viewrecords : true,
		height : "400px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit: true,
		editable: true,
		edittype :"text",
		cellsubmit : 'clientArray',
		loadComplete : function(data) {
			showJqgridDataNon(data, "apply_list",3);
		}
	});
	//jq grid 끝 
	
	bindWindowJqGridResize("apply_list", "apply_list_div");

});

function jsNvlFormmater(cellvalue, options, rowObject) {
	
	var str = (cellvalue==undefined?"-":cellvalue);
	
	return str;
}

function search() {
	
	jQuery("#apply_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectActplanRankPageListUrl,
		page : 1,
		postData : {
           year : $("#p_year").val(),
           seq : $("#p_seq").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function changeYear(){
    var param = {}; 
    param["year"] = $("#p_year").val();
    
    getCodeList("/back/announce/announceSeqCodeList.do", param, "p_seq", "", "", "","N","Y");
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
	<!-- search_area -->
	<div class="search_area">
		 <table class="search_box">
			<caption>결과보고서 키워드</caption>
			<colgroup>
				<col style="width: 100px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<tr>
				<th>회차/공고연도</th>
				<td>
                  	<g:select id="p_seq" name="p_seq"  source="${seqList}" selected="${param.p_seq}" cls="in_wp60" />/
					<select id="p_year" name="p_year" class="form-control input-sm" onChange="changeYear()">
                      <c:forEach var="i" begin="0" end="5" >
                         <option value="${curYear-i}" <c:if test="${(curYear-i) == selYear}">selected</c:if>>${curYear-i}</option>
                     </c:forEach>
                  </select>
				</td>
			</tr>
			</tbody>
		</table>
		<div class="search_area_btnarea">
			<a href="javascript:search();" class="btn sch" title="조회">
				<span>조회</span>
			</a>
		</div>
	</div>
	<!--// search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="apply_list_div" >
	    <table id="apply_list"></table>
	</div>
	<!--// table 1dan list -->
</div>
<!--// content -->
</form>
  
		 		