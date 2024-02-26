<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script src="/js/announce.js"></script>
<script>

function changeInsuranceClass(){
	 var insuranceClass = $("#insurance_class").val();
	 //기존  활동보고서 제출기간 삭제
	 delTableRow("insurance_tb");
	 // 활동보고서 제출기간 생성
	 createInsurance("insurance_tb", insuranceClass);
}

function changeNotworkClass(){
	 var notworkClass = $("#notwork_class").val();
	 //기존  활동보고서 제출기간 삭제
	 delTableRow("notwork_tb");
	 // 활동보고서 제출기간 생성
	 createNotwork("notwork_tb", notworkClass);	
}

function evalstdInsert(){
	   var insclass = $("#insurance_class").val(); 
	   for(var i =1; i <= insclass;i++){
		   if($("#inspoint_"+i).val() == ""){
			   alert("건강보험료 점수를 입력해 주십시요");
			   $("#inspoint_"+i).focus();
			   return;
		   }
		   if($("#insurancefrom_"+i).val() == ""){
			   alert("직장보험료를 입력해 주십시요");
			   $("#insurancefrom_"+i).focus();
			   return;
		   }
		   if($("#insuranceto_"+i).val() == ""){
			   alert("직장보험료를 입력해 주십시요");
			   $("#insuranceto_"+i).focus();
			   return;
		   }	
		   if($("#regionfrom_"+i).val() == ""){
			   alert("지역보험료를 입력해 주십시요");
			   $("#regionfrom_"+i).focus();
			   return;
		   }
		   if($("#regionto_"+i).val() == ""){
			   alert("지역보험료를 입력해 주십시요");
			   $("#regionto_"+i).focus();
			   return;
		   }			   
	   }
	   var workclass = $("#notwork_class").val(); 
	   for(var i =1; i <= workclass;i++){
		   if($("#notworkpoint_"+i).val() == ""){
			   alert("미취업 점수를 입력해 주십시요");
			   $("#notworkpoint_"+i).focus();
			   return;
		   }
	   }
	   
	   for(var i =1; i <= 5;i++){
		   if($("#family_"+i).val() == ""){
			   alert("부양가족 점수를 입력해 주십시요");
			   $("#family_"+i).focus();
			   return;
		   }
	   }   

	   // 데이터를 등록 처리해준다.
	   $("#evalstdWriteFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					popupClose();
				}	
			},
			dataType: "json", 
	        data: {
	        	announc_id : $("#announc_id").val()
			},
			url: "/back/announce/insertEvalstd.do"
	    });	
}

