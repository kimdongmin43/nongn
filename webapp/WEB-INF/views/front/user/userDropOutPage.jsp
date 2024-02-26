<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
		var userDropOutUrl = "<c:url value='/front/user/userDropOut.do'/>";
		
		function dropOut(){
			if (confirm('정말로 탈퇴하시겠습니까?')) {
				$.ajax({
					type: "POST",
			        url: userDropOutUrl,
			        dataType: 'json',
					success:function(data){
						alert(data.message);
						opener.cancel();
						closePopup();
					}
				});
			}
		}
		
		function closePopup(){
			window.close();
		}
		
	</script>
	
	<!-- popup_content -->
	<!-- header -->
	<div id="pop_header">
	<header>
		<h1 class="pop_title">회원탈퇴</h1>
		<a href="javascript:closePopup()" class="pop_close" title="페이지 닫기">
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
				
				<div class="">
					
					<!-- withdrawal_txt_box -->
					<div class="withdrawal_txt_box">
						<p>회원탈퇴 전에 아래 내용을 꼭 <span>확인</span>해주시기 바랍니다.</p>								
					</div>
					<!--// withdrawal_txt_box -->
					<!-- withdrawal_list -->
					<div class="withdrawal_list">
						<ol>
							<li>
								<span>1.</span>
								<div>
									<p>사용하고 계시는 (<strong class="color_point">${s_user_id }</strong>) 아이디는 <strong>재사용 및 복구가 불가능합니다.</strong></p>
   									<p>탈퇴 시 해당 아이디는 즉시 탈퇴 처리 되며, 탈퇴한 아이디는 <span class="under_line">본인과 타인 모두 재사용 및 복구가 불가</span>하오니 신중하게 선택하시기 바랍니다.</p>
   								</div>
							</li>
							<li>
								<span>2.</span>
								<div>
									<strong>탈퇴 후 회원정보는 모두 삭제됩니다.</strong>
   									<p><span class="under_line">탈퇴 시 아이디를 제외한 회원정보는 모두 삭제</span>되며, 삭제된 데이터는 복구되지 않습니다.</p>
   								</div>    								
							</li>
							<li>
								<span>3.</span>
								<div>
									<strong>탈퇴 후에도 게시판형 서비스에 등록한 게시물은 그대로 남아 있습니다.</strong>
   									<p>서울시 상공회의소 온라인플랫폼 홈페이지에 올린 게시글 및 댓글은 탈퇴 시 자동 삭제되지 않고 그대로 남아 있으므로, 삭제를 원하는 게시글이 있다면 <span class="under_line">반드시 탈퇴 전 삭제하시기 바랍니다.</span></p>
   								</div>    								
							</li>
						</ol>
					</div>
					<!--// withdrawal_list -->
					
				</div>
				<!-- button_area -->
				<div class="button_area">
	            	<div class="alignc">
	            		<button class="btn save" title="회원탈퇴" onclick="dropOut();">
	            			<span>회원탈퇴</span>
	            		</button>
	            		<button class="btn cancel" title="취소" onclick="closePopup()">
	            			<span>취소</span>
	            		</button>
	            	</div>
	            </div>
	            <!--// button_area -->
			</div>
		</div>
	</article>	
	</div>
	<!--// popup_content -->