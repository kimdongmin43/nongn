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

<!-- <link rel="stylesheet" type="text/css" href="/css/masterpage/style.css">   2016.06.24 수정 footer 충돌로 인한 주석 -->
<link rel="stylesheet" type="text/css" href="/css/masterpage/jquery-ui.css">

<script>
	var cropTypeList;
	var cropList;
	var regCityList;
	var regSigunguList;

	function searchRegister() {
		var param = {};
// 		if($("#휴대전화번호").val() == ""){
// 			param['phoneNumber'] = "010-5555-9999";
// 		}
// 		else{
// 			param['phoneNumber'] = $("#전화번호").val();
// 		}

		param['licenseNo'] = ${LIC_NO};

		$.ajax({
			url: "/GenCMS/gencms/getRegisterInfo.do",
			data : JSON.stringify(param),
			type: "POST",
			cache:false,
			timeout : 30000, 
			contentType: "application/json; charset=UTF-8",
			dataType:"json", 
			success: function(obj){
				if(obj.list != null && obj.list.length > 0){
					$("#자격증번호").val(obj.list[0]["자격증번호"]);
					$("#최종발행번호").val(obj.list[0]["손해평가사자격증발행번호"]);
					$("#시험년도").val(obj.list[0]["시험연도"]);
					$("#수험번호").val(obj.list[0]["수험번호"]);
					$("#성명").val(obj.list[0]["손해평가사성명"]);
					$("#생년월일").val(obj.list[0]["손해평가사생년월일"]);
					$("#합격연월일").val(obj.list[0]["자격증합격일자"]);
					$("#최종발급연월일").val(obj.list[0]["자격증발급일자"]);
					$("#휴대전화번호").val(obj.list[0]["손해평가사휴대전화번호"]);
					$("#일반전화번호").val(obj.list[0]["손해평가사일반전화번호"]);
					$("#차량소유여부").val(obj.list[0]["손해평가사차량소유여부"]);
					$("#SMS발송동의여부").val(obj.list[0]["손해평가사SMS발송동의여부"]);
					$("#우편번호").val(obj.list[0]["손해평가사우편번호"]);
					$("#도로명주소").val(obj.list[0]["손해평가사기본주소"]);
					$("#도로명상세주소").val(obj.list[0]["손해평가사상세주소"]);
				 	$("#지번주소").val(obj.list[0]["손해평가사지번기본주소"]);				// 2017.04.04 기존 : 도로명 주소만 입력. 개선 : 도로명, 지번 주소 둘다 입력
					$("#지번상세주소").val(obj.list[0]["손해평가사지번상세주소"]);			// 2017.04.04 기존 : 도로명 주소만 입력. 개선 : 도로명, 지번 주소 둘다 입력
					$("#손해평가사소속구분코드").val(obj.list[0]["손해평가사소속구분코드"]); // 2016.06 재해보험업무시스탬 개선내용 : 소속 컬럼 추가
				}

				$.ajax({
					url: "/GenCMS/gencms/getRegisterActiveTime.do",
					data : JSON.stringify({"자격증번호" : $("#자격증번호").val()}),
					type: "POST",
					cache:false,
					timeout : 30000, 
					contentType: "application/json; charset=UTF-8",
					dataType:"json", 
					success: function(obj){

						if(obj.list == null || obj.list.length == 0){
							var bodyStr = "";
							bodyStr += "<tr>";

							for(var j=0; j<12; j++){
								bodyStr += "<td>" + "<input type='checkbox'>" + "</td>";
							}
							bodyStr += "</tr>";
								
							$("#활동가능시기")[0].innerHTML = bodyStr;
						}
						else{
							var bodyStr = "";
							for(var i=0; i<obj.list.length; i++){
								bodyStr += "<tr>";

								for(var j=0; j<12; j++){
									if(obj.list[i]["활동가능" + (j+1) + "월여부"] == "1"){
										bodyStr += "<td>" + "<input type='checkbox' checked>" + "</td>";
									}
									else{
										bodyStr += "<td>" + "<input type='checkbox'>" + "</td>";
									}
								}
								bodyStr += "</tr>";
							}
							$("#활동가능시기")[0].innerHTML = bodyStr;
						}

					},
					failure: function(obj){
						alert("fail");
					},
					scope: this
				});

				$.ajax({
					url: "/GenCMS/gencms/getRegisterCropList.do",
					data : JSON.stringify({"자격증번호" : $("#자격증번호").val()}),
					type: "POST",
					cache:false,
					timeout : 30000, 
					contentType: "application/json; charset=UTF-8",
					dataType:"json", 
					success: function(obj){

						if(obj.list == null || obj.list.length == 0){
							$("#주력품목")[0].innerHTML = "<tr><td class='emp' colspan='8'>등록된 글이 없습니다.</td></tr>";
						}
						else{
							var bodyStr = "";
							for(var i=0; i<obj.list.length; i++){
								bodyStr += "<tr>";
								bodyStr += "<td><input type='checkbox'></td>";
								bodyStr += "<td><select style='width:98%;' onchange='changeCropTypeFunction(this)'>";

								var cropTypeStr = "";
								for(var j=0; j<cropTypeList.length; j++){
									if(obj.list[i]['구분품목코드'] == cropTypeList[j]['Cd']){
										bodyStr += "<option value='"+ cropTypeList[j]['Cd'] +"' selected>" + cropTypeList[j]['Cd_Nm'] + "</option>";
										cropTypeStr = cropTypeList[j]['Cd'];
									}
									else{
										bodyStr += "<option value='"+ cropTypeList[j]['Cd'] +"'>" + cropTypeList[j]['Cd_Nm'] + "</option>";
									}
								}
								bodyStr += "</select></td>";

								bodyStr += "<td><select style='width:98%;''>";
								bodyStr += "<option value='"+ cropTypeStr +"0000'>전체</option>";
								for(var j=0; j<cropList.length; j++){
									if(obj.list[i]['손해평가사활동품목코드'] == cropList[j]['Cd']){
										bodyStr += "<option value='"+ cropList[j]['Cd'] +"' selected>" + cropList[j]['Cd_Nm'] + "</option>";
									}
									else{
										bodyStr += "<option value='"+ cropList[j]['Cd'] +"'>" + cropList[j]['Cd_Nm'] + "</option>";
									}
								}
								bodyStr += "</select></td>";
								
								bodyStr += "</tr>";
							}
							$("#주력품목")[0].innerHTML = bodyStr;
						}

					},
					failure: function(obj){
						alert("fail");
					},
					scope: this
				});

				$.ajax({
					url: "/GenCMS/gencms/getRegisterRegList.do",
					data : JSON.stringify({"자격증번호" : $("#자격증번호").val()}),
					type: "POST",
					cache:false,
					timeout : 30000, 
					contentType: "application/json; charset=UTF-8",
					dataType:"json", 
					success: function(obj){

						if(obj.list == null || obj.list.length == 0){
							$("#활동지역")[0].innerHTML = "<tr><td class='emp' colspan='8'>등록된 글이 없습니다.</td></tr>";
						}
						else{
							var bodyStr = "";
							for(var i=0; i<obj.list.length; i++){
								bodyStr += "<tr>";
								bodyStr += "<td>" + "<input type='checkbox'>" + "</td>";

								bodyStr += "<td><select style='width:98%;' onchange='changeCityFunction(this)'>";

								var regCityStr = "";
								for(var j=0; j<regCityList.length; j++){
									if(obj.list[i]['시도코드'] == regCityList[j]['Cd']){
										bodyStr += "<option value='"+ regCityList[j]['Cd'] +"' selected>" + regCityList[j]['Cd_Nm'] + "</option>";
										regCityStr = regCityList[j]['Cd'];
									}
									else{
										bodyStr += "<option value='"+ regCityList[j]['Cd'] +"'>" + regCityList[j]['Cd_Nm'] + "</option>";
									}
								}
								bodyStr += "</select></td>";

								bodyStr += "<td><select style='width:98%;''>";
								bodyStr += "<option value='"+regCityStr+"000'>전체</option>";
								for(var j=0; j<regSigunguList.length; j++){
									if(obj.list[i]['시도코드'] == regSigunguList[j]['Cd_Tp']){
										if(obj.list[i]['시군구코드'] == regSigunguList[j]['Cd']){
											bodyStr += "<option value='"+ regSigunguList[j]['Cd'] +"' selected>" + regSigunguList[j]['Cd_Nm'] + "</option>";
										}
										else{
											bodyStr += "<option value='"+ regSigunguList[j]['Cd'] +"'>" + regSigunguList[j]['Cd_Nm'] + "</option>";
										}
									}
								}
								bodyStr += "</select></td>";

								bodyStr += "</tr>";
							}
							$("#활동지역")[0].innerHTML = bodyStr;
						}

					},
					failure: function(obj){
						alert("fail");
					},
					scope: this
				});
			},
			failure: function(obj){
				alert("fail");
			},
			scope: this
		});
	}

	function changeCheckFunction1(){
		for(var i=0; i<$("#주력품목 tr").length; i++){
			$("#주력품목 tr:eq("+i+") td:eq(0) input").attr("checked", $("#changeCheck_1")[0].checked);
		}
	}

	function changeCheckFunction2(){
		for(var i=0; i<$("#활동지역 tr").length; i++){
			$("#활동지역 tr:eq("+i+") td:eq(0) input").attr("checked", $("#changeCheck_2")[0].checked);
		}
	}

	function getCodeList(){
		// 2016.06 재해보험업무시스탬 개선내용 : 소속 콤보 박스 세팅
		$.ajax({
			url: "/GenCMS/gencms/mapTypeCodeList.do", 
			data : JSON.stringify({"codeType" : "80460" }), 
			type: "POST",
			cache:false,
			timeout : 30000, 
			contentType: "application/json; charset=UTF-8",
			dataType:"json", 
			success: function(obj){
				if(obj.list == null || obj.list.length == 0){
					$("#손해평가사소속구분코드")[0].innerHTML = "";
				}
				else{
					var bodyStr = "";
					for(var i=0; i<obj.list.length; i++){
						bodyStr += "<option value='"+ obj.list[i]['code'] +"''>" + obj.list[i]['value'] + "</option>";
					}
					$("#손해평가사소속구분코드")[0].innerHTML = bodyStr;
				}
			
				$.ajax({
					url: "/GenCMS/gencms/getCropAllCodeTypeList.do",
					data : JSON.stringify({}),
					type: "POST",
					cache:false,
					timeout : 30000, 
					contentType: "application/json; charset=UTF-8",
					dataType:"json", 
					success: function(obj){
		
						if(obj.list == null || obj.list.length == 0){
							cropTypeList = [];
						}
						else{
							cropTypeList = obj.list;
						}
		
						$.ajax({
							url: "/GenCMS/gencms/getCropAllCodeList.do",
							data : JSON.stringify({}),
							type: "POST",
							cache:false,
							timeout : 30000, 
							contentType: "application/json; charset=UTF-8",
							dataType:"json", 
							success: function(obj){
		
								if(obj.list == null || obj.list.length == 0){
									cropList = [];
								}
								else{
									cropList = obj.list;
								}
		
								$.ajax({
									url: "/GenCMS/gencms/getRegCityCdList.do",
									data : JSON.stringify({}),
									type: "POST",
									cache:false,
									timeout : 30000, 
									contentType: "application/json; charset=UTF-8",
									dataType:"json", 
									success: function(obj){
		
										if(obj.list == null || obj.list.length == 0){
											regCityList = [];
										}
										else{
											regCityList = obj.list;
										}
		
										$.ajax({
											url: "/GenCMS/gencms/getRegSigunguCdList.do",
											data : JSON.stringify({}),
											type: "POST",
											cache:false,
											timeout : 30000, 
											contentType: "application/json; charset=UTF-8",
											dataType:"json", 
											success: function(obj){
		
												if(obj.list == null || obj.list.length == 0){
													regSigunguList = [];
												}
												else{
													regSigunguList = obj.list;
												}
		
												searchRegister();
											},
											failure: function(obj){
												alert("fail");
											},
											scope: this
										});
										
									},
									failure: function(obj){
										alert("fail");
									},
									scope: this
								});
								
							},
							failure: function(obj){
								alert("fail");
							},
							scope: this
						});
		
						
					},
					failure: function(obj){
						alert("fail");
					},
					scope: this
				});
			
			},
			failure: function(obj){
				alert("fail");
			},
			scope: this
		});
		
	}

	function CropRowAdd(){
		var cropDataList = [];
		
		for(var i=0; i<$("#주력품목 tr").length; i++){
			cropDataList.push({
				cropType : $("#주력품목 tr:eq("+i+") td:eq(1) select").val(),
				cropItem : $("#주력품목 tr:eq("+i+") td:eq(2) select").val()
			});
		}
		
		var innerHtml = "";

		if($("#주력품목 tr").length == 1 && $("#주력품목 tr td").length == 1){
			innerHtml = "";
		}
		else{
			innerHtml = $("#주력품목")[0].innerHTML;
		}
		
		var bodyStr = "<tr>";
		bodyStr += "<td><input type='checkbox'></td>";
		bodyStr += "<td><select style='width:98%;' onchange='changeCropTypeFunction(this)'>";

		var selCropType = "";
		for(var j=0; j<cropTypeList.length; j++){
			if(j > 0){
				bodyStr += "<option value='"+ cropTypeList[j]['Cd'] +"'>" + cropTypeList[j]['Cd_Nm'] + "</option>";
			}
			else{
				bodyStr += "<option value='"+ cropTypeList[j]['Cd'] +"'>" + cropTypeList[j]['Cd_Nm'] + "</option>";
				selCropType = cropTypeList[j]['Cd'];
			}
		}
		bodyStr += "</select></td>";

		bodyStr += "<td><select style='width:98%;''>";
		bodyStr += "<option value='"+selCropType+"0000'>전체</option>";
		for(var j=0; j<cropList.length; j++){
			if(selCropType == cropList[j]['Cd_Tp']){
				bodyStr += "<option value='"+ cropList[j]['Cd'] +"'>" + cropList[j]['Cd_Nm'] + "</option>";
			}
		}
		bodyStr += "</select></td>";

		innerHtml += bodyStr + "</tr>";

		$("#주력품목")[0].innerHTML = innerHtml;

		for(var i=0; i<cropDataList.length; i++){
			$("#주력품목 tr:eq("+ i +") td:eq(1) select").val(cropDataList[i].cropType);
			$("#주력품목 tr:eq("+ i +") td:eq(2) select").val(cropDataList[i].cropItem);
		}
	}

	function CropRowDelete(){
		var chk = true;
		while(chk){
			var cnt = -1;
			for(var i=0; i<$("#주력품목 tr").length; i++){
				if($("#주력품목 tr:eq(" + i + ") td input")[0].checked == true){
					cnt = i;
					break;
				}
			}
			if(cnt > -1){
				$("#주력품목 tr:eq(" + cnt + ")").remove();
			}
			else{
				chk = false;
			}
		}
	}

	function RegRowAdd(){
		var regDataList = [];
		
		for(var i=0; i<$("#활동지역 tr").length; i++){
			regDataList.push({
				regType : $("#활동지역 tr:eq("+i+") td:eq(1) select").val(),
				regItem : $("#활동지역 tr:eq("+i+") td:eq(2) select").val()
			});
		}
		
		var innerHtml = "";

		if($("#활동지역 tr").length == 1 && $("#활동지역 tr td").length == 1){
			innerHtml = "";
		}
		else{
			innerHtml = $("#활동지역")[0].innerHTML;
		}

		var bodyStr = "<tr>";
		bodyStr += "<td>" + "<input type='checkbox'>" + "</td>";

		bodyStr += "<td><select style='width:98%;'' onchange='changeCityFunction(this)'>";

		var selCityCd = "";
		for(var j=0; j<regCityList.length; j++){
			if(j > 0){
				bodyStr += "<option value='"+ regCityList[j]['Cd'] +"'>" + regCityList[j]['Cd_Nm'] + "</option>";
			}
			else{
				bodyStr += "<option value='"+ regCityList[j]['Cd'] +"'>" + regCityList[j]['Cd_Nm'] + "</option>";
				selCityCd = regCityList[j]['Cd'];
			}
		}
		bodyStr += "</select></td>";

		bodyStr += "<td><select style='width:98%;''>";
		bodyStr += "<option value='"+selCityCd+"000'>전체</option>";
		
		for(var j=0; j<regSigunguList.length; j++){
			if(selCityCd == regSigunguList[j]['Cd_Tp']){
				bodyStr += "<option value='"+ regSigunguList[j]['Cd'] +"'>" + regSigunguList[j]['Cd_Nm'] + "</option>";
			}
		}
		bodyStr += "</select></td>";

		innerHtml += bodyStr + "</tr>";

		$("#활동지역")[0].innerHTML = innerHtml;

		for(var i=0; i<regDataList.length; i++){
			$("#활동지역 tr:eq("+ i +") td:eq(1) select").val(regDataList[i].regType);
			$("#활동지역 tr:eq("+i+") td:eq(2) select").val(regDataList[i].regItem);
		}
	}

	function RegRowDelete(){
		var chk = true;
		while(chk){
			var cnt = -1;
			for(var i=0; i<$("#활동지역 tr").length; i++){
				if($("#활동지역 tr:eq(" + i + ") td input")[0].checked == true){
					cnt = i;
					break;
				}
			}
			if(cnt > -1){
				$("#활동지역 tr:eq(" + cnt + ")").remove();
			}
			else{
				chk = false;
			}
		}
	}

	function changeCityFunction(obj){
		var selectedValue = obj.value;

		var bodyStr = "";
		bodyStr += "<select style='width:98%;''>";
		bodyStr += "<option value='"+selectedValue+"000' selected>전체</option>";

		for(var j=0; j<regSigunguList.length; j++){
			if(selectedValue == regSigunguList[j]['Cd_Tp']){
				bodyStr += "<option value='"+ regSigunguList[j]['Cd'] +"'>" + regSigunguList[j]['Cd_Nm'] + "</option>";
			}
		}
		bodyStr += "</select>";
		
		obj.parentNode.parentNode.children[2].innerHTML = bodyStr;
	}

	function changeCropTypeFunction(obj){
		var selectedValue = obj.value;

		var bodyStr = "";
		bodyStr += "<select style='width:98%;''>";
		bodyStr += "<option value='"+selectedValue+"0000' selected>전체</option>";

		for(var j=0; j<cropList.length; j++){
			if(selectedValue == cropList[j]['Cd_Tp']){
				bodyStr += "<option value='"+ cropList[j]['Cd'] +"'>" + cropList[j]['Cd_Nm'] + "</option>";
			}
		}
		bodyStr += "</select>";
		
		obj.parentNode.parentNode.children[2].innerHTML = bodyStr;
	}

	function saveFunction(){
		if(validation() == false){
			return;
		}
		
		var registerInfo = {
			"휴대전화번호" : $("#휴대전화번호").val(),
			"일반전화번호" : $("#일반전화번호").val(),
			"우편번호" : $("#우편번호").val(),
			"주소" : $("#도로명주소").val(),
			"상세주소" : $("#도로명상세주소").val(),
			"지번주소" : $("#지번주소").val(),			// 2017.04.04 기존 : 도로명 주소만 입력. 개선 : 도로명, 지번 주소 둘다 입력 
			"지번상세주소" : $("#지번상세주소").val(),	// 2017.04.04 기존 : 도로명 주소만 입력. 개선 : 도로명, 지번 주소 둘다 입력
			"차량소유여부" : $("#차량소유여부").val(),
			"SMS발송동의여부" : $("#SMS발송동의여부").val(),
			"자격증번호" : $("#자격증번호").val(),
			"손해평가사소속구분코드" : $("#손해평가사소속구분코드").val() // 2016.06 재해보험업무시스탬 개선내용 : 소속 컬럼 추가 
		};

		var registerActiveTime = { "자격증번호" : $("#자격증번호").val() };

		for(var i=0; i<$("#활동가능시기 tr td").length; i++){
			registerActiveTime['활동가능' + (i+1) + '월여부'] = ($("#활동가능시기 tr td:eq(" + i + ") input")[0].checked)?1:0;
		}

		var registerCropList = [];
		
		for(var i=0; i<$("#주력품목 tr").length; i++){
			if($("#주력품목 tr:eq("+ i +") td:eq(1) select").val() != undefined){
				var obj = {"자격증번호" : $("#자격증번호").val()};
				obj['cropCode'] = $("#주력품목 tr:eq(" + i + ") td:eq(2) select").val();
				registerCropList.push(obj);
			}
		}

		var registerRegCodeList = [];

		for(var i=0; i<$("#활동지역 tr").length; i++){
			if($("#활동지역 tr:eq("+ i +") td:eq(2) select").val() != undefined){
				var obj = {"자격증번호" : $("#자격증번호").val()};
				obj['SigunguCode'] = $("#활동지역 tr:eq(" + i + ") td:eq(2) select").val();
				registerRegCodeList.push(obj);
			}
		}
		
		var param = {
			"registerInfo" : registerInfo,
			"registerActiveTime" : registerActiveTime,
			"registerCropList" : registerCropList,
			"registerRegCodeList" : registerRegCodeList
		};

		$.ajax({
			url: "/GenCMS/gencms/updateRegisterInfo.do",
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
					searchRegister();
				}

			},
			failure: function(obj){
				alert("fail");
			},
			scope: this
		});


		
	}

	function popAddrFunction(){
		
		window.open("/GenCMS/gencms/addrPopup.do", "addrApi", "width=1000,height=550 scrollbars=1");
	}

	
	/** 2017-04-03 우편번호 검색 추가 내용 **/
	function jusoCallBack(roadFullAddr,addrDetail, jibunAddr, zipNo){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		$("#우편번호").val(zipNo);			   	// 우편번호
		$("#도로명주소").val(roadFullAddr); 	// 도로명 주소
		$("#지번주소").val(jibunAddr); 	   		// 지번 주소 					// 2017.04.04 기존 : 도로명 주소만 입력. 개선 : 도로명, 지번 주소 둘다 입력
		$("#도로명상세주소").val(addrDetail);	// 고객 입력 상세 주소(도로명)
		$("#지번상세주소").val(addrDetail);	   	// 고객 입력 상세 주소(지번)	// 2017.04.04 기존 : 도로명 주소만 입력. 개선 : 도로명, 지번 주소 둘다 입력
		
		/** 추가적으로 제공하는 주소값들 **/
/*  	document.form.roadAddrPart1.value = roadAddrPart1;
		document.form.roadAddrPart2.value = roadAddrPart2;
		document.form.addrDetail.value = addrDetail;
		document.form.engAddr.value = engAddr;
		document.form.jibunAddr.value = jibunAddr;
		document.form.zipNo.value = zipNo;
		document.form.admCd.value = admCd;
		document.form.rnMgtSn.value = rnMgtSn;
		document.form.bdMgtSn.value = bdMgtSn;
		document.form.detBdNmList.value = detBdNmList; */
		/** 2017년 2월 추가제공 **/
	/* 	document.form.bdNm.value = bdNm;
		document.form.bdKdcd.value = bdKdcd;
		document.form.siNm.value = siNm;
		document.form.sggNm.value = sggNm;
		document.form.emdNm.value = emdNm;
		document.form.liNm.value = liNm;
		document.form.rn.value = rn;
		document.form.udrtYn.value = udrtYn;
		document.form.buldMnnm.value = buldMnnm;
		document.form.buldSlno.value = buldSlno;
		document.form.mtYn.value = mtYn;
		document.form.lnbrMnnm.value = lnbrMnnm;
		document.form.lnbrSlno.value = lnbrSlno;
		document.form.emdNo.value = emdNo; */
		
}

	
	$(function() {
		getCodeList();
	});

	function validation(){
		var cnt = 0;
		var regExp = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		     
		if($("#휴대전화번호").val().length > 0){
			if ( !regExp.test( $("#휴대전화번호").val() ) ) {
			      alert("잘못된 휴대폰 번호입니다.");
			      return false;
			}
			else{
				var tel = $("#휴대전화번호").val();
				
				tel = replaceAll(tel, "-");
				if(tel.length < 10){
					 alert("잘못된 휴대폰 번호입니다.");
				     return false;
				}
				else if(tel.length > 10){
					tel = tel.substring(0, 3) + "-" +  tel.substring(3, 7) + "-" + tel.substring(7, 11);
				}
				else{
					tel = tel.substring(0, 3) + "-" +  tel.substring(3, 6) + "-" + tel.substring(6, 10);
				}

				$("#휴대전화번호").val(tel);
			}
			cnt++;
		}
// 		regExp = /^(0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4]))-(\d{3,4})-(\d{4})$/;
		regExp = /^(0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4]))-?(\d{3,4})-?(\d{4})$/;
		if($("#일반전화번호").val().length > 0){
			if ( !regExp.test( $("#일반전화번호").val() ) ) {
			      alert("잘못된 일반전화 번호입니다.");
			      return false;
			}
			else{
				var phone = $("#일반전화번호").val();
				
				phone = replaceAll(phone, "-");
				if(phone.length < 9){
					alert("잘못된 일반전화 번호입니다.");
				     return false;
				}
				if(phone.substring(0, 2) == "02"){
					if(phone.length > 10){
						alert("잘못된 일반전화 번호입니다.");
					     return false;
					}
					else if(phone.length > 9){
						phone = phone.substring(0, 2) + "-" + phone.substring(2, 6) + "-" + phone.substring(6, 10);
					}
					else{
						phone = phone.substring(0, 2) + "-" + phone.substring(2, 5) + "-" + phone.substring(5, 9);
					}
				}
				else{
					if(phone.length > 11){
						alert("잘못된 일반전화 번호입니다.");
					     return false;
					}
					else if(phone.length > 10){
						phone = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7, 11);
					}
					else{
						phone = phone.substring(0, 3) + "-" + phone.substring(3, 6) + "-" + phone.substring(6, 10);
					}
				}

				$("#일반전화번호").val(phone);
			}
			cnt++;
		}

		if(cnt == 0){
			alert("휴대전화번호 또는 일반전화번호 둘중 하나는 입력하여야 합니다.");
		    return false;
		}
	}

	function replaceAll(value, del){
		var result = value;
		while(result.indexOf(del) > -1){
			result = result.replace(del, "");
		}
		return result;
	}
