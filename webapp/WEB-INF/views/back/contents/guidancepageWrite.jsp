<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var savedRow = null;
var savedCol = null;
var writeUrl = "<c:url value='/back/contents/guidancepageWrite.do'/>";
var guidancepageUpdateUrl =  "<c:url value='/back/contents/guidancepageUpdate.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";


$(document).ready(function(){	
	

});


function guidanceUpdate()
{

	var url = guidancepageUpdateUrl;	
		
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
			<!-- write_basic -->
			<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
			<div class="table_area">
				  <table class="view">
					<caption>등록 화면</caption>
					<colgroup>
						<col style="width: 200px;" />
						<col style="width: *;" />										
					</colgroup>
					<tbody>			
					<tr>
						<th scope="row" style = "vertical-align: middle"><label for = "title1"><input type = "text" class = "in_w90" id = "title1" name = "title1"   value = "${guidancePageInfo.title1}" data-parsley-required="true" /><strong class="color_pointr">*</strong></label></th>
							<td>
								<input type = "hidden" id = "contId1" name = "contId1" value = "${guidancePageInfo.contId1}">
								<textarea  class="in_w100" id="contents1" name = "contents1" placeholder="설립목적" title = "설립목적 내용 입력" style="width:100%;resize:none"  rows="4"   data-parsley-maxlength="4000" >${guidancePageInfo.contents1}</textarea>
							</td>
					</tr>					
					<tr>
						<th scope="row"  style = "vertical-align: middle" ><label for = "title2"><input type = "text" class = "in_w90" id = "title2" name = "title2"   value = "${guidancePageInfo.title2}" data-parsley-required="true"/><strong class="color_pointr">*</strong></label></th>
							<td>
								<input type = "hidden" id = "contId2" name = "contId2" value = "${guidancePageInfo.contId2}">
								<textarea  class="in_w100" id="contents2" name = "contents2" placeholder="공공 경제단체" title = "공공 경제단체 내용 입력" style="width:100%;resize:none"  rows="4"   data-parsley-maxlength="4000" >${guidancePageInfo.contents2}</textarea>
							</td>
					</tr>
					<tr>
						<th scope="row"  style = "vertical-align: middle"><label for = "title3"><input type = "text"  class = "in_w90" id = "title3" name = "title3"   value = "${guidancePageInfo.title3}" data-parsley-required="true"/><strong class="color_pointr">*</strong></label></th>
							<td>
								<input type = "hidden" id = "contId3" name = "contId3" value = "${guidancePageInfo.contId3}">
								<textarea  class="in_w100" id="contents3" name = "contents3" placeholder="종합 경제단체" title = "종합 경제단체 내용 입력" style="width:100%;resize:none"  rows="4"   data-parsley-maxlength="4000" >${guidancePageInfo.contents3}</textarea>
							</td>
					</tr>
					<tr>
						<th scope="row"  style = "vertical-align: middle"><label for = "title4"><input type = "text" class = "in_w90" id = "title4" name = "title4"   value = "${guidancePageInfo.title4}" data-parsley-required="true"/><strong class="color_pointr">*</strong></label></th>
							<td>
								<input type = "hidden" id = "contId4" name = "contId4" value = "${guidancePageInfo.contId4}">
								<textarea  class="in_w100" id="contents4" name = "contents4" placeholder="지역에 기반을둔 단체" title = "지역에 기반을둔 단체 내용 입력" style="width:100%;resize:none"  rows="4"   data-parsley-maxlength="4000" >${guidancePageInfo.contents4}</textarea>
							</td>
					</tr>
					<tr>
						<th scope="row"  style = "vertical-align: middle"><label for = "title5"><input type = "text" class = "in_w90" id = "title5" name = "title5"   value = "${guidancePageInfo.title5}" data-parsley-required="true" /><strong class="color_pointr">*</strong></label></th>
							<td>
								<input type = "hidden" id = "contId5" name = "contId5" value = "${guidancePageInfo.contId5}">
								<textarea  class="in_w100" id="contents5" name = "contents5" placeholder="범 세계적인 경제단체" title = "범 세계적인 경제단체 내용 입력" style="width:100%;resize:none"  rows="4"   data-parsley-maxlength="4000" >${guidancePageInfo.contents5}</textarea>
							</td>
					</tr>
					<tr>
						<th scope="row"  style = "vertical-align: middle"><label for = "title6"><input type = "text" class = "in_w90" id = "title6" name = "title6"   value = "${guidancePageInfo.title6}" data-parsley-required="true" /><strong class="color_pointr">*</strong></label></th>
							<td>
								<input type = "hidden" id = "contId6" name = "contId6" value = "${guidancePageInfo.contId6}">
								<textarea  class="in_w100" id="contents6" name = "contents6" placeholder="업계를 선도하는 경제단체" title = "업계를 선도하는 경제단체 내용 입력" style="width:100%;resize:none"  rows="4"   data-parsley-maxlength="4000" >${guidancePageInfo.contents6}</textarea>
							</td>
					</tr>
					
					</tbody>
				</table>				
			</div>
			<!--// write_basic -->
			<!-- button_area -->
			<div class="button_area">
				<div class="float_right">				
					<a class="btn save" title="저장" onclick="guidanceUpdate()">
						<span>저장</span>
					</a>				
				
				</div>
			</div>
			<!--// button_area -->
</form>
</div>
<!--// content -->
<script>


	
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

