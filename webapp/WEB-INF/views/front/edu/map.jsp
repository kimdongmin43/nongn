<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<script src="${ScriptPath}/imgLiquid.js"></script>



<!-- <link rel="stylesheet" type="text/css" href="/css/masterpage/style.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/css/masterpage/jquery-ui.css"> -->

<!-- 	<link rel="stylesheet" type="text/css" href="/css/adins_web/style.css"> -->
    <link rel="stylesheet" type="text/css" href="/css/map/style.css">

<!-- <link rel="stylesheet" type="text/css" href="/css/masterpage/style.css">   2016.06.24 수정 footer 충돌로 인한 주석 -->
	<link rel="stylesheet" type="text/css" href="/css/masterpage/jquery-ui.css">

    <link href="/css/map/plugin.css" rel="stylesheet" type="text/css" />
 	<style>
 	#map {overfolw:hidden;}
 	</style>

	<script src="/scripts/GenCms/map/js/jquery.cookie.js"></script>
    <script src="/scripts/GenCms/map/js/d3.js"></script>
    <script>

    // 2016.05.10 지도 색상 변경에 따른 수정 start

// 	function colorChangeFunction(obj){
// 		target.value = obj;
// 		target.style.backgroundColor = obj;

// 		if(target.id == "maxColor"){
// 			$.cookie("maxColor", obj);
// 		}
// 		else{
// 			$.cookie("minColor", obj);
// 		}

// 		searchMapData();
// 	}
	// 2016.05.10 지도 색상 변경에 따른 수정 end

    $(function() {
// 		if($.cookie("maxColor") == null){
// 			$("#maxColor").val("rgb(255,0,0)");
// 			$("#maxColor")[0].style.backgroundColor = "rgb(255,0,0)";
// 		}
// 		else{
// 			$("#maxColor").val($.cookie("maxColor"));
// 			$("#maxColor")[0].style.backgroundColor = $.cookie("maxColor");
// 		}

// 		if($.cookie("minColor") == null){
// 			$("#minColor").val("rgb(255,232,232)");
// 			$("#minColor")[0].style.backgroundColor = "rgb(255,232,232)";
// 		}
// 		else{
// 			$("#minColor").val($.cookie("minColor"));
// 			$("#minColor")[0].style.backgroundColor = $.cookie("minColor");
// 		}

		var date = new Date();
		var toYear = date.getFullYear();

		var strHtml = "";
// 		<option value="0">미소유</option>

		for(var i=0; i<10; i++){
			if(parseInt(toYear)-i > 2015){
				strHtml += "<option value='" + (parseInt(toYear)-i)  + "'>" + (parseInt(toYear)-i) + "년</option>";
			}
		}
    	$("#기준년")[0].innerHTML = strHtml;
		$("#기준년").val(toYear);

		var mmSel = date.getMonth() - 1;
		if(mmSel < 0){
			mmSel = 11;
		}
		$("#기준월").val($("#기준월 option:eq(" + mmSel + ")").val());

		var param = {
				"codeType" : $("#대분류").val()
			};

		$.ajax({
			url: "/GenCMS/gencms/mapTypeCodeList.do",
			data : JSON.stringify(param),
			type: "POST",
			cache:false,
			timeout : 30000,
			contentType: "application/json; charset=UTF-8",
			dataType:"json",
			success: function(obj){
				codeList = obj.list;
				if(obj.list == null || obj.list.length == 0){
					$("#품목")[0].innerHTML = "";
				}
				else{
					var bodyStr = "<option value=''>전체</option>";
					for(var i=0; i<obj.list.length; i++){
						bodyStr += "<option value='"+ obj.list[i]['code'] +"'>" + obj.list[i]['value'] + "</option>";
					}
					$("#품목")[0].innerHTML = bodyStr;
				}

			},
			failure: function(obj){
				alert("fail");
			},
			scope: this
		});

		searchMapData();
    });


    function searchMapData(){
		var pdCode = "";
		if($("#대분류").val() == '80410'){
			pdCode = $("#품목").val();
		}
		else{
			for(var i=0; i<codeList.length; i++){
				if($("#품목").val() == codeList[i].code){
					pdCode = codeList[i].value;
					break;
				}
			}
		}

    	var param = {
// 			type : $("#대분류").val(),
       		gijunDt : $("#기준년").val()+$("#기준월").val(),
       		pCode : pdCode
   		};

   		$.ajax({
   			url: "/GenCMS/gencms/getSearchMapData.do",
   			data : JSON.stringify(param),
   			type: "POST",
   			cache:false,
   			timeout : 30000,
   			contentType: "application/json; charset=UTF-8",
   			dataType:"json",
   			success: function(obj){
				if(obj.list == null || obj.list.length == 0){

					for(var key in insu){
						insu[key]['비율'] = "";
						insu[key]['위험보험료'] = "";
						insu[key]['가입금액'] = "";
						insu[key]['지급금액'] = "";
						insu[key]['보험금지급건수'] = "";
						insu[key]['인원'] = "";
					}


					$("#maparea")[0].innerHTML = "";
					searchMap();
   				}
   				else{
   					for(var key in insu){
						insu[key]['비율'] = "";
						insu[key]['위험보험료'] = "";
						insu[key]['가입금액'] = "";
						insu[key]['지급금액'] = "";
						insu[key]['보험금지급건수'] = "";
						insu[key]['인원'] = "";
					}

   					for(var key in insu){

						for(var i=0; i<obj.list.length; i++){
							if(key == obj.list[i]['시도시군구']){
								var gubun = "";
								if(obj.list[i]['시도시군구'].length == 2){
									gubun = "sido";
								}
								else{
									gubun = "sigungu";
								}

								insu[key]['비율'] = parseFloat(obj.list[i][$("#구분").val()]) / parseFloat(obj[gubun+"Max"+$("#구분").val()]);
								insu[key]['위험보험료'] = commify(obj.list[i]['위험보험료']) + " 원";
								insu[key]['가입금액'] = commify(obj.list[i]['가입금액']) + " 원";
								insu[key]['지급금액'] = commify(obj.list[i]['지급금액']) + " 원";
								insu[key]['보험금지급건수'] = commify(obj.list[i]['보험금지급건수']) + " 건";
								insu[key]['인원'] = commify(obj.list[i]['인원']) + " 명";
								break;
							}
						}
       				}
   				}

				$("#maparea")[0].innerHTML = "";
				searchMap();
   			},
   			failure: function(obj){
   				alert("fail");
   			},
   			scope: this
   		});

    }

    function commify(n) {
        var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
        n += '';                                       // 숫자를 문자열로 변환

        while (reg.test(n))
            n = n.replace(reg, '$1' + ',' + '$2');
        return n;
    }

	var codeList;
    function changeTypeFunction(){
    	codeList = [];
    	var param = {
				"codeType" : $("#대분류").val()
			};

		$.ajax({
			url: "/GenCMS/gencms/mapTypeCodeList.do",
			data : JSON.stringify(param),
			type: "POST",
			cache:false,
			timeout : 30000,
			contentType: "application/json; charset=UTF-8",
			dataType:"json",
			success: function(obj){
				codeList = obj.list;

				if(obj.list == null || obj.list.length == 0){
					$("#품목")[0].innerHTML = "";
				}
				else{
					var bodyStr = "<option value=''>전체</option>";
					for(var i=0; i<obj.list.length; i++){
						bodyStr += "<option value='"+ obj.list[i]['code'] +"''>" + obj.list[i]['value'] + "</option>";
					}
					$("#품목")[0].innerHTML = bodyStr;
				}

			},
			failure: function(obj){
				alert("fail");
			},
			scope: this
		});
    }

