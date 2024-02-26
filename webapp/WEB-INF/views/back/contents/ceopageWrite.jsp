<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>


<script src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script src="<c:url value='/dext5upload/js/dext5upload.js' />" charset="utf-8"></script>
<script src="<c:url value='/dext5editor/js/dext5editor.js' />" charset="utf-8"></script>
<script>
var savedRow = null;
var savedCol = null;
var del_Yn = "N";
var writeUrl = "<c:url value='/back/contents/ceopageListPage.do'/>";
var ceopageUpdateUrl =  "<c:url value='/back/contents/ceopageUpdate.do'/>";
var ceopageInsertUrl =  "<c:url value='/back/contents/ceopageInsert.do'/>";
var ceopageDeleteUrl =  "<c:url value='/back/contents/ceopageDelete.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";



$(document).ready(function(){	

});


function valcheck(){
	
	if(!$("#writeFrm").parsley().validate())
		{
		return false;
		}	
	if ($("#startDy").val()==null || $("#startDy").val()=="") {
		alert("임기 시작일을 입력해주세요.");		
		return false;
	}	
	
	if (DEXT5UPLOAD.GetTotalFileCount("upload1")<1) {
		alert("사진파일은 필수 입력사항입니다.");
		return false;		
	}
	
	
	return true;
}

function ceopageInsert()
{
	var url = ceopageInsertUrl;	
		   
		
	
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						list();
					}	
				},
				dataType: "json",
				url: url
		    });	
	 	
}
function ceopageUpdate()
{
	var url = ceopageUpdateUrl;	
		
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						list();
					}	
				},
				dataType: "json",
				url: url
		    });	
	   
}
function ceopageDelete()
{
	
	
	if (!confirm("정말 삭제하시겠습니까?")) {
		return;
	}
	var url = ceopageDeleteUrl;
	   $("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					list();
				}	
			},
			dataType: "json",
			url: url
	    });	
  		
}
function list(){
	var f = document.writeFrm;
	f.target = "_self";
    f.action = writeUrl;
    f.submit();
}

function DEXT5UPLOAD_OnCreationComplete(uploadID) { 
	
	 DEXT5UPLOAD.SetMaxTotalFileCount('1', uploadID);
	 DEXT5UPLOAD.SetSize('100%','150',uploadID);
	 DEXT5UPLOAD.SetAllowOrLimitExtension(1, 'jpg,png,gif', uploadID);
	 DEXT5UPLOAD.SetMaxTotalFileSize('10MB', uploadID);
	 
		 if ("${ceoPageInfo.fileId}"!=""){
			  DEXT5UPLOAD.AddUploadedFile('${ceoPageInfo.fileId}', '${ceoPageInfo.originFileNm}', '${ceoPageInfo.path}', '${ceoPageInfo.fileSize}', '${ceoPageInfo._attachId}', uploadID);
		}
				 
}

function fileTransfer(){
		
		if(!valcheck())
		{
			return;
		}		
		DEXT5UPLOAD.Transfer('upload1');
	
}


