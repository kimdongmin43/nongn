<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
var disUrl =  "<c:url value='/front/contents/disclosurePage.do'/>";
var gridUrl = "<c:url value='/front/contents/chartDownload.do'/>";
function getSelectValue(frm)
{
 frm.searchTxt.value = frm.searchKey.options[frm.searchKey.selectedIndex].value;
 frm.searchTxt2.value = frm.searchKey2.options[frm.searchKey2.selectedIndex].value;
 frm.searchTxt3.value = frm.searchKey3.options[frm.searchKey3.selectedIndex].value;
 frm.searchTxt4.value = frm.searchKey4.options[frm.searchKey4.selectedIndex].value;
}



var codeList;	//230418 임동균 
function sectionCd(){
	codeList = [];
	$.ajax({
		url: "/front/contents/disclosurePageCodeList.do",
        data: {
        	searchTxt4 : $("#searchKey4").val()
        },		
		type: "GET",
		cache:false,
		timeout : 30000,
		contentType: "application/json; charset=UTF-8",
		dataType:"json",
		success: function(obj){		
			
			if(obj.dis3 == null || obj.dis3.length == 0){
				$("#searchKey2").innerHTML = "";
			}
			else{
				var bodyStr = "<option value=''>전체</option>";
				for(var i=0; i<obj.dis3.length; i++){
					 bodyStr += "<option value='"+ obj.dis3[i]['disItem'] +"''>" + obj.dis3[i]['disItemNm'] + "</option>";
				}
				
				$("#searchKey2").html(bodyStr);
			}
		},
		failure: function(obj){
			alert("fail");
		},
		scope: this
	});	
}

/*
function sectionCd(){
		
	
		var searchKey2 = $("#searchKey2").val();
		var searchKey3 = $("#searchKey3").val();
		var searchKey4 = $("#searchKey4").val();
		
		
		if( searchKey4 == "1"){
			$("#searchKey2").find("option").remove();
		     $("#searchKey2").append("<option value='1' selected>감자 대지</option>");
		}
		if( searchKey4 == "2"){
			$("#searchKey2").find("option").remove();
			 $("#searchKey2").append("<option value='' selected>전체</option>");
		     $("#searchKey2").append("<option value='2' selected>나물콩</option>");
		     $("#searchKey2").append("<option value='3' selected>콩 백태</option>");
		     $("#searchKey2").append("<option value='4' selected>콩 서리태</option>");
		     $("#searchKey2").append("<option value='5' selected>콩 흑태</option>");
		}
		if( searchKey4 == "3"){
			$("#searchKey2").find("option").remove();
			 $("#searchKey2").append("<option value='' selected>전체</option>");
		     $("#searchKey2").append("<option value='6' selected>마늘(난지형 남도종)</option>");
		     $("#searchKey2").append("<option value='7' selected>마늘(난지형 대서종)</option>");
		     $("#searchKey2").append("<option value='8' selected>마늘(한지형)</option>");
		}
		if( searchKey4 == "4"){
			$("#searchKey2").find("option").remove();
			 $("#searchKey2").append("<option value='' selected>전체</option>");
		     $("#searchKey2").append("<option value='9' selected>양배추</option>");
		}
		if( searchKey4 == "5"){
			$("#searchKey2").find("option").remove();
			 $("#searchKey2").append("<option value='' selected>전체</option>");
		     $("#searchKey2").append("<option value='10' selected>양파</option>");
		     $("#searchKey2").append("<option value='11' selected>양파(조생종)</option>");
		     $("#searchKey2").append("<option value='12' selected>양파(중만생종)</option>");
		}
		if( searchKey4 == "6"){
			$("#searchKey2").find("option").remove();
			 $("#searchKey2").append("<option value='' selected>전체</option>");
		     $("#searchKey2").append("<option value='13' selected>포도 거봉</option>");
		     $("#searchKey2").append("<option value='14' selected>포도 거봉(노지)</option>");
		     $("#searchKey2").append("<option value='15' selected>포도 거봉(시설)</option>");
		     $("#searchKey2").append("<option value='16' selected>포도 델라웨어</option>");
		     $("#searchKey2").append("<option value='17' selected>포도 마스캇베리에이</option>");
		     $("#searchKey2").append("<option value='18' selected>포도 샤인머스켓(노지)</option>");
		     $("#searchKey2").append("<option value='19' selected>포도 샤인머스켓(시설)</option>");
		     $("#searchKey2").append("<option value='20' selected>포도 캠벨얼리</option>");
		     $("#searchKey2").append("<option value='21' selected>포도 캠벨얼리(노지)</option>");
		     $("#searchKey2").append("<option value='22' selected>포도 캠벨얼리(시설)</option>");
		}
		if( searchKey4 == "7"){
			$("#searchKey2").find("option").remove();
			 $("#searchKey2").append("<option value='' selected>전체</option>");
		     $("#searchKey2").append("<option value='23' selected>호박고구마</option>");
		     $("#searchKey2").append("<option value='24' selected>밤고구마</option>");
		}
};
*/

