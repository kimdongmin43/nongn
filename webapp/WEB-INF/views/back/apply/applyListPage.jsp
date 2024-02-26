<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%
      request.setAttribute("applyGb", "P");
%>
<link href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" rel="stylesheet" />
<script src="/assets/jquery/jquery.ui.datepicker.js"></script>

<script>
var savedRow = null;
var savedCol = null;
var selectApplyUrl = "<c:url value='/back/apply/applyPageList.do'/>";
var applyWriteUrl =  "<c:url value='/back/apply/applyWrite.do'/>";

$(document).ready(function(){
	$(".onlynum").keyup( setNumberOnly );
	
	$('#apply_list').jqGrid({
		datatype: 'json',
		url: selectApplyUrl,
		mtype: 'POST',
		colModel: [
            //{ label: '선택', index: 'sel_box', name: 'sel_box', width: 30, align : 'center', sortable:false, formatter:jsCheckboxFormmater},  
			{ label: '번호', index: 'rnum', name: 'rnum', width: 30, align : 'center', sortable:false, formatter:jsRownumFormmater},
			{ label: '아이디', index: 'user_id', name: 'user_id', width: 40, align : 'center', sortable:false },
			{ label: '이름', index: 'user_str', name: 'user_str', align : 'center', width:40, sortable:false, formatter:jsTitleLinkFormmater},
			{ label: '구비서류', index: 'doc_str', name: 'doc_str', align : 'center', width:40, sortable:false, formatter:jsDocLinkFormmater},
			{ label: '행정구역', index: 'administ_nm', name: 'administ_nm', align : 'center', width:50, sortable:false},
			{ label: '전입일', index: 'seoul_live_dt', name: 'seoul_live_dt', width: 50, align : 'center' , sortable:false},
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
			{ label: '서류</br>심사결과', index: 'paper_result', name: 'paper_result' , width: 40, align : 'center', sortable:false, formatter:jsResultLinkFormmater},
			{ label: '공고ID', index: 'announc_id', name: 'announc_id',  hidden:true},
			{ label: '신청ID', index: 'aply_id', name: 'aply_id',  hidden:true},
			{ label: '사용자번호', index: 'user_no', name: 'user_no',  hidden:true},
			{ label: '주민등록파일', index: 'id_file_id', name: 'id_file_id',  hidden:true},
			{ label: '주민등록파일명', index: 'id_file_nm', name: 'id_file_nm',  hidden:true},
			{ label: '건강보험구분', index: 'health_gb', name: 'health_gb',  hidden:true},
			{ label: '건강보험파일', index: 'health_file_id', name: 'health_file_id',  hidden:true},
			{ label: '건강보험파일명', index: 'health_file_nm', name: 'health_file_nm',  hidden:true},
			{ label: '고용보험자격파일', index: 'unemplyinsur_file_id', name: 'unemplyinsur_file_id',  hidden:true},
			{ label: '고용보험자격파일명', index: 'unemplyinsur_file_nm', name: 'unemplyinsur_file_nm',  hidden:true},
			{ label: '졸업증명서파일', index: 'deploma_file_id', name: 'deploma_file_id',  hidden:true},
			{ label: '졸업증명서파일명', index: 'deploma_file_nm', name: 'deploma_file_nm',  hidden:true},
			{ label: '사용자명', index: 'user_nm', name: 'user_nm',  hidden:true},
			{ label: '헨드폰', index: 'mobile', name: 'mobile',  hidden:true},
			{ label: '1차심사결과', index: 'first_result', name: 'first_result',  hidden:true}
		],
		postData :{	
			year : $("#p_year").val(),
			seq : $("#p_seq").val(),
			administ_cd : $("#p_administ_cd").val(),
			seoul_live_sta : $("#p_seoul_live_sta").val(),
			seoul_live_end : $("#p_seoul_live_end").val(),
			health_class_sta : $("#p_health_class_sta").val(),
			health_class_end : $("#p_health_class_end").val(),
			notwork_class_sta : $("#p_notwork_class_sta").val(),
			notwork_class_end : $("#p_notwork_class_end").val(),
			dependent_cnt : $("#p_dependent_cnt").val(),
			reserver_yn : $("#p_reserver_yn").val(),
			paper_result : $("#p_paper_result").val(),
			tot_point_sta : $("#p_tot_point_sta").val(),
			tot_point_end : $("#p_tot_point_end").val(),
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
	 
	$('#receiver_list').jqGrid({
		datatype: 'local',
		mtype: 'POST',
		colModel: [
			{ label: '이름', index: 'user_nm', name: 'user_nm', width: 100, align : 'center', sortable:false },
			{ label: '전화번호', index: 'mobile', name: 'mobile', align : 'left', sortable:false, width:150},
			{ label: '사용자번호', index: 'user_no', name: 'user_no',  hidden:true},
			{ label: '사용자ID', index: 'user_id', name: 'user_id',  hidden:true}
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
		cellsubmit : 'clientArray'
	});
	
	$('#result_list').jqGrid({
		datatype: 'local',
		mtype: 'POST',
		colModel: [
			{ label: '아이디', index: 'user_id', name: 'user_id', width: 60, align : 'center', sortable:false },
			{ label: '증번호', index: 'health_no', name: 'health_no', align : 'center', sortable:false, width:90},
			{ label: '구분', index: 'health_gb', name: 'health_gb', align : 'center', sortable:false, width:87},
			{ label: '금액', index: 'health_fee', name: 'health_fee', align : 'center', width:100, sortable:false },
			{ label: '결과', index: 'success', name: 'success', width: 60, align : 'center', sortable:false },
			{ label: '오류', index: 'message', name: 'message', width: 150, align : 'center', sortable:false }
		],
		rowNum : -1,
		viewrecords : true,
		height : "200px",
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
	
	var str = "<a href=\"javascript:applyWrite('P','"+rowObject.aply_id+"')\">"+rowObject.user_nm+"</a>";
	
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
		str = "<a onmouseover=\"showFailPopup('"+rowObject.paper_fail_reason_nm+"')\" onmouseout='hideSubmitPopup()'>"+jsNvl(cellvalue)+"</a>";
	else
		str = jsNvl(cellvalue);
	
	return str;
}

function search() {
	jQuery("#apply_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectApplyUrl,
		page : 1,
		postData : {
			year : $("#p_year").val(),
			seq : $("#p_seq").val(),
			administ_cd : $("#p_administ_cd").val(),
			seoul_live_sta : $("#p_seoul_live_sta").val(),
			seoul_live_end : $("#p_seoul_live_end").val(),
			health_class_sta : $("#p_health_class_sta").val(),
			health_class_end : $("#p_health_class_end").val(),
			notwork_class_sta : $("#p_notwork_class_sta").val(),
			notwork_class_end : $("#p_notwork_class_end").val(),
			dependent_cnt : $("#p_dependent_cnt").val(),
			reserver_yn : $("#p_reserver_yn").val(),
			paper_result : $("#p_paper_result").val(),
			tot_point_sta : $("#p_tot_point_sta").val(),
			tot_point_end : $("#p_tot_point_end").val(),
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
    
    getCodeList("/back/announce/announceSeqCodeList.do", param, "p_seq", "", "", "","N","Y");
}

function applyExcelDown(){
     var f = document.listFrm;
     
     f.target = "hiddenFrame";
     f.action = "/back/apply/applyExcelDown.do";
     f.submit();
     f.target = "";
}

function healthExcelDown(){
    var f = document.listFrm;
    
    f.target = "hiddenFrame";
    f.action = "/back/apply/healthExcelDown.do";
    f.submit();
    f.target = "";
}

function pointRecalc(){
	   var str = ""; 
	   var evalCnt = 0;
	  $.ajax({
        url: "/back/apply/selectEvalCnt.do",
        dataType: "json",
        type: "post",
        async:false,
        data: {
			year : $("#p_year").val(),
			seq : $("#p_seq").val()
 		},
        success: function(data) {
        	evalCnt = data.evalCnt;
        }
      });	
	  if(evalCnt > 0){
		  str += "신청자 중 일부 심사결과가 존재합니다.\r\n"; 
		  str += "점수 재계산되더라도 심사결과에는 영향을 미치지 않습니다.\r\n";
	  }	  
	 str += $("#p_year").val()+"년 "+$("#p_seq").val()+"회 공고에 대한 ";
     if(!confirm(str+"점수를 재계산 하시겠습니까?")) return;
	// 서류심사 처리자가 있습니다 그래도 
	$.ajax({
        url: "/back/apply/updateApplyRecalc.do",
        dataType: "json",
        type: "post",
        data: {
			year : $("#p_year").val(),
			seq : $("#p_seq").val()
 		},
        success: function(data) {
        	alert(data.message);
        	if(data.success == "true") search();
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

function healthExcelUploadWrite(){
	$("#result_list_div").hide();
	$("#excel_file").val("");
	$("#pop_title").html($("#p_seq").val()+"차 / "+$("#p_year").val()+"년");
	excelPopupShow();
}

function healthExcelUpload(){
	
	$('#result_list').jqGrid('clearGridData');
	
	if($("#excel_file").val() == ""){
		alert("업로드 파일을 선택해 주십시요.");
		return;
	}
	
	if($("#excel_file").val() != "" && !$("#excel_file").val().toLowerCase().match(/\.(xls|xlsx)$/)){
	    alert("확장자가 xls,xlsx 파일만 업로드가 가능합니다.");
	    return;
	}
	
	// 데이터를 등록 처리해준다.
	$("#excelFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.errorCnt > 0){
					var list = responseText.list;
					for(var i =0; i < list.length;i++){
						$("#result_list").addRowData(undefined, list[i]);
					}
					$("#result_list_div").show();
				}else{	
					search();
					excelPopupClose();
				}
			},
			dataType: "json",
	        data: {
	   		   year : $("#p_year").val(),
	   		   seq : $("#p_seq").val()
	 		},
			url: "/back/apply/healthExcelUpload.do"
	  });	

}

function evalResultPopup(){
	$("#evalFailTitle").html("서류심사 Fail 사유");
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
     
  	var aplyRow = new Array();
 	var ret = null;
	for (var i = 0; i < s.length; i++) {
		ret = jQuery("#apply_list").jqGrid('getRowData',s[i]);
		if(gubun == 'F' && ret.first_result == 'Pass'){
			alert("1차 심사 Pass자를 Fail 처리할 수 없습니다.");
			evalPopupClose(); 
			return;
		}
		 aplyRow.push(ret.aply_id);
    }    
	
     if(!confirm("선택한 대상자를 "+gubunNm+" 처리하시겠습니까?")) return;
    	 
    $.ajax({
        url: "/back/apply/updateEvalResult.do",
        dataType: "json",
        type: "post",
        data: {
        	type : "P",
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

function formReset(){
	$("select[name=p_administ_cd] option[value='']").attr("selected",true);
	$("select[name=p_seoul_live_sta] option[value='']").attr("selected",true);
	$("select[name=p_seoul_live_end] option[value='']").attr("selected",true);
	$("select[name=p_health_class_sta] option[value='']").attr("selected",true);
	$("select[name=p_health_class_end] option[value='']").attr("selected",true);
	$("select[name=p_notwork_class_sta] option[value='']").attr("selected",true);
	$("select[name=p_notwork_class_end] option[value='']").attr("selected",true);
	$("select[name=p_dependent_cnt] option[value='']").attr("selected",true);
	$("select[name=p_reserver_yn] option[value='']").attr("selected",true);
	$("select[name=p_paper_result] option[value='']").attr("selected",true);
	$("#p_tot_point_sta").val("");
	$("#p_tot_point_end").val("");
	$("#p_searchtxt").val("");
}

function excelPopupShow(){
	$('#modal-excel-write').modal('show');
}

function excelPopupClose(){
	$('#modal-excel-write').modal('hide');
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
	<input type='hidden' id="mode" name='mode' value="W" />
	<input type='hidden' id="result_gb" name='result_gb' value="P" />
	
	<!-- search_area -->
	<div class="search_area">
		<table class="search_box">
			<caption>신청자 서류심사관리검색</caption>
			<colgroup>
				<col style="width: 110px;" />
				<col style="width: 20%;" />
				<col style="width: 110px;" />
				<col style="width: 20%;" />
				<col style="width: 110px;" />
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
				<th>행정구역</th>
				<td>
				     <c:set var="firstTitle" value="" />
				     <c:if test="${administList.size() > 1}">
				           <c:set var="firstTitle" value="전체" />
				     </c:if>
					<g:select id="p_administ_cd" name="p_administ_cd"  source="${administList}" selected="${param.p_administ_cd}" titleCode="${firstTitle}" cls="in_wp80" />
				</td>
				<th>서울거주기간</th>
				<td>
					<select id="p_seoul_live_sta" name="p_seoul_live_sta" class="in_wp80" title="서울거주기간시작">
					  <option value="">- 전체 -</option>
				      <c:forEach var="i" begin="1" end="13" >
                         <option value="${i}" <c:if test="${i == param.p_seoul_live_sta}">selected</c:if>>${i}개월</option>
                     </c:forEach>
					</select> ~
					<select id="p_seoul_live_end" name="p_seoul_live_end" class="in_wp80" title="서울거주기간종료">
					  <option value="">- 전체 -</option>
				      <c:forEach var="i" begin="1" end="13" >
                         <option value="${i}" <c:if test="${i == param.p_seoul_live_end}">selected</c:if>>${i}개월</option>
                     </c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>건강보험료</th>
				<td>	
					<select id="p_health_class_sta" name="p_health_class_sta" class="in_wp80" title="건강보험료시작">
					  <option value="">- 전체 -</option>
				      <c:forEach var="i" begin="1" end="10" >
                         <option value="${i}" <c:if test="${i == param.p_health_class_sta}">selected</c:if>>${i}등급</option>
                     </c:forEach>
					</select> ~
					<select id="p_health_class_end" name="p_health_class_end" class="in_wp80" title="건강보험료종료">
					  <option value="">- 전체 -</option>
				      <c:forEach var="i" begin="1" end="10" >
                         <option value="${i}" <c:if test="${i == param.p_health_class_end}">selected</c:if>>${i}등급</option>
                     </c:forEach>
					</select>
				</td>
				<th>최근 미취업기간</th>
				<td>
					<select id="p_notwork_class_sta" name="p_notwork_class_sta" class="in_wp80" title="최근 미취업기간시작">
					  <option value="">- 전체 -</option>
				      <c:forEach var="i" begin="1" end="10" >
                         <option value="${i}" <c:if test="${i == param.p_notwork_class_sta}">selected</c:if>>${i}등급</option>
                     </c:forEach>
					</select> ~
					<select id="p_notwork_class_end" name="p_notwork_class_end" class="in_wp80" title="최근 미취업기간종료">
					  <option value="">- 전체 -</option>
				      <c:forEach var="i" begin="1" end="10" >
                         <option value="${i}" <c:if test="${i == param.p_notwork_class_end}">selected</c:if>>${i}등급</option>
                     </c:forEach>
					</select>
				</td>
				<th>배우자 및 자녀 수</th>
				<td>
					<select id="p_dependent_cnt" name="p_dependent_cnt" class="in_wp80" title="배우자 및 자녀 수">
					  <option value="">- 전체 -</option>
				      <c:forEach var="i" begin="0" end="4" >
                         <option value="${i}" <c:if test="${i == param.p_dependent_cnt}">selected</c:if>>${i}명
                         	<c:if test="${i == 4}"> 이상</c:if>
                         </option>
                     </c:forEach>
					</select>
				</td>
			</tr>			
			<tr>
				<th>기초생활수급자</th>
				<td>	
					<select id="p_reserver_yn" name="p_reserver_yn" class="in_wp80" title="기초생활수급자">
					  <option value="">- 전체 -</option>
					  <option value="Y" <c:if test="${'Y' == param.p_reserver_yn}">selected</c:if>>예</option>
					  <option value="N" <c:if test="${'N' == param.p_reserver_yn}">selected</c:if>>아니오</option>
					</select>
				</td>
				<th>합계점수</th>
				<td>
					<input id="p_tot_point_sta" name="p_tot_point_sta" type="text" value="${param.p_tot_point_sta}" class="in_w30 onlynum" /> ~ <input id="p_tot_point_end" name="p_tot_point_end" type="text" value="${param.p_tot_point_end}" class="in_w30 onlynum" />
				</td>
				<th>서류심사결과</th>
				<td>
					<select id="p_paper_result" name="p_paper_result" class="in_wp80" title="서류심사결과">
					  <option value="">- 전체 -</option>
					  <option value="P" <c:if test="${'P' == param.p_paper_result}">selected</c:if>>Pass</option>
					  <option value="F" <c:if test="${'F' == param.p_paper_result}">selected</c:if>>Fail</option>
					</select>
				</td>
			</tr>
			<tr>	
			    <th>검색구분</th>
				<td colspan="5"> 
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
			<a href="javascript:applyExcelDown()" class="btn acti" title="엑셀다운">
				<span>엑셀다운로드</span>
			</a>
			<a href="javascript:smsWrite('apply_list')" class="btn acti" title="SMS">
				<span>SMS</span>
			</a>
			<a href="javascript:healthExcelDown()" class="btn acti" title="증번호 일괄다운로드">
				<span>증번호 일괄다운로드</span>
			</a>
		</div>
		<div class="float_right">
			<a href="javascript:pointRecalc()" class="btn acti" title="점수재계산">
				<span>점수재계산</span>
			</a>
			<a href="javascript:healthExcelUploadWrite()" class="btn acti" title="건강보험료일괄등록">
				<span>건강보험료일괄등록</span>
			</a>			
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
	</form>
	
</div>
<!--// content -->

 
 	
	<div class="modal fade" id="modal-excel-write" >
		<div class="modal-dialog modal-size-small">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title">건강보험료 일괄등록</h1>
				<a href="javascript:excelPopupClose()" class="pop_close" title="페이지 닫기">
					<span>닫기</span>
				</a>
			</header>
			</div>
			<!-- //header -->
			<!-- container -->
			<div id="pop_container">
			<article>
				<div class="pop_content_area">
				    <div  id="excel_pop_content"  style="margin:10px;">
	<form id="excelFrm" name="excelFrm" method="post" data-parsley-validate="true" enctype="multipart/form-data">
					 <!-- title_area -->
					<div class="title_area">
						<h2 class="pop_title">공고: <span id="pop_title" class="color_pointr">1회차 2017년</span></h2>
					</div>
					<!--// title_area -->
					<!-- table_area -->
					<div class="table_area">
						<table class="write">
							<caption>건강보험료 일괄등록 화면</caption>
							<colgroup>
								<col style="width: 150px;">
								<col style="width: *;">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">엑셀파일 선택<strong class="color_pointr">*</strong></th>
								<td>
									<label for="excel_file" class="hidden">파일 선택하기</label>
									<input id="excel_file" name="excel_file" type="file" class="in_wp400" />
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<!--// table_area -->		
					<!-- information_area -->
					<div class="information_area">
						<section>
							<h5 class="infor_title">주의사항</h5>
							<ul class="information">
								<li>
									<span>1. 엑셀파일 저장 시 엑셀 형식으로 저장해주십시오.</span>
								</li>
								<li>
									<span>2. 샘플 양식 폼을 변경할 시 등록이 불가능합니다. 주의하여 주십시오.</span>
								</li>
								<li>
									<span>3. 엑셀 버전은 2003이하의 버전을 사용하여 주십시오.(확장자 .xls 사용)</span>
								</li>
								<li>
									<span>4. 샘플파일의 필수항목 "*"은 꼭 입력하여 주십시오.</span>
								</li>
								<li>
									<span>5. 휴대전화는 전화번호 사이에–를 입력하여 주시고, 이메일주소는 @를 입력하여 주십시오.</span>
								</li>
								<li>
									<span>6. 샘플파일을 참고하여 작성하여 주십시요. (<a href="/html/healthno.xlsx" title="샘플파일다운로드">샘플파일다운</a>)</span>
								</li>
							</ul>
						</section>
					</div>
					<!--// information_area -->
					<!-- table_area -->
					<div id="result_list_div" class="table_area" style="display:none">
						<table id="result_list"></table>
					</div>
					<!--// table_area -->		
							
					<!-- button_area -->
					<div class="button_area">
						<div class="alignc">
							<a href="javascript:healthExcelUpload()" class="btn save" title="저장하기">
								<span>저장</span>
							</a>
							<a href="javascript:excelPopupClose();" class="btn cancel" title="닫기">
								<span>닫기</span>
							</a>							
						</div>
					</div>
					<!--// button_area -->
</form>
				    </div>
				</div>
			</article>	
			</div>
			<!-- //container -->			
		</div>
	</div>
	
 <jsp:include page="/WEB-INF/views/back/apply/applyInclude.jsp"/>