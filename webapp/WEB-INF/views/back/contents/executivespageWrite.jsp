<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>


<script src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script src="<c:url value='/dext5editor/js/dext5editor.js' />" charset="utf-8"></script>
<script>
var savedRow = null;
var savedCol = null;
var del_Yn = "N";
var writeUrl = "<c:url value='/back/contents/ceopageListPage.do'/>";
var ceopageUpdateUrl =  "<c:url value='/back/contents/ceopageUpdate.do'/>";
var ceopageInsertUrl =  "<c:url value='/back/contents/ceopageInsert.do'/>";
var ceopageDeleteUrl =  "<c:url value='/back/contents/ceopageDelete.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";



$(document).ready(function(){	
	chkFile();
	$('.file_area .btn_file_delete').click(function() {
        if (confirm('첨부된 파일을 삭제하시겠습니까?')) {
            var el = this;
            var id = $(this).parent().parent().parent().attr('id');            
            $.post(
           		deleteFileUrl,           		
                {file_id: $(el).data("file_id")},
                function(data) {
                    if (data.success == "true") {
                        var len =$(el).parent().siblings().length;
                        if (len <= 0) {
                            $(el).closest('div').siblings('input').val('');
                        }
                        $(el).parent().parent().remove();                        
                        if (id=="file_area") {
                        	$("#attach_file").show();     	
						}                        
                        del_Yn = "Y";
                    } else {
                        alert(data.message);
                    }
                }
            );
        }
    });
});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:ceopageWrite('"+rowObject.page_id+"')\">"+rowObject.title+"</a>";
	
	return str;
}

function valcheck(){
	
	if ($("#start_date").val()==null || $("#start_date").val()=="") {
		alert("임기 시작일을 입력해주세요.");		
		return false;
	}	
	if($("#file").val()=="" && del_Yn=="Y"){		
		alert("사진이미지는 필수값 입니다.");
		return;
	}
	if ($("#file").val() != "" && !$("#file").val().toLowerCase().match(/\.(jpg|png|gif)$/)){
		alert("확장자가 jpg,png,gif 파일만 업로드가 가능합니다.");
		return false;
	}
	return true;
}

function ceopageInsert()
{
	var url = ceopageInsertUrl;	
	if ( $("#writeFrm").parsley().validate() ){	   
		
		if(!valcheck())
		{
		return;
		}
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
function ceopageUpdate()
{
	var url = ceopageUpdateUrl;	
	if ( $("#writeFrm").parsley().validate() ){	   
		
		if(!valcheck())
		{
		return;
		}		
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
function ceopageDelete()
{
	if (!confirm("정말 삭제하시겠습니까?")) {
		return;
	}
	var url = ceopageDeleteUrl;
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
function list(){
	var f = document.writeFrm;
	f.target = "_self";
    f.action = writeUrl;
    f.submit();
}



function chkFile()
{		
	
	
	if ("${ceopageinfo.file_id}"!=""&&"${ceopageinfo.file_id}"!=null) {
		$("#attach_file").hide();
		$("#file_area").show();		
	}
	else
	{		
		$("#attach_file").show();
		$("#file_area").hide();
	}
			
	
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
        <form id="writeFrm" name="writeFrm" method="post"  onsubmit="return false;" enctype="multipart/form-data" > 
				<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
				<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
				<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
				<input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
				<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="<c:out value="${param.p_searchtxt}" escapeXml="true" />" />
			    <input type='hidden' id="p_satis_yn" name='p_satis_yn' value="${param.p_satis_yn}" />
				<input type='hidden' id="mode" name='mode' value="${param.mode}" />
			    <input type='hidden' id="page_id" name='page_id' value="${ceopageinfo.page_id}" />
			    <input type='hidden' id="contents" name = "contents" value = '${ceoinfo.contents}' />
			    
			<!-- table_area -->
					<div class="table_area">
						<table class="write">
							<caption>등록 화면</caption>
							<colgroup>
								<col style="width: 120px;">
								<col style="width: *;">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">
									<label for="name">회장명 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="ceo_name" name="ceo_name" type="text" class="in_w100" value = "${ceopageinfo.ceo_name}" data-parsley-required="true"/>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="stage_desc">기수 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="stage_desc" name="stage_desc" type="text" class="in_w100" value = "${ceopageinfo.stage_desc}" data-parsley-required="true"/>
								</td>
							</tr>
							<tr>
								<th scope="row">임기 <strong class="color_pointr">*</strong></th>
								<td>
									<input type="text" id="start_date" name="start_date" readonly value="${ceopageinfo.start_date}"  class="in_wp100 datepicker">									
									&nbsp;~&nbsp;
									<input type="text" id="end_date" name="end_date" class="in_wp100 datepicker" readonly value="${ceopageinfo.end_date}" >
									<input id="ceo_check" name="ceo_check" type="checkbox" class="marginl20" <c:if test = '${ceopageinfo.ceo_check eq  "Y"}'>checked = checked</c:if>    />
									<label for="ceo_check">현재 임기중</label>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="com_name">근무지 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="com_name" name="com_name" type="text" class="in_w100" value = "${ceopageinfo.com_name}" data-parsley-required="true"/>
								</td>
							</tr>
							<tr>
					<th scope="row">사진 <strong class="color_pointr">*</strong></th>
					<td>
						<div id="attach_file">
							<div class="file_area">
								<label for="file" class="hidden">파일 선택하기</label>
								<input id="file" name="file" type="file" class="in_wp400" />																	
							</div>
						</div>						
						<div class="file_area" id="file_area">
							<ul class="file_list">						
								<li>
									<a id="group_id" href="/commonfile/fileidDownLoad.do?file_id=${ceopageinfo.file_id}"  target="_blank" class="download" title="다운받기" >
										${ceopageinfo.origin_file_nm}(${ceopageinfo.file_size}KB)
									</a>
									<a href="javascript:;" class="btn_file_delete" data-file_id="${ceopageinfo.file_id}" title="파일 삭제">
										<img src="/images/back/icon/icon_delete.png" alt="삭제" />
									</a>
								</li>
							</ul>
						</div>	
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
							<c:set var="gubun" value="${ceopageinfo.gubun}"></c:set>
							<c:choose>
							<c:when test="${gubun ne 'E' }">
							<a class="btn save" title="저장하기" onclick="ceopageInsert()">
								<span>저장</span>
							</a>
							<a class="btn list" title="목록" onclick="list()">
								<span>목록</span>
							</a>							
							</c:when>
							<c:otherwise>
							<a class="btn save" title="저장하기" onclick="ceopageUpdate()">
								<span>저장</span>
							</a>
							<a class="btn save" title="삭제하기" onclick="ceopageDelete()">
								<span>삭제</span>
							</a>
							<a class="btn list" title="목록" onclick="list()">
								<span>목록</span>
							</a>	
							
							</c:otherwise>
							</c:choose>
							
						</div>
					</div>
</form>
</div>
<!--// content -->
<script>
$('.datepicker').each(function(){
   $(this).datepicker({
		  format: "yyyy-mm-dd",
		  language: "kr",
		  keyboardNavigation: false,
		  forceParse: false,
		  autoclose: true,
		  todayHighlight: true,
		  showOn: "button",
		  buttonImage:"/images/back/icon/icon_calendar.png",
		  buttonImageOnly:true,
		  changeMonth: true,
         changeYear: true,
         showButtonPanel:false
		 });
});
</script>
