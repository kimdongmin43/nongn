<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script>
var selectMenuSearchListUrl = "<c:url value='/back/menu/menuSearchList.do'/>";

var savedRow = null;
var savedCol = null;

$(document).ready(function(){

	$('#menu_list').jqGrid({
		datatype: 'json',
		url: selectMenuSearchListUrl,
		mtype: 'POST',
		colModel: [
	            { label: '선택', index: 'sel_box', name: 'sel_box', width: 40, align : 'center', sortable:false,formatter:jsRadioFormmater},
	            { label: '레벨', index: 'lvl', name: 'lvl', width: 40, align : 'center',sortable:false },

				{ label: '메뉴명', index: 'menuNm', name: 'menuNm', align : 'left', width:120,sortable:true},
				{ label: '경로', index: 'menuNavi', name: 'menuNavi', width: 250, align : 'left',sortable:true },
				{ label: '등록여부', index: 'refYn', name: 'refYn', align : 'center', width:50,sortable:false},
				{ label: 'refUrl', index: 'refUrl', name: 'refUrl', hidden:true},
				{ label: 'menuId', index: 'menuId', name: 'menuId',  hidden:true },
		],
		postData :{
			siteCd :"${param.siteCd}",
			mainMenuId:$("#mainMenuId").val()
		},
		viewrecords : true,
		height : "580px",
		width : "870",
		gridview : true,
		/* autowidth : true, */
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
			showJqgridDataNon(data, "menu_list",5);
		}
	});
	//jq grid 끝

});

function jsRadioFormmater(cellvalue, options, rowObject){
	return '<input type="radio" id="chk_menuId" name="chk_menuId" value="'+options.rowId+'")/>';
}


function selMenu(){
	var idx = $(':radio[name="chk_menuId"]:checked').val();
	if(idx == undefined) {
		alert("메뉴를 선택해 주십시요.");
		return;
	}
	var ret = jQuery("#menu_list").jqGrid('getRowData',idx);
	$("#refMenuId").val(ret.menuId);
	$("#refMenuNm").val(ret.menuNm);
	$("#refUrl").val(ret.refUrl);
	$("#refCd_F").find("input[name=url]").val(ret.refUrl);
	popupSearchClose();
}
function findText(txt){

	$("#refYn").val("");

	$("#menu_list").find("tr[role=row]").hide();
	$("#menu_list").find(".jqgfirstrow").show();
	$("#menu_list").find("tr td:nth-child(3):contains("+txt+")").closest("tr[role=row]").show();

	if(txt.length < 1){
		$("#menu_list").find("tr[role=row]").show();
	}
}
function findText2(txt){

	$("#findText").val("");

	$("#menu_list").find("tr[role=row]").hide();
	$("#menu_list").find(".jqgfirstrow").show();
	$("#menu_list").find("tr td:nth-child(5):contains("+txt+")").closest("tr[role=row]").show();

	if(txt.length < 1){
		$("#menu_list").find("tr[role=row]").show();
	}
}
</script>
		<!-- tabel_search_area -->
		<div class="table_search_area" style="margin-top:20px">
			<div class="float_left">
				<span class="inpbox"><input id="findText" name="findText" type="text" style="width: 150px" placeholder="찾기.." title="찾기.." onkeyup="findText(this.value);" />
					<select id="refYn" name="refYn"  onChange="findText2(this.value);">
                      	<option value="" >전체</option>
                      	<option value="N" >미등록</option>
                      	<option value="Y" >등록</option>
                  	</select>				
                  	</span>
                  	
		
             
			</div>
			
			<div class="float_right">
				<a href="javascript:selMenu();" class="btn acti" title="선택" style="margin-right:20px;">
					<span>선택</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->

		<div class="table_area" id="menu_list_div" >
		    <table id="menu_list"></table>
		</div>
