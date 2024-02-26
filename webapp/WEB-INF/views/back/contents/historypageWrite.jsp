<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>



<script src="<c:url value='/dext5editor/js/dext5editor.js' />" charset="utf-8"></script>
<script>

var createpageId = "<c:url value='/back/contents/historypageCreatepageId.do'/>";
var writeUrl = "<c:url value='/back/contents/historypageWrite.do'/>";
var historypageUpdateUrl =  "<c:url value='/back/contents/historypageUpdate.do'/>";
var historypageDeleteUrl =  "<c:url value='/back/contents/historypageDelete.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";
var editor_index = 0;
var editor_gubun = 'N';
var savedRow = null;
var savedCol = null;



$(document).on("click","#chkbox",function(){

	var searchIDs = $("INPUT[id=chkbox]:checkbox:checked").map(function(){
	 	return $(this).val();
	 	}).get();
	 	$("#check").val(searchIDs);

});

function historyUpdate()
{

	var url = historypageUpdateUrl;

	for (var  i = 1;  i <= editor_index;  i++) {

		$("#contents"+i).val(DEXT5.getBodyValue('editor_'+i));
		removeCss('editor_'+i);
	}

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

		if (editor_gubun!='Y') {
		<c:forEach items="${historypageinfo}" var = "historypageinfo" varStatus="status">
				DEXT5.setBodyValue('${historypageinfo.contents}','editor_${status.index+1}');
				addCss('editor_${status.index+1}');
		</c:forEach>
		}
}

function createEditor(editor_index){



	var holder = 'editorHoder_PlaceHolder'+editor_index;
	DEXT5.config.EditorHolder = holder;
	DEXT5.config.Height = "350px";
	var editor = new Dext5editor("editor_"+editor_index);
	editor_gubun = 'Y';

}
function addHistroy(){

	var pageId = "";
	editor_index++;
	var html = '<li>'
				+ '<label for="chkbox" class="hidden">선택</label>'
				+ '<input id="chkbox" name = "chkbox" type="checkbox"  class="float_left marginr20" value = "'+pageId+'" />'
				+ '<input name = "chk" type="hidden"  class="float_left marginr20" value= "'+pageId+'" />'
				+ '<input name = "sort" type="hidden"  class="float_left marginr20" value= "'+editor_index+'" />'
				+ '<input type = "hidden" id = "contents'+editor_index+'"name ="contents" value=""/>'
				+ '<div class="division">'
				+ '<dl class="dl_history">'
				+ '<dt class="history_title">'
				+ '연혁구분 <strong class="color_pointr">*</strong>'
				+ '</dt>'
				+ '<dd class="history_memo">'
				+ '<label for="in_history1" class="hidden">연도 입력</label>'
				+ '<input id="in_history1" name="title" type="text" class="in_w100" data-parsley-required="true" />'
				+ '</dd>'
				+ '	</dl>'
				+ '<div class="editor_area" id="editorHoder_PlaceHolder'+editor_index+'">'
				+ '</div>'
				+ '</div>'
				+ '</li>';
	var test = $("#ulclass").html();
	$("#ulclass").append(html);
	createEditor(editor_index);
}

function delHistory(){
	//$("INPUT[id=chkbox]:checkbox:checked").parent().parent().remove();
 	var url = historypageDeleteUrl
	if ($("#check").val()=='') {
		alert("삭제할 연혁을 선택해주세요.");
		return;
	}
	if (!confirm("정말 삭제하시겠습니까?")) {
		return;
	}
	   var data = new Object();
		data.contId=$("#check").val();
	    $.ajax({
		    url : url,
		    type : "POST",
		    cache : false,
		    data : data,
		    dataType : "json",
		    async : false,
		    success : function(responseText, statusText) {
		    	alert(responseText.message);
		    	list();
		    	},
		    	error : function(responseText, statusText){
		    	alert(responseText.message);
		    	list();
		    	}
		    	});
}

function AjaxPageLoad(pageUrl) {

    $.ajax({
        url: pageUrl,
        dataType: "html",
        contentType: "application/x-www-form-urlencoded",
        success: function (data) {
            $("#maincontent").html(data);
        }
    });

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
					<div class="division marginb10 alignr">
						<a class="btn none marginl20" title="추가하기" onclick="addHistroy()">
							<span><img src="../../../images/back/common/btn_file_add1.png" alt="추가하기" /> 추가</span>
						</a>
						<a class="btn none" title="삭제하기" onclick="delHistory()">
							<span><img src="../../../images/back/common/btn_file_delete1.png" alt="삭제하기" /> 삭제</span>
						</a>
					</div>
					<!-- history_area -->
					<div class="history_area">
						<ul class="history_list" id = "ulclass">
						<!-- row -->
						<c:forEach items="${historypageinfo}" var="historypageinfo" varStatus="status">
							<li>
								<label for="chkbox" class="hidden">선택</label>
								<input id="chkbox" type="checkbox" name = "chkbox" class="float_left marginr20" value ="${historypageinfo.contId}" />
								<input type = 'hidden' id = "chk" name ="chk" value="${historypageinfo.contId}"/>
								<input type = 'hidden' id = "sort" name ="sort" value="${historypageinfo.sort}"/>
								<input type = 'hidden' id = "contents${status.index+1}"name ="contents" value='${historypageinfo.contents}' />
								<div class="division">
									<dl class="dl_history">
										<dt class="history_title">
											연혁구분 <strong class="color_pointr">*</strong>
										</dt>
										<dd class="history_memo">
											<label for="in_history1" class="hidden">연도 입력</label>
											<input id="in_history1" name="title" type="text" class="in_w100" value ="${historypageinfo.title}" data-parsley-required="true" />
										</dd>
									</dl>
									<div class="editor_area">
										<script>

												DEXT5.config.Height = "350px";

												var editor = new Dext5editor("editor_${status.index+1}");

												editor_index = "${status.index+1}";
										</script>
									</div>
								</div>
							</li>
							</c:forEach>
							<!--// row -->
						</ul>
					</div>
					<input type="hidden" id="check">
					<!--// law_area -->
			<!-- button_area -->
			<div class="button_area">
				<div class="float_right">
					<button type="button" class="btn save" title="저장" onclick="historyUpdate()">
						<span>저장</span>
					</button>

				</div>
			</div>
			<!--// button_area -->

</form>
</div>
<!--// content -->


