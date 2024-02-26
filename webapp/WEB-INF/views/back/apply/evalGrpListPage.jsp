<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var savedRow = null;
var savedCol = null;
var selectEvalGrpUrl = "<c:url value='/back/apply/evalGrpPageList.do'/>";
var insertEvalGrpUrl = "<c:url value='/back/apply/insertEvalGrp.do'/>";
var updateEvalGrpUrl = "<c:url value='/back/apply/updateEvalGrp.do'/>"
var deleteEvalGrpUrl = "<c:url value='/back/apply/deleteEvalGrp.do'/>";

$(document).ready(function(){
	
	$('#evalgrp_list').jqGrid({
		datatype: 'json',
		url: selectEvalGrpUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', sortable:false, formatter:jsRownumFormmater},
			{ label: '회차/공고연도', index: 'title', name: 'title', width: 120, align : 'center', sortable:false, formatter:jsTitleLinkFormmater},
			{ label: '1차 Pass인원', index: 'first_pass_cnt', name: 'first_pass_cnt', align : 'center', width:150, sortable:false},
			{ label: '심사위원', index: 'judge_cnt', name: 'judge_cnt', align : 'center', width:150, sortable:false},
			{ label: '그룹 및 심사위원배정 관리', index: 'group_cnt', name: 'group_cnt', align : 'center', width:300, sortable:false, formatter:jsGrpmngFormmater},
			{ label: '상세관리', index: 'dtl_btn', name: 'dtl_btn', width: 100, align : 'center', sortable:false, formatter:jsBtnFormmater},
			{ label: '공고ID', index: 'announc_id', name: 'announc_id', hidden:true },
			{ label: '연도', index: 'year', name: 'year', hidden:true },
			{ label: '회차', index: 'seq', name: 'seq', hidden:true },
			{ label: '그룹관리여부', index: 'group_mod_yn', name: 'group_mod_yn', hidden:true }
		],
		postData :{	
			year : $("#p_year").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#evalgrp_pager',
		viewrecords : true,
		sortname : "year desc, seq",
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
			var ret = jQuery("#evalgrp_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "evalgrp_list");
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
			showJqgridDataNon(data, "evalgrp_list",6);
		}
	});
	//jq grid 끝 
	
	jQuery("#evalgrp_list").jqGrid('navGrid', '#evalgrp_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("evalgrp_list", "evalgrp_list_div");

	$('#judge_list').jqGrid({
		datatype: 'local',
		mtype: 'POST',
		colModel: [
			{ label: '그룹명', index: 'group_no', name: 'group_no', width: 60, align : 'center', sortable:false },
			{ label: '이름1', index: 'user_nm1', name: 'user_nm1', align : 'left', sortable:false, width:60},
			{ label: '휴대전화1', index: 'mobile1', name: 'mobile1', sortable:false, width:60},
			{ label: '이메일1', index: 'email1', name: 'email1', sortable:false, width:100},
			{ label: '이름2', index: 'user_nm2', name: 'user_nm2', align : 'left', sortable:false, width:60},
			{ label: '휴대전화2', index: 'mobile2', name: 'mobile2', sortable:false, width:60},
			{ label: '이메일2', index: 'email2', name: 'email2', sortable:false, width:100},
			{ label: '이름3', index: 'user_nm3', name: 'user_nm3', align : 'left', sortable:false, width:60},
			{ label: '휴대전화3', index: 'mobile3', name: 'mobile3', sortable:false, width:60},
			{ label: '이메일3', index: 'email3', name: 'email3', sortable:false, width:100},
			{ label: '결과', index: 'success', name: 'success', sortable:false, width:60},
			{ label: '오류', index: 'message', name: 'message', sortable:false, width:150}
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
		cellsubmit : 'clientArray'
	});
	
	
});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = rowObject.seq+"차 / "+rowObject.year+"년";
	
	return str;
}

function jsGrpmngFormmater(cellvalue, options, rowObject) {
	var str = "";
	str += rowObject.group_cnt
	if(rowObject.group_mod_yn == "Y")
 		str +=" <a href=\"javascript:evalMngPopup('"+rowObject.announc_id+"')\" class=\"btn look\" title=\"그룹관리\"><span>그룹관리</span></a>";
	
 	if(rowObject.group_cnt > 0)
 		str +=" <a href=\"javascript:evalJudgeSetPopup('"+rowObject.announc_id+"','"+rowObject.year+"','"+rowObject.seq+"')\" class=\"btn look\" title=\"심사위원배정\"><span>심사위원배정</span></a>";
	
 	return str;
}

function jsBtnFormmater(cellvalue, options, rowObject) {
	var str = "";
 	str ="<a href=\"javascript:evalSecondListPage('"+rowObject.year+"','"+rowObject.seq+"')\" class=\"btn look\" title=\"상세관리\"><span>상세관리</span></a>";
	return str;
}

function search() {
		
	jQuery("#evalgrp_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectEvalGrpUrl,
		page : 1,
		postData : {
			year : $("#p_year").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function evalMngPopup(announcId) {
	$("#announc_id").val(announcId);
	popupShow();
}

function evalgroupInsert(){
	if(!confirm("심사위원배정한 정보가 있을 시 삭제가 됩니다. 그룹을 생성하시겠습니까?")) return;
	
	var groupCnt = $("#group_cnt").val();
	
    $.ajax({
        url: insertEvalGrpUrl,
        dataType: "json",
        type: "post",
        data: {
           announc_id : $("#announc_id").val(),
  		   group_cnt : groupCnt
		},
        success: function(data) {
        	alert(data.message);
			if(data.success == "true"){
				 search();
				 popupClose();
			}	
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

function evalJudgeSetPopup(announcId, year, seq) {
	$("#announc_id").val(announcId);
	$("#judge_list_div").hide();
	$("#attached_file").val("");
	$("#pop_title").html(seq+"차 / "+year+"년");
	judgePopupShow();
}

function evaljudgeInsert(){
	
	if($("#attached_file").val() == ""){
		   alert("파일을 선택해 주십시요.");
		   return;
	}
	
	if (!$("#attached_file").val().toLowerCase().match(/\.(xls|xlsx)$/)){
	    alert("확장자가 xls,xlsx 파일만 업로드가 가능합니다.");
	    return;
	}  
	
	if(!confirm("심사위원을 일괄배정 하시겠습니까?")) return;
	
	$('#judge_list').jqGrid('clearGridData');
	
   // 데이터를 등록 처리해준다.
   $("#excelFrm").ajaxSubmit({
		success: function(responseText, statusText){
			alert(responseText.message);
			var list = responseText.list;
			for(var i =0; i < list.length;i++){
				$("#judge_list").addRowData(undefined, list[i]);
			}
			$("#judge_list_div").show();
		},
		dataType: "json", 				
        data: {
        	announc_id : $("#announc_id").val()
	 	},
		url: "/back/apply/insertEvaljudge.do"
    });	
}

function evalSecondListPage(year, seq) {
	 var param = "p_year="+year+"&p_seq="+seq;
	 goPage("e0d74c1492ca4ca9afea504394b65228", param);
}

function formReset(){
	$("#p_evalgrp_nm").val("");
}

function popupShow(){
	$('#modal-evalgrp-write').modal('show');
}

function popupClose(){
	$('#modal-evalgrp-write').modal('hide');
}

function judgePopupShow(){
	$('#modal-evaljudge-write').modal('show');
}

function judgePopupClose(){
	$('#modal-evaljudge-write').modal('hide');
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
	<input type='hidden' id="announc_id" name='announc_id' value="" />
	
	<!-- search_area -->
	<div class="search_area">
		 <table class="search_box">
			<caption>그룹및심사위원 검색</caption>
			<colgroup>
				<col style="width: 80px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<tr>
				<th>년도</th>
				<td>
                    <select id="p_year" name="p_year" class="form-control input-sm" onChange="changeYear()">
                      <option value="" >- 전체 -</option>
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
			<a href="javascript:formReset();" class="btn clear" title="초기화">
				<span>초기화</span>
			</a>
		</div>
	</div>
	<!--// search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="evalgrp_list_div" >
	    <table id="evalgrp_list"></table>
        <div id="evalgrp_pager"></div>
	</div>
	<!--// table 1dan list -->
</div>
<!--// content -->
</form>
 <div class="modal fade" id="modal-evalgrp-write" >
		<div class="modal-dialog modal-size-smaill">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title">그룹관리</h1>
				<a href="javascript:popupClose()" class="pop_close" title="페이지 닫기">
					<span>닫기</span>
				</a>
			</header>
			</div>
			<!-- //header -->
			<!-- container -->
			<div id="pop_container">
			<article>
				<div class="pop_content_area">
				    <div  id="pop_content" >
				         
				    <!-- write_basic -->
					<div class="table_area">
						<table class="write">
							<caption>그룹 등록화면</caption>
							<colgroup>
								<col style="width: 120px;" />
								<col style="width: *;" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">그룹수</th>
								<td>
						               <select class="in_wp80" id="group_cnt" name="group_cnt">
											 <c:forEach var="i" begin="1" end="20">
						                         <option value="${i}" >${i}</option>
						                     </c:forEach>
										</select>
								</td>
							</tr>		
							</tbody>
						</table>
					</div>
					<!--// write_basic -->
					<!-- footer --> 
					<div id="footer">
					<footer>
						<div class="button_area alignc">
							<a href="javascript:evalgroupInsert()" class="btn save" title="저장">
								<span>저장</span>
							</a>
						</div>
					</footer>
					</div>
					<!-- //footer -->
				         
				    </div>
				</div>
			</article>	
			</div>
			<!-- //container -->
		</div>
  </div>

 <div class="modal fade" id="modal-evaljudge-write" >
		<div class="modal-dialog modal-size-normal">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title">심사위원배정</h1>
				<a href="javascript:judgePopupClose()" class="pop_close" title="페이지 닫기">
					<span>닫기</span>
				</a>
			</header>
			</div>
			<!-- //header -->
			<!-- container -->
			<div id="pop_container">
			<article>
				<div class="pop_content_area">
				    <div  id="judge_pop_content" style="margin:10px">

<form id="excelFrm" name="excelFrm" method="post" data-parsley-validate="true" enctype="multipart/form-data">
					<!-- title_area -->
					<div class="title_area">
						<h2 class="pop_title">공고: <span id="pop_title" class="color_pointr">1회차 2017년</span></h2>
					</div>
					<!--// title_area -->
					<!-- table_area -->
					<div class="table_area">
						<table class="write">
							<caption>신청자 정보 등록 화면</caption>
							<colgroup>
								<col style="width: 150px;">
								<col style="width: *;">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">엑셀파일 선택<strong class="color_pointr">*</strong></th>
								<td>
									<label for="attached_file" class="hidden">파일 선택하기</label>
									<input id="attached_file" name="attached_file" type="file" class="in_wp400" />
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
									<span>6. 샘플파일을 참고하여 작성하여 주십시요. (<a href="/html/evalperson.xlsx" title="샘플파일다운로드">샘플파일다운</a>)</span>
								</li>
							</ul>
						</section>
					</div>
					<!--// information_area -->
					<!-- table_area -->
					<div class="table_area" id="judge_list_div" >
					    <table id="judge_list"></table>
					</div>
					<!--// table_area -->		
							
					<!-- button_area -->
					<div class="button_area">
						<div class="alignc">
							<a href="javascript:evaljudgeInsert();" class="btn save" title="저장하기">
								<span>저장</span>
							</a>
							<a href="javascript:judgePopupClose();" class="btn cancel" title="닫기">
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