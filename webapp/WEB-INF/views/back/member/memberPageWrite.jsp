<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>



<script>

var insertMemberpageUrl = "<c:url value='/back/member/memberInsert.do'/>";
var deleteMemberpageUrl = "<c:url value='/back/member/memberDelete.do'/>";
var updateMemberPassUrl = "<c:url value='/back/member/memberPassUpdate.do'/>";
var joinPrt = "<c:url value='/back/member/memberJoinPrt.do'/>";
var passwordCheckYn = 'N';

$(document).ready(function(){
	$("#passwordCheck").keyup(function() {
		if($("#passwordCheck").val() != $("#password").val()){
			$("#passwordLable").css("color","red");
			$("#passwordLable").text("비밀번호가 일치하지 않습니다.");			
		}
		else{
			$("#passwordLable").css("color","blue");
			$("#passwordLable").text("비밀번호 일치.");
		}
		
		
		});	
});


function memberPageList() {

    var f = document.writeFrm;
    f.target = "_self";
    f.action = "/back/member/memberPageList.do";
    f.submit();
}

function memberInsert() {

	   var url = "";
	   url = insertMemberpageUrl;
	   
	   if ($("#writeFrm").parsley().validate()){
	   // 데이터를 등록 처리해준다.
	   
	if($("#passwordCheck").val() != $("#password").val()){
		alert("비밀번호가 일치하지 않습니다.");
		return;
	}
	   
	   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						memberPageList();
					}
				},
				dataType: "json",
				url: url
		    });
	   }
}
function memberDelete(){
	   if(!confirm("정말 삭제하시겠습니까?")) return;

		$.ajax
		({
			type: "POST",
	           url: deleteMemberpageUrl,
	           data:{
	           	memberId : $("#memberId").val()
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					memberPageList();
				}
			}
		});
}

/* 
function memberPass()
{

	if(!confirm("승인처리 하시겠습니까?")){
		return;
	}

	$.ajax
	({
		type: "POST",
           url: updateMemberPassUrl,
           data:{
           	memberId : $("#memberId").val()
           },
           dataType: 'json',
		success:function(data){
			if(data.success == "true"){
				alert("승인처리 되었습니다.");
				$("#passYn").hide();
			}
		}
	});
}
 */

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
				<input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
				<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="<c:out value="${param.p_searchtxt}" escapeXml="true" />" />
			    <input type='hidden' id="p_satis_yn" name='p_satis_yn' value="${param.p_satis_yn}" />
				<input type='hidden' id="mode" name='mode' value="${param.mode}" />
			    <input type='hidden' id="memberId" name='memberId' value="${memberInfo.memberId}" />
			<!-- write_basic -->
			<div class="table_area">
						<table class="write">
							<caption>신청담당자 정보 등록 화면</caption>
							<colgroup>
								<col style="width: 10%;">
								<col style="width: *%;">								
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">
									<label for="memberNm">이름 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="memberNm" name="memberNm" type="text" maxlength="100" class="in_w15" data-parsley-required="true" value = "${memberInfo.memberNm}"/>
								</td>								
							</tr>
							<tr>
								<th scope="row">
									<label for="loginId">아이디 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="loginId" name="loginId" type="text" class="in_w15" maxlength="100" data-parsley-required="true" value = "${memberInfo.loginId}"/>
								</td>								
							</tr>
							<tr>
								<th scope="row">
									<label for="password">비밀번호 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="password" name="password" type="password" class="in_w15"  data-parsley-required="true" maxlength="100" value = "${memberInfo.password}" title="비밀번호"/>
								</td>								
							</tr>
							<tr>
								<th scope="row">
									<label for="passwordCheck">비밀번호 확인 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="passwordCheck" name="passwordCheck" type="password" class="in_w15" data-parsley-required="true" maxlength="100"  value = "${memberInfo.password}" title="비밀번호 확인"/>
									<label id = "passwordLable"></label>
								</td>								
							</tr>
							<tr>
								<th scope="row">
									<label for="useYn">상태설정 </label>
								</th>
								<td>
									<input name="useYn" type="radio" value = "Y" <c:if test = "${memberInfo.useYn eq null or memberInfo.useYn eq 'Y' }">checked="checked"</c:if>   />&nbsp;사용
									<input name="useYn" type="radio" value = "N" <c:if test = "${memberInfo.useYn eq 'N' }">checked="checked"</c:if> />&nbsp;사용중지
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
 					<c:if test="${param.mode == 'W' }">
					<a  href="javascript:memberInsert();" class="btn save" title="저장">
						<span>저장</span>
					</a>
					</c:if>
					 <c:if test="${param.mode == 'E' }">					
					<a href="javascript:memberInsert();" class="btn save" title="수정">
						<span>수정</span>
					</a>
					<a href="javascript:memberDelete();" class="btn save" title="삭제">
						<span>삭제</span>
					</a>
					</c:if>
					<a href="javascript:memberPageList();" class="btn cancel" title="취소">
						<span>취소</span>
					</a>
				</div>
			</div>
			<!--// button_area -->
</form>
</div>
<!--// content -->
