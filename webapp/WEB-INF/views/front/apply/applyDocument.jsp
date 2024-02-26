<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var updateApplyDocUrl = "<c:url value='/front/apply/updateApplyDoc.do'/>"

$(document).ready(function(){
	
});

var updateCheck = 0;
function upateApplyDoc(){
	   if(updateCheck == 1) return;
	   updateCheck = 1;
	   $("#update_applydoc_btn").hide();
	   
	   if($('#id_file_id').val() == "")
	   	  $('#uploadFile1').attr('data-parsley-required', 'true');	
	   if($('#unemplyinsur_file_id').val() == "")
		   	  $('#uploadFile3').attr('data-parsley-required', 'true');	
	   if($('#deploma_file_id').val() == "")
		   	  $('#uploadFile4').attr('data-parsley-required', 'true');
	   
	   if ( $("#writeFrm").parsley().validate() ){
		   
		   for(var i =1; i < 5; i++ ){
				if ($("#uploadFile"+i).val() != "" && !$("#uploadFile"+i).val().toLowerCase().match(/\.(jpg|png|gif|ppt|pptx|xls|xlsx|doc|docx|hwp|txt|pdf|zip)$/)){
				    alert("확장자가 jpg,png,gif,ppt,pptx,xls,xlsx,doc,docx,hwp,txt,pdf,zip 파일만 업로드가 가능합니다.");
				    $("#update_applydoc_btn").show();
				    updateCheck = 0;
				    return;
				}  
	      }
		   
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					if(responseText.success == "true"){
						applyActplan();
					}else{
						alert(responseText.message);
						$("#update_applydoc_btn").show();
						updateCheck = 0;
					}
					
				},
				dataType: "json", 				
				url: updateApplyDocUrl
		    });	
		   
	   }else{
		   $("#update_applydoc_btn").show();
		   updateCheck = 0;
	   }
}

function delFile(gubun){
	   if(gubun == "1") $("#id_file_id").val("");
	   else	if(gubun == "2") $("#health_file_id").val("");
	   else	if(gubun == "3") $("#unemplyinsur_file_id").val("");
	   else	if(gubun == "4") $("#deploma_file_id").val("");
	   
		$("#upFile"+gubun).hide();
}

function applyAgree(){
	var f = document.writeFrm;
    f.action = "/front/apply/applyAgree.do";
	f.encoding="application/x-www-form-urlencoded";
    f.submit();
}

function applyActplan(){
	var f = document.writeFrm;
    f.action = "/front/apply/applyActplan.do";
    f.submit();
}

</script>
 <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true" enctype="multipart/form-data">
<input type='hidden' id="announc_id" name='announc_id' value="${apply.announc_id}" />
<input type='hidden' id="aply_id" name='aply_id' value="${apply.aply_id}" />
<input type="hidden" id="id_file_id" name="id_file_id" value="${apply.id_file_id}" />
<input type="hidden" id="health_file_id" name="health_file_id" value="" />
<input type="hidden" id="unemplyinsur_file_id" name="unemplyinsur_file_id" value="${apply.unemplyinsur_file_id}" />
<input type="hidden" id="deploma_file_id" name=deploma_file_id value="${apply.deploma_file_id}" />
			    
				<!-- division40 -->
				<div class="division40">
					<!-- division50 -->
					<div class="division50">
						<!-- chapter_area -->
						<div class="chapter_area">
							<img src="/images/front/sub/chapter02.png" alt="2. 신청 시 구비서류" />
						</div>
						<!--// chapter_area -->
						<!-- division30 -->
						<div class="division30">
							<!-- title_area -->
							<div class="title_area">
								<h3 class="title">신청 시 구비서류</h3>
							</div>
							<!--// title_area -->
							<!-- table_area -->
							<div class="table_area">
								<table class="write fixed">
									<caption>신청 시 구비서류 등록 화면</caption>
									<colgroup>
										<col style="width: 160px;">
										<col style="width: *;">
									</colgroup>
									<tbody>
									<tr>
										<th scope="row" class="first"><strong class="color_pointr">*</strong>주민등록등본</th>
										<td class="first">
											<div class="file_area">
												  <c:if test="${!empty apply.id_file_id}">
							                      <p id="upFile1"><a href="/commonfile/fileidDownLoad.do?file_id=${apply.id_file_id}" >${apply.id_file_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('1')"></a></p>
							                      </c:if>
												  <label for="uploadFile1" class="hidden">파일 선택하기</label>
							                      <input class="in_w60 marginb10" type="file" id="uploadFile1" name="uploadFile1" value="" data-parsley-required="false" data-parsley-maxlength="100" />
											</div>
											<p class="point_txt2">※ 과거의 주소변동(이력) 사항 포함</p>
											<p class="point_txt2">※ 주민번호 뒷자리 6자리는 가려서 제출</p>
										</td>
									</tr>
							        <input type="hidden" id="uploadFile2" name="uploadFile2" />
									<tr>
										<th scope="row"><strong class="color_pointr">*</strong>고용보험 피보험자격 내역서(피보험자용)</th>
										<td>
											<div class="file_area">
												  <c:if test="${!empty apply.unemplyinsur_file_id}">
							                      <p id="upFile3"><a href="/commonfile/fileidDownLoad.do?file_id=${apply.unemplyinsur_file_id}" >${apply.unemplyinsur_file_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('3')"></a></p>
							                      </c:if>
													<label for="uploadFile3" class="hidden">파일 선택하기</label>
							                       <input class="in_w60 marginb10" type="file" id="uploadFile3" name="uploadFile3" value=""  data-parsley-required="false" data-parsley-maxlength="100" />
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong class="color_pointr">*</strong>최종학력 졸업증명서 또는 졸업예정증명서</th>
										<td>
											<div class="file_area">
												  <c:if test="${!empty apply.deploma_file_id}">
							                      <p id="upFile4"><a href="/commonfile/fileidDownLoad.do?file_id=${apply.deploma_file_id}" >${apply.deploma_file_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('4')"></a></p>
							                      </c:if>
												  <label for="uploadFile4" class="hidden">파일 선택하기</label>
							                      <input class="in_w60 marginb10" type="file" id="uploadFile4" name="uploadFile4" value=""  data-parsley-required="false" data-parsley-maxlength="100" />
											</div>
										</td>
									</tr>
									</tbody>
								</table>
							</div>
							<!--// table_area -->
							<p class="point_txt2" style="color:red">※ 이미지 업로드가 안될 경우 zip으로 압축을 하여 업로드 해주십시요.</p>	
						</div>
						<!--// division30 -->
						<!-- button_area -->
						<div class="button_area">
			            	<div class="alignc">
			            		<a href="javascript:applyAgree()" class="btn save2" title="이전단계">
			            			<span>이전단계</span>
			            		</a>
			            		<a id="update_applydoc_btn" href="javascript:upateApplyDoc()" class="btn save2" title="다음단계">
			            			<span>다음단계</span>
			            		</a>
			            	</div>
			            </div>
						<!--// button_area -->						
		           	</div>
		           	<!--// division50 -->
	           	</div>
	           	<!--// division40 -->
</form>
