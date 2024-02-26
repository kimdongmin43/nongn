<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>



<script src="<c:url value='/dext5editor/js/dext5editor.js' />" charset="utf-8"></script>
<script>
var savedRow = null;
var savedCol = null;
var writeUrl = "<c:url value='/back/contents/statutepageWrite.do'/>";
var statutepageUpdateUrl =  "<c:url value='/back/contents/statutepageUpdate.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";






function statuteUpdate()
{
	removeCss('editor1');
	removeCss('editor2');
	removeCss('editor3');
	$("#contents1").val(DEXT5.getBodyValue('editor1'));
	$("#contents2").val(DEXT5.getBodyValue('editor2'));
	$("#contents3").val(DEXT5.getBodyValue('editor3'));


	var url = statutepageUpdateUrl;

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

	addCss('editor1');
	addCss('editor2');
	addCss('editor3');
 	DEXT5.setBodyValue('${statutePageInfo.contents1}','editor1');
	DEXT5.setBodyValue('${statutePageInfo.contents2}','editor2');
	DEXT5.setBodyValue('${statutePageInfo.contents3}','editor3');
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
       	<form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
       	<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
					<div class="history_area">
						<ul class="history_list">
							<!-- row -->
							<%-- <input type = 'hidden' id = "${statutepageinfo.cont_id}_" name = '${statutepageinfo.page_id}_contents' value = '${statutepageinfo.contents}'> --%>
							<li>
								<div class="division">
									<dl class="dl_history">
										<dt class="history_title">
											제목 <strong class="color_pointr">*</strong>
										</dt>
										<dd class="history_memo">
											<label for="title1" class="hidden">제목 입력</label>
											<input id="title1" name="title1" type="text" class="in_w100" value = "${statutePageInfo.title1}" data-parsley-required="true"/>
										</dd>
									</dl>
									<div class="editor_area view">
											<input type= "hidden" id = "contId1" name = "contId1" value = '${statutePageInfo.contId1}'>
											<input type= "hidden" id = "contents1" name = "contents1" value = '${statutePageInfo.contents1}'>
				     						<script>
													var editor = new Dext5editor("editor1");
											</script>
									</div>
								</div>
							</li>
								<li>
								<div class="division">
									<dl class="dl_history">
										<dt class="history_title">
											제목 <strong class="color_pointr">*</strong>
										</dt>
										<dd class="history_memo">
											<label for="title2" class="hidden">제목 입력</label>
											<input id="title2" name="title2" type="text" class="in_w100" value = "${statutePageInfo.title2}" data-parsley-required="true"/>
										</dd>
									</dl>
									<div class="editor_area view">
											<input type= "hidden" id = "contId2" name = "contId2" value = '${statutePageInfo.contId2}'>
											<input type= "hidden" id = "contents2" name = "contents2" value = '${statutePageInfo.contents2}'>
				     						<script>
													var editor = new Dext5editor("editor2");
											</script>
									</div>
								</div>
							</li>
								<li>
								<div class="division">
									<dl class="dl_history">
										<dt class="history_title">
											제목 <strong class="color_pointr">*</strong>
										</dt>
										<dd class="history_memo">
											<label for="title3" class="hidden">제목 입력</label>
											<input id="title3" name="title3" type="text" class="in_w100" value = '${statutePageInfo.title3}' data-parsley-required="true"/>
										</dd>
									</dl>
									<div class="editor_area view">
											<input type= "hidden" id = "contId3" name = "contId3" value = '${statutePageInfo.contId3}'>
											<input type= "hidden" id = "contents3" name = "contents3" value = '${statutePageInfo.contents3}'>
				     						<script>
													var editor = new Dext5editor("editor3");
											</script>
									</div>
								</div>
							</li>


						</ul>
					</div>

					<!--// law_area -->
			<!-- button_area -->
			<div class="button_area">
				<div class="float_right">
					<a class="btn save" title="저장" onclick="statuteUpdate()">
						<span>저장</span>
					</a>

				</div>
			</div>
			<!--// button_area -->

</form>
</div>
<!--// content -->


