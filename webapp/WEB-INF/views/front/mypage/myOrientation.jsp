<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
$(document).ready(function(){
	
});

function insertOrientation(){
	var f = document.writeFrm;

	// 동의여부 확인
	if($('input:checkbox[id="agree_yn"]').is(":checked")== false){
		alert("약관동의는 필수입니다.");
		return;
	}
		
	// 관심분야 하나라도 체크
	var fieldCnt = $('input:checkbox[name="field_cd"]:checked').length;
    if(fieldCnt < 1 || fieldCnt > 5){
    	alert("관심분야는 최소1개 최대 5개까지 선택 가능합니다.");
    	return;
    }
	
   $("#writeFrm").ajaxSubmit({
		success: function(responseText, statusText){
			if(responseText.success == "true"){
				alert("상공회의소사업 약정서 동의를 완료하였습니다.\n[마이페이지 > 청년수당 신청결과]에서\n자가진단을 참여해 주시기 바랍니다.");
				myApplyResult();
			}else{	
				alert(responseText.message);
			}	
		},
		dataType: "json", 				
		url: "/front/apply/insertOrientation.do"
    });	
}

function folding(){
	if($("#agree_fold").attr("class") == "open"){
		$("#agree_fold").removeClass("open");
		$("#agree_fold").addClass("fold");
		$("#agree_fold").html("<span>약관접기</span>");
		$("#agree_term").show();
	}else{
		$("#agree_fold").removeClass("fold");
		$("#agree_fold").addClass("open");
		$("#agree_fold").html("<span>약관보기</span>");
		$("#agree_term").hide();
	}
}

function myApplyResult(){
	var f = document.writeFrm;
    f.action = "/front/apply/myApplyResult.do";
    f.submit();
}