function DEXT5UPLOAD_OnTransfer_Complete(uploadID) {
	
	var del_file_list = DEXT5UPLOAD.GetDeleteListForJson(uploadID);
	var in_file_list = DEXT5UPLOAD.GetNewUploadListForJson(uploadID);
	
	$("#delFile").val(JSON.stringify(del_file_list));
	$("#inFile").val(JSON.stringify(in_file_list));
	

	if ($("#attachId").val()==null || $("#attachId").val()=="") {
		$.ajax({
			type: "POST",
			url: "/common/file/insertFile.do",
			data :$("#writeFrm").serialize(),
			dataType: 'json',
			async : false,
			success:function(data){
				if(data.success == "true"){					
					$("#attachId").val(data.attachId);		
				}
				else 	alert("실패");
			}
		});
	}else{
		
		$.ajax({
			type: "POST",
			url: "/common/file/updateFile.do",
			data :$("#writeFrm").serialize(),
			dataType: 'json',
			async : false,
			success:function(data){
				if(data.success == "true"){
				
				}else alert("실패");
			}
		});
		
	}
	
	if ("${ceoPageInfo.gubun}"!='E') {
		ceopageInsert();
	}
	else
	{
	ceopageUpdate();
	}


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
        <!-- <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true"> --> 
        <form id="writeFrm" name="writeFrm" method="post"  onsubmit="return false;" enctype="multipart/form-data" > 
				<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
				<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
				<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
				<input type='hidden' id="mode" name='mode' value="${param.mode}" />
			    <input type='hidden' id="ceoId" name='ceoId' value="${ceoPageInfo.ceoId}" />
			    <input type='hidden' id="contents" name = "contents" value = '${ceoinfo.contents}' />
			    <input type='hidden' id="delFile" name = "delFile" />
			    <input type='hidden' id="inFile" name = "inFile" />
			    <input type='hidden' id="attachId" name = attachId value = "${ceoPageInfo.attachId}" />
			    
			<!-- table_area -->
					<div class="table_area">
						<table class="write">
							<caption>등록 화면</caption>
							<colgroup>
								<col style="width: 120px;">
								<col style="width: *;">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">
									<label for="ceoNm">회장명 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="ceoNm" name="ceoNm" type="text" class="in_w100" value = "${ceoPageInfo.ceoNm}" data-parsley-required="true"/>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="stageDesc">기수 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="stageDesc" name="stageDesc" type="text" class="in_w100" value = "${ceoPageInfo.stageDesc}" data-parsley-required="true"/>
								</td>
							</tr>
							<tr>
								<th scope="row">임기 <strong class="color_pointr">*</strong></th>
								<td>
									<label for ="startDy" class = "hidden">임기시작일</label>
									<input type="text" id="startDy" name="startDy" readonly value="${ceoPageInfo.startDy}"  class="in_wp100 datepicker">									
									&nbsp;~&nbsp;
									<label for ="endDy" class = "hidden">임기시작일</label>
									<input type="text" id="endDy" name="endDy" class="in_wp100 datepicker" readonly value="${ceoPageInfo.endDy}" >
									<input id="ceoYn" name="ceoYn" type="checkbox" class="marginl20" <c:if test = '${ceoPageInfo.ceoYn eq  "Y"}'>checked = checked</c:if>    />
									<label for="ceoYn">현재 임기중</label>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="companyNm">근무지 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="companyNm" name="companyNm" type="text" class="in_w100" value = "${ceoPageInfo.companyNm}" data-parsley-required="true"/>
								</td>
							</tr>
							<tr>
					<th scope="row">사진 <strong class="color_pointr">*</strong></th>
					<td>
						<script>
				        					var dext5Upload = new Dext5Upload("upload1");
    							</script>
						<p class="margint5 color_pointo"> 가로 100px / 세로 125px 권장 사이즈이며, jpg, png, gif 확장자만 사용 가능합니다.</p>
					</td>
				</tr>
					</tbody>
						</table>
					</div>
					<!--// table_area -->	
					<!-- button_area -->
					<div class="button_area">
						<div class="float_right">
							<c:set var="gubun" value="${ceoPageInfo.gubun}"></c:set>
							<c:choose>
							<c:when test="${gubun ne 'E' }">
							<button type="button" class="btn save" title="저장하기" onclick="fileTransfer()">
								<span>저장</span>
							</button>
							<button type="button" class="btn list" title="목록" onclick="list()">
								<span>목록</span>
							</button>							
							</c:when>
							<c:otherwise>
							<button type="button" class="btn save" title="저장하기" onclick="fileTransfer()">
								<span>저장</span>
							</button>
							<button type= "button" class="btn save" title="삭제하기" onclick="ceopageDelete()">
								<span>삭제</span>
							</button>
							<button class="btn list" title="목록" onclick="list()">
								<span>목록</span>
							</button>	
							
							</c:otherwise>
							</c:choose>
							
						</div>
					</div>
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
</script>
