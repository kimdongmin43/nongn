<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<link href="/assets/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" />
<script src="/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>

<script>
var insertUserUrl = "<c:url value='/back/user/insertUser.do'/>";
var updateUserUrl = "<c:url value='/back/user/updateUser.do'/>"
var deleteUserUrl = "<c:url value='/back/user/deleteUser.do'/>";
var userIdCheckUrl = "<c:url value='/back/user/userIdCheck.do'/>";
var updatePasswordChangeUrl = "<c:url value='/back/user/updatePasswordChange.do'/>";
var ssoSearchYn = "N";
var user_auth= ${USER_AUTH};



$(document).ready(function(){
	$(".onlynum").keyup( setNumberOnly );
	if(user_auth<999){
		$("#userCd option[value=999]").remove();
	}
	
	
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

function userListPage() {
    var f = document.writeFrm;

    f.target = "_self";
    f.action = "/back/user/managerListPage.do";
    f.submit();
}

function userInsert(str){

	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){

			
			var userCd = $("#userCd").val();
			if(userCd == ""){
			alert("사용자 구분을 선택해주십시요.");
			return;
			}
			var loginId = $("#loginId").val();
			if(loginId == "" || !(loginId.length >= 5 &&  loginId.length <= 15)){
			alert("아이디는 최소 5자 ~ 최대 15자 영문,숫자만 사용 가능합니다. ");
			return;
			}

		


			/* var userPw = $("#password").val();
			if(userPw == ""){
			alert("패스워드를 입력해주십시요.");
			return;
			} */

			/* if(!checkPass(userPw)) return; */


		   	if(!(($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != "") || ($("#tel_1").val() == "" && $("#tel_2").val() == "" && $("#tel_3").val() == ""))){
				alert("내선번호를 정확히 입력해주십시요");
				$("#tel_1").focus();
				return;
			}
			if($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != ""){
			 	$("#tel").val($("#tel_1").val()+"-"+$("#tel_2").val()+"-"+$("#tel_3").val());
			}else{
			 	$("#tel").val("");
			}

			if($("#userCd").val() == ""){
				alert("사용자 구분을 선택해주십시요.");
				return;
			}
			
			if (str=='W') {
				
				if($("#id_chk_yn").val() == "N" || loginId != $("#checked_id").val()){
					alert("아이디 중복확인을 해주십시요.");
					return;
					}
				
				if($("#password").val()!=$("#passwordCheck").val()){
					alert("비밀번호가 일치하지 않습니다.")
					return;
				}				
			}

			url = insertUserUrl;
			if($("#mode").val() == "E") url = updateUserUrl;

			// 데이터를 등록 처리해준다.
			$("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						userListPage();
					}
				},
				dataType: "json",
				url: url
		  	});

	   }
}

function userDelete(){
	   if(!confirm("관리자를 정말 삭제하시겠습니까?")) return;

		$.ajax
		({
			type: "POST",
	           url: deleteUserUrl,
	           data:{
	           	userId : $("#userId").val()
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					userListPage();
				}
			}
		});
}

function pwdInit(){
	   if(!confirm("관리자의 비밀번호를 정말 초기화하시겠습니까?")) return;

		$.ajax
		({
			type: "POST",
	           url: updatePasswordChangeUrl,
	           data:{
	           	userId : $("#userId").val()
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
			}
		});
}

function idValidate(){
	var loginId = $("#loginId").val();
	 /* if(loginId == "" || !(loginId.length >= 5 &&  loginId.length <= 15) || onOnlyAlphaNumber(loginId)){
		 alert("아이디는 최소 5자 ~ 최대 15자 영문,숫자만 사용 가능합니다. ");
		 return;
	 } */

	 $.ajax
	 ({
			type: "POST",
	           url: userIdCheckUrl,
	           data:{
	           	loginId : loginId
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					$("#id_chk_yn").val("Y");
					$("#checked_id").val(loginId);
				}
			}
		});

}
function userFindSite(txt){

	$("#siteList").find("li").hide();
	$("#siteList").find("li:contains("+txt+")").show();

	if(txt.length < 1 || $("#siteList").find("li:contains("+txt+")").length < 1){
		$("#siteList").hide();
	}else{
		$("#siteList").show();
		if(window.event.keyCode == 13){
			var id ='';
			$("#siteList").children("li").each(function(){
				if($(this).is(":visible")){
					id= $(this).find("input[name=selSiteId]").val();
				}
				return;
			});
			var nm ='';
			$("#siteList").children("li").each(function(){
				if($(this).is(":visible")){
					nm= $(this).find("input[name=selSiteNm]").val();
				}
				return;
			});

			userSetSite(id,nm);
		}
	}
}
function userSetSite(id,nm){
	$("#siteNm").val(nm);
	$("#siteId").val(id);
	$("#siteList").hide();
}

