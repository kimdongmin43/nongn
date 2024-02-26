<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>


<style>
.ui-jqgrid tr.jqgrow td { height: 120px; padding-top: 0px;}
</style>

<script>
var savedRow = null;
var savedCol = null;
var selectLocationpageUrl = "<c:url value='/back/contents/emppagePageList.do'/>";

var emppageWriteUrl =  "<c:url value='/back/contents/emppageWrite.do'/>";
var sortUpdateUrl = "<c:url value='/back/contents/empReorderUpdate.do'/>";
var empRankWriteUrl = "<c:url value='/back/contents/emprankWrite.do'/>";
var empDeptWriteUrl = "<c:url value='/back/contents/empdeptWrite.do'/>";
/* 
//resize시 grid width 재설정
$(window).bind("resize", function() {
	
   var tmpWidth = $("#content").width();
   $('#emppage_list').jqGrid("setGridWidth", tmpWidth-5);
});   
 */
$(document).ready(function(){
	
	$('#emppage_list').jqGrid({
		datatype: 'json',
		url: selectLocationpageUrl,
		mtype: 'POST',
		colModel: [
			{label: '번호', index: 'sort', name: 'sort', width: 5, align : 'center' , sortable:false, editable:true,editoptions:{dataInit: function(element) {
						$(element).keyup(function(){
							chkNumber(element);
						});
					}}  },	
			{ label: '업무', index: 'deptNm', name: 'deptNm', width: 10,  align : 'center', sortable:false },
			{ label: '사진', index: 'attachId', name: 'attachId', width: 110, fixed:true, align : 'center', sortable:false , formatter:jsgetImgFormmater },
			{ label: '직위', index: 'rankNm', name: 'rankNm', width: 20,  align : 'center', sortable:false },
			{ label: '임직원명', index: 'empNm', name: 'empNm', align : 'center', width:50, formatter:jsTitleLinkFormmater},
			{ label: '임직원아이디', index: 'empId', name: 'empId', align : 'left', width:0,sortable:false, hidden:true}
			
		],
		viewrecords : true,
		sortname : "sort",
		sortorder : "asc",
		height : "100%",
		width : "1000",
		rowNum:-1,
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
			showJqgridDataNon(data, "emppage_list",4);
		}
	});
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
		
	var str = "<a href=\"javascript:emppageEdit('"+rowObject.empId+"')\">"+rowObject.empNm+"</a>";
	
	return str;
}

function jsUseynLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "사용";
	
	if(cellvalue == "N") str = "미사용";
	
	return str;
}

