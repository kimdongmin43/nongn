<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<link href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" rel="stylesheet" />
<script src="/assets/jquery/jquery.ui.datepicker.js"></script>

<script>
var applyUpdateUrl =  "<c:url value='/front/apply/updateApply.do'/>";

$(document).ready(function(){
	$(".onlynum").keyup( setNumberOnly );
	
	$('.datepicker').each(function(){
	    $(this).datepicker({
			  format: "yyyy-mm-dd",
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
			 });
	});
	
	actplanCnt =1;
	programCnt =1;
	
    $.ajax({
        url: "/front/actplan/applyActplanList.do",
        dataType: "json",
        type: "post",
        data: {
        	aply_id : $("#aply_id").val()
		},
        success: function(data) {
        	if(data != null && data.list.length > 0){
        		 var actplan = "";
        		for(var i =0; i < data.list.length;i++){
        			actplan = data.list[i];
        			addActivetarget(actplan.up_activ_target, actplan.activ_target);
        		}
        	}else{
        		addActivetarget('','');
        	}	
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
    
    $.ajax({
        url: "/front/actplan/applyWishprogList.do",
        dataType: "json",
        type: "post",
        data: {
  		   aply_id : $("#aply_id").val()
		},
        success: function(data) {
        	if(data != null && data.list.length > 0){
	       		 var actplan = "";
	       		for(var i =0; i < data.list.length;i++){
	       			actplan = data.list[i];
	       			addProgram(actplan.wish_prog);
	       		}
	       	}else{
	       		addProgram("");
	       	}	
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
    
});

function updateApply(){
	   
	   var url = "";

	   if($('#id_file_id').val() == "")
	   	  $('#uploadFile1').attr('data-parsley-required', 'true');	
/* 	   if($('#health_file_id').val() == "")
		   	  $('#uploadFile2').attr('data-parsley-required', 'true');	 */
	   if($('#unemplyinsur_file_id').val() == "")
		   	  $('#uploadFile3').attr('data-parsley-required', 'true');	
	   if($('#deploma_file_id').val() == "")
		   	  $('#uploadFile4').attr('data-parsley-required', 'true');	
		   
	   if ( $("#writeFrm").parsley().validate() ){
			if($("#administ_cd").val().substring(0,2) != "11" ){
				alert("서울시 거주자만 청년수당 신청이 가능합니다.");
				return;
			}
			
		   if($("#tel_2").val() != "" && $("#tel_3").val() != "" )
		   	 $("#hometel").val($("#tel_1").val()+"-"+$("#tel_2").val()+"-"+$("#tel_3").val());
		   
		   $("#mobile").val($("#mobile_1").val()+"-"+$("#mobile_2").val()+"-"+$("#mobile_3").val());
		   $("#email").val($("#email_1").val()+"@"+$("#email_2").val());
		   
		   for(var i =1; i < 5; i++ ){
				if ($("#uploadFile"+i).val() != "" && !$("#uploadFile"+i).val().toLowerCase().match(/\.(jpg|png|gif|ppt|pptx|xls|xlsx|doc|docx|hwp|txt|pdf|zip)$/)){
				    alert("확장자가 jpg,png,gif,ppt,pptx,xls,xlsx,doc,docx,hwp,txt,pdf,zip 파일만 업로드가 가능합니다.");
				    return;
				}  
	     	}

		   var actplan = new Map();
		   var program = new Map();
		   var actplan1Row = new Array();
		   var actplan2Row = new Array();
		   $("select[name='activetargetcode1']").each(function(i,e){
			   actplan1Row.push(e.value);
		   });
		   $("select[name='activetargetcode2']").each(function(i,e){
			   actplan2Row.push(e.value);
		   });
		   var key = "";
		   var dupcheck = true;
		   for(var i =0; i < actplan1Row.length;i++){
			    key = actplan1Row[i]+"/"+actplan2Row[i];
			    if(actplan.containsKey(key)){
			    	alert("증복된 활동목표가 있습니다.");
			    	dupcheck = false;
			    }
			    actplan.put(key,"");
		   }
		   $("select[name='programcode']").each(function(i,e){
			   key = e.value;
			    if(program.containsKey(key)){
			    	alert("증복된 프로그램이 있습니다.");
			    	dupcheck = false;
			    }
			    program.put(key,"");
		   });

		   if(!dupcheck) return;
		   
	       url = applyUpdateUrl; 

		   if(!confirm("신청서를 수정하시겠습니까?")) return;
		   
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						myApplyResult();
					}	
				},
				dataType: "json", 				
				url: url
		    });	
	   }
}    

function changeEmailDomain(){
	   $("#email_2").val($("#email_domain").val());
}

function setAddr(roadAddr,jibunAddr,zipNo,admCd){
	$("#postno").val(zipNo);
	$("#basic_addr").val(roadAddr);
	$("#detail_addr").val("");
	$("#detail_addr").focus();
	$("#administ_cd").val(admCd);
}

function delFile(gubun){
	   if(gubun == "1") $("#id_file_id").val("");
	   else	if(gubun == "2") $("#health_file_id").val("");
	   else	if(gubun == "3") $("#unemplyinsur_file_id").val("");
	   else	if(gubun == "4") $("#deploma_file_id").val("");
	   
		$("#upFile"+gubun).hide();
}

var actplanCnt =1;
function addActivetarget(upActplan, actplan){
	var str = "", selyn = "";
	
	if(actplanCnt > 3) {
		alert("활동목표를 더 이상 입력할 수 없습니다.");
		return;
	}

	str +='<li id="activetarget_'+actplanCnt+'">';
	str +='<div class="list_row">';
	str +='	<div class="head_area">';
	str +='		<strong>활동목표</strong>';
	str +='	</div>';
	str +='	<div class="body_area">';
	str +='		<label for="activetargetcode1'+actplanCnt+'" class="hidden">활동목표 '+actplanCnt+'단계</label>';
	str +='		<select class="in_w20" id="activetargetcode1'+actplanCnt+'" name="activetargetcode1" onchange="changeActivetarget('+actplanCnt+')">';
	<c:forEach var="row" items="${activetargetList}" varStatus="status">
	                if(upActplan == "") upActplan = "<c:if test="${ status.index== 0}">${row.code}</c:if>"; 
				    if('${row.code}' == upActplan) selyn = "selected";
				    else selyn = "";
	str += '				<option value="${row.code}" '+selyn+'>${row.codenm}</option>';
	</c:forEach>
	str +='		</select>';
	str +='		<label for="activetargetcode2'+actplanCnt+'" class="hidden">활동목표 '+actplanCnt+'단계</label>';
	str +='		<select class="in_w20" id="activetargetcode2'+actplanCnt+'" name="activetargetcode2">';
	var pdata = {
			gubun : "ACTIVE_TARGET",
			up_classify_id : upActplan
		};
	str += getCodeListStr("/front/classify/classifyCodeList.do", pdata, actplan, "") ;
	str +='		</select>';
	str +='		<div class="contents_list_btn_area">';
	str +='			<a href="javascript:delActivetarget(\''+actplanCnt+'\')" class="plus_btn" title="활동목표 빼기 버튼">';
	str +='				<img src="/images/back/common/btn_minus.png" alt="빼기 버튼" />';
	str +='			</a>';
	str +='		</div>';
	str +='	</div>';
	str +='</div>';
	str +='</li>';
	
	actplanCnt++;
	
	$("#activetarget_list").append(str);
}

function changeActivetarget(idx){
	var upActplan = $("#activetargetcode1"+idx).val();
	var pdata = {
			gubun : "ACTIVE_TARGET",
			up_classify_id : upActplan
		};
	selectbox_deletealllist("activetargetcode2"+idx);
	getCodeList("/front/classify/classifyCodeList.do", pdata, "activetargetcode2"+idx, "", "", "", true); 
}

function delActivetarget(idx){
	 if(actplanCnt < 3){
		 alert("활동목표는 최소 하나는 입력하셔야 합니다.");
		 return;
	 }
	 $("#activetarget_"+idx).remove();
	 actplanCnt--;
}

var programCnt =1;
function addProgram(selval){
	   var str = "", selyn ="";
	   
		if(programCnt > 3) {
			alert("활동목표를 더 이상 입력할 수 없습니다.");
			return;
		}

		str += '<li id="program_'+programCnt+'">';
		str += '	<div class="list_row">';
		str += '		<div class="head_area">';
		str += '			<strong>프로그램</strong>';
		str += '		</div>';
		str += '		<div class="body_area">';
		str += '			<label for="programcode" class="hidden">프로그램 '+programCnt+'단계</label>';
		str += '			<select class="in_w20" id="programcode" name="programcode">';
		<c:forEach var="row" items="${programList}">
		                         if('${row.code}' == selval) selyn = "selected";
		                         else selyn = "";
		str += '				<option value="${row.code}" '+selyn+'>${row.codenm}</option>';
		</c:forEach>
		str += '			</select>';
		str += '			<div class="contents_list_btn_area">';
		str += '				<a href="javascript:delProgram(\''+programCnt+'\')" class="plus_btn" title="프로그램 빼기 버튼">';
		str += '					<img src="/images/back/common/btn_minus.png" alt="빼기 버튼" />';
		str += '				</a>';
		str += '			</div>';
		str += '		</div>';
		str += '	</div>';
		str += '</li>';
		
		programCnt++;
		
		$("#program_list").append(str);
}

function delProgram(idx){
	 if(programCnt < 3){
			alert("희망프로그램은 최소 하나는 입력하셔야 합니다.");
			return;
	 }
	 $("#program_"+idx).remove();
	 programCnt--;
}

function myApplyResult(){
	var f = document.writeFrm;
    f.action = "/front/apply/myApplyResult.do";
    f.submit();
}

function checkPriod(){
	var date = new Date("${apply.rel_dt}");
	var data = "";
	var gap = 0;
	if(jsNvl($("#grad_dt").val(),"0000-00-00") > jsNvl($("#retire_dt").val(),"0000-00-00")){
		if($("#grad_dt").val() != "")
			gap = getDifferenceDate("M",$("#grad_dt").val(), date.yyyymmdd("-"));
	}else{
		if($("#retire_dt").val() != "")
			gap = getDifferenceDate("M",$("#retire_dt").val(), date.yyyymmdd("-"));
	}
    
	$("#unemploy_priod").val(gap);
}

function checkSeoullivePriod(){
	var date = new Date("${apply.rel_dt}");
	var data = "";
	var gap = 0;
	if($("#seoul_live_dt").val() != "")
		gap = getDifferenceDate("M",$("#seoul_live_dt").val(), date.yyyymmdd("-"));
    
	$("#seoul_live_priod").val(gap);	
}


</script>
<form id="writeFrm" name="writeFrm" method="post"  onSubmit="return false;" data-parsley-validate="true" enctype="multipart/form-data">
<input type='hidden' id="aply_id" name='aply_id' value="${apply.aply_id}" />
<input type="hidden" id="id_file_id" name="id_file_id" value="${apply.id_file_id}" />
<input type="hidden" id="health_file_id" name="health_file_id" value="${apply.health_file_id}" />
<input type="hidden" id="unemplyinsur_file_id" name="unemplyinsur_file_id" value="${apply.unemplyinsur_file_id}" />
<input type="hidden" id="deploma_file_id" name=deploma_file_id value="${apply.deploma_file_id}" />
<input type="hidden" id="email" name="email" value="${apply.email}" />
<input type="hidden" id="mobile" name="mobile" value="${apply.mobile}" />
<input type="hidden" id="hometel" name="hometel" value="${apply.hometel}" />
<input type="hidden" id="administ_cd" name="administ_cd" value="${apply.administ_cd}" />

					<!-- division40 -->
					<div class="division40">
						<!-- division60 -->
						<div class="division60">
							<!-- title_area -->
							<div class="title_area">
								<h3 class="title">신청자 정보</h3>
							</div>
							<!--// title_area -->
							<!-- table_area -->
							<div class="table_area">
								<table class="write fixed">
									<caption>신청자 정보 등록 화면</caption>
									<colgroup>
										<col style="width: 160px;">
										<col style="width: *;">
									</colgroup>
									<tbody>
									<tr>
										<th scope="row" class="first">
											<label for="input_name">이름</label>
										</th>
										<td class="first">
											${apply.user_nm}
										</td>
									</tr>
									<tr>
										<th scope="row">생년월일</th>
										<td>
										 ${apply.birth_year}년 ${apply.birth_mm}월 ${apply.birth_dd}일 (${apply.gender_nm})
										</td>
									</tr>
									<tr>
										<th scope="row">자택전화</th>
										<td>
											<div class="m_phone_area">
											<label for="tel_1" class="hidden">자택전화 첫번째자리</label>
				                             <select id='tel_1' name='tel_1' title='자택전화 첫번째자리' class="in_wp70">
												    <option value='02' <c:if test="${apply.tel_1 == '02'}">selected</c:if>>02</option>
													<option value='051' <c:if test="${apply.tel_1 == '051'}">selected</c:if>>051</option>
													<option value='053' <c:if test="${apply.tel_1 == '053'}">selected</c:if>>053</option>
													<option value='032' <c:if test="${apply.tel_1 == '032'}">selected</c:if>>032</option>
													<option value='062' <c:if test="${apply.tel_1 == '062'}">selected</c:if>>062</option>
													<option value='042' <c:if test="${apply.tel_1 == '042'}">selected</c:if>>042</option>
													<option value='052' <c:if test="${apply.tel_1 == '052'}">selected</c:if>>052</option>
													<option value='044' <c:if test="${apply.tel_1 == '044'}">selected</c:if>>044</option>
													<option value='031' <c:if test="${apply.tel_1 == '031'}">selected</c:if>>031</option>
													<option value='033' <c:if test="${apply.tel_1 == '033'}">selected</c:if>>033</option>
													<option value='043' <c:if test="${apply.tel_1 == '043'}">selected</c:if>>043</option>
													<option value='041' <c:if test="${apply.tel_1 == '041'}">selected</c:if>>041</option>
													<option value='063' <c:if test="${apply.tel_1 == '063'}">selected</c:if>>063</option>
													<option value='061' <c:if test="${apply.tel_1 == '061'}">selected</c:if>>061</option>
													<option value='054' <c:if test="${apply.tel_1 == '054'}">selected</c:if>>054</option>
													<option value='055' <c:if test="${apply.tel_1 == '055'}">selected</c:if>>055</option>
													<option value='064' <c:if test="${apply.tel_1 == '064'}">selected</c:if>>064</option>
													<option value='070' <c:if test="${apply.tel_1 == '070'}">selected</c:if>>070</option>
				                           </select>
											-
											<label for="tel_2" class="hidden">전화 중간자리</label>
											<input id="tel_2" name="tel_2" type="text" value="${apply.tel_2}" class="in_wp40 onlynum" maxlength="4"   data-parsley-required="false" data-parsley-errors-messages-disabled="true"  />
											-
											<label for="tel_3" class="hidden">전화 뒷자리</label>
											<input id="tel_3" name="tel_3" type="text" value="${apply.tel_3}" class="in_wp40 onlynum" maxlength="4" data-parsley-required="false" />
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<strong class="color_pointr">*</strong>휴대전화
										</th>
										<td>
											<div class="m_phone_area">
											<label for="mobile_1" class="hidden">휴대폰번호 첫번째자리</label>
										    <select id='mobile_1' name='mobile_1' title='휴대폰번호 첫번째자리' class="in_wp70">
													<option value='010' <c:if test="${apply.mobile_1 == '010'}">selected</c:if>>010</option>
													<option value='011' <c:if test="${apply.mobile_1 == '011'}">selected</c:if>>011</option>
													<option value='016' <c:if test="${apply.mobile_1 == '016'}">selected</c:if>>016</option>
													<option value='017' <c:if test="${apply.mobile_1 == '017'}">selected</c:if>>017</option>
													<option value='018' <c:if test="${apply.mobile_1 == '018'}">selected</c:if>>018</option>
													<option value='019' <c:if test="${apply.mobile_1 == '019'}">selected</c:if>>019</option>
										    </select>
											-
											<label for="mobile_2" class="hidden">휴대전화 중간자리</label>
											<input id="mobile_2" name="mobile_2" type="text" value="${apply.mobile_2}" class="in_wp40 onlynum" maxlength="4"  data-parsley-required="true" data-parsley-errors-messages-disabled="true" maxlength="4" />
											-
											<label for="mobile_3" class="hidden">휴대전화 뒷자리</label>
											<input id="mobile_3" name="mobile_3" type="text" value="${apply.mobile_3}" class="in_wp40 onlynum" maxlength="4" data-parsley-required="true" />
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong class="color_pointr">*</strong>이메일</th>
										<td>
										<label for="email_1" class="hidden">이메일 앞주소</label>
										<input id="email_1" name="email_1" type="text" value="${apply.email_1}" class="in_wp80" data-parsley-required="true" data-parsley-errors-messages-disabled="true"  />
										<span>@</span>
										<label for="email_2" class="hidden">이메일 뒷주소</label>
										<input id="email_2" name="email_2" type="text" value="${apply.email_2}" class="in_wp100"  data-parsley-required="true" data-parsley-errors-container="#email_error_message" />
										<label for="email_domain" class="hidden">이메일주소선택</label>
										<select id='email_domain' name='email_domain' title='이메일주소선택' class="in_wp80" onChange="changeEmailDomain()">
			                                                <option value="self">직접입력</option>
															<option value="hanmail.net">한메일</option>
															<option value="naver.com">네이버</option>
															<option value="nate.com">네이트</option>
															<option value="gmail.com">구글</option>
															<option value="yahoo.co.kr">야후</option>
															<option value="lycos.co.kr">라이코스</option>
															<option value="chollian.net">천리안</option>
															<option value="empal.com">엠팔</option>
															<option value="hotmail.com">핫메일</option>
															<option value="dreamwiz.com">드림위즈</option>
															<option value="paran.com">파란</option>
											</select>
											<div id="email_error_message"></div>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong class="color_pointr">*</strong>주민등록주소</th>
										<td>
										<div class="address_area">
											<label for="postno" class="hidden">우편번호</label>
											<input id="postno" name="postno" type="text" value="${apply.postno}" placeholder="우편번호" class="in_wp70"  />
											<button onClick="jusoPopupShow();return false;" class="btn s_save_btn" title="주소찾기">
												<span>주소찾기</span>
											</button>
										</div>
										<div class="address_area">
											<input id="basic_addr" name="basic_addr" type="text" value="${apply.basic_addr}" placeholder="기본주소"  class="in_w50"  readOnly data-parsley-required="true" data-parsley-errors-messages-disabled="true"  />
											<label for="basic_addr" class="hidden">주민등록주소 상세주소1</label>
											<input id="detail_addr" name="detail_addr" type="text" value="${apply.detail_addr}" placeholder="상세주소" class="in_w50" data-parsley-required="true" data-parsley-maxlength="200" style="margin-top:5px;" />
											<label for="detail_addr" class="hidden">주민등록주소 상세주소2</label>
										</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong class="color_pointr">*</strong>전입일(주민등록기준)</th>
										<td>
										<label for="seoul_live_priod" class="hidden">전입일(주민등록기준) 선택</label>
										<input type="hidden" id="seoul_live_priod" name="seoul_live_priod" value="${apply.seoul_live_priod}" />
	   								    <label for="seoul_live_dt" class="hidden">전입날짜선택</label>
	   								    <input type="text" id="seoul_live_dt" name="seoul_live_dt" class="in_wp100 datepicker" readonly value="${apply.seoul_live_dt}" data-parsley-required="true" data-parsley-errors-container="#seoullivedt_error_message" onChange="checkSeoullivePriod()" />
	   								    <div id="seoullivedt_error_message"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="health_no">
												<strong class="color_pointr">*</strong>건강보험증 번호
											</label>											
										</th>
										<td>
										<input id="health_no" name="health_no" type="text" value="${apply.health_no}" class="in_wp150 onlynum" maxlength="11" data-parsley-required="true" data-parsley-maxlength="20" />
										</td>
									</tr>
									<tr style="display:none;">
										<th scope="row">
										     <label for="health_gb">
											    <strong class="color_pointr">*</strong>건강보험료
											 </label>   								
										</th>
										<td>
										<g:radio id="health_gb" name="health_gb" codeGroup="HEALTHINSUR_GUBUN" curValue="${apply.health_gb}"  />
										<label for="health_fee" class="hidden">건강보험료</label>
									    <input id="health_fee" name="health_fee" type="text" value="${apply.health_fee}" class="in_wp150 onlynum" data-parsley-required="true" data-parsley-maxlength="20"  data-parsley-errors-container="#health_error_message"  />
										<label>원</label>
										<div id="health_error_message"></div>
										<!--  <a class="btn s_save_btn" title="보험료조회">
											<span>보험료조회</span>
										</a> -->
										</td>
									</tr>
									<tr>
										<th scope="row">
											<strong class="color_pointr">*</strong>최종학력 졸업일자							
										</th>
										<td>
											<label for="last_ability" class="hidden">최종학력</label>
											<g:select id="last_ability" name="last_ability"  codeGroup="LAST_ABILITY" cls="in_wp100" selected="${apply.last_ability}" />
											<label for="grad_dt" class="hidden">최종학력 졸업일자</label>
											<input type="text" id="grad_dt" name="grad_dt" class="in_wp100 datepicker" readonly value="${apply.grad_dt}" data-parsley-required="true" data-parsley-errors-container="#graddt_error_message" onChange="checkPriod()" />
											<div id="graddt_error_message"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">최종 퇴직일자</th>
										<td>
										<label for="retire_dt" class="hidden">최종 퇴직일자</label>
										<input type="text" id="retire_dt" name="retire_dt" class="in_wp100 datepicker" readonly value="${apply.retire_dt}" data-parsley-errors-container="#retiredt_error_message"  onChange="checkPriod()" />
										<div id="retiredt_error_message"></div>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="unemploy_priod">
												최근 미취업기간
											</label>
										</th>
										<td>
                                            <input id="unemploy_priod" name="unemploy_priod" type="text" value="${apply.unemploy_priod}" class="in_wp50 onlynum" style="background-color:lightgray" readOnly/> 개월
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="dependent_cnt">
												<strong class="color_pointr">*</strong>배우자 및 자녀 수
											</label>
										</th>
										<td>
											<select class="in_wp100" id="dependent_cnt" name="dependent_cnt">
			   								    <c:forEach var="i" begin="0" end="4">
						                         <option value="${i}" <c:if test="${i == apply.dependent_cnt}">selected</c:if>>${i}인
						                         	<c:if test="${i == 4}"> 이상</c:if>
						                         </option>
						                     </c:forEach>
											</select>	
										</td>
									</tr>
									<tr>
										<th scope="row">
											<strong class="color_pointr">*</strong>기초생활수급자 여부										
										</th>
										<td>
										   <label for="reserver1" class="hidden">기초생활수급 Y</label>
											<input type="radio" id="reserver1" name="reserver_yn" value="Y" <c:if test="${apply.reserver_yn == 'Y'}">checked</c:if>> 사용 
											<label for="reserver2" class="hidden">기초생활수급 N</label>
											<input type="radio" id="reserver2" name="reserver_yn" value="N"  <c:if test="${apply.reserver_yn == 'N'}">checked</c:if>> 미사용
										</td>
									</tr>
									</tbody>
								</table>
							</div>	
							<!--// table_area -->	
						</div>
			           	<!--// division60 -->
						
						<!-- division60 -->
						<div class="division60">
							<!-- title_area -->
							<div class="title_area">
								<h3 class="title">신청 시 구비서류</h3>
							</div>
							<!--// title_area -->
							<!-- table_area -->
							<div class="table_area">
								<table class="write fixed">
									<caption>신청 시 구비서류 등록 화면</caption>
									<colgroup>
										<col style="width: 160px;">
										<col style="width: *;">
									</colgroup>
									<tbody>
									<tr>
										<th scope="row" class="first"><strong class="color_pointr">*</strong>주민등록등본</th>
										<td class="first">
											<div class="file_area">
												  <c:if test="${!empty apply.id_file_id}">
							                      <p id="upFile1"><a href="/commonfile/fileidDownLoad.do?file_id=${apply.id_file_id}" >${apply.id_file_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('1')"></a></p>
							                      </c:if>
												  <label for="uploadFile1" class="hidden">파일 선택하기</label>
							                      <input class="in_w60 marginb10" type="file" id="uploadFile1" name="uploadFile1" value="" data-parsley-maxlength="100" />
											</div>
											<p class="point_txt2">※ 과거의 주소변동(이력) 사항 포함</p>
											<p class="point_txt2">※ 주민번호 뒷자리 6자리는 가려서 제출</p>
										</td>
									</tr>
									<input type="hidden" id="uploadFile2" name="uploadFile2" />
									<tr>
										<th scope="row"><strong class="color_pointr">*</strong>고용보험 피보험자격 내역서(피보험자용)</th>
										<td>
											<div class="file_area">
												  <c:if test="${!empty apply.unemplyinsur_file_id}">
							                      <p id="upFile3"><a href="/commonfile/fileidDownLoad.do?file_id=${apply.unemplyinsur_file_id}" >${apply.unemplyinsur_file_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('3')"></a></p>
							                      </c:if>
													<label for="uploadFile3" class="hidden">파일 선택하기</label>
							                       <input class="in_w60 marginb10" type="file" id="uploadFile3" name="uploadFile3" value=""  data-parsley-maxlength="100" />
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><strong class="color_pointr">*</strong>최종학력 졸업증명서 또는 졸업예정증명서</th>
										<td>
											<div class="file_area">
												  <c:if test="${!empty apply.deploma_file_id}">
							                      <p id="upFile4"><a href="/commonfile/fileidDownLoad.do?file_id=${apply.deploma_file_id}" >${apply.deploma_file_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('4')"></a></p>
							                      </c:if>
												  <label for="uploadFile4" class="hidden">파일 선택하기</label>
							                      <input class="in_w60 marginb10" type="file" id="uploadFile4" name="uploadFile4" value=""  data-parsley-maxlength="100" />
											</div>
										</td>
									</tr>
									</tbody>
								</table>
							</div>
							<!-- table_area -->
						</div>
						<!--// division60 -->
						<!-- division60 -->
						<div class="division60">
							<!-- title_area -->
							<div class="title_area">
								<h3 class="title">활동계획서</h3>
							</div>
							<!--// title_area -->
							<!-- contents_table -->
							<div class="contents_table">
								<!-- contents_title -->
								<div class="contents_title">
									<strong>활동목표</strong> <strong style="color:red;">(필수)</strong>
									<div class="contents_title_btn_area">
										<a href="javascript:addActivetarget('','');" class="plus_btn" title="활동목표 더하기 버튼">
											<img src="/images/front/icon/faq_plus.png" alt="더하기 버튼" />
										</a>
									</div>
								</div>
								<!--// contents_title -->
								<!-- contents_list -->
								<div class="contents_list">
									<ul class="line_list" id="activetarget_list">
	
									</ul>
								</div>
								<!--// contents_list -->
							</div>
							<!--// contents_table -->
							<!-- contents_table -->
							<div class="contents_table">
								<!-- contents_title -->
								<div class="contents_title">
									<strong>희망프로그램</strong> <strong style="color:red;">(필수)</strong>
									<div class="contents_title_btn_area">
										<a href="javascript:addProgram('');" class="plus_btn" title="활동목표 더하기 버튼">
											<img src="/images/front/icon/faq_plus.png" alt="더하기 버튼" />
										</a>
									</div>
								</div>
								<!--// contents_title -->
								<!-- contents_list -->
								<div class="contents_list">
									<ul class="line_list" id="program_list">
										
									</ul>
								</div>
								<!--// contents_list -->
							</div>
							<!--// contents_table -->
							<!-- contents_table -->
							<div class="contents_table">
								<!-- contents_title -->
								<div class="contents_title">
									<strong>세부활동계획</strong> <strong style="color:red;">(필수)</strong>
								</div>
								<!--// contents_title -->
								<!-- contents_list -->
								<div class="contents_list">
									<ul class="no_list">
										<li>
											<div class="list_row">
												<div class="head_area">
													<strong><label for="input_textarea">지원동기</label></strong>
												</div>
												<div class="body_area">
												    <label for="aply_motiv" class="hidden">파일 선택하기</label>
													<textarea cols="5" rows="10" id="aply_motiv" name="aply_motiv" class="in_w100" data-parsley-required="true" data-parsley-maxlength="4000" >${apply.aply_motiv}</textarea>
												</div>
											</div>
										</li>
										<li>
											<div class="list_row">
												<div class="head_area">
													<strong><label for="input_textarea02">월별활동계획</label></strong>
												</div>
												<div class="body_area">
												    <label for="activ_plan" class="hidden">파일 선택하기</label>
													<textarea cols="5" rows="10" id="activ_plan" name="activ_plan" class="in_w100" data-parsley-required="true" data-parsley-maxlength="4000" >${apply.activ_plan}</textarea>
												</div>
											</div>
										</li>								
									</ul>
								</div>
								<!--// contents_list -->
							</div>
							<!--// contents_table -->
							
							<!-- explain_txt_area -->
							<div class="explain_txt_area">
								<div class="explain_txt01">
									<p>본인은 상기 기재내용을 사실대로 기재하였으며, 만일 기재 내용이 <strong>사실과 다를 경우 신청기관이 접수를 취소하거나 이외 상공회의소사업 지원금 환수 또는 제재를 가하더라도 이의를 제기하지 않겠습니다.</strong></p>
								</div>
								<div class="explain_txt02">
									<ul>
										<li>
											<strong>신청일 :</strong>
											<span>${apply.reg_date}</span>
										</li>
										<li>
											<strong>신청자 :</strong>
											<span>${apply.user_nm}(인)</span>
										</li>
									</ul>
								</div>
								<div class="explain_txt03">
									<strong>서울특별시시장 귀하</strong>
								</div>
							</div>
							<!--// explain_txt_area -->
							
						</div>
						<!--// division60 -->
			            <!-- button_area -->
			            <div class="button_area">
			            	<div class="alignc">
			            	<c:if test="${apply.state == 'A'}">
		            		<a href="javascript:updateApply();" class="btn save2" title="수정완료">
		            			<span>수정완료</span>
		            		</a>
		            		</c:if>
		            		<a href="javascript:myApplyResult();" class="btn save2" title="취소">
		            			<span>취소</span>
		            		</a>
			            	</div>
			            </div>
			           	<!--// button_area -->
		           	</div>
		           	<!--// division40 -->
</form>		           	
 <jsp:include page="/WEB-INF/views/front/user/jusoSearchPopup.jsp"/>