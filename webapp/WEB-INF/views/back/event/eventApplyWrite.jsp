<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<link type="text/css" rel="stylesheet" href="/css/front/reset.css" />
<link type="text/css" rel="stylesheet" href="/css/front/contents.css" />
<script src="/js/common_ui.js"></script>
<script>
var insertEventUrl = "<c:url value='/back/event/insertEventApplyEmp.do?menuId=${param.menuId}'/>";
var updateEventUrl = "<c:url value='/back/event/insertEventApplyEmp.do?menuId=${param.menuId}'/>"
var deleteEventUrl = "<c:url value='/back/event/deleteEvent.do?menuId=${param.menuId}'/>";
var eventViewUrl =  "<c:url value='/back/event/eventWrite.do?menuId=${param.menuId}'/>";
var updateStepChangeUrl = "<c:url value='/back/event/updateStepChange.do'/>";

$(document).ready(function(){
	selUser();

	$(".onlynum").keyup( setNumberOnly );



	$("input[name=aNm]").change(function (){
		selUser();
	});

	$('#compRegNo').on("keyup", function(event ) {
		keyUpBizNo($('#compRegNo'));
	});
});

function prePage() {
    var f = document.writeFrm;

    if(!confirm('작성된 내용은 모두 삭제되며, 이전 페이지로 이동합니다. \n진행 하시겠습니까?')) return;

    $('#mode').val("E");

    f.target = "_self";
    f.action = eventViewUrl;
    f.submit();
}

function eventApply() {
    var f = document.writeFrm;

    f.target = "_self";
    f.action = "/back/event/eventApplyListPage.do?menuId=${param.menuId}";
    f.submit();
}




function applyInsert(){

	 $('#applyCount').val($('input[name=aNm]').length- 1);

	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){

		   url = insertEventUrl;
		   if($("#mode").val() == "") $("#mode").val('W');
		   if($("#mode").val() == "E") url = insertEventUrl;



		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.success);
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						eventListPage();
  					}
  				},
  				fail: function(e){
  					alert("fail:"+e);

  				},
  				error: function(e){
  					alert("error:"+e);

  				},
  				dataType: "json",
  				url: url
  		    });

	   }
}

function addRow(){
	 if($('#applyList > tr').length>10){
		alert('10명 이상은 등록 할 수 없습니다.');
		return;
	}
	var oneRow = '';
	oneRow += '	<tr>';
	oneRow += '		<td><input type="checkbox" name="applyChk" class="delChk" /></td>';
	oneRow += '		<td><input type="text" name="aNm" class="w_100" data-parsley-required="true" /></td>';
	oneRow += '		<td><input type="text" name="aDept" class="w_100" /></td>';
	oneRow += '		<td><input type="text" name="aRank" class="w_100" data-parsley-required="true" /></td>';
	oneRow += '		<td><input type="text" name="aTel" class="w_100" data-parsley-required="true" /></td>';
	oneRow += '		<td><input type="text" name="aMobile" class="w_100" data-parsley-required="true" /></td>';
	oneRow += '		<td><input type="text" name="aFax" class="w_100" /></td>';
	oneRow += '		<td><input type="text" name="aEmail" class="w_100" data-parsley-required="true" /></td>';
	oneRow += '	</tr>';

	$('#applyList').append(oneRow);


	$("input[name=aNm]").change(function (){
		selUser();
	});

}


function selUser(){
	$('#copySel option').remove();
	$('#copySel').append("<option>참가자에서 선택</option>");
	$("input[name=aNm]").each(function (index){
		if($(this).val()!='')
		$('#copySel').append("<option value='"+index+"'>"+$(this).val()+"</option>");
	});
}

function  delRow(){
	$(':checkbox[name="applyChk"]:checked ').parents("tr").remove();
}

function allCheck(){
	if ($('input[name=allChk]').prop("checked")){
		$('input[name=applyChk]').prop("checked",true);
	}else{
		$('input[name=applyChk]').prop("checked",false);
	}
}

function copyCell(){
	var idx = $("#copySel option").index($("#copySel option:selected"));
	pushData(idx);
}

function pushData(idx){
	$('#managerWr input').each(function (){
		var name = $(this).attr("name").replace("manager","a");
		$(this).val(idx == 0?"":$('#applyList input[name='+name+']').eq(idx-1).val());
	});
}

function applyInsert2(){
	//alert($('form[name=writeFrm]').serialize());


}