function search() {

	var f = document.listFrm;
    f.target = "_self";
    f.action = disUrl;
    f.submit();

}

$( document ).ready(function() {
	$("#skip_nav").focus();		//	키보드 이동을 위해 포커스 - 2020.10.19
});
</script>

	<div class="content_tit">
		<h3>${MENU.menuNm}</h3>
	</div>
	<form name="listFrm"  id="listFrm" method="post" onsubmit="return false;">
		<div class="cont_search_area" id="containerContent">
			<div class="cont_search_box">
				<div class="con_wrap">
					<dl>
						<dt><label for="searchKey">기준년도</label></dt>
						<dd>
							<fieldset>
								<select id="searchKey" name = "searchKey" class = "in_w200 select_style" data-parsley-required="true" onChange="getSelectValue(this.form);" >
									<option value="">전체</option>
									<c:set var="today" value="<%=new java.util.Date()%>" />
									<fmt:formatDate value="${today}" pattern="yyyy" var="end"/>
									<c:forEach begin="2016" end="${end}" var="idx" step="1">
									<option value="<c:out value="${end-idx+2016}" />"  ${param.searchTxt eq end-idx+2016?' selected':''}>
									<c:out value="${end-idx+2016}" /></option>
								 </c:forEach>
								</select>
							</fieldset>
						  <input type="hidden" name="searchTxt" id="searchTxt" value="${param.searchTxt}">
						</dd>
					</dl>
					<dl>
						<!-- forEach 문으로 selectBox 만들기 230417 김동민 대리 -->
						<dt><label for="searchKey4">품목분류</label></dt>
						<dd>
							<fieldset>
								<select name="searchKey4" id="searchKey4" class="select_style" onChange="getSelectValue(this.form); sectionCd();">
									<option value="">전체</option>
									<c:forEach var="dis2" items="${dis2}" varStatus="loop">
									<option value="${dis2.disSectionCd}" <c:if test="${param.searchTxt4 == dis2.disSectionCd}">selected</c:if>>${dis2.disSectionNm}</option>
									</c:forEach>
								</select>
							</fieldset>
							<input type="hidden" name="searchTxt4" id="searchTxt4" value="${param.searchTxt4}">
						</dd>
						<!-- 위에 forEach 방식으로 변경 -->
						<!--<dt><label for="searchKey4" class="pl20">품목분류1111111111111111111</label></dt>
						  <dd>
						   <fieldset>
							<select name="searchKey4" id="searchKey4" title="산출구분 옵션" onChange="getSelectValue(this.form); sectionCd();">
								<option value="" selected>전체</option>
								<option value="1" <c:if test="${param.searchTxt4 == '1'}">selected</c:if>>감자</option>
								<option value="2" <c:if test="${param.searchTxt4 == '2'}">selected</c:if>>콩</option>
								<option value="3" <c:if test="${param.searchTxt4 == '3'}">selected</c:if>>마늘</option>
								<option value="4" <c:if test="${param.searchTxt4 == '4'}">selected</c:if>>배추</option>
								<option value="5" <c:if test="${param.searchTxt4 == '5'}">selected</c:if>>양파</option>
								<option value="6" <c:if test="${param.searchTxt4 == '6'}">selected</c:if>>포도</option>
								<option value="7" <c:if test="${param.searchTxt4 == '7'}">selected</c:if>>고구마</option>                            
							</select>
							</fieldset>
							  <input type="hidden" name="searchTxt4" id="searchTxt4" value="${param.searchTxt4}">
						</dd> -->
					</dl>
					<dl>
						<!-- forEach 문으로 selectBox 만들기 230417 김동민 대리 -->
						<dt><label for="searchKey2">세부품목</label></dt>
						<dd>
							<fieldset>
								<select name="searchKey2" id="searchKey2" class="select_style" title="품목 옵션" onChange="getSelectValue(this.form);">
									<option value="">전체</option>
									<c:forEach var="dis3" items="${dis3}" varStatus="loop">
									<option value="${dis3.disItem}" <c:if test="${param.searchTxt2 == dis3.disItem}">selected</c:if>>${dis3.disItemNm}</option>
									</c:forEach>
								</select>
							</fieldset>
							<input type="hidden" name="searchTxt2" id="searchTxt2" value="${param.searchTxt2}">
						</dd>					
						<!-- 위에 forEach 방식으로 변경 -->
						<!-- <dt><label for="searchKey2" class="pl20">품목명</label></dt>
						  <dd>
						   <fieldset>
						   <select name="searchKey2" id="searchKey2" title="품목 옵션" onChange="getSelectValue(this.form);">
								<option value="" selected>전체</option>
								<option value="1" <c:if test="${param.searchTxt2 == '1'}">selected</c:if>>감자 대지</option>
								<option value="2" <c:if test="${param.searchTxt2 == '2'}">selected</c:if>>나물콩</option>
								<option value="3" <c:if test="${param.searchTxt2 == '3'}">selected</c:if>>콩 백태</option>
								<option value="4" <c:if test="${param.searchTxt2 == '4'}">selected</c:if>>콩 서리태</option>
								<option value="5" <c:if test="${param.searchTxt2 == '5'}">selected</c:if>>콩 흑태</option>
								<option value="6" <c:if test="${param.searchTxt2 == '6'}">selected</c:if>>마늘(난지형 남도종)</option>
								<option value="7" <c:if test="${param.searchTxt2 == '7'}">selected</c:if>>마늘(난지형 대서종)</option> 
								<option value="8" <c:if test="${param.searchTxt2 == '8'}">selected</c:if>>마늘(한지형)</option> 
								<option value="9" <c:if test="${param.searchTxt2 == '9'}">selected</c:if>>양배추</option> 
								<option value="10" <c:if test="${param.searchTxt2 == '10'}">selected</c:if>>양파</option>
								<option value="11" <c:if test="${param.searchTxt2 == '11'}">selected</c:if>>양파(조생종)</option>
								<option value="12" <c:if test="${param.searchTxt2 == '12'}">selected</c:if>>양파(중만생종)</option> 
								<option value="13" <c:if test="${param.searchTxt2 == '13'}">selected</c:if>>포도 거봉</option>
								<option value="14" <c:if test="${param.searchTxt2 == '14'}">selected</c:if>>포도 거봉(노지)</option>
								<option value="15" <c:if test="${param.searchTxt2 == '15'}">selected</c:if>>포도 거봉(시설)</option>                                     
								<option value="16" <c:if test="${param.searchTxt2 == '16'}">selected</c:if>>포도 델라웨어</option>
								<option value="17" <c:if test="${param.searchTxt2 == '17'}">selected</c:if>>포도 마스캇베리에이</option>
								<option value="18" <c:if test="${param.searchTxt2 == '18'}">selected</c:if>>포도 샤인머스켓(노지)</option>
								<option value="19" <c:if test="${param.searchTxt2 == '19'}">selected</c:if>>포도 샤인머스켓(시설)</option>
								<option value="20" <c:if test="${param.searchTxt2 == '20'}">selected</c:if>>포도 캠벨얼리</option>
								<option value="21" <c:if test="${param.searchTxt2 == '21'}">selected</c:if>>포도 캠벨얼리(노지)</option>   
								<option value="22" <c:if test="${param.searchTxt2 == '22'}">selected</c:if>>포도 캠벨얼리(시설)</option>
								<option value="23" <c:if test="${param.searchTxt2 == '23'}">selected</c:if>>호박고구마</option>
								<option value="24" <c:if test="${param.searchTxt2 == '24'}">selected</c:if>>밤고구마</option>          
							</select>
							</fieldset>
								  <input type="hidden" name="searchTxt2" id="searchTxt2" value="${param.searchTxt2}">
						</dd>  -->
					</dl>
					<dl>
						<dt><label for="searchKey3">산출구분</label></dt>
						<dd>
							<fieldset>
								<select name="searchKey3" id="searchKey3" class="select_style" title="산출구분 옵션" onChange="getSelectValue(this.form);">
									<option value="" selected>전체</option>
									<option value="1" <c:if test="${param.searchTxt3 == '1'}">selected</c:if>>기준가격</option>
									<option value="2" <c:if test="${param.searchTxt3 == '2'}">selected</c:if>>수확기가격</option>                            
								</select>
							</fieldset>
							<input type="hidden" name="searchTxt3" id="searchTxt3" value="${param.searchTxt3}">
						</dd>
					</dl>
					<button type="button" class="btn_search" title="검색하기" onclick="search();">검색</button>
				</div>
			</div>
			<div class="btn_area fl_right">		<!-- 2022.09.22 김동민 대리 추가 -->
				<a href="#none" id="excelFileExport" class="btn_down" title="엑셀 다운로드">엑셀 다운로드</a>
			</div>
		</div>
 	</form>
	<!--//기준가격공시 검색-->
	<!--기준가격공시 검색 후 출력화면-->
	<div class="table_area table_wrap scroll">
		<table id="table_style" class="table_style">
			<caption>기준가격공시 정보표로 기준년도,품목,산출구분에 따라 공시일자,공시품목,공시단위,산출가격구분,공시금액(원) 정보를 제공함</caption>
			<colgroup>
				<col width="15%" />
				<col />
				<col span="3" width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">공시일자</th>
					<th scope="col">공시품목</th>
					<th scope="col">공시단위</th>
					<th scope="col">산출가격구분</th>
					<th scope="col">공시금액(원)</th>
				</tr>
			</thead>
			<tbody>
				<!--tr>
					<td>2021-11-22</td>
					<td class="txt_left">밤고구마</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">1,407</td>
				</tr>
				<tr>
					<td>2021-11-22</td>
					<td class="txt_left">호박고구마</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">1,834</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">샤인머스켓(노지)</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">8,036</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">샤인머스켓(노지)</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">8,303</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">샤인머스켓(시설)</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">11,218</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">샤인머스켓(시설)</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">10,295</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">델라웨어</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">8,172</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">델라웨어</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">5,647</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">MBA</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">2,123</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">MBA</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">2,204</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">거봉(노지)</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">6,247</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">거봉(노지)</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">4,316</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">거봉(시설)</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">9,825</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">거봉(시설)</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">6,772</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">캠벨(노지)</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">3,254</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">캠벨(노지)</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">2,355</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">캠벨(시설)</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">2,791</td>
				</tr>
				<tr>
					<td>2021-11-03</td>
					<td class="txt_left">캠벨(시설)</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">3,282</td>
				</tr>
				<tr>
					<td>2021-09-07</td>
					<td class="txt_left">마늘(난지형 대서종)</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">4,396</td>
				</tr>
				<tr>
					<td>2021-09-07</td>
					<td class="txt_left">마늘(난지형 대서종)</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">3,331</td>
				</tr>
				<tr>
					<td>2021-09-07</td>
					<td class="txt_left">마늘(한지형)</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">6,335</td>
				</tr>
				<tr>
					<td>2021-09-07</td>
					<td class="txt_left">마늘(한지형)</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">5,380</td>
				</tr>
				<tr>
					<td>2021-08-18</td>
					<td class="txt_left">마늘(난지형 남도종)</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">3,364</td>
				</tr>
				<tr>
					<td>2021-08-18</td>
					<td class="txt_left">마늘(난지형 남도종)</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">2,822</td>
				</tr>
				<tr>
					<td>2021-07-29</td>
					<td class="txt_left">양파(중·만생종)</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">482</td>
				</tr>
				<tr>
					<td>2021-07-29</td>
					<td class="txt_left">양파(중·만생종)</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">477</td>
				</tr>
				<tr>
					<td>2021-07-29</td>
					<td class="txt_left">양파(조생종)</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">664</td>
				</tr>
				<tr>
					<td>2021-07-29</td>
					<td class="txt_left">양파(조생종)</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">653</td>
				</tr>
				<tr>
					<td>2021-05-28</td>
					<td class="txt_left">양배추</td>
					<td>1 키로</td>
					<td>수확기가격</td>
					<td class="txt_right">284</td>
				</tr>
				<tr>
					<td>2021-05-28</td>
					<td class="txt_left">양배추</td>
					<td>1 키로</td>
					<td>기준가격</td>
					<td class="txt_right">201</td>
				</tr -->
				<c:forEach var="dis" items="${dis}" varStatus="loop">
				<tr>
					<td>${dis.disDt}</td>
					<td class="txt_cen">${dis.disItemNm}</td>
					<td>${dis.disUnit}</td>
					<c:if test="${dis.cropItemCalcGbnCd == '1'}">
					<td>기준가격</td>
					</c:if>
					<c:if test="${dis.cropItemCalcGbnCd == '2'}">
					<td>수확기가격</td>
					</c:if>
					<td class="txt_right">${dis.disPrice}</td>
				</tr>
				</c:forEach>
				<c:if test="${empty dis }">
				<tr>
					<td colspan="5" class="">조회된 결과가 없습니다.</td>
				</tr>
				</c:if>
			</tbody>			
		</table>
	</div>
                    
                    
	<!-- SheetJS CDN -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>		<!-- 2022.09.22 김동민 대리 추가 -->
	<!-- FileSaver saveAs CDN -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

	<script>		<!-- 2022.09.22 김동민 대리 추가 -->
	function s2ab(s) { 
		var buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
		var view = new Uint8Array(buf);  //create uint8array as viewer
		for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; //convert to octet
		return buf;    
	}
	function exportExcel(){ 
		// step 1. workbook 생성
		var wb = XLSX.utils.book_new();

		// step 2. 시트 만들기 
		var newWorksheet = excelHandler.getWorksheet();
		
		// step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.  
		XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());

		// step 4. 엑셀 파일 만들기 
		var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});

		// step 5. 엑셀 파일 내보내기 
		saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName());
	}
	$(document).ready(function() { 
		$("#excelFileExport").click(function(){
			exportExcel();
		});
	});
	</script>
	<script>
	var excelHandler = {
			getExcelFileName : function(){
				return '기준가격공시.xlsx';
			},
			getSheetName : function(){
				return 'Table Test Sheet';
			},
			getExcelData : function(){
				return document.getElementById('table_style'); //테이블 아이디 
			},
			getWorksheet : function(){
				return XLSX.utils.table_to_sheet(this.getExcelData());
			}
	}
	</script>