<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script>	
	$(document).ready(function(){
		
	$('#actplan_list').jqGrid({
		datatype: 'json',
		url: selectActplanUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', formatter:jsRownumFormmater},
			{ label: '아이디', index: 'user_id', name: 'user_id', width: 80, align : 'center' },
			{ label: '이름', index: 'user_str', name: 'user_str', align : 'center', width:80, formatter:jsTitleLinkFormmater},
            <c:forEach var="i" begin="1" end="${actseqSize}" >
			{ label: '지급대상', index: 'act_pay_${i}', name: 'act_pay_${i}', align : 'center', width:60, formatter:jsPayFormmater},
			{ label: '보고서', index: 'act_submit_${i}', name: 'act_submit_${i}', align : 'center', width:60, formatter:jsReportFormmater},
            </c:forEach>
			{ label: '지급정지여부', index: 'give_yn', name: 'give_yn', width: 80, align : 'center', formatter:jsResultLinkFormmater},
			{ label: '신청id', index: 'aply_id', name: 'aply_id', hidden:true},
			{ label: '이름', index: 'user_nm', name: 'user_nm', hidden:true},
			{ label: '헨드폰', index: 'mobile', name: 'mobile', hidden:true},
			{ label: '지급정지사유', index: 'givestop_reason_nm', name: 'givestop_reason_nm', hidden:true}
		],
		postData :{	
			year : $("#p_year").val(),
			seq : $("#p_seq").val(),
			act_seq : $("#p_act_seq").val(),
			submit_yn : $("#p_submit_yn").val(),
			give_yn : $("#p_give_yn").val(),
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#actplan_pager',
		viewrecords : true,
		sortname : "user_nm",
		sortorder : "asc",
		height : "350px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit : false,
		multiselect: true,
		cellsubmit : 'clientArray',
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
		},
		onSelectRow : function(rowid, status, e) {
			var ret = jQuery("#actplan_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "actplan_list");
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
			showJqgridDataNon(data, "actplan_list",${3+(actseqSize*2)});
		}
	});
	//jq grid 끝 

	jQuery("#actplan_list").jqGrid('setGroupHeaders', {
		  useColSpanStyle: true, 
		  groupHeaders:[
   	        <c:forEach var="i" begin="1" end="${actseqSize}" >
	              {startColumnName: 'act_pay_${i}', numberOfColumns: 2, titleText: '${i}차'},
            </c:forEach>
		  ]	
	});
	
	jQuery("#actplan_list").jqGrid('navGrid', '#actplan_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("actplan_list", "actplan_list_div");

  });
	
	function jsRownumFormmater(cellvalue, options, rowObject) {
		
		var str = $("#total_cnt").val()-(rowObject.rnum-1);
		
		return str;
	}

	function jsTitleLinkFormmater(cellvalue, options, rowObject) {
		
		var str = "<a href=\"javascript:applyWrite('S','"+rowObject.aply_id+"')\">"+rowObject.user_nm+"</a>";
		
		return str;
	}

	function jsPayFormmater(cellvalue, options, rowObject) {
		var str = "지급";
		if(cellvalue == "N") str = "미지급";
		return str;
	}
	
	function jsReportFormmater(cellvalue, options, rowObject) {
		var str = "<a href=\"javascript:showActreport('"+rowObject.announc_id+"','"+options.colModel.index.replace("act_submit_","")+"','"+rowObject.aply_id+"')\" >제출</a>";
		if(cellvalue == "N") str = "미제출";
		return str;
	}

	function jsResultLinkFormmater(cellvalue, options, rowObject) {
		
		var str = "";
		
		if(cellvalue == "N")
			str = "<a onmouseover=\"showFailPopup('"+rowObject.givestop_reason_nm+"')\" onmouseout='hideSubmitPopup()'>정지</a>";
		else
			str = "-";
		
		return str;
	}
	
	function search() {
			
		jQuery("#actplan_list").jqGrid('setGridParam', {
			datatype : 'json',
			url : selectActplanUrl,
			page : 1,
			postData : {
				year : $("#p_year").val(),
				seq : $("#p_seq").val(),
				act_seq : $("#p_act_seq").val(),
				submit_yn : $("#p_submit_yn").val(),
				give_yn : $("#p_give_yn").val(),
				searchkey : $("#p_searchkey").val(),
				searchtxt : $("#p_searchtxt").val()
			},
			mtype : "POST"
		}

		).trigger("reloadGrid");
		
	}
	
	function showActreport(annoucId, actSeq, aplyId){
		var param = "announc_id="+annoucId+"&act_seq="+actSeq+"&aply_id="+aplyId;
		openWinC("/back/actplan/actreportWrite.do", 'actreportWritePopup', param, 800, 800,"scrollbars=yes,resizable=no");
	}
	
</script>

    <div class="modal fade" id="modal-actreport-write" >
		<div class="modal-dialog modal-size-normal">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title">보고서 제출</h1>
				<a href="javascript:actreportPopupClose()" class="pop_close" title="페이지 닫기">
					<span>닫기</span>
				</a>
			</header>
			</div>
			<!-- //header -->
			<!-- container -->
			<div id="pop_container">
			<article>
				<div class="pop_content_area">
				    <div  id="pop_actreport_content" style="margin:10px;">
				    
				    </div>
				</div>
			</article>	
			</div>
			<!-- //container -->			
		</div>
	</div>
	
	<!-- tabel_search_area -->
	<div class="table_search_area">
	  <div class="float_left">
			<a href="javascript:actplanExcelDown()" class="btn acti" title="엑셀다운로드">
				<span>엑셀다운로드</span>
			</a>
			<a href="javascript:smsWrite('actplan_list')" class="btn acti" title="SMS">
				<span>SMS</span>
			</a>
			<a href="javascript:actplanReportExcelDown()" class="btn acti" title="엑셀다운로드">
				<span>활동개월 엑셀다운로드</span>
			</a>
		</div>
		<div class="float_right">

		</div>
	</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="actplan_list_div" >
	    <table id="actplan_list"></table>
        <div id="actplan_pager"></div>
	</div>
	<!--// table 1dan list -->
	