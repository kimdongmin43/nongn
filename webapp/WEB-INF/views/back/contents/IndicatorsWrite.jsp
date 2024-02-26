<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	String now = formatter.format(new java.util.Date());
%>

<script>
var selectIndicatorsUrl = "<c:url value='/back/contents/IndicatorsPageList.do'/>";
var insertIndicatorsUrl = "<c:url value='/back/contents/insertIndicators.do'/>";
var updateIndicatorUrl =  "<c:url value='/back/contents/updateIndicators.do'/>";
var deleteIndicatorUrl =  "<c:url value='/back/contents/deleteIndicators.do'/>";


function IndicatorsInsert(){
	   var url = "";

	   if ( $("#writeFrm").parsley().validate() ){

		   url = insertIndicatorsUrl;
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



function IndicatorsSave(){


	   var url = "";

	   if ( $("#writeFrm").parsley().validate() ){

		   url = updateIndicatorUrl;
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
	
	
function IndicatorsDel(){


	   var url = "";

	   if ( $("#writeFrm").parsley().validate() ){

		   url = deleteIndicatorUrl;
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert("1건 삭제했습니다.");
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
		url : selectIndicatorsUrl,
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
    f.action = "/back/contents/IndicatorsListPage.do?menuId=4950";
    f.submit();
    
    
}




</script>

<form id="writeFrm" name="writeFrm" method="post" data-parsley-validate="true" enctype="multipart/form-data">

 <input type='hidden' id="farmId" name='farmId' value="${param.farmId}" /> 
 




			<!-- write_basic -->
		<div class="table_area">
			<table class="write">
				<caption>주요지표 등록화면</caption>
				<colgroup>
					<col style="width: 140px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
			
				
				
						<tr>
					<th scope="row">연도</th>
					<td>
						  <input class="in_w25" type="text"  id="year" name="year" value="${indica.year}" data-parsley-required="true" data-parsley-maxlength="8"  />
					  </td>
				</tr>
		
				

		
				<tr>
					<th scope="row">대상품목(축종)수</th>
					<td>
						  <input class="in_w25" type="text"  id="itemNum" name="itemNum" value="${indica.itemNum}" data-parsley-required="true" data-parsley-maxlength="30"  />
					  </td>
				</tr>
		
				<tr>
			 		<th scope="row">가입면적(두수)</th>
					<td>
						<label for="url" class="hidden">홈페이지 주소 입력</label>
						  <input class="in_w25" type="text"  id="joinNum" name="joinNum" value="${indica.joinNum}" data-parsley-required="true" data-parsley-maxlength="30"  />
					</td>
				</tr>
				<tr>
			 		<th scope="row">가입농가수</th>
					<td>
						<label for="url" class="hidden">홈페이지 주소 입력</label>
						  <input class="in_w25" type="text"  id="houseNum" name="houseNum" value="${indica.houseNum}" data-parsley-required="true" data-parsley-maxlength="30"  />
					</td>
				</tr>
				<tr>
			 		<th scope="row">가입금액</th>
					<td>
						<label for="url" class="hidden">홈페이지 주소 입력</label>
						  <input class="in_w25" type="text"  id="subFee" name="subFee" value="${indica.subFee}" data-parsley-required="true" data-parsley-maxlength="30"  />
					</td>
				</tr>
				<tr>
			 		<th scope="row">순보험료</th>
					<td>
						<label for="url" class="hidden">홈페이지 주소 입력</label>
						  <input class="in_w25" type="text"  id="premium" name="premium" value="${indica.premium}" data-parsley-required="true" data-parsley-maxlength="30"  />
					</td>
				</tr>
				<tr>
			 		<th scope="row">가입률</th>
					<td>
						<label for="url" class="hidden">홈페이지 주소 입력</label>
						  <input class="in_w25" type="text"  id="subRate" name="subRate" value="${indica.subRate}" data-parsley-required="true" data-parsley-maxlength="30"  />
					</td>
				</tr>
				
				<tr>
					<th scope="row">구분</th>
					<td>
						 <input type="radio" name="gubun" value="F" <c:if test="${indica.gubun == 'F'}">checked</c:if>> 농작물
						 <input type="radio" name="gubun" value="L"  <c:if test="${indica.gubun == 'L'}">checked</c:if>> 가축
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
				<a href="javascript:IndicatorsInsert()" class="btn save" title="등록">
					<span>등록</span>
				</a>
			  </c:if>
                 <c:if test="${param.mode == 'E' }">
                 	<a href="javascript:IndicatorsSave()" class="btn save" title="수정">
					<span>수정</span>
				</a>
				
				</c:if>
				
				   <c:if test="${param.mode == 'E' }">
                 	<a href="javascript:IndicatorsDel()" class="btn save" title="삭제">
					<span>삭제</span>
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