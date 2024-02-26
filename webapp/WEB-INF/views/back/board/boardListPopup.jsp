<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script>
var selectBoardSearchListUrl = "<c:url value='/back/board/menuBoardhList.do'/>";

var savedRow = null;
var savedCol = null;

$(document).ready(function(){

	$('#board_list').jqGrid({
		datatype: 'json',
		url: selectBoardSearchListUrl,
		mtype: 'POST',
		colModel: [
	               { label: '선택', index: 'sel_box', name: 'sel_box', width: 40, align : 'center', sortable:false,formatter:jsRadioFormmater},
				{ label: '제목', index: 'title', name: 'title', width: 200, align : 'left',sortable:false },
				{ label: '타입', index: 'boardCdNm', name: 'boardCdNm', width: 120, align : 'center',sortable:false },
				{ label: '등록자', index: 'regUserNm', name: 'regUserNm', align : 'center', width:80,sortable:false},
				{ label: '등록일', index: 'regDt2', name: 'regDt2', align : 'center', width:100,sortable:false},
				{ label: '경로', index: 'refUrl', name: 'refUrl', align : 'center', width:250,sortable:false},
				{ label: '등록여부', index: 'refYn', name: 'refYn', align : 'center', width:50,sortable:false},
				{ label: 'boardId', index: 'boardId', name: 'boardId', hidden:true}
		],
		postData :{

		},
		viewrecords : true,
		height : "580px",
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
			showJqgridDataNon(data, "board_list",4);
		}
	});
	//jq grid 끝

});

function jsRadioFormmater(cellvalue, options, rowObject){
	return '<input type="radio" id="chk_board_id" name="chk_board_id" value="'+options.rowId+'")/>';
}


function selBoard(){
	var idx = $(':radio[name="chk_board_id"]:checked').val();
	if(idx == undefined) {
		alert("게시판을 선택해 주십시요.");
		return;
	}
	var ret = jQuery("#board_list").jqGrid('getRowData',idx);
	$("#refBoardId").val(ret.boardId);
	$("#refBoardNm").val(ret.title);
	$("#menuNm").val(ret.title);
	$("#originMenuNm").val(ret.title);
	$("#refUrl").val(ret.refUrl);
	$("#refCd_B").find("input[name=url]").val($("#refUrl").val());
	popupSearchClose();
}

function findText(txt){


	$("#board_list").find("tr[role=row]").hide();
	$("#board_list").find(".jqgfirstrow").show();
	$("#board_list").find("tr td:nth-child(2):contains("+txt+")").closest("tr[role=row]").show();

	if(txt.length < 1){
		$("#board_list").find("tr[role=row]").show();
	}
}
function findText2(txt){

	$("#findText").val("");

	$("#board_list").find("tr[role=row]").hide();
	$("#board_list").find(".jqgfirstrow").show();
	$("#board_list").find("tr td:nth-child(7):contains("+txt+")").closest("tr[role=row]").show();

	if(txt.length < 1){
		$("#board_list").find("tr[role=row]").show();
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
				<a href="javascript:selBoard();" class="btn acti" title="선택" style="margin-right:20px;">
					<span>선택</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->

		<div class="table_area" id="board_list_div" >
		    <table id="board_list"></table>
		</div>
