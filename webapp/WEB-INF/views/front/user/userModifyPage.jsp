<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var userModifyUrl = "<c:url value='/front/user/userModify.do'/>";
var userDropOutUrl = "<c:url value='/front/user/userDropOutPage.do'/>";

function dropout(){
	window.open(userDropOutUrl, 'dropOutPop', 'width=700,height=535,top=100,left=100');
}

function cancel(){
	document.location.href = "/front/user/main.do";
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

function jsSave(){
	
	$("#user_mobile").val($("#mobile_1").val()+"-"+$("#mobile_2").val()+"-"+$("#mobile_3").val());
	
	if($("#email_1").val() != "" && $("#email_2").val() != ""){
		$("#user_email").val($("#email_1").val()+"@"+$("#email_2").val());
	}
	
	if($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != ""){
		$("#user_tel").val($("#tel_1").val()+"-"+$("#tel_2").val()+"-"+$("#tel_3").val());
	}
	
	if ( $("#writeFrm").parsley().validate() ){
		 // 데이터를 등록 처리해준다.
		 $("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
				if(responseText.success == "true"){
					alert(responseText.message);
					cancel();
				}else{	
					alert(responseText.message);
				}
			},
			dataType: "json", 				
			url: userModifyUrl
		});	
	}
	
}

</script>

 <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true" onsubmit="return false;">
 	<input type='hidden' id="user_mobile" name='user_mobile' value="" />
 	<input type='hidden' id="user_email" name='user_email' value="" />
 	<input type='hidden' id="user_tel" name='user_tel' value="" />
 	<input type='hidden' id="administ_cd" name='administ_cd' value="" />
 	<input type='hidden' id="user_no" name='user_no' value="" />

