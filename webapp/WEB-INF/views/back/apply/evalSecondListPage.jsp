<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%
      request.setAttribute("applyGb", "S");
%>
<script>
var savedRow = null;
var savedCol = null;
var selectEvalSecondUrl = "<c:url value='/back/apply/evalSecondPageList.do'/>";
var applyWriteUrl =  "<c:url value='/back/apply/applyWrite.do'/>";

$(document).ready(function(){
	
	changeSeq();
	
	$('#apply_list').jqGrid({
		datatype: 'json',
		url: selectEvalSecondUrl,
		mtype: 'POST',
		colModel: [
            //{ label: '선택', index: 'sel_box', name: 'sel_box', width: 30, align : 'center', sortable:false, formatter:jsCheckboxFormmater},  
			{ label: '번호', index: 'rnum', name: 'rnum', width: 30, align : 'center', sortable:false, formatter:jsRownumFormmater},
			{ label: '아이디', index: 'user_id', name: 'user_id', width: 40, align : 'center', sortable:false },
			{ label: '이름', index: 'user_str', name: 'user_str', align : 'center', width:40, sortable:false, formatter:jsTitleLinkFormmater},
			{ label: '구비서류', index: 'doc_str', name: 'doc_str', align : 'center', width:40, sortable:false, formatter:jsDocLinkFormmater},
			{ label: '행정구역', index: 'administ_nm', name: 'administ_nm', align : 'center', width:45, sortable:false},
			{ label: '전입일', index: 'seoul_live_dt', name: 'seoul_live_dt', width: 55, align : 'center' , sortable:false},
			{ label: '증번호', index: 'health_no', name: 'health_no', width: 40, align : 'center' , sortable:false},
			{ label: '구분', index: 'health_gb_nm', name: 'health_gb_nm' , width: 40, align : 'center', sortable:false},
			{ label: '금액', index: 'health_fee', name: 'health_fee' , width: 40, align : 'right', sortable:false,formatter:'currency',formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
			{ label: '등급', index: 'health_class', name: 'health_class' , width: 40, align : 'center', sortable:false},
			{ label: '점수', index: 'health_point', name: 'health_point' , width: 40, align : 'center', sortable:false},
			{ label: '개월', index: 'unemploy_priod', name: 'unemploy_priod' , width: 40, align : 'center', sortable:false},
			{ label: '등급', index: 'notwork_class', name: 'notwork_class' , width: 40, align : 'center', sortable:false},
			{ label: '점수', index: 'notwork_point', name: 'notwork_point' , width: 40, align : 'center', sortable:false},
			{ label: '인원', index: 'dependent_cnt', name: 'dependent_cnt' , width: 40, align : 'center', sortable:false},
			{ label: '점수', index: 'family_point', name: 'family_point' , width: 40, align : 'center', sortable:false},
			{ label: '기초생활</br>수급자여부', index: 'reserver_nm', name: 'reserver_nm' , width: 40, align : 'center', sortable:false},
			{ label: '합계', index: 'tot_point', name: 'tot_point' , width: 40, align : 'center', sortable:false},
			{ label: '그룹', index: 'group_nm', name: 'group_nm' , width: 40, align : 'center', sortable:false},
			{ label: '심사위원', index: 'judge_nm', name: 'judge_nm' , width: 100, align : 'center', sortable:false},
			{ label: '2차심사결과', index: 'second_result', name: 'second_result' , width: 50, align : 'center', sortable:false, formatter:jsResultLinkFormmater},
			{ label: '공고ID', index: 'announc_id', name: 'announc_id',  hidden:true},
			{ label: '신청ID', index: 'aply_id', name: 'aply_id',  hidden:true},
			{ label: '사용자번호', index: 'user_no', name: 'user_no',  hidden:true},
			{ label: '주민등록파일', index: 'id_file_id', name: 'id_file_id',  hidden:true},
			{ label: '주민등록파일명', index: 'id_file_nm', name: 'id_file_nm',  hidden:true},
			{ label: '건강보험파일', index: 'health_file_id', name: 'health_file_id',  hidden:true},
			{ label: '건강보험파일명', index: 'health_file_nm', name: 'health_file_nm',  hidden:true},
			{ label: '고용보험자격파일', index: 'unemplyinsur_file_id', name: 'unemplyinsur_file_id',  hidden:true},
			{ label: '고용보험자격파일명', index: 'unemplyinsur_file_nm', name: 'unemplyinsur_file_nm',  hidden:true},
			{ label: '졸업증명서파일', index: 'deploma_file_id', name: 'deploma_file_id',  hidden:true},
			{ label: '졸업증명서파일명', index: 'deploma_file_nm', name: 'deploma_file_nm',  hidden:true},
			{ label: '사용자명', index: 'user_nm', name: 'user_nm',  hidden:true},
			{ label: '헨드폰', index: 'mobile', name: 'mobile',  hidden:true}
		],
		postData :{	
			year : $("#p_year").val(),
			seq : $("#p_seq").val(),
			group_no : $("#p_group_no").val(),
			second_result : $("#p_second_result").val(),
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#apply_pager',
		viewrecords : true,
		sortname : "user_nm",
		sortorder : "asc",
		height : "350px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit : false,
		cellsubmit : 'clientArray',
		multiselect: true,
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
		},
		onSelectRow : function(rowid, status, e) {
			var ret = jQuery("#apply_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "apply_list");
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
			
			showJqgridDataNon(data, "apply_list",20);

		}
	});
	//jq grid 끝 
	
	jQuery("#apply_list").jqGrid('setGroupHeaders', {
		  useColSpanStyle: true, 
		  groupHeaders:[
			{startColumnName: 'health_no', numberOfColumns: 5, titleText: '건강보험'},
			{startColumnName: 'unemploy_priod', numberOfColumns: 3, titleText: '최근 미취업기간'},
			{startColumnName: 'dependent_cnt', numberOfColumns: 2, titleText: '배우자 및 자녀 수'}
		  ]	
		
	});
	
	jQuery("#apply_list").jqGrid('navGrid', '#apply_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("apply_list", "apply_list_div");
	 
	$('#result_list').jqGrid({
		datatype: 'local',
		mtype: 'POST',
		colModel: [
			{ label: '아이디', index: 'user_id', name: 'user_id', width: 40, align : 'center', sortable:false },
			{ label: '증번호', index: 'health_no', name: 'health_no', align : 'center', sortable:false, width:60},
			{ label: '구분', index: 'code_desc', name: 'code_desc', align : 'center', sortable:false, width:60},
			{ label: '금액', index: 'use_yn', name: 'use_yn', align : 'center', width:60},
			{ label: '비고', index: 'reg_date', name: 'reg_date', width: 60, align : 'center', sortable:false },
		],
		rowNum : -1,
		viewrecords : true,
		height : "350px",
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
		loadComplete : function(data) {
		}
	});
	
});

function jsCheckboxFormmater(cellvalue, options, rowObject){
	return '<input type="checkbox" id="chk_user_no" name="chk_user_no" value="'+rowObject.user_no+'")/>';
}

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:applyWrite('S','"+rowObject.aply_id+"')\">"+rowObject.user_nm+"</a>";
	
	return str;
}

function jsDocLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "종";
	var docCnt = 0;
	
	if(rowObject.id_file_id != undefined) docCnt++;
	//if(rowObject.health_file_id != undefined) docCnt++;
	if(rowObject.unemplyinsur_file_id != undefined) docCnt++;
	if(rowObject.deploma_file_id != undefined) docCnt++;
	if(docCnt > 0)
		str = "<a onmouseover=\"showSubmitPopup('"+rowObject.id_file_id+"','"+rowObject.health_file_id+"','"+rowObject.unemplyinsur_file_id+"','"+rowObject.deploma_file_id+"')\" onmouseout='hideSubmitPopup()'>"+docCnt+str+"</a>";
	else
		str = docCnt+str;
	
	return str;
}

function jsResultLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "";
	
	if(cellvalue == "Fail")
		str = "<a onmouseover=\"showFailPopup('"+rowObject.second_fail_reason_nm+"')\" onmouseout='hideSubmitPopup()'>"+jsNvl(cellvalue)+"</a>";
	else
		str = jsNvl(cellvalue);
	
	return str;
}

