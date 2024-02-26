<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<% java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	String now = formatter.format(new java.util.Date());
%>
<script src="<c:url value='/dext5upload/js/dext5upload.js' />" charset="utf-8"></script>
<script>
	$(document).ready(function(){
		if($("#p_region").val() == "1"){
			$("#img_txt").html("※ Visual Images : 가로 804px  x  세로 330px");
		}else if($("#p_region").val() == "2"){
			$("#img_txt").html("※ 바로가기 : 가로 85px  x  세로 70px");
		}else if($("#p_region").val() == "3"){
			$("#img_txt").html("※ 유관기관 : 가로 206px  x  세로 74px");
		}else{
			$("#img_txt").html("");
		}

	});


function DEXT5UPLOAD_OnCreationComplete(uploadID) {

		 DEXT5UPLOAD.SetMaxTotalFileCount('1', uploadID);
		 DEXT5UPLOAD.SetAllowOrLimitExtension(1, 'jpg,png,gif', uploadID);
		 DEXT5UPLOAD.SetMaxTotalFileSize('10MB', uploadID);
		 if ("${banner.fileId}"!=""){
			  DEXT5UPLOAD.AddUploadedFile('${banner.fileId}', '${banner.originFileNm}', '${banner.filePath}', '${banner.fileSize}','${banner.attachId}', uploadID);
		}
}



function fileTransfer(){

	<c:if test="${banner.sectionCd eq '1' or banner.sectionCd eq '4' or banner.sectionCd eq '5'  }">
	if (DEXT5UPLOAD.GetTotalFileCount("upload1")<1) {
		alert("배너 이미지를 등록해주세요");
		return false;
	}
	DEXT5UPLOAD.Transfer('upload1');
	</c:if>
	<c:if test = "${banner.sectionCd eq '2' or banner.sectionCd eq '3' or banner.sectionCd eq '7'}">
	bannerInsert();
	</c:if>


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
	bannerInsert();
}



</script>

<form id="writeFrm" name="writeFrm" method="post" data-parsley-validate="true" enctype="multipart/form-data">
<input type="hidden" id="image" name="image" value="${banner.image}" />
<input type='hidden' id="banner_id" name='banner_id' value="${banner.banner_id}" />
<input type='hidden' id="region" name='region' value="${banner.region}" />
<input type='hidden' id="cTabGbn" name = "cTabGbn" />
<input type='hidden' id="SectionCd" name = "cSectionCd" >
<input type ="hidden" id ="sectionCd2" name = "sectionCd2" value = "${banner.sectionCd}">
<input type='hidden' id="delFile" name = "delFile" />
<input type='hidden' id="inFile" name = "inFile" />
<input type='hidden' id="attachId" name = "attachId" value = "${banner.attachId}" />



			<!-- write_basic -->
		<div class="table_area">
			<table class="write">
				<caption>배너 등록화면</caption>
				<colgroup>
					<col style="width: 140px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<c:if test="${param.mode == 'E' }">
				<%-- <tr>
					<th scope="row">코드</th>
					<td>
                          ${banner.banner_id}
					</td>
				</tr> --%>
				</c:if>


				<tr>
					<th scope="row">제목<span class="asterisk">*</span></th>
					<td>
						<input class="in_w100" type="hidden" id="bannerId" name="bannerId" value="${banner.bannerId}" placeholder="(저장 후 자동생성)"  readonly="readonly"/>
					    <input class="in_w100" type="text" id="title" name="title" value="${banner.title}" placeholder="제목"  data-parsley-required="true" data-parsley-maxlength="100"  />
					</td>
				</tr>
<%-- 		<c:if test = '${banner.sectionCd eq "1"}'>
					<tr>
					<th scope="row">이미지 설명</th>
					<td>
					    <c:if test="${!empty banner.attachId}">
	                    <p id="uploadedFile"><a href="/commonfile/fileidDownLoad.do?file_id=${banner.attachId}" >${banner.originFileNm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile()"></a></p>
	                     </c:if>

                    	    <input class="in_w100" type="file" id="uploadFile" name="uploadFile" value="" /> </td>
				</tr>
				<tr>
				</c:if>
			 --%>
			 <c:if test = '${banner.sectionCd eq "1"}'>
					<tr>
					<th scope="row">배너 설명</th>
					<td>
						  <input class="in_w100" type="text"  id="alt" name="alt" value="${banner.alt}" data-parsley-required="true" data-parsley-maxlength="100"  />
					  </td>
				</tr>
				</c:if>
				<tr>
			 		<th scope="row">URL</th>
					<td>
						<label for="url" class="hidden">홈페이지 주소 입력</label>
						  <input class="in_w100" type="text" id="url" name="url" value="<c:if test = '${banner.url eq null}'>http://</c:if><c:if test = '${banner.url ne null}'>${banner.url}</c:if>" placeholder="http://" data-parsley-type="http"  data-parsley-maxlength="1000" />
					</td>
				</tr>
				<tr>
					<th scope="row">타겟설정</th>
					<td>
						<input name="targetCd" type="radio" value = "_self" <c:if test = "${banner.targetCd eq '_self'}">checked=checked</c:if> />현재창 열기
						<input name="targetCd" type="radio" value = "_blank" <c:if test = "${banner.targetCd eq '_blank'}">checked=checked</c:if> />새창 열기
					</td>
				</tr>
				<tr>
					<th scope="row">사용여부</th>
					<td>
						 <input type="radio" name="useYn" value="Y" <c:if test="${banner.useYn == 'Y'}">checked</c:if>> 사용
						 <input type="radio" name="useYn" value="N"  <c:if test="${banner.useYn == 'N'}">checked</c:if>> 미사용
					</td>
				</tr>
				<c:if test="${param.mode == 'E' }">
				<tr>
					<th scope="row">등록자</th>
					<td>
                               ${banner.regUserNm}
					</td>
				</tr>
				<tr>
					<th scope="row">등록일</th>
					<td>
                               ${banner.regDt}
					</td>
				</tr>
				</c:if>


				</tbody>
			</table>
		</div>

				<div style="display:none;">
						<input class="in_w100" type="text" id="sectionCd" name="sectionCd" value="${banner.sectionCd}" readonly="readonly"/>
				</div>
		<!--// write_basic -->
		<!-- footer -->
		<div id="footer">
		<footer>
			<div class="button_area alignc">
			   <c:if test="${param.mode == 'W'}">
				<a href="javascript:bannerInsert()" class="btn save" title="등록">
					<span>등록</span>
				</a>
			  </c:if>
                 <c:if test="${param.mode == 'E' }">
                 	<a href="javascript:bannerSave()" class="btn save" title="수정">
					<span>수정</span>
				</a>
				<a href="javascript:bannerDelete('${banner.bannerId}')" class="btn save" title="등록">
					<span>삭제</span>
				</a>
				</c:if>
				<a href="javascript:popupClose()" class="btn cancel" title="닫기">
					<span>취소</span>
				</a>
			</div>
		</footer>
		</div>
		<!-- //footer -->
</form>