</script>
 <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" onsubmit="return false;" data-parsley-validate="true">
    <input type='hidden' id="aply_id" name='aply_id' value="${orientation.aply_id}" />

					<!-- division40 -->
					<div class="division40">
						<!-- division -->
						<div class="division">
							<!-- text_box -->
							<div class="text_box marginb20">
								<strong>신청하신 청년수당 수급자로 선정되었습니다.</strong>
							</div>
							<!--// text_box -->
							<!-- division30 -->
							<div class="division30">
								<!-- title_area -->
								<div class="title_area">
									<h3 class="title">1단계 : 프로그램 선택</h3>
								</div>
								<!--// title_area -->
								<!-- division -->
								<div class="division">
									<p class="margint20">서울시 상공회의소는 청년의 사회진입 과정을 도울 수 있는 정서상담, 일상생활 설계, 진로모색, 구직활동에 필요한 직무역량강화 등 다양한 프로그램을 제공합니다. 아래 프로그램 중 관심 있거나 정보를 받고 싶은 프로그램 알림을 신청하세요. 신청하신 프로그램에 대한 상세 정보를 프로그램별 신청기간에 문자로 보내드립니다. 최대 5개까지 선택할 수 있습니다.</p>
									<div class="margint20 alignr">
										<button onClick="goPage('4529d17b544045a084725c63c22e74fa')" class="btn s_save_btn2" title="프로그램 안내 상세보기">
											<span>프로그램 안내 상세보기</span>
										</button>
									</div>
								</div>
								<!--// division -->
								<!-- written_list_area -->
								<div class="written_list_area">
									<ul class="written_list">
										<c:set var="preConcern" value="0"/>
										<c:forEach var="row" items="${concernList}" varStatus="status">
										<c:if test="${fn:substring(row.code,0,1) != preConcern}">
										   <c:if test="${status.index > 0}">
										         </ul>
											</div>
										</li>
										    </c:if>
										<li>
											<div>
												<strong class="written_title">
										 			<c:choose>
												        <c:when test="${fn:substring(row.code,0,1) == '1'}">
												            진짜사회생활
												       </c:when>
												        <c:when test="${fn:substring(row.code,0,1) == '2'}">
												            진짜 내일탐구
												       </c:when>
												        <c:when test="${fn:substring(row.code,0,1) == '3'}">
												            정서상담 프로그램
												       </c:when>
												        <c:when test="${fn:substring(row.code,0,1) == '4'}">
												            일상생활지원 프로그램
												       </c:when>
												    </c:choose>
			                                   </strong>
												<ul class="written_sub_list">
													<li>
														<input type="checkbox" id="field_cd_${row.code}" name="field_cd" value="${row.code}" <c:if test="${fn:indexOf(orientation.interstfield, row.code) > -1}">checked</c:if> />
														<label for="field_cd_${row.code}">
															<span>${row.codenm}</span>
														</label>
													</li>
										</c:if>
										<c:if test="${fn:substring(row.code,0,1) == preConcern}">
													<li>
														<input type="checkbox" id="field_cd_${row.code}" name="field_cd" value="${row.code}" <c:if test="${fn:indexOf(orientation.interstfield, row.code) > -1}">checked</c:if>  />
														<label for="field_cd_${row.code}">
															<span>${row.codenm}</span>
														</label>
													</li>
										</c:if>
										<c:set var="preConcern" value="${fn:substring(row.code,0,1)}"/>
										</c:forEach>
									</ul>
								</div>
								<!--// written_list_area -->
							</div>
							<!--// division30 -->
							<!-- division30 -->
							<div class="division30">
								
								<!-- title_area -->
								<div class="title_area">
									<h3 class="title">2단계 : 오리엔테이션</h3>
								</div>
								<!--// title_area -->
                                  ${secondStr}
                                  
							</div>
							<!--// division30 -->
							<!-- division30 -->
							<div class="division30">
								<!-- title_area -->
								<div class="title_area">
									<h3 class="title">3단계 : 약정서</h3>
								</div>
								<!--// title_area -->
								<!-- terms_area -->
								<div class="terms_area">
									<!-- terms_box -->
									<div class="terms_box">
										<!-- terms_title -->
										<div class="terms_title">
											<div class="checks">
												<input type="checkbox" id="agree_yn"  name="agree_yn" value="Y" <c:if test="${orientation.agree_yn == 'Y'}">checked</c:if> />
												<label for="agree_yn">상공회의소사업 약정서 동의</label>
											</div>
											<a id="agree_fold" href="javascript:folding()"  class="fold" title="약관접기">
												<span>약관접기</span>
											</a>
										</div>
										<!--// terms_title -->
										<!-- terms_contents -->
										<div id="agree_term" class="terms_contents" style="display:">
											${agreeStr }
										</div>
										<!--// terms_contents -->
									</div>
									<!--// terms_box -->
								</div>
								<!--// terms_area -->
							</div>
							<!--// division30 -->
						</div>
						<!--// division -->
						<!-- division -->
						<div class="division alignc">
							<p>전년도 상공회의소사업 대상자입니까?</p>
							<div class="margint10">
								<input type="radio" id="pre_snd1" name="pre_snd_yn" value="Y" <c:if test="${orientation.pre_snd_yn == 'Y'}">checked</c:if> />
								<label for="pre_snd1" class="marginr10">예</label>
								<input type="radio" id="pre_snd2" name="pre_snd_yn" value="N"  <c:if test="${orientation.pre_snd_yn == 'N'}">checked</c:if> />
								<label for="pre_snd2" class="marginr10">아니오</label>	
							</div>
						</div>
						<!--// division -->
						<!--// division -->
			            <!-- button_area -->
			            <div class="button_area">
			            	<div class="alignc">
			            		<button onClick="javascript:insertOrientation()" class="btn save2" title="참가확인">
			            			<span>참가확인</span>
			            		</button>
			            	</div>
			            </div>
			           	<!--// button_area -->
		           	</div>
		           	<!--// division40 -->

</form>