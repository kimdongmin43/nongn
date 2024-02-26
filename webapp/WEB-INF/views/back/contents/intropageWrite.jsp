<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<% java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	String now = formatter.format(new java.util.Date());
%>

<script src="<c:url value='/smarteditor2/js/HuskyEZCreator.js' />" charset="utf-8"></script>

<script>
var insertIntropageUrl = "<c:url value='/back/contents/insertIntropage.do'/>";
var updateIntropageUrl = "<c:url value='/back/contents/updateIntropage.do'/>"
var deleteIntropageUrl = "<c:url value='/back/contents/deleteIntropage.do'/>";

$(document).ready(function(){


});

function intropageListPage() {

    var f = document.writeFrm;
    f.target = "_self";
    f.action = "/back/contents/intropageListPage.do";
    f.submit();
}

function intropageInsert(){
	
	var oriText = oEditors.getById["contents"].getIR();		//	검색속도 향상을 위해 내용의 HTML 태그를 제거하는 기능 추가 - 2020.11.05
	var newText = oriText.replace(/(<([^>]+)>)/ig,"");
	$("#contentsSrch").val(newText);

	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);

	
	   if($("#contents").val() == ""){
		     alert("내용을 입력해주십시요.");
		     return;
	   }
	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){

		   url = insertIntropageUrl;
		   if($("#mode").val() == "E") url = updateIntropageUrl;

		   // 데이터를 등록 처리해준다.

		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						intropageListPage();
  					}
  				},
  				dataType: "json",
  				url: url
  		    });
	   }
}

function intropageDelete(){
	   if(!confirm("소개페이지를 정말 삭제하시겠습니까?")) return;

		$.ajax
		({
			type: "POST",
	           url: deleteIntropageUrl,
	           data:{
	           	contId : $("#contId").val()
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					intropageListPage();
				}
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
			<h3 class="title"><c:if test="${intropage.title eq null}">${MENU.menuNm}</c:if><c:if test="${intropage.title ne null}">${intropage.title}</c:if></h3>
		</div>
		<!--// main_title -->
		 <jsp:include page="/WEB-INF/views/back/menu/menuDescInclude.jsp"/>
		</div>
    		   <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
				
				<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
				<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
				<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
				<input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
				<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="<c:out value="${param.p_searchtxt}" escapeXml="true" />" />
			    <input type='hidden' id="p_satis_yn" name='p_satis_yn' value="${param.p_satis_yn}" />
				<input type='hidden' id="mode" name='mode' value="${param.mode}" />
			    <input type='hidden' id="contId" name='contId' value="${intropage.contId}" />
			    <input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
				<input type='hidden' id="contentsSrch" name='contentsSrch' value="" />



			<!-- write_basic -->
			<div class="table_area">
				  <table class="view">
					<caption>상세보기 화면</caption>
					<colgroup>
						<col style="width: 140px;" />
						<col style="width: *;" />
						<col style="width: 140px;" />
						<col style="width: *;" />
					</colgroup>
					<tbody>
					<c:if test="${param.mode == 'E' }">
					<tr>
						<th scope="row">등록자</th>
						<td>${intropage.regUserNm}</td>
						<th scope="row">등록일</th>
						<td>${intropage.regdt}</td>
					</tr>

					</c:if>
						<c:if test="${param.mode == 'W' }">
					<tr>
						<th scope="row">등록자</th>
						<td>${USER.userNm}</td>
						<th scope="row">등록일</th>
						<td><%=now%></td>
					</tr>

					</c:if>
					<tr>
						<th scope="row"><label for="title"> 콘텐츠명<span class="asterisk">*</span> </label></th>
						<td colspan="3">
							  <input class="in_w100" type="text" id="title" name="title" value="${intropage.title}" placeholder="콘텐츠명" data-parsley-required="true" data-parsley-maxlength="100" />
						</td>
					</tr>
					<tr>
						<th scope="row" colspan="4">내용</th>
					</tr>
					
					</tbody>
				</table>
				<div class="editor_area view">
				     <textarea class="form-control" id="contents" name="contents" placeholder="내용" rows="20" style="width:100%;height:400px;" >${intropage.contents}</textarea>
				</div>
				
			</div>
			<!--// write_basic -->

			<!-- button_area -->
			<div class="button_area">
				<div class="float_right">

					<c:if test="${param.mode == 'W' }">
					<a href="javascript:intropageInsert();" class="btn save" title="저장">
						<span>저장</span>
					</a>
					</c:if>
					 <c:if test="${param.mode == 'E' }">
					<a href="javascript:intropageInsert();" class="btn save" title="수정">
						<span>수정</span>
					</a>
					<a href="javascript:intropageDelete();" class="btn save" title="삭제">
						<span>삭제</span>
					</a>
					</c:if>
					<a href="javascript:intropageListPage();" class="btn cancel" title="취소">
						<span>취소</span>
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