function search() {		
	
	jQuery("#emppage_list").jqGrid('setGridParam', {
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

function emppageEdit(empId) {
	
	var url = null;
	url = "<c:url value='/back/contents/emppageEdit.do'/>";
	var f = document.listFrm;	
	$("#empId").val(empId);	
    f.action = url;
    f.submit();
  
}

function emppageWrite() {
	
	var url = emppageWriteUrl;
	var f = document.listFrm;		
    f.action = url;
    f.submit();
  
}

function formReset(){
	$("#p_searchtxt").val("");
	$("select[name=p_satis_yn] option[value='']").attr("selected",true);
}


function empReorder(){
	
	var dataArray = new Array();
	var data = new Object();
	jQuery('#emppage_list').jqGrid('saveCell', savedRow, savedCol);
	var arrrows = $('#emppage_list').getRowData();
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
			 temp.empId=arrrows[i].empId;
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

function deptList()	{
	
	 var title = "";
		var url = "";
		 title = "업무관리"; 
		$('#pop_dept').html("");
		
$('#deptpop_title').html(title);
 $.ajax({
   	url: empDeptWriteUrl,
   	dataType: "html",
   	type: "post",
   	
   success: function(data) {
   	
   	$('#pop_dept').html(data);
   	popupShow3();
   	
   },
   error: function(e) {
       alert("테이블을 가져오는데 실패하였습니다.");
   }
}); 


}	
	
function rankList()	{
	 var title = "";
		var url = "";
		 title = "직위관리"; 
		$('#pop_boardreorder').html("");
		
$('#boardreorder_title').html(title);
	$.ajax({
    	url: empRankWriteUrl,
    	dataType: "html",
    	type: "post",
    	
    success: function(data) {
    	
    	$('#pop_boardreorder').html(data);
    	popupShow();
    	
    	
    },
    error: function(e) {
        alert("테이블을 가져오는데 실패하였습니다.");
    }
});

}
//상단공지번호관리 팝업 열기
function popupShow(){
	$('#modal-boardreorder-list').modal('show');
}
//상단공지번호관리 팝업 닫기
function popupClose(){
	$('#modal-boardreorder-list').modal("hide");
}
	


function rankReorder(){
	var dataArray = new Array();
	var data = new Object();
		
	jQuery('#sort_list').jqGrid('saveCell', savedRow, savedCol);
	
	var arrrows = $('#sort_list').getRowData();
	
	if(arrrows != undefined && arrrows.length > 0)
		for(var i=0;i<arrrows.length;i++){
			//필수값 체크
			if(arrrows.length>0){
				if(arrrows[i].sort == '' || arrrows[i].sort == null){
					alert("번호는 필수값입니다. 확인후 다시입력해주세요");
					return;
				}
			}
			var temp =  new Object();
			 temp.sort= arrrows[i].sort;
			 temp.rankId=arrrows[i].rankId;
			 dataArray.push(temp);
		}	 
	else {
		alert("번호를 저장할 게시물이 없습니다.");
		return;
	}
	data.data = JSON.stringify(dataArray) ;
	
	$.ajax
	({
		type: "POST",
           url: empRankReorderNotiUrl,
           data:data,
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				search();
				popupClose();
			}	
		}
	});
}

function deptReorder(){
	var dataArray = new Array();
	var data = new Object();
		
	jQuery('#sort_list2').jqGrid('saveCell', savedRow, savedCol);
	
	var arrrows = $('#sort_list2').getRowData();
	
	if(arrrows != undefined && arrrows.length > 0)
		for(var i=0;i<arrrows.length;i++){
			//필수값 체크
			if(arrrows.length>0){
				if(arrrows[i].sort == '' || arrrows[i].sort == null){
					alert("번호는 필수값입니다. 확인후 다시입력해주세요");
					return;
				}
			}
			var temp =  new Object();
			 temp.sort= arrrows[i].sort;
			 temp.deptId=arrrows[i].deptId;
			 dataArray.push(temp);
		}	 
	else {
		alert("번호를 저장할 게시물이 없습니다.");
		return;
	}
	data.data = JSON.stringify(dataArray) ;
	
	$.ajax
	({
		type: "POST",
           url: empDeptReorderNotiUrl,
           data:data,
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				search2();
				popupClose2();
			}	
		}
	});
}
function popupShow2(){
	$('#modal-boardreorder-list2').modal('show');
}

function popupClose2(){
	$('#modal-boardreorder-list2').modal("hide");	
}

function popupShow4(){
	$('#modal-boardreorder-list4').modal('show');
}

function popupClose4(){
	$('#modal-boardreorder-list4').modal("hide");	
}