// 	var target;
//     function popFunction(obj){
//     	target = obj;
//     	window.open("/GenCMS/gencms/colorPopup.do", "colorPopup", "width=165, height=250, status=0, location=0");
// 	}
    </script>
	<article class="item">
			<fieldset>
				<legend>재해보험 지도</legend>
				<h5 class="title"><span>재해보험 지도</span></h5>
				<div class="cont pd">

					<%-- 일반형 게시판 --%>
				    <div class="board_ty mb_ty01">
			             <table>
			                 <caption>재해보험 지도</caption>
			                 <colgroup>
			                     <col span="1" style="width:20%;">
			                     <col span="1" style="width:30%;">
			                     <col span="1" style="width:20%;">
			                     <col span="1" style="width:30%;">
			                 </colgroup>
			                 <tbody>
			                 	<tr>
			                         <th scope="row"><label>대분류</label></th>
			                         <td class="left">
			                            <select id="대분류" name="대분류" title="대분류" style="width:95%;" onchange="changeTypeFunction()">
			                            	<option value="80410">농작물</option>
											<option value="80420">가축</option>
										</select>
			                         </td>
			                         <th scope="row"><label>기준년월</label></th>
			                         <td class="left">
			                             <select id="기준년" name="기준년" title="기준년" style="width:46%;">
										</select>
										<select id="기준월" name="기준월" title="기준월" style="width:46%;">
											<option value="01">1월</option>
											<option value="02">2월</option>
											<option value="03">3월</option>
											<option value="04">4월</option>
											<option value="05">5월</option>
											<option value="06">6월</option>
											<option value="07">7월</option>
											<option value="08">8월</option>
											<option value="09">9월</option>
											<option value="10">10월</option>
											<option value="11">11월</option>
											<option value="12">12월</option>
										</select>
			                         </td>
			                     </tr>
			                     <tr>
			                         <th scope="row"><label>기준지표</label></th>
			                         <td class="left">
			                            <select id="구분" name="구분" title="구분" style="width:95%;">
											<option value="위험보험료">위험보험료</option>
											<option value="가입금액">가입금액</option>
											<option value="지급금액">지급금액</option>
											<option value="보험금지급건수">보험금지급건수</option>
										</select>
			                         </td>
			                         <th scope="row"><label>품목/축종</label></th>
			                         <td class="left">
			                             <select id="품목" name="품목" title="품목/축종" style="width:95%;">
										</select>
			                         </td>
			                     </tr>
<!-- 			                     <tr> -->
<!-- 			                         <th scope="row"><label>Max Color</label></th> -->
<!-- 			                         <td class="left" > -->
<!-- 										<input id="maxColor" name="maxColor" type="button" style="background-color: rgb(255,0,0)" value="rgb(255,0,0)" onclick="popFunction(this)"> -->
<!-- 			                         </td> -->
<!-- 			                         <th scope="row"><label>Min Color</label></th> -->
<!-- 			                         <td class="left"> -->
<!-- 										<input id="minColor" name="minColor" type="button" style="background-color: rgb(255,232,232)" value="rgb(255,232,232)" onclick="popFunction(this)"> -->
<!-- 			                         </td> -->
<!-- 			                     </tr> -->
			                 </tbody>
			             </table>
			         </div>
			         <!-- //board_ty -->
				    <%-- //일반형 게시판 --%>

				    <!-- btn_area -->
				    <!-- 2016.05.09 버튼 height 조정 -->
					<ul class="btn_area" style="height: 27px">
						<li class="right">
							<a href="#none" class="btn_s btn_ty02" onclick="searchMapData()"><span class="ico_search">조회</span></a>
						</li>
					</ul>
					<!-- //btn_area -->
				</div>
			</fieldset>
		</article>

	<div id="maparea" class="container"></div>

    <script src="/scripts/GenCms/map/js/script.js"></script>
