<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>


$(document).ready(function(){

	
});

function showApply(aplyId){
	var f = document.listFrm;
	
	$("#aply_id").val(aplyId);
    f.action = "/front/apply/myApply.do";
    f.submit();
}    

function showActreport(announcId, actSeq, aplyId, state){
	var f = document.listFrm;
	
	if('${agreeYn}' == 'N'){
		alert("먼저 약정서 동의 및 관심 프로그램 선택을 진행하셔야 합니다.");
		return;
	}
	
	$("#announc_id").val(announcId);
	$("#act_seq").val(actSeq);
	$("#aply_id").val(aplyId);
	$("#state").val(state);
    f.action = "/front/actplan/myActreport.do";
    f.submit();	
}

function showOrientation(announcId, actSeq, aplyId){
	var f = document.listFrm;
	
	$("#announc_id").val(announcId);
	$("#act_seq").val(actSeq);
	$("#aply_id").val(aplyId);
    f.action = "/front/apply/myOrientation.do";
    f.submit();	
}

function selfDiagnose(){
	var url = "https://goo.gl/ZrzbhQ";
	window.open(url, 'Pop', 'width=1024,height=768,top=100,left=100');
}

</script>
 <form id="listFrm" name="listFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
    <input type='hidden' id="announc_id" name='announc_id' value="" />
    <input type='hidden' id="act_seq" name='act_seq' value="" />
    <input type='hidden' id="aply_id" name='aply_id' value="" />
    <input type='hidden' id="state" name='state' value="" />
