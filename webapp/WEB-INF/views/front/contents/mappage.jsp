<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="/css/map/style.css">
<style>
.background {
    fill: #fff;
    pointer-events: all;
}
#states path {
    fill: #ccece6;
    stroke: #fff;
    stroke-width: 1.5px;
}
</style>
<script src="/js/map/d3.js"></script>
<script>


    $(function() {

		var date = new Date();
		var toYear = date.getFullYear();

		var strHtml = "";

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
			url: "/front/contents/mapTypeCodeList.do",
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
   			url: "/front/contents/getSearchMapData.do",
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
			url: "/front/contents/mapTypeCodeList.do",
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

    function area(key){
    	insu[key]['비율'] = "";
		insu[key]['위험보험료'] = "";
		insu[key]['가입금액'] = "";
		insu[key]['지급금액'] = "";
		insu[key]['보험금지급건수'] = "";
		insu[key]['인원'] = "";
    }

    </script>


		<div class="content_tit" id="containerContent">
           <h3>재해보험 지도</h3>
       	</div>
		<div class="sub_contents" >

			<!--content-->
                <div class="content">

                    <!--cont_search_area-->
                    <div class="cont_search_area">
                    	<div class="cont_search_box2">
                        	<dl>
                            	<dt><label for="" >대분류</label></dt>
                                <dd>
                                    <select id="대분류" name="대분류" title="대분류" class="in_wp160" onchange="changeTypeFunction()">
			                            	<option value="80410">농작물</option>
											<option value="80420">가축</option>
										</select>
                                </dd>
                                <dt><label for="" >기준년월</label></dt>
                                <dd>
                                    <select id="기준년" name="기준년" title="기준년">
                                        <option value="" selected>2017년</option>
                                        <option value="">2016년</option>
                                    </select>
                                    <select id="기준월" name="기준월" title="기준월">
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
                                </dd>
                            </dl>
                            <dl>
                            	<dt><label for="" >기준지표</label></dt>
                                <dd>
                                    <select id="구분" name="구분" title="구분" class="in_wp160">
                                        <option value="위험보험료">위험보험료</option>
										<option value="가입금액">가입금액</option>
										<option value="지급금액">지급금액</option>
										<option value="보험금지급건수">보험금지급건수</option>
                                    </select>
                                </dd>
                                <dt><label for="" >품목/축종</label></dt>
                                <dd>
                                    <select id="품목" name="품목" title="품목/축종" >
                                    </select>
                                    <button class="btn_search" title="조회"  onclick="searchMapData()">
                                        조회
                                    </button>
                                </dd>
                            </dl>
                        </div>
                    </div>

                    <div id="maparea" class="container" style="overflow:hidden;"></div>

  					<script src="/js/map/script.js"></script>

                    </div>
                    <!--//map_area-->

                </div>
                <!--//content-->


		</div>
