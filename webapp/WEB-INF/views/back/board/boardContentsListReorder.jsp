<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script>
var selectMenuSearchListUrl = "<c:url value='/back/menu/menuSearchList.do'/>";
var selectBoardContentsPageListUrl = "<c:url value='/back/board/selectBoardContentsPageList.do'/>";
var boardContentsReorderNotiUrl = "<c:url value='/back/board/updateBoardContentsReorderNoti.do'/>";

var savedRow = null;
var savedCol = null;

$(document).ready(function(){
	
	$('#sort_list').jqGrid({
		datatype: 'json',
		url: selectBoardContentsPageListUrl,
		mtype: 'POST',
		colModel: [
				{ label: '번호', index: 'notiSeq', name: 'notiSeq', width: 140, align : 'center' , sortable:false, editable:true,editoptions:{dataInit: function(element) {
					$(element).keyup(function(){
						chkNumber(element);
					});
				}}  },
	            //{ label: '선택', index: 'sel_box', name: 'sel_box', width: 40, align : 'center', sortable:false,formatter:jsRadioFormmater},      
				//{ label: '메뉴코드', index: 'menu_id', name: 'menu_id', width: 150, align : 'center',sortable:false },
				{ label: '제목', index: 'title', name: 'title', align : 'left', width:420,sortable:false},
				{ label: '콘텐츠아이디', index: 'contId', name: 'contId', align : 'left', width:0,sortable:false, hidden:true}
				//{ label: '형태', index: 'menu_type_nm', name: 'menu_type_nm', align : 'center', width:100,sortable:false}
		],
		postData :{	
			boardId : $("#boardId").val(),
			notiYn : 'Y',
			defaulttype : $("#defaulttype").val()
		},
		viewrecords : true,
		sortname : "noti_yn DESC, noti_seq DESC, restep_seq",
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

function contentsReorder(){
	var updateRow = new Array();
	var saveCnt = 0;
	jQuery('#sort_list').jqGrid('saveCell', savedRow, savedCol);
	
	var arrrows = $('#sort_list').getRowData();
	if(arrrows != undefined && arrrows.length > 0)
		for(var i=0;i<arrrows.length;i++){
			//필수값 체크
			if(arrrows.length>0){
				if(arrrows[i].notiSeq == '' || arrrows[i].notiSeq == null){
					alert("번호는 필수값입니다. 확인후 다시입력해주세요");
					return;
				}
			}
			//arrrows[i].menu_nm="";
			updateRow[saveCnt++] = arrrows[i];
		}
	else {
		alert("번호를 저장할 게시물이 없습니다.");
		return;
	}
	$.ajax
	({
		type: "POST",
           url: boardContentsReorderNotiUrl,
           data:{
            sort_list : JSON.stringify(updateRow)
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				$("#searchYn").val("Y");
				search();
				popupCloseReorder();
			}	
		}
	});
}

</script>
		

		<div class="table_area" id="sort_list_div" >
		<input type='hidden' id="boardId" name='boardId' value="${param.boardId }" />
		    <table id="sort_list"></table>
		</div>
		
		<!-- tabel_search_area -->
		<div class="table_search_area" style="margin-top:20px">
			<div class="float_right">
				<a href="javascript:contentsReorder();" class="btn save" title="저장" style="margin-right:20px;">
					<span>번호저장</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->