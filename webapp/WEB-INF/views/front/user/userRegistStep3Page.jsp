<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var userRegistUrl = "<c:url value='/front/user/userRegist.do'/>";
var userChkIdUrl = "<c:url value='/front/user/userChkId.do'/>";
var idchk = false;
var submitok = false;

function chkId(){
	
	var userid = $("#user_id").val();
	
	if(userid == ""){
		$("#id_txt").html("아이디를 입력하여야합니다.");
		return false;
	}
	
	if(userid.length < 5 || userid.length > 15){
		$("#id_txt").html("※ 최소 5자 ~ 최대 15자");
		return false;
	}
	
	if(!check(userid)){
		return false;
	}else{
		$.ajax({
	        url: userChkIdUrl,
	        dataType: "json",
	        type: "post",
	        data: {
	        	user_id : $("#user_id").val()
			},
	        success: function(data) {
	        	$("#id_txt").html(data.message);
	        	if(data.success == "true"){
	        		idchk = true;
	        	}else{
	        		idchk = false;
	        	}
	        }
	    });
	}
	
}

/**
* 아이디체크(공백, 특수문자 제외)
**/
function check(str){
	//공백 금지
	var blank_pattern = /[\s]/g;
	var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;

	if( blank_pattern.test( str) == true){
	    $("#id_txt").html("공백은 사용할 수 없습니다.");
	    return false;
	}

	if( special_pattern.test(str) == true ){
	    $("#id_txt").html("특수문자는 사용할 수 없습니다.");
	    return false;
	}
	
	return true;
}

function jsSave(){
	var f = document.writeFrm;
	
	if($("#birth_year").val() == ""  || $("#birth_mm").val() == "" || $("#birth_dd").val() == ""){
		alert("생년월일을 입력하여야합니다.");
		return false;
	}else{
		$("#birth").val($("#birth_year").val()+$("#birth_mm").val()+$("#birth_dd").val());
		// 만14세 미만 가입 불가
		if(getAge($("#birth").val()) < 14){
			alert("14세 이상만 회원가입 가능합니다.");
			document.location.href = "/front/user/main.do";
			return false;
		}
	}
	
	if($("#user_id").val() == ""){
		$("#id_txt").html("아이디를 입력하여야합니다.");
		return false;
	}
	
	if(!idchk){
		$("#id_txt").html("아이디가 중복되었거나 중복확인을 하지 않았습니다.");
		return false;
	}

	if(!checkPassword_info($("#user_pw").val())){
		return false;
	}

	if($("#mobile_1").val() == "" || $("#mobile_2").val() == "" || $("#mobile_3").val() == ""){
		alert("휴대전화는 필수 입력사항입니다.");
		return;
	}else{
		$("#user_mobile").val($("#mobile_1").val()+"-"+$("#mobile_2").val()+"-"+$("#mobile_3").val());
	}

	if($("#email_1").val() != "" && $("#email_2").val() != ""){
		$("#user_email").val($("#email_1").val()+"@"+$("#email_2").val());
	}

	if($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != ""){
		$("#user_tel").val($("#tel_1").val()+"-"+$("#tel_2").val()+"-"+$("#tel_3").val());
	}
	
	if ( $("#writeFrm").parsley().validate() ){
		if(submitok){
			alert("처리중입니다.");
			return false;
		}else{
			submitok = true;
			// 데이터를 등록 처리해준다.
			 $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					if(responseText.success == "true"){
						$("#user_no").val(responseText.user_no);
					    f.action = "/front/user/userRegistStep4Page.do";
					    f.submit();
					}else{	
						alert(responseText.message);
					}
				},
				dataType: "json",
				url: userRegistUrl
			});	
		}
		 
	}
}

