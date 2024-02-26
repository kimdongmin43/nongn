<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script>
var selectIntropageSearchListUrl = "<c:url value='/back/contents/intropageSearchList.do'/>";

var savedRow = null;
var savedCol = null;

$(document).ready(function(){

	$('#intropage_list').jqGrid({
		datatype: 'json',
		url: selectIntropageSearchListUrl,
		mtype: 'POST',
		colModel: [
	               { label: '선택', index: 'sel_box', name: 'sel_box', width: 40, align : 'center', sortable:false,formatter:jsRadioFormmater},
				{ label: '제목', index: 'title', name: 'title', width: 120, align : 'left',sortable:false },
				{ label: '등록자', index: 'regUserNm', name: 'regUserNm', align : 'center', width:80,sortable:false},
				{ label: '등록일', index: 'regDt', name: 'regDt', align : 'center', width:100,sortable:false},
				{ label: '경로', index: 'refUrl', name: 'refUrl', align : 'left', width:250,sortable:false},
				{ label: '등록여부', index: 'refYn', name: 'refYn', align : 'center', width:50,sortable:false},				
				{ label: 'contId', index: 'contId', name: 'contId', hidden:true}
		],
		postData :{

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
			showJqgridDataNon(data, "intropage_list",4);
		}
	});
	//jq grid 끝

});

function jsRadioFormmater(cellvalue, options, rowObject){
	return '<input type="radio" id="chk_intropage_id" name="chk_intropage_id" value="'+options.rowId+'")/>';
}
 

function selIntropage(){
	var idx = $(':radio[name="chk_intropage_id"]:checked').val();
	if(idx == undefined) {
		alert("콘텐츠를 선택해 주십시요.");
		return;
	}
	var ret = jQuery("#intropage_list").jqGrid('getRowData',idx);
	$("#refContId").val(ret.contId);
	$("#refContNm").val(ret.title);
	$("#menuNm").val(ret.title);
	$("#originMenuNm").val(ret.title);
	$("#refUrl").val(ret.refUrl);
	$("#refCd_C").find("input[name=url]").val($("#refUrl").val());
	popupSearchClose();
}

function findText(txt){


	$("#intropage_list").find("tr[role=row]").hide();
	$("#intropage_list").find(".jqgfirstrow").show();
	$("#intropage_list").find("tr td:nth-child(2):contains("+txt+")").closest("tr[role=row]").show();

	if(txt.length < 1){
		$("#intropage_list").find("tr[role=row]").show();
	}
}
function findText2(txt){

	$("#findText").val("");

	$("#intropage_list").find("tr[role=row]").hide();
	$("#intropage_list").find(".jqgfirstrow").show();
	$("#intropage_list").find("tr td:nth-child(6):contains("+txt+")").closest("tr[role=row]").show();

	if(txt.length < 1){
		$("#intropage_list").find("tr[role=row]").show();
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
				<a href="javascript:selIntropage();" class="btn acti" title="선택" style="margin-right:20px;">
					<span>선택</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->

		<div class="table_area" id="intropage_list_div" >
		    <table id="intropage_list"></table>
		</div>
