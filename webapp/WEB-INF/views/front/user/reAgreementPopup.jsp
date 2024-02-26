<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script>
	function popupShow(){
		$('#modal-pw-write').modal('show');
	}

	function popupClose(){
		$('#modal-pw-write').modal('hide');
		document.location.href = "/front/user/main.do";
	}
</script>

<div class="modal fade" id="modal-pw-write" >
	<div class="modal-dialog modal-size-small">
	<!-- popup_content -->
	<!-- header -->
	<div id="pop_header">
		<header>
			<h1 class="pop_title">회원정보 재동의 안내</h1>
			<a href="javascript:popupClose()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
	
	</div>
	<!-- //header -->
	
	<!-- container -->
	<div id="pop_container">
		<article>
			<div class="pop_content_area">
				<div id="pop_content">
					<div class="agreement_txt">
						<p>회원정보 <strong class="color_pointr">재동의</strong>가</p>
						<p>정상적으로 완료되었습니다.</p>
					</div>
					<br/>
					<!-- button_area -->
					<div class="button_area">
		            	<div class="alignc">
		            		<button onclick="popupClose()" class="btn save" title="확인">
		            			<span>확인</span>
		            		</button>
		            	</div>
		            </div>
		            <!--// button_area -->
				</div>
			</div>
		</article>	
	</div>
	<!--// popup_content -->
	</div>
</div>