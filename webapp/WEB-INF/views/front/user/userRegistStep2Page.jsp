<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
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

function next(){
	
	if(!$("#agreement").is(":checked")){
		alert("이용약관에 동의하지 않았습니다.");
		return;
	}
	if(!$("#privacy").is(":checked")){
		alert("개인정보 수집.이용동의에 동의하지 않았습니다.");
		return;
	}
	
	var f = document.joinFrm;
    f.action = "/front/user/userRegistStep3Page.do";
    f.submit();
	
}
</script>

<form id="joinFrm" name="joinFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="civil_name" name='civil_name' value="${civil_name}" />
	<input type='hidden' id="sms_number" name='sms_number' value="${sms_number}" />


<!-- division40 -->
<div class="division40">
	<!-- division60 -->
	<div class="division60">
		<!-- chapter_area -->
		<div class="chapter_area">
			<img src="/images/front/sub/member_chapter02.png" alt="2. 약관동의" />
		</div>
		<!--// chapter_area -->
		<!-- member_list_txt -->
		<div class="member_list_txt">
			<ul>
				<li>회원가입을 위해서 회원가입약관(개인정보 수집.이용동의)을 읽어보신 후에 약관에 동의하고 가입신청을 해주시기 바랍니다.</li>
			</ul>
		</div>
		<!--// member_list_txt -->
		<!-- division30 -->
		<div class="division30">
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
							<span>약관접기</span>
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
							<label for="privacy">개인정보 수집.이용동의</label>
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
           		<button class="btn save2" title="다음단계" onclick="next();">
           			<span>다음단계</span>
           		</button>
           	</div>
		</div>
		<!--// button_area -->
	</div>
	<!--// division60 -->
</div>
<!--// division40 -->
</form>
