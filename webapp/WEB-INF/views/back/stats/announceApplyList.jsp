<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var selectAnnounceApplyPageListUrl = "<c:url value='/back/apply/announceApplyPageList.do'/>";

$(document).ready(function(){

	$('#apply_list').jqGrid({
		datatype: 'json',
		url: selectAnnounceApplyPageListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '회차', index: 'seq', name: 'seq', width: 60, align : 'center', sortable:false},
			{ label: '공고연도', index: 'year', name: 'year', width: 60, align : 'center' , sortable:false},
			{ label: '신청인원', index: 'user_cnt', name: 'user_cnt', align : 'center', width:60, sortable:false},
			{ label: '서류심사 Pass', index: 'paper_cnt', name: 'paper_cnt', align : 'center', width:80, sortable:false},
			{ label: '1차 심사 Pass', index: 'first_cnt', name: 'first_cnt', align : 'center', width:80, sortable:false},
			{ label: '2차 심사 Pass', index: 'second_cnt', name: 'second_cnt', align : 'center', width:80, sortable:false},
			{ label: '건강보험료', index: 'health_fee', name: 'health_fee', align : 'center', width:60, sortable:false,formatter:'currency',formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
			{ label: '미취업기간', index: 'unemploy_priod', name: 'unemploy_priod', width: 60, align : 'center', sortable:false},
			{ label: '부양가족수', index: 'dependent_cnt', name: 'dependent_cnt' , width: 60, align : 'center', sortable:false}
		],
		postData :{	
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#apply_pager',
		viewrecords : true,
		sortname : "a.year",
		sortorder : "desc, a.seq desc",
		height : "350px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit : false,
		cellsubmit : 'clientArray',
		onSelectRow : function(rowid, status, e) {
			var ret = jQuery("#apply_list").jqGrid('getRowData', rowid);
		},
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },	
		//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
		loadComplete : function(data) {
			
			showJqgridDataNon(data, "apply_list",9);

		}
	});
	//jq grid 끝 
	
	jQuery("#apply_list").jqGrid('navGrid', '#apply_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("apply_list", "apply_list_div");
	
	jQuery("#apply_list").jqGrid('setGroupHeaders', {
		  useColSpanStyle: true, 
		  groupHeaders:[
			{startColumnName: 'paper_cnt', numberOfColumns: 3, titleText: '심사 Pass 인원'},
			{startColumnName: 'health_fee', numberOfColumns: 3, titleText: '2차 심사 Pass인원 평균점수'}
		  ]	
		
	});
	
});


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
	
	<!-- table 1dan list -->
	<div class="table_area" id="apply_list_div" >
	    <table id="apply_list"></table>
        <div id="apply_pager"></div>
	</div>
	<!--// table 1dan list -->
	
</div>
<!--// content -->
</form>
  
		 		