// SSO 연동 사용자 리스트 가져오기
function managerPopup(){

	var title = "";
	var url = "";

	url = "/back/user/managerSearchPopup.do";
	$("#menutype_title").html("내부사용자계정");
    $.ajax({
        url: url,
        dataType: "html",
        type: "post",
        data: {
        	userNm : $("#userNm").val(),
		},
        success: function(data) {
        	$('#pop_managerlist').html(data);
        	popupSearchShow();
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}
function popupSearchShow(){
	$("#modal-manager-list").modal('show');
}

function popupSearchClose(){
	$("#modal-manager-list").modal("hide");
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
			   <input type='hidden' id="mode" name='mode' value="${param.mode}" />
			    <input type='hidden' id="userId" name='userId' value="${user.userId}" />
			    <input type='hidden' id="tel" name='tel' value="${user.tel}" />
			<!-- write_basic -->
			<div class="table_area">
				  <table class="view">
					<caption>상세보기 화면</caption>
					<colgroup>
						<col style="width: 140px;" />
						<col style="width: *;" />
						<col style="width: 120px;" />
						<col style="width: *;" />
					</colgroup>
					<tbody>
					<tr>
						<th scope="row">사용자 구분(권한)<span class="asterisk">*</span></th>
						<td colspan="3">
                            <div class="pull-left m-r-5">
								<g:select id="userCd" name="userCd"  codeGroup="USER_CD" selected="${user.userCd}"  cls="in_wp100" titleCode="선택" showTitle="true" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">이름  <span class="asterisk">*</span></th>
						<td colspan="3">
						    <input class="in_w20" type="text" id="userNm" name="userNm" value="${user.userNm}" data-parsley-required="true" placeholder="이름"  data-parsley-maxlength="30" data-parsley-errors-container="#nm_error_message"  />
							
						</td>
					</tr>
					<tr>
						<th scope="row">아이디  <span class="asterisk">*</span></th>
						<td colspan="3">
							<c:if test="${param.mode != 'E' }">
							    <input class="form-control in_w20" type="text" id="loginId" name="loginId" value="${user.loginId}" data-parsley-required="true" data-parsley-errors-container="#id_error_message" placeholder="아이디"  />
							    <input type="hidden" id="id_chk_yn" name="id_chk_yn"  value="N" />
							    <input type="hidden" id="checked_id" name="checked_id"  value="" />
							    <a href="javascript:idValidate();" class="btn look" title="중복확인">
									<span>중복확인</span>
								</a>
								<div id="id_error_message"></div>
							</c:if>
							<c:if test="${param.mode == 'E' }">
						       ${user.loginId}
						       <input type="hidden" id="loginId" name="loginId" value="${user.loginId}" />
						    </c:if>
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
							<c:if test="${param.mode eq 'W'}">
							<tr>
								<th scope="row">
									<label for="passwordCheck">비밀번호 확인 <strong class="color_pointr">*</strong></label>
								</th>
								<td>
									<input id="passwordCheck" name="passwordCheck" type="password" class="in_w15" data-parsley-required="true" maxlength="100"  value = "${memberInfo.password}" title="비밀번호 확인"/>
									<label id = "passwordLable"></label>
								</td>								
							</tr>
							</c:if>

					<tr style="display:none">
						<th scope="row">상공회의소 <strong class="color_pointr">*</strong></th>
						<td>
							<span class="inpbox">
								<input type="text" id="siteNm" value="${user.siteNm}"  style="width:140px;border: 1px solid #969696; " placeholder="지역상공 찾기.." title="지역상공 찾기.." onkeyup="userFindSite(this.value);"/>
								<input type="hidden" id="siteId" name="siteId" value="${user.siteId}"/>

								<ul id="siteList" style="z-index: 999999; position:absolute;border: 1px solid #969696;background-color: #fff;list-style-type: none;display:none; width:140px; padding:5px;margin:-5px 0 0 3px;">
									<c:forEach  var="row" items="${SITE_LIST}" varStatus="status">
									<li>
										<a href="#none" onclick="userSetSite('${row.siteId}','${row.siteNm}')">${row.siteNm}</a>
										<input type="hidden" name="selSiteId" value="${row.siteId }"/>
										<input type="hidden" name="selSiteNm" value="${row.siteNm }"/>

									</li>
									</c:forEach>
								</ul>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row">부서명</th>
						<td colspan="3">
						    <input class="in_w20" type="text" id="deptNm" name="deptNm" value="${user.deptNm}" placeholder="부서" data-parsley-required="false" data-parsley-maxlength="100" />
						</td>
					</tr>
					
					<c:if test="${param.mode == 'E' }">
                    	<tr>
						<th scope="row">등록자 <strong class="color_pointr">*</strong></th>
						<td>${user.regUserId}</td>
					</tr>
					<tr>
						<th scope="row">등록일 <strong class="color_pointr">*</strong></th>
						<td>${user.regDt}</td>
					</tr>
					</c:if>
					</tbody>
				</table>
			</div>
			<!--// write_basic -->

			<!-- button_area -->
			<div class="button_area">
				<div class="float_right">
				
			        <c:if test="${param.mode == 'W'}">
					<a href="javascript:userInsert('W');" class="btn save" title="등록">
						<span>등록</span>
					</a>
	               </c:if>
	               <c:if test="${param.mode == 'E' }">
					<a href="javascript:userInsert('M');" class="btn save" title="수정">
						<span>수정</span>
					</a>
					<c:if test="${USER.userCd eq '999'}">
					<a href="javascript:userDelete();" class="btn save" title="삭제">
						<span>삭제</span>
					</a>
					</c:if>
					</c:if>
					<a href="javascript:userListPage();" class="btn cancel" title="목록">
						<span>취소</span>
					</a>
				</div>
			</div>
			<!--// button_area -->
	</form>
</div>

<!--// content -->
 <jsp:include page="/WEB-INF/views/back/user/jusoSearchPopup.jsp"/>

 <div class="modal fade" id="modal-manager-list" >
	<div class="modal-dialog modal-size-small">
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 id="menutype_title" class="pop_title">내부사용자계정</h1>
			<a href="javascript:popupSearchClose()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area" style="text-align:center">
			    <div  id="pop_managerlist"  style="margin:10px;">
			    </div>
			</div>
		</article>
		</div>
		<!-- //container -->
	</div>
</div>