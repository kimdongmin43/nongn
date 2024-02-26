<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%
      request.setAttribute("applyGb", "O");
%>
<script>
var savedRow = null;
var savedCol = null;
var selectOrientationUrl = "<c:url value='/back/apply/orientationPageList.do'/>";

$(document).ready(function(){
		
	$('#orientation_list').jqGrid({
		datatype: 'json',
		url: selectOrientationUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', formatter:jsRownumFormmater},
			{ label: '아이디', index: 'user_id', name: 'user_id', width: 80, align : 'center' },
			{ label: '이름', index: 'user_str', name: 'user_str', align : 'center', width:80, formatter:jsTitleLinkFormmater},
			{ label: '약관동의여부', index: 'agree_nm', name: 'agree_nm', align : 'center', width:80, formatter:jsResultLinkFormmater},
			{ label: '약관동의일', index: 'agree_dt', name: 'agree_dt', align : 'center', width:100},
			{ label: '관심분야', index: 'interstfield', name: 'interstfield', width: 200, align : 'left' },
			{ label: '전년도 수급여부', index: 'pre_snd_yn_nm', name: 'pre_snd_yn_nm', width: 80, align : 'center' },
			{ label: '신청id', index: 'aply_id', name: 'aply_id', hidden:true},
			{ label: '이름', index: 'user_nm', name: 'user_nm', hidden:true},
			{ label: '헨드폰', index: 'mobile', name: 'mobile',  hidden:true}
		],
		postData :{	
			year : $("#p_year").val(),
			seq : $("#p_seq").val(),
			agree_yn : $("#p_agree_yn").val(),
			pre_snd_yn : $("#p_pre_snd_yn").val(),
			interstfield : getField(),
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#orientation_pager',
		viewrecords : true,
		sortname : "user_nm",
		sortorder : "asc",
		height : "350px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit : false,
		multiselect: true,
		cellsubmit : 'clientArray',
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
		},
		onSelectRow : function(rowid, status, e) {
			var ret = jQuery("#orientation_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "orientation_list");
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
			
			showJqgridDataNon(data, "orientation_list",7);

		}
	});
	//jq grid 끝 
	
	jQuery("#orientation_list").jqGrid('navGrid', '#orientation_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("orientation_list", "orientation_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:applyWrite('S','"+rowObject.aply_id+"')\">"+rowObject.user_nm+"</a>";
	
	return str;
}

function jsResultLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "";
	
	if(rowObject.agree_yn == "C")
		str = "<a onmouseover=\"showFailPopup('"+rowObject.cancel_reason_nm+"')\" onmouseout='hideSubmitPopup()'>"+jsNvl(cellvalue)+"</a>";
	else
		str = jsNvl(cellvalue);
	
	return str;
}

function search() {
		
	jQuery("#orientation_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectOrientationUrl,
		page : 1,
		postData : {
			year : $("#p_year").val(),
			seq : $("#p_seq").val(),
			agree_yn : $("#p_agree_yn").val(),
			pre_snd_yn : $("#p_pre_snd_yn").val(),
			interstfield : getField(),
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

function orientationExcelDown(){
     var f = document.listFrm;
     $("#interstfield").val(getField());
     f.target = "hiddenFrame";
     f.action = "/back/apply/orientationExcelDown.do";
     f.submit();
     f.target = "";
}

function getField(){
   var chk = "";
   var cnt =0;
   $(":checkbox[name='p_field_cd']:checked").each(function(i,e){
       if(cnt > 0) chk += ",";
       chk += e.value;
       cnt++;
   });
   
   return chk;
}

function formReset(){
	$("select[name=p_agree_yn] option[value='']").attr("selected",true);
	$("select[name=p_pre_snd_yn] option[value='']").attr("selected",true);
	$("#p_searchtxt").val("");
	   $(":checkbox[name='p_field_cd']:checked").each(function(i,e){
	      e.checked = false;
	   });
}

function checkAll(idx){
	debugger;
	 if($("input:checkbox[id='field_cd_all_"+idx+"']").is(":checked") == true){
		   $(":checkbox[id^='field_cd_" + idx + "']").each(function(i,e){
			      e.checked = true;
			   });
	 }else{
		   $(":checkbox[id^='field_cd_" + idx + "']").each(function(i,e){
			      e.checked = false;
	        });
	 }
}

function agreeCancelPopup(){
	$("#evalFailTitle").html("동의취소 사유");
	 var s = jQuery("#orientation_list").jqGrid('getGridParam','selarrrow');

     if(s.length < 1){
     	alert("대상자를 선택해 주십시요.");
     	return;
     }
     
	evalPopupShow();
}

function updateEvalResult(gubun){
	 var cancelReason = $("#fail_reason").val();
	 var s = jQuery("#orientation_list").jqGrid('getGridParam','selarrrow');

     if(s.length < 1){
     	alert("대상자를 선택해 주십시요.");
     	return;
     }
     
  	var aplyRow = new Array();
 	var ret = null;
	for (var i = 0; i < s.length; i++) {
		ret = jQuery("#orientation_list").jqGrid('getRowData',s[i]);
   	    aplyRow.push(ret.aply_id);
    }    
	
     if(!confirm("선택한 대상자를 동의취소 하시겠습니까?")) return;
    	 
    $.ajax({
        url: "/back/apply/updateOrientationAgreeCancel.do",
        dataType: "json",
        type: "post",
        data: {
           cancel_reason : cancelReason,
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

function popupShow(){
	$('#modal-orientation-write').popup('show');
}

function popupClose(){
	$('#modal-orientation-write').popup('hide');
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
	<input type='hidden' id="interstfield" name='interstfield' value="" />
	
	<!-- search_area -->
	<div class="search_area">
		<table class="search_box">
			<caption>신청자 서류심사관리검색</caption>
			<colgroup>
				<col style="width: 110px;" />
				<col style="width: 20%;" />
				<col style="width: 100px;" />
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
                      <option value="" >- 전체 -</option>
                      <c:forEach var="i" begin="0" end="5" >
                         <option value="${curYear-i}" <c:if test="${(curYear-i) == selYear}">selected</c:if>>${curYear-i}</option>
                     </c:forEach>
                  </select>
				</td>
				<th>약관동의여부</th>
				<td>
					<g:select id="p_agree_yn" name="p_agree_yn" codeGroup="ORIENTATION_AGREE_YN" selected="${param.p_agree_yn}" titleCode="전체" showTitle="true" cls="form-control input-sm" />
				</td>
				<th>전년도 수급여부</th>
				<td>
					<g:select id="p_pre_snd_yn" name="p_pre_snd_yn" codeGroup="YES_NO" selected="${param.p_pre_snd_yn}" titleCode="전체" showTitle="true" cls="form-control input-sm" />
				</td>				
			</tr>
			<tr>
				<th>관심분야</th>
				<td colspan="5">
					<c:set var="preConcern" value="0"/>
					<c:forEach var="row" items="${concernList}" varStatus="status">
				    <c:if test="${fn:substring(row.code,0,1) != preConcern}">
				       <c:if test="${status.index > 0}"></br></c:if>
				       <c:choose>
					        <c:when test="${fn:substring(row.code,0,1) == '1'}">
					            진짜사회생활&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					       </c:when>
					        <c:when test="${fn:substring(row.code,0,1) == '2'}">
					            진짜 내일탐구&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					       </c:when>
					        <c:when test="${fn:substring(row.code,0,1) == '3'}">
					            정서상담 프로그램&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					       </c:when>
					        <c:when test="${fn:substring(row.code,0,1) == '4'}">
					            일상생활지원 프로그램
					       </c:when>
					    </c:choose>
					    <input type="checkbox" id="field_cd_all_${fn:substring(row.code,0,1)}"  onClick="checkAll('${fn:substring(row.code,0,1)}')"/>
						<label for="field_cd_all_${fn:substring(row.code,0,1)}">
							<span>전체</span>
						</label>|
					    <input type="checkbox" id="field_cd_${row.code}" name="p_field_cd" value="${row.code}" />
						<label for="field_cd_${row.code}">
							<span>${row.codenm}</span>
						</label>&nbsp;&nbsp;
					</c:if>
					<c:if test="${fn:substring(row.code,0,1) == preConcern}">
						<input type="checkbox" id="field_cd_${row.code}" name="p_field_cd" value="${row.code}" />
						<label for="field_cd_${row.code}">
							<span>${row.codenm}</span>
						</label>&nbsp;&nbsp;
					</c:if>
					<c:set var="preConcern" value="${fn:substring(row.code,0,1)}"/>
					</c:forEach>
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
			<a href="javascript:orientationExcelDown()" class="btn acti" title="엑셀다운로드">
				<span>엑셀다운로드</span>
			</a>
			<a href="javascript:smsWrite('orientation_list')" class="btn acti" title="SMS">
				<span>SMS</span>
			</a>
		</div>
		<div class="float_right">

		</div>
	</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="orientation_list_div" >
	    <table id="orientation_list"></table>
        <div id="orientation_pager"></div>
	</div>
	<!--// table 1dan list -->
	
		<!-- tabel_search_area -->
	<div class="table_search_area">
	   <div class="float_left">
		</div>
		<div class="float_right">
			<a href="javascript:agreeCancelPopup()" class="btn none" title="Fail">
				<span>동의취소</span>
			</a>			
		</div>
	</div>
	<!--// tabel_search_area -->	
	
</div>
<!--// content -->
</form>

<jsp:include page="/WEB-INF/views/back/apply/applyInclude.jsp"/>
		 		