<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	String now = formatter.format(new java.util.Date());
	String devServer = "";
	pageContext.setAttribute("devServer",devServer);
%>
<script>

$(document).ready(function(){
		
	
	if ($("#tabGbn").val()=='B') {
		$("#imgDesc").css("display","none");		
	}else{
		$("#imgDesc").css("display","");
	}
	
	
});


function delFile(fileId,attachId){
	
	if (!confirm("파일을 삭제하시겠습니까?")) {
		return;		
	}
	
	 var data = new Object();
	 data.fileId = fileId;
	 data.attachId = attachId;
	 
	$.ajax({
		type: "POST",
		url: "/commonfile/deleteFile.do",
		data :data,
		dataType: 'json',
		success:function(data){
			if(data.success == "true"){
				alert(data.message);
				$("#uploadFile").css("display","");
				$("#uploadedFile").css("display","none");
			}else
			{
			alert("실패");
			}
		}
	});
}	

function imageInsert() {
	
	var url = '';
	
	url = $("#tabGbn").val() == "A"?"/back/main/insertMainImg.do":"/back/main/insertPopnoti.do";
			
	
	  $("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					list();
					closePopup();
				}
			},
			dataType: "json",
			url: url
	    });


}




function mainImgSave(){

	var url = '';
	
	url = $("#tabGbn").val() == "A"?"/back/main/updateMainImg.do":"/back/main/updatePopnoti.do";
			


	   $("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					list();
					closePopup();
				}
			},
			dataType: "json",
			url: url
	    });
}

function list(){
	jQuery("#mainAndPopup_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectMainandPopupListUrl,
		page : 1,
		postData : {			
			tabGbn : $("#tabGbn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
}



function mainImgDelete(useYn){
	
	

	if(!confirm('삭제하시겠습니까?')){
		return;
	}

	
	var url = '';
	
	url = $("#tabGbn").val() == "A"?"/back/main/deleteMainImg.do":"/back/main/deletePopnoti.do";
		


	   $("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					list();
					closePopup();
				}
			},
			dataType: "json",
			url: url
	    });
}