function search() {
		
	jQuery("#apply_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectEvalSecondUrl,
		page : 1,
		postData : {
			year : $("#p_year").val(),
			seq : $("#p_seq").val(),
			group_no : $("#p_group_no").val(),
			second_result : $("#p_second_result").val(),
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function changeYear(){
    var param = {}; 
    param["year"] = $("#p_year").val();
    
    getCodeList("/back/announce/announceSeqCodeList.do", param, "p_seq", "", "", "","Y","Y");
    changeSeq();
}

function changeSeq(){
    var param = {}; 
    param["year"] = $("#p_year").val();
    param["seq"] = $("#p_seq").val();
    
	getCodeList("/back/apply/groupCodeList.do", param, "p_group_no", "", "", "","N");
}

function applyExcelDown(){
     var f = document.listFrm;
     
     f.target = "hiddenFrame";
     f.action = "/back/apply/evalSecondExcelDown.do";
     f.submit();
     f.target = "";
}

function formReset(){
	$("select[name=p_group_no] option[value='']").attr("selected",true);
	$("select[name=p_searchkey] option[value='']").attr("selected",true);
	$("#p_searchtxt").val("");
}

function evalResultPopup(){
	$("#evalFailTitle").html("2차심사 Fail 사유");
	 var s = jQuery("#apply_list").jqGrid('getGridParam','selarrrow');

     if(s.length < 1){
     	alert("대상자를 선택해 주십시요.");
     	return;
     }
	evalPopupShow();
}

function updateEvalResult(gubun){
	var gubunNm = "Pass";
	var failReason = "";
	if(gubun == "F") {
		gubunNm = "Fail";
		failReason = $("#fail_reason").val();
	}
	
	 var s = jQuery("#apply_list").jqGrid('getGridParam','selarrrow');

     if(s.length < 1){
     	alert("대상자를 선택해 주십시요.");
     	return;
     }
     
     if(!confirm("선택한 대상자를 "+gubunNm+" 처리하시겠습니까?")) return;
    	 
 	var aplyRow = new Array();
	for (var i = 0; i < s.length; i++) {
		ret = jQuery("#apply_list").jqGrid('getRowData',s[i]);
	    aplyRow.push(ret.aply_id);
    }
	
    $.ajax({
        url: "/back/apply/updateEvalResult.do",
        dataType: "json",
        type: "post",
        data: {
        	type : "S",
           result : gubun,
  		   fail_reason : failReason,
  		   aply_list : JSON.stringify(aplyRow)
		},
        success: function(data) {
        	alert(data.message);
        	if(data.success == "true") search();
        	evalPopupClose(); 
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
    	 
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
	<input type='hidden' id="apply_id" name='apply_id' value="" />
	<input type='hidden' id="mode" name='mode' value="W" />
	
	<!-- search_area -->
	<div class="search_area">
		<table class="search_box">
			<caption>신청자 서류심사관리검색</caption>
			<colgroup>
				<col style="width: 110px;" />
				<col style="width: 20%;" />
				<col style="width: 80px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<tr>
				<th>회차/공고연도</th>
				<td>	
					<g:select id="p_seq" name="p_seq"  source="${seqList}" selected="${param.p_seq}" cls="in_wp60" onChange="changeSeq()" />/
					<select id="p_year" name="p_year" class="form-control input-sm" onChange="changeYear()">
                      <c:forEach var="i" begin="0" end="5" >
                         <option value="${curYear-i}" <c:if test="${(curYear-i) == selYear}">selected</c:if>>${curYear-i}</option>
                     </c:forEach>
                  </select>
				</td>
				<th>그룹</th>
				<td>
					<select id="p_group_no"  name="p_group_no" class="in_wp100">
					         <option value="">- 전체 -</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>2차 심사결과</th>
				<td>
					<select id="p_second_result" name="p_second_result" class="in_wp80" title="기초생활수급자">
					  <option value="">- 전체 -</option>
					  <option value="P" <c:if test="${'P' == param.p_second_result}">selected</c:if>>Pass</option>
					  <option value="F" <c:if test="${'F' == param.p_second_result}">selected</c:if>>Fail</option>
					</select>
				</td>
			</tr>			
			<tr>
				<th>검색구분</th>
				<td colspan="3">
					<select id="p_searchkey" name="p_searchkey" class="in_wp80" title="검색구분">
						<option value="user_nm">이름</option>
						<option value="user_id">아이디</option>
						<option value="mobile">휴대전화</option>
						<option value="email">이메일</option>
					</select>
					<label for="input_text" class="hidden">검색어 입력</label>
					<input id="p_searchtxt" name="p_searchtxt" type="text" value="${param.p_searchtxt}" class="in_w50" />
				</td>
			</tr>	
			</tbody>
		</table>
		<div class="search_area_btnarea">
			<a href="javascript:search();" class="btn sch" title="조회하기">
				<span>조회</span>
			</a>
			<a href="javascript:formReset();" class="btn clear" title="검색 초기화">
				<span>초기화</span>
			</a>
		</div>
	</div>
	<!--// search_area -->
	
	<!-- tabel_search_area -->
	<div class="table_search_area">
	  <div class="float_left">
			<a href="javascript:applyExcelDown()" class="btn acti" title="엑셀다운로드">
				<span>엑셀다운로드</span>
			</a>
			<a href="javascript:smsWrite('apply_list')" class="btn acti" title="SMS">
				<span>SMS</span>
			</a>
		</div>
		<div class="float_right">

		</div>
	</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="apply_list_div" >
	    <table id="apply_list"></table>
        <div id="apply_pager"></div>
	</div>
	<!--// table 1dan list -->
	
	<!-- tabel_search_area -->
	<div class="table_search_area">
	   <div class="float_left">
		</div>
		<div class="float_right">
			<a href="javascript:updateEvalResult('P')" class="btn acti" title="Pass">
				<span>Pass</span>
			</a>
			<a href="javascript:evalResultPopup()" class="btn none" title="Fail">
				<span>Fail</span>
			</a>			
		</div>
	</div>
	<!--// tabel_search_area -->	
	
</div>
<!--// content -->
</form>
 <jsp:include page="/WEB-INF/views/back/apply/applyInclude.jsp"/>
  <jsp:include page="/WEB-INF/views/back/user/jusoSearchPopup.jsp"/>