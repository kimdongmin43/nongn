<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" rel="stylesheet" />
<script src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script>



var selectdisclosureUrl = "<c:url value='/back/contents/disclosurePageList.do'/>";
var insertdisUrl = "<c:url value='/back/contents/insertDis.do'/>";
var updatedisUrl =  "<c:url value='/back/contents/updateDis.do'/>";

function disInsert(){
	   var url = "";

	   if ( $("#writeFrm").parsley().validate() ){

		   url = insertdisUrl;
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						search();
						list();
	
					}
				},
				dataType: "json",
				url: url
		    });

	   }
}



function disSave(){


	   var url = "";

	   if ( $("#writeFrm").parsley().validate() ){

		   url = updatedisUrl;
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						search();
						list();
					
					}
				},
				dataType: "json",
				url: url
		    });

	   }
	}
	
	
function search() {		
	
	jQuery("#intropage_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectdisclosureUrl,
		page : 1,
		postData : {
			
			searchtxt : $("#p_searchtxt").val(),
		
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}
	
	
function getSelectValue(frm)
{

 frm.year.value = frm.searchKey.options[frm.searchKey.selectedIndex].value;
}	
	

function list() {

	var f = document.writeFrm;
    f.target = "_self";
    f.action = "/back/contents/disclosurePage.do?menuId=5455";
    f.submit();
    
    
}




</script>

<form id="writeFrm" name="writeFrm" method="post" data-parsley-validate="true" enctype="multipart/form-data">

 <input type='hidden' id="disId" name='disId' value="${param.disId}" /> 
 




			<!-- write_basic -->
		<div class="table_area">
			<table class="write">
				<caption>주요지표 등록화면</caption>
				<colgroup>
					<col style="width: 140px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
		
				
<%-- 						<tr>
					<th scope="row">연도</th>
					<td>
						  <input class="in_w25" type="text"  id="year" name="year" value="${dis.year}" data-parsley-required="true" data-parsley-maxlength="8"  />
					  </td>
				</tr> --%>
				
				<tr>
						<th scope="row">연도</th>
						<td >
                            <select id='year' name='year' title='내선전화 첫번째자리' class="in_w10">
                                    <option value='' >선택</option>
								    <option value='2018' <c:if test="${dis.year == '2018'}">selected</c:if>>2018</option>
									<option value='2017' <c:if test="${dis.year == '2017'}">selected</c:if>>2017</option>
									<option value='2016' <c:if test="${dis.year == '2016'}">selected</c:if>>2016</option>
								                     
                           </select>
                       </td>
					</tr>
				
				
		
				
				<tr>
					<th scope="row">공시일자</th>
					<td>
						<input type="text" id="disDt" name="disDt" class="in_wp100 datepicker"  readonly  value="${dis.disDt}" />
					</td>
				</tr>
		
			<%-- 	<tr>
			 		<th scope="row">공시품목</th>
					<td>
						<label for="disItem" class="hidden">홈페이지 주소 입력</label>
						  <input class="in_w25" type="text"  id="disItem" name="disItem" value="${dis.disItem}" data-parsley-required="true" data-parsley-maxlength="30"  />
					</td>
				</tr> --%>
				
				<tr>
						<th scope="row">공시품목</th>
						<td >
                            <select id='disItem' name='disItem' title='내선전화 첫번째자리' class="in_w10">
                                    <option value='' >선택</option>
								    <option value='감자 대지' <c:if test="${dis.disItem == '감자 대지'}">selected</c:if>>감자 대지</option>
									<option value='고구마 풍원미' <c:if test="${dis.disItem == '고구마 풍원미'}">selected</c:if>>고구마 풍원미</option>
									<option value='나물콩' <c:if test="${dis.disItem == '나물콩'}">selected</c:if>>나물콩</option>
									<option value='마늘(난지형 남도종)' <c:if test="${dis.disItem == '마늘(난지형 남도종)'}">selected</c:if>>마늘(난지형 남도종)</option>
									<option value='마늘(난지형 대서종)' <c:if test="${dis.disItem == '마늘(난지형 대서종)'}">selected</c:if>>마늘(난지형 대서종)</option>
									<option value='마늘(한지형)' <c:if test="${dis.disItem == '마늘(한지형)'}">selected</c:if>>마늘(한지형)</option>
									<option value='밤고구마' <c:if test="${dis.disItem == '밤고구마'}">selected</c:if>>밤고구마</option>
									<option value='밤고구마' <c:if test="${dis.disItem == '밤고구마'}">selected</c:if>>밤고구마</option>
									<option value='배추' <c:if test="${dis.disItem == '배추'}">selected</c:if>>배추</option>
									<option value='양파' <c:if test="${dis.disItem == '양파'}">selected</c:if>>양파</option>
									<option value='콩 백태' <c:if test="${dis.disItem == '콩 백태'}">selected</c:if>>콩 백태</option>
									<option value='콩 서리태' <c:if test="${dis.disItem == '콩 서리태'}">selected</c:if>>콩 서리태</option>
									<option value='콩 흑태' <c:if test="${dis.disItem == '콩 흑태'}">selected</c:if>>콩 흑태</option>
									<option value='포도 거봉' <c:if test="${dis.disItem == '포도 거봉'}">selected</c:if>>포도 거봉</option>
									<option value='포도 델라웨어' <c:if test="${dis.disItem == '포도 델라웨어'}">selected</c:if>>포도 델라웨어</option>
									<option value='포도 마스캇베리에이' <c:if test="${dis.disItem == '포도 마스캇베리에이'}">selected</c:if>>포도 마스캇베리에이</option>
									<option value='포도 샤인마스캇' <c:if test="${dis.disItem == '포도 샤인마스캇'}">selected</c:if>>포도 샤인마스캇</option>
									<option value='포도 캠벨얼리' <c:if test="${dis.disItem == '포도 캠벨얼리'}">selected</c:if>>포도 캠벨얼리</option>
                          			<option value='호박고구마' <c:if test="${dis.disItem == '호박고구마'}">selected</c:if>>호박고구마</option>
                       
                           </select>
                       </td>
					</tr>
				
				
				<tr>
			 		<th scope="row">공시단위</th>
					<td>
						<label for="disUnit" class="hidden">홈페이지 주소 입력</label>
						  <input class="in_w25" type="text"  id="disUnit" name="disUnit" value="${dis.disUnit}" data-parsley-required="true" data-parsley-maxlength="30"  />
					</td>
				</tr>
		
	
				<tr>
			 		<th scope="row">공시금액</th>
					<td>
						<label for="disPrice" class="hidden">홈페이지 주소 입력</label>
						  <input class="in_w25" type="text"  id="disPrice" name="disPrice" value="${dis.disPrice}" data-parsley-required="true" data-parsley-maxlength="10"  />
					</td>
				</tr>
				
				<tr>
					<th scope="row">구분</th>
					<td>
						 <input type="radio" name="gubun" value="F" <c:if test="${dis.gubun == 'F'}">checked</c:if>> 기준가격
						 <input type="radio" name="gubun" value="L"  <c:if test="${dis.gubun == 'L'}">checked</c:if>> 수확기가격
					</td>
				</tr>
			


				</tbody>
			</table>
		</div>

			
		<!--// write_basic -->
		<!-- footer -->
		<div id="footer">
		<footer>
			<div class="button_area alignc">
			   <c:if test="${param.mode == 'W'}">
				<a href="javascript:disInsert()" class="btn save" title="등록">
					<span>등록</span>
				</a>
			  </c:if>
                 <c:if test="${param.mode == 'E' }">
                 	<a href="javascript:disSave()" class="btn save" title="수정">
					<span>수정</span>
				</a>
				
				</c:if>
				<a href="javascript:list()" class="btn cancel" title="닫기">
					<span>뒤로</span>
				</a>
			</div>
		</footer>
		</div>
		<!-- //footer -->
</form>


<script>
$('.datepicker').each(function(){
	 $(this).datepicker({
		  dateFormat : "yy.mm.dd",
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
		 })});

</script>

