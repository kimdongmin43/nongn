<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script>
var selectManagerSearchListUrl = "<c:url value='/back/user/managerSearchList.do'/>";

var savedRow = null;
var savedCol = null;

$(document).ready(function(){

	$('#manager_list').jqGrid({
		datatype: 'json',
		url: selectManagerSearchListUrl,
		mtype: 'POST',
		colModel: [
	            { label: '선택', index: 'sel_box', name: 'sel_box', width: 40, align : 'center', sortable:false,formatter:jsRadioFormmater},
				 { label: '아이디', index: 'membid', name: 'membid', width: 140, align : 'center',sortable:false },
	            { label: '이름', index: 'nm', name: 'nm', width: 80, align : 'center',sortable:false },
	            { label: '사번', index: 'empno', name: 'empno', width: 80, align : 'center',sortable:false },
				{ label: '부서명', index: 'deptNm', name: 'deptNm', width: 200, align : 'center',sortable:false },
				{ label: '회사전화번호(인사정보에 없는 사용자를 위한 필드)', index: 'compTel', name: 'compTel', hidden:true},
				{ label: '통합회원번호', index: 'loginid', name: 'loginid', hidden:true}
		],
		postData :{
			findText : $("#userNm").val(),
			//chamCd : $("#chamCd").val()
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
			showJqgridDataNon(data, "manager_list",4);
			//$("#findTextCnt").html("최대 100명만 검색 됩니다.(조회 결과:"+data.rows.length+"명)");
		}
	});
	//jq grid 끝
});



function jsRadioFormmater(cellvalue, options, rowObject){
	return '<input type="radio" id="chk_manager_id" name="chk_manager_id" value="'+options.rowId+'")/>';
}

function selIntropage(){
	var idx = $(':radio[name="chk_manager_id"]:checked').val();
	if(idx == undefined) {
		alert("아이디를 선택해 주십시요.");
		return;
	}
	var ret = jQuery("#manager_list").jqGrid('getRowData',idx);
	$("#loginId").val(ret.membid);
	$("#userNm").val(ret.nm);
	$("#deptNm").val(ret.deptNm);
	$("#siteNm").val("${SITE.siteNm}");
	$("#siteId").val("${SITE.siteId}");
	
	var telArr;
	if ( !ret.compTel==""){
		telArr = ret.compTel.split('-');
		
		for(var i=0;i<telArr.length;i++){
			if(i==0){
				$("#tel_"+(i+1)).val(telArr[i]).prop("selected",true);
			}else{
				$("#tel_"+(i+1)).val(telArr[i]);
			}
	    }
	}
	ssoSearchYn = "Y";
	
	popupSearchClose();
}

function findText(txt){

	$("#manager_list").find("tr[role=row]").hide();
	$("#manager_list").find(".jqgfirstrow").show();
	$("#manager_list").find("td:contains("+txt+")").closest("tr[role=row]").show();

	if(txt.length < 1){
		$("#manager_list").find("tr[role=row]").show();
	}
}

</script>
		<!-- tabel_search_area -->
		<div class="table_search_area" style="margin-top:20px">
			<div class="float_left">
				<span class="inpbox"><input id="findText" name="findText" type="text" class="in_w80" placeholder="찾기.." title="찾기.." value="${param.userNm}" onkeyup="findText(this.value);" /></span> <!--onkeypress="if( event.keyCode==13 ){findText(this.value);}"  -->
			</div>
			<!-- <h id="findTextCnt">최대 100명만 검색 됩니다. (조회 결과:0명)</h> -->
			<div class="float_right">
				<a href="javascript:selIntropage();" class="btn acti" title="선택" style="margin-right:20px;">
					<span>선택</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->

		<div class="table_area" id="manager_list_div" >
		    <table id="manager_list"></table>
		</div>
