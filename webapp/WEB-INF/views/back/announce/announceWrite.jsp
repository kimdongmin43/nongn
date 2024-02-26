<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<link href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" rel="stylesheet" />
<script src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script src="/js/announce.js"></script>

<script>
var insertAnnounceUrl = "<c:url value='/back/announce/insertAnnounce.do'/>";
var updateAnnounceUrl = "<c:url value='/back/announce/updateAnnounce.do'/>"
var deleteAnnounceUrl = "<c:url value='/back/announce/deleteAnnounce.do'/>";

$(document).ready(function(){
	$(".onlynum").keyup( setNumberOnly );
	
	<c:if test="${param.mode == 'W' }">
	createActSubmit("actsubmit_tb", 1);
	</c:if>
	initDate();
});

function announceListPage() {
    var f = document.writeFrm;
    
    f.target = "_self";
    f.action = "/back/announce/announceListPage.do";
    f.submit();
}

function announceInsert(){
	
	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){
		   
		   var mngStaDt = $("#mng_stadt_dt").val()+""+$("#mng_stadt_hour").val()+""+$("#mng_stadt_min").val()+"00";
		   var mngEndDt = $("#mng_enddt_dt").val()+""+$("#mng_enddt_hour").val()+""+$("#mng_enddt_min").val()+"00";
		   if(($("#mng_stadt_dt").val() != "" && $("#mng_enddt_dt").val() != "")){
			    if(mngStaDt > mngEndDt){
				     alert("운영기간 시작일자가 종료일자보다 이후 일자가 올 수 없습니다.");
				     return;
			   }
			    $("#mng_stadt").val(mngStaDt);
			    $("#mng_enddt").val(mngEndDt);
		   }else{
			     alert("운영기간을 입력해주십시요.");
			     return;				   
		   }	    

		   var aplyStaDt = $("#aply_stadt_dt").val()+""+$("#aply_stadt_hour").val()+""+$("#aply_stadt_min").val()+"00";
		   var aplyEndDt = $("#aply_enddt_dt").val()+""+$("#aply_enddt_hour").val()+""+$("#aply_enddt_min").val()+"00";
		   if(($("#aply_stadt_dt").val() != "" && $("#aply_enddt_dt").val() != "")){
			    if(aplyStaDt > aplyEndDt){
				     alert("신청기간 시작일자가 종료일자보다 이후 일자가 올 수 없습니다.");
				     return;
			   }
			    $("#aply_stadt").val(aplyStaDt);
			    $("#aply_enddt").val(aplyEndDt);
		   }else{
			     alert("신청기간을 입력해주십시요.");
			     return;				   
		   }	  

		   var evalStaDt = $("#eval_stadt_dt").val()+""+$("#eval_stadt_hour").val()+""+$("#eval_stadt_min").val()+"00";
		   var evalEndDt = $("#eval_enddt_dt").val()+""+$("#eval_enddt_hour").val()+""+$("#eval_enddt_min").val()+"00";
		   if(($("#eval_stadt_dt").val() != "" && $("#eval_enddt_dt").val() != "")){
			    if(evalStaDt > evalEndDt){
				     alert("심사기간 시작일자가 종료일자보다 이후 일자가 올 수 없습니다.");
				     return;
			   }
			    $("#eval_stadt").val(evalStaDt);
			    $("#eval_enddt").val(evalEndDt);
		   }else{
			     alert("심사기간을 입력해주십시요.");
			     return;				   
		   }	  
		   
		   if(($("#rel_dt_dt").val() != "")){
			   var relDt = $("#rel_dt_dt").val()+""+$("#rel_dt_hour").val()+""+$("#rel_dt_min").val()+"00";
			    $("#rel_dt").val(relDt);
		   }else{
			     alert("발표일을 입력해주십시요.");
			     return;				   
		   }
		   
		   var submitStaDt = "", submitEndDt = ""; 
		   for(var i =1; i <= $("#act_month").val();i++){
			   submitStaDt = $("#submit_stadt_"+i).val()+""+$("#submit_stadt_hour_"+i).val()+""+$("#submit_stadt_min_"+i).val()+"00";
			   submitEndDt = $("#submit_enddt_"+i).val()+""+$("#submit_enddt_hour_"+i).val()+""+$("#submit_enddt_min_"+i).val()+"00";
			   if(($("#submit_stadt_"+i).val() != "" && $("#submit_enddt_"+i).val() != "")){
				    if(submitStaDt > submitEndDt){
					     alert(i+"차 활동보고서 제출기간 시작일자가 종료일자보다 이후 일자가 올 수 없습니다.");
					     return;
				   }
			   }else{
				     alert(i+"차 활동보고서 제출기간을 입력해주십시요.");
				     return;				   
			   }    
		   }
		   
		   url = insertAnnounceUrl;
		   if($("#mode").val() == "E") url = updateAnnounceUrl; 

		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						announceListPage();
  					}	
  				},
  				dataType: "json", 				
  				url: url
  		    });	
		   
	   }
}

