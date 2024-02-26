<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
var savedRow = null;
var savedCol = null;
var selectApplyUrl = "<c:url value='/back/event/eventApplyEmpPageList.do?menuId=${param.menuId}'/>";
var eventWriteUrl =  "<c:url value='/back/event/eventApplyWrite.do?menuId=${param.menuId}'/>";
var eventViewUrl =  "<c:url value='/back/event/eventWrite.do?menuId=${param.menuId}'/>";
var updateChangeJoin = "<c:url value='/back/event/updateEventApplyEmp.do'/>";
var eventExcelUrl = "<c:url value='/back/event/eventExcel.do'/>";

$(document).ready(function(){

	$('#event_list').jqGrid({
		datatype: 'json',
		url: selectApplyUrl,
		mtype: 'POST',
		multiselect:true,
		colModel: [
			{ label: '성명', index: 'empNm', name: 'empNm', width: 30, align : 'center', sortable:false},
			{ label: '신청자명', index: 'managerNm', name: 'managerNm', align : 'center', width:30, sortable:false, formatter:jsTitleLinkFormmater},
			{ label: '부서명', index: 'deptNm', name: 'deptNm', align : 'center', width:30, sortable:false},
			{ label: '직책', index: 'rankNm', name: 'rankNm', width: 20, align : 'left', sortable:false},
			{ label: '전화번호', index: 'tel', name: 'tel', width: 40, align : 'center', sortable:false},
			{ label: '핸드폰번호', index: 'mobile', name: 'mobile', width: 40, align : 'center', sortable:false},
			{ label: '팩스번호', index: 'fax', name: 'fax', width: 40, align : 'center', sortable:false },
			{ label: '이메일', index: 'email', name: 'email', width: 60, align : 'center', sortable:false},
			{ label: '참가여부', index: 'attendYnNm', name: 'attendYnNm', width: 30, align : 'center', sortable:false},
			{ label: 'key', index: 'empSeq', name: 'empSeq', hidden:true}
		],
		postData :{
			user_gb : "N",
			eventId : "${event.eventId}"
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#event_pager',
		viewrecords : true,
		sortname : "reg_dt",
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
			var ret = jQuery("#event_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "event_list");
		   return 'stop';
		},
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#totalCnt").val(data.records);
        },
		//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
		loadComplete : function(data) {
			showJqgridDataNon(data, "event_list",8);

		}
	});
	//jq grid 끝

	jQuery("#event_list").jqGrid('navGrid', '#event_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});

	bindWindowJqGridResize("event_list", "event_list_div");

	jQuery("#allchk").bind('click', function () {
		$(this).prop('checked',$(this).prop('checked')?false:true);
		$('input').prop('checked',$(this).prop("checked"));
	});

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	var str = $("#totalCnt").val()-(rowObject.rnum-1);
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	var str = "<a href=\"javascript:eventWrite('"+rowObject.applySeq+"')\">"+rowObject.managerNm+"</a>";
	return str;
}

function jsCheckFormmater(cellvalue, options, rowObject) {
	var str = "";
 	str ="<input type=\"checkbox\" name=\"sel\" value=\""+rowObject.empSeq+"\" />";
	return str;
}

function jsBtnFormmater(cellvalue, options, rowObject) {
	var str = "";
 	str ="<span class=\""+rowObject.eventStepCd+"\">"+rowObject.stepNm+"</span>";
	return str;
}

function search() {

	jQuery("#event_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectUserUrl,
		page : 1,
		postData : {
			user_gb : "N",
			eventId : "${param.eventId}"
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");

}

function eventWrite(applySeq) {
    var f = document.listFrm;
    var mode = "W";
    if(applySeq != "") mode = "E";

	$('#contents_area').html("");

	$("#mode").val(mode);
	$("#applySeq").val(applySeq);

    f.action = eventWriteUrl;
    f.submit();
}

function goeventList(){
	var f = document.listFrm;

	$("#mode").val("E");

    f.action = eventViewUrl;
    f.submit();
}

function formReset(){
	$("#p_reg_stadt").val("");
	$("#p_reg_enddt").val("");
	$("#p_searchtxt").val("");
}

function applyJoin(str){
	var ids = jQuery("#event_list").jqGrid('getGridParam','selarrrow'); //체크된 row id들을 배열로 반환
	var idsArr = (","+ids).split(",");
	var valueArr= [];
   for(var i=1; i<idsArr.length; i++){
        var rowObject = $("#event_list").getRowData(idsArr[i]); //체크된 id의 row 데이터 정보를 Object 형태로 반환
        valueArr[i-1] = rowObject.empSeq; //Obejcy key값이 name인 value값 반환

    }
   var value = valueArr.join();

	if (valueArr.length==0){alert('참여자 선택 후 진행하시기 바랍니다.');return;}
	var ment=null;
	if (str=='Y'){ment='[확인] 선택하신 신청자의 참가여부를 "참여"상태로 수정합니다\n[취소] 작업을 취소합니다 ';}else{ment='[확인] 선택하신 신청자의 참가여부를 "미참여"상태로 수정합니다\n[취소] 작업을 취소합니다 '}
	if(confirm(ment)){
		 $.ajax({
		        url: updateChangeJoin,
		        dataType: "html",
		        type: "post",
		        data: {
		           empSeq :	value,
		           applySeq : "${param.applySeq}",
		           eventId : "${event.eventId}",
		           attendYn : str
				},
		        success: function(data) {
		        	//$('#pop_content').html(data);
		        	//popupShow();
		        	//$(".onlynum").keyup( setNumberOnly );
		        	alert('정상 처리 되었습니다.');
		        	//$("[id^='parsley-id-multiple-menuCd']").attr("display","none");
		        	jQuery("#event_list").trigger("reloadGrid");
		        },
		        error: function(e) {
		            alert("참가여부 처리 실패하였습니다.");
		        }
		    });
	}else{
		alert(document.listFrm.sel.value);

		return;}

}

function pushKorcham(){
	if(confirm('[확인] 사업관리 연동을 시작 합니다\n[취소] 작업을 취소합니다')){
		 $.ajax({
		        url: updateChangeJoin,
		        dataType: "html",
		        type: "post",
		        data: {
		           empSeq :	value,
		           applySeq : "${param.applySeq}",
		           eventId : "${event.eventId}",
		           attendYn : str
				},
		        success: function(data) {
		        	//$('#pop_content').html(data);
		        	//popupShow();
		        	//$(".onlynum").keyup( setNumberOnly );
		        	alert('정상 처리 되었습니다.');
		        	//$("[id^='parsley-id-multiple-menuCd']").attr("display","none");
		        	jQuery("#event_list").trigger("reloadGrid");
		        },
		        error: function(e) {
		            alert("참가여부 처리 실패하였습니다.");
		        }
		    });
	}else{

		return;}
}

function sendEventData(){
	if(!confirm('[확인] 사업관리 연동을 시작 합니다\n[취소] 작업을 취소합니다')) return;
   $.ajax
	({
		type: "POST",
           url:  "/back/event/sendEventData.do",
           data:{
	        	projectId : $("#projectId").val(),
	        	projectSeq : $("#projectSeq").val(),
	        	chamCd : $("#projectCd").val()
           },
           dataType: 'json',
		success:function(data){
			alert("사업이 연동되었습니다.");
		}
	});

}


//excel로 출력
function exportExcel ( pFileName ) {
	var pGridObj = $('#event_list');
     var mya = pGridObj.getDataIDs();
     var data = pGridObj.getRowData(mya[0]);
     var colNames=new Array();
     var ii=0;
     for (var d in data){ colNames[ii++] = d; }

     //컬럼 헤더 가져오기
     var columnHeader = pGridObj.jqGrid('getGridParam','colNames') + '';
     var arrHeader = columnHeader.split(',');
     var html="<table border=1><tr>";
     for ( var y = 1; y < arrHeader.length; y++ ) {
          html = html + "<td><b>" + encodeURIComponent(arrHeader[y])  + "</b></td>";
     }


     html = html + "</tr>";

     //값 불러오기
     for(var i=0;i< mya.length;i++) {
          var datac= pGridObj.getRowData(mya[i]);
          html = html +"<tr>";
          for(var j=0; j< colNames.length;j++) html=html + '<td>' + encodeURIComponent(datac[colNames[j]])+"</td>";
          html = html+"</tr>";
     }


     html=html+"</table>";  // end of line at the end
     document.EXCEL_.csvBuffer.value = html;
     document.EXCEL_.fileName.value = encodeURIComponent(pFileName);
     document.EXCEL_.target='_blank';
     //document.EXCEL_.action = eventExcelUrl;
     document.EXCEL_.submit();
}

</script>
<form id="EXCEL_" name="EXCEL_" action="/excel/down_excel.jsp"  method="post">
     <input type="hidden" name="csvBuffer" id="csvBuffer" value="">
     <input type="hidden" name="fileName" id="fileName" value="">
</form>
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
	<input type='hidden' id="p_searchStatus" name='p_searchStatus' value="${param.p_searchStatus}" />
	<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="${param.p_searchtxt}" />
	<input type='hidden' id="p_reg_stadt" name='p_reg_stadt' value="${param.p_reg_stadt}" />
	<input type='hidden' id="totalCnt" name='totalCnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="eventId" name='eventId' value="${event.eventId}" />
	<input type='hidden' id="applySeq" name='applySeq' value="" />
    <input type='hidden' id="projectId" name = "projectId" value = "${event.projectId}" />
    <input type='hidden' id="projectSeq" name = "projectSeq" value = "${event.projectSeq}" />
    <input type='hidden' id="projectCd" name = "projectCd" value = "${event.projectCd}" />
	<input type='hidden' id="mode" name='mode' value="W" />
	<input type='hidden' id="applyMode" name='applyMode' value="E" />

		<!-- search_area -->
	<div class="search_area">
		 <table class="search_box">
			<caption>팝업검색</caption>
			<colgroup>
				<col style="width: 80%;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<tr>
				<td style="font-size:18px">
					<b><span id="eventTitle">${event.title}</span></b>
				</td>
				<td>
					<b>행사일 : <span id="eventDt">${event.seDt}</span></b>
				</td>
			</tr>
			<tr>
				<td>
					<b>담당부서 : <span id="deptNm">${event.deptNm}</span><c:if test="${event.managerNm != ''}">| 담당자 : <span id="managerNm">${event.managerNm}</span></c:if><c:if test="${event.tel != ''}"> / <span id="managerNm">${event.tel}</span></c:if></b>
				</td>
				<td>
				</td>
			</tr>
			</tbody>
		</table>

	</div>
	<!--// search_area -->

	<!-- table 1dan list -->
	<p>참가자명단</p>
	<div class="table_area" id="event_list_div" >
	    <table id="event_list"></table><br /><br />
	    <div class="table_search_area">
	    	<div class="float_left">
				<a href="javascript: applyJoin('Y');" class="btn acti" title="참여">
					<span>참여</span>
				</a>
				<a href="javascript: applyJoin('N');" class="btn acti" title="미참여">
					<span>미참여</span>
				</a>
			</div>
			<div class="float_right">
				<a href="javascript:exportExcel ( 'applyList.xls' );" class="btn acti" title="엑셀 다운로드">
					<span>엑셀 다운로드</span>
				</a>
				<a href="javascript: sendEventData();" class="btn acti" title="사업관리 연동">
					<span>사업관리 연동</span>
				</a>
				<a href="javascript:goeventList();" class="btn acti" title="이전화면">
					<span>이전화면</span>
				</a>
			</div>
		</div>
        <div id="event_pager"></div>
	</div>
	</form>
	<!--// table 1dan list -->
</div>
<!--// content -->
