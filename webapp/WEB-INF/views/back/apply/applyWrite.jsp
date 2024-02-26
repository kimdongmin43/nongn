<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script>

$(document).ready(function(){
	$(".onlynum").keyup( setNumberOnly );
	
	actplanCnt =1;
	programCnt =1;
	
    $.ajax({
        url: "/back/actplan/applyActplanList.do",
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
        url: "/back/actplan/applyWishprogList.do",
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

function setAddr(roadAddr,jibunAddr,zipNo,admCd){
	$("#postno").val(zipNo);
	$("#basic_addr").val(roadAddr);
	$("#detail_addr").val("");
	$("#administ_cd").val(admCd);
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

<form id="writeFrm" name="writeFrm" method="post"  data-parsley-validate="true" enctype="multipart/form-data">
<input type='hidden' id="aply_id" name='aply_id' value="${apply.aply_id}" />
<input type="hidden" id="id_file_id" name="id_file_id" value="${apply.id_file_id}" />
<input type="hidden" id="health_file_id" name="health_file_id" value="${apply.health_file_id}" />
<input type="hidden" id="unemplyinsur_file_id" name="unemplyinsur_file_id" value="${apply.unemplyinsur_file_id}" />
<input type="hidden" id="deploma_file_id" name=deploma_file_id value="${apply.deploma_file_id}" />
<input type="hidden" id="email" name="email" value="${apply.email}" />
<input type="hidden" id="mobile" name="mobile" value="${apply.mobile}" />
<input type="hidden" id="hometel" name="hometel" value="${apply.hometel}" />

            <div id="printArea">
				<!-- title_area -->
					<div class="title_area">
						<h2 class="pop_title">신청자 정보</h2>
					</div>
					<!--// title_area -->
					<!-- table_area -->
					<div class="table_area">
					
						<table class="write">
							<caption>신청자 정보 등록 화면</caption>
							<colgroup>
								<col style="width: 150px;">
								<col style="width: *;">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">이름</th>
								<td>${apply.user_nm}</td>
							</tr>
							<tr>
								<th scope="row">생년월일</th>
								<td> ${apply.birth_year}년 ${apply.birth_mm}월 ${apply.birth_dd}일 (${apply.gender_nm})</td>
							</tr>
							<tr>
								<th scope="row">자택전화</th>
								<td>
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
									<span>-</span>
									<input id="tel_2" name="tel_2" type="text" value="${apply.tel_2}" class="in_wp40 onlynum" maxlength="4" data-parsley-required="false" data-parsley-errors-messages-disabled="true"  />
									<label for="tel_2" class="hidden">자택전화 중간번호</label>
									<span>-</span>
									<input id="tel_3" name="tel_3" type="text" value="${apply.tel_3}" class="in_wp40 onlynum" maxlength="4" data-parsley-required="false" />
									<label for="tel_3" class="hidden">자택전화 뒷번호</label>
								</td>
							</tr>
							<tr>
								<th scope="row">휴대전화<strong class="color_pointr">*</strong></th>
								<td>
								    <select id='mobile_1' name='mobile_1' title='휴대폰번호 첫번째자리' class="in_wp70">
											<option value='010' <c:if test="${apply.mobile_1 == '010'}">selected</c:if>>010</option>
											<option value='011' <c:if test="${apply.mobile_1 == '011'}">selected</c:if>>011</option>
											<option value='016' <c:if test="${apply.mobile_1 == '016'}">selected</c:if>>016</option>
											<option value='017' <c:if test="${apply.mobile_1 == '017'}">selected</c:if>>017</option>
											<option value='018' <c:if test="${apply.mobile_1 == '018'}">selected</c:if>>018</option>
											<option value='019' <c:if test="${apply.mobile_1 == '019'}">selected</c:if>>019</option>
								    </select>
								    <label for="mobile_1" class="hidden">휴대폰번호 첫번째자리</label>
									<span>-</span>
									<input id="mobile_2" name="mobile_2" type="text" value="${apply.mobile_2}" class="in_wp40 onlynum" maxlength="4" data-parsley-required="true" data-parsley-errors-messages-disabled="true" />
									<label for="mobile_2" class="hidden">휴대전화 중간번호</label>
									<span>-</span>
									<input id="mobile_3" name="mobile_3" type="text" value="${apply.mobile_3}" class="in_wp40 onlynum" maxlength="4"  data-parsley-required="true" />
									<label for="mobile_3" class="hidden">휴대전화 뒷번호</label>
								</td>
							</tr>
							<tr>
								<th scope="row">이메일<strong class="color_pointr">*</strong></th>
								<td>
									<input id="email_1" name="email_1" type="text" value="${apply.email_1}" class="in_wp80" data-parsley-required="true" data-parsley-errors-messages-disabled="true"  />
									<label for="email_1" class="hidden">이메일 앞주소</label>
									<span>@</span>
									<input id="email_2" name="email_2" type="text" value="${apply.email_2}" class="in_wp100" data-parsley-required="true" data-parsley-errors-container="#email_error_message" />
									<label for="email_2" class="hidden">이메일 뒷주소</label>
									<label for="email_domain" class="hidden">이메일 뒷주소 선택</label>
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
								<th scope="row">주민등록주소<strong class="color_pointr">*</strong></th>
								<td>
									<div class="marginb10">
										<label for="postno" class="hidden">우편번호</label>
										<input id="postno" name="postno" type="text" value="${apply.postno}" placeholder="우편번호" class="in_wp70"  readOnly />
										<a href="javascript:jusoPopupShow();"  class="btn active" title="주소찾기 하기">
											<span>주소찾기</span>
										</a>
									</div>
									<div class="marginb10">
										<label for="basic_addr" class="hidden">기본주소입력</label>
										<input id="basic_addr" name="basic_addr" type="text" value="${apply.basic_addr}" placeholder="기본주소"  class="in_w50" readOnly  data-parsley-required="true" data-parsley-errors-messages-disabled="true"  />
									</div>
									<div>
										<label for="detail_addr" class="hidden">상세주소입력</label>
										<input id="detail_addr" name="detail_addr" type="text" value="${apply.detail_addr}" placeholder="상세주소" class="in_w50" data-parsley-required="true" data-parsley-maxlength="200" />
									</div>								
									<input id="administ_cd" name="administ_cd" type="hidden" value="${apply.administ_cd}"  />
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="residence_period">
										전입일(주민등록기준)<strong class="color_pointr">*</strong>
									</label>
								</th>
								<td>
                                         <input type="hidden" id="seoul_live_priod" name="seoul_live_priod" value="${apply.seoul_live_priod}" />
	   								    <input type="text" id="seoul_live_dt" name="seoul_live_dt" class="in_wp100 datepicker" readonly value="${apply.seoul_live_dt}" data-parsley-required="true" data-parsley-errors-container="#seoullivedt_error_message" onChange="checkSeoullivePriod()" />
	   								    <div id="seoullivedt_error_message"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="health_insurance">
										건강보험증번호<strong class="color_pointr">*</strong>
									</label>
								</th>
								<td>
									<input id="health_no" name="health_no" type="text" value="${apply.health_no}" class="in_wp150 onlynum" maxlength="11" data-parsley-required="true" data-parsley-maxlength="20" />
								</td>
							</tr>
							<tr style="display:none;">
								<th scope="row">건강보험료<strong class="color_pointr">*</strong></th>
								<td>
									<g:radio id="health_gb" name="health_gb" codeGroup="HEALTHINSUR_GUBUN" curValue="${apply.health_gb}"  />
									<label for="health_fee" class="hidden">건강보험료</label>
									<input id="health_fee" name="health_fee" type="text" value="${apply.health_fee}" class="in_wp150 onlynum" data-parsley-required="true" data-parsley-maxlength="20"  data-parsley-errors-container="#health_error_message"  />
									<span>원</span>
									<div id="health_error_message"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">최종학력 졸업일자<strong class="color_pointr">*</strong></th>
								<td>
								    <g:select id="last_ability" name="last_ability"  codeGroup="LAST_ABILITY" cls="in_wp100" selected="${apply.last_ability}" />
									<label for="college_grad_dt" class="hidden">최종학력 졸업일자</label>
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
									<label for="get_job">
										최근 미취업기간
									</label>
								</th>
								<td>
									<input id="unemploy_priod" name="unemploy_priod" type="text" value="${apply.unemploy_priod}" class="in_wp50 onlynum" style="background-color:lightgray" readOnly/> 개월					
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="family_num">
										배우자 및 자녀 수<strong class="color_pointr">*</strong>
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
								<th scope="row">기초생활수급자 여부<strong class="color_pointr">*</strong></th>
								<td>
                                     <input type="radio" name="reserver_yn" value="Y" <c:if test="${apply.reserver_yn == 'Y'}">checked</c:if>> 사용 <input type="radio" name="reserver_yn" value="N"  <c:if test="${apply.reserver_yn == 'N'}">checked</c:if>> 미사용
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<!--// table_area -->		
					
					<!-- title_area -->
					<div class="title_area">
						<h2 class="pop_title">신청 시 구비서류</h2>
					</div>
					<!--// title_area -->
					
					<!-- table_area -->
					<div class="table_area">
						<table class="write">
							<caption>등록 화면</caption>
							<colgroup>
								<col style="width: 150px;">
								<col style="width: *;">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">주민등록등본<strong class="color_pointr">*</strong></th>
								<td>
									<div class="file_area">
									  <c:if test="${!empty apply.id_file_id}">
				                      <p id="upFile1"><a href="/commonfile/fileidDownLoad.do?file_id=${apply.id_file_id}" >${apply.id_file_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('1')"></a></p>
				                      </c:if>
										<label for="uploadFile1" class="hidden">파일 선택하기</label>
				                       <input class="in_wp400 marginb10" type="file" id="uploadFile1" name="uploadFile1" value="" />
										<p class="color_point marginb5">※ 과거의 주소변동(이력) 사항 포함</p>
										<p class="color_point">※ 주민번호 뒷자리 6자리는 가려서 제출</p>
									</div>
								</td>
							</tr>
							<input type="hidden" id="uploadFile2" name="uploadFile2" />
							<tr>
								<th scope="row">고용보험 피보험자격 내역서(피보험자용)<strong class="color_pointr">*</strong></th>
								<td>
									<div class="file_area">
									  <c:if test="${!empty apply.unemplyinsur_file_id}">
				                      <p id="upFile3"><a href="/commonfile/fileidDownLoad.do?file_id=${apply.unemplyinsur_file_id}" >${apply.unemplyinsur_file_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('3')"></a></p>
				                      </c:if>
										<label for="uploadFile3" class="hidden">파일 선택하기</label>
				                       <input class="in_wp400 marginb10" type="file" id="uploadFile3" name="uploadFile3" value="" />
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">최종학력 졸업증명서 또는 졸업예정증명서<strong class="color_pointr">*</strong></th>
								<td>
									<div class="file_area">
									  <c:if test="${!empty apply.deploma_file_id}">
				                      <p id="upFile4"><a href="/commonfile/fileidDownLoad.do?file_id=${apply.deploma_file_id}" >${apply.deploma_file_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('4')"></a></p>
				                      </c:if>
										<label for="uploadFile4" class="hidden">파일 선택하기</label>
				                       <input class="in_wp400 marginb10" type="file" id="uploadFile4" name="uploadFile4" value="" />
									</div>
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<!--// table_area -->
					
					<!-- title_area -->
					<div class="title_area">
						<h2 class="pop_title">활동계획서</h2>
					</div>
					<!--// title_area -->
					
					<!-- contents_table -->
					<div class="contents_table">
						<!-- contents_title -->
						<div class="contents_title">
							<strong>활동목표</strong> <strong style="color:red;">(필수)</strong>
							<div class="contents_title_btn_area">
								<a href="javascript:addActivetarget('','');" class="plus_btn" title="활동목표 더하기 버튼">
									<img src="/images/back/common/btn_plus.png" alt="더하기 버튼" />
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
									<img src="/images/back/common/btn_plus.png" alt="더하기 버튼" />
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
											<strong><label for="aply_motiv">지원동기</label></strong>
										</div>
										<div class="body_area">
											<textarea cols="5" rows="10" id="aply_motiv" name="aply_motiv" class="in_w100" data-parsley-required="true" data-parsley-maxlength="4000" >${apply.aply_motiv}</textarea>
										</div>
									</div>
								</li>
								<li>
									<div class="list_row">
										<div class="head_area">
											<strong><label for="activ_plan">월별활동계획</label></strong>
										</div>
										<div class="body_area">
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
					<!-- button_area -->
					<div class="button_area">
						<div class="float_left">
							<a href="javascript:applyPrint();" class="btn list" title="인쇄하기">
								<span>인쇄</span>
							</a>
						</div>
						
						<div class="alignc">
							<a href="javascript:applyInsert();" class="btn save" title="저장하기">
								<span>저장</span>
							</a>
							<a href="javascript:popupClose();"  class="btn cancel" title="취소하기">
								<span>취소</span>
							</a>
						</div>
					</div>
					<!--// button_area -->
</form>					

