<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%
      request.setAttribute("applyGb", "A");
%>
<script>
var savedRow = null;
var savedCol = null;
var selectActplanUrl = "<c:url value='/back/actplan/actplanPageList.do'/>";

$(document).ready(function(){
	changeSeq();
});

function actplanListTable(){
	var actseqSize = 0;
	if($("#p_act_seq").val() == "") {
		actseqSize = $("#actseqSize").val();
		$("select[name=p_submit_yn] option[value='']").attr("selected",true);
		$("#submit_th").hide();
		$("#submit_td").hide();
	}else{
		actseqSize = $("#p_act_seq").val();
		$("#submit_th").show();
		$("#submit_td").show();
	}
	
    $.ajax({
        url: "/back/actplan/actplanListTable.do",
        dataType: "html",
        type: "post",
        data: {
        	actseqSize : actseqSize
		},
        success: function(data) {
        	$('#table_div').html(data);
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

function changeYear(){
    var param = {}; 
    param["year"] = $("#p_year").val();
    
    getCodeList("/back/announce/announceSeqCodeList.do", param, "p_seq", "", "", "","Y");
    changeSeq();
}

function changeSeq(){
	$("select[name=p_submit_yn] option[value='']").attr("selected",true);
	$.ajax({
		type : "POST",
		url : "/back/actplan/actplanCodeList.do",
		async : true,
		data : {
			year : $("#p_year").val(),
			seq : $("#p_seq").val()	
		},
		success : function(data, dataType) {
			if (data != null && data.list != null) {
				selectbox_insertlist("p_act_seq", data.list, "", "", "-전체-", "N");
 	            $("#actseqSize").val(data.list.length);
				actplanListTable();
			}
		}
	});
}

function actplanExcelDown(){
     var f = document.listFrm;
     f.target = "hiddenFrame";
     f.action = "/back/actplan/actplanExcelDown.do";
     f.submit();
     f.target = "";
}

function actplanReportExcelDown(){
    var f = document.listFrm;
    
    if($("#p_act_seq").val() == ""){
    	alert("활동개월을 선택해 주십시요.");
    	return;
    }
    
    f.target = "hiddenFrame";
    f.action = "/back/actplan/actplanReportExcelDown.do";
    f.submit();
    f.target = "";
}

function getField(){
   var chk = "";
   var cnt =0;
   $(":checkbox[name='p_field_cd']:checked").each(function(i,e){
       if(cnt > 0) chk += ",";
       chk += e.value;
       cnt++;
   });
   
   return chk;
}


function evalResultPopup(){
	$("#evalFailTitle").html("지급정지사유");
	 var s = jQuery("#actplan_list").jqGrid('getGridParam','selarrrow');

     if(s.length < 1){
     	alert("대상자를 선택해 주십시요.");
     	return;
     }
	evalPopupShow();
}

function updateEvalResult(gubun){
	var gubunNm = "지급정지취소";
	var failReason = "";
	if(gubun == "F") {
		gubunNm = "지급정지";
		failReason = $("#fail_reason").val();
	}
	
	 var s = jQuery("#actplan_list").jqGrid('getGridParam','selarrrow');

     if(s.length < 1){
     	alert("대상자를 선택해 주십시요.");
     	return;
     }
     
 	var aplyRow = new Array();
	for (var i = 0; i < s.length; i++) {
		ret = jQuery("#actplan_list").jqGrid('getRowData',s[i]);
		aplyRow.push(ret.aply_id);
    }
	
    if(!confirm("선택한 대상자를 "+gubunNm+" 처리하시겠습니까?")) return;
    	 
	
    $.ajax({
        url: "/back/actplan/updateActplanGiveStop.do",
        dataType: "json",
        type: "post",
        data: {
        	type : "A",
        	give_yn : gubun=="F"?"N":"Y",
           givestop_reason : failReason,
  		   aply_list : JSON.stringify(aplyRow)
		},
        success: function(data) {
        	alert(data.message);
        	if(data.success == "true") search();
        	evalPopupClose(); 
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
    	 
}

function formReset(){
	$("#p_searchtxt").val("");
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
	<input type='hidden' id="actseqSize" name='actseqSize' value="" />
	
	<!-- search_area -->
	<div class="search_area">
		<table class="search_box">
			<caption>활동결과서검색</caption>
			<colgroup>
				<col style="width: 110px;" />
				<col style="width: 20%;" />
				<col style="width: 110px;" />
				<col style="width: 25%;" />
				<col style="width: 110px;" />				
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<tr>
				<th>회차/공고연도</th>
				<td>	
					<g:select id="p_seq" name="p_seq"  source="${seqList}" selected="${param.p_seq}" onChange="changeSeq()" cls="in_wp60" />/
					<select id="p_year" name="p_year" class="form-control input-sm" onChange="changeYear()">
                      <option value="" >- 전체 -</option>
                      <c:forEach var="i" begin="0" end="5" >
                         <option value="${curYear-i}" <c:if test="${(curYear-i) == selYear}">selected</c:if>>${curYear-i}</option>
                     </c:forEach>
                  </select>
				</td>
				<th>활동개월</th>
				<td>	
					<g:select id="p_act_seq" name="p_act_seq"  source="${actseqList}" selected="${param.p_act_seq}" titleCode="전체" showTitle="true" cls="in_wp230" onChange="actplanListTable()" />
				</td>
				<th id="submit_th" style="display:none">제출여부</th>
				<td id="submit_td" style="display:none">	
				    <g:select id="p_submit_yn" name="p_submit_yn" codeGroup="SUBMIT_YN" titleCode="전체" showTitle="true" cls="in_wp100" />
				</td>
				
			</tr>		
			<tr>
				<th>지급정지여부</th>
				<td>	
					<select id="p_give_yn"  name="p_give_yn">
					     <option value="">-전체-</option>
					     <option value="N">지급정지</option>
					     <option value="Y">지급정상</option>
					</select>   
				</td>
				<th>검색구분</th>
				<td colspan="5">
					<select id="p_searchkey" name="p_searchkey" class="in_wp80" title="검색구분">
						<option value="user_nm">이름</option>
						<option value="user_id">아이디</option>
						<option value="mobile">휴대전화</option>
						<option value="email">이메일</option>
					</select>
					<label for="input_text" class="hidden">검색어 입력</label>
					<input id="p_searchtxt" name="p_searchtxt" type="text" value="${param.p_searchtxt}" class="in_w50" />
				</td>
			</tr>	
			</tbody>
		</table>
		<div class="search_area_btnarea">
			<a href="javascript:search();" class="btn sch" title="조회하기">
				<span>조회</span>
			</a>
			<a href="javascript:formReset();" class="btn clear" title="검색 초기화">
				<span>초기화</span>
			</a>
		</div>
	</div>
	<!--// search_area -->

     <div id="table_div">
	 </div>
	
		<!-- tabel_search_area -->
	<div class="table_search_area">
	   <div class="float_left">
		</div>
		<div class="float_right">
			<a href="javascript:evalResultPopup()" class="btn acti" title="지급정지">
				<span>지급정지</span>
			</a>
			<a href="javascript:updateEvalResult('P')" class="btn none" title="지급정지취소">
				<span>지급정지취소</span>
			</a>			
		</div>
	</div>
	<!--// tabel_search_area -->		
	
</div>
<!--// content -->
</form>

  <jsp:include page="/WEB-INF/views/back/apply/applyInclude.jsp"/>
		 		