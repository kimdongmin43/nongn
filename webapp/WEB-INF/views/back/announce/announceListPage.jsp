<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script>
var savedRow = null;
var savedCol = null;
var selectAnnounceUrl = "<c:url value='/back/announce/announcePageList.do'/>";
var announceWriteUrl =  "<c:url value='/back/announce/announceWrite.do'/>";

$(document).ready(function(){
		
	$('#announce_list').jqGrid({
		datatype: 'json',
		url: selectAnnounceUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 30, align : 'center', sortable:false, formatter:jsRownumFormmater },
			{ label: '코드', index: 'announc_id', name: 'announc_id', align : 'center', width:40, sortable:false, hidden:true },
			{ label: '회차/공고연도', index: 'title_btn', name: 'title_btn', align : 'center', width:60, sortable:false, formatter:jsTitleLinkFormmater },
			{ label: '회차', index: 'seq', name: 'seq', hidden:true },
			{ label: '공고연도', index: 'year', name: 'year', hidden:true },
			{ label: '운영기간', index: 'mng_dt', name: 'mng_dt', width: 140, align : 'center', sortable:false },
			{ label: '신청기간', index: 'aply_dt', name: 'aply_dt', width: 140, align : 'center', sortable:false },
			{ label: '심사기간', index: 'eval_dt', name: 'eval_dt', width: 140, align : 'center', sortable:false },
			{ label: '발표일', index: 'rel_dt', name: 'rel_dt', width: 70, align : 'center', sortable:false },
			{ label: '활동개월(차)', index: 'act_month', name: 'act_month', width: 50, align : 'center', sortable:false },
			{ label: '심사기준관리', index: 'act_btn', name: 'act_btn', width: 60, align : 'center', sortable:false , formatter:jsBtnLinkFormmater }
		],
		postData :{	
			year : $("#p_year").val(),
			open_yn : $("#p_open_yn").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#announce_pager',
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
			var ret = jQuery("#announce_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "announce_list");
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
			
			showJqgridDataNon(data, "announce_list",9);

		}
	});
	//jq grid 끝 
	
	jQuery("#announce_list").jqGrid('navGrid', '#announce_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("announce_list", "announce_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:announceWrite('"+rowObject.announc_id+"')\">"+rowObject.seq+"/"+rowObject.year+"</a>";
	
	return str;
}

function jsBtnLinkFormmater(cellvalue, options, rowObject) {

	var str = "";

 	str ="<a href=\"javascript:evalstdWrite('"+rowObject.announc_id+"')\" class=\"btn look\" title=\"심사기준관리\"><span>심사기준관리</span></a>";
		
	return str;
}
function search() {
		
	jQuery("#announce_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectAnnounceUrl,
		page : 1,
		postData : {
			year : $("#p_year").val(),
			open_yn : $("#p_open_yn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function announceWrite(announcId) {
    var f = document.listFrm;
    var mode = "W";
    if(announcId != "") mode = "E";
    
	$("#mode").val(mode);
	$("#announc_id").val(announcId);
	
    f.action = announceWriteUrl;
    f.submit();
  
}

function evalstdWrite(announcId){
	$("#announc_id").val(announcId);
	
    $.ajax({
        url: "/back/announce/evalstdWrite.do",
        dataType: "html",
        type: "post",
        data: {
        	announc_id : announcId
		},
        success: function(data) {
        	$('#pop_content').html(data);
        	$(".onlynum").keyup( setNumberOnly );
        	popupShow();
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

function formReset(){
	$("select[name=p_open_yn] option[value='']").attr("selected",true);
}

function popupShow(){
	$("#modal-evalstd-write").modal('show');
}

function popupClose(){
	$("#modal-evalstd-write").modal("hide");
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
	<input type='hidden' id="announc_id" name='announc_id' value="" />
	<input type='hidden' id="mode" name='mode' value="W" />
	
	<!-- search_area -->
	<div class="search_area">
		 <table class="search_box">
			<caption>공고검색</caption>
			<colgroup>
				<col style="width: 80px;" />
				<col style="width: 35%;" />
				<col style="width: 80px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<tr>
				<th>공고연도</th>
				<td>
                  <select id="p_year" name="p_year" class="form-control input-sm">
                      <option value="" >- 전체 -</option>
                      <c:forEach var="i" begin="0" end="5" >
                         <option value="${curYear-i}" <c:if test="${(curYear-i) == selYear}">selected</c:if>>${curYear-i}</option>
                     </c:forEach>
                  </select>
				</td>
				<th>공개여부</th>
				<td>
                  <select id="p_open_yn" name="p_open_yn" class="form-control input-sm">
                       <option value="">- 전체 -</option>
                       <option value="Y" <c:if test="${param.p_open_yn == 'Y'}">selected</c:if>>공개</option>
                       <option value="N" <c:if test="${param.p_open_yn == 'N'}">selected</c:if>>비공개</option>
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
	
	<!-- tabel_search_area -->
	<div class="table_search_area">
		<div class="float_right">
			<a href="javascript:announceWrite('')" class="btn acti" title="공고 등록">
				<span>공고등록</span>
			</a>
		</div>
	</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="announce_list_div" >
	    <table id="announce_list"></table>
        <div id="announce_pager"></div>
	</div>
	<!--// table 1dan list -->
</div>
<!--// content -->
</form>

     <div class="modal fade" id="modal-evalstd-write" >
		<div class="modal-dialog modal-size-normal">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title">심사기준</h1>
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
				    </div>
				</div>
			</article>	
			</div>
			<!-- //container -->			
		</div>
	</div>