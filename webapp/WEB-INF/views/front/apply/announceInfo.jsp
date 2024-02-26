<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@page import="kr.apfs.local.common.util.StringUtil"%>
<%@page import="kr.apfs.local.common.util.ConfigUtil"%>
<%
     //치환 변수 선언합니다.
   pageContext.setAttribute("cr", "\r"); //Space
   pageContext.setAttribute("cn", "\n"); //Enter
   pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
   pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<script>
$(document).ready(function(){

});

function announceApply(announcId, submitCnt, age){
	var f = document.writeFrm;

    // 로그인 했는지를 체크한다.
     if('${s_user_id}' == ''){
    	if(confirm("청년수당 신청은 회원만 가능합니다.\r\n로그인 페이지로 이동하시겠습니까?")){
    		// 로그인 페이지로 이동을 해준다.
    		goPage('7d8de154663840ad83ae6d93bf539c5c', '', '');
    		return;
    	} else return;
    }

    if(submitCnt > 0){
    	alert("이미 청년수당 수급이력이 존재하므로 신청을 할 수 없습니다.");
    	return;
    }

    // 나이가 19~30세인지를 체크
     if(age < 19 || age > 30){
    	alert("청년수당 신청 나이는 만19세~30세를 대상으로 합니다.");
    	return;
    }

    $("#announc_id").val(announcId);

    var checkVal = false;
     $.ajax({
         url: "/front/apply/applyRoadCheck.do",
         dataType: "json",
         type: "post",
         async : false,
         success: function(data) {
             if(data.applyTime > <%=(String)ConfigUtil.getProperty("system.applyBaseTime") %>){
             	 document.location.href ="/front/apply/applyRoadAlarm.do";
             	 checkVal = true;
             }
         },
         error: function(e) {
             alert("신청 페이지 이동에 실패하였습니다.");
         }
     });

     if(checkVal) return;

    // 동의 페이지로 이동한다.
    f.action = "/front/apply/applyAgree.do";
    f.submit();
}

function showApplyResult(){
	goPage('8da557f44039472ea56106bb9234aaf2', '', '');
}

</script>
 <form id="writeFrm" name="writeFrm" method="post"  onSubmit="return false;" class="form-horizontal text-left" data-parsley-validate="true">
    <input type='hidden' id="announc_id" name='announc_id' value="${announce.announc_id}" />
</form>
			<!-- division40 -->
			<div class="division40">
            <c:if test="${not empty announceList}">
            <c:forEach var="announce" items="${announceList}" varStatus="status">
				<!-- division50 -->
				<div class="division50">
					<!-- title_area -->
					<div class="title_area">
						<h3 class="title">${announce.seq}회차 ${announce.year}년 청년수당 일정안내</h3>
					</div>
					<!--// title_area -->
					<!-- info_txt_area -->
					<div class="info_txt_area">
						<p>${fn:replace(announce.contents, cn, br)}</p>
					</div>
					<!--// info_txt_area -->
					<!-- table_area -->
					<div class="table_area">
						<table class="view fixed">
							<caption>${announce.seq}회차 ${announce.year}년 청년수당 일정안내 상세보기 화면</caption>
							<colgroup>
								<col style="width: 160px;">
								<col style="width: *;">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row" class="first">신청기간</th>
								<td class="first">${announce.aply_dt}</td>
							</tr>
							<tr>
								<th scope="row">심사기간</th>
								<td>${announce.eval_dt}</td>
							</tr>
							<tr>
								<th scope="row">발표일</th>
								<td>${announce.rel_dt} ~</td>
							</tr>
							<tr>
								<th scope="row" class="last">활동결과서 제출기간</th>
								<td class="last">
									<ul class="view_list">
									  <c:forEach var="row" items="${announce.actsubmitList}" varStatus="status">
										<li>
											${row.act_seq}차 : ${row.submit_stadt} ${row.submit_stadt_hour}:${row.submit_stadt_min} ~ ${row.submit_enddt} ${row.submit_enddt_hour}:${row.submit_enddt_min}
										</li>
									   </c:forEach>
									</ul>
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<!--// table_area -->

					<!-- button_area -->
		            <div class="button_area">
		            	<div class="alignc">
		            	    <c:if test="${announce.state == 'C'}">
		            		<span class="m_marginb10 m_theblock">이미 청년수당 신청을 하셨습니다.</span>
		            		<button onClick="javascript:showApplyResult();" class="btn save2" title="청년수당 신청결과">
		            			<span>청년수당 신청결과</span>
		            		</button>
		            		</c:if>
		            		<c:if test="${announce.state == 'A'}">
		            		<button onClick="announceApply('${announce.announc_id}',${announce.pre_submit_cnt},'${announce.age}')" class="btn save2" title="청년수당 신청하기">
		            			<span>청년수당 신청하기</span>
		            		</button>
		            		</c:if>
		            	    <c:if test="${announce.state == 'B'}">
		            		<span class="m_marginb10 m_theblock">청년수당 신청기간이 아닙니다.</span>
		            		</c:if>
		            		<c:if test="${announce.state == 'AE'}">
		            		<span class="m_marginb10 m_theblock">청년수당 신청기간이 종료되었습니다.</span>
		            		</c:if>
		            		<c:if test="${announce.state == 'M'}">
		            		<span class="m_marginb10 m_theblock">청년수당 신청기간이 종료되었습니다.</span>
		            		<c:if test="${not empty announce.aply_id}">
		            		<button onClick="javascript:showApplyResult();" class="btn save2" title="청년수당 신청결과">
		            			<span>청년수당 신청결과</span>
		            		</button>
		            		</c:if>
		            		</c:if>
		            	</div>
		            </div>
		           	<!--// button_area -->
				</div>
	           	<!--// division50 -->
	           	</c:forEach>
	           	</c:if>

	           	<c:if test="${empty announceList}">
	           	<!-- division50 -->
	           	<div class="division50">
	           		<div class="guide_box">
	           			<div class="guide_bg_box">
	           				<div>
			           			<p>청년수당 일정이 시작전이거나 종료되었습니다.</p>
			            		<button onClick="goPage('221d82257f564b29997d7050028d45a9','','')" class="btn s_save_btn" title="청년수당이란?">
			            			<span>청년수당이란?</span>
			            		</button>
			            		<button onClick="goPage('b935fd907c2d4be287bc23139c6cd4fc','','')" class="btn s_save_btn" title="청년수당 FAQ">
			            			<span>청년수당 FAQ</span>
			            		</button>
			            	</div>
						</div>
	           		</div>
	           	</div>
	           	<!--// division50 -->
	           	</c:if>
           	</div>
           	<!--// division40 -->