</script>
<form id="evalstdWriteFrm" name="evalstdWriteFrm" method="post" data-parsley-validate="true">
		<!-- title_area -->
		<div class="title_area">
			<h2 class="pop_title">건강보험료 구간</h2>
		</div>
		<!--// title_area -->
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<label for="insurance_class" class="hidden">등급 구분 선택</label>
				<select id="insurance_class" name="insurance_class" class="in_wp90" title="등급 구분 선택" onChange="changeInsuranceClass()">
					<option value="1" <c:if test="${insurance_class == 1}">selected</c:if>>1등급</option>
					<option value="2" <c:if test="${insurance_class == 2}">selected</c:if>>2등급</option>
					<option value="3" <c:if test="${insurance_class == 3}">selected</c:if>>3등급</option>
					<option value="4" <c:if test="${insurance_class == 4}">selected</c:if>>4등급</option>
					<option value="5" <c:if test="${insurance_class == 5}">selected</c:if>>5등급</option>
					<option value="6" <c:if test="${insurance_class == 6}">selected</c:if>>6등급</option>
					<option value="7" <c:if test="${insurance_class == 7}">selected</c:if>>7등급</option>
					<option value="8" <c:if test="${insurance_class == 8}">selected</c:if>>8등급</option>
					<option value="9" <c:if test="${insurance_class == 9}">selected</c:if>>9등급</option>
					<option value="10" <c:if test="${insurance_class == 10}">selected</c:if>>10등급</option>
				</select>
			</div>
		</div>
		<!--// tabel_search_area -->
		<!-- table 1dan list -->
		<div class="table_area">
			<table id="insurance_tb" class="list fixed">
				<caption>리스트 화면</caption>
				<colgroup>
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: *;" />
					<col style="width: *;" />
				</colgroup>
				<thead>
				<tr>
					<th class="first" scope="col">등급</th>
					<th scope="col">점수</th>
					<th scope="col">월별 직장보험료 구간</th>
					<th class="last" scope="col">월별 지역보험료 구간</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="row" items="${insuranceList}" varStatus="status">
				<tr>
					<td class="first">${row.lvl}</td>
					<td>
						<label class="hidden" for="inspoint_${row.lvl}">점수 입력창</label>
						<input type="text" class="in_w80 onlynum" id="inspoint_${row.lvl}" name="inspoint_${row.lvl}" value="${row.point}" />
					</td>
					<td class="alignl">
						<c:if test="${(status.index+1) != insurance_class}">
						<input type="text" class="in_wp100 onlynum" id="insurancefrom_${row.lvl}"  name="insurancefrom_${row.lvl}" value="${row.eval_from}" />
						<label class="hidden" for="insurancefrom_${row.lvl}">월별 직장보험료 구간 초과 입력</label>
						<span>초과</span>
						</c:if>
						<span class="marginr10 marginl10">~</span>
						<c:if test="${status.index > 0}">
						<input type="text" class="in_wp100 onlynum" id="insuranceto_${row.lvl}" name="insuranceto_${row.lvl}" value="${row.eval_to}" />
						<label class="hidden" for="insuranceto_${row.lvl}">월별 직장보험료 구간 이하 입력</label>
						<span>이하</span>
						</c:if>
					</td>
					<td class="last alignl">
						<c:if test="${(status.index+1) != insurance_class}">
						<input type="text" class="in_wp100 onlynum" id="regionfrom_${row.lvl}" name="regionfrom_${row.lvl}"  value="${row.eval2_from}" />
						<label class="hidden" for="regionfrom_${row.lvl}">월별 지역보험료 구간 초과 입력</label>
						<span>초과</span>
						</c:if>
						<span class="marginr10 marginl10">~</span>
				    	<c:if test="${status.index > 0}">
						<input type="text" class="in_wp100 onlynum" id="regionto_${row.lvl}" name="regionto_${row.lvl}"  value="${row.eval2_to}" />
						<label class="hidden" for="regionto_${row.lvl}">월별 지역보험료 구간 이하 입력</label>
						<span>이하</span>
						</c:if>
					</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<!--// table 1dan list -->
		
		<!-- title_area -->
		<div class="title_area">
			<h2 class="pop_title">미취업 기간</h2>
		</div>
		<!--// title_area -->
		
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<label for="notwork_class" class="hidden">등급 구분 선택</label>
				<select id="notwork_class" name="notwork_class" class="in_wp90" title="등급 구분 선택" onChange="changeNotworkClass()">
					<option value="1" <c:if test="${notwork_class == 1}">selected</c:if>>1등급</option>
					<option value="2" <c:if test="${notwork_class == 2}">selected</c:if>>2등급</option>
					<option value="3" <c:if test="${notwork_class == 3}">selected</c:if>>3등급</option>
					<option value="4" <c:if test="${notwork_class == 4}">selected</c:if>>4등급</option>
					<option value="5" <c:if test="${notwork_class == 5}">selected</c:if>>5등급</option>
					<option value="6" <c:if test="${notwork_class == 6}">selected</c:if>>6등급</option>
					<option value="7" <c:if test="${notwork_class == 7}">selected</c:if>>7등급</option>
					<option value="8" <c:if test="${notwork_class == 8}">selected</c:if>>8등급</option>
					<option value="9" <c:if test="${notwork_class == 9}">selected</c:if>>9등급</option>
					<option value="10" <c:if test="${notwork_class == 10}">selected</c:if>>10등급</option>
				</select>
			</div>
		</div>
		<!--// tabel_search_area -->
		
		<!-- table 1dan list -->
		<div class="table_area">
			<table id="notwork_tb" class="list fixed">
				<caption>미취업 기간 리스트 화면</caption>
				<colgroup>
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: *;" />
				</colgroup>
				<thead>
				<tr>
					<th class="first" scope="col">등급</th>
					<th scope="col">점수</th>
					<th class="last" scope="col">미취업 기간</th>
				</tr>
				</thead>
				<tbody>
                <c:forEach var="row" items="${notworkList}" varStatus="status">
				<tr>
					<td class="first">${row.lvl}</td>
					<td>
						<label class="hidden" for="notworkpoint_${row.lvl}">점수 입력창</label>
						<input type="text" class="in_w80 onlynum" id="notworkpoint_${row.lvl}" name="notworkpoint_${row.lvl}" value="${row.point}" />
					</td>
					<td class="last">
					   <c:if test="${(status.index+1) != notwork_class}">
						<label for="notworkfrom_${row.lvl}" class="hidden">미취업기간 설정</label>
						<select class="in_wp100" id="notworkfrom_${row.lvl}" name="notworkfrom_${row.lvl}" >
							 <c:forEach var="i" begin="0" end="120">
		                         <option value="${i}" <c:if test="${i == row.eval_from}">selected</c:if>>${i}</option>
		                     </c:forEach>
						</select>
						<span>초과</span>
						</c:if>					
						<span class="marginr10 marginl10">~</span>	
					     <c:if test="${status.index > 0}">
						<label for="notworkto_${row.lvl}" class="hidden">미취업기간 설정</label>
						<select class="in_wp100" id="notworkto_${row.lvl}"  name="notworkto_${row.lvl}" value="${row.eval_to}" >
							 <c:forEach var="i" begin="0" end="120">
		                         <option value="${i}" <c:if test="${i == row.eval_to}">selected</c:if>>${i}</option>
		                     </c:forEach>
						</select>
						<span>이하</span>
						</c:if>
					</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<!--// table 1dan list -->
		
		<!-- title_area -->
		<div class="title_area">
			<h2 class="pop_title">배우자 및 자녀 수</h2>
		</div>
		<!--// title_area -->
		
		<!-- table 1dan list -->
		<div class="table_area">
			<table class="list fixed">
				<caption>부양가족 수 리스트 화면</caption>
				<colgroup>
					<col style="width: 20%;" />
					<col style="width: 20%;" />
					<col style="width: 20%;" />
					<col style="width: 20%;" />
					<col style="width: 20%;" />
				</colgroup>
				<thead>
				<tr>
					<th class="first" scope="col">없음</th>
					<th scope="col">1인</th>
					<th scope="col">2인</th>
					<th scope="col">3인</th>
					<th class="last" scope="col">4인 이상</th>
				</tr>
				</thead>
				<tbody>	
				<tr>
				<c:forEach var="row" items="${familyList}" varStatus="status">
					<td <c:if test="${status.index == 0}">class="first"</c:if><c:if test="${status.index== 4}">class="last"</c:if>>
						<label class="hidden" for="family_${row.lvl}">가족수 입력창</label>
						<input type="text" class="in_w80 onlynum" id="family_${row.lvl}" name="family_${row.lvl}" value="${row.point}" />
					</td>
                </c:forEach> 
				</tr>
				</tbody>
			</table>
		</div>
		<!--// table 1dan list -->
		
		<!-- button_area -->
		<div class="button_area">
			<div class="alignc">
				<a href="javascript:evalstdInsert()" class="btn save" title="저장하기">
					<span>저장</span>
				</a>
			</div>
		</div>
		<!--// button_area -->        
</form>