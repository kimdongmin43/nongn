<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var saveSatisfyUrl = "<c:url value='/front/board/saveSatisfy.do'/>";

	//만족도 저장
	function saveSatisfy(){
		
		// 로그인 여부 확인하기
		var sid = "${s_user_no }";
		var yn = "${intropage.satisfy_yn }";
		
		if(sid == ""){
			alert("로그인이 후 참여 가능합니다.");
			goPage('7d8de154663840ad83ae6d93bf539c5c', '', '');
			return;
		}
		
		if(yn == "Y"){
			alert("이미 참여하였습니다.");
			return;
		}
		
		var url = saveSatisfyUrl;
		if (confirm('만족도를 저장하시겠습니까?')) {
			$.ajax({
				type: "POST",
				url: url,
				data :jQuery("#satisfyFrm").serialize(),
				dataType: 'json',
				success:function(data){
					alert(data.message);
					if(data.success == "true"){
						$(".satisfaction_area").hide();
					}	
				}
			});
	    }
	}
</script>

<div class="editor">${intropage.contents}</div>

<%-- 만족도사용여부 --%>
<c:if test="${intropage.satis_yn eq 'Y'}">
<!-- satisfaction_area -->
<form id="satisfyFrm" name="satisfyFrm" onsubmit="return false;" style="margin-top : 20px">
	<input type='hidden' id="contents_id" name='contents_id' value="${intropage.page_id}" />
	<div class="satisfaction_area marginb10">
		<strong class="satisfaction_txt">현재 페이지의 콘텐츠 안내 및 정보 제공에 만족하십니까?</strong>
		<div class="satisfaction_radio_area">
	 	<ul>
	 		<li>
	 			<input type="radio" id="sat1" name="point" value="5" checked />
	 			<label for="sat1" class="marginr20">매우 만족</label>
	 		</li>
	 		<li>
	 			<input type="radio" id="sat2" name="point" value="4" />
	 			<label for="sat2" class="marginr20">만족</label>
	 		</li>
	 		<li>
	 			<input type="radio" id="sat3" name="point" value="3" />
	 			<label for="sat3" class="marginr20">보통</label>
	 		</li>
	 		<li>
	 			<input type="radio" id="sat4" name="point" value="2" />
	 			<label for="sat4" class="marginr20">불만족</label>
	 		</li>
	 		<li>
	 			<input type="radio" id="sat5" name="point" value="1" />
	 			<label for="sat5" class="marginr20">매우 불만족</label>
	 		</li>
	 	</ul>	
	 	<button class="btn satisfaction" onclick="saveSatisfy()" title="확인">
	 		<span>확인</span>
	 	</button>
		</div>            			            		
	</div>
</form>
<!--// satisfaction_area -->
</c:if>