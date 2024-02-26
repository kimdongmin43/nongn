<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script src="<c:url value='/smarteditor2/js/HuskyEZCreator.js' />" charset="utf-8"></script>
<link href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" rel="stylesheet" />
<script src="/assets/jquery/jquery.ui.datepicker.js"></script>


<script>
var insertPopnotiUrl = "<c:url value='/back/popnoti/insertPopnoti.do'/>";
var updatePopnotiUrl = "<c:url value='/back/popnoti/updatePopnoti.do'/>"
var deletePopnotiUrl = "<c:url value='/back/popnoti/deletePopnoti.do'/>";

$(document).ready(function(){
	$(".onlynum").keyup( setNumberOnly );
	
});

function popnotiListPage() {
    var f = document.writeFrm;
    
    f.target = "_self";
    f.action = "/back/popnoti/popnotiListPage.do";
    f.submit();
}

function popnotiInsert(){
	$("#contents").val();

	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){
		   var staDt = $("#startDy").val();
		   var endDt = $("#endDy").val();
		
		   if((staDt != "" && endDt != "") && (staDt > endDt)){
			     alert("게시 시작일자가 종료일자보다 이후 일자가 올 수 없습니다.");
			     return;
		   }
			/*
			if ($("#uploadFile").val() != "" && !$("#uploadFile").val().toLowerCase().match(/\.(ppt|pptx|xls|xlsx|doc|docx|hwp|txt|jpg|png|gif)$/)){
			    alert("확장자가 ppt,pptx,xls,xlsx,doc,docx,hwp,txt,jpg,png,gif 파일만 업로드가 가능합니다.");
			    return;
			}  
			*/
		   //oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);

		   if($("#contents").val() == ""){
			     alert("내용을 입력해주십시요.");
			     return;
		   }
		   
		   url = insertPopnotiUrl;
		   if($("#mode").val() == "E") url = updatePopnotiUrl; 

		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						popnotiListPage();
  					}	
  				},
  				dataType: "json", 				
  				url: url
  		    });	
		   
	   }
}

function popnotiDelete(){
	   if(!confirm("팝업을 정말 삭제하시겠습니까?")) return;
	   
		$.ajax
		({
			type: "POST",
	           url: deletePopnotiUrl,
	           data:{
	           	notiId : $("#notiId").val()
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					popnotiListPage();
				}	
			}
		});
}