function announceDelete(){
	   if(!confirm("소개페이지를 정말 삭제하시겠습니까?")) return;
	   
		$.ajax
		({
			type: "POST",
	           url: deleteAnnounceUrl,
	           data:{
	           	announce_id : $("#announce_id").val()
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					announceListPage();
				}	
			}
		});
}

function changeActMonth(){
	 var mon = $("#act_month").val();
	 //기존  활동보고서 제출기간 삭제
	 delTableRow("actsubmit_tb");
	 // 활동보고서 제출기간 생성
	 createActSubmit("actsubmit_tb", mon);
	 initDate();
}

</script>

<!--// content -->
<div id="content">
	<!-- title_and_info_area -->
	<div class="title_and_info_area">
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title">${MENU.menuNm}</h3>
		</div>
		<!--// main_title -->
		<jsp:include page="/WEB-INF/views/back/menu/menuDescInclude.jsp"/>
	</div>	
       <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
			<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
			<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
			<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
			<input type='hidden' id="p_year" name='p_year' value="${param.p_year}" />
		    <input type='hidden' id="p_open_yn" name='p_open_yn' value="${param.p_open_yn}" />
			<input type='hidden' id="mode" name='mode' value="${param.mode}" />
		    <input type='hidden' id="announc_id" name='announc_id' value="${announce.announc_id}" />
		    <input type='hidden' id="mng_stadt" name='mng_stadt' value="${announce.mng_stadt}" />
		    <input type='hidden' id="mng_enddt" name='mng_enddt' value="${announce.mng_enddt}" />
		    <input type='hidden' id="aply_stadt" name='aply_stadt' value="${announce.aply_stadt}" />
		    <input type='hidden' id="aply_enddt" name='aply_enddt' value="${announce.aply_enddt}" />
		    <input type='hidden' id="eval_stadt" name='eval_stadt' value="${announce.eval_stadt}" />
		    <input type='hidden' id="eval_enddt" name='eval_enddt' value="${announce.eval_enddt}" />
		    <input type='hidden' id="rel_dt" name='rel_dt' value="${announce.rel_dt}" />
			    
			<!-- write_basic -->
			<div class="table_area">
				  <table class="view">
					<caption>상세보기 화면</caption>
					<colgroup>
						<col style="width: 140px;" />
						<col style="width: *;" />
					</colgroup>
					<tbody>
					<c:if test="${param.mode == 'E' }">
					<tr>
						<th scope="row">회차  <span class="asterisk">*</span></th>
						<td >
						    ${announce.seq} 회차
							  <input type="hidden" id="seq" name="seq" value="${announce.seq}" />
						</td>
					</tr>
					</c:if>
					<tr>
						<th scope="row">공고연도  <span class="asterisk">*</span></th>
						<td >
							<c:if test="${param.mode == 'E' }">
						    ${announce.year} 년
						    </c:if>
						    <c:if test="${param.mode != 'E' }">
			                  <select id="year" name="year" class="in_wp60">
			                      <c:forEach var="i" begin="0" end="5">
			                         <option value="${curYear-i}" <c:if test="${(curYear-i) == announce.year}">selected</c:if>>${curYear-i}</option>
			                     </c:forEach>
			                  </select>
			                 </c:if> 
						</td>
					</tr>
					<tr>
						<th scope="row" >내용</th>
						<td >
                              <textarea class="in_w100" id="contents" name="contents" placeholder="내용" rows="4"  >${announce.contents}</textarea>
						</td>
					</tr>
					<tr>
						<th scope="row">활동개월(차)</th>
						<td >
							<c:if test="${param.mode == 'E' }">
						    ${announce.act_month} 개월
						    <input type="hidden" id="act_month" name="act_month" value="${announce.act_month}" />
						    </c:if>
						    <c:if test="${param.mode != 'E' }">
			                  <select id="act_month" name="act_month" class="in_wp100" onChange="changeActMonth()">
			                      <c:forEach var="i" begin="1" end="12">
			                         <option value="${i}" <c:if test="${i == announce.act_month}">selected</c:if>>${i}</option>
			                     </c:forEach>
			                  </select>
			                 </c:if>  
						</td>
					</tr>					
					<tr>
						<th scope="row">운영기간</th>
						<td >
                                <input type="text" id="mng_stadt_dt" name="mng_stadt_dt" class="in_wp100 datepicker" readonly value="${announce.mng_stadt}">
								<select class="in_wp80" id="mng_stadt_hour" name="mng_stadt_hour">
									 <c:forEach var="i" begin="0" end="23">
									      <c:set var="hour" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="hour" value="0${i}"/></c:if>
				                         <option value="${hour}" <c:if test="${hour == announce.mng_stadt_hour}">selected</c:if>>${hour}</option>
				                     </c:forEach>
								</select>
								<select class="in_wp80" id="mng_stadt_min" name="mng_stadt_min">
									 <c:forEach var="i" begin="0" end="59">
									      <c:set var="min" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
				                         <option value="${min}" <c:if test="${min == announce.mng_stadt_min}">selected</c:if>>${min}</option>
				                     </c:forEach>
								</select>
								<span>~</span>
                                <input type="text" id="mng_enddt_dt" name="mng_enddt_dt" class="in_wp100 datepicker" readonly value="${announce.mng_enddt}">
								<select class="in_wp80" id="mng_enddt_hour" name="mng_enddt_hour">
									 <c:forEach var="i" begin="0" end="23">
									      <c:set var="hour" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="hour" value="0${i}"/></c:if>
				                         <option value="${hour}" <c:if test="${hour == announce.mng_enddt_hour}">selected</c:if>>${hour}</option>
				                     </c:forEach>
								</select>
								<select class="in_wp80" id="mng_enddt_min" name="mng_enddt_min">
									 <c:forEach var="i" begin="0" end="59">
									      <c:set var="min" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
				                         <option value="${min}" <c:if test="${min == announce.mng_enddt_min}">selected</c:if>>${min}</option>
				                     </c:forEach>
								</select>
						</td>	
					</tr>
					<tr>
						<th scope="row">신청기간</th>
						<td >
                                <input type="text" id="aply_stadt_dt" name="aply_stadt_dt" class="in_wp100 datepicker" readonly value="${announce.aply_stadt}">
								<select class="in_wp80" id="aply_stadt_hour" name="aply_stadt_hour">
									 <c:forEach var="i" begin="0" end="23">
									      <c:set var="hour" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="hour" value="0${i}"/></c:if>
				                         <option value="${hour}" <c:if test="${hour == announce.aply_stadt_hour}">selected</c:if>>${hour}</option>
				                     </c:forEach>
								</select>
								<select class="in_wp80" id="aply_stadt_min" name="aply_stadt_min">
									 <c:forEach var="i" begin="0" end="59">
									      <c:set var="min" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
				                         <option value="${min}" <c:if test="${min == announce.aply_stadt_min}">selected</c:if>>${min}</option>
				                     </c:forEach>
								</select>								
								<span>~</span>
								<input type="text" id="aply_enddt_dt" name="aply_enddt_dt" class="in_wp100 datepicker" readonly value="${announce.aply_enddt}">
								<select class="in_wp80" id="aply_enddt_hour" name="aply_enddt_hour">
									 <c:forEach var="i" begin="0" end="23">
									      <c:set var="hour" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="hour" value="0${i}"/></c:if>
				                         <option value="${hour}" <c:if test="${hour == announce.aply_enddt_hour}">selected</c:if>>${hour}</option>
				                     </c:forEach>
								</select>
								<select class="in_wp80" id="aply_enddt_min" name="aply_enddt_min">
									 <c:forEach var="i" begin="0" end="59">
									      <c:set var="min" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
				                         <option value="${min}" <c:if test="${min == announce.aply_enddt_min}">selected</c:if>>${min}</option>
				                     </c:forEach>
								</select>
						</td>
					</tr>
					<tr>
						<th scope="row">심사기간</th>
						<td >
                                <input type="text" id="eval_stadt_dt" name="eval_stadt_dt" class="in_wp100 datepicker" readonly value="${announce.eval_stadt}">
								<select class="in_wp80" id="eval_stadt_hour" name="eval_stadt_hour">
									 <c:forEach var="i" begin="0" end="23">
									      <c:set var="hour" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="hour" value="0${i}"/></c:if>
				                         <option value="${hour}" <c:if test="${hour == announce.eval_stadt_hour}">selected</c:if>>${hour}</option>
				                     </c:forEach>
								</select>
								<select class="in_wp80" id="eval_stadt_min" name="eval_stadt_min">
									 <c:forEach var="i" begin="0" end="59">
									      <c:set var="min" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
				                         <option value="${min}" <c:if test="${min == announce.eval_stadt_min}">selected</c:if>>${min}</option>
				                     </c:forEach>
								</select>											
								<span>~</span>
                                <input type="text" id="eval_enddt_dt" name="eval_enddt_dt" class="in_wp100 datepicker" readonly value="${announce.eval_enddt}">
								<select class="in_wp80" id="eval_enddt_hour" name="eval_enddt_hour">
									 <c:forEach var="i" begin="0" end="23">
									      <c:set var="hour" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="hour" value="0${i}"/></c:if>
				                         <option value="${hour}" <c:if test="${hour == announce.eval_enddt_hour}">selected</c:if>>${hour}</option>
				                     </c:forEach>
								</select>
								<select class="in_wp80" id="eval_enddt_min" name="eval_enddt_min">
									 <c:forEach var="i" begin="0" end="59">
									      <c:set var="min" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
				                         <option value="${min}" <c:if test="${min == announce.eval_enddt_min}">selected</c:if>>${min}</option>
				                     </c:forEach>
								</select>								
						</td>
					</tr>
					<tr>
						<th scope="row">발표일</th>
						<td >
								<input type="text" id="rel_dt_dt" name="rel_dt_dt" class="in_wp100 datepicker" readonly value="${announce.rel_dt}">
								<select class="in_wp80" id="rel_dt_hour" name="rel_dt_hour">
									 <c:forEach var="i" begin="0" end="23">
									      <c:set var="hour" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="hour" value="0${i}"/></c:if>
				                         <option value="${hour}" <c:if test="${hour == announce.rel_dt_hour}">selected</c:if>>${hour}</option>
				                     </c:forEach>
								</select>
								<select class="in_wp80" id="rel_dt_min" name="rel_dt_min">
									 <c:forEach var="i" begin="0" end="59">
									      <c:set var="min" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
				                         <option value="${min}" <c:if test="${min == announce.rel_dt_min}">selected</c:if>>${min}</option>
				                     </c:forEach>
								</select>	
						</td>
					</tr>
					<tr>
						<th scope="row">공개여부</th>
						<td >
                              <input type="radio" name="open_yn" value="Y" <c:if test="${announce.open_yn == 'Y'}">checked</c:if>> 사용 <input type="radio" name="open_yn" value="N"  <c:if test="${announce.open_yn == 'N'}">checked</c:if>> 미사용
						</td>
					</tr>
					</tbody>
				</table>
			</div>
			<!--// write_basic -->
			
			<!-- table_area -->
			<div class="table_area">
				<table id="actsubmit_tb" class="list fixed">
					<caption>리스트 화면</caption>
					<colgroup>
						<col style="width: 25%;">
						<col style="width: *;">
					</colgroup>
					<thead>
					<tr>
						<th class="first" scope="col">활동 개월(차)</th>
						<th class="last" scope="col">활동보고서 제출기간</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="row" items="${actSubmitList}">
					<tr>
						<td class="first">${row.act_seq}차<input type="hidden" id="act_seq" name="act_seq" value="${row.act_seq}" /></td>
						<td class="last alignl">
							<input type="text" id="submit_stadt_${row.act_seq}" name="submit_stadt_${row.act_seq}" class="in_wp100 datepicker" readonly value="${row.submit_stadt}">
							<label for="submit_stadt_hour_${row.act_seq}" class="hidden">시간입력</label>
							<select class="in_wp80" id="submit_stadt_hour_${row.act_seq}" name="submit_stadt_hour_${row.act_seq}">
									 <c:forEach var="i" begin="0" end="23">
									      <c:set var="hour" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="hour" value="0${i}"/></c:if>
				                         <option value="${hour}" <c:if test="${hour == row.submit_stadt_hour}">selected</c:if>>${hour}</option>
				                     </c:forEach>
							</select>
							<label for="submit_stadt_min_${row.act_seq}" class="hidden">분입력</label>
							<select class="in_wp80" id="submit_stadt_min_${row.act_seq}" name="submit_stadt_min_${row.act_seq}">
									 <c:forEach var="i" begin="0" end="59">
									      <c:set var="min" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
				                         <option value="${min}" <c:if test="${min == row.submit_stadt_min}">selected</c:if>>${min}</option>
				                     </c:forEach>
							</select>
							&nbsp;~&nbsp;
							<input type="text" id="submit_enddt_${row.act_seq}" name="submit_enddt_${row.act_seq}" class="in_wp100 datepicker" readonly value="${row.submit_enddt}">
							<label for="submit_enddt_hour_${row.act_seq}" class="hidden">시간입력</label>
							<select class="in_wp80" id="submit_enddt_hour_${row.act_seq}" name="submit_enddt_hour_${row.act_seq}">
									 <c:forEach var="i" begin="0" end="23">
									      <c:set var="hour" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="hour" value="0${i}"/></c:if>
				                         <option value="${hour}" <c:if test="${hour == row.submit_enddt_hour}">selected</c:if>>${hour}</option>
				                     </c:forEach>
							</select>
							<label for="submit_enddt_min_${row.act_seq}" class="hidden">분입력</label>
							<select class="in_wp80" id="submit_enddt_min_${row.act_seq}" name="submit_enddt_min_${row.act_seq}">
									 <c:forEach var="i" begin="0" end="59">
									      <c:set var="min" value="${i}"/>
									      <c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
				                         <option value="${min}" <c:if test="${min == row.submit_enddt_min}">selected</c:if>>${min}</option>
				                     </c:forEach>
				            </select>
						</td>
					</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<!--// table_area -->
			
			<!-- button_area -->
			<div class="button_area">
				<div class="float_right">

					<c:if test="${param.mode == 'W' }">
					<a href="javascript:announceInsert('W');" class="btn save" title="저장">
						<span>저장</span>
					</a>
					</c:if>
					 <c:if test="${param.mode == 'E' }">
					<a href="javascript:announceInsert('M');" class="btn save" title="수정">
						<span>수정</span>
					</a>
					<a href="javascript:announceDelete();" class="btn save" title="삭제">
						<span>삭제</span>
					</a>
					</c:if>
					<a href="javascript:announceListPage();" class="btn cancel" title="취소">
						<span>취소</span>
					</a>
				</div>
			</div>
			<!--// button_area -->
</form>
</div>
<!--// content -->
