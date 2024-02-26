<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="/assets/jquery/jquery.ui.datepicker.js"></script>
<link href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" rel="stylesheet">




<script>
var insertMemberpageUrl = "<c:url value='/back/member/memberInsert.do'/>";
var deleteMemberpageUrl = "<c:url value='/back/member/memberDelete.do'/>";
var updateMemberPassUrl = "<c:url value='/back/member/memberPassUpdate.do'/>";
var joinPrt = "<c:url value='/back/member/memberJoinPrt.do'/>";



$(document).ready(function(){


	selOption("${investParam.departCd}");
	$("#investYear").val("${investParam.investYear}");

});

function selOption(str){
	$("#departCdSecond").val(str);
	$("#departCdFirst").val(str);

	if ($("#departCdSecond").val()==str) {
		$("#departCdSecond").css("display","");
		$("#departCdFirst").val('농림축산식품');
	}
}

function investListPage() {

    var f = document.writeFrm;
    f.target = "_self";
    f.action = "/back/contents/investListPage.do";
    f.submit();
}

function investWrite(mode){

	var url = "";
	modeParam = mode;
	url = modeParam=="W"?"/back/contents/investInsert.do":"/back/contents/investUpdate.do";
	if ($("#departCdFirst").val()=='농림축산식품') {
		$("#departCd").val($("#departCdSecond").val());
	}else{
		$("#departCd").val($("#departCdFirst").val());
	}



	if ($("#writeFrm").parsley().validate()){

			if(confirm("저장 하시겠습니까?")){
				$.ajax({
					type: "POST",
					url: url,
					data :$("#writeFrm").serialize(),
					dataType: 'json',
					async : false,
					success:function(data){
						if(data.success == "true"){
							alert(data.message);
							investListPage();
						}
						else 	alert("실패");
					}
				});


			}
		}

}

function investDelete(){
	   if(!confirm("정말 삭제하시겠습니까?")) return;

		$.ajax
		({
			type: "POST",
	           url: "/back/contents/investDelete.do",
	           data :$("#writeFrm").serialize(),
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					investListPage();
				}
			}
		});
}


