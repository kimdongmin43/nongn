<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var savedRow = null;
var savedCol = null;
var selectCodemasterUrl = "<c:url value='/back/code/codemasterPageList.do'/>";
var codemasterWriteUrl =  "<c:url value='/back/code/codemasterWrite.do'/>";
var insertCodemasterUrl = "<c:url value='/back/code/insertCodemaster.do'/>";
var updateCodemasterUrl = "<c:url value='/back/code/updateCodemaster.do'/>"


$(document).ready(function(){
	

	
/* 	${pageContext.request.scheme}: http
	${pageContext.request.serverName}: localhost
	${pageContext.request.serverPort}: 8080
	${pageContext.request.contextPath}: /someApp
	JSP에서 구현된 JavaScript에서는 위 정보를 활용하여 아래와 같이 웹 애플리케이션의 절대 주소를 획득할 수 있다.
	var absoluteUrl = '${pageContext.request.scheme}' + '://' + '${pageContext.request.serverName}' + ':' + '${pageContext.request.serverPort}' + '${pageContext.request.contextPath}';
 */

	
	
	$('#modal-codemaster-write').popup();
	
	$('#master_list').jqGrid({
		datatype: 'json',
		url: selectCodemasterUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', sortable:false, formatter:jsRownumFormmater},
			{ label: '코드구분ID', index: 'mstId', name: 'mstId', width: 120, align : 'center', sortable:false },
			{ label: '코드구분명', index: 'mstNm', name: 'mstNm', align : 'left', width:200, sortable:false, formatter:jsTitleLinkFormmater},
			{ label: '설명', index: 'mstDesc', name: 'mstDesc', align : 'left', width:200, sortable:false},
			{ label: '사용여부', index: 'useYn', name: 'useYn', align : 'center', width:40, sortable:false, formatter:jsUseynLinkFormmater},
			/* { label: '코드수', index: 'codeCnt', name: 'codeCnt', width: 50, align : 'center' , sortable:false}, */
			{ label: '코드관리', index: 'codeBtn', name: 'codeBtn' , width: 100, align : 'center', sortable:false, formatter:jsBtnFormmater}
		],
		postData :{	
			master_nm : $("#p_master_nm").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#master_pager',
		viewrecords : true,
		sortname : "mst_nm",
		sortorder : "asc",
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
			var ret = jQuery("#master_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "master_list");
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
			
			showJqgridDataNon(data, "master_list",7);

		}
	});
	//jq grid 끝 
	
	jQuery("#master_list").jqGrid('navGrid', '#master_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("master_list", "master_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:codemasterWrite('"+rowObject.mstId+"')\">"+rowObject.mstNm+"</a>";
	
	return str;
}

function jsUseynLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "사용";
	
	if(cellvalue == "N") str = "미사용";
	
	return str;
}

function jsBtnFormmater(cellvalue, options, rowObject) {
		
	var str = "";

 	str ="<a href=\"javascript:codeListPage('"+rowObject.mstId+"')\" class=\"btn look\" title=\"코드상세\"><span>코드상세</span></a>";
		
	return str;
}

function search() {
		
	jQuery("#master_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectCodemasterUrl,
		page : 1,
		postData : {
			mstNm : $("#p_master_nm").val(),
			useYn : $("#p_useYn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function codemasterWrite(mstId) {
    var f = document.listFrm;
    var mode = "W";
    if(mstId != ""){
    	mode = "E";
       $("#pop_title").html("코드구분 수정");
    }
    else $("#pop_title").html("코드구분 등록");

    
	$('#pop_content').html("");
	
	$("#mode").val(mode);
    $.ajax({
        url: codemasterWriteUrl,
        dataType: "html",
        type: "post",
        data: {
           mode : mode,
  		   mstId : mstId
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

function codemasterInsert(){
	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){

		   url = insertCodemasterUrl;
		   if($("#mode").val() == "E") url = updateCodemasterUrl; 
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
  				url: url
  		    });	
		   
	   }	
}


function codeListPage(mstId) {
	 
    var f = document.listFrm;
  
    $("#mstId").val(mstId);
    f.target = "_self";
    f.action = "/back/code/codeListPage.do";
    f.submit();
}

function formReset(){
	$("#p_master_nm").val("");
	$('#p_useYn option[value=""').attr('selected','selected');
}

function popupShow(){
	$('#modal-codemaster-write').popup('show');
}

function popupClose(){
	$('#modal-codemaster-write').popup('hide');
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
	<input type='hidden' id="mstId" name='mstId' value="" />
	<input type='hidden' id="mode" name='mode' value="W" />
	
	<!-- search_area -->
	<div class="search_area">
		 <table class="search_box">
			<caption>코드구분검색</caption>
			<colgroup>
				<col style="width: 80px;" />
				<col style="width: 20%;" />
				<col style="width: 70px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<tr>
				<th>코드구분명</th>
				<td>
                     <input type="text" class="form-control input-sm" id="p_master_nm" name="p_master_nm" value="${param.p_master_nm}"  placeholder="대코드명" />
				</td>
				<th>사용여부</th>
				<td>
                  <select id="p_useYn" name="p_useYn" class="form-control input-sm">
                       <option value="">- 전체 -</option>
                       <option value="Y" <c:if test="${param.p_useYn == 'Y'}">selected</c:if>>사용</option>
                       <option value="N" <c:if test="${param.p_useYn == 'N'}">selected</c:if>>미사용</option>
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
			<a href="javascript:codemasterWrite('')" class="btn acti" title="코드구분 등록">
				<span>코드구분등록</span>
			</a>
		</div>
	</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="master_list_div" >
	    <table id="master_list"></table>
        <div id="master_pager"></div>
	</div>
	<!--// table 1dan list -->
	</form>
</div>
<!--// content -->

  <div id="modal-codemaster-write" style="width:600px;background-color:white">
		<div id="wrap">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title" id = "pop_title">코드구분 등록</h1>
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
		 		