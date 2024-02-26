<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" rel="stylesheet" />
<script src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script src="<c:url value='/smarteditor2/js/HuskyEZCreator.js' />" charset="utf-8"></script>
<script>



var selecteventUrl = "<c:url value='/back/event/eventPageList.do'/>";
var insertEvUrl = "<c:url value='/back/event/insertEvent.do'/>";
var updateEvUrl =  "<c:url value='/back/event/updateEvent.do'/>";
var deleteEvUrl =  "<c:url value='/back/event/deleteEvent.do'/>";


function evInsert(){
	
	oEditors.getById["schdContents"].exec("UPDATE_CONTENTS_FIELD", []);
	
	   var url = "";

	   if ( $("#writeFrm").parsley().validate() ){

		   url = insertEvUrl;
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						search();
						list();
	
					}
				},
				dataType: "json",
				url: url
		    });

	   }
}



function evSave(){
	
	oEditors.getById["schdContents"].exec("UPDATE_CONTENTS_FIELD", []);

	   var url = "";

	   if ( $("#writeFrm").parsley().validate() ){

		   url = updateEvUrl;
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						search();
						list();
					
					}
				},
				dataType: "json",
				url: url
		    });

	   }
	}
	
	
function evDel(){
	
	oEditors.getById["schdContents"].exec("UPDATE_CONTENTS_FIELD", []);

	   var url = "";

	   if ( $("#writeFrm").parsley().validate() ){

		   url = deleteEvUrl;
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert("1건을 삭제하였습니다");
					if(responseText.success == "true"){
						search();
						list();
					
					}
				},
				dataType: "json",
				url: url
		    });

	   }
	}
	
	
function search() {		
	
	jQuery("#intropage_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selecteventUrl,
		page : 1,
		postData : {
			
			searchtxt : $("#p_searchtxt").val(),
		
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}
	
	


function list() {

	var f = document.writeFrm;
    f.target = "_self";
    f.action = "/back/event/eventPageList.do?menuId=5457";
    f.submit();
    
    
}




</script>

<form id="writeFrm" name="writeFrm" method="post" data-parsley-validate="true" enctype="multipart/form-data">

 <input type='hidden' id="schdIdx" name='schdIdx' value="${param.schdIdx}" /> 
 




			<!-- write_basic -->
		<div class="table_area">
			<table class="write">
				<caption>주요지표 등록화면</caption>
				<colgroup>
					<col style="width: 140px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
		
				
	
				<tr>
			 		<th scope="row">제목</th>
					<td>
						  <input class="in_w25" type="text"  id="schdTitle" name="schdTitle" value="${event.schdTitle}" data-parsley-required="true" data-parsley-maxlength="100"  />
					</td>
				</tr>
				
				
					
				<tr>
					<th scope="row" >시작일자</th>
					<td>
						<input type="text" id="schdStDt" name="schdStDt" class="in_wp100 datepicker"  readonly  value="${event.schdStDt}" />
					</td>
			
				</tr>
				
				
				<tr>
			 		<th scope="row">종료일자</th>
					<td>
						 <input type="text" id="schdEdDt" name="schdEdDt" class="in_wp100 datepicker"  readonly  value="${event.schdEdDt}" />
					</td>
				</tr>

				<tr>
					<th scope="row">구분</th>
					<td>
						 <input type="radio" name="schdClass" value="01" <c:if test="${event.schdClass == '01'}">checked</c:if>> 실무교육
						 <input type="radio" name="schdClass" value="02"  <c:if test="${event.schdClass == '02'}">checked</c:if>> 보수교육
						 <input type="radio" name="schdClass" value="03"  <c:if test="${event.schdClass == '03'}">checked</c:if>> 수시교육
						 
					</td>
				</tr>
			
				<tr>
						<th scope="row" colspan="4" style="text-align:center;">내용</th>
				</tr>

				</tbody>
				</table>
					<div class="editor_area view">
				     <textarea class="form-control" id="schdContents" name="schdContents"  rows="20" style="width:100%;height:400px;" >${event.schdContents}</textarea>
				</div>
			
		</div>

			
		<!--// write_basic -->
		<!-- footer -->
		<div id="footer">
		<footer>
			<div class="button_area alignc">
			   <c:if test="${param.mode == 'W'}">
				<a href="javascript:evInsert()" class="btn save" title="등록">
					<span>등록</span>
				</a>
			  </c:if>
                 <c:if test="${param.mode == 'E' }">
                 	<a href="javascript:evSave()" class="btn save" title="수정">
					<span>수정</span>
				</a>
				
				</c:if>
				
				 <c:if test="${param.mode == 'E' }">
                 	<a href="javascript:evDel()" class="btn save" title="삭제">
					<span>삭제</span>
				</a>
				</c:if>
				
				<a href="javascript:list()" class="btn cancel" title="닫기">
					<span>뒤로</span>
				</a>
			</div>
		</footer>
		</div>
		<!-- //footer -->
</form>


<script>
$('.datepicker').each(function(){
	 $(this).datepicker({
		  dateFormat : "yymmdd",
		  language: "kr",
		  keyboardNavigation: false,
		  forceParse: false,
		  autoclose: true,
		  todayHighlight: true,
		  showOn: "button",
		  buttonImage:"/images/back/icon/icon_calendar.png",
		  buttonImageOnly:true,
		  changeMonth: true,
         changeYear: true,
         showButtonPanel:false
		 })});

</script>

<script>
	
var oEditors = [];

nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "schdContents",
    sSkinURI: "<c:url value='/smarteditor2/SmartEditor2Skin.html?editId=contents' />",
    htParams : {
    	bUseModeChanger : true
    }, 
    fCreator: "createSEditor2"
});

</script>