function companyWrite() {

	var companyNo = $("#tempCompRegNo").val();
	var mode = companyNo =="" ? "W":"E";

	$('#pop_content').html("");
	$("#mode").val(mode);

	var regNo = $('#compRegNo').val().replace(/\-/g,'');

    $.ajax({
        url: "/back/company/companyWrite.do",
        dataType: "html",
        type: "post",
        data: {
        		coNo : companyNo,
             	mode : mode
		},
        	success: function(data) {
	        	$('#pop_content').html(data);
	        	$('#newcompRegNo').val(regNo);
	        	popupShow();
		},
		error: function(e) {
		    alert("테이블을 가져오는데 실패하였습니다.");
		}
    });
}
function companyInsert(){

	   if ( $("#writeFrm2").parsley().validate() ){
			$("#tempCompRegNo").val($('#newcompRegNo').val());
			$("#tempCompNm").val($('#conameHang').val());
			$("#tempBizType").val($('#bizkind').val());
			$("#tempBizForm").val($('#bizkindOrg').val());

		   url = "/back/company/insertCompany.do";
		   if($("#mode").val() == "E") url = "/back/company/updateCompany.do";
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm2").ajaxSubmit({
				success: function(responseText, statusText){

					if(responseText.success == "true"){
						alert($("#mode").val() == "E"?"수정되었습니다.":"등록되었습니다.");
						popupClose();
						pushCompany();
					}
				},
				dataType: "json",
				url: url,
				data : {
					mode:$("#mode").val()
				}
		    });

	   }
}

var userRatingYn= null;
var userRatingment = null;
function setMemberCode(){

	   $.ajax
		({
			type: "POST",
	           url:  "/back/member/member.do",
	           data:{
		        	compRegNo : $("#compRegNo").val(),
		        	chamCd : '${SITE.chamCd}'
	           },
	           dataType: 'json',
			success:function(data){
				var memCd = data.memCd;
				//alert(memCd);
				if($('#eventRat').val()=='D'){
					userRatingment = '본 행사(교육)는 기납(전전기) 회원사만 신청 가능합니다.';
					if (!(memCd=='C' || memCd=='D')){alert(userRatingment); userRatingYn='N';}
				}
				if($('#eventRat').val()=='C'){
					userRatingment = '본 행사(교육)는 기납(전기) 회원사만 신청 가능합니다.';
					if (memCd!='C'){alert(userRatingment); userRatingYn='N';}
				}
				if($('#eventRat').val()=='B'){
					userRatingment = '본 행사(교육)는 회원사만 신청 가능합니다.';
					if (memCd=='A'){alert(userRatingment); userRatingYn='N';}
				}
			}
		});
}

function pushCompany(){
	$('#companyNo').val($("#tempCompRegNo").val());
	$('#companyNm').val($("#tempCompNm").val());
	$('#bizType').val($("#tempBizType").val());
	$('#bizForm').val($("#tempBizForm").val());
	popClose();
}

function companyDelete(itemId){
	   if(!confirm("선택하신 메뉴 삭제 시 하부의 모든 메뉴도 삭제됩니다. 정말 삭제하시겠습니까?")) return;

		$.ajax
		({
			type: "POST",
	           url: deleteMenuUrl,
	           data:{
		        	coNo : $("#coNo").val()
	           },
	           dataType: 'json',
			success:function(data){
				if(data.success == "true"){
					alert('삭제되었습니다.');
					popupClose();
				}
			}
		});
}

function getCompany(){
	$.ajax
	({
		type: "POST",
           url: "/back/event/getCompany.do",
           data:{
        	   compRegNo : $("#compRegNo").val().replace(/\-/g,'')
           },
           dataType: 'json',
		success:function(data){
			if(data.success=='true'){
				$("td.title").html(data.companyMap.conameHang);
				$("td.bsnNo").html(data.companyMap.compRegNo);
				$("#tempCompRegNo").val(data.companyMap.compRegNo);
				$("#tempCompNm").val(data.companyMap.conameHang);
				$("#tempBizType").val(data.companyMap.bizType);
				$("#tempBizForm").val(data.companyMap.item);
				$("#selCompany").css('display','');
				alert(data.companyMap.localDb);
				if(data.companyMap.localDb=='Y'){
					$("#newCompany").css('display','');
					if($('#eventRat').val()=='B' || $('#eventRat').val()=='C' ||$('#eventRat').val()=='D' ){
						userRatingment = '본 행사(교육)는 회원사만 신청 가능합니다.';
						alert(userRatingment);
						userRatingYn='N';
					}
				}else{
					setMemberCode();
				}
			}else{
				if($('#eventRat').val()=='B'){
					userRatingment = '본 행사(교육)는 회원사만 신청 가능합니다.';
					alert(userRatingment);
					userRatingYn='N';
					return;
				}else if($('#eventRat').val()=='C' || $('#eventRat').val()=='D' ){
					userRatingment = '본 행사(교육)는 기납 회원사만 신청 가능합니다.';
					alert(userRatingment);
					userRatingYn='N';
					return;
				}else{
					if(!confirm('상공회의소에 등록되지 않은 기업정보입니다.\n 입력하신 사업자등록번호를 확인하시기 바랍니다.\n 본 행사등록을 위해서는 기업정보를 등록하여야 합니다.\n 등록하시겠습니까?')) return;
				}
				$("td.title").html('검색 결과 없음');
				$("td.bsnNo").html("");
				$("#tempCompRegNo").val("");
				$("#tempCompNm").val("");
				$("#tempBizType").val("");
				$("#tempBizForm").val("");
				companyWrite();
			}
		}
	});
}

