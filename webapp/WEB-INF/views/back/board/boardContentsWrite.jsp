<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" rel="stylesheet" />

<script src="<c:url value='/smarteditor2/js/HuskyEZCreator.js' />" charset="utf-8"></script>


<script src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script src="/assets/jquery/jquery.table2excel.js"></script>
<script>
var listUrl = "<c:url value='/back/board/boardContentsListPage.do'/>";
var insertBoardContentsUrl = "<c:url value='/back/board/insertBoardContents.do'/>";
var insertBoardContentsReplyUrl = "<c:url value='/back/board/insertBoardContentsReply.do'/>";
var updateBoardContentsUrl = "<c:url value='/back/board/updateBoardContents.do'/>";
var deleteBoardContentsUrl = "<c:url value='/back/board/deleteBoardContents.do'/>";
var saveBoardAnswerUrl = "<c:url value='/back/board/saveBoardContentsAnswer.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";
var maxNoti = "${boardinfo.notiCnt}";
var notiCnt = "${boardinfo.notiSum}";
var boardContentsWriteUrl = "<c:url value='/back/board/boardContentsWrite.do'/>";

$(document).ready(function(){
	if($("#mode").val() != "E") $("#regDt").val($.datepicker.formatDate($.datepicker.ATOM, new Date()));	// 현재날짜 선택

	imgRefresh(); //캡차 이미지 요청


	//예약일 현재
	$("#book_ynY").click(function() {
		/* $("#bookDt").val($.datepicker.formatDate($.datepicker.ATOM, new Date())); */	// 현재날짜 선택
		$("#regDt").val($.datepicker.formatDate($.datepicker.ATOM, new Date()));
	 });

	//예약일 작성
	$("#book_ynN").click(function() {		
		$("#regDt").val("");
	 });

});
//답변 쓰기(QNA)
function contentsAnswer(){
	var f = document.writeFrm;

	$("#mode").val("A");
    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
}





//게시물 등록 및 수정
function contentsWrite(){

	var oriText = oEditors.getById["contents"].getIR();		//	검색속도 향상을 위해 내용의 HTML 태그를 제거하는 기능 추가 - 2020.11.05
	var newText = oriText.replace(/(<([^>]+)>)/ig,"");
	$("#contentsSrch").val(newText);
	
	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);	
	var url = "";

	// 썸네일은 이미지형식으로저장
	/*
	if ($("#thumb").val() != "" && !$("#thumb").val().toLowerCase().match(/\.(jpg|png|gif)$/)){
		alert("확장자가 jpg,png,gif 파일만 업로드가 가능합니다.");
		return;
	}
	*/

   if ( $("#writeFrm").parsley().validate() ){

	   if($("#mode").val() == "E"){					// 수정
		   url = updateBoardContentsUrl;
	   }else if($("#mode").val() == "R"){		// 신규
		   url = insertBoardContentsReplyUrl;
	   }else if($("#mode").val() == "A"){		// 답변
		   url = saveBoardAnswerUrl
	   }else{
		   url = insertBoardContentsUrl;
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



//게시물 삭제
function contentsDelete(delyn){
    var url = deleteBoardContentsUrl;
    var confirmMsg;
    confirmMsg = delyn == 'N' ? "게시물을 복원하시겠습니까?" : "게시물을 삭제하시겠습니까?" ;

    $("#delYn").val(delyn);

	if (confirm(confirmMsg)) {
		$.ajax({
			type: "POST",
			url: url,
			data :jQuery("#writeFrm").serialize(),
			dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					list();
				}
			}
		});
    }
}

function delFile(fileId,attachId,idx){
	
	if (!confirm("파일을 삭제하시겠습니까?")) {
		return;		
	}
	
	 var data = new Object();
	 var html = "";
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
				
				html += 	"<div id='attach_file'>";
				html += "<div class='file_area'>";
				html += "<label for='attached_file' class='hidden'>파일 선택하기</label>";
				html += "<input id='attached_file' name='attached_file' type='file' class='in_wp400'/>";								
				html += "</div>";
				html += "</div>";				
				
				$("#totalFileDiv").append(html);
				$("#uploaded_"+idx).css("display","none");
			
				
			}else
			{
			alert("실패");
			}
		}
	});
}	
	
function list(){
	var f = document.writeFrm;

    f.target = "_self";
    f.action = listUrl;
    f.submit();
}

//230801 관리자페이지 공지사항 상단 8개로 늘림
function chkNoti(){
	//console.log("notiSum : " + Number(notiCnt));
	//console.log("notiCnt : " + Number(maxNoti));
	// 게시물허용수 > 게시물수 비교
	if(Number(notiCnt) < 9){
	} else{
		alert("고정 공지사항 갯수를 초과하였습니다.");
		$("#notiN").prop('checked', true) ;
	}
}
/*230801 관리자페이지 공지사항 상단 8개로 늘림 원본
function chkNoti(){

	// 게시물허용수 > 게시물수 비교
	if(Number(maxNoti) > Number(notiCnt)){
	} else{
		alert("고정 공지사항 갯수를 초과하였습니다.");
		$("#notiN").prop('checked', true) ;
	}
}
*/
function imgRefresh(){
	 $("#captchaImg").attr("src", "/captcha?id=" + Math.random());
}

</script>

