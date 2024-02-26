<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>



<script src="<c:url value='/dext5editor/js/dext5editor.js' />" charset="utf-8"></script>
<script>
var savedRow = null;
var savedCol = null;
var writeUrl = "<c:url value='/back/contents/visionpageWrite.do'/>";
var visionpageUpdateUrl =  "<c:url value='/back/contents/visionpageUpdate.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";



function visionUpdate()
{
	removeCss('editor');
	$("#contents").val(DEXT5.getBodyValue('editor'));

	var url = visionpageUpdateUrl;

	if ( $("#writeFrm").parsley().validate() ){
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
}

function list(){
	var f = document.writeFrm;

    f.target = "_self";
    f.action = writeUrl;
    f.submit();
}


function dext_editor_loaded_event() {

	addCss('editor');
	DEXT5.setBodyValue('${visionpageinfo.contents}','editor');

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
        <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
       <!-- <form id="writeFrm" name="writeFrm" method="post"  onsubmit="return false;" enctype="multipart/form-data"> -->
				<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
				<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
				<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
				<input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
				<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="<c:out value="${param.p_searchtxt}" escapeXml="true" />" />
			    <input type='hidden' id="p_satis_yn" name='p_satis_yn' value="${param.p_satis_yn}" />
				<input type='hidden' id="mode" name='mode' value="${param.mode}" />
			    <input type='hidden' id="page_id" name='page_id' value="${visioninfo.page_id}" />
			    <input type='hidden' id='contents' name = 'contents' value = '${visionpageinfo.contents}' />


			<!-- write_basic -->
			<div class="table_area">

				<div class="editor_area view">
			<%-- 	     <textarea class="form-control" id="contents" name="contents" placeholder="내용" rows="20" style="width:100%;height:400px;" >${visionpageinfo.contents}</textarea> --%>
				<script>
					var editor = new Dext5editor("editor");
				</script>
				</div>
			</div>
			<!--// write_basic -->

			<!-- button_area -->
			<div class="button_area">
				<div class="float_right">
					<a class="btn save" title="저장" onclick="visionUpdate()">
						<span>저장</span>
					</a>

				</div>
			</div>
			<!--// button_area -->

</form>
</div>
<!--// content -->
<!-- <script>

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

</script> -->