</script>
	<!-- cont_area -->
	<div class="cont_area">
	
		<article class="item">
			<fieldset>
				<legend>손해평가사 정보</legend>
				<h5 class="title"><span>손해평가사 정보</span></h5>
				<!-- cont -->
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
			                     <tr>
			                         <th scope="row"><label for="자격증번호">자격증번호</label></th>
			                         <td class="left">
			                             <input type="text" id="자격증번호" name="자격증번호" class="input_ty" style="width:98%; background-color: #D5D5D5;" readonly>
			                         </td>
			                         <th scope="row"><label for="최종발행번호">최종발행번호</label></th>
			                         <td class="left">
			                             <input type="text" id="최종발행번호" name="최종발행번호" class="input_ty" style="width:98%; background-color: #D5D5D5;" readonly>
			                         </td>
			                     </tr>
			                     <tr>
			                         <th scope="row"><label for="시험년도">시험년도</label></th>
			                         <td class="left">
			                             <input type="text" id="시험년도" name="시험년도" class="input_ty" style="width:98%; background-color: #D5D5D5;" readonly>
			                         </td>
			                         <th scope="row"><label for="수험번호">수험번호</label></th>
			                         <td class="left">
			                             <input type="text" id="수험번호" name="수험번호" class="input_ty" style="width:98%; background-color: #D5D5D5;" readonly>
			                         </td>
			                     </tr>
			                     <tr>
			                         <th scope="row"><label for="성명">성명</label></th>
			                         <td class="left">
			                             <input type="text" id="성명" name="성명" class="input_ty" style="width:98%; background-color: #D5D5D5;" readonly>
			                         </td>
			                         <th scope="row"><label for="select_date_생년월일">생년월일</label></th>
			                         <td class="left">
			                         	 <input type="text" id="생년월일" name="생년월일" class="input_ty" style="width:98%; background-color: #D5D5D5;" readonly>
			                         </td>
			                     </tr>
			                     <tr>
			                         <th scope="row"><label for="select_date_합격연월일">합격연월일</label></th>
			                         <td class="left">
			                             <input type="text" id="합격연월일" name="합격연월일" class="input_ty" style="width:98%; background-color: #D5D5D5;" readonly>
			                         </td>
			                         <th scope="row"><label for="select_date_최종발급연월일">최종발급연월일</label></th>
			                         <td class="left">
			                             <input type="text" id="최종발급연월일" name="최종발급연월일" class="input_ty" style="width:98%; background-color: #D5D5D5;" readonly>
			                         </td>
			                     </tr>
			                     <tr>
			                         <th scope="row"><label for="휴대전화번호">휴대전화번호</label></th>
			                         <td class="left">
			                             <input type="text" id="휴대전화번호" name="휴대전화번호" class="input_ty" style="width:98%;">
			                         </td>
			                         <th scope="row"><label for="일반전화번호">일반전화번호</label></th>
			                         <td class="left">
			                             <input type="text" id="일반전화번호" name="일반전화번호" class="input_ty" style="width:98%;">
			                         </td>
			                     </tr>
			                     <tr>
			                         <th scope="row"><label>SMS발송동의여부</label></th>
			                         <td class="left">
			                         	<select id="SMS발송동의여부" name="SMS발송동의여부" title="SMS발송동의여부" style="width:98%;">
											<option value="0">미동의</option>
											<option value="1">동의</option>
										</select>
			                         </td>
			                         <th scope="row"><label>차량사용여부</label></th> <!-- 2016.06 재해보험업무시스탬 개선내용 : 차량소유여부 ->차량사용여부   -->
			                         <td class="left">
			                         	<select id="차량소유여부" name="차량소유여부" title="차량소유여부" style="width:98%;">
											<option value="0">N</option>
											<option value="1">Y</option>
										</select>
			                         </td>
			                     </tr>
			                    <tr><!-- 2016.06 재해보험업무시스탬 개선내용 : 소속  -->
			                         <th scope="row"><label>소속</label></th> 
			                         <td class="left">
			                         	<select id="손해평가사소속구분코드" name="손해평가사소속구분코드" title="손해평가사소속구분코드" style="width:98%;">
										</select>
			                         </td>
			                     </tr>
			                     <tr>
			                         <th scope="row" rowspan="3"><label>소재지</label></th>
			                         <td class="left" colspan="3">
			                             <input type="text" id="우편번호" name="우편번호" class="input_ty" style="width:25%;" disabled="disabled" >
			                             <a href="javascript:popAddrFunction();" class="btn_xs">우편번호 검색</a>			                             
			                         </td>
			                         <td>
			                         </td>			                         
			                     </tr>
			                     <tr>
			                     	 <td class="left" colspan="3">
			                     	 	<input type="text" id="도로명주소" name="도로명주소" class="input_ty" style="width:60%;" disabled="disabled" >
			                     	 	<input type="text" id="도로명상세주소" name="도로명상세주소" class="input_ty" style="width:35%;" >
			                     	 </td>			                     
			                     </tr>
			                     <tr>
			                     	 <td class="left" colspan="3">
			                     	 	<input type="text" id="지번주소" name="지번주소" class="input_ty" style="width:60%;" disabled="disabled" >
			                     	 	<input type="text" id="지번상세주소" name="지번상세주소" class="input_ty" style="width:35%;" >
			                     	 </td>			                     
			                     </tr>			                 
			                     
			                 </tbody>
			                 
			             </table>
			             
			         </div>
			         <!-- //board_ty -->        
				        	
				    <%-- //일반형 게시판 --%>
				</div>
				<!-- //cont -->
			</fieldset>
		</article>
		<article class="board_search"><!-- 2016.06 재해보험업무시스탬 개선내용 : 차량소유여부 ->차량사용여부   -->
			<label >※ 차량사용여부 : 손해평가 활동에 차량을 이용할 의향이 있으십니까?</label>
		</article>
		<article class="item">
			<fieldset>
				<legend>활동가능 시기</legend>
				<h5 class="title"><span>활동가능 시기</span></h5>
				<!-- cont -->
				<div class="cont pd">
					<%-- 일반형 게시판 --%>
			        <!-- board_ty -->
			           <div class="board_ty">
			           	<table>
			                <caption>활동가능시기</caption>
			                <colgroup>
				        		<col span="1" style="width:8%;">
				                <col span="1" style="width:8%;">
				                <col span="1" style="width:8%;">
				                <col span="1" style="width:8%;">
				                <col span="1" style="width:8%;">
				                <col span="1" style="width:8%;">
				                <col span="1" style="width:8%;">
				                <col span="1" style="width:8%;">
				                <col span="1" style="width:8%;">
				                <col span="1" style="width:8%;">
				                <col span="1" style="width:8%;">
				                <col span="1" style="width:8%;">
			                </colgroup>
			                <thead>
			                    <tr>
				         			<th scope="col">1월</th>
				                    <th scope="col">2월</th>
				                    <th scope="col">3월</th>
				                    <th scope="col">4월</th>
				                    <th scope="col">5월</th>
				                    <th scope="col">6월</th>
				                    <th scope="col">7월</th>
				                    <th scope="col">8월</th>
				                    <th scope="col">9월</th>
				                    <th scope="col">10월</th>
				                    <th scope="col">11월</th>
				                    <th scope="col">12월</th>
			                    </tr>
			                </thead>
							<tbody id="활동가능시기">
							</tbody>
						</table>
					</div>                               
			         <!-- //board_ty -->
				    <%-- //일반형 게시판 --%>
				</div>
				<!-- //cont -->
			</fieldset>
		</article>
		
		<article class="item">
			<fieldset>
				<legend>주력 품목</legend>
				<h5 class="title"><span>주력 품목</span></h5>
				<div class="cont pd">
					<%-- 일반형 게시판 --%>
			        <!-- board_ty -->
			           <div class="board_ty">
			           	<table>
			                <caption>주력 품목</caption>
			                <colgroup>
				        		<col span="1" style="width:10%;">
				        		<col span="1" style="width:45%;">
				        		<col span="1" style="width:45%;">
			                </colgroup>
			                <thead>
			                    <tr>
				         			<th scope="col"><input id=changeCheck_1 type="checkbox" onchange="changeCheckFunction1()"></th>
				         			<th scope="col">품목분류</th>
				         			<th scope="col">품목명</th>
			                    </tr>
			                </thead>
							<tbody id="주력품목">
							</tbody>
						</table>
					</div>                               
			         <!-- //board_ty -->
				    <%-- //일반형 게시판 --%>
				    
				    <!-- btn_area -->
                    <ul class="btn_area" style="height: 27px">
                        <li class="right">
                            <a href="javascript:CropRowAdd();" class="btn_xs02">행추가</a>
                            <a href="javascript:CropRowDelete();" class="btn_xs">행삭제</a>
                        </li>
                    </ul>
                    <!-- //btn_area -->
				</div>
			</fieldset>
		</article>
		 
		<article class="item">
			<fieldset>
				<legend>활동 지역</legend>
				<h5 class="title"><span>활동 지역</span></h5>
				<div class="cont pd">
					<%-- 일반형 게시판 --%>
			        <!-- board_ty -->
			           <div class="board_ty">
			           	<table>
			                <caption>활동지역</caption>
			                <colgroup>
				        		<col span="1" style="width:10%;">
				        		<col span="1" style="width:45%;">
				        		<col span="1" style="width:45%;">
			                </colgroup>
			                <thead>
			                    <tr>
				         			<th scope="col"><input id=changeCheck_2 type="checkbox" onchange="changeCheckFunction2()"></th>
				         			<th scope="col">시도</th>
				         			<th scope="col">시군구</th>
			                    </tr>
			                </thead>
							<tbody id="활동지역">
							</tbody>
						</table>
					</div>                               
			         <!-- //board_ty -->
				    <%-- //일반형 게시판 --%>
				    
				    <!-- btn_area -->
                    <ul class="btn_area" style="height: 27px">
                        <li class="right">
                            <a href="javascript:RegRowAdd();" class="btn_xs02">행추가</a>
                            <a href="javascript:RegRowDelete();" class="btn_xs">행삭제</a>
                        </li>
                    </ul>
                    <!-- //btn_area -->
				</div>
			</fieldset>
		</article>
		
		<!-- btn_area -->
		<!-- 2016.05.09 버튼 height 조정 -->
		<ul class="btn_area" style="height: 27px">
			<li class="right">
				<a href="javascript:saveFunction();" class="btn_s btn_ty02"><span class="ico_save">수정</span></a>
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
	
