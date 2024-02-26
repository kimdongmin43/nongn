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
</script>

<!-- division40 -->
<div class="division40">
	<!-- division60 -->
		<!-- division30 -->
		<div class="division30">
			<!-- terms_area -->
			<div class="terms_area">
				<!-- terms_box -->
				<div class="terms_box">
					<!-- terms_title -->
					<div class="terms_title">
						<div class="checks">
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
			</div>
			<!--// terms_area -->
		</div>
		<!--// division30 -->
	</div>
	<!--// division60 -->
</div>
<!--// division40 -->
