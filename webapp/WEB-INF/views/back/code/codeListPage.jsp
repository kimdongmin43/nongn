<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var selectCodeListUrl = "<c:url value='/back/code/codeList.do'/>";
var codeWriteUrl =  "<c:url value='/back/code/codeWrite.do'/>";
var insertCodeUrl = "<c:url value='/back/code/insertCode.do'/>";
var updateCodeUrl = "<c:url value='/back/code/updateCode.do'/>"
var deleteCodeUrl = "<c:url value='/back/code/deleteCode.do'/>";
var codeReorderUrl = "<c:url value='/back/code/updateCodeReorder.do'/>";

var savedRow = null;
var savedCol = null;

$(document).ready(function(){
	
	$('#modal-code-write').popup();
	
	$('#code_list').jqGrid({
		datatype: 'json',
		url: selectCodeListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'sort', name: 'sort', width: 50, align : 'center', editable : true, sortable:false,editoptions:{dataInit: function(element) {
				$(element).keyup(function(){
					chkNumber(element);
				});
			}}  },
			{ label: '코드', index: 'codeId', name: 'codeId', width: 80, align : 'center', sortable:false },
			{ label: '코드명', index: 'codeNm', name: 'codeNm', align : 'left', sortable:false, width:200, formatter:jsTitleLinkFormmater},
			{ label: '설명', index: 'codeDesc', name: 'codeDesc', align : 'left', sortable:false, width:200},
			{ label: '사용여부', index: 'useYn', name: 'useYn', align : 'center', width:40, sortable:false, formatter:jsUseynLinkFormmater},
			/* { label: '등록일', index: 'reg_dt', name: 'reg_dt', width: 100, align : 'center', sortable:false }, */
		],
		postData :{	
			mstId : $("#mstId").val(),
			codeNm : $("#p_codeNm").val()
		   },
		rowNum : -1,
		viewrecords : true,
		height : "350px",
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
			showJqgridDataNon(data, "code_list",6);
		}
	});
	//jq grid 끝 
	
	bindWindowJqGridResize("code_list", "code_list_div");

});

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:codeWrite('"+rowObject.codeId+"')\">"+rowObject.codeNm+"</a>";
	
	return str;
}

function jsUseynLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "사용";
	
	if(cellvalue == "N") str = "미사용";
	
	return str;
}

function search() {
		
	jQuery("#code_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectCodeListUrl,
		page : 1,
		postData : {
			codeNm : $("#p_codeNm").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function codeWrite(codeId) {
    var f = document.listFrm;    
    var mode = "W";
    
    if(codeId != ""){
    	mode = "E";
    $("#pop_title").html("코드상세 수정");
    }
    else $("#pop_title").html("코드상세 등록");
	$('#pop_content').html("");
	
	$("#mode").val(mode);
    $.ajax({
        url: codeWriteUrl,
        dataType: "html",
        type: "post",
        data: {
           mode : mode,
  		   mstId : $("#mstId").val(),
  		   mstNm : $("#mstNm").val(),
  		   codeId : codeId
		},
        success: function(data) {
        	$('#pop_content').html(data);
        	popupShow();
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
  
}

function codeInsert(){
	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){

		   url = insertCodeUrl;
		   if($("#mode").val() == "E") url = updateCodeUrl; 
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						search();
  						popupClose();
  					}	
  				},
  				dataType: "json",
  				data : {
  					mstId : $("#mstId").val()
  				},
  				url: url
  		    });	
		   
	   }
}

function codeDelete(){
	   if(!confirm("정말 삭제하시겠습니까?")) return;
	   
		$.ajax
		({
			type: "POST",
	           url: deleteCodeUrl,
	           data:{
	           	gubun : $("#gubun").val(),
	           	code : $("#code").val()
	           },
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

function codeReorder(){
	var updateRow = new Array();
	var saveCnt = 0;
	
	jQuery('#code_list').jqGrid('saveCell', savedRow, savedCol);
	
	var arrrows = $('#code_list').getRowData();
	if(arrrows != undefined && arrrows.length > 0)
		for(var i=0;i<arrrows.length;i++){
			//필수값 체크
			if(arrrows.length>0){
				if(arrrows[i].sort == '' || arrrows[i].sort == null){
					alert("번호는 필수값입니다. 확인후 다시입력해주세요");
					return;
				}
			}
			arrrows[i].codeNm="";
			updateRow[saveCnt++] = arrrows[i];
		}
	else {
		alert("번호를 저장할 코드가 없습니다.");
		return;
	}
		
	$.ajax
	({
		type: "POST",
           url: codeReorderUrl,
           data:{
           	mstId : $("#mstId").val(),
            code_list : JSON.stringify(updateRow) 
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				search();
			}	
		}
	});
}

function formReset(){
	$("#p_codeNm").val("");
}

function popupShow(){
	$('#modal-code-write').popup('show');
}

function popupClose(){
	$('#modal-code-write').popup('hide');
}

function codemasterListPage(){
    var f = document.listFrm;
   
    f.target = "_self";
    f.action = "/back/code/codemasterListPage.do";
    f.submit();
}

</script>

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
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="mstId" name='mstId' value="${codemaster.mstId}" />
	<input type='hidden' id="mstNm" name='mstNm' value="${codemaster.mstNm}" />
	<input type='hidden' id="pMstNm" name='pMstNm' value="${param.pMstNm}" />
	<input type='hidden' id="pUseYn" name='pUseYn' value="${param.pUseYn}" />
	<input type='hidden' id="mode" name='mode' value="W" />

	<!-- search_area -->
	<div class="search_area">
		 <table class="search_box" border=1">
			<caption>코드검색</caption>
			<colgroup>
				<col style="width: 80px;" />
				<col style="width: 20%;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<tr>
				<th>코드명</th>
				<td>
                     <input type="text" class="form-control input-sm" id="pCodeNm" name="p_codeNm" value="${param.pCodeNm}" placeholder="코드명"  />
				</td>
				<td></td>
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
	    <div class="float_left">
	         <h5>코드구분ID : ${codemaster.mstId},  코드구분명 : ${codemaster.mstNm}</h5>
	    </div>
		<div class="float_right">
			<a href="javascript:codeReorder()" class="btn acti" title="번호저장">
				<span>번호저장</span>
			</a>
			<a href="javascript:codeWrite('')" class="btn acti" title="코드등록">
				<span>코드등록</span>
			</a>
			<a href="javascript:codemasterListPage()" class="btn acti" title="코드구분목록">
				<span>코드구분목록</span>
			</a>
		</div>
	</div>
	<!--// tabel_search_area -->
	
	<!-- table 1dan list -->
	<div class="table_area" id="code_list_div" >
	    <table id="code_list"></table>
	</div>
	<!--// table 1dan list -->
	</form>
</div>
<!--// content -->


  <div id="modal-code-write" style="width:600px;background-color:white">
		<div id="wrap">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title" id="pop_title"></h1>
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
				    <div id="pop_content">
					</div>    
				</div>
			</article>	
			</div>
			<!-- //container -->
		</div>
  </div>
	 		