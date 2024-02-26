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

<link rel="shortcut icon" href="/images/adins_web/layout/favicon.ico" type="image/x-icon">
<link rel="apple-touch-icon" href="/images/adins_web/layout/apple-touch-icon.png"> 
<link rel="stylesheet" type="text/css" href="/css/adins_web/style.css">

<!-- <link rel="stylesheet" type="text/css" href="/css/masterpage/style.css">  2016.06.24 수정 footer 충돌로 인한 주석 -->
<link rel="stylesheet" type="text/css" href="/css/masterpage/jquery-ui.css">

<script>
	var eduCdList;
	var eduList;
	var licenseNo = ${LIC_NO};

	function searchHistotyFunction(){
		var param = {
				"licenseNo" : licenseNo
			};
		
		$.ajax({
			url: "/GenCMS/gencms/searchHistoryEdu.do",
			data : JSON.stringify(param),
			type: "POST",
			cache:false,
			timeout : 30000, 
			contentType: "application/json; charset=UTF-8",
			dataType:"json", 
			success: function(obj){
				var mapList = obj.list;
	
				if(mapList == null || mapList.length == 0){
					$("#교육목록")[0].innerHTML = "<tr><td class='emp' colspan='7'>등록된 글이 없습니다.</td></tr>";
				}
				else{
					var bodyStr = "";
					for(var i=0; i<mapList.length; i++){
						bodyStr += "<tr>";
						bodyStr += "<td align='center'>" + mapList[i]["손해평가사교육구분"] + "</td>";
						bodyStr += "<td align='center'>" + mapList[i]["손해평가사교육연도"] + "</td>";
						bodyStr += "<td align='right'>" + mapList[i]["손해평가사교육회차"] + "</td>";
						bodyStr += "<td align='left'>" + mapList[i]["손해평가사교육명"] + "</td>";
						bodyStr += "<td  align='center'>" + mapList[i]["손해평가사교육시작일자"] + " ~ " + mapList[i]["손해평가사교육종료일자"] + "</td>";
						bodyStr += "<td  align='center'>" + mapList[i]["손해평가사교육이수상태"] + "</td>";
	// 					bodyStr += "<td  align='center'>" + mapList[i]["손해평가사교육이수일자"] + "</td>";
						bodyStr += "</tr>";
					}
					$("#교육목록")[0].innerHTML = bodyStr;
				}
				
			},
			failure: function(obj){
				alert("fail");
			},
			scope: this
		});
	}

	function searchEduFunction(){
		eduList = null;
		var param = {
				"licenseNo" : licenseNo
			};
		
		$.ajax({
			url: "/GenCMS/gencms/searchEdu.do",
			data : JSON.stringify(param),
			type: "POST",
			cache:false,
			timeout : 30000, 
			contentType: "application/json; charset=UTF-8",
			dataType:"json", 
			success: function(obj){
				var mapList = obj.list;
	
				if(mapList == null || mapList.length == 0){
					$("#교육예정목록")[0].innerHTML = "<tr><td class='emp' colspan='7'>등록된 글이 없습니다.</td></tr>";
				}
				else{
					eduList = mapList;
					var bodyStr = "";
					for(var i=0; i<mapList.length; i++){
						bodyStr += "<tr>";
						bodyStr += "<td align='center'>" + mapList[i]["손해평가사교육구분"] + "</td>";
						bodyStr += "<td align='center'>" + mapList[i]["손해평가사교육연도"] + "</td>";
						bodyStr += "<td align='right'>" + mapList[i]["손해평가사교육회차"] + "</td>";
						bodyStr += "<td align='left'>" + mapList[i]["손해평가사교육명"] + "</td>";
						bodyStr += "<td  align='center'>" + mapList[i]["손해평가사교육시작일자"] + " ~ " + mapList[i]["손해평가사교육종료일자"] + "</td>";
						bodyStr += "<td  align='center'><select style='width:98%;'>";

						for(var j=0; j<eduCdList.length; j++){
							if(mapList[i]['손해평가사교육참석여부코드'] == eduCdList[j]['code']){
								bodyStr += "<option value='"+ eduCdList[j]['code'] +"' selected>" + eduCdList[j]['value'] + "</option>";
							}
							else{
								bodyStr += "<option value='"+ eduCdList[j]['code'] +"'>" + eduCdList[j]['value'] + "</option>";
							}
						}

						bodyStr += "</select></td>";
						bodyStr += "</tr>";
					}
					$("#교육예정목록")[0].innerHTML = bodyStr;
				}
				
			},
			failure: function(obj){
				alert("fail");
			},
			scope: this
		});
	}

	function getCodeList(){
		$.ajax({
			url: "/GenCMS/gencms/getEduStatusCode.do",
			data : JSON.stringify({}),
			type: "POST",
			cache:false,
			timeout : 30000, 
			contentType: "application/json; charset=UTF-8",
			dataType:"json", 
			success: function(obj){

				if(obj.list == null || obj.list.length == 0){
					eduCdList = [];
				}
				else{
					eduCdList = obj.list;
				}

				searchHistotyFunction();
				searchEduFunction();
			},
			failure: function(obj){
				alert("fail");
			},
			scope: this
		});
	}

	function saveFunction(){
		if(eduList != null && eduList.length>0){
			for(var i=0; i<eduList.length; i++){
				eduList[i]['손해평가사교육참석여부코드'] = $("#교육예정목록 tr:eq("+i+") td:eq(5) select").val();
			}
		}
		
		var param = {
				"eduList" : eduList
			};
		
		$.ajax({
			url: "/GenCMS/gencms/updateEdu.do",
			data : JSON.stringify(param),
			type: "POST",
			cache:false,
			timeout : 30000, 
			contentType: "application/json; charset=UTF-8",
			dataType:"json", 
			success: function(obj){
				
				if(obj.result == null || obj.result == 1){
					alert("실패하였습니다.");
				}
				else{
					alert("저장되었습니다.");
					searchHistotyFunction();
					searchEduFunction();
				}
				
			},
			failure: function(obj){
				alert("fail");
			},
			scope: this
		});
	}
	
	$(function() {
		getCodeList();
	});

	