/* function deleteMainImage(){
	// 데이터를 삭제 처리해준다.
	$("#writeFrm").ajaxSubmit({
		url: deleteMainImgUrl,
		dataType: "json",
		success: function(responseText, statusText){
			//alert(responseText.message);
			if(responseText.success == "true"){
				mainImageInit();
				closePopup();
			}
		}
  	});
}

function changeImageSize(val){

	alert(val);

	if(val == ''){

		DEXT5UPLOAD.SetSize("", "","upload1");

	}else{

		var val1 = val.split("px").join('').split('*')[0];
		var val2 = val.split("px").join('').split('*')[1];

		DEXT5UPLOAD.SetSize(val1, val2,"upload1") ;
	}
} */
function setImgSize(obj){

	$("#imgSizeInfo").html(obj.naturalWidth + "px*" +  obj.naturalHeight + "px");
}
</script>
<form id="writeFrm" name="writeFrm" method="post"  enctype="multipart/form-data" data-parsley-validate="true"  >

	<input type='hidden' name='mainId' value="${param.mainId}" />
	<input type='hidden' name='imgId' value="${param.imgId}" />
	<input type='hidden' name='attachId' id='attachId' value="${mainImage.attachId}" />
	<input type='hidden' name='fileId' id='fileId' value="${mainImage.fileId}" />


	<input type='hidden' name='inFile'  id='inFile' value="" />
	<input type='hidden' name='delFile' id='delFile' value="" />

	<!-- search_area -->
	<%--		<c:if test="${USER_AUTH eq '999' }">
	<div class="search_area">
		<table class="search_box">
			<caption>통합검색 화면</caption>
			<colgroup>
				<col style="width: 80px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<tr>
				<th scope="row">
					타입 <img src="/images/back/common/bullet_important.png" alt="필수" />
				</th>
				<td>
					<select class="in_wp120" disabled="disabled">
						<option value="A"  <c:if test="${param.mainCd eq 'A'}">selected</c:if>>타입 A</option>
						<option value="B"  <c:if test="${param.mainCd eq 'B'}">selected</c:if>>타입 B</option>
						<option value="C"  <c:if test="${param.mainCd eq 'C'}">selected</c:if>>타입 C</option>
					</select>
				</td>
			</tr>
			</tbody>
		</table>
	</div> </c:if>--%>
	<!--// search_area -->
	<!-- table list -->
	<div class="table_area marginb10">
		<table class="write">
			<caption>이미지 등록 화면</caption>
			<colgroup>
				<col style="width: 24%;">
				<col style="width: *;">
			</colgroup>
			<tbody>
	<%-- 		<tr style="display:none;">
				<th scope="row">
					코드 <img src="/images/back/common/bullet_important.png" alt="필수" />
				</th>
				<td><c:if test="${param.mode eq 'E'}">${SITE.siteId}-${param.mainId}-${param.imgId}</c:if></td>
			</tr> --%>
			<tr>
				<th scope="row">
					<label for="input_img_name">
						제목
					</label>
				</th>
				<td>
					<input type="text" class="in_w100" id="title" name="title" value="${mainImage.title}"/>
					
				</td>
			</tr>		
			<tr id ="imgDesc">
				<th scope="row">
					<label for="input_img_alt">이미지설명</label>
				</th>
				<td>
					<input type="text" class="in_w100" id="imgDesc" name="imgDesc" value="${mainImage.imgDesc}"/>
				</td>
			</tr>
			
			<tr>
				<th scope="row">
					이미지 <img src="/images/back/common/bullet_important.png" alt="필수" />
				</th>
					<td>
						
		                 <p id="uploadedFile" style = '<c:if test="${empty mainImage.fileId}">display:none;</c:if>'>
		                 <a href="/commonfile/fileidDownLoad.do?fileId=${mainImage.fileId}&attachId=${mainImage.attachId}" >${mainImage.originFileNm}</a>
		                  <a href='javascript:delFile("${mainImage.fileId}","${mainImage.attachId}");' class="btn_file_delete"  title="파일 삭제">
										<img src="/images/back/icon/icon_delete.png" alt="삭제" />
						</a></p>		                   
		                 <div id = "uploadFile" style = '<c:if test="${!empty mainImage.fileId}">display:none;</c:if>'>
	  					 <input type="file" id="uploadFile" name="uploadFile" value="" class="in_w100"   />	  					 
						</div>
					</td>
				</tr>

			<%-- <c:if test="${param.mode eq 'E'}">
			<tr>
				<th scope="row">
					업로드 이미지
				</th>
				<td>
					<img src="${devServer}${mainImage.filePath}" alt="${mainImage.title}" height="150" onload="javascript:setImgSize(this);"/>
				</td>
			</tr>
			<tr>
				<th scope="row">
					사이즈
				</th>
				<td id="imgSizeInfo">

				</td>
			</tr>
			</c:if> --%>
				<tr>
				<th scope="row">
					<label for="input_img_name">
						URL
					</label>
				</th>
				<td>
					<input type="text" class="in_w100" id="url"  name="url" value="<c:if test ='${mainImage.url eq null}'>http://</c:if><c:if test ='${mainImage.url ne null}'>${mainImage.url}</c:if>"/>
				</td>
			</tr>
			<tr>
				<th scope="row">사용여부</th>
				<td>
					<input id="usey" name="useYn" type="radio" value="Y" <c:if test="${empty mainImage.useYn or mainImage.useYn eq 'Y'}">checked="checked"</c:if> >
					<label for="usey">사용</label>
					<input id="usen" name="useYn" type="radio" class="marginl15" value="N" <c:if test="${mainImage.useYn eq 'N'}">checked="checked"</c:if>>
					<label for="usen">미사용</label>
				</td>
			</tr>
			<tr>
				<th scope="row">
					등록자 <img src="/images/back/common/bullet_important.png" alt="필수" />
				</th>
				<td><c:choose><c:when test="${param.mode eq 'E'}">${mainImage.regUserNm}</c:when><c:otherwise>${USER.userNm}</c:otherwise></c:choose></td>
			</tr>
			<tr>
				<th scope="row">
					등록일 <img src="/images/back/common/bullet_important.png" alt="필수" />
				</th>
				<td><c:choose><c:when test="${param.mode eq 'E'}">${mainImage.regDt}</c:when><c:otherwise><%=now%></c:otherwise></c:choose></td>
			</tr>
			</tbody>
		</table>
	</div>
	</form>
	<!--// table list -->
		<!-- footer -->
			<div class="file_area" id="fileArea" style="display:none;">
					</div>
		<div id="footer">
		<footer>
			<div class="button_area alignc">
			   <c:if test="${param.mode eq 'W'}">
				<a href="javascript:imageInsert();" class="btn save" title="등록">
					<span>등록</span>
				</a>
			  </c:if>
                 <c:if test="${param.mode eq 'E' }">
                 	<a href="javascript:mainImgSave();" class="btn save" title="수정">
					<span>수정</span>
				</a>
				<a href="javascript:mainImgDelete('${mainImage.useYn}');" class="btn save" title="등록">
					<span>삭제</span>
				</a>
				</c:if>
				<a href="javascript:closePopup();" class="btn cancel" title="닫기">
					<span>취소</span>
				</a>
			</div>
		</footer>
		</div>
		<!-- //footer -->
