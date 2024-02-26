<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
function fn_searchID(){
	var url = "https://regist.korcham.net/join/finduser_id.jsp?loginUrl=aHR0cDovL3d3dy5rb3JjaGFtLm5ldC9tYWluL21lbWJlci9sb2dpbi5hc3A/bV9BY3Q9Y2VydGlmaV9GYWxzZTA2";
	window.open(url, "srchId", "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=435,height=650");
}

function fn_searchPW(){
	var url = "https://regist.korcham.net/join/finduser_pw.jsp?loginUrl=aHR0cDovL3d3dy5rb3JjaGFtLm5ldC9tYWluL21lbWJlci9sb2dpbi5hc3A/bV9BY3Q9Y2VydGlmaV9GYWxzZTA2";
	window.open(url, "srchId", "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=435,height=650");
}

function goJoin() {
	location.href='/common/front/join.do';
}
</script>
				<div class="contents_title">
					<h2>로그인</h2>
				</div>
<<<<<<< .mine
<div class="ed">
	<div class="contents_detail">
		<ul class="join">
			<li class="line"><div class="top">Join us</div>
				<h3>상공회의소 회원</h3>
				<div class="txt">
					상공회의소 회원은 상공업을 영위하는 법인, 개인, 상공업과 관련된 업무를 하는 비영리단체가 가입할 수 있으며, 가입에
					따른 다양한 혜택을 누릴 수 있습니다.<br>
					<br>
					<strong>종합경제단체</strong><br>상공회의소는 모든 업종을 망라하여 상공업자 모두를 회원으로 하는
					경제계를 대표하는 단체<br>
					<br>
					<strong>민간경제기구</strong><br>전세계 대부분의 국가에 설립되어 있는 범세계적인 민간경제기구
				</div>
				<button
					onclick="javascript:window.open('https://regist.korcham.net/join/join_RegistAuth.jsp?abc=ZGFlamVvbmNjaQ==','new','width=760,height=650,scrollbars=yes,resizable=no');">상공회의소
					회원가입</button></li>
			<li><div class="top">Join us</div>
				<h3>코참넷(웹사이트) 회원가입</h3>
				<div class="txt">코참넷 사이트 회원은 개인단위로 가입하실 수 있으며, 코참넷에서 제공하는
					전문화되고 차별화된 서비스를 이용하실 수 있습니다. 코참넷(KorChamNet)은 대한상공회의소가 기업의 정보화 촉진 및
					기업활동에 유용한 경제 경영정보 제공을 위하여 구축한 홈페이지의 네트워크를 말합니다.</div>
				<button
					onclick="javascript:window.open('https://regist.korcham.net/join/join_RegistPersonO.jsp?cciid=daejeoncci&p_op_type=I&m_joinGubun=LHK','new','width=880,height=650,scrollbars=yes,resizable=no');">온라인
					회원가입</button></li>
		</ul>
	</div>
</div>



				<div class="contents_detail">
					<div class="login_box">
						<h3>로그인</h3>
						<form>
							<fieldset>
								<legend>로그인</legend>
								<input type="text" class="txt" placeholder="아이디" />
								<input type="password" class="txt" placeholder="패스워드"  title="비밀번호"/>
								<button class="login">로그인</button>
							</fieldset>
						</form>
						<ul class="forget">
							<li>
								<span>아이디/비밀번호를 잊으셨나요?</span>
								<div class="forget_btn">
									<button class="btn_forget" onclick="fn_searchID();">아이디찾기</button>
									<button class="btn_forget" onclick="fn_searchPW();">비밀번호찾기</button>
								</div>
							</li>
							<li>
								<span>다양한 혜택이 기다리는 회원이 되세요</span>
								<div class="forget_btn">
									<button class="btn_forget" onclick="goJoin();">회원가입</button>
								</div>
							</li>
						</ul>
					</div>