<!--// content -->
<div id="content">
	<!-- title_and_info_area -->
	<div class="title_and_info_area">
		<!-- main_title -->
		<div class="main_title">
			<%-- <h3 class="title">${MENU.menuNm}</h3> --%>
			<c:if test="${gubun eq 'M'}" ><h3 class="title">${MENU.menuNm}</h3></c:if>
			<c:if test="${gubun ne 'M'}" ><h3 class="title">${boardinfo.title}</h3></c:if>
		</div>
		<!--// main_title -->
		<jsp:include page="/WEB-INF/views/back/menu/menuDescInclude.jsp"/>
	</div>
	<!--// title_and_info_area -->
	
	<form id="writeFrm" name="writeFrm" method="post"  onsubmit="return false;" enctype="multipart/form-data">
		<input type='hidden' id="mode" name='mode' value="${param.mode}" />
		<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
		<input type='hidden' id="boardId" name='boardId' value="${param.boardId}" />
		<input type='hidden' id="contId" name='contId' value="<c:if test="${param.mode eq 'E'}">${contentsinfo.contId }</c:if><c:if test="${param.mode eq 'A'}">${contentsinfo.contId }</c:if>" />
		<input type='hidden' id="gubun" name='gubun' value="${param.gubun}" />
		<input type='hidden' id="imgAttachId" name='imgAttachId' value="${contentsinfo.imgAttachId }" />
		<input type='hidden' id="attachId" name='attachId' value="${contentsinfo.attachId }" />
		<input type='hidden' id="attachIdAnswer" name='attachIdAnswer' value="${contentsinfo.attachIdAnswer }" />
		<input type='hidden' id="delFile" name = "delFile" />
		<input type='hidden' id="inFile" name = "inFile" />
		<input type='hidden' id="refSeq" name='refSeq' value="${contentsinfo.refSeq }" />
		<input type='hidden' id="restepSeq" name='restepSeq' value="${contentsinfo.restepSeq }" />
		<input type='hidden' id="relevelSeq" name='relevelSeq' value="${contentsinfo.relevelSeq }" />
		<input type='hidden' id="boardCd" name='boardCd' value="${boardinfo.boardCd }" />
		<input type='hidden' id="contentsTxt" name='contentsTxt' value='${boardinfo.contentsTxt }' />
		<input type='hidden' id="delYn" name='delYn' value="" />
		<input type='hidden' id="contentsSrch" name='contentsSrch' value="" />

		<!-- write_basic -->
		<div class="table_area">
			<c:set var="array_item" value="${ fn:split(boardinfo.itemUse, ',') }" />
			<c:set var="array_view" value="${ fn:split(boardinfo.itemOut, '|') }" />

			<table class="view">
				<caption>등록 화면</caption>
				<colgroup>
					<col style="width: 120px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>

				<c:if test="${fn:indexOf(boardinfo.itemUse, 'cate') != -1}">
		<%-- 		<tr>
					<th scope="row">분류 <c:if test="${fn:indexOf(boardinfo.itemRequired, 'cate') != -1}"><strong class="color_pointr">*</strong></c:if> </th><!-- 카테고리 -->
					<td>
						<select class="in_wp150" title="구분 선택" id="cateId" name="cateId"
							 <c:if test="${fn:indexOf(boardinfo.itemRequired, 'cate') != -1}">data-parsley-required="true"</c:if>
						>
							<option value="" >- 선택 -</option>
							<c:forEach items="${category }" var="list">
								<option value="${list.cateId }" <c:if test="${list.cateId eq contentsinfo.cateId && param.mode eq 'E'}">selected</c:if>>${list.cateNm }</option>
							</c:forEach>
						</select>
					</td>
				</tr> --%>
			<%-- 	<tr>
					<th scope="row">분류 </th><!-- 카테고리 -->
					<td>
              			<input id="division" name="division" type="text" class="in_wp200" value="${contentsinfo.division}" data-parsley-required="true"/>
					</td>
				</tr> --%>
				</c:if>
				
				
				<c:if test="${boardinfo.boardId eq '10026'
							   or boardinfo.boardId eq '51' 
							   or boardinfo.boardId eq '52' 
							   or boardinfo.boardId eq '20064'
							   or boardinfo.boardId eq '20059'
							   or boardinfo.boardId eq '20065'
							   or boardinfo.boardId eq '20058'		
							   or boardinfo.boardId eq '20061'								   					   
							    }">				
				<tr>
					<th scope="row">						
								카테고리
					</th>
					<td>
						<select class = "in_w15" id = "etc0" name ="etc0">	 											
							<c:if test = "${boardinfo.boardId eq '10026' or boardinfo.boardId eq '51' or  boardinfo.boardId eq '52' }">
							<option value = "1" <c:if test="${contentsinfo.etc0 eq '1' }">selected</c:if> >농림수산식품모태펀드</option>
							<option value = "2" <c:if test="${contentsinfo.etc0 eq '2' }">selected</c:if> >농식품전문 크라우드펀딩</option>
							<option value = "3" <c:if test="${contentsinfo.etc0 eq '3' }">selected</c:if> >농업정책보험</option>
							<option value = "7" <c:if test="${contentsinfo.etc0 eq '7' }">selected</c:if> >양식수산물재해보험</option><!-- 2021.07.14 -->
							<option value = "4" <c:if test="${contentsinfo.etc0 eq '4' }">selected</c:if> >손해평가사</option>
							<option value = "5" <c:if test="${contentsinfo.etc0 eq '5' }">selected</c:if> >농림수산정책자금 검사</option>
							<option value = "6" <c:if test="${contentsinfo.etc0 eq '6' }">selected</c:if> >농특회계 융자금 관리</option>
							<option value = "9" <c:if test="${contentsinfo.etc0 eq '9' }">selected</c:if> >기타</option>
							</c:if>
							<c:if test = "${boardinfo.boardId eq '20064' or boardinfo.boardId eq '20059' or  boardinfo.boardId eq '20065' }">
							<option value = "1" <c:if test="${contentsinfo.etc0 eq '1' }">selected</c:if> >대출취급 부적정</option>
							<option value = "2" <c:if test="${contentsinfo.etc0 eq '2' }">selected</c:if> >부당사용 및 중도화수 사유 발생</option>
							<option value = "3" <c:if test="${contentsinfo.etc0 eq '3' }">selected</c:if> >사후관리.채권보전 조치 소홀</option>												
							</c:if>
							<c:if test = "${boardinfo.boardId eq '20058'}">
							<option value = "1" <c:if test="${contentsinfo.etc0 eq '1' }">selected</c:if> >농작물재해보험</option>
							<option value = "2" <c:if test="${contentsinfo.etc0 eq '2' }">selected</c:if> >농기계종합보험</option>
							<option value = "3" <c:if test="${contentsinfo.etc0 eq '3' }">selected</c:if> >가축재해보험</option>
							<option value = "4" <c:if test="${contentsinfo.etc0 eq '4' }">selected</c:if> >농업인안전재해보험</option>
							</c:if>
							<c:if test = "${boardinfo.boardId eq '20061'}">
							<option value = "1" <c:if test="${contentsinfo.etc0 eq '1' }">selected</c:if> >시험관련</option>
							<option value = "2" <c:if test="${contentsinfo.etc0 eq '2' }">selected</c:if> >기출문제</option>
							<option value = "3" <c:if test="${contentsinfo.etc0 eq '3' }">selected</c:if> >기타</option>
							</c:if>
						</select>

					</td>
				</tr>
				</c:if>

				<c:if test="${fn:indexOf(boardinfo.itemUse, 'title') != -1}">
				
				<tr>
					<th scope="row">
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'title'}">
								${array_view[status.index]} <c:if test="${fn:indexOf(boardinfo.itemRequired, 'title') != -1}"><strong class="color_pointr">*</strong></c:if>
							</c:if>
						</c:forEach>

					</th>
					<td>
						<%-- <input type="text" value="${param.mode}" /> --%>
						<input id="title" name="title" type="text" class="in_w60" value="<c:if test="${param.mode eq 'R'}">RE : </c:if><c:if test="${param.mode eq 'A'}">[답변]</c:if><c:if test="${param.mode ne 'W'}">${contentsinfo.title }</c:if>"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'title') != -1}"> data-parsley-required="true"</c:if>
							<c:if test="${param.mode eq 'A'}">readonly="readonly"</c:if>
						/>
					</td>
				</tr>
				</c:if>
				
				
				

				<c:if test="${fn:indexOf(boardinfo.itemUse, 'link') != -1}">
				<tr>
					<th scope="row">
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'link'}">
								${array_view[status.index]} <c:if test="${fn:indexOf(boardinfo.itemRequired, 'link') != -1}"><strong class="color_pointr">*</strong></c:if>
							</c:if>
						</c:forEach>
					</th>
					<td>
						<input id="titleLink" name="titleLink" type="text" class="in_w60" value="<c:if test="${param.mode eq 'E'}">${contentsinfo.titleLink }</c:if>"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'link') != -1}">data-parsley-required="true"</c:if>
						/>
					</td>
				</tr>
				</c:if>

				<c:if test="${param.mode ne 'R'}">
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'noti_yn') != -1}">
				<tr>
					<th scope="row">
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'noti_yn'}">
								${array_view[status.index]} <c:if test="${fn:indexOf(boardinfo.itemRequired, 'noti_yn') != -1}"><strong class="color_pointr">*</strong></c:if>
							</c:if>
						</c:forEach>
					</th>
					<td>
						<input id="notiY" name="notiYn" type="radio" value="Y" onclick="chkNoti();" <c:if test="${contentsinfo.notiYn eq 'Y'}">checked="checked"</c:if> />
						<label for="notiY">사용</label>
						<input id="notiN" name="notiYn" type="radio" value="N" <c:if test="${contentsinfo.notiYn ne 'Y'}">checked="checked"</c:if> class="marginl15" />
						<label for="notiN">미사용</label>
					</td>
				</tr>
				</c:if>
				</c:if>

				<c:if test="${boardinfo.boardCd == 'Q'}">
				<tr>
					<th scope="row">비밀글 <c:if test="${fn:indexOf(boardinfo.itemRequired, 'open_yn') != -1}"><strong class="color_pointr">*</strong></c:if></th>
					<td>
						<input id="openYn" name="openYn" value="Y" type="radio" <c:if test="${contentsinfo.openYn eq 'Y'}">checked="checked"</c:if> />
						<label for="use">사용</label>
						<input id="openYn" name="openYn" value="N" type="radio" <c:if test="${contentsinfo.openYn ne 'Y'}">checked="checked"</c:if> class="marginl15" />
						<label for="not">미사용</label>
					</td>
				</tr>
				</c:if>

				<%--
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'url') != -1}">
				<tr>
					<th scope="row" rowspan="2">URL <c:if test="${fn:indexOf(boardinfo.itemRequired, 'url') != -1}"><strong class="color_pointr">*</strong></c:if></th>
					<td>
						<label for="use">URL 명</label>
						<input id="url_nm" name="url_nm" type="text" class="in_w60" value="<c:if test="${param.mode eq 'E'}">${contentsinfo.url_nm }</c:if>"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'url') != -1}">data-parsley-required="true"</c:if>
						/>
					</td>
				</tr>
				<tr>
					<td>
						<label for="use">URL 주소</label>
						<input id="url_link" name="url_link" type="text" class="in_w60"  value="<c:if test="${param.mode eq 'E'}">${contentsinfo.url_link }</c:if>"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'url') != -1}">data-parsley-required="true"</c:if>
						/>
					</td>
				</tr>
				</c:if> --%>

				<c:if test="${fn:indexOf(boardinfo.itemUse, 'source') != -1}">
				<tr>
					<th scope="row">출처 <c:if test="${fn:indexOf(boardinfo.itemRequired, 'source') != -1}"><strong class="color_pointr">*</strong></c:if></th>
					<td><input id="source" name="source" type="text" class="in_w60" value="<c:if test="${param.mode eq 'E'}">${contentsinfo.source }</c:if>" /></td>
				</tr>
				</c:if>

				<%--
				<tr style="<c:if test="${fn:indexOf(boardinfo.itemUse, 'thumb') == -1}">display:none</c:if>" >
					<th scope="row">
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'thumb'}">
								${array_view[status.index]} <c:if test="${fn:indexOf(boardinfo.itemRequired, 'thumb') != -1}"><strong class="color_pointr">*</strong></c:if>
							</c:if>
						</c:forEach>
					</th>
					<td>
						<div class="file_area">
							<label for="attached_file" class="hidden">파일 선택하기</label>
							<input class="form-control in_w50" type="file" id="thumb" name="thumb" value=""
								<c:if test="${fn:indexOf(boardinfo.itemRequired, 'thumb') != -1}">data-parsley-required="true"</c:if>
							/>
						</div>
						<c:if test="${param.mode eq 'E' && not empty contentsinfo.imageFileNm}">
						<div class="file_area" id="uploadedFile">
							<ul class="file_list">
								<li>
									<a href="#none" title="썸네일">${contentsinfo.imageFileNm}</a>
									<a href="javascript:;" class="btn_file_delete" data-file_id="${contentsinfo.imgAttachId}" title="파일 삭제">
										<img src="/images/back/icon/icon_delete.png" alt="삭제" />
									</a>
								</li>
							</ul>
						</div>
						</c:if>
					</td>
				</tr>
				 --%>



				<!-- 상품홍보 -->
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'product') != -1}">

				
				<tr>
					<th scope="row">
						<label for="companyNm">기업명 <strong class="color_pointr">*</strong></label>
					</th>
					<td>
						<input id="companyNm" name="companyNm" type="text" class="in_wp200" value="${contentsinfo.companyNm}" data-parsley-required="true"/>
					</td>
				</tr>
               
               	<tr>
					<th scope="row"><label for="ceo">대표자 <strong class="color_pointr">*</strong></label></th>
					<td><input id="ceo" name="ceo" type="text" class="in_wp200" value="${contentsinfo.ceo}" data-parsley-required="true" /></td>
				</tr>
               
               
					
				<tr>
					<th scope="row">연락처 <strong class="color_pointr">*</strong></th>
					<td>
						<label for="tel" class="hidden">통신사 및 국번 입력</label>
						<input id="tel" name="tel" type="text" class="in_wp200" value="${contentsinfo.tel}" data-parsley-required="true"/>
