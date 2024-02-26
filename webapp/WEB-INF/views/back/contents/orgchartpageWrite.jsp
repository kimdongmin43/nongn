<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>


<script src="<c:url value='/dext5editor/js/dext5editor.js' />" charset="utf-8"></script>
<script src="<c:url value='/dext5upload/js/dext5upload.js' />" charset="utf-8"></script>
<script>
var savedRow = null;
var savedCol = null;

var writeUrl = "<c:url value='/back/contents/orgchartpageWrite.do'/>";
var orgchartpageUpdateUrl =  "<c:url value='/back/contents/orgchartpageUpdate.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";


function orgchartUpdate()
{
	
	var url = orgchartpageUpdateUrl;
	removeCss('editor');
	$("#contents").val(DEXT5.getBodyValue('editor'));
	
	
	
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						addCss('editor');
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
	 
		 if ("${orgchartPageInfo.fileId}"!=""){
			  DEXT5UPLOAD.AddUploadedFile('${orgchartPageInfo.fileId}', '${orgchartPageInfo.originFileNm}', '${orgchartPageInfo.filePath}', '${orgchartPageInfo.fileSize}', '${orgchartPageInfo.attachId}', uploadID);
		}
				 
}

function fileTransfer(){
	
	if (DEXT5UPLOAD.GetTotalFileCount("upload1")<1) {
		alert("사진파일은 필수 입력사항입니다.");
		return false;		
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
	orgchartUpdate();
}


function dext_editor_loaded_event() {    
	
	addCss('editor')
	DEXT5.setBodyValue($("#contents").val(),'editor');
   
   

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
       <form id="writeFrm" name="writeFrm" method="post"  onsubmit="return false;" enctype="multipart/form-data">			
			    <input type='hidden' id="contId" name='contId' value="${orgchartPageInfo.contId}" />			    
			    <input type='hidden' id="delFile" name = "delFile" />
			    <input type='hidden' id="inFile" name = "inFile" />
			    <input type='hidden' id="attachId" name = "attachId" value = "${orgchartPageInfo.attachId}" />
			    <input type='hidden' id="contents" name = "contents" value = '${orgchartPageInfo.contents}' />
			    <input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
			    
			<!-- write_basic -->
			<div class="table_area">
				  <table class="view">
					<caption>상세보기 화면</caption>
					<colgroup>
						<col style="width: 140px;" />
						<col style="width: *;" />
						<col style="width: 140px;" />
						<col style="width: *;" />
					</colgroup>
					<tbody>								
					<tr>
					<th scope="row">조직도 이미지  <strong class="color_pointr">*</strong></th>
					<td>
							<script>
				        			var dext5Upload = new Dext5Upload("upload1");
    							</script>
					</td>
				</tr>
					</tbody>
				</table>
				
				<div class="editor_area view">
				     	<script>
								var editor = new Dext5editor("editor");
						</script> 
				</div>
				
			</div>
			<!--// write_basic -->
			<!-- button_area -->
			<div class="button_area">
				<div class="float_right">				
					<a class="btn save" title="저장" onclick="fileTransfer();">
					
						<span>저장</span>
					</a>				
				
				</div>
			</div>
			<!--// button_area -->
	
			
		</form>
	</div>
<!--// content -->
