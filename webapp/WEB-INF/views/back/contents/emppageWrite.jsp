<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<% java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	String now = formatter.format(new java.util.Date());
%>

<script src="<c:url value='/dext5upload/js/dext5upload.js' />" charset="utf-8"></script>

<script>
var insertEmppageUrl = "<c:url value='/back/contents/insertEmppage.do'/>";
var updateEmppageUrl = "<c:url value='/back/contents/updateEmppage.do'/>"
var deleteEmppageUrl = "<c:url value='/back/contents/deleteEmppage.do'/>";


function emppageListPage() {
    var f = document.writeFrm;
    
    f.target = "_self";
    f.action = "/back/contents/emppageListPage.do";
    f.submit();
}
function valcheck(){
	
	if(!$("#writeFrm").parsley().validate())
		{
		return false;
		}	
	
	
	if (DEXT5UPLOAD.GetTotalFileCount("upload1")<1) {
		alert("사진파일은 필수 입력사항입니다.");
		return false;		
	}
	
	
	return true;
}

function DEXT5UPLOAD_OnCreationComplete(uploadID) { 
	
	 DEXT5UPLOAD.SetMaxTotalFileCount('1', uploadID);
	 DEXT5UPLOAD.SetSize('100%','150',uploadID);
	 DEXT5UPLOAD.SetAllowOrLimitExtension(1, 'jpg,png,gif', uploadID);
	 DEXT5UPLOAD.SetMaxTotalFileSize('10MB', uploadID);
	 
		 if ("${empPageInfo.fileId}"!=""){
			  DEXT5UPLOAD.AddUploadedFile('${empPageInfo.fileId}', '${empPageInfo.originFileNm}', '${empPageInfo.path}', '${empPageInfo.fileSize}', '${empPageInfo.attachId}', uploadID);
		}
				 
}

function emppageInsert(){

	if ( $("#writeFrm").parsley().validate() ){   
	var mode = $("#empId").val()==""?"W":"E";
	$("#mode").val(mode);
	
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						emppageListPage();
  					}	
  				},
  				dataType: "json", 				
  				url: insertEmppageUrl
  		    });	
		   
	   }
}

function emppageDelete(){
	
	if (!confirm("정말 삭제하시겠습니까?")) {
		return;
	}
	
	  $("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					emppageListPage();
				}	
			},
			dataType: "json", 				
			url: deleteEmppageUrl
	    });	
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
	emppageInsert();
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
				<input type='hidden' id="contents" name='contents' value=' ${emppage.contents}' />
				<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
				<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
				<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
				<input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
				<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="<c:out value="${param.p_searchtxt}" escapeXml="true" />" />
			    <input type='hidden' id="p_satis_yn" name='p_satis_yn' value="${param.p_satis_yn}" />
				<input type='hidden' id="mode" name='mode' value="${param.mode}" />
			    <input type='hidden' id="empId" name='empId' value="${empPageInfo.empId}" />
			    <input type='hidden' id="delFile" name = "delFile" />
			    <input type='hidden' id="inFile" name = "inFile" />
			    <input type='hidden' id="attachId" name = "attachId" value = "${empPageInfo.attachId}" />
			    
			    
		<div id="content">
	<!-- table_area -->
					<div class="table_area">
						<table class="write">
							<caption>등록 화면</caption>
							<colgroup>
								<col style="width: 140px;">
								<col style="width: *;">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">
									<label for="empNm">임직원명 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="empNm" name="empNm" type="text" class="in_w100" data-parsley-required="true" value = "${empPageInfo.empNm}"/>
									
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="deptId">담당업무 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<select id="deptId" name = "deptId" class="in_wp150" data-parsley-required="true">
										<c:forEach items="${empDeptList}" var="empDeptList" >										
										<option value="${empDeptList.deptId}" <c:if test = "${empPageInfo.deptId eq empDeptList.deptId}"> selected = selected</c:if> >${empDeptList.deptNm}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="rankId">직위 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<select id="rankId" name = "rankId" class="in_wp150" data-parsley-required="true">
										<c:forEach items="${empRankList}" var = "empRankList">
										<option value="${empRankList.rankId}"  <c:if test = "${empPageInfo.rankId eq empRankList.rankId }"> selected = selected</c:if> >${empRankList.rankNm}</option>
										</c:forEach>										
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">사진 <strong class="color_pointr">*</strong></th>
								<td>
										<script>
						        			var dext5Upload = new Dext5Upload("upload1");
		    							</script>
									<p class="margint5 color_pointo">가로 000px / 세로 000px 권장 사이즈이며, jpg, png, gif 확장자만 사용 가능합니다.</p>
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<!--// table_area -->
					<!-- button_area -->
					<div class="button_area">
						<div class="float_right">
							<a class="btn save" title="저장하기" onclick="fileTransfer()">
								<span>저장</span>
							</a>
							<c:if test="${empPageInfo.empId.toString() ne null }">
							<a class="btn save" title="삭제하기" onclick="emppageDelete()">
								<span>삭제</span>
							</a>
							</c:if>
							<a class="btn list" title="목록" onclick="emppageListPage()">
								<span>목록</span>
							</a>
						</div>
					</div>
					<!--// button_area -->
					</div>
</form>
</div>
<!--// content -->
