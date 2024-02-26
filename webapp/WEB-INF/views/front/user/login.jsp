<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
document.domain= "korcham.net";

//회원가입등 외부링크 연결
function goKocham(url) {

	window.open(url, "kochamPop", "width=1200,height=652");
}
function goLogin() {

	if (document.form.p_loginid.value == '')
	{
		alert('ID를 입력해 주세요.');
		document.form.p_loginid.focus();
		return;
	}
	if (document.form.p_pswd.value == '')
	{
		alert('PW를 입력해 주세요.');
		document.form.p_pswd.focus();
		return;
	}

	$("#successURL").val("${pageContext.request.scheme}://${pageContext.request.serverName}${ pageContext.request.serverPort==''? '': ':'}${ pageContext.request.serverPort}");
	document.form.action = "https://www.korcham.net/nCham/Service/Member/appl/LoginCommAct.asp";
	document.form.submit();
	//setMemberCode();

}

function setMemberCode(){

	   $.ajax
		({
			type: "POST",
	           url:  "/front/member/member.do",
	           data:{

		        	chamCd : '${SITE.chamCd}',
		        	memId:$("#p_loginid").val()
	           },
	           dataType: 'json',
			success:function(data){
				var memCd = data.memCd;
				document.form.action = "https://www.korcham.net/nCham/Service/Member/appl/LoginCommAct.asp";
				document.form.submit();
			}
		});
}

function gofindId(){
	var url = "http://regist.korcham.net/join/finduser_id.jsp?loginUrl=aHR0cDovL3d3dy5rb3JjaGFtLm5ldC9tYWluL21lbWJlci9sb2dpbi5hc3A/bV9BY3Q9Y2VydGlmaV9GYWxzZTA2";
	window.open(url, "srchId", "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=445,height=652");
}

function gofindPw(){
	var url = "http://regist.korcham.net/join/finduser_pw.jsp";
	window.open(url, "srchId", "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=445,height=652");
}
</script>


<div class="contents_title">
	<h2>로그인</h2>
</div>
<div class="contents_detail">

	<div class="login_box">
		<h3>로그인</h3>
			<form name="form" method="POST" class="margin-bottom-0">
			<fieldset>
				<legend>로그인</legend>
				<input type="hidden" name="successURL" id="successURL"/>
				<input type="text" class="txt" placeholder="아이디" name="p_loginid" id="p_loginid" onkeypress="if(event.keyCode==13) {goLogin(); return false;}"/>
				<input type="password" class="txt" placeholder="패스워드" name="p_pswd" onkeypress="if(event.keyCode==13) {goLogin(); return false;}" title="비밀번호"/>
				<a class="login" href="javascript:goLogin();">
					<span>로그인</span>
				</a>
			</fieldset>
			</form>
		<ul class="forget">
			<li>
				<span>아이디/비밀번호를 잊으셨나요?</span>
				<div class="forget_btn">
					<a class="btn_forget" href="javascsript:goKocham('https://regist.korcham.net/join/finduser_pw.jsp')">비밀번호찾기</a> -->
					<a class="btn_forget" href="javascript: gofindId()">아이디찾기</a>
					<a class="btn_forget" href="javascript: gofindPw()">비밀번호찾기</a>
				</div>
			</li>
			<li>
				<span>다양한 혜택이 기다리는 회원이 되세요</span>
				<div class="forget_btn">
					<a class="btn_forget" href="http://www.korcham.net/nCham/Service/Member/appl/Join.asp" target="_blank">회원가입</a>
				</div>
			</li>
		</ul>
	</div>

</div>