<!-- 						-
						<label for="num_center" class="hidden">앞자리 번호 입력</label>
						<input id="num_center" name="num_center" type="text" class="in_wp70" />
						-
						<label for="num_last" class="hidden">뒷자리 번호 입력</label>
						<input id="num_last" name="num_last" type="text" class="in_wp70" /> -->
					</td>
				</tr>
				<%-- <tr>
					<th scope="row">주요품목 <strong class="color_pointr">*</strong></th>
					<td>
						<input id="mainItem" name="mainItem" type="text" class="in_wp200" value="${contentsinfo.mainItem}" data-parsley-required="true" />

					</td>
				</tr> --%>
				
				<tr>
					<th scope="row">
						<label for="note">사업내용 <strong class="color_pointr">*</strong></label>
					</th>
					<td>
						<input id="note" name="note" type="text" class="in_wp300" value="${contentsinfo.note}" data-parsley-required="true"/>
					</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="email">이메일 <strong class="color_pointr">*</strong></label>
					</th>
					<td>
						<input id="email" name="email" type="text" class="in_wp200" value="${contentsinfo.email}" data-parsley-required="true"/>
					</td>
				</tr>
		<%-- 		<tr>
					<th scope="row">
						<label for="homepage">홈페이지 <strong class="color_pointr">*</strong></label>
					</th>
					<td>
						<input id="homepage" name="homepage" type="text" class="in_w90" value="<c:if test='${empty contentsinfo}'>http://</c:if><c:if test='${!empty contentsinfo}'>${contentsinfo.homepage}</c:if>" data-parsley-required="true" data-parsley-type="http"/>
					</td>
				</tr> --%>
				<tr>
					<th scope="row">
						<label for="productDesc">기타 <strong class="color_pointr">*</strong></label>
					</th>
					<td>
						<input id="productDesc" name="productDesc"  title="설명 입력" class="in_wp200" value="${contentsinfo.productDesc}" data-parsley-required="true"/>
					</td>
				</tr>
				
				<tr>
					<th scope="row">
						<label for=imgPath>이미지<br>(이미지파일 첨부시 출력됩니다.) <strong class="color_pointr">*</strong></label>
					</th>
					<td colspan="4" scope="row">
						<div class="editor_ir">
					 	 <img src="${contentsinfo.imgPath}${contentsinfo.imgNm}" alt="${contentsinfo.imgNm}" style="height:650px;width:500px;"> 
					 	 </div>
					</td>
				</tr>
				
				<!-- <tr>
					<th scope="row">사진 <strong class="color_pointr">*</strong></th>
					<td>
						<div class="file_area">
							<label for="attached_file" class="hidden">파일 선택하기</label>
							<input id="attached_file" name="attached_file" type="file" class="in_w100" />
						</div>
						<div class="file_area">
							<ul class="file_list">
								<li>
									<a href="#none" title="파일_01.hwp">사진이미지.png</a>
									<a href="#none" class="btn_file_delete" title="파일 삭제">
										<img src="../../../images/icon/icon_delete.png" alt="삭제">
									</a>
								</li>
							</ul>
						</div>
					</td>
				</tr> -->
				</c:if>

				<!-- 유관기관 -->
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'related') != -1}">
		
				<tr>
					<th scope="row">
						<label for="addr1">주소 <strong class="color_pointr">*</strong></label>
					</th>
					<td>
						<input id="addr1" name="addr1" type="text" class="in_w100" value="${contentsinfo.addr1}" data-parsley-required="true"/>
					</td>
				</tr>
				<tr>
					<th scope="row">연락처 <strong class="color_pointr">*</strong></th>
					<td>
						<label for="tel" class="hidden">통신사 및 국번 입력</label>
						<input id="tel" name="tel" type="text" class="in_wp200" value="${contentsinfo.tel}" data-parsley-required="true"/>
						<!-- -
						<label for="num_center" class="hidden">앞자리 번호 입력</label>
						<input id="num_center" name="num_center" type="text" class="in_wp70" />
						-
						<label for="num_last" class="hidden">뒷자리 번호 입력</label>
						<input id="num_last" name="num_last" type="text" class="in_wp70" /> -->
					</td>
				</tr>
				<tr>
					<th scope="row">팩스 <strong class="color_pointr">*</strong></th>
					<td>
						<label for="fax" class="hidden">통신사 및 국번 입력</label>
						<input id="fax" name="fax" type="text" class="in_wp200" value="${contentsinfo.fax}" data-parsley-required="true"/>
						<!-- -
						<label for="faxnum_center" class="hidden">앞자리 번호 입력</label>
						<input id="faxnum_center" name="faxnum_center" type="text" class="in_wp70" />
						-
						<label for="faxnum_last" class="hidden">뒷자리 번호 입력</label>
						<input id="faxnum_last" name="faxnum_last" type="text" class="in_wp70" /> -->
					</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="homepage">홈페이지 <strong class="color_pointr">*</strong></label>
					</th>
					<td>
						<input id="homepage" name="homepage" type="text" class="in_w90" value="<c:if test='${empty contentsinfo}'>http://</c:if><c:if test='${!empty contentsinfo}'>${contentsinfo.homepage}</c:if>" data-parsley-required="true" data-parsley-type="http"/>
					</td>
				</tr>
				<tr>
					<th scope="row">
						비고(메모) <strong class="color_pointr">*</strong>
					</th>
					<td>
						<textarea id="note" name="note" rows="7" title="비고(메모) 입력" class="in_w100" data-parsley-required="true">${contentsinfo.note}</textarea>
					</td>
				</tr>
				</c:if>

				<!-- 국제무역추천사이트 -->
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'international') != -1}">
				<%-- <tr>
					<th scope="row">
						<label for="title">사이트명 <strong class="color_pointr">*</strong></label>
					</th>
					<td>
						<input id="title" name="title" type="text" class="in_w100" value="${contentsinfo.title}" data-parsley-required="true"/>
					</td>
				</tr> --%>
				<tr>
					<th scope="row">
						<label for="homepage">홈페이지 <strong class="color_pointr">*</strong></label>
					</th>
					<td>
						<input id="homepage" name="homepage" type="text" class="in_w90" value="<c:if test='${empty contentsinfo}'>http://</c:if><c:if test='${!empty contentsinfo}'>${contentsinfo.homepage}</c:if>" data-parsley-required="true" data-parsley-type="http"/>
					</td>
				</tr>
				<tr>
					<th scope="row">
						비고(메모) <strong class="color_pointr">*</strong>
					</th>
					<td>
						<textarea id="note" name="note" rows="7" title="비고(메모) 입력" class="in_w100" data-parsley-required="true">${contentsinfo.note}</textarea>
					</td>
				</tr>
				</c:if>

				<c:if test="${fn:indexOf(boardinfo.itemUse, 'attach') != -1}">

				<%--
				<tr>
					<th scope="row">
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'attach'}">
								${array_view[status.index]} <c:if test="${fn:indexOf(boardinfo.itemRequired, 'attach') != -1}"><strong class="color_pointr">*</strong></c:if>
							</c:if>
						</c:forEach>
					</th>
					<td>
						<div id="attach_file">
							<div class="file_area">
								<label for="attached_file" class="hidden">파일 선택하기</label>
								<input id="attached_file" name="attached_file" type="file" class="in_wp400"
									<c:if test="${fn:indexOf(boardinfo.itemRequired, 'attach') != -1}">data-parsley-required="true"</c:if>
								/>
								<button class="marginl20" title="추가하기" id="addbtn" onclick="addFile()">
									<span><img src="/images/back/common/btn_file_add.png" alt="파일추가하기" /></span>
								</button>
							</div>
						</div>
						<c:if test="${param.mode eq 'E'}">
						<div class="file_area" id="file_area1">
							<ul class="file_list">
								<c:forEach items="${fileList }" var="list">
								<li>
									<a href="/commonfile/fileidDownLoad.do?file_id=${list.file_id}"  target="_blank" class="download" title="다운받기">
										${list.origin_file_nm }(${size }KB)
									</a>
									<a href="javascript:;" class="btn_file_delete" data-file_id="${list.file_id}" title="파일 삭제">
										<img src="/images/back/icon/icon_delete.png" alt="삭제" />
									</a>
								</li>
								</c:forEach>
							</ul>
						</div>
						</c:if>
						<c:if test="${param.mode eq 'A'}">
						<div class="file_area" id="file_area1">
							<ul class="file_list">
								<c:forEach items="${fileList }" var="list">
								<li>
									<a href="/commonfile/fileidDownLoad.do?file_id=${list.file_id}"  target="_blank" class="download" title="다운받기">
										${list.origin_file_nm }(${size }KB)
									</a>
									<a href="javascript:;" class="btn_file_delete" data-file_id="${list.file_id}" title="파일 삭제">
										<img src="/images/back/icon/icon_delete.png" alt="삭제" />
									</a>
								</li>
								</c:forEach>
							</ul>
						</div>
						</c:if>
					</td>
				</tr>
				--%>
				</c:if>

				<c:if test="${fn:indexOf(boardinfo.itemUse, 'reg_mem_nm') != -1}">
				<tr>
					<th scope="row">
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'reg_mem_nm'}">
								${array_view[status.index]} <c:if test="${fn:indexOf(boardinfo.itemRequired, 'reg_mem_nm') != -1}"><strong class="color_pointr">*</strong></c:if>
							</c:if>
						</c:forEach>
					</th>
					<td>
						<input id="regMemNm" name="regMemNm" type="text" class="in_w15" value='<c:if test ="${contentsinfo.regMemNm eq null}">${USER.userNm}</c:if><c:if test ="${contentsinfo.regMemNm ne null}">${contentsinfo.regMemNm}</c:if>'
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'reg_mem_nm') != -1}">data-parsley-required="true"</c:if>
						/>
					</td>
				</tr>
				</c:if>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'organization') != -1}">
				<tr>
					<th scope="row">
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'organization'}">
								${array_view[status.index]} <c:if test="${fn:indexOf(boardinfo.itemRequired, 'organization') != -1}"><strong class="color_pointr">*</strong></c:if>
							</c:if>
						</c:forEach>
					</th>
					<td>
						<input id="regMemNm" name="regMemNm" type="text" class="in_w15" value="${regMemNm }"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'reg_mem_nm') != -1}">data-parsley-required="true"</c:if> readonly
						/>
					</td>
				</tr>
				</c:if>
				<%-- <c:if test="${fn:indexOf(boardinfo.itemUse, 'phone') != -1}">
				<tr>
					<th scope="row">휴대전화 <c:if test="${fn:indexOf(boardinfo.itemRequired, 'phone') != -1}">*</c:if></th>
					<td>
						<c:set var="phone1" value="010" />
						<c:set var="phone2" value="" />
						<c:set var="phone3" value="" />
						<c:if test="${not empty contentsinfo.mobile }">
							<c:set var="phone" value="${contentsinfo.mobile }" />
							<c:set var="phone_split" value="${fn:split(phone, '-')}" />
							<c:forEach var="p1" items="${phone_split }" varStatus="s">
								<c:if test="${s.count == 1 }"><c:set var="phone1" value="${p1 }" /></c:if>
								<c:if test="${s.count == 2 }"><c:set var="phone2" value="${p1 }" /></c:if>
								<c:if test="${s.count == 3 }"><c:set var="phone3" value="${p1 }" /></c:if>
							</c:forEach>
						</c:if>
						<select class="in_wp60" title="구분 선택" id="phone1" name="phone1">
							<option value="010" <c:if test="${phone1 eq '010' }" >selected</c:if>>010</option>
							<option value="011" <c:if test="${phone1 eq '011' }" >selected</c:if>>011</option>
							<option value="016" <c:if test="${phone1 eq '016' }" >selected</c:if>>016</option>
							<option value="017" <c:if test="${phone1 eq '017' }" >selected</c:if>>017</option>
							<option value="018" <c:if test="${phone1 eq '018' }" >selected</c:if>>018</option>
							<option value="019" <c:if test="${phone1 eq '019' }" >selected</c:if>>019</option>
						</select>
						- <input type="text" class="in_wp60" id="phone2" name="phone2" value="${phone2 }" maxlength="4"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'phone') != -1}">data-parsley-required="true" data-parsley-errors-messages-disabled="true"</c:if>
						/>
						- <input type="text" class="in_wp60" id="phone3" name="phone3" value="${phone3 }" maxlength="4"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, 'phone') != -1}">data-parsley-required="true"</c:if>
						/>
						<div class="color_point">
							* 답신여부를 SMS로 받으시겠습니까?(
								<input id="sms_ynY" name="sms_yn" value="Y" type="radio" <c:if test="${contentsinfo.sms_yn eq 'Y'}">checked="checked"</c:if> />
								<label for="use">예</label>
								<input id="sms_ynN" name="sms_yn" value="N" type="radio" <c:if test="${contentsinfo.sms_yn ne 'Y'}">checked="checked"</c:if> class="marginl15" />
								<label for="not">아니요</label>
							)
						</div>
					</td>
				</tr>
				</c:if> --%>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'reg_dt') != -1}">
				<tr>
					<th scope="row">
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'reg_dt'}">
								${array_view[status.index]} <c:if test="${fn:indexOf(boardinfo.itemRequired, 'reg_dt') != -1}"><strong class="color_pointr">*</strong></c:if>
							</c:if>
						</c:forEach>
					</th>
					<td>
						<%-- <input id="book_ynN" name="bookYn" type="radio" value="N" <c:if test="${contentsinfo.bookYn ne 'Y'}">checked="checked"</c:if> />
						<label for="now">현재</label>
						<input id="book_ynY" name="bookYn" type="radio" value="Y" <c:if test="${contentsinfo.bookYn eq 'Y'}">checked="checked"</c:if> class="marginl15" />
						<label for="target">지정</label> --%>
						<%-- <input type="text" id="bookDt" name="bookDt" class="in_wp100 datepicker"
							value="<c:if test="${param.mode eq 'E'}">${contentsinfo.bookDt }</c:if>" readonly
						/> --%>
						<input type="text" id="regDt" name="regDt" class="in_wp100 datepicker"
							value="<c:if test="${param.mode eq 'E'}">${contentsinfo.regDt }</c:if>" readonly
						/>
					</td>
				</tr>
				</c:if> 
				<c:if test="${param.mode == 'E' }">
				<tr>
					<th scope="row">
					URL
					</th>
					<td>
						<input type="text" id="refUrl" name="refUrl" class="in_wp400" value="${contentsinfo.refUrl }" readonly />
					</td>
				</tr>
				</c:if>
				
				<c:if test="${param.boardId eq '20083'}">
					<tr>
						<th scope="row">공개여부</th>
						<td>비공개</td>
					</tr>
					<tr>
						<th scope="row" >경영체명</th>
						<td>
							<input type="text" name="etc1" class="in_w100" value="${contentsinfo.etc1}" />
						</td>
					</tr>
					<tr>
						<th>대표자명</th>
						<td >
							<input type="text" name="etc2" class="in_w100" value="${contentsinfo.etc2}" />
						</td>
					</tr>
					<tr>
						<th>사업자등록번호</th>
						<td>
							<input type="text" name="etc3" class="in_w100" value="${contentsinfo.etc3}"  placeholder="000-00-00000"/>
						</td>
					</tr>
					<tr>
						<th scope="row">법인등록번호</th>
						<td>
							<input type="text" name="etc4" class="in_w100" value="${contentsinfo.etc4}"  />
						</td>
					</tr>
					<tr>
						<th>설립연도</th>
						<td>
							<input type="text" name="etc5" class="in_w100" value="${contentsinfo.etc5}"   />
						</td>
					</tr>
					<tr>
						<th scope="row">소재지(본사)</th>
						<td>
							<input type="text" name="etc6" class="in_w100" value="${contentsinfo.etc6}" />
						</td>
					</tr>
					<tr>
						<th scope="row" >전화번호</th>
						<td>
							<input type="text" name="etc7" class="in_w100" value="${contentsinfo.etc7}" />
						</td>
					</tr>
					<tr>
						<th scope="row">팩스</th>
						<td>
							<input type="text" name="etc8" class="in_w100" value="${contentsinfo.etc8}" />
						</td>
					</tr>
					<tr>
						<th>직원수</th>
						<td>
							<input type="text" name="etc9" class="in_w100" value="${contentsinfo.etc9}" />
						</td>
					</tr>
					<tr>
						<th scope="row" >담당자 성명</th>
						<td>
							<input type="text" name="etc10" class="in_w100" value="${contentsinfo.etc10}" />
						</td>
					</tr>
					<tr>
						<th scope="row">직통전화</th>
						<td>
							<input type="text" name="etc11" class="in_w100" value="${contentsinfo.etc11}" />
						</td>
					</tr>
					<tr>
						<th scope="row">사업분야</th>
						<td class="usrView">
							<input type="checkbox" id="item01" name="items01" value="1" onclick=""/><label for="item01">농업</label>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="item02" name="items01" value="2" onclick="" /><label for="item02">임산</label>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="item03"  name="items01" value="3" onclick=""/><label for="item03">축산</label>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="item04" name="items01" value="4" onclick="" /><label for="item04">식품제조가공</label>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="item05" name="items01" value="5" onclick="" /><label for="item05">유통</label>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="item06" name="items01" value="6" onclick=""/><label for="item06">기타 연관산업</label>
						</td>
					</tr>
					<tr>
						<th scope="row">사업내용</th>
						<td>
							<input type="text" name="etc13" class="in_w100" value="${contentsinfo.etc13}" />
						</td>
					</tr>
					<tr>
						<th>주생산품목</th>
						<td>
							<input type="text" name="etc14" class="in_w100" value="${contentsinfo.etc14}" />
						</td>
					</tr>
					<tr>
						<th >펀딩 품목</th>
						<td>
							<input type="text" name="etc15" class="in_w100" value="${contentsinfo.etc15}" />
						</td>
					</tr>
					<tr>
						<th scope="row" >펀딩유형</th>
						<td class="usrView">
							<input type="checkbox" id="item01" name="items02" value="1" onclick=""/><label for="item01">후원형</label>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="item02" name="items02" value="2" onclick="" /><label for="item02">증권형</label>
						</td>
					</tr>
					<tr>
						<th scope="row">홈페이지</th>
						<td>
							<input type="text" name="etc18" class="in_w100" value="${contentsinfo.etc16}"/>
						</td>
					</tr>
					<c:forTokens var="item01" items="${contentsinfo.etc18}" delims=",">
					<script>
						$('input:checkbox[name="items01"]').each(function() {
							if(this.value == "${item01}"){ //값 비교
				            	this.checked = true; //checked 처리
							}
						});
					</script>
					</c:forTokens>
			
					<c:forTokens var="item02" items="${contentsinfo.etc19}" delims=",">
						<script>
							$('input:checkbox[name="items02"]').each(function() {
								if(this.value == "${item02}"){ //값 비교
					            	this.checked = true; //checked 처리
								}
							});
						</script>
					</c:forTokens>
				</c:if>
				
				<c:if test="${param.boardId eq '20083'}">
		<table id="table"  style="display: none;">
				<caption>등록 화면</caption>
				<colgroup>
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" >경영체명</th>
						<th>대표자명</th>
						<th>사업자등록번호</th>
						<th scope="row">법인등록번호</th>
						<th>설립연도</th>
						<th scope="row">소재지(본사)</th>
						<th scope="row" >전화번호</th>
						<th scope="row">팩스</th>
						<th>직원수</th>
						<th scope="row" >담당자 성명</th>
						<th scope="row">직통전화</th>
						<th>사업분야</th>
						<th scope="row">사업내용</th>
						<th>주생산품목</th>
						<th >펀딩 품목</th>
						<th scope="row" >펀딩유형</th>
						<th scope="row">홈페이지</th>
					</tr>
					<tr>
						<td>
							<input type="text" name="etc1" class="in_w100" value="${contentsinfo.etc1}" />
						</td>
						<td >
							<input type="text" name="etc2" class="in_w100" value="${contentsinfo.etc2}" />
						</td>
						<td>
							<input type="text" name="etc3" class="in_w100" value="${contentsinfo.etc3}"  placeholder="000-00-00000"/>
						</td>
						<td>
							<input type="text" name="etc4" class="in_w100" value="${contentsinfo.etc4}"  />
						</td>
						<td>
							<input type="text" name="etc5" class="in_w100" value="${contentsinfo.etc5}"   />
						</td>
						<td>
							<input type="text" name="etc6" class="in_w100" value="${contentsinfo.etc6}" />
						</td>
						<td>
							<input type="text" name="etc7" class="in_w100" value="${contentsinfo.etc7}" />
						</td>
						<td>
							<input type="text" name="etc8" class="in_w100" value="${contentsinfo.etc8}" />
						</td>
						<td>
							<input type="text" name="etc9" class="in_w100" value="${contentsinfo.etc9}" />
						</td>
						<td>
							<input type="text" name="etc10" class="in_w100" value="${contentsinfo.etc10}" />
						</td>
						<td>
							<input type="text" name="etc11" class="in_w100" value="${contentsinfo.etc11}" />
						</td>
						<td>
							<input type="text" id="parts" class="in_w100"  value="${contentsinfo.etc12}" />
						</td>
						<td>
							<input type="text" name="etc13" class="in_w100" value="${contentsinfo.etc13}" />
						</td>
						<td>
							<input type="text" name="etc14" class="in_w100" value="${contentsinfo.etc14}" />
						</td>
						<td>
							<input type="text" name="etc15" class="in_w100" value="${contentsinfo.etc15}" />
						</td>
						<td>
							<input type="text" name="fundingkind" class="in_w100" value="${contentsinfo.etc17}" /> 
						</td>
						<td>
							<input type="text" name="etc18" class="in_w100" value="${contentsinfo.etc16}"/>
						</td>
					</tr>
				</tbody>
			</table>
			</c:if>
				
				<c:if test="${param.boardId eq '20082'}">
					<tr>
						<th scope="row">경영체명</th>
						<td>
							<input type="text" name="etc1" class="in_w80" value="${contentsinfo.etc1}" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th>대표자명</th>
						<td>
							<input type="text" name="etc2" class="in_w80" value="${contentsinfo.etc2}" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">사업자등록번호</th>
						<td>
							<input type="text" name="etc3" class="in_w80" value="${contentsinfo.etc3}" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">법인등록번호</th>
						<td>
							<input type="text" name="etc4" class="in_w80" value="${contentsinfo.etc4}"  />
						</td>
					</tr>
					<tr>
						<th>설립연도</th>
						<td>
							<input type="text" name="etc5" class="in_w80" value="${contentsinfo.etc5}" />
						</td>
					</tr>
					<tr>
						<th scope="row">소재지(본사)</th>
						<td>
							<input type="text" name="etc6" class="in_w80" value="${contentsinfo.etc6}" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">전화번호</th>
						<td>
							<input type="text" name="etc7" class="in_w80" value="${contentsinfo.etc7}" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">팩스</th>
						<td>
							<input type="text" name="etc8" class="in_w80" value="${contentsinfo.etc8}" />
						</td>
					</tr>
					<tr>
						<th>임직원수</th>
						<td>
							<input type="text" name="etc9" class="in_w80" value="${contentsinfo.etc9}" />
						</td>
					</tr>
					<tr>
						<th scope="row">담당자 직통전화(유선)</th>
						<td>
							<input type="text" name="etc11" class="in_w80" value="${contentsinfo.etc11}" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">사업분야</th>
						<td class="usrView" colspan="6">
							<input type="text" name="etc12" class="in_w80" value="${contentsinfo.etc0}" data-parsley-required="true" />
							<!-- 
							<input type="checkbox" id="item01" name="item" value="1" /><label for="item01">농업</label>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="item02" name="item" value="2"/><label for="item02">임산</label>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="item03"  name="item" value="3" /><label for="item03">축산</label>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="item04" name="item" value="4" /><label for="item04">수산</label>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="item05" name="item" value="5" /><label for="item05">식품제조가공</label>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="item06" name="item" value="6" /><label for="item06">유통</label>
							&nbsp;&nbsp;&nbsp;
							<input type="checkbox" id="item07" name="item" value="7" /><label for="item07">기타 연관산업</label>
							<c:forTokens var="item" items="${contentsinfo.etc0}" delims=",">
							<script>
								$('input:checkbox[name="item"]').each(function() {
									if(this.value == "${item}"){ //값 비교
						            this.checked = true; //checked 처리
									}
								});
							</script>
							</c:forTokens>
							 -->
						</td>
					</tr>
					<tr>
						<th scope="row">사업내용</th>
						<td>
							<input type="text" name="etc13" class="in_w80" value="${contentsinfo.etc13}" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th>주생산품목</th>
						<td>
							<input type="text" name="etc14" class="in_w80" value="${contentsinfo.etc14}" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">매출액 ’17년</th>
						<td colspan>
							(<input type="text" name="etc15" class="in_w10" value="${contentsinfo.etc15}" />)억원
						</td>
					</tr>
					<tr>
						<th scope="row">매출액 ’18년</th>
						<td colspan>
							(<input type="text" name="etc16" class="in_w10" value="${contentsinfo.etc16}" />)억원
						</td>
					</tr>
					<tr>
						<th scope="row">매출액 ’19년</th>
						<td colspan>
							(<input type="text" name="etc17" class="in_w10" value="${contentsinfo.etc17}" />)억원
						</td>
					</tr>
					<tr>
						<th scope="row">홈페이지</th>
						<td>
							<input type="text" name="etc18" class="in_w80" value="${contentsinfo.etc18}"/>
						</td>
					</tr>
					<tr>
						<th>투자 유치 희망 금액</th>
						<td>
							(<input type="text" name="etc19" class="in_w10" value="${contentsinfo.etc19}" data-parsley-required="true" />)억원
						</td>
					</tr>
					<tr>
						<th scope="row">첨부파일</th>
						<td colspan="3">
							<c:if test="${fn:length(fileList) > 0 }">
								<div class="file_area" id="file_area1">
									<ul class="file_list">
										<c:forEach items="${fileList}" var="list">
										<li>
											<a href="/commonfile/fileidDownLoad.do?fileId=${list.fileId}&attachId=${list.attachId}"  target="_blank" class="download" title="다운받기">
												${list.originFileNm }(${list.fileSize}KB)
											</a>
											<a href='javascript:delFile("${list.fileId}","${list.attachId}");' class="btn_file_delete" data-file_id="${list.file_id}" title="파일 삭제">
												<img src="/images/back/icon/icon_delete.png" alt="삭제" />
											</a>
										</li>
										</c:forEach>
									</ul> 
								</div>
							</c:if>
						</td>
					</tr>
				</c:if>
				
				
				<c:if test="${param.boardId eq '20057'}">
					<tr>
						<th scope="row">경영체명</th>
						<td>
							<input type="text" name="etc1" class="in_w50" value="${contentsinfo.etc1}" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">대표번호</th>
						<td>
							<input type="text"  name="etc2" class="in_w50" value="${contentsinfo.etc2}" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">기업형태</th>
						<td>
							<select name="etc3" class="in_w50"><option value="개인">개인</option><option value="농어업법인">농어업법인</option><option value="일반법인">일반법인</option></select>
						</td>
					</tr>
					<tr>
						<th scope="row">자본금</th>
						<td>
							<input type="text" name="etc4" class="in_w30" value="${contentsinfo.etc4}"  data-parsley-type="integer" />백만원
						</td>
					</tr>
					<tr>
						<th scope="row">주소(본사)</th>
						<td><input type="text" name="etc5" class="in_w50" value="${contentsinfo.etc5}"/></td>
					</tr>
					<tr>
						<th scope="row">주요제품</th>
						<td>
							<input type="text" name="etc6" class="in_w50" value="${contentsinfo.etc6}" />
						</td>
					<tr>
						<th scope="row">전년도매출액</th>
						<td>
							<input type="text" name="etc7" class="in_w30" value="${contentsinfo.etc7}"  data-parsley-type="integer"/>백만원
						</td>
					</tr>
					
					<c:forEach var="itemFront" items="${fileList}" varStatus="status">
						<tr>
							<th scope="row">첨부파일</th>
							<td colspan="3">
							<div id="attach_file" style = "<c:if test="${fn:length(fileList) > 0}">display:none</c:if>">
								<div class="file_area">
									<label for="attached_file" class="hidden" style="display:none;">파일 선택하기</label>
									<input id="attached_file" name="attached_file" type="file" class="in_wp400"
										<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}">data-parsley-required="true"</c:if>
									/>
								</div>
							</div>
								<c:if test="${fn:length(fileList) > 0 }">
									<div class="file_area" id="file_area1">
										<ul class="file_list">
											<c:forEach items="${fileList}" var="list">
											<li>
												<a href="/commonfile/fileidDownLoad.do?fileId=${list.fileId}&attachId=${list.attachId}"  target="_blank" class="download" title="다운받기">
													${list.originFileNm }(${list.fileSize}KB)
												</a>
												<a href='javascript:delFile("${list.fileId}","${list.attachId}");' class="btn_file_delete" data-file_id="${list.file_id}" title="파일 삭제">
													<img src="/images/back/icon/icon_delete.png" alt="삭제" />
												</a>
											</li>
											</c:forEach>
										</ul> 
									</div>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				
				<c:forEach var="j" begin="0" end="9" varStatus="jstatus">
				<c:set var="v_etc" value="etc${j}" />
				<c:if test="${fn:indexOf(boardinfo.itemUse, v_etc) != -1}">
				<tr>
					<th scope="row">
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq v_etc}">
								${array_view[status.index]} <c:if test="${fn:indexOf(boardinfo.itemRequired, v_etc) != -1}"><strong class="color_pointr">*</strong></c:if>
							</c:if>
						</c:forEach>
					</th>
					<td>
						<input id="${v_etc}" name="${v_etc}" type="text" class="in_w60" value="<c:if test="${param.mode eq 'E'}">${contentsinfo[v_etc]}</c:if>"
							<c:if test="${fn:indexOf(boardinfo.itemRequired, v_etc) != -1}"> data-parsley-required="true"</c:if>
							<c:if test="${param.mode eq 'A'}">readonly="readonly"</c:if>
						/>
					</td>
				</tr>
				</c:if>
				</c:forEach>
				<c:if test="${fn:indexOf(boardinfo.itemUse, 'contents') != -1}">
				<tr>
					<th scope="row" colspan="2">
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'contents'}">
								${array_view[status.index]} <c:if test="${fn:indexOf(boardinfo.itemRequired, 'contents') != -1}"><strong class="color_pointr">*</strong></c:if>
							</c:if>
						</c:forEach>
					</th>
				</tr>
				</c:if>
				</tbody>
			</table>
			<div class="editor_area view" style="<c:if test="${fn:indexOf(boardinfo.itemUse, 'contents') == -1}">display:none</c:if>">
				<textarea class="form-control" id="contents" name="contents" placeholder="내용" rows="20" style="width:100%;height:400px;"  >


					


					<c:if test="${param.mode eq 'E'}">${contentsinfo.contents }</c:if><c:if test="${param.mode eq 'A'}">${contentsinfo.contentsTxt}</c:if>
				</textarea>
			</div>			 	
			<table class="view">
			<colgroup>
					<col style="width: 120px;" />
					<col style="width: *;" />
				</colgroup>
		<c:if test="${boardinfo.boardCd != 'Q'}">
			<tr>
					<th scope="row">
						<c:forEach var="i" items="${array_item}" varStatus="status">
							<c:if test="${i eq 'attach'}">
								${array_view[status.index]} <c:if test="${fn:indexOf(boardinfo.itemRequired, 'attach') != -1}"><strong class="color_pointr">*</strong></c:if>
							</c:if>
						</c:forEach>
					</th>
					<td>
						<%-- ${fn:length(fileList)} --%>
						
						
						<c:if test="${param.mode eq 'E' and fn:length(fileList) > 0 }">
						<div class="file_area" id="file_area1">							
							<c:forEach items="${fileList}" var="list" varStatus="status">
							<ul>								
								<li id = "uploaded_${status.index}">
									<a href="/commonfile/fileidDownLoad.do?fileId=${list.fileId}&attachId=${list.attachId}"  target="_blank" class="download" title="다운받기">
										${list.originFileNm }(${list.fileSize}KB)
									</a>
									<a href='javascript:delFile("${list.fileId}","${list.attachId}","${status.index}");' class="btn_file_delete" data-file_id="${list.file_id}" title="파일 삭제">
										<img src="/images/back/icon/icon_delete.png" alt="삭제" />
									</a>
								</li>
								
							</ul>
							</c:forEach>
						</div>
						</c:if>
						
						<div id = "totalFileDiv">
							<div id="attach_file" style = "<c:if test="${fn:length(fileList) > 0}">display:none</c:if>">
								<div class="file_area">
									<label for="attached_file" class="hidden">파일 선택하기</label>
									<input id="attached_file" name="attached_file" type="file" class="in_wp400" 
										<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}">data-parsley-required="true"</c:if> 
									/>								
								</div>
							</div>
							<div id="attach_file" style = "<c:if test="${fn:length(fileList) > 1}">display:none</c:if>">
								<div class="file_area">
									<label for="attached_file" class="hidden">파일 선택하기</label>
									<input id="attached_file" name="attached_file" type="file" class="in_wp400" 
										<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}">data-parsley-required="true"</c:if> 
									/>								
								</div>
							</div>
							<div id="attach_file" style = "<c:if test="${fn:length(fileList) > 2}">display:none</c:if>">
								<div class="file_area">
									<label for="attached_file" class="hidden">파일 선택하기</label>
									<input id="attached_file" name="attached_file" type="file" class="in_wp400" 
										<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}">data-parsley-required="true"</c:if> 
									/>								
								</div>
							</div>
							<div id="attach_file" style = "<c:if test="${fn:length(fileList) > 3}">display:none</c:if>">
								<div class="file_area">
									<label for="attached_file" class="hidden">파일 선택하기</label>
									<input id="attached_file" name="attached_file" type="file" class="in_wp400" 
										<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}">data-parsley-required="true"</c:if> 
									/>								
								</div>
							</div>
							<div id="attach_file" style = "<c:if test="${fn:length(fileList) > 4}">display:none</c:if>">
								<div class="file_area">
									<label for="attached_file" class="hidden">파일 선택하기</label>
									<input id="attached_file" name="attached_file" type="file" class="in_wp400" 
										<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}">data-parsley-required="true"</c:if> 
									/>								
								</div>
							</div>
						</div>
					</td>
					
					
					<%-- 원본 <td>
						<div id="attach_file">
							<div class="file_area">
								<label for="attached_file" class="hidden">파일 선택하기</label>
								<input id="attached_file" name="attached_file" type="file" class="in_wp400" 
									<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}">data-parsley-required="true"</c:if> 
								/>
								<button class="marginl20" title="추가하기" id="addbtn" onclick="addFile()">
									<span><img src="/images/back/common/btn_file_add.png" alt="파일추가하기" /></span>
								</button>
							</div>
						</div>
						<c:if test="${param.mode eq 'E'}">
						<div class="file_area" id="file_area1">
							<ul class="file_list">
								<c:forEach items="${fileList }" var="list">
								<li>
									<a href="/commonfile/fileidDownLoad.do?file_id=${list.file_id}"  target="_blank" class="download" title="다운받기">
										${list.origin_file_nm }(${size }KB)
									</a>
									<a href="javascript:;" class="btn_file_delete" data-file_id="${list.file_id}" title="파일 삭제">
										<img src="/images/back/icon/icon_delete.png" alt="삭제" />
									</a>
								</li>
								</c:forEach>
							</ul>
						</div>
						</c:if>
					</td> --%>
				</tr>
				</c:if>
			</table>
			
			<c:if test="${param.boardId eq '20082'}">
			<table id="table" style="display: none;">
				<caption>등록 화면</caption>
				<colgroup>
					<col style="width: 120px;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
					<tr>
						<th>제목</th>
						<th>경영체명</th>
						<th>대표자명</th>
						<th>사업자등록번호</th>
						<th>법인등록번호</th>
						<th>설립연도</th>
						<th>소재지(본사)</th>
						<th>전화번호</th>
						<th>팩스</th>
						<th>임직원수</th>
						<th>담당자 직통전화(유선)</th>
						<th>사업분야</th>
						<th>사업내용</th>
						<th>주생산품목</th>
						<th>매출액 17년</th>
						<th>매출액 18년</th>
						<th>매출액 19년</th>
						<th>홈페이지</th>
						<th>투자 유치 희망 금액</th>
						<th>첨부파일</th>
					</tr>
					<tr>
						<td>
							<input type="text" name="etc1" class="in_w80" value="${contentsinfo.title}" data-parsley-required="true" />
						</td>
						<td>
							<input type="text" name="etc1" class="in_w80" value="${contentsinfo.etc1}" data-parsley-required="true" />
						</td>
						<td>
							<input type="text" name="etc2" class="in_w80" value="${contentsinfo.etc2}" data-parsley-required="true" />
						</td>
						<td>
							<input type="text" name="etc3" class="in_w80" value="${contentsinfo.etc3}" data-parsley-required="true" />
						</td>
						<td>
							<input type="text" name="etc4" class="in_w80" value="${contentsinfo.etc4}"  />
						<td>
							<input type="text" name="etc5" class="in_w80" value="${contentsinfo.etc5}" />
						</td>
						<td>
							<input type="text" name="etc6" class="in_w80" value="${contentsinfo.etc6}" data-parsley-required="true" />
						</td>
						<td>
							<input type="text" name="etc7" class="in_w80" value="${contentsinfo.etc7}" data-parsley-required="true" />
						</td>
						<td>
							<input type="text" name="etc8" class="in_w80" value="${contentsinfo.etc8}" />
						</td>
						<td>
							<input type="text" name="etc9" class="in_w80" value="${contentsinfo.etc9}" />
						</td>
						<td>
							<input type="text" name="etc11" class="in_w80" value="${contentsinfo.etc11}" data-parsley-required="true" />
						</td>
						<td>
							<input type="text" name="etc12" class="in_w80" value="${contentsinfo.etc0}" data-parsley-required="true" />
						</td>
						<td>
							<input type="text" name="etc13" class="in_w80" value="${contentsinfo.etc13}" data-parsley-required="true" />
						</td>
						<td>
							<input type="text" name="etc14" class="in_w80" value="${contentsinfo.etc14}" data-parsley-required="true" />
						</td>
						<td>
							(<input type="text" name="etc15" class="in_w10" value="${contentsinfo.etc15}" />)억원
						</td>
						<td>
							(<input type="text" name="etc16" class="in_w10" value="${contentsinfo.etc16}" />)억원
						</td>
						<td>
							(<input type="text" name="etc17" class="in_w10" value="${contentsinfo.etc17}" />)억원
						</td>
						<td>
							<input type="text" name="etc18" class="in_w80" value="${contentsinfo.etc18}"/>
						</td>
						<td>
							(<input type="text" name="etc19" class="in_w10" value="${contentsinfo.etc19}" data-parsley-required="true" />)억원
						</td>
						<td>
							<c:if test="${fn:length(fileList) > 0 }">
								<div class="file_area" id="file_area1">
									<ul class="file_list">
										<c:forEach items="${fileList}" var="list">
										<li>
											<a href="/commonfile/fileidDownLoad.do?fileId=${list.fileId}&attachId=${list.attachId}"  target="_blank" class="download" title="다운받기">
												${list.originFileNm }(${list.fileSize}KB)
											</a>
											<a href='javascript:delFile("${list.fileId}","${list.attachId}");' class="btn_file_delete" data-file_id="${list.file_id}" title="파일 삭제">
												<img src="/images/back/icon/icon_delete.png" alt="삭제" />
											</a>
										</li>
										</c:forEach>
									</ul> 
								</div>
							</c:if>
						</td>
				</tbody>
				</table>
				</c:if>
				
				
				<c:if test="${param.boardId eq '20057'}">
					<tr>
						<th scope="row">경영체명</th>
						<td>
							<input type="text" name="etc1" class="in_w50" value="${contentsinfo.etc1}" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">대표번호</th>
						<td>
							<input type="text"  name="etc2" class="in_w50" value="${contentsinfo.etc2}" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">기업형태</th>
						<td>
							<select name="etc3" class="in_w50"><option value="개인">개인</option><option value="농어업법인">농어업법인</option><option value="일반법인">일반법인</option></select>
						</td>
					</tr>
					<tr>
						<th scope="row">자본금</th>
						<td>
							<input type="text" name="etc4" class="in_w30" value="${contentsinfo.etc4}"  data-parsley-type="integer" />백만원
						</td>
					</tr>
					<tr>
						<th scope="row">주소(본사)</th>
						<td><input type="text" name="etc5" class="in_w50" value="${contentsinfo.etc5}"/></td>
					</tr>
					<tr>
						<th scope="row">주요제품</th>
						<td>
							<input type="text" name="etc6" class="in_w50" value="${contentsinfo.etc6}" />
						</td>
					<tr>
						<th scope="row">전년도매출액</th>
						<td>
							<input type="text" name="etc7" class="in_w30" value="${contentsinfo.etc7}"  data-parsley-type="integer"/>백만원
						</td>
					</tr>
					
					<c:forEach var="itemFront" items="${fileList}" varStatus="status">
						<tr>
							<th scope="row">첨부파일</th>
							<td colspan="3">
							<div id="attach_file" style = "<c:if test="${fn:length(fileList) > 0}">display:none</c:if>">
								<div class="file_area">
									<label for="attached_file" class="hidden" style="display:none;">파일 선택하기</label>
									<input id="attached_file" name="attached_file" type="file" class="in_wp400"
										<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}">data-parsley-required="true"</c:if>
									/>
								</div>
							</div>
								<c:if test="${fn:length(fileList) > 0 }">
									<div class="file_area" id="file_area1">
										<ul class="file_list">
											<c:forEach items="${fileList}" var="list">
											<li>
												<a href="/commonfile/fileidDownLoad.do?fileId=${list.fileId}&attachId=${list.attachId}"  target="_blank" class="download" title="다운받기">
													${list.originFileNm }(${list.fileSize}KB)
												</a>
												<a href='javascript:delFile("${list.fileId}","${list.attachId}");' class="btn_file_delete" data-file_id="${list.file_id}" title="파일 삭제">
													<img src="/images/back/icon/icon_delete.png" alt="삭제" />
												</a>
											</li>
											</c:forEach>
										</ul> 
									</div>
								</c:if>
							</td>
						</tr>
					</c:forEach>
						
						
						
						
						
					</tr>
					
				</tbody>
			</table>
			</c:if>
		</div>
		<!--// write_basic -->
	</form>
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<c:if test="${param.mode ne 'E'}">
				<button onclick="contentsWrite()" class="btn save" title="저장하기">
					<span>저장</span>
				</button>
				</c:if>
				<!-- 수정/삭제버튼 추가 -->
				<c:if test="${param.boardId eq '20082' 
								or param.boardId eq '20083'}">
	                <a href="javascript:excelDownload('${contentsinfo.title}')" class="btn save" title="엑셀 다운로드">엑셀 다운로드</a>
	                <button id="answerSave" class="btn save" onclick="contentsAnswer()" title="답변하기">
							<span>답변하기</span>
						</button>
				</c:if>
				<c:if test="${contentsinfo.delYn eq 'N'}">
					<c:if test="${fn:indexOf(boardinfo.itemUse, 'reply_yn') != -1}">
						<c:if test="${param.mode ne 'A'}">
						<c:if test="${param.boardId ne '20082' 
								or param.boardId ne '20083'}">
							<button id="answerSave" class="btn save" onclick="contentsAnswer()" title="답변하기">
								<span>답변하기</span>
							</button>
						</c:if>
						</c:if>
					</c:if>
					<c:if test="${param.mode eq 'E'}">
							<button id="modBtn" onclick="contentsWrite()" class="btn save" title="수정하기">
								<span>수정</span>
							</button>
					<button id="delBtn" onclick="contentsDelete('Y')" class="btn cancel" title="삭제하기">
						<span>삭제</span>
					</button>
					</c:if>
				</c:if>
				<c:if test="${contentsinfo.delYn eq 'Y'}">
				<button id="delBtn" onclick="contentsDelete('N')" class="btn cancel" title="복원하기">
					<span>복원</span>
				</button>
				</c:if>

				<a href="javascript:list()" class="btn list" title="목록 페이지로 이동">
					<span>목록</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->
</div>

<script language="javascript">
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

function excelDownload ( pFileName ) {
	$("#table").table2excel({ 
		exclude: ".noExl"
		, name: "Excel Document Name", 
		filename: pFileName +'.xls', //확장자를 여기서 붙여줘야한다. 
		fileext: ".xls", 
		exclude_img: true, 
		exclude_links: true, 
		exclude_inputs: true 
	});
}

</script>