function search() {		
	
	jQuery("#sort_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectEmpRankListUrl,
		page : 1,
		postData : {
			searchtxt : $("#p_searchtxt").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}
function search2() {		
	
	
	jQuery("#sort_list2").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectEmpDeptListUrl,
		page : 1,
		postData : {
			searchtxt : $("#p_searchtxt2").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}


function rankInsert(rankId){
	var data = new Object();
	data.rankId = rankId;
	
	  var title = "";
		var url = "";
		 title = "직위관리"; 
		$('#pop_rank').html("");		
		$('#rankpop_title').html(title);
	$.ajax({
 	url: rankInsertpageUrl,
 	dataType: "html",
 	type: "post",
 	data : data,
 	
 success: function(data) {	 
 	$('#pop_rank').html(data); 	
 	popupShow2(); 	
 },
 error: function(e) {
     alert("테이블을 가져오는데 실패하였습니다.");
 }
}); 

}


function deptInsert(deptId){
	var data = new Object();
	data.deptId = deptId;
	
	  var title = "";
		var url = "";
		 title = "직위관리"; 
		$('#pop_rank2').html("");		
		$('#rankpop_title2').html(title);		
		
	$.ajax({
 	url: deptInsertpageUrl,
 	dataType: "html",
 	type: "post",
 	data : data,
 	
 success: function(data) {
	 
	
 	$('#pop_rank2').html(data); 	
 	popupShow4(); 	
 },
 error: function(e) {
     alert("테이블을 가져오는데 실패하였습니다.");
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
	<input type='hidden' id="contId" name='contId'/>
	<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
	<input type='hidden' id="empId" name='empId'/>
	
	
	
	<!-- tabel_search_area -->
	<div class="table_search_area">
		<div class="information_area" style="width: 960px">
				- 번호를 클릭하여 숫자를 입력한 후, "번호저장" 버튼을 누르면 적용됩니다. (작은 숫자가 우선표시됨)
		</div>
		<div style="padding-bottom: 10px; padding-left: 705px">
					<a href="javascript:deptList()" class="btn acti" title="담당업무 관리">
						<span>담당업무관리</span>
					</a>
					<a href="javascript:rankList()" class="btn acti" title="직위관리">
						<span>직위관리</span>
					</a>
					<a href="javascript:empReorder()" class="btn acti" title="번호저장">
						<span>번호저장</span>
					</a>
			        <a href="javascript:emppageWrite('W')" class="btn acti" title="등록">
			        	<span>등록</span>					
			        </a>
		</div>
	</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="emppage_list_div" >
	    <table id="emppage_list"></table>
        <div id="emppage_pager"></div>
	</div>
	<!--// table 1dan list -->
	</form>
</div>

<!--// content -->
<div class="modal fade" id="modal-boardreorder-list" >
	<div class="modal-dialog modal-size-small">
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 id="boardreorder_title" class="pop_title">직위관리</h1>
			<a href="javascript:popupClose()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area" style="text-align:center">
			    <div  id="pop_boardreorder"  style="margin:10px;">
			    </div>
			</div>
		</article>	
		</div>
		<!-- //container -->			
	</div>
</div>



<div class="modal fade" id="modal-boardreorder-list2" >
	<div class="modal-dialog modal-size-small" style="width: 400px">
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 id="rankpop_title" class="pop_title">직위관리</h1>
			<a href="javascript:popupClose2()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area" style="text-align:center">
			    <div  id="pop_rank"  style="margin:10px;">
			   
			    </div>
			</div>
		</article>	
		</div>
		<!-- //container -->			
	</div>
</div>



<div class="modal fade" id="modal-boardreorder-list3" >
	<div class="modal-dialog modal-size-small">
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 id="deptpop_title" class="pop_title">업무관리</h1>
			<a href="javascript:popupClose3()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area" style="text-align:center">
			    <div  id="pop_dept"  style="margin:10px;">
			    </div>
			</div>
		</article>	
		</div>
		<!-- //container -->			
	</div>
</div>



<div class="modal fade" id="modal-boardreorder-list4" >
	<div class="modal-dialog modal-size-small" style="width: 400px">
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 id="rankpop_title2" class="pop_title">업무관리</h1>
			<a href="javascript:popupClose4()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area" style="text-align:center">
			    <div  id="pop_rank2"  style="margin:10px;">
			   
			    </div>
			</div>
		</article>	
		</div>
		<!-- //container -->			
	</div>
</div>
