<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
	var passwordChangeUrl = "<c:url value='/front/user/passwordChange.do'/>";
	
	function pwSave(){
		if ( $("#passFrm").parsley().validate() ){
			if(checkPassword_info($("#user_pw").val())){
				$.ajax({
			        url: passwordChangeUrl,
			        dataType: "json",
			        type: "post",
			        data: {
			        	user_pw : $("#user_pw").val(),
			        	now_pw : $("#now_pw").val()
					},
			        success: function(data) {
			        	alert(data.message);
			        	pwPopupClose();
			        }
			    });
			}
		}
	}
	
	function checkPassword_info(p_pwd){
		var chk_pwd = p_pwd;
		var chk_num = chk_pwd.search(/[0-9]/g);
		var chk_eng = chk_pwd.search(/[a-z]/ig);
		var sp_filter =  /[~!@\#$*\()\=_|]/gi;
		var chk_spc = chk_pwd.search(sp_filter);
		var blank_filter = /[\s]/g;
		var cnt = 0;
	
		var chk_sp  =  sp_filter.test(chk_pwd);
	    
		//비밀번호 일치여부 체크
		if($("#user_pw").val() != $("#user_pw_confirm").val()){
			alert("비밀번호를 다시 확인해 주시기 바랍니다.");
			return false;
		}
		
		// 길이 체크
		if(chk_pwd.length > 15 || chk_pwd.length < 10 ){
			alert("10~15자 이상  영문소문자와 대문자, 숫자,특수문자 중 2가지 이상 문자 조합하여 사용 가능합니다.");
			return false;
		}
	  	
		// 조합 체크
		if(chk_num != -1) cnt++;
		if(chk_eng != -1) cnt++;
		if(chk_spc != -1) cnt++;
	
		if(cnt < 2){
			alert("영문소문자와 대문자, 숫자,특수문자 중 2가지 이상 문자 조합하여 사용 가능합니다.");
			return false;
		}
	  	
		// 공백 체크
		if(blank_filter.test(chk_pwd)){
			alert("비밀번호는 공백을 사용할 수 없습니다.");
			return false;
		}
	
		return true;
	}
	
	function pwPopupShow(){
		$('#modal-pw-write').modal('show');
	}

	function pwPopupClose(){
		$('#modal-pw-write').modal('hide');
	}
	
</script>

<div class="modal fade" id="modal-pw-write" >
	<div class="modal-dialog modal-size-small">
	<!-- popup_content -->
	<!-- header -->
	<div id="pop_header">
	<header>
		<h1 class="pop_title">비밀번호 변경안내</h1>
		<a href="javascript:pwPopupClose()" class="pop_close" title="페이지 닫기">
			<span>닫기</span>
		</a>
	</header>
	</div>
	
	<!-- //header -->
	<!-- container -->
	<div id="pop_container">
	<article>
		<form id="passFrm" name="passFrm" method="post"  data-parsley-validate="true">
		<div class="pop_content_area">
			<div id="pop_content">
				<!-- title_area -->
				<div class="title_area">
					<h2 class="pop_title">회원님의 <strong class="color_pointr">비밀번호를 변경</strong>해 주세요</h2>
				</div>
				<!--// title_area -->			
				<!-- table_area -->
				<div class="table_area">
					<table class="write fixed">
						<caption>비밀번호 변경 화면</caption>
						<colgroup>
							<col style="width: 150px;">
							<col style="width: *;">
						</colgroup>
						<tbody>
						<tr>
							<th scope="row" class="first">
								<label for="now_pw">
									<strong class="color_pointr">*</strong>현재 비밀번호
								</label>
							</th>
							<td class="first">
								<input type="password" class="in_w100" id="now_pw" name="now_pw" data-parsley-required="true" title="현재 비밀번호"/>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<label for="user_pw">
									<strong class="color_pointr">*</strong>새 비밀번호
								</label>
							</th>
							<td>
								<input type="password" class="in_w100" id="user_pw" name="user_pw" data-parsley-required="true" data-parsley-maxlength="15" title="새 비밀번호" />
							</td>
						</tr>
						<tr>
							<th scope="row">
								<label for="user_pw_confirm">
									<strong class="color_pointr">*</strong>새 비밀번호 확인
								</label>
							</th>
							<td>
								<input type="password" class="in_w100" id="user_pw_confirm" data-parsley-required="true" data-parsley-maxlength="15" title="새 비밀번호 확인" />
							</td>
						</tr>
						</tbody>
					</table>
				</div>
				<!--// table_area -->
				
				<!-- division -->
				<div class="division">
					<ul class="txt_list_area">
						<li>10~15자 이상  영문소문자와 대문자, 숫자,특수문자 중 2가지 이상 문자 조합하여 사용 가능합니다.</li>
						<li>특수문자는 `~`,`!`,`@`,`#`,`$`,`*`,`(`,`)`,`=`,`_`,`.`,`|` 만 사용 가능합니다. </li>
					</ul>
				</div>
				<!--// division -->
				
				<!-- button_area -->
				<div class="button_area">
	            	<div class="alignc">
	            		<button class="btn save2" title="비밀번호 변경" onclick="pwSave();">
	            			<span>비밀번호 변경</span>
	            		</button>
	            		<button class="btn save2" title="취소" onclick="pwPopupClose()">
	            			<span>취소</span>
	            		</button>
	            	</div>
	            </div>
	            <!--// button_area -->
	            
			</div>
		</div>
		</form>
	</article>	
	</div>
	<!--// popup_content -->
	</div>
</div>