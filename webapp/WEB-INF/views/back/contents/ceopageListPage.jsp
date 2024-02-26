<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script src="/assets/jstree/dist/jstree.js"></script>

<style>
.ui-jqgrid tr.jqgrow td { height: 120px; padding-top: 0px;}
</style>
<script>
var savedRow = null;
var savedCol = null;
var selectLocationpageUrl = "<c:url value='/back/contents/ceopagePageList.do'/>";
var ceopageWriteUrl =  "<c:url value='/back/contents/ceopageWrite.do'/>";
var ceopageEdtUrl = "<c:url value='/back/contents/ceopageEdit.do'/>";
var sortUpdateUrl = "<c:url value='/back/contents/updateceoReorder.do'/>";
																	 

/* 
//resize시 grid width 재설정
$(window).bind("resize", function() {
	
   var tmpWidth = $("#content").width();
   $('#ceopage_list').jqGrid("setGridWidth", tmpWidth-5);
});    */


$(document).ready(function(){
	
	$('#ceopage_list').jqGrid({
		datatype: 'json',
		url: selectLocationpageUrl,
		mtype: 'POST',
		colModel: [
			{label: '번호', index: 'sort', name: 'sort', width: 5, align : 'center' , sortable:false, editable:true,editoptions:{dataInit: function(element) {
						$(element).keyup(function(){
							chkNumber(element);
						});
					}}  },						
			{ label: '사진', index: 'attachId', name: 'attachId', width: 110, align : 'center',fixed:true, sortable:false , formatter:jsgetImgFormmater },
			{ label: '회장명', index: 'ceoNm', name: 'ceoNm', align : 'center', width:15, formatter:jsTitleLinkFormmater},
			{ label: '기수', index: 'stageDesc', name: 'stageDesc', width: 20,  align : 'center', sortable:false },
			{ label: '임기', index: 'sedate', name: 'sedate', width: 20, align : 'center', sortable:false },
			{ label: '회장아이디', index: 'ceoId', name: 'ceoId', align : 'left', width:0,sortable:false, hidden:true}
		],
		viewrecords : true,		
		sortname : "sort",
		rowNum:-1, 
		sortorder : "asc",
		height : "100%",
		width : "1000",
		gridview : true,
		/* autowidth : true, */
		forceFit : true,
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
			
			showJqgridDataNon(data, "ceopage_list",4);
		}
	});
	$("#ceopage_list").jqGrid('setFrozenColumns');
	
	//jq grid 끝 


});

function jsgetImgFormmater (cellvalue, options, rowObject) {	
	var absoluteUrl = '${pageContext.request.scheme}' + '://' + '${pageContext.request.serverName}' + ':' + '${pageContext.request.serverPort}';
	var str =  "<img src='"
	+absoluteUrl+rowObject.filePath
	+"' alt='사진없음' class='info_img' style = 'width:100%;height:100%;'  />";
	return str;
}
function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
		
	var str = "<a href=\"javascript:ceopageEdit('"+rowObject.ceoId+"')\">"+rowObject.ceoNm+"</a>";
	
	return str;
}

function jsUseynLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "사용";
	
	if(cellvalue == "N") str = "미사용";
	
	return str;
}

function search() {		
	
	jQuery("#ceopage_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectLocationpageUrl,
		page : 1,
		postData : {
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val(),
			satis_yn : $("#p_satis_yn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function ceopageEdit(ceoId) {
	
	var url = null;
	url = ceopageEdtUrl;
	var f = document.listFrm;	
	$("#ceoId").val(ceoId);	
    f.action = url;
    f.submit();
  
}

function ceopageWrite() {
	
	var url = ceopageWriteUrl;
	var f = document.listFrm;		
    f.action = url;
    f.submit();
  
}

function formReset(){
	$("#p_searchtxt").val("");	
}

function contentsReorder(){
	
	var dataArray = new Array();
	var data = new Object();
	jQuery('#ceopage_list').jqGrid('saveCell', savedRow, savedCol);
	var arrrows = $('#ceopage_list').getRowData();
	if(arrrows != undefined && arrrows.length > 0)
		for(var i=0;i<arrrows.length;i++){
			//필수값 체크
			if(arrrows.length>0){
				if(arrrows[i].sort == '' || arrrows[i].sort == null){
					alert("번호는 필수값입니다. 확인후 다시입력해주세요");
					return;
				}
			}
			//arrrows[i].menu_nm="";
			var temp =  new Object();
			 temp.sort= arrrows[i].sort;
			 temp.ceoId=arrrows[i].ceoId;
			 dataArray.push(temp);
		}
	else {
		alert("번호를 저장할 목록이 없습니다.");
		return;
	}
	 data.data = JSON.stringify(dataArray) ;

	
	$.ajax
	({
		type: "POST",
           url: sortUpdateUrl,
           data:data,            
           	dataType: 'json',
			success:function(data){
			alert(data.message);
			if(data.success == "true"){
				location.reload();				
			}	
		}
	});
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
	<input type='hidden' id="ceoId" name='ceoId'/>
	
	<!-- tabel_search_area -->
	<div class="table_search_area">
		
		
	</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div>
	<div class="information_area" style="width: 960px">
				- 번호를 클릭하여 숫자를 입력한 후, "번호저장" 버튼을 누르면 적용됩니다. (작은 숫자가 우선표시됨)
		</div>
	<div style="padding-bottom: 10px; padding-left: 875px">
					<a href="javascript:contentsReorder()" class="btn acti" title="번호저장">
						<span>번호저장</span>
					</a>
			        <a href="javascript:ceopageWrite()" class="btn acti" title="등록">
			        	<span>등록</span>					
			        </a>
	</div>
	<div class="table_area" id="ceopage_list_div" >
	
	    <table id="ceopage_list"></table>
        <div id="ceopage_pager"></div>
	</div>
	</div>
	<!--// table 1dan list -->
<!--// content -->
</form>
</div>
