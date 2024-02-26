<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script>
 function goMain(){
	document.location.href = "/front/user/main.do";
 }
</script>	
	<!-- division40 -->
	<div class="division40">
		<!-- division50 -->
		<div class="division50">
			<!-- chapter_area -->
			<div class="chapter_area">
				<img src="/images/front/sub/chapter04.png" alt="4. 신청완료" />
			</div>
			<!--// chapter_area -->
			<!-- complete_box -->
			<div class="complete_box">
				<p><span>${announce.seq}회차 ${announce.year}년</span> 청년수당 신청을 완료하였습니다.</p>
				<button onClick="goMain();return false;" class="btn save2" title="메인으로">
           			<span>메인으로</span>
           		</button>
           		<button onClick="goPage('8da557f44039472ea56106bb9234aaf2' ,'','');return false;"class="btn save2" title="청년수당 신청결과">
           			<span>청년수당 신청결과</span>
           		</button>
			</div>
			<!-- complete_box -->
          	</div>
          	<!--// division50 -->
         	</div>
         	<!--// division40 -->