function checkPassword_info(p_pwd){
	var chk_pwd = p_pwd;
	var chk_num = chk_pwd.search(/[0-9]/g);
	var chk_eng = chk_pwd.search(/[a-z]/ig);
	var sp_filter =  /[~!@\#$*\()\=_|]/gi;
	var chk_spc = chk_pwd.search(sp_filter);
	var blank_filter = /[\s]/g;
	var cnt = 0;

	var chk_sp  =  sp_filter.test(chk_pwd);
    
	//비밀번호 일치여부 체크
	if(chk_pwd != $("#user_pw_confirm").val()){
		$("#id_txt").html("비밀번호를 다시 확인해 주시기 바랍니다.");
		return false;
	}
  	
	// 조합 체크
	if(chk_num != -1) cnt++;
	if(chk_eng != -1) cnt++;
	if(chk_spc != -1) cnt++;

	if(cnt < 2){
		$("#id_txt").html("영문소문자와 대문자, 숫자,특수문자 중 2가지 이상 문자 조합하여 사용 가능합니다.");
		return false;
	}
  	
	// 공백 체크
	if(blank_filter.test(chk_pwd)){
		$("#id_txt").html("비밀번호는 공백을 사용할 수 없습니다.");
		return false;
	}

	return true;
}

function changeEmailDomain(){
	$("#email_2").val($("#email_domain").val());
}

function setAddr(roadAddr,jibunAddr,zipNo,admCd){
	$("#post").val(zipNo);
	$("#addr1").val(roadAddr);
	$("#addr2").val("");
	$("#administ_cd").val(admCd);
	$("#addr2").focus();
}

</script>

 <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true" onsubmit="return false;">
 	<input type='hidden' id="user_mobile" name='user_mobile' value="" />
 	<input type='hidden' id="user_email" name='user_email' value="" />
 	<input type='hidden' id="user_tel" name='user_tel' value="" />
 	<input type='hidden' id="user_no" name='user_no' value="" />
 	<input type='hidden' id="administ_cd" name='administ_cd' value="" />
 	<input type='hidden' id="birth" name='birth' value="" />
 	
<!-- division40 -->
<div class="division40">
	<!-- division60 -->
	<div class="division60">
		<!-- chapter_area -->
		<div class="chapter_area">
			<img src="/images/front/sub/member_chapter03.png" alt="3. 회원정보입력" />
		</div>
		<!--// chapter_area -->
		
		<!-- division30 -->
		<div class="division30">
			<!-- table_area -->
			<div class="table_area">
				<table class="write fixed">
					<caption>회원 정보 등록 화면</caption>
					<colgroup>
						<col style="width: 140px;">
						<col style="width: *;">
					</colgroup>
					<tbody>
					<tr>
						<th scope="row" class="first"><strong class="color_pointr">*</strong>이름</th>
						<td class="first">${param.civil_name}
							<input type='hidden' id="user_nm" name='user_nm' value="${param.civil_name}" />
						</td>
					</tr>
					<tr>
						<th scope="row"><strong class="color_pointr">*</strong>생년월일(성별)</th>
						<td>
							<label for="birth_year" class="hidden">년도 선택</label>
							<select class="in_wp100 m_marginb5" id="birth_year" name="birth_year" data-parsley-required="true" data-parsley-errors-messages-disabled="true" data-parsley-errors-container="#birth_error_message">
			                      <c:forEach var="i" begin="0" end="90" >
			                         <option value="${curYear-i}">${curYear-i}</option>
			                     </c:forEach>
							</select>
							<label for="birth_mm" class="hidden">월 선택</label>
							<select class="in_wp100 m_marginb5" id="birth_mm" name="birth_mm" data-parsley-required="true" data-parsley-errors-messages-disabled="true">
								 <c:forEach var="i" begin="1" end="12">
								      <c:set var="mm" value="${i}"/>
								      <c:if test="${i < 10}"><c:set var="mm" value="0${i}"/></c:if>
			                         <option value="${mm}">${mm}</option>
			                     </c:forEach>
							</select>
							<label for="birth_dd" class="hidden">일 선택</label>
							<select class="in_wp100 m_marginb5" id="birth_dd" name="birth_dd" data-parsley-required="true">
								 <c:forEach var="i" begin="1" end="31">
								      <c:set var="dd" value="${i}"/>
								      <c:if test="${i < 10}"><c:set var="dd" value="0${i}"/></c:if>
			                         <option value="${dd}">${dd}</option>
			                     </c:forEach>
			                </select>
			                
			                (<input name="gender" id="genderM" value="M" type="radio" checked />
							<label for="genderM">남</label>
							<input name="gender" id="genderF" value="F" type="radio" />
							<label for="genderF">여</label>)
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="user_id"><strong class="color_pointr">*</strong>아이디</label>
						</th>
						<td>
							<input type="text" class="m_in_w2030" id="user_id" name="user_id" data-parsley-required="true" data-parsley-minlength="5" data-parsley-maxlength="15" data-parsley-errors-container="#id_txt" />
							<button class="btn s_save_btn" title="중복확인" onclick="chkId();">
								<span>중복확인</span>
							</button>
							<span class="point_txt" id="id_txt"></span>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="user_pw"><strong class="color_pointr">*</strong>비밀번호</label>
						</th>
						<td>
							<input type="password" class="m_in_w2030" id="user_pw" name="user_pw" data-parsley-required="true" data-parsley-minlength="10" data-parsley-maxlength="15" title="비밀번호" />												
							<div class="margint5">
								<p class="point_txt1" id="pwtxt">※ 10~15자 이상  영문소문자와 대문자, 숫자,특수문자 중 2가지 이상 문자 조합하여 사용 가능합니다.<br/>
								※ 특수문자는 `~`,`!`,`@`,`#`,`$`,`*`,`(`,`)`,`=`,`_`,`.`,`|` 만 사용 가능합니다. </p>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="user_pw_confirm"><strong class="color_pointr">*</strong>비밀번호 확인</label>
						</th>
						<td>
							<input type="password" class="m_in_w2030" id="user_pw_confirm" data-parsley-required="true" data-parsley-minlength="10" data-parsley-maxlength="15" title="비밀번호 확인" />
						</td>
					</tr>
					<tr>
						<th scope="row">자택전화</th>
						<td>
							<div class="m_phone_area">
								<label for="tel_1" class="hidden">전화 앞번호</label>
								<select id='tel_1' name='tel_1' title='자택전화 첫번째자리' class="in_wp70">
                             	    <option value=''>- 선택 -</option>
								    <option value='02' selected>02</option>
									<option value='051'>051</option>
									<option value='053'>053</option>
									<option value='032'>032</option>
									<option value='062'>062</option>
									<option value='042'>042</option>
									<option value='052'>052</option>
									<option value='044'>044</option>
									<option value='031'>031</option>
									<option value='033'>033</option>
									<option value='043'>043</option>
									<option value='041'>041</option>
									<option value='063'>063</option>
									<option value='061'>061</option>
									<option value='054'>054</option>
									<option value='055'>055</option>
									<option value='064'>064</option>
									<option value='070'>070</option>
                          		 </select>
								-
								<label for="tel_2" class="hidden">전화 중간자리</label>
								<input type="text" class="in_wp80" id="tel_2" name="tel_2" />
								-
								<label for="tel_3" class="hidden">전화 뒷자리</label>
								<input type="text" class="in_wp80" id="tel_3" name="tel_3" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<strong class="color_pointr">*</strong>휴대전화
						</th>
						<td>
							<div class="m_phone_area">
								<c:set var="sms_number" value="${param.sms_number }" />
								
								<c:if test="${fn:length(sms_number) == 10 }">
									<c:set var="mobile_1" value="${fn:substring(sms_number, 0,3) }" />
									<c:set var="mobile_2" value="${fn:substring(sms_number, 3,6) }" />
									<c:set var="mobile_3" value="${fn:substring(sms_number, 6,10) }" />
								</c:if>
								<c:if test="${fn:length(sms_number) == 11 }">
									<c:set var="mobile_1" value="${fn:substring(sms_number, 0,3) }" />
									<c:set var="mobile_2" value="${fn:substring(sms_number, 3,7) }" />
									<c:set var="mobile_3" value="${fn:substring(sms_number, 7,11) }" />
								</c:if>
								
								<input type="hidden" class="in_wp80" id="mobile_1" name="mobile_1" value="${mobile_1 }">${mobile_1 }
								-
								<input type="hidden" class="in_wp80" id="mobile_2" name="mobile_2" value="${mobile_2 }">${mobile_2 }
								-
								<input type="hidden" class="in_wp80" id="mobile_3" name="mobile_3" value="${mobile_3 }">${mobile_3 }
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td>
							<label for="email_1" class="hidden">이메일 앞주소</label>
							<input type="text" class="in_wp80 m_marginb5" id="email_1" name="email_1" />
							<span>@</span>
							<label for="email_2" class="hidden">이메일 뒷주소</label>
							<input type="text" class="in_wp80 m_marginb5" id="email_2" name="email_2" />
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
						</td>
					</tr>
					<tr>
						<th scope="row">주민등록주소</th>
						<td>
							<div class="address_area">
								<input type="text" class="in_address1" id="post" name="post"/>
								<label for="post" class="hidden">주민등록주소</label>
								<button class="btn s_save_btn" title="주소찾기" onclick="jusoPopupShow();;">
									<span>주소찾기</span>
								</button>
							</div>
							<div class="address_area">
								<input type="text" class="in_address2" id="addr1" name="addr1" readOnly />
								<label for="addr1" class="hidden">주민등록주소 상세주소1</label>
								<input type="text" class="in_address2" id="addr2" name="addr2" />
								<label for="addr2" class="hidden">주민등록주소 상세주소2</label>
							</div>
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
           		<button class="btn save2" title="회원가입완료" onclick="jsSave()">
           			<span>회원가입완료</span>
				</button>
			</div>
		</div>
		<!--// button_area -->
	</div>
	<!--// division60 -->
</div>
<!--// division40 -->
</form>
 <jsp:include page="/WEB-INF/views/front/user/jusoSearchPopup.jsp"/>