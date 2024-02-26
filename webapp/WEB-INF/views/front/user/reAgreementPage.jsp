<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var updateAgreementUrl = "<c:url value='/front/user/updateAgreement.do'/>";
var reAgreementPopupUrl = "<c:url value='/front/user/reAgreementPopup.do'/>";

$(document).ready(function(){
	
	$("[id^=chk]").click(function(){
		if($(this).hasClass('open')){
			$(this).parent().next().show();
			$(this).removeClass('open');
			$(this).addClass('fold');
			$(this).children().html('약관접기');
		}else{
			$(this).parent().next().hide();
			$(this).removeClass('fold');
			$(this).addClass('open');
			$(this).children().html('약관보기');
		}
	});
});

function reAgreement(){
	if(!$("#agreement").is(":checked")){
		alert("이용약관에 동의하지 않았습니다.");
		return;
	}
	if(!$("#privacy").is(":checked")){
		alert("개인정보 수집.이용동의에 동의하지 않았습니다.");
		return;
	}
	
	if (confirm('회원정보 재동의 하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: updateAgreementUrl,
			dataType: 'json',
			success:function(data){
				if(data.success == "true"){
					popupShow();
				}	
			}
		});
    }
}

</script>

<!-- division40 -->
<div class="division40">
	<!-- division60 -->
		<!-- division30 -->
		<div class="division30">
			<!-- text_box -->
			<c:set var="year" value="2014" />
			<c:set var="month" value="11" />
			<c:set var="day" value="01" />
			<c:if test="${not empty agree_dt}">
				<c:set var="year" value="${fn:substring(agree_dt, 0,4) }" />
				<c:set var="month" value="${fn:substring(agree_dt, 5,7) }" />
				<c:set var="day" value="${fn:substring(agree_dt, 8,10) }" />
			</c:if>
			<div class="text_box marginb20">
				<p class="marginb10">2014년 11월 1일부터 개인정보 보호법에 따른 2년주기 회원정보 재동의 절차를 시행합니다. <strong>${s_user_name}</strong>님께서는 <strong>${year+2 }년 ${month }월 ${day }일</strong> 까지 서울시 상공회의소 온라인플랫폼 홈페이지에 재동의 하지 않을 경우 자동으로 회원 탈퇴 처리됨을 알려드립니다.</p> 
				<p>서울시 상공회의소 온라인플랫폼 홈페이지는 보다 편리하고 안전한 웹사이트 이용을 위해 개인정보 보호법에 따른 회원정보 재동의를 시행하고 있습니다. 표준개인정보호지침(안전행정부 2011.09)에 의거 2년을 주기로 재동의 절차를 거쳐 동의한 경우에만 회원자격을 유지할 수 있습니다.</p>
			</div>
			<!--//  -->
			<!-- terms_area -->
			<div class="terms_area">
				<!-- terms_box -->
				<div class="terms_box">
					<!-- terms_title -->
					<div class="terms_title">
						<div class="checks">
							<input type="checkbox" id="agreement" />
							<label for="agreement">이용약관</label>
						</div>
						<a href="#none" id="chk1" class="fold" title="약관보기">
							<span>약관보기</span>
						</a>
					</div>
					<!--// terms_title -->
					<!-- terms_contents -->
					<div class="terms_contents">
						${agreement.contents }
					</div>
					<!--// terms_contents -->
				</div>
				<!--// terms_box -->
				<!-- terms_box -->
				<div class="terms_box">
					<!-- terms_title -->
					<div class="terms_title">
						<div class="checks">
							<input type="checkbox" id="privacy" />
							<label for="privacy">개인정보 수집. 이용동의</label>
						</div>
						<a href="#none" id="chk2" class="fold" title="약관접기">
							<span>약관접기</span>
						</a>
					</div>
					<!--// terms_title -->
					<!-- terms_contents -->
					<div class="terms_contents">
						${privacy.contents }
					</div>
					<!--// terms_contents -->
				</div>
				<!--// terms_box -->
			</div>
			<!--// terms_area -->
		</div>
		<!--// division30 -->
		
		<!-- button_area -->
		<div class="button_area">
           	<div class="alignc">
           		<button onclick="reAgreement()" class="btn save2" title="회원정보 재동의">
           			<span>회원정보 재동의</span>
           		</button>
           	</div>
		</div>
		<!--// button_area -->
		
	</div>
	<!--// division60 -->
</div>
<!--// division40 -->
<jsp:include page="/WEB-INF/views/front/user/reAgreementPopup.jsp"/>
