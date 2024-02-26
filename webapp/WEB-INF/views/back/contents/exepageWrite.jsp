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
var insertExepageUrl = "<c:url value='/back/contents/insertExepage.do'/>";
var deleteExepageUrl = "<c:url value='/back/contents/deleteExepage.do'/>";



function exepageListPage() {
    var f = document.writeFrm;
    
    f.target = "_self";
    f.action = "/back/contents/exepageListPage.do";
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

function exepageInsert(){

	
		   // 데이터를 등록 처리해준다.
		   
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						exepageListPage();
  					}	
  				},
  				dataType: "json", 				
  				url: insertExepageUrl
  		    });	
		   
	   
}

function exepageDelete(){
	
	if (!confirm("정말 삭제하시겠습니까?")) {
		return;
	}
	
	  $("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					exepageListPage();
				}	
			},
			dataType: "json", 				
			url: deleteExepageUrl
	    });	
}

function DEXT5UPLOAD_OnCreationComplete(uploadID) { 
	
	 DEXT5UPLOAD.SetMaxTotalFileCount('1', uploadID);
	 DEXT5UPLOAD.SetSize('100%','150',uploadID);
	 DEXT5UPLOAD.SetAllowOrLimitExtension(1, 'jpg,png,gif', uploadID);
	 DEXT5UPLOAD.SetMaxTotalFileSize('10MB', uploadID);
	 
		 if ("${exePageInfo.fileId}"!=""){
			  DEXT5UPLOAD.AddUploadedFile('${exePageInfo.fileId}', '${exePageInfo.originFileNm}', '${exePageInfo.path}', '${exePageInfo.fileSize}', '${exePageInfo.attachId}', uploadID);
		}
				 
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
	exepageInsert();
}

</script>

<!--// content -->
<div id="content">
	<!-- title_and_info_area -->
	<div class="title_and_info_area">
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title"> <c:if test="${exePageInfo.exeCd eq '1'}">임원 등록/수정</c:if><c:if test="${exePageInfo.exeCd eq '2'}">의원 등록/수정</c:if></h3>
		</div>
		<!--// main_title -->
		 <jsp:include page="/WEB-INF/views/back/menu/menuDescInclude.jsp"/>
		</div>
    	 <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
				<input type='hidden' id="contents" name='contents' value=' ${exepage.contents}' />
				<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
				<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
				<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
				<input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
				<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="<c:out value="${param.p_searchtxt}" escapeXml="true" />" />
			    <input type='hidden' id="p_satis_yn" name='p_satis_yn' value="${param.p_satis_yn}" />
				<input type='hidden' id="mode" name='mode' value="${param.mode}" />
			    <input type='hidden' id="exeId" name='exeId' value="${exePageInfo.exeId}" />
			    <input type='hidden' id="delFile" name = "delFile" />
			    <input type='hidden' id="inFile" name = "inFile" />
			    <input type='hidden' id="attachId" name = "attachId" value = "${exePageInfo.attachId}" />
			    
			    
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
									<label for="exeNm">
										<c:choose>
									    	<c:when test="${exePageInfo.exeCd eq '1'}">
									    	임원명
									    	</c:when>
									    	<c:when test="${exePageInfo.exeCd eq '2'}">
									    	의원명
									    	</c:when>
			    						</c:choose>
			    						<strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="exeNm" name="exeNm" type="text" class="in_w100" data-parsley-required="true" value = "${exePageInfo.exeNm}" />
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="companyNm">회사명 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="companyNm" name="companyNm" type="text" class="in_w100" data-parsley-required="true" value ="${exePageInfo.companyNm}" />
								</td>
							</tr>
							<tr>
								
									<c:choose>
									    	<c:when test="${exePageInfo.exeCd eq '1'}">
									    		<th scope="row">
														<label for="rankId">			
									    					임원 직위
									    				<strong class="color_pointr">*</strong></label>
									    		</th>
									    				<td>								
															<select id="rankId" name = "rankId" class="in_wp150" data-parsley-required="true">
																<c:forEach items = "${exeRankList}" var ="exeRankList">
																<option value="${exeRankList.rankId}" <c:if test="${exeRankList.rankId.toString() eq exePageInfo.rankId}">selected : selected</c:if>  >${exeRankList.rankNm}</option>
																</c:forEach>
															</select>
														</td>									    		
									    	</c:when>
									    	<c:when test="${exePageInfo.exeCd eq '2'}">
									    					<input type = "hidden" name = "rankId" value = ""> 
									    	</c:when>
			    						</c:choose>
							</tr>
							<tr style="display: none;">
								<th scope="row">임원/의원 구분</th>
								<td>
									<input type = "text" id = "exeCd" name = "exeCd" value = "${exePageInfo.exeCd}">
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="rankNm">회사 직위 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="rankNm" name="rankNm" type="text" class="in_w100" data-parsley-required="true" value = "${exePageInfo.rankNm}"/>
								</td>
							</tr>
							<tr>
								<th scope="row">연락처 <strong class="color_pointr">*</strong></th>
								<td>
									<label for="tel1" class="hidden">통신사 및 국번 입력</label>
									<input id="tel1" name="tel1" type="text" class="in_wp70" data-parsley-type="digits" data-parsley-required="true" maxlength="3" value = "${exePageInfo.tel1}" />
									-
									<label for="tel2" class="hidden">앞자리 번호 입력</label>
									<input id="tel2" name="tel2" type="text" class="in_wp70" data-parsley-type="digits" data-parsley-required="true" maxlength="4" value = "${exePageInfo.tel2}"/>
									-
									<label for="tel3" class="hidden">뒷자리 번호 입력</label>
									<input id="tel3" name="tel3" type="text" class="in_wp70"  data-parsley-type="digits" data-parsley-required="true" maxlength="4" value = "${exePageInfo.tel3}"/>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="homepage">홈페이지 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="homepage" name="homepage" type="text" class="in_w100" data-parsley-required="true"  value = "${exePageInfo.homepage}"/>
								</td>
							</tr>
							<tr>
								<th scope="row">사진 <strong class="color_pointr">*</strong></th>
								<td>
								<script>
				        					var dext5Upload = new Dext5Upload("upload1");
    							</script>
									<p class="margint5 color_pointo"> 가로 000px / 세로 000px 권장 사이즈이며, jpg, png, gif 확장자만 사용 가능합니다.</p>
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<!--// table_area -->
					<!-- button_area -->
					<div class="button_area">
						<div class="float_right">
							<a class="btn save" title="저장하기" onclick="fileTransfer()()">
								<span>저장</span>
							</a>
							<c:if test="${exePageInfo.exeId.toString() ne 'W' }">
							<a class="btn save" title="삭제하기" onclick="exepageDelete()">
								<span>삭제</span>
							</a>
							<a class="btn list" title="목록" onclick="exepageListPage()">
								<span>목록</span>
							</a>
							</c:if>
						</div>
					</div>
					<!--// button_area -->			
				</div>
				</form>
				<!--// content -->
			</div>
			
			
			
			