function secondDropDownSet(item){

	if (item.value == "농림축산식품") {
		$("#departCdSecond").css("display","");
	} else {
		$("#departCdSecond").css("display","none");
	}
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
				<input type='hidden' id="contents" name='contents' value=' ${intropage.contents}' />
				<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
				<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
				<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
				<input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
				<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="<c:out value="${param.p_searchtxt}" escapeXml="true" />" />
			    <input type='hidden' id="p_satis_yn" name='p_satis_yn' value="${param.p_satis_yn}" />
				<input type='hidden' id="mode" name='mode' value="${param.mode}" />
				<input type='hidden' id="investId" name="investId" value="${investParam.investId}" />
				<input type='hidden' id="departCd" name="departCd" value="${investParam.departCd}" />

			<!-- write_basic -->
			<div class="table_area">
						<table class="write">
							<caption>신청담당자 정보 등록 화면</caption>
							<colgroup>
								<col style="width: 14%;">
								<col style="width: *;">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row" style = 'text-align: center;'>
									<label for="select">투자분야 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<select id="departCdFirst"  name = "departCdFirst" class="in_w15" onchange="secondDropDownSet(this)" data-parsley-required="true">
										<option value=""> 선택</option>
										<option value="농식품 통합지원">농식품 통합지원</option>
										<option value="그린바이오">그린바이오</option>
										<option value="스마트농업">스마트농업</option>
										<option value="세컨더리(혼합형)">세컨더리(혼합형)</option>
										<option value="농림축산식품">농림축산식품</option>
										<option value="8대 사업">8대 사업</option>
										<option value="수산업">수산업</option>
										<option value="6차 산업화">6차 산업화</option>
										<option value="AgroSeed">AgroSeed</option>
										<option value="R&D">R&D</option>
										<option value="수출">수출</option>
										<option value="창업아이디어">창업아이디어</option>
										<option value="스마트팜">스마트팜</option>
										<option value="ABC펀드">ABC펀드</option>
										<option value="세컨더리펀드">세컨더리펀드</option>
										<option value="농식품벤처펀드">농식품벤처펀드</option>
										<option value="지역특성화펀드(경기도)">지역특성화펀드(경기도)</option>
										<option value="지역특성화펀드(경북)">지역특성화펀드(경북)</option>
										<option value="마이크로">마이크로</option>
										<option value="징검다리">징검다리</option>
										<option value="수산벤처창업">수산벤처창업</option>
										<option value="영파머스">영파머스</option>
										<option value="창업보육">창업보육</option>
										<option value="소형프로젝트">소형프로젝트</option>
										<option value="지역특성화(전북)">지역특성화(전북)</option>
										<option value="푸드테크">푸드테크</option>
										<option value="스마트양식산업혁신">스마트양식산업혁신</option>
									</select>

									<select id="departCdSecond" name = "departCdSecond" class="in_w15" style="display: none;">
										<option value="농림축산식품">농림축산식품</option>
										<option value="농림축산업">농림축산업</option>
										<option value="식품사업">식품사업</option>
										<option value="농림수산식품">농림수산식품</option>
										<option value="농림수산업">농림수산업</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row" style = 'text-align: center;'>
									<label for="investYear">년도 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
								<select id="investYear" name = "investYear" class = "in_w15" data-parsley-required="true">
							        <option value="">전체</option>
          							<c:set var="today" value="<%=new java.util.Date()%>" />
          							<fmt:formatDate value="${today}" pattern="yyyy" var="end"/>
          							<c:forEach begin="2010" end="${end+1}" var="idx" step="1">
           							<option value="<c:out value="${idx}" />">
									<c:out value="${idx}" /></option>
          							</c:forEach>
								</select>
								</td>
							</tr>
							<tr>
								<th scope="row" style = 'text-align: center;'>
									<label for="company">운용사 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="company" name="company" type="text" class="in_w60" data-parsley-required="true" value = "${investParam.company}"/>
								</td>
							</tr>
							<tr>
								<th scope="row" style = 'text-align: center;'>
									<label for="copart">조합명 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="copart" name="copart" type="text" class="in_w60"  maxlength="100" value = "${investParam.copart}" data-parsley-required="true" />
								</td>
							</tr>
							<tr>
								<th scope="row" style = 'text-align: center;'>
									<label for="phone">전화 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<%-- <input id="repEmail" name="repEmail" type="text" class="in_w30" data-parsley-type="email" data-parsley-required="true" maxlength="50" value = "${memberInfo.repEmail }"/> --%>
									<input id="phone" name="phone" type="text" class="in_w30"  data-parsley-required="true" maxlength="50" value = "${investParam.phone }"/>
								</td>
							</tr>
							<tr>
								<th scope="row" style = 'text-align: center;'>
									<label for="addr">주소 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="addr" name="addr" type="text" class="in_w60"  maxlength="200" value = "${investParam.addr}" data-parsley-required="true" />
								</td>
							</tr>
							<tr>
								<th scope="row" style = 'text-align: center;'>홈페이지</th>
								<td>
									<label for="homepage" class="hidden">홈페이지 주소 입력</label>
			  					 	<input class="in_w60" type="text" id="homepage" name="homepage" value="<c:if test = '${investParam.homepage eq null}'>http://</c:if><c:if test = '${investParam.homepage ne null}'>${investParam.homepage}</c:if>" placeholder="http://" data-parsley-type="http"  data-parsley-maxlength="100" />
								</td>
							</tr>
							<tr>
								<th scope="row" style = 'text-align: center;'>
									<label for="scale">조합규모 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="scale" name="scale" type="text" class="in_w15" maxlength="100" value = "${investParam.scale}" data-parsley-type="digits"  data-parsley-required="true" /> 억원(숫자만입력)
								</td>
							</tr>
							<tr>
								<th scope="row" style = 'text-align: center;'>
									<label for="startDy">투자기간</label>
								</th>
								<td>
									<input type="text" id="startDy" name="startDy" class="in_wp100 datepicker" readonly value="${investParam.investSdt}" />
									~
									<input type="text" id="endDy" name="endDy" class="in_wp100 datepicker" readonly value="${investParam.investEdt}" />
								</td>
							</tr>

							</tbody>
						</table>
					</div>
					<!--// table_area -->
			<!--// write_basic -->

			<!-- button_area -->
			<div class="button_area">
				<div class="float_right">
 					<c:if test = "${memberInfo.useYn eq 'N' }">

					<a id="passYn" href="javascript:memberPass();" class="btn save" title="승인">
						<span>승인</span>
					</a>
					</c:if>

					<c:if test="${param.mode == 'W' }">
					<a  href="javascript:investWrite('W');" class="btn save" title="저장">
						<span>저장</span>
					</a>
					</c:if>
					 <c:if test="${param.mode == 'E' }">
					<a href="javascript:investWrite('E');" class="btn save" title="수정">
						<span>수정</span>
					</a>
					<a href="javascript:investDelete();" class="btn save" title="삭제">
						<span>삭제</span>
					</a>
					</c:if>
					<a href="javascript:investListPage();" class="btn cancel" title="취소">
						<span>취소</span>
					</a>
				</div>
			</div>
			<!--// button_area -->
</form>
<form id = "joinForm">
	<input type="hidden" id = "joinFormId">
</form>
</div>
<!--// content -->


<script>
$('.datepicker').each(function(){
	 $(this).datepicker({
		  dateFormat : "yy.mm",
		  language: "kr",
		  keyboardNavigation: false,
		  forceParse: false,
		  autoclose: true,
		  todayHighlight: true,
		  showOn: "button",
		  buttonImage:"/images/back/icon/icon_calendar.png",
		  buttonImageOnly:true,
		  changeMonth: true,
         changeYear: true,
         showButtonPanel:false
		 })});

</script>
