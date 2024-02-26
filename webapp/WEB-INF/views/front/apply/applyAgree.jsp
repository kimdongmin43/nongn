<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" rel="stylesheet" />
<script src="/assets/jquery/jquery.ui.datepicker.js"></script>

<script>
var insertApplyUrl = "<c:url value='/front/apply/insertApplyInfo.do'/>";
var updateApplyUrl = "<c:url value='/front/apply/updateApplyInfo.do'/>"

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
	
});

var insertCheck = 0;
function insertApply(){
	   if(insertCheck == 1) return;
	   insertCheck = 1;
	   $("#insert_apply_btn").hide();
	   // 동의 체크 확인
	   if($("input:checkbox[id='agree_chk1']").is(":checked") == false){
		   alert("개인정보 수집이용에 동의를 해주십시요.");
			$("#insert_apply_btn").show();
			insertCheck = 0;
		   return;
	   }

	   if($("input:checkbox[id='agree_chk2']").is(":checked") == false){
		   alert("개인정보의 제3자 제공조회에 동의를 해주십시요.");
			$("#insert_apply_btn").show();
			insertCheck = 0;
		   return;
	   }
	   
	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){

			if($("#administ_cd").val().substring(0,2) != "11" ){
				alert("서울시 거주자만 청년수당 신청이 가능합니다.");
				//document.location.href = "/front/user/main.do";
				$("#insert_apply_btn").show();
   				insertCheck = 0;
				return;
			}
			
		   if($("#tel_2").val() != "" && $("#tel_3").val() != "" )
		   	  $("#hometel").val($("#tel_1").val()+"-"+$("#tel_2").val()+"-"+$("#tel_3").val());
		   
		   $("#mobile").val($("#mobile_1").val()+"-"+$("#mobile_2").val()+"-"+$("#mobile_3").val());
		   $("#email").val($("#email_1").val()+"@"+$("#email_2").val());
		   
		   url = insertApplyUrl;
		   if($("#aply_id").val() != "") url = updateApplyUrl; 

		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					if(responseText.success == "true"){
						$("#aply_id").val(responseText.aply_id);
						announceDocument();
					}else{	
						alert(responseText.message);
						$("#insert_apply_btn").show();
   					    insertCheck = 0;
					}
				},
				dataType: "json", 				
				url: url
		    });	
		   
	   }else{
		   $("#insert_apply_btn").show();
		   insertCheck = 0;
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

function announceInfo(){
	document.location.href = "/front/apply/announceInfo.do";
}

function announceDocument(){
	var f = document.writeFrm;
    f.action = "/front/apply/applyDocument.do";
    f.submit();
}  

function allCheck(){
	if($("input:checkbox[id='all_chk']").is(":checked") == false){
		$("input:checkbox[id='agree_chk1']").prop( "checked",false);
		$("input:checkbox[id='agree_chk2']").prop( "checked",false);
	}else{
		$("input:checkbox[id='agree_chk1']").prop( "checked",true);
		$("input:checkbox[id='agree_chk2']").prop( "checked",true);
   }	 
}

function folding(idx){
	if($("#agree_fold"+idx).attr("class") == "open"){
		$("#agree_fold"+idx).removeClass("open");
		$("#agree_fold"+idx).addClass("fold");
		$("#agree_fold"+idx).html("<span>약관접기</span>");
		$("#agree_term"+idx).show();
	}else{
		$("#agree_fold"+idx).removeClass("fold");
		$("#agree_fold"+idx).addClass("open");
		$("#agree_fold"+idx).html("<span>약관보기</span>");
		$("#agree_term"+idx).hide();
	}
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
 <form id="writeFrm" name="writeFrm" method="post" onSubmit="return false;" class="form-horizontal text-left" data-parsley-validate="true">
	<input type='hidden' id="user_gb" name='user_gb' value="N" />
	<input type='hidden' id="announc_id" name='announc_id' value="${apply.announc_id}" />
    <input type='hidden' id="aply_id" name='aply_id' value="${apply.aply_id}" />
    <input type='hidden' id="user_no" name='user_no' value="${apply.user_no}" />
    <input type='hidden' id="user_nm" name='user_nm' value="${apply.user_nm}" />
    <input type='hidden' id="email" name='email' value="${apply.email}" />
    <input type='hidden' id="birthday" name='birthday' value="${apply.birthday}" />
    <input type='hidden' id="mobile" name='mobile' value="${apply.mobile}" />
    <input type='hidden' id="hometel" name='hometel' value="${apply.hometel}" />
    <input type='hidden' id="administ_cd" name='administ_cd' value="${apply.administ_cd}" />
			    
			<!-- division40 -->
			<div class="division40">
				<!-- division50 -->
				<div class="division50">
					<!-- chapter_area -->
					<div class="chapter_area">
						<img src="/images/front/sub/chapter01.png" alt="1. 약관동의 및 신청자 정보" />
					</div>
					<!--// chapter_area -->
					<!-- division30 -->
					<div class="division30">
						<!-- terms_area -->
						<div class="terms_area">
							<!-- terms_box -->
							<div class="terms_box">
								<!-- terms_title -->
								<div class="terms_title">
									<div class="checks">
										<input type="checkbox" id="all_chk" name="all_chk" onClick="allCheck()" <c:if test="${apply.indinfo_agree == 'Y'}">checked</c:if> />
										<label for="all_chk">개인정보 수집&middot;이용 및 제3자 제공·조회 동의서에 모두 동의합니다.</label>
									</div>
								</div>
								<!--// terms_title -->
							</div>
							<!--// terms_box -->
							<!-- terms_box -->
							<div class="terms_box">
								<!-- terms_title -->
								<div class="terms_title">
									<div class="checks">
										<input type="checkbox" id="agree_chk1"  name="agree_chk1" value="Y" <c:if test="${apply.indinfo_agree == 'Y'}">checked</c:if> />
										<label for="agree_chk1">개인정보 수집&middot;이용 동의<span class="color_pointr">(필수)</span></label>
									</div>
									<a id="agree_fold1" href="javascript:folding(1)" class="open" title="약관접기">
										<span>약관보기</span>
									</a>
								</div>
								<!--// terms_title -->
								<!-- terms_contents -->
								<div id="agree_term1" class="terms_contents" style="display:none">
									<p><strong>개인정보의 수집&middot;이용 목적 :</strong> 상공회의소사업과 관련된 사무를 처리하기 위해 본인의 고유식별정보 등 개인정보를 수집 및 이용하는데 동의합니다</p>
									<p><strong>수집하는 개인정보의 항목 :</strong> 신청인의 국민건강보험공단 건강보험증 번호(부양자 가족 성명, 생년월일), 성명, 생년월일, 주소, 이메일 주소, 휴대폰 번호, 자택전화번호 등 연락처, 건강보험료, 미취업 기간 등</p>
									<p><strong>개인정보의 보유 및 이용기간 :</strong> 위 개인정보는 수집&middot;이용에 관한 동의일로부터 상공회의소사업 관련 업무 종료일까지 사업목적을 위하여 보유&middot;이용됩니다. 단, 지원 종료 후 관계법령 등의 규정에 의하여 기록&middot;보존되고, 기간이 경과할 경우 「개인정보보호법」 등에서 정하는 바에 따라 파기됩니다.</p>
									<p class="terms_important_txt">위 개인정보의 수집 및 이용에 관한 동의는 거부할 수 있으며, 다만 동의하지 않는 경우 상공회의소사업 지원 신청·선정·지급에 불이익을 받으실 수 있습니다.</p>
								</div>
								<!--// terms_contents -->
							</div>
							<!--// terms_box -->
							<!-- terms_box -->
							<div class="terms_box">
								<!-- terms_title -->
								<div class="terms_title">
									<div class="checks">
										<input type="checkbox" id="agree_chk2"  name="agree_chk2" value="Y" <c:if test="${apply.thirdparty_agree == 'Y'}">checked</c:if> />
										<label for="agree_chk2">개인정보의 제3자 제공&middot;조회 동의<span class="color_pointr">(필수)</span></label>
									</div>
									<a id="agree_fold2" href="javascript:folding(2)" class="open" title="약관보기">
										<span>약관보기</span>
									</a>
								</div>
								<!--// terms_title -->
								<!-- terms_contents -->
								<div id="agree_term2" class="terms_contents" style="display:none">
									<p><strong>개인정보를 제공받는 자 :</strong> 국민건강보험공단 및 상공회의소사업 민간위탁기관</p>
									<p><strong>개인정보를 제공받는 자의 이용 목적 :</strong> 건강보험료 부과내역 확인 및 상공회의소사업 대상자 관리 관련 정보 확인</p>
									<p><strong>제공하는 개인정보의 항목 :</strong> 국민건강보험공단 건강보험증 번호(부양자 가족 성명, 생년월일), 성명, 생년월일, (민간위탁기관) 신청인이 신청기관에 제공한 성명, 생년월일, 전화번호, 이메일주소, 건강보험료, 미취업 기간</p>
									<p><strong>제3자가 조회하는 개인정보의 항목 :</strong> 건강보험료 부과금액, 성명, 주소, 연락처, 이메일 등</p>
									<p><strong>개인정보를 제공받는 자의 개인정보 보유 및 이용 기간 :</strong>상공회의소사업 민간위탁기관은 상공회의소사업 외의 목적으로 개인정보를 이용 및 조회할 수 없으며 제공받은 개인정보는 제공 동의일로부터 상공회의소사업 지원 종료일까지 사업목적을 위하여 보유&middot;이용&middot;조회됩니다. 단, 지원 종료 후 관계법령 등의 규정에 의하여 기록&middot;보존되고, 기간이 경과할 경우 「개인정보보호법」 등에서 정하는 바에 따라 파기됩니다.</p>
									<p class="terms_important_txt">위 개인정보의 제3자 제공 및 조회에 관한 동의는 거부할 수 있으며, 다만 동의하지 않는 경우 상공회의소사업 지원 신청·선정·지급이 불가할 수 있음을 알려드립니다.</p>
								</div>
								<!--// terms_contents -->
							</div>
							<!--// terms_box -->
						</div>
						<!--// terms_area -->
						<!-- caution_area -->
						<div class="caution_area">
							<strong>주의사항</strong>
							<ul>
								<li>기타 지원사업 관련 문의사항은 신청 기관의 업무 담당자에게 문의하시기 바랍니다.</li>
							</ul>
						</div>
						<!--// caution_area -->
					</div>
					<!--// division30 -->
					<!-- division30 -->
					<div class="division30">
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
									<col style="width: 20%;">
									<col style="width: *;">
								</colgroup>
								<tbody>
								<tr>
									<th scope="row" class="first">
										<label for="input_name">이름</label>
									</th>
									<td class="first">
										${s_user_name}
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
											<input id="tel_2" name="tel_2" type="text" value="${apply.tel_2}" class="in_wp40 onlynum" maxlength="4"  data-parsley-required="false" data-parsley-errors-messages-disabled="true"  />
											-
											<label for="tel_3" class="hidden">전화 뒷자리</label>
											<input id="tel_3" name="tel_3" type="text" value="${apply.tel_3}" class="in_wp40 onlynum" maxlength="4"  data-parsley-required="false" />
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
											<input id="mobile_2" name="mobile_2" type="text" value="${apply.mobile_2}" class="in_wp40 onlynum"  data-parsley-required="true" data-parsley-errors-messages-disabled="true" maxlength="4" />
											-
											<label for="mobile_3" class="hidden">휴대전화 뒷자리</label>
											<input id="mobile_3" name="mobile_3" type="text" value="${apply.mobile_3}" class="in_wp40 onlynum"  data-parsley-required="true" maxlength="4" />
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
										<input id="email_2" name="email_2" type="text" value="${apply.email_2}" class="in_wp100" data-parsley-required="true" data-parsley-errors-container="#email_error_message" />
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
											<input id="basic_addr" name="basic_addr" type="text" value="${apply.basic_addr}" placeholder="기본주소"  class="in_w50" data-parsley-required="true" data-parsley-errors-messages-disabled="true"  readOnly />
											<label for="basic_addr" class="hidden">주민등록주소 상세주소1</label>
											<input id="detail_addr" name="detail_addr" type="text" value="${apply.detail_addr}" placeholder="상세주소" class="in_w50" data-parsley-required="true" data-parsley-maxlength="200" style="margin-top:5px;" />
											<label for="detail_addr" class="hidden">주민등록주소 상세주소2</label>
										</div>
										<p class="point_txt2">※ 서울시 거주지가 아니라는 메시지가 나올 시 주소찾기를 통해서 주소를 다시 입력해 주십시요.</p>
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
								<tr style="display:none">
									<th scope="row">
										<label for="health_gb">
											<strong class="color_pointr">*</strong>건강보험료		
										</label>   						
									</th>
									<td>
										<g:radio id="health_gb" name="health_gb" codeGroup="HEALTHINSUR_GUBUN" curValue="${apply.health_gb}"  />
										<label for="health_fee" class="hidden">건강보험료</label>
									    <input id="health_fee" name="health_fee" type="text" value="${apply.health_fee}" class="in_wp150 onlynum" data-parsley-required="false" data-parsley-maxlength="20"  data-parsley-errors-container="#health_error_message"  />
										<label>원</label>
										<div id="health_error_message"></div>
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
									<input type="text" id="retire_dt" name="retire_dt" class="in_wp100 datepicker" readonly value="${apply.retire_dt}" onChange="checkPriod()" />
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
					<!--// division30 -->
					<!-- button_area -->
					<div class="button_area">
		            	<div class="alignc">
		            		<a id="insert_apply_btn" href="javascript:insertApply()" class="btn save2" title="다음단계">
		            			<span>다음단계</span>
		            		</a>
		            		<a href="javascript:announceInfo()" class="btn save2" title="취소">
		            			<span>취소</span>
		            		</a>
		            	</div>
		            </div>
					<!--// button_area -->
	           	</div>
	           	<!--// division50 -->
           	</div>
           	<!--// division40 -->	
</form>
 <jsp:include page="/WEB-INF/views/front/user/jusoSearchPopup.jsp"/>