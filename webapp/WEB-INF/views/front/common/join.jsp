<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%
	String client_id = request.getRequestURL().toString();
	client_id = client_id.substring(7);
	client_id = client_id.substring(0, client_id.indexOf("."));
	String abc = null;

	if (client_id.equals("pcci")) {
		abc = "cGNjaQ==";
	} else if (client_id.equals("dcci")) {
		abc = "ZGNjaQ==";
	} else if (client_id.equals("incham")) {
		abc = "aW5jaGFt";
	} else if (client_id.equals("kwangjucci")) {
		abc = "a3dhbmdqdWNjaQ==";
	} else if (client_id.equals("daejeoncci")) {
		abc = "ZGFlamVvbmNjaQ==";
	} else if (client_id.equals("ulsan")) {
		abc = "dWxzYW4=";
	} else if (client_id.equals("suwoncci")) {
		abc = "c3V3b25jY2k=";
	} else if (client_id.equals("anseongcci")) {
		abc = "YW5zZW9uZ2NjaQ==";
	} else if (client_id.equals("acci")) {
		abc = "YWNjaQ==";
	} else if (client_id.equals("bucheoncci")) {
		abc = "YnVjaGVvbmNjaQ==";
	} else if (client_id.equals("sncci")) {
		abc = "c25jY2k=";
	} else if (client_id.equals("kbcci")) {
		abc = "a2JjY2k=";
	} else if (client_id.equals("pyeongtaekcci")) {
		abc = "cHllb25ndGFla2NjaQ==";
	} else if (client_id.equals("icheoncci")) {
		abc = "aWNoZW9uY2Np";
	} else if (client_id.equals("ansancci")) {
		abc = "YW5zYW5jY2k=";
	} else if (client_id.equals("hwaseongcci")) {
		abc = "aHdhc2VvbmdjY2k=";
	} else if (client_id.equals("yongincci")) {
		abc = "eW9uZ2luY2Np";
	} else if (client_id.equals("kimpocci")) {
		abc = "a2ltcG9jY2k=";
	} else if (client_id.equals("kunpocci")) {
		abc = "a3VucG9jY2k=";
	} else if (client_id.equals("hkcci")) {
		abc = "aGtjY2k=";
	} else if (client_id.equals("shiheungcci")) {
		abc = "c2hpaGV1bmdjY2k=";
	} else if (client_id.equals("chunchoncci")) {
		abc = "Y2h1bmNob25jY2k=";
	} else if (client_id.equals("gangneungcci")) {
		abc = "Z2FuZ25ldW5nY2Np";
	} else if (client_id.equals("wonjucci")) {
		abc = "d29uanVjY2k=";
	} else if (client_id.equals("samchokcci")) {
		abc = "c2FtY2hva2NjaQ==";
	} else if (client_id.equals("sokchocci")) {
		abc = "c29rY2hvY2Np";
		;
	} else if (client_id.equals("donghaecci")) {
		abc = "ZG9uZ2hhZWNjaQ==";
	} else if (client_id.equals("taebaekcci")) {
		abc = "dGFlYmFla2NjaQ==";
	} else if (client_id.equals("cheongjucci")) {
		abc = "Y2hlb25nanVjY2k=";
	} else if (client_id.equals("chungjucci")) {
		abc = "Y2h1bmdqdWNjaQ==";
	} else if (client_id.equals("cbcci")) {
		abc = "Y2JjY2k=";
	} else if (client_id.equals("seosancci")) {
		abc = "c2Vvc2FuY2Np";
	} else if (client_id.equals("jcci")) {
		abc = "amNjaQ==";
	} else if (client_id.equals("iksancci")) {
		abc = "aWtzYW5jY2k=";
	} else if (client_id.equals("gunsancci")) {
		abc = "Z3Vuc2FuY2Np";
	} else if (client_id.equals("jeongeupcci")) {
		abc = "amVvbmdldXBjY2k=";
	} else if (client_id.equals("mokpocci")) {
		abc = "bW9rcG9jY2k=";
	} else if (client_id.equals("sgcci")) {
		abc = "c2djY2k=";
	} else if (client_id.equals("yeosucci")) {
		abc = "eWVvc3VjY2k=";
	} else if (client_id.equals("gimcheoncci")) {
		abc = "Z2ltY2hlb25jY2k=";
	} else if (client_id.equals("andongcci")) {
		abc = "YW5kb25nY2Np";
	} else if (client_id.equals("pohangcci")) {
		abc = "cG9oYW5nY2Np";
	} else if (client_id.equals("gyeongjucci")) {
		abc = "Z3llb25nanVjY2k=";
	} else if (client_id.equals("yeongjucci")) {
		abc = "eWVvbmdqdWNjaQ==";
	} else if (client_id.equals("gumicci")) {
		abc = "Z3VtaWNjaQ==";
	} else if (client_id.equals("gyeongsancci")) {
		abc = "Z3llb25nc2FuY2Np";
	} else if (client_id.equals("dcci")) {
		abc = "ZGNjaQ==";
	} else if (client_id.equals("yeongcheoncci")) {
		abc = "eWVvbmdjaGVvbmNjaQ==";
	} else if (client_id.equals("chilgokcci")) {
		abc = "Y2hpbGdva2NjaQ==";
	} else if (client_id.equals("masancci")) {
		abc = "bWFzYW5jY2k=";
	} else if (client_id.equals("jinjucci")) {
		abc = "amluanVjY2k=";
	} else if (client_id.equals("tongyoungcci")) {
		abc = "dG9uZ3lvdW5nY2Np";
	} else if (client_id.equals("sacheoncci")) {
		abc = "c2FjaGVvbmNjaQ==";
	} else if (client_id.equals("jinhaecci")) {
		abc = "amluaGFlY2Np";
	} else if (client_id.equals("changwoncci")) {
		abc = "Y2hhbmd3b25jY2k=";
	} else if (client_id.equals("yangsancci")) {
		abc = "eWFuZ3NhbmNjaQ==";
	} else if (client_id.equals("gimhaecci")) {
		abc = "Z2ltaGFlY2Np";
	} else if (client_id.equals("miryangcci")) {
		abc = "bWlyeWFuZ2NjaQ==";
	} else if (client_id.equals("hamancci")) {
		abc = "aGFtYW5jY2k=";
	} else if (client_id.equals("kojecci")) {
		abc = "a29qZWNjaQ==";
	} else if (client_id.equals("jejucci")) {
		abc = "amVqdWNjaQ==";
	} else if (client_id.equals("eumseongcci")) {
		abc = "ZXVtc2VvbmdjY2k=";
	} else if (client_id.equals("gmcci")) {
		abc = "Z21jY2k=";
	} else if (client_id.equals("gecci")) {
		abc = "Z2VjY2k=";
	} else if (client_id.equals("gycci")) {
		abc = "Z3ljY2k=";
	} else if (client_id.equals("jincci")) {
		abc = "amluY2Np";
	} else if (client_id.equals("pccci")) {
		abc = "cGNjY2k=";
	} else if (client_id.equals("osancci")) {
		abc = "b3NhbmNjaQ==";
	} else if (client_id.equals("dangjincci")) {
		abc = "ZGFuZ2ppbmNjaQ==";
	} else if (client_id.equals("uiwangcci")) {
		abc = "dWl3YW5nY2Np";
	} else if (client_id.equals("pajucci")) {
		abc = "cGFqdWNjaQ==";
	} else if (client_id.equals("gwangyangcci")) {
		abc = "Z3dhbmd5YW5nY2Np";
	} else if (client_id.equals("daejeoncci")) {
		abc = "ZGFlamVvbmNjaQ==";
	} else if (client_id.equals("bucheoncci")) {
		abc = "YnVjaGVvbmNjaQ==";
	} else if (client_id.equals("icheoncci")) {
		abc = "aWNoZW9uY2Np";
	} else if (client_id.equals("hkcci")) {
		abc = "aGtjY2k=";
	} else if (client_id.equals("gycci")) {
		abc = "Z3ljY2k=";
	} else if (client_id.equals("pajucci")) {
		abc = "cGFqdWNjaQ==";
	} else if (client_id.equals("wonjucci")) {
		abc = "d29uanVjY2k=";
	} else if (client_id.equals("samchokcci")) {
		abc = "c2FtY2hva2NjaQ==";
	} else if (client_id.equals("taebaekcci")) {
		abc = "dGFlYmFla2NjaQ==";
	} else if (client_id.equals("chungjucci")) {
		abc = "Y2h1bmdqdWNjaQ==";
	} else if (client_id.equals("jcci")) {
		abc = "amNjaQ==";
	} else if (client_id.equals("iksancci")) {
		abc = "aWtzYW5jY2k=";
	} else if (client_id.equals("jeongeupcci")) {
		abc = "amVvbmdldXBjY2k=";
	} else if (client_id.equals("pohangcci")) {
		abc = "cG9oYW5nY2Np";
	} else if (client_id.equals("gumicci")) {
		abc = "Z3VtaWNjaQ==";
	} else if (client_id.equals("masancci")) {
		abc = "bWFzYW5jY2k=";
	} else if (client_id.equals("jinjucci")) {
		abc = "amluanVjY2k=";
	} else if (client_id.equals("sacheoncci")) {
		abc = "c2FjaGVvbmNjaQ==";
	} else if (client_id.equals("jinhaecci")) {
		abc = "amluaGFlY2Np";
	} else if (client_id.equals("changwoncci")) {
		abc = "Y2hhbmd3b25jY2k=";
	} else if (client_id.equals("jejucci")) {
		abc = "amVqdWNjaQ==";
	} else if (client_id.equals("djcci")) {
		abc = "ZGFlamVvbmNjaQ==";
	} else if (client_id.equals("jdcci")) {
		abc = "amRjY2k=";
	}