function popupShow(){
	$("#modal-menu-write").modal('show');
}
function popupClose(){
	$("#modal-menu-write").modal("hide");
}

//사업자 번호 체크(keyup)
function keyUpBizNo(obj) {
	var regExp = /^[0-9]*$/;
	if(!regExp.test(obj.val())) {
		obj.val(obj.val().replace(/[^0-9]/gi,""));
	}

	var bizNo = obj.val();
	bizNo = bizNo.replace(/\-/g, "");
	if(bizNo.length > 5) {
		bizNo = bizNo.substr(0, 3) + "-" + bizNo.substr(3, 2) + "-" + bizNo.substr(5);
	} else if(bizNo.length > 3) {
		bizNo = bizNo.substr(0, 3) + "-" + bizNo.substr(3);
	}

	bizNo = bizNo.substr(0, 12);
	obj.val(bizNo);
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
				<input type='hidden' id="p_searchStatus" name='p_searchStatus' value="${param.p_searchStatus}" />
				<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="${param.p_searchtxt}" />
				<input type='hidden' id="p_reg_stadt" name='p_reg_stadt' value="${param.p_reg_stadt}" />
				<input type='hidden' id="pStartDy" name='pStartDy' />
				<input type='hidden' id="pEndDy" name='pEndDy' />
				<input type='hidden' id="eventId" name='eventId' value="${event.eventId}" />
			    <input type='hidden' id="projectId" name = "projectId" value = "${event.projectId}" />
			    <input type='hidden' id="projectSeq" name = "projectSeq" value = "${event.projectSeq}" />
			    <input type='hidden' id="projectCd" name = "projectCd" value = "${event.projectCd}" />
				<input type='hidden' id="eventRat" name='eventRat' value="${event.targetMemCd}" />
				<input type='hidden' id="memCd" name='memCd' value="" />
				<input type='hidden' id="mode" name='mode' value="${param.applyMode}" />
				<input type='hidden' id="applySeq" name='applySeq' value="${param.applySeq}" />
				<input type='hidden' id="applyCount" name = "applyCount" />
			     <input type='hidden' id="contents" name = "contents" />
				<input type="hidden" id="tempCompRegNo" value="" />
				<input type="hidden" id="tempCompNm" value="" />
				<input type="hidden" id="tempBizType" value="" />
				<input type="hidden" id="tempBizForm" value="" />

				<input type="hidden" name="aNm" value="" />
				<input type="hidden" name="aDept" value="" />
				<input type="hidden" name="aRank" value="" />
				<input type="hidden" name="aTel" value="" />
				<input type="hidden" name="aMobile" value="" />
				<input type="hidden" name="aFax" value="" />
				<input type="hidden" name="aEmail" value="" />

			<!-- write_basic -->
			<div class="table_area">
				 <div class="contents_detail">
					<!--//S: 행사교육신청 -->
					<div class="event_app">
						<div class="event_app_tit">
							<h3>${event.title}</h3>
							<div class="event_info">담당부서 : ${event.deptNm } | 담당자 : ${event.managerNm } | 일자 : ${event.seDt }</div>
						</div>
						<h4>회사정보</h4>
						<div class="datalist">
							<table cellspacing="0" cellpadding="0" >
								<caption>회사정보 입력표.회사정보 게시글을 회사명, 사업자번호, 업종, 업태 순으로 정보를 작성하실 수 있습니다.</caption>
								<colgroup>
									<col style="width:20%" />
									<col style="width:30%" />
									<col style="width:20%" />
									<col style="width:30%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="col">회사명(*)</th>
										<td><input type="text"  id="companyNm" name="companyNm" value="${apply.companyNm }" readonly class="w_b" /><button type="button" class="btn-ask" title="조회" onclick="popOpen($('.p1'))">조회</button></td>
										<th scope="col">사업자번호</th>
										<td><input type="text" id="companyNo" name="companyNo" value="${apply.companyNo }" readonly class="w_b" /><button type="button" class="btn-ask" title="조회" onclick="popOpen($('.p1'))">조회</button></td>
									</tr>
									<tr>
										<th scope="col">업종</th>
										<td><input type="text" id="bizType" name="bizType" value="${apply.bizType }" class="w_100" /></td>
										<th scope="col">업태</th>
										<td><input type="text" id="bizForm" name="bizForm" value="${apply.bizForm }" class="w_100" /></td>
									</tr>
								</tbody>
							</table>
						</div>
						<h4>참가자명단 (*)은 필수 입력정보입니다.</h4>
						<div class="float_right">
						<a class="btn look" href="javascript: addRow()">+ 추가</a><a class="btn look" href="javascript: delRow()">- 삭제</a>
						</div>
						<div class="datalist2" onblur="mkOp();">
							<table cellspacing="0" cellpadding="0">
								<caption>참가자명단 입력표.참가자명단 게시글을 성명, 부서명, 직책, 전화번호, 핸드폰번호, 팩스번호, 이메일 순으로 정보를 작성하실 수 있습니다.</caption>
								<colgroup>
									<col style="width:9%" />
									<col style="width:13%" />
									<col style="width:13%" />
									<col style="width:13%" />
									<col style="width:13%" />
									<col style="width:13%" />
									<col style="width:13%" />
									<col style="width:13%" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col"><input type="checkbox" onclick="allCheck();" name="allChk" /></th>
										<th scope="col">성명(*)</th>
										<th scope="col">부서명</th>
										<th scope="col">직책(*)</th>
										<th scope="col">전화번호(*)</th>
										<th scope="col">핸드폰번호(*)</th>
										<th scope="col">팩스번호</th>
										<th scope="col">이메일(*)</th>
									</tr>
								</thead>
								<tbody id="applyList">
									<c:forEach items="${applyList }" var="aL" varStatus="i">
									<tr>
										<td><input type="checkbox" name="applyChk" class="delChk" /></td>
										<td><input type="text" name="aNm" value="${aL.empNm }" class="w_100" data-parsley-required="true" /></td>
										<td><input type="text" name="aDept" value="${aL.deptNm }" class="w_100" /></td>
										<td><input type="text" name="aRank" value="${aL.rankNm }" class="w_100" data-parsley-required="true" /></td>
										<td><input type="text" name="aTel" value="${aL.tel }" class="w_100" data-parsley-required="true" /></td>
										<td><input type="text" name="aMobile" value="${aL.mobile }" class="w_100" data-parsley-required="true" /></td>
										<td><input type="text" name="aFax" value="${aL.fax }" class="w_100" /></td>
										<td><input type="text" name="aEmail" value="${aL.email }" class="w_100" data-parsley-required="true" /></td>
									</tr>
									</c:forEach>
									<c:if test="${fn:length(applyList)<10}">
									<tr>
										<td><input type="checkbox" name="applyChk" class="delChk"/></td>
										<td><input type="text" name="aNm" class="w_100" data-parsley-required="true"  /></td>
										<td><input type="text" name="aDept" class="w_100" /></td>
										<td><input type="text" name="aRank" class="w_100" data-parsley-required="true" /></td>
										<td><input type="text" name="aTel" class="w_100" data-parsley-required="true" /></td>
										<td><input type="text" name="aMobile" class="w_100" data-parsley-required="true" /></td>
										<td><input type="text" name="aFax" class="w_100" /></td>
										<td><input type="text" name="aEmail" class="w_100" data-parsley-required="true" /></td>
									</tr>
									</c:if>
								</tbody>
							</table>
						</div>
						<h4>신청담당자 정보</h4>
						<div class="select_type">
							<select id="copySel" onchange="copyCell()">
								<option>참가자에서 선택</option>
							</select>
						</div>
						<div class="datalist">
							<table cellspacing="0" cellpadding="0">
								<caption>신청담당자 정보 입력표.신청담당자 정보 게시글을 성명, 사업자번호, 직책, 업태, 핸드폰번호, 사업자번호, 이메일, 메일수신동의 순으로 정보를 작성하실 수 있습니다.</caption>
								<colgroup>
									<col style="width:20%" />
									<col style="width:30%" />
									<col style="width:20%" />
									<col style="width:30%" />
								</colgroup>
								<tbody id="managerWr">
									<tr>
										<th scope="col">성명(*)</th>
										<td><input type="text" name="managerNm" value="${apply.managerNm }" class="w_100" data-parsley-required="true"  /></td>
										<th scope="col">부서명</th>
										<td><input type="text" name="managerDept" value="${apply.detpNm }" class="w_100" /></td>
									</tr>
									<tr>
										<th scope="col">직책(*)</th>
										<td><input type="text" name="managerRank" value="${apply.rankNm }" class="w_100" data-parsley-required="true"  /></td>
										<th scope="col">전화번호(*)</th>
										<td><input type="text" name="managerTel" value="${apply.tel }" class="w_100" data-parsley-required="true"  /></td>
									</tr>
									<tr>
										<th scope="col">핸드폰번호(*)</th>
										<td><input type="text" name="managerMobile" value="${apply.mobile }" class="w_100" data-parsley-required="true"  /></td>
										<th scope="col">팩스번호</th>
										<td><input type="text" name="managerFax" value="${apply.fax }" class="w_100" /></td>
									</tr>
									<tr>
										<th scope="col">이메일(*)</th>
										<td colspan="3"><input type="text" name="managerEmail" value="${apply.email }" class="w_100" data-parsley-required="true"  /></td>
									</tr>
									<tr>
										<th scope="col">메일수신동의(*)</th>
										<td colspan="3">향후 상공회의소 교육 ∙ 행사안내 메일을 받는데 동의하십니까? <span class="iradio on"><input type="radio" class="radio" name="managerEmailUse" id="open" checked value="Y" /><label for="open">공개</label></span>
										<span class="iradio"><input type="radio" class="radio" id="notopen" name="managerEmailUse" value="N" /><label for="notopen">비공개</label></span></td>
									</tr>
								</tbody>
							</table>
						</div>
						<h4>개인정보 수집 및 이용안내</h4>
						<textarea></textarea>
						<div class="event_btn">
							<button href="#none" type="button" class="btn2 btn-event" title="신청" onclick="applyInsert()">신청</button>
							<button href="#none" type="button" class="btn2 btn-event" title="취소" onclick="prePage()">취소</button>
						</div>
					</div>
					<!--//E: 행사교육신청 -->
				</div>
			</div>
			<!--// write_basic -->
</form>
	<div id="popup_wrap">
	<!-- .p1 : E -->
		<div class="popup pop_w2 p1">
			<div class="popup_inner">
				<div class="tit">
					회사검색
					<button type="button" class="but_close" title="팝업 닫기" onClick="javascript:popClose()"><img src="/images/family_close.png"></button>
				</div>
				<div class="con">
					<div class="datalist">
						<div class="input_box2">
							<label for="compRegNo">사업자번호</label>
							<input type="text" id="compRegNo" class="onlynum" />
							<button onclick="getCompany();" type="button" class="btn_popup">검색</button>
						</div>
						<div class="boardlist">
							<table cellspacing="0" cellpadding="0">
								<caption>회사 목록표.회사검색된 내용을 회사명, 사업자번호 순으로 정보를 확인하실 수 있습니다.</caption>
								<colgroup>
									<col style="width:60%" />
									<col style="width:40%" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">회사명</th>
										<th scope="col">사업자번호</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="title"></td>
										<td class="bsnNo"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- 버튼 -->
					<div class="btn_wrap">
						<button type="button" class="btn-default" onclick="companyWrite();" id="newCompany" style="display:none">수정</button>
						<button type="button" class="btn-default" onclick="pushCompany();" id="selCompany" style="display:none">확인</button>
						<button type="button" class="btn-default" onClick="javascript:popClose()">취소</button>
					</div>
					<!-- 버튼 끝 -->
				</div>
			</div>
		</div>
		<!-- //.p1 : E -->
	</div>
	<div class="modal fade" id="modal-menu-write" >
	<div class="modal-dialog modal-size-800">
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 class="pop_title">회사등록</h1>
			<a href="javascript:popupClose()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area">
			    <div  id="pop_content" >
			    </div>
			</div>
		</article>
		</div>
		<!-- //container -->
	</div>
</div>
</div>