</script>
	<!-- cont_area -->
	<div class="cont_area">
	
		<article class="item">
			<fieldset>
				<legend>교육 현황</legend>
				<h5 class="title"><span>교육 현황</span></h5>
				<div class="cont pd">
					<%-- 일반형 게시판 --%>
			        <!-- board_ty -->
			           <div class="board_ty">
			           	<table>
			                <caption>교육 현황</caption>
			                <colgroup>
				        		<col span="1" style="width:10%;">
				        		<col span="1" style="width:10%;">
				        		<col span="1" style="width:10%;">
				        		<col span="1" style="width:30%;">
				        		<col span="1" style="width:30%;">
				        		<col span="1" style="width:10%;">
<%-- 				        		<col span="1" style="width:10%;"> --%>
			                </colgroup>
			                <thead>
			                    <tr>
				         			<th scope="col">구분</th>
				         			<th scope="col">년도</th>
				         			<th scope="col">회차</th>
				         			<th scope="col">교육명</th>
				         			<th scope="col">교육기간</th>
				         			<th scope="col">이수상태</th>
<!-- 				         			<th scope="col">이수일자</th> -->
			                    </tr>
			                </thead>
							<tbody id="교육목록">
								<tr><td class="emp" colspan="6">등록된 글이 없습니다.</td></tr>
							</tbody>
						</table>
					</div>                               
			         <!-- //board_ty -->
				    <%-- //일반형 게시판 --%>
				    
				</div>
			</fieldset>
		</article>
		
		<article class="item">
			<fieldset>
				<legend>교육 예정 현황</legend>
				<h5 class="title"><span>교육 예정 현황</span></h5>
				<div class="cont pd">
					<%-- 일반형 게시판 --%>
			        <!-- board_ty -->
			           <div class="board_ty">
			           	<table>
			                <caption>교육 예정 현황</caption>
			                <colgroup>
				        		<col span="1" style="width:10%;">
				        		<col span="1" style="width:10%;">
				        		<col span="1" style="width:10%;">
				        		<col span="1" style="width:30%;">
				        		<col span="1" style="width:25%;">
				        		<col span="1" style="width:15%;">
			                </colgroup>
			                <thead>
			                    <tr>
				         			<th scope="col">구분</th>
				         			<th scope="col">년도</th>
				         			<th scope="col">회차</th>
				         			<th scope="col">교육명</th>
				         			<th scope="col">교육기간</th>
				         			<th scope="col">참석여부</th>
			                    </tr>
			                </thead>
							<tbody id="교육예정목록">
								<tr><td class="emp" colspan="6">등록된 글이 없습니다.</td></tr>
							</tbody>
						</table>
					</div>                               
			         <!-- //board_ty -->
				    <%-- //일반형 게시판 --%>
				    
				</div>
			</fieldset>
		</article>
		
		<!-- btn_area -->
		<!-- 2016.05.09 버튼 height 조정 -->
		<ul class="btn_area" style="height: 27px">
			<li class="right">
				<a href="javascript:saveFunction();" class="btn_s btn_ty02" ><span class="ico_save">수정</span></a>
			</li>
		</ul>
		<!-- //btn_area -->
		
		
<!-- 		<article class="item"> -->
<!-- 			<fieldset> -->
<!-- 				<legend>손해평가사 정보</legend> -->
<!-- 				<h5 class="title"><span>손해평가사 정보</span></h5> -->
<!-- 				<div class="cont pd"> -->
				
<!-- 				</div> -->
<!-- 			</fieldset> -->
<!-- 		</article> -->
	    
					      
					            	
	</div>
    <!-- //cont_area -->
	