%>
<script>
function ajoin(){
	var url = 'https://regist.korcham.net/join/join_RegistAuth.jsp?abc=<%=abc%>';
	window.open(url,'new','width=760,height=650,scrollbars=yes,resizable=no');
}
function bjoin(){
	var url ='https://regist.korcham.net/join/join_RegistPersonO.jsp?cciid=${clientId}&p_op_type=I&m_joinGubun=LHK';
	window.open(url,'new','width=880,height=650,scrollbars=yes,resizable=no');
}
</script>
				<div class="contents_title">
					<h2>회원가입</h2>
				</div>
	<div class="contents_detail">
		<ul class="join">
			<li class="line"><div class="top">상공회의소 회원</div>

				<div class="txt">
					상공회의소 회원은 상공업을 영위하는 법인, 개인, 상공업과 관련된 업무를 하는 비영리단체가 가입할 수 있으며, 가입에
					따른 다양한 혜택을 누릴 수 있습니다.<br />
					<br />
					<strong>종합경제단체</strong><br />상공회의소는 모든 업종을 망라하여 상공업자 모두를 회원으로 하는
					경제계를 대표하는 단체<br />
					<br />
					<strong>민간경제기구</strong><br />전세계 대부분의 국가에 설립되어 있는 범세계적인 민간경제기구
				</div>
				<button
					onclick="ajoin()">상공회의소
					회원가입</button></li>
			<li><div class="top">코참넷(웹사이트) 회원</div>

				<div class="txt">코참넷 사이트 회원은 개인단위로 가입하실 수 있으며, 코참넷에서 제공하는
					전문화되고 차별화된 서비스를 이용하실 수 있습니다.<br /><br />
					<br />
					<strong>코참넷(KorChamNet)</strong><br />
					상공회의소가 기업의 정보화 촉진 및
					기업활동에 유용한 경제 경영정보 제공을 위하여 구축한 홈페이지의 네트워크를 말합니다.</div>
				<button
					onclick="bjoin()">온라인
					회원가입</button></li>
		</ul>
	</div>


