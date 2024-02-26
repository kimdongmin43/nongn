<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<% java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	String now = formatter.format(new java.util.Date());
%>

<script src="<c:url value='/dext5editor/js/dext5editor.js' />" charset="utf-8"></script>

<script>
var insertLocationpageUrl = "<c:url value='/back/contents/insertLocationpage.do'/>";
var updateLocationpageUrl = "<c:url value='/back/contents/updateLocationpage.do'/>"
var deleteLocationpageUrl = "<c:url value='/back/contents/deleteLocationpage.do'/>";

$(document).ready(function(){



});

function locationpageListPage() {
    var f = document.writeFrm;

    f.target = "_self";
    f.action = "/back/contents/locationpageListPage.do";
    f.submit();
}

function locationpageUpdate(){


	if ( $("#writeFrm").parsley().validate() ){
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						locationpageListPage();
  					}
  				},
  				dataType: "json",
  				url: updateLocationpageUrl
  		    });

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
    		   <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
				<input type='hidden' id="contents" name='contents' value=' ${locationpage.contents}' />
				<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
				<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
				<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
				<input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
				<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="<c:out value="${param.p_searchtxt}" escapeXml="true" />" />
			    <input type='hidden' id="p_satis_yn" name='p_satis_yn' value="${param.p_satis_yn}" />
				<input type='hidden' id="mode" name='mode' value="${param.mode}" />
			    <input type='hidden' id="locId" name='locId' value="${locationPageInfo.locId}" />
			    <input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />


		<div id="content">

					<!-- table_area -->
					<div class="table_area">
						<table class="write">
							<caption>등록 화면</caption>
							<colgroup>
								<col style="width: 160px;">
								<col style="width: *;">
								<col style="width: 160px;">
								<col style="width: *;">
							</colgroup>
							<tbody>
							<c:if test="${locationPageInfo.gubun eq 'B'}">
							<tr>
								<th scope="row">
									<label for="branchNm">명칭 <strong class="color_pointr">*</strong></label>
								</th>
								<td colspan="3">
									<input id="branchNm" name="branchNm" type="text" class="in_w100" <c:if test="${locationPageInfo.gubun eq 'B'}">data-parsley-required="true"</c:if> value = "${locationPageInfo.branchNm}"/>
								</td>
							</tr>
							</c:if>
							<tr>
								<th scope="row">
									<label for="addr2">주소 <strong class="color_pointr">*</strong></label>
								</th>
								<td colspan="3">
									<input id="addr2" name="addr2" type="text" class="in_w100" data-parsley-required="true" value = "${locationPageInfo.addr2}" />
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="lng">지도좌표(위도:X) <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="lng" name="lng" type="text" class="in_w100" data-parsley-required="true"  value = "${locationPageInfo.lng}"/>
								</td>
								<th scope="row">
									<label for="lat">지도좌표(위도:Y) <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="lat" name="lat" type="text" class="in_w100" data-parsley-required="true" value = "${locationPageInfo.lat}" />
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="tel">연락처 <strong class="color_pointr">*</strong></label>
								</th>
								<td colspan="3">
									<input id="tel" name="tel" type="text" class="in_w100" data-parsley-required="true" value = "${locationPageInfo.tel}"/>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="explain">위치설명</label>
								</th>
								<td colspan="3">
									<input id="locDesc" name="locDesc" type="text" class="in_w100" value = "${locationPageInfo.locDesc}"/>
								</td>
							</tr>
							<tr>
								<th scope="row">비고</th>
								<td colspan="3">
									<textarea rows="5" class="in_w100" id = "locComment" name = "locComment">${locationPageInfo.locComment}</textarea>
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<!--// table_area -->
					<!-- button_area -->
					<div class="button_area">
						<div class="float_right">
							<a class="btn save" title="저장하기" onclick="locationpageUpdate()">
								<span>저장</span>
							</a>
						</div>
					</div>
					<!--// button_area -->
				</div>
</form>
</div>
<!--// content -->
