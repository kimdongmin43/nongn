<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
	var passwordChangeUrl = "<c:url value='/front/user/passwordChange.do'/>";
	
	function pwSave(){
		if ( $("#writeFrm").parsley().validate() ){
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
	
	function main(){
		//메인으로
		document.location.href = "/front/user/main.do";
	}
	
</script>

<!-- division40 -->
<div class="division40">
	<!-- division60 -->
	<div class="division60">
		
		<!-- title_area -->
		<div class="title_area">
			<h3 class="title">회원님의 <strong class="color_pointr">비밀번호를 변경</strong>해 주세요</h3>
		</div>
		<!--// title_area -->
		<!-- division -->
		<div class="division">
			<ul class="txt_list_area2">
				<li>회원님께서는 장기간 비밀번호를 변경하지 않고, 동일한 비밀번호를 사용 중이십니다.</li>
				<li>회원님의 소중한 개인정보를 보호하기 위하여 비밀번호 변경을 안내해 드리고 있습니다.</li>
				<li>정기적인 비밀번호 변경으로 회원님의 개인정보를 보호해 주세요.</li>
			</ul>
		</div>
		<!--// division -->
		
		<!-- table_area -->
		<form id="writeFrm" name="writeFrm" method="post"  data-parsley-validate="true">
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
					<td class="first"><input type="password" class="in_w100" id="now_pw" name="now_pw" data-parsley-required="true" title="현재 비밀번호" /></td>
				</tr>
				<tr>
					<th scope="row">
						<label for="user_pw">
							<strong class="color_pointr">*</strong>새 비밀번호
						</label>
					</th>
					<td><input type="password" class="in_w100" id="user_pw" name="user_pw" data-parsley-required="true" data-parsley-maxlength="15" title="새 비밀번호" /></td>
				</tr>
				<tr>
					<th scope="row">
						<label for="user_pw_confirm">
							<strong class="color_pointr">*</strong>새 비밀번호 확인
						</label>
					</th>
					<td><input type="password" class="in_w100" id="user_pw_confirm" data-parsley-required="true" data-parsley-maxlength="15" title="새 비밀번호 확인" /></td>
				</tr>
				</tbody>
			</table>
		</div>
		</form>
		<!--// table_area -->
		<!-- division -->
		<div class="division">
			<ul class="txt_list_area">
				<li>10~15자 이상  영문소문자와 대문자, 숫자,특수문자 중 2가지 이상 문자 조합하여 사용 가능합니다.</li>
				<li>특수문자는 `~`,`!`,`@`,`#`,`$`,`*`,`(`,`)`,`=`,`_`,`.`,`|` 만 사용 가능합니다.</li>
			</ul>
		</div>
		<!--// division -->
		<!-- button_area -->
		<div class="button_area">
           	<div class="alignc">
           		<button class="btn save2" title="비밀번호 변경" onclick="pwSave();">
           			<span>비밀번호 변경</span>
           		</button>
           		<button class="btn save2" title="다음에 변경하기" onclick="main();">
           			<span>다음에 변경하기</span>
           		</button>
           	</div>
           </div>
           <!--// button_area -->
		</div>
		<!--// division60 -->
	</div>
	<!--// division40 -->