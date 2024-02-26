<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script src="<c:url value='/dext5editor/js/dext5editor.js' />" charset="utf-8"></script>
<script src="<c:url value='/dext5upload/js/dext5upload.js' />" charset="utf-8"></script>
<script>
var savedRow = null;
var savedCol = null;
var writeUrl = "<c:url value='/back/contents/localvisionpageWrite.do'/>";
var localvisionpageUpdateUrl =  "<c:url value='/back/contents/localvisionpageUpdate.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";





function valcheck(){

	if (DEXT5.getBodyValue('editor')==""){
		alert("내용은 필수 입력사항입니다.")
	}
	if (DEXT5UPLOAD.GetTotalFileCount("upload1")<1) {
		alert("AI 이미지 파일은 필수 입력사항입니다.")
		return false;
	}
	if (DEXT5UPLOAD.GetTotalFileCount("upload2")<1) {
		alert("이미지 파일은 필수 입력사항입니다.")
		return false;
	}

	return true;
}


function localvisionUpdate(){

	removeCss('editor');
	removeCss('editor2');
		   $("#contents").val(DEXT5.getBodyValue('editor'));
		   $("#contents2").val(DEXT5.getBodyValue('editor2'));

		   $("#writeFrm").ajaxSubmit({

				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						list();
					}
				},
				dataType: "json",
				url: localvisionpageUpdateUrl
		    });

}

function list(){
	var f = document.writeFrm;

    f.target = "_self";
    f.action = writeUrl;
    f.submit();
}



function dext_editor_loaded_event() {

	addCss('editor');
	addCss('editor2');

	    DEXT5.setBodyValue('${localVisionPageInfo.contents}','editor');

	    /* alert('${localVisionPageInfo.contents2}'); */
	    <c:if test = "${USER.userCd eq '999'}">
	    DEXT5.setBodyValue('${masterVisionPageInfo.contents2}','editor2');
	    </c:if>

	   //DEXT5.setBodyValue('&lt  &gt d &lt /ul &gt','editor');
	   //DEXT5.setHtmlValue('&lt  &gt d &lt /ul &gt','editor');

}
function DEXT5UPLOAD_OnCreationComplete(uploadID) {

	 DEXT5UPLOAD.SetMaxTotalFileCount('1', uploadID);
	 DEXT5UPLOAD.SetSize('100%','150',uploadID);
	 DEXT5UPLOAD.SetMaxTotalFileSize('10MB', uploadID);
	 if(uploadID=='upload1'){
		 DEXT5UPLOAD.SetAllowOrLimitExtension(1, 'ai', uploadID)
		 }else {
			 DEXT5UPLOAD.SetAllowOrLimitExtension(1, 'jpg,png,gif', uploadID)
			 };

		 if (uploadID=="upload1"&&"${localVisionPageInfo.picFileId}"!=""){

			DEXT5UPLOAD.AddUploadedFile('${localVisionPageInfo.picFileId}', '${localVisionPageInfo.picOriginFileNm}', '${localVisionPageInfo.picPath}', '${localVisionPageInfo.picFileSize}', '${localVisionPageInfo.picAttachId}', uploadID);
		}
		else if (uploadID=="upload2" && "${localVisionPageInfo.sinFileId}"!=""){
			DEXT5UPLOAD.AddUploadedFile('${localVisionPageInfo.sinFileId}', '${localVisionPageInfo.sinOriginFileNm}', '${localVisionPageInfo.sinPath}', '${localVisionPageInfo.sinFileSize}', '${localVisionPageInfo.sinAttachId}', uploadID);
		}

}
function fileTransfer()
{

	if (!valcheck()) {
		return;
	}
	DEXT5UPLOAD.Transfer('upload1');

}


