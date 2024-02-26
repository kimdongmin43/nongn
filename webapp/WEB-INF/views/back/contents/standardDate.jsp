<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>



<script src="<c:url value='/smarteditor2/js/HuskyEZCreator.js' />" charset="utf-8"></script>
<script language="javascript">
var savedRow = null;
var savedCol = null;
var writeUrl = "<c:url value='/back/contents/standardDate.do'/>";



$(document).ready(function(){



});


function standardDateUpdate()
{


	var url = "/back/code/updateCode.do";




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




	<div id="content">
					<!-- title_and_info_area -->
					<div class="title_and_info_area">
						<!-- main_title -->
						<div class="main_title">
							<h3 class="title">${MENU.menuNm}</h3>
						</div>
						<!--// main_title -->
					</div>
					<!--// title_and_info_area -->
					<!-- table write -->
					<form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
					<input type = "hidden" id = "codeDesc" name = "codeDesc" value = "${standardDateParam.codeDesc}" >
					<input type = "hidden" id = "use_yn" name = "use_yn" value = "${standardDateParam.use_yn}">
					<input type = "hidden" id = "codeId" name = "codeId" value = "${standardDateParam.codeId}">
					<input type = "hidden" id = "mstId" name = "mstId" value = "${standardDateParam.mstId}">
					
									
					
					<div class="table_area">
						<table class="write">
							<caption>하단정보 등록 화면</caption>
							<colgroup>
								<col style="width: 150px;">
								<col style="width: *;">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">
									<label for="addr">
										기준일 <img src="../../../images/back/common/bullet_important.png" alt="필수" />
									</label>
								</th>
								<td>
									<input type="text" class="in_w100" id="codeNm" name = "codeNm" value = "${standardDateParam.codeNm}" maxlength="100" data-parsley-required="true" />
								</td>							
							</tbody>
						</table>
					</div>
					<!--// table write -->
					<!-- button_area -->
					<div class="button_area">
						<div class="float_right">
							<a class="btn save" title="저장" onclick="standardDateUpdate()">
								<span>저장</span>
							</a>
						</div>
					</div>
					</form>
					<!--// button_area -->
				</div>

<!--// content -->


