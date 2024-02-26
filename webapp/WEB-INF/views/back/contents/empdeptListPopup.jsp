<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<style>
.ui-jqgrid #sort_list2 tr.jqgrow td { height: 24px; padding-top: 0px;}
</style>
<script>
var selectMenuSearchListUrl = "<c:url value='/back/menu/menuSearchList.do'/>";
var selectEmpDeptListUrl = "<c:url value='/back/contents/empDeptList.do'/>";
var boardContentsReorderNotiUrl = "<c:url value='/back/board/updateBoardContentsReorderNoti.do'/>";
var empDeptReorderNotiUrl = "<c:url value='/back/contents/updateDeptReorder.do'/>";
var deptInsertpageUrl = "<c:url value='/back/contents/empDeptInsertpage.do'/>";



var savedRow = null;
var savedCol = null;

$(document).ready(function(){
	
	$('#sort_list2').jqGrid({
		datatype: 'json',
		url: selectEmpDeptListUrl,
		mtype: 'POST',
		colModel: [
				{ label: '번호', index: 'sort', name: 'sort', width: 140, align : 'center' , sortable:false, editable:true,editoptions:{dataInit: function(element) {
					$(element).keyup(function(){
						chkNumber(element);
					});
				}}  },
				{ label: '업무명', index: 'deptNm', name: 'deptNm', align : 'left', width:420,height:100,sortable:false,formatter:jsTitleLinkFormmater},
				{ label: '업무아이디', index: 'deptId', name: 'deptId', align : 'left', width:0,sortable:false, hidden:true}
			
		],
		viewrecords : true,
		sortname : "sort",
		sortorder : "asc",		
		height : "280px",
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
			showJqgridDataNon(data, "sort_list",4);
		}
	});
	
	//jq grid 끝 

});

function jsRadioFormmater(cellvalue, options, rowObject){
		
	return '<input type="radio" id="chk_menu_id" name="chk_menu_id" value="'+options.rowId+'")/>';
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:deptInsert('"+rowObject.deptId+"')\">"+rowObject.deptNm+"</a>";
	
	return str;
}

function popupShow3(){
	$('#modal-boardreorder-list3').modal('show');
}

function popupClose3(){
	$('#modal-boardreorder-list3').modal("hide");	
}


</script>

<div class="search_area">
		 <table class="search_box">
			<caption>코드구분검색</caption>			
			<tbody>
			<tr>
				<th style="width: 40px">업무명</th>
				<td>          
                  <input type="text" class="in_wp200" id="p_searchtxt2" name="p_searchtxt2" value=""  placeholder="">
				</td>
				<td>
					<button  class="btn sch" title="조회" onclick="search2();">
						<span>조회</span>
					</button>
				</td>
					
				</tr>
			</tbody>
		</table>
		<div class="search_area_btnarea">			
			<a href="javascript:deptInsert('W');" class="btn sch" title="등록">
				<span>등록</span>
			</a>
		</div>
	</div>
		<div class="table_area" id="sort_list_div" >
		<input type='hidden' id="board_id" name='board_id' value="${param.board_id }" />
		    <table id="sort_list2"></table>
		</div>
		
		<!-- tabel_search_area -->
		<div class="table_search_area" style="margin-top:20px">
			<div class="float_right">
				<a href="javascript:deptReorder();" class="btn save" title="저장" style="margin-right:20px;">
					<span>번호저장</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->
		
		
		
	