function DEXT5UPLOAD_OnTransfer_Complete(uploadID) {


	var del_file_list = DEXT5UPLOAD.GetDeleteListForJson(uploadID);
	var in_file_list = DEXT5UPLOAD.GetNewUploadListForJson(uploadID);
	$("#delFile").val(JSON.stringify(del_file_list));
	$("#inFile").val(JSON.stringify(in_file_list));

if (uploadID == "upload1") {
	if ($("#picAttachId").val()==null || $("#picAttachId").val()=="") {
		$.ajax({
			type: "POST",
			url: "/common/file/insertFile.do",
			data :$("#writeFrm").serialize(),
			dataType: 'json',
			async : false,
			success:function(data){
				if(data.success == "true"){
					$("#picAttachId").val(data.attachId);
				}
				else 	alert("실패");
			}
		});
	}else{
		$("#attachId").val($("#picAttachId").val());
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
}
if (uploadID == "upload2") {
	if ($("#sinAttachId").val()==null || $("#sinAttachId").val()=="") {
		$.ajax({
			type: "POST",
			url: "/common/file/insertFile.do",
			data :$("#writeFrm").serialize(),
			dataType: 'json',
			async : false,
			success:function(data){
				if(data.success == "true"){
					$("#sinAttachId").val(data.attachId);
				}else 	alert("실패");
			}
		});
	}else{
		$("#attachId").val($("#sinAttachId").val());
		$.ajax({
			type: "POST",
			url: "/common/file/updateFile.do",
			data :$("#writeFrm").serialize(),
			dataType: 'json',
			async : false,
			success:function(data){

				if(data.success == "true"){
				}else 	alert("실패");
			}
		});

	}
}
if (uploadID=="upload1"&& DEXT5UPLOAD.GetUploadCompleteState('upload1')==true) {
	DEXT5UPLOAD.Transfer('upload2');

}
 if(DEXT5UPLOAD.GetUploadCompleteState('upload1')==true && DEXT5UPLOAD.GetUploadCompleteState('upload2')==true){
	 localvisionUpdate();
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
       <form id="writeFrm" name="writeFrm" method="post"  onsubmit="return false;" enctype="multipart/form-data">
       			<input type='hidden' id="contents" name = "contents" value = '${localVisionPageInfo.contents}' />
       			<input type='hidden' id="contents2" name = "contents2" value = '${localVisionPageInfo.contents2}' />
				<input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
				<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="<c:out value="${param.p_searchtxt}" escapeXml="true" />" />
			    <input type='hidden' id="p_satis_yn" name='p_satis_yn' value="${param.p_satis_yn}" />
				<input type='hidden' id="mode" name='mode' value="${param.mode}" />
				<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
			    <input type='hidden' id="contId" name='contId' value="${localVisionPageInfo.contId}"/>
			    <input type='hidden' id="contId2" name='contId2' value="${masterVisionPageInfo.contId2}"/>
			    <input type='hidden' id="limit" name='limit' value="${USER.userCd}"/>
			    <input type='hidden' id="picAttachId" name = "picAttachId" value = '${localVisionPageInfo.picAttachId}' />
			    <input type='hidden' id="sinAttachId" name = "sinAttachId" value = '${localVisionPageInfo.sinAttachId}' />
			    <input type='hidden' id="delFile" name = "delFile" />
			    <input type='hidden' id="inFile" name = "inFile" />
			    <input type='hidden' id="attachId" name = "attachId" />



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
					<th scope="row">AI 이미지 <strong class="color_pointr">*</strong></th>
					<td>
						<script>
				        					var dext5Upload = new Dext5Upload("upload1");
    							</script>
						<p class="margint5 color_pointo"> 가로 000px / 세로 000px 권장 사이즈이며, jpg, png, gif 확장자만 사용 가능합니다.</p>
					</td>
				</tr>
				<tr>
					<th scope="row">JPG 이미지 <strong class="color_pointr">*</strong></th>
					<td>	<script>

				        					var dext5Upload = new Dext5Upload("upload2");
    							</script>
						<p class="margint5 color_pointo"> 가로 000px / 세로 000px 권장 사이즈이며, jpg, png, gif 확장자만 사용 가능합니다.</p>
					</td>
				</tr>

					</tbody>
				</table>
				<c:if test = "${USER.userCd eq '999'}">
				<h2 class="main_title">공통영역</h2>
				<div class="editor_area view">
				     <%-- <textarea class="form-control" id="contents2" name="contents2" placeholder="내용" rows="20" style="width:100%;height:400px;" >${masterVisionPageInfo.contents2}</textarea> --%>
				    <script>
						var editor = new Dext5editor("editor2");

					</script>
				</div>
				<h2 class="main_title">지역영역</h2>
				</c:if>


				<div class="editor_area view">
				     <%-- <textarea class="form-control" id="contents" name="contents" placeholder="내용" rows="20" style="width:100%;height:400px;" >${localVisionPageInfo.contents}</textarea> --%>
				    <script>
						var editor = new Dext5editor("editor");
					</script>
				</div>
			</div>
			<!--// write_basic -->

			<!-- button_area -->
			<div class="button_area">
				<div class="float_right">
					<a class="btn save" title="저장" onclick="fileTransfer()">
						<span>저장</span>
					</a>

				</div>
			</div>
			<!--// button_area -->
</form>
</div>
<!--// content -->


