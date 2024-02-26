<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
$(document).ready(function(){
	
});

function goMain(){
	document.location.href = "/front/user/main.do";
}

function goAnnounceInfo(){
	document.location.href = "/front/apply/announceInfo.do";
}

</script>
			<!-- division40 -->
			<div class="division40">
				<!-- division50 -->
				<div class="division50">
					<div class="guide_area">
						<div class="guide_txt">
							<p class="guide_txt01">서비스 이용에 불편을 드려서 죄송합니다.</p>
							<p class="guide_txt02">잠시만 기다려주세요.</p>
							<p class="guide_txt03">서울시 상공회의소 온라인플랫폼을 이용해 주셔서 감사합니다.</p>
							<p class="guide_txt03">현재 접속인원이 많아 신청서 작성이 지연되고 있습니다.</p>
							<p class="guide_txt03">잠시 후 재접속 부탁 드립니다.</p>
							<p class="guide_txt03">항상 더 나은 서비스 제공을 위해 노력하는 서울시가 되겠습니다.</p>
							<p class="guide_txt03">감사합니다.</p>		
						</div>
						<div class="guide_btn_area">
							<div class="alignc">
			            		<button onClick="goMain()" class="btn save2" title="메인으로">
			            			<span>메인으로</span>
			            		</button>
			            		<button onClick="goAnnounceInfo()" class="btn save2" title="청년수당 신청하기">
			            			<span>청년수당 신청하기</span>
			            		</button>
			            	</div>
						</div>
					</div>
	           	</div>
	           	<!--// division50 -->
           	</div>
           	<!--// division40 -->