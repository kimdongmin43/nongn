<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import = "java.util.Map"%>
<%@ page import = "java.util.List"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<script src="${ScriptPath}/imgLiquid.js"></script>

<link rel="stylesheet" type="text/css" href="/css/adins_web/style.css">

<!-- <link rel="stylesheet" type="text/css" href="/css/masterpage/style.css">   2016.06.24 수정 footer 충돌로 인한 주석 -->
<link rel="stylesheet" type="text/css" href="/css/masterpage/jquery-ui.css">

<script>

	function searchBBS() {
		var param = {
				 	// 2016.10.05 보험1부 성혜수 요청 농작물공시 년도별 조회로 변경
					//"I_FROM_DT" : $("#select_date_1").val(),
					//"I_TO_DT" : $("#select_date_2").val(),
					"I_YEAR" : $("#select_year").val(),
					
					"I_CODE" : $("#search_code").val(),
					"I_TYPE" : $("#search_type").val()
				};
		
		$.ajax({
			url: "/GenCMS/gencms/cropListData.do",
			data : JSON.stringify(param),
			type: "POST",
			cache:false,
			timeout : 30000, 
			contentType: "application/json; charset=UTF-8",
			dataType:"json", 
			success: function(obj){
				var mapList = obj.list;

				if(mapList == null || mapList.length == 0){
					$("#listBody")[0].innerHTML = "<tr><td class='emp' colspan='8'>등록된 글이 없습니다.</td></tr>";
				}
				else{
					var bodyStr = "";
					for(var i=0; i<mapList.length; i++){
						bodyStr += "<tr>";
						bodyStr += "<td align='center'>" + mapList[i]["농작물가격공시일자"] + "</td>";
						bodyStr += "<td align='left'>" + mapList[i]["농작물품목코드명"] + "</td>";
						bodyStr += "<td align='left'>" + mapList[i]["농작물공시단위"] + "</td>";
						bodyStr += "<td align='left'>" + mapList[i]["농작물산출가격구분"] + "</td>";
						bodyStr += "<td  align='right'>" + mapList[i]["농작물공시산출가격"] + "</td>";
						bodyStr += "</tr>";
					}
					$("#listBody")[0].innerHTML = bodyStr;
				}
				
			},
			failure: function(obj){
				alert("fail");
			},
			scope: this
		});
	}

	function bindComboData(){
		var param = {}; 
		
		$.ajax({
			url: "/GenCMS/gencms/getSearchTypeGubun.do",
			data : JSON.stringify(param),
			type: "POST",
			cache:false,
			timeout : 30000, 
			contentType: "application/json; charset=UTF-8",
			dataType:"json", 
			success: function(obj){

				if(obj.list == null || obj.list.length == 0){
					$("#search_type")[0].innerHTML = "";
				}
				else{
					var bodyStr = "<option value=''>전체</option>";
					for(var i=0; i<obj.list.length; i++){
						bodyStr += "<option value='"+ obj.list[i]['code'] +"''>" + obj.list[i]['value'] + "</option>";
					}
					$("#search_type")[0].innerHTML = bodyStr;
				}
			},
			failure: function(obj){
				alert("fail");
			},
			scope: this
		});
	}

	
	$(function() {
		// 2016.10.05 보험1부 성혜수 요청 농작물공시 년도별 조회로 변경 ----------------------------------------
		/*
		$(".select_date").datepicker({
			showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
			buttonImage: "/images/masterpage/template/ico_calendar.gif", // 버튼 이미지
			buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
			dateFormat: 'yy-mm-dd',
			prevText: '이전 달',
			nextText: '다음 달',
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNames: ['일','월','화','수','목','금','토'],
			dayNamesShort: ['일','월','화','수','목','금','토'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			showMonthAfterYear: true,
			yearSuffix: '년',
			buttonText: "달력보기"
		});

		var dateFrom = new Date();
		var yyFrom = dateFrom.getFullYear();
		var mmFrom = getDateFunction(dateFrom.getMonth()+1);
		var ddFrom = getDateFunction(dateFrom.getDate());
		
		$("#select_date_2").val(yyFrom + "-" + mmFrom + "-" + ddFrom);
		$("#select_date_1").val(yyFrom-1 + "-" + mmFrom + "-" + ddFrom);
		*/

		var param = {}; 
		
		$.ajax({
			url: "/GenCMS/gencms/getSearchCodeYear.do",
			data : JSON.stringify(param),
			type: "POST",
			cache:false,
			timeout : 30000, 
			contentType: "application/json; charset=UTF-8",
			dataType:"json", 
			success: function(obj){

				if(obj.list == null || obj.list.length == 0){
					$("#search_year")[0].innerHTML = "";
				}
				else{
					var bodyStr = "";
					for(var i=0; i<obj.list.length; i++){
						bodyStr += "<option value='"+ obj.list[i]['code'] +"''>" + obj.list[i]['value'] + "</option>";
					}
					$("#search_year")[0].innerHTML = bodyStr;
				}
			},
			failure: function(obj){
				alert("fail");
			},
			scope: this
		});
		// ---------------------------------------------------------------------------------
		
		
		bindComboData();
	});

	function getDateFunction(value){
		if(String(value).length == 1){
			return "0" + String(value);
		}
		else{
			return value;
		}
	} 