</form>
		
					<!-- division40 -->
					<div class="division40">
						<!-- division60 -->
						<div class="division60">
							<!-- title_area -->
							<div class="title_area">
								<h3 class="title">청년수당 신청결과</h3>
							</div>
							<!--// title_area -->
							<!--// list_table_area -->  
				            <div class="list_table_area">
				                <table class="contents_list2 fixed">
				                    <caption>청년수당 신청결과 리스트 화면</caption>
				                    <colgroup>
				                        <col style="width: 30%;">
				                        <col style="width: *;">
				                    </colgroup>
				                    <thead>
				                    <tr>
				                        <th scope="col" class="first_line">회차/공고연도</th>
				                        <th scope="col">신청정보 및 결과보기</th>
				                    </tr>
				                    </thead>
				                    <tbody>
				                    <c:forEach var="row" items="${applyList}" varStatus="status">
					                    <tr>
					                        <td class="first_line">${row.seq}회/ ${row.seq}년</td>
					                        <td class="alignl">
					                        	<ul class="contents_ul">
					                        		<li>
					                        			<span class="li_title" style="width: 80px">신청일</span>
					                        			<span>${row.reg_date}</span>
					                        			<button onClick="javascript:showApply('${row.aply_id}');" class="btn s_save_btn" title="신청서 보기">
									                        <span>신청서 보기</span>
									                    </button>
					                        		</li>
					                        		<li>
					                        			<span class="li_title" style="width: 80px">신청결과</span>
					                        			<span class="color_pointr">
					                        			   <c:choose>
															   <c:when test="${row.second_result == 'P' &&  row.rel_yn == 'Y'}">축하합니다.</c:when>
															   <c:when test="${row.state == 'F'}">청년수당 대상이 아닙니다. (${row.fail_reason_nm})</c:when>
															   <c:when test="${row.state == 'P'}">대기중 입니다.</c:when>
															</c:choose>
					                        			</span>
					                        			<c:if test="${row.second_result == 'P' && row.rel_yn == 'Y' && row.agree_yn == 'N' && row.agree_dt == null && row.submit_yn == 'N'}">
					                        			<button onClick="javascript:showOrientation('${row.announc_id}','${row.act_seq}','${row.aply_id}')" class="btn s_save_btn" title="약정서 동의 및 관심 프로그램 선택">
									                        <span>약정서 동의 및 관심 프로그램 선택</span>
									                    </button>
									                    </c:if>
					                        		</li>
					                        		<c:if test="${row.state == 'P' && row.agree_dt != null}">
					                        		<li>
					                        			<span class="li_title" style="width: 80px">약정서 동의일</span>
					                        			<span>${row.agree_dt}</span>
					                        			<c:if test="${row.submit_yn == 'N' }">
					                        			<button onClick="selfDiagnose()" class="btn s_save_btn2" title="자가진단 바로가기">
									                        <span>자가진단 바로가기</span>
									                    </button>
									                    </c:if>
					                        		</li>
					                        		</c:if>
					                        	</ul>
					                        </td>
										</tr>
									</c:forEach>
									<c:if test="${empty applyList }"><tr><td class="first_line" colspan="2">청년수당 신청이력이 없습니다.</td></tr></c:if>
									</tbody>
								</table>
							</div>
							<!--// list_table_area -->  	
						</div>
			           	<!--// division60 -->
			           	<c:if test="${sumitAnnouce != null && sumitAnnouce.state == 'P' }">
			           	<!-- division60 -->
			           	<div class="division60">
			           		<!-- title_area -->
							<div class="title_area">
								<h3 class="title"><span class="color_pointr">${sumitAnnouce.seq}회 ${sumitAnnouce.year}년</span> 활동결과 보고서</h3>
							</div>
							<!--// title_area -->
							<!--// list_table_area -->  
				            <div class="list_table_area">
				                <table class="contents_list2 fixed">
				                    <caption>활동결과 보고서 리스트 화면</caption>
				                    <colgroup>
				                        <col style="width: 20%;">
				                        <col style="width: 40%;">
				                        <col style="width: 40%;">
				                    </colgroup>
				                    <thead>
				                    <tr>
				                        <th scope="col" class="first_line">활동 회차</th>
				                        <th scope="col">보고서 제출기간</th>
				                        <th scope="col">제출일 / 보고서 관리</th>
				                    </tr>
				                    </thead>
				                    <tbody>
				                    <c:forEach var="row" items="${sumitList}" varStatus="status">
				                    <tr>
				                        <td class="<c:if test="${sumitList.size()-1 == status.index}">last_line</c:if> first_line">${row.submit_mm}월</td>
				                        <td class="<c:if test="${sumitList.size()-1 == status.index}">last_line</c:if>">${row.submit_stadt} ${row.submit_stadt_hour}:${row.submit_stadt_min} ~ ${row.submit_enddt} ${row.submit_enddt_hour}:${row.submit_enddt_min}</td>
				                        <td class="<c:if test="${sumitList.size()-1 == status.index}">last_line</c:if>">
				                           <c:if test="${(row.state == 'B' || row.state == 'E') && row.aply_id == null}">
				                            -
				                           </c:if>
				                           <c:if test="${sumitAnnouce.agree_yn == 'Y' && row.state == 'A' && row.pre_submit_yn == 'Y' && sumitAnnouce.give_yn == 'Y' && row.reg_date == null}">
					                            <button onClick="javascript:showActreport('${row.announc_id}','${row.act_seq}','${row.aply_id}','${row.state}');" class="btn s_save_btn" title="보고서 제출">
							                        <span>보고서 제출</span>
							                    </button>
				                           </c:if>
				                           <c:if test="${row.reg_date != null}">
				                        	<span>${row.reg_date}</span>
				                        	<button onClick="javascript:showActreport('${row.announc_id}','${row.act_seq}','${row.aply_id}','${row.state}')" class="btn s_save_btn marginl5" title="보고서 보기">
						                        <span>보고서 보기</span>
						                    </button>
						                  </c:if>  
				                        </td>
									</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
							<!--// list_table_area -->							
			           	</div>
			           	<!--// division60 -->
			           	</c:if>
		           	</div>
		           	<!--// division40 -->		           	