<!-- division40 -->
<div class="division40">
	<!-- division60 -->
	<div class="division60">
		
		<!-- division30 -->
		<div class="division30">
			<!-- table_area -->
			<div class="table_area">
				<table class="write fixed">
					<caption>회원 정보 수정 화면</caption>
					<colgroup>
						<col style="width: 140px;">
						<col style="width: *;">
					</colgroup>
					<tbody>
					<tr>
						<th scope="row" class="first"><strong class="color_pointr">*</strong>이름</th>
						<td class="first">${user.user_nm }</td>
					</tr>
					<tr>
						<th scope="row"><strong class="color_pointr">*</strong>생년월일(성별)</th>
						<td>
							<c:set var="year" value="" />
							<c:set var="month" value="" />
							<c:set var="day" value="" />
							<c:if test="${not empty user.birth }">
								<c:set var="year" value="${fn:substring(user.birth, 0,4) }" />
								<c:set var="month" value="${fn:substring(user.birth, 4,6) }" />
								<c:set var="day" value="${fn:substring(user.birth, 6,8) }" />
							</c:if>
							${year }년 ${month }월 ${day }일(${user.gender_nm })
						</td>
					</tr>
					<tr>
						<th scope="row">
							<strong class="color_pointr">*</strong>아이디
						</th>
						<td>${user.user_id }</td>
					</tr>
					<tr>
						<th scope="row">
							<strong class="color_pointr">*</strong>비밀번호
						</th>
						<td>
							<button class="btn s_save_btn" title="비밀번호 변경" onclick="pwPopupShow();">
								<span>비밀번호 변경</span>
							</button>
						</td>
					</tr>
					<tr>
						<th scope="row">자택전화</th>
						<td>
							<div class="m_phone_area">
								<c:set var="tel1" value="02" />
								<c:set var="tel2" value="" />
								<c:set var="tel3" value="" />
								<c:if test="${not empty user.user_tel }">
									<c:set var="tel" value="${user.user_tel }" />
									<c:set var="tel_split" value="${fn:split(tel, '-')}" />
									<c:forEach var="t1" items="${tel_split }" varStatus="s">
										<c:if test="${s.count == 1 }"><c:set var="tel1" value="${t1 }" /></c:if>
										<c:if test="${s.count == 2 }"><c:set var="tel2" value="${t1 }" /></c:if>
										<c:if test="${s.count == 3 }"><c:set var="tel3" value="${t1 }" /></c:if>
									</c:forEach>
								</c:if>
								<label for="tel_1" class="hidden">전화 앞번호</label>
								<select id='tel_1' name='tel_1' title='자택전화 첫번째자리' class="in_wp70">
								    <option value='02' <c:if test="${tel1 eq '02' }" >selected</c:if>>02</option>
									<option value='051' <c:if test="${tel1 eq '051' }" >selected</c:if>>051</option>
									<option value='053' <c:if test="${tel1 eq '053' }" >selected</c:if>>053</option>
									<option value='032' <c:if test="${tel1 eq '032' }" >selected</c:if>>032</option>
									<option value='062' <c:if test="${tel1 eq '062' }" >selected</c:if>>062</option>
									<option value='042' <c:if test="${tel1 eq '042' }" >selected</c:if>>042</option>
									<option value='052' <c:if test="${tel1 eq '052' }" >selected</c:if>>052</option>
									<option value='044' <c:if test="${tel1 eq '044' }" >selected</c:if>>044</option>
									<option value='031' <c:if test="${tel1 eq '031' }" >selected</c:if>>031</option>
									<option value='033' <c:if test="${tel1 eq '033' }" >selected</c:if>>033</option>
									<option value='043' <c:if test="${tel1 eq '043' }" >selected</c:if>>043</option>
									<option value='041' <c:if test="${tel1 eq '041' }" >selected</c:if>>041</option>
									<option value='063' <c:if test="${tel2 eq '063' }" >selected</c:if>>063</option>
									<option value='061' <c:if test="${tel2 eq '061' }" >selected</c:if>>061</option>
									<option value='054' <c:if test="${tel2 eq '054' }" >selected</c:if>>054</option>
									<option value='055' <c:if test="${tel2 eq '055' }" >selected</c:if>>055</option>
									<option value='064' <c:if test="${tel2 eq '064' }" >selected</c:if>>064</option>
									<option value='070' <c:if test="${tel2 eq '070' }" >selected</c:if>>070</option>
                          		 </select>
								-
								<label for="tel_2" class="hidden">전화 중간자리</label>
								<input type="text" class="in_wp80" id="tel_2" name="tel_2" value="${tel2 }" />
								-
								<label for="tel_3" class="hidden">전화 뒷자리</label>
								<input type="text" class="in_wp80" id="tel_3" name="tel_3" value="${tel3 }" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<strong class="color_pointr">*</strong>휴대전화
						</th>
						<td>
							<div class="m_phone_area">
								<c:set var="phone1" value="010" />
								<c:set var="phone2" value="" />
								<c:set var="phone3" value="" />
								<c:if test="${not empty user.user_mobile }">
									<c:set var="phone" value="${user.user_mobile }" />
									<c:set var="phone_split" value="${fn:split(phone, '-')}" />
									<c:forEach var="p1" items="${phone_split }" varStatus="s">
										<c:if test="${s.count == 1 }"><c:set var="phone1" value="${p1 }" /></c:if>
										<c:if test="${s.count == 2 }"><c:set var="phone2" value="${p1 }" /></c:if>
										<c:if test="${s.count == 3 }"><c:set var="phone3" value="${p1 }" /></c:if>
									</c:forEach>
								</c:if>
							
								<label for="mobile_1" class="hidden">휴대전화 앞번호</label>
								<select id='mobile_1' name='mobile_1' title='휴대폰번호 첫번째자리' class="in_wp70" data-parsley-required="true" >
									<option value="010" <c:if test="${phone1 eq '010' }" >selected</c:if>>010</option>							
									<option value="011" <c:if test="${phone1 eq '011' }" >selected</c:if>>011</option>
									<option value="016" <c:if test="${phone1 eq '016' }" >selected</c:if>>016</option>
									<option value="017" <c:if test="${phone1 eq '017' }" >selected</c:if>>017</option>
									<option value="018" <c:if test="${phone1 eq '018' }" >selected</c:if>>018</option>
									<option value="019" <c:if test="${phone1 eq '019' }" >selected</c:if>>019</option>
							    </select>
								-
								<label for="mobile_2" class="hidden">휴대전화 중간자리</label>
								<input type="text" class="in_wp80" id="mobile_2" name="mobile_2" value="${phone2 }" maxlength="4" data-parsley-required="true" data-parsley-maxlength="4" data-parsley-errors-messages-disabled="true" />
								-
								<label for="mobile_3" class="hidden">휴대전화 뒷자리</label>
								<input type="text" class="in_wp80" id="mobile_3" name="mobile_3" value="${phone3 }" maxlength="4" data-parsley-required="true" data-parsley-maxlength="4" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td>
							<c:set var="email1" value="" />
							<c:set var="email2" value="" />
							<c:if test="${not empty user.user_email }">
								<c:set var="email" value="${user.user_email }" />
								<c:set var="email_split" value="${fn:split(email, '@')}" />
								<c:forEach var="e1" items="${email_split }" varStatus="s">
									<c:if test="${s.count == 1 }"><c:set var="email1" value="${e1 }" /></c:if>
									<c:if test="${s.count == 2 }"><c:set var="email2" value="${e1 }" /></c:if>
								</c:forEach>
							</c:if>
						
							<label for="email_1" class="hidden">이메일 앞주소</label>
							<input type="text" class="in_wp80 m_marginb5" id="email_1" name="email_1" value="${email1 }" />
							<span>@</span>
							<label for="email_2" class="hidden">이메일 뒷주소</label>
							<input type="text" class="in_wp80 m_marginb5" id="email_2" name="email_2" value="${email2 }" />
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
								<input type="text" class="in_address1" id="post" name="post" value="${user.post }" />
								<label for="post" class="hidden">주민등록주소</label>
								<button class="btn s_save_btn" title="주소찾기" onclick="jusoPopupShow();">
									<span>주소찾기</span>
								</button>
							</div>
							<div class="address_area">
								<input type="text" class="in_address2" id="addr1" name="addr1" value="${user.addr1 }" data-parsley-maxlength="200" readOnly />
								<label for="addr1" class="hidden">주민등록주소 상세주소1</label>
								<input type="text" class="in_address2" id="addr2" name="addr2" value="${user.addr2 }" data-parsley-maxlength="200" />
								<label for="addr2" class="hidden">주민등록주소 상세주소2</label>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">약관 동의일</th>
						<td>
							${user.agree_dt	 }
							<c:if test="${user.reagree_yn eq 'Y' }"><%-- 동의후 23개월 후에 재동의 버튼이 활성화 된다. --%>
								<label class="hidden">재동의 바로가기</label>
								<button onclick="goPage('041eb02ef86a4e78b7abb65d7b5fa6ee', '','');" class="btn s_save_btn" title="재동의 바로가기">
									<span>재동의 바로가기</span>
								</button>
							</c:if>
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
           		<button class="btn save2" title="회원탈퇴" onclick="dropout();">
           			<span>회원탈퇴</span>
           		</button>
           		<button class="btn save2" title="정보수정완료" onclick="jsSave();">
           			<span>정보수정완료</span>
           		</button>
           		<button class="btn save2" title="취소" onclick="cancel();">
           			<span>취소</span>
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
<jsp:include page="/WEB-INF/views/front/user/pwdChangePopup.jsp"/>