</script>
            	<!-- cont_area -->
	<div class="cont_area">
		<article class="item">
			<fieldset>
				<legend>농작물 공시가격 정보</legend>
				<h5 class="title"><span>농작물 공시가격 정보</span></h5>
				<div class="cont pd">
					
					<%-- 일반형 게시판 --%>
				    <div class="board_ty mb_ty01">
			             <table>
			                 <caption>손해평가사 정보</caption>
			                 <colgroup>
			                     <col span="1" style="width:20%;">
			                     <col span="1" style="width:30%;">
			                     <col span="1" style="width:20%;">
			                     <col span="1" style="width:30%;">
			                 </colgroup>
			                 <tbody>
			                 <!-- 2016.10.05 보험1부 성혜수 요청 농작물공시 년도별 조회로 변경 
			                     <tr>
			                         <th scope="row"><label>공시기간</label></th>
			                         <td class="left" colspan="3">
			                             <input type="text" class="input_ty select_date" name="board_source_dt" id="select_date_1" value="${StartDT}" title="날짜를 선택하세요." style="width:35%;" readonly>
			                             ~
			                             <input type="text" class="input_ty select_date" name="board_source_dt" id="select_date_2" value="${StartDT}" title="날짜를 선택하세요." style="width:35%;" readonly>
			                         </td>
			                     </tr>
			                  -->
			                     <tr>
			                         <th scope="row"><label>공시년도</label></th>
			                         <td class="left" >
			                            <select title="검색" id="search_year" style="width:98%;"></select>
			                         </td>
			                     </tr>
			                     <tr>
			                         <th scope="row"><label>품목</label></th>
			                         <td class="left">
			                             <select title="검색" id="search_code" style="width:98%;">
						                	<c:forEach items="${cropList}" var="item" varStatus="status">
												<option value="${item.code}">${item.value}</option>
						   					</c:forEach>
						                </select>
			                         </td>
			                         <th scope="row"><label>산출구분</label></th>
			                         <td class="left">
			                             <select title="검색" id="search_type" style="width:98%;"></select>
			                         </td>
			                     </tr>
			                 </tbody>
			             </table>
			         </div>
			         <!-- //board_ty -->        
				    <%-- //일반형 게시판 --%>
				    
				    <!-- btn_area -->
				    <!-- 2016.05.09 버튼 height 조정 -->
					<ul class="btn_area" style="height: 27px">
						<li class="right">
							<a href="javascript:searchBBS();" class="btn_s btn_ty02"><span class="ico_search">조회</span></a>
						</li>
					</ul>
					<!-- //btn_area -->
				</div>
			</fieldset>
		</article>
	    
		<!-- board_header -->
        <div class="board_header">
        <!-- board_info -->
        <div>
<!--         	<ul class="board_info"> -->
<%--                 <li class="num">Total : <span>${BBSCount}</span></li> --%>
<%--                 <li class="num">Page : <span>${BBSSRC.pageNo} / <fmt:parseNumber value="${BBSCount div 13 + 1}" integerOnly="true"/></span></li>	 --%>
<!--             </ul> -->
        </div>
        <!-- //board_info -->
        
        </div>
        <!-- //board_header -->
            		
        <%-- 일반형 게시판 --%>
	            <!-- board_ty -->
                <div class="board_ty">
                	<table>
	                    <caption>게시판 리스트</caption>
	                    <colgroup>
			          		<col span="1" style="width:20%;">
                            <col span="1" style="width:20%;">
                            <col span="1" style="width:20%;">
                            <col span="1" style="width:20%;">
                            <col span="1" style="width:20%;">
	                    </colgroup>
	                    <thead>
	                        <tr>
				          		<th scope="col">공시일자</th>
				          		<th scope="col">공시품목</th>
			                    <th scope="col">공시단위</th>
			                    <th scope="col">산출가격구분</th>
			                    <th scope="col">공시금액</th>
	                        </tr>
	                    </thead>
						<tbody id="listBody">
          				<c:forEach items="${BBSList}" var="item" varStatus="status">
          					<tr>
          						<td>${item.COL1}</td>
          						<td>${item.COL2}</td>
          						<td>${item.COL3}</td>
          						<td>${item.COL4}</td>
          						<td>${item.COL5}</td>
	                   		</tr>
    					</c:forEach>
		   				<c:if test="${empty BBSList}">
			          		<tr><td class="emp" colspan="5">등록된 글이 없습니다.</td></tr>
		                </c:if>
						</tbody>
					</table>
						
				</div>                               
	            <!-- //board_ty -->
	            	
	            <%-- //일반형 게시판 --%>
					            	
			</div>
	        <!-- //cont_area -->
	