function delFile(gubun){
		$("#attachId").val("");
		$("#uploadedFile").hide();
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
		<jsp:include page="/WEB-INF/views/back/menu/menuDescInclude.jsp"/>
	</div>	
		<!--// main_title -->
		 <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true"  enctype="multipart/form-data">
				<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
				<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
				<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
				<input type='hidden' id="p_searchKey" name='p_searchKey' value="${param.p_searchKey}" />
				<input type='hidden' id="p_searchTxt" name='p_searchTxt' value="<c:out value="${param.p_searchTxt}" escapeXml="true" />" />
				<input type='hidden' id="p_use_yn" name='p_use_yn' value="${param.p_use_yn}" />
				<input type='hidden' id="mode" name='mode' value="${param.mode}" />
			    <input type='hidden' id="notiId" name='notiId' value="${popnoti.notiId}" />
			    <input type='hidden' id="attachId" name='attachId' value="${popnoti.attachId}" />
			    <input type='hidden' id="contents" name='contents' value='${popnoti.contents}' />
			    <input type='hidden' id="tabGbn" name='tabGbn' value='${param.tabGbn}' />
				<input type='hidden' id="delFile" name = "delFile" />
				<input type='hidden' id="inFile" name = "inFile" />
			    
			<!-- write_basic -->
			<div class="table_area">
				  <table class="view">
					<caption>상세보기 화면</caption>
					<colgroup>
						<col style="width: 120px;" />
						<col style="width: *;" />
						<col style="width: 120px;" />
						<col style="width: *;" />
					</colgroup>
					<tbody>
					<c:if test="${params.mode == 'E' }">
					<tr>
						<th scope="row">등록자</th>
						<td>${popnoti.regUserNm}</td>
						<th scope="row">등록일</th>
						<td>${popnoti.regDt}</td>
					</tr>
					</c:if>
					<tr>
						<th scope="row">제목  <span class="asterisk">*</span></th>
						<td colspan="3">
							<input class="form-control in_w100" type="text" id="title" name="title" value="${popnoti.title}" placeholder="제목" data-parsley-required="true" data-parsley-maxlength="100" />
						</td>
					</tr>
					<tr>
						<th scope="row">팝업크기  <span class="asterisk">*</span><br/>(픽셀사이즈)</th>
						<td colspan="3">
						    <p>가로 <input class="form-control onlynum" type="text" id="width" name="width" value="${popnoti.width}" placeholder="팝업크기 가로" maxLength="4" data-parsley-required="true" data-parsley-type="number" style="width:50px"/></p> 
							<p style="margin-top : 5px">세로 <input class="form-control onlynum" type="text" id="height" name="height" value="${popnoti.height}" placeholder="팝업크기 세로" maxLength="4" data-parsley-required="true" data-parsley-type="number" style="width:50px"/></p>
						</td>
					</tr>
					<tr>
						<th scope="row">팝업위치  <span class="asterisk">*</span><br/>(픽셀사이즈)</th>
						<td colspan="3">
                             <p>Top <input class="form-control onlynum" type="text" id="top" name="top" value="${popnoti.top}" placeholder="팝업위치 Top" maxLength="4" data-parsley-required="true" data-parsley-type="number"  style="width:50px"/></p>
							 <p style="margin-top : 5px">Left <input class="form-control onlynum" type="text" id="left" name="left" value="${popnoti.left}" placeholder="팝업위치 Left" maxLength="4" data-parsley-required="true" data-parsley-type="number"  style="width:50px"/></p>
						</td>
					</tr>	
					<tr>
						<th scope="row">사용여부</th>
						<td colspan="3">
							<input type="radio" name="useYn" value="Y" <c:if test="${popnoti.useYn == 'Y'}">checked</c:if>> 사용 <input type="radio" name="useYn" value="N"  <c:if test="${popnoti.useYn == 'N'}">checked</c:if>> 미사용 
						</td>
					</tr>	
					<tr>
						<th scope="row">게시기간</th>
						<td colspan="3">
                          <input type="text" id="startDy" name="startDy" class="in_wp100 datepicker" readonly value="${popnoti.startDy}">
                          ~
                          <input type="text" id="endDy" name="endDy" class="in_wp100 datepicker" readonly value="${popnoti.endDy}">
						</td>
					</tr>	
					<tr>
						<th scope="row">첨부파일</th>
						<td colspan="3">
						 <%--  
						  <c:if test="${param.mode == 'E' && !empty popnoti.attachId}">
	                      <p id="uploadedFile"><a href="/commonfile/fileidDownLoad.do?attachId=${popnoti.attachId}" >${popnoti.file_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile()"></a></p>
	                     </c:if> 
	                      <input class="form-control in_w50" type="file" id="uploadFile" name="uploadFile" value="" />
	                       --%>
				
 						</td>
					</tr>
					<tr>
						<th scope="row" colspan="4">내용</th>
					</tr>
					</tbody>
				</table>
				<div class="editor_area view">
					<%-- <textarea class="form-control" id="contents" name="contents" placeholder="내용" rows="20"  style="width:100%;height:400px;" >${popnoti.contents}</textarea> --%>
				
				</div>

			</div>
			<!--// write_basic -->
			
			<!-- button_area -->
			<div class="button_area">
				<div class="float_right">
					<a href="javascript:popnotiPreview();" class="btn list" title="미리보기">
						<span>미리보기</span>
					</a>
					<c:if test="${param.mode == 'W' }">
					<!-- <a href="javascript:popnotiInsert('W');" class="btn save" title="저장"> -->
					<a href="javascript:fileTransfer();" class="btn save" title="저장">
						<span>저장</span>
					</a>
					</c:if>
					 <c:if test="${param.mode == 'E' }">
					<!-- <a href="javascript:popnotiInsert('M');" class="btn save" title="수정"> -->
					<a href="javascript:fileTransfer();" class="btn save" title="수정">
						<span>수정</span>
					</a>
					<a href="javascript:popnotiDelete();" class="btn save" title="삭제">
						<span>삭제</span>
					</a>
					</c:if>
					<a href="javascript:popnotiListPage();" class="btn cancel" title="취소">
						<span>취소</span>
					</a>
				</div>
			</div>
			<!--// button_area -->
</form>
</div>
<!--// content -->

<script>
     $('.datepicker').each(function(){
	    $(this).datepicker({
			  format: "yyyy-mm-dd",
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
			 });
	});
	
     var oEditors = [];

     nhn.husky.EZCreator.createInIFrame({
         oAppRef: oEditors,
         elPlaceHolder: "contents",
         sSkinURI: "<c:url value='/smarteditor2/SmartEditor2Skin.html?editId=contents' />",
         htParams : {
         	bUseModeChanger : true
         }, 
         fCreator: "createSEditor2"
     });

</script>