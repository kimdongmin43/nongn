<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var savedRow = null;
var savedCol = null;
var selectMemberUrl = "<c:url value='/back/member/memberList.do'/>";
var memberpageWriteUrl =  "<c:url value='/back/member/memberpageWrite.do'/>";

$(document).ready(function(){


	$('#memberpage_list').jqGrid({
		datatype: 'json',
		url: selectMemberUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', formatter:jsRownumFormmater},
			{ label: '이름', index: 'memberNm', name: 'memberNm', align : 'left', width:100 , formatter:jsTitleLinkFormmater},			
			{ label: '등록일', index: 'regDt', name: 'regDt', width: 60, align : 'center', sortable:false},			
			{ label: '사용여부', index: 'useYn', name: 'useYn', width: 60, align : 'center' , formatter:jsTitleFormmater }
		],
		postData :{
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val()			
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#memberpage_pager',
		viewrecords : true,
		sortname : "upd_dt",
		sortorder : "desc",
		height : "450px",
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
			var ret = jQuery("#memberpage_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "memberpage_list");
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

			showJqgridDataNon(data, "memberpage_list",7);

		}
	});
	//jq grid 끝

	jQuery("#memberpage_list").jqGrid('navGrid', '#memberpage_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});

	bindWindowJqGridResize("memberpage_list", "memberpage_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {

	var str = $("#total_cnt").val()-(rowObject.rnum-1);

	return str;
}

function jsTitleFormmater(cellvalue, options, rowObject) {
  var str = "";
  str = rowObject.useYn=="Y"?"사용":"사용중지";
  return str;

}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {

	var str = "<a href=\"javascript:memberPageWrite('"+rowObject.memberId+"')\">"+rowObject.memberNm+"</a>";

	return str;
}
function jsgetImgFormmater (cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.fileId !=null){
		str = "<img src='/images/back/icon/icon_file.png'>";/* <a href='"+rowObject.filePath+ "' target='_blank'> */
	}
	return str;
}


function search() {

	jQuery("#memberpage_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectMemberUrl,
		page : 1,
		postData : {
			searchKey : $("#p_searchkey").val(),
			searchTxt : $("#p_searchTxt").val()

		},
		mtype : "POST"
	}

	).trigger("reloadGrid");

}

function memberPageWrite(memberId) {
    var f = document.listFrm;
    var mode = "W";
    if(memberId != "") mode = "E";

	$("#mode").val(mode);
	$("#memberId").val(memberId);
    f.action = memberpageWriteUrl;
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
	<input type='hidden' id="memberId" name='memberId' value="" />
	<input type='hidden' id="mode" name='mode' value="W" />

	<!-- search_area -->
	<div class="search_area">
		 <table class="search_box">
			<caption>코드구분검색</caption>
			<colgroup>
				<col style="width: 80px;" />
				<%-- <col style="width: 40%;" /> --%>
				<%-- <col style="width: 80px;" /> --%>
				<%-- <col style="width: *;" /> --%>
			</colgroup>
			<tbody>
			<tr>
				<th>
					<label for="p_searchkey">검색조건</label>
				</th>
				<td>

                  <select id="p_searchkey" name="p_searchkey" class="form-control input-sm">
                       <option value="" >전체</option>
                       <option value="E" >사용</option>                       
                       <option value="A" >사용중지</option>
                  </select>
                  
                  <%-- <label for="p_searchTxt" class="hidden">검색어 입력</label>
                  <input type="text" class="in_wp200" id="p_searchTxt" name="p_searchTxt" value="<c:out value="${param.p_searchTxt}" escapeXml="true" />"  placeholder="" onkeypress="if(event.keyCode==13) {search(); return false;}"> --%>
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

	<!-- tabel_search_area -->
	<div class="table_search_area">
		<div class="float_right">
			<a href="javascript:memberPageWrite('')" class="btn acti" title="등록">
				<span>등록</span>
			</a>
			</div>
		</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="memberpage_list_div" >
	    <table id="memberpage_list"></table>
        <div id="memberpage_pager"></div>
	</div>
	<!--// table 1dan list -->
<!--// content -->
		</form>
	</div>
