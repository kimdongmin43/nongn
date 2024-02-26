<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=5.0, minimum-scale=1.0, width=device-width" />
<%
	String Category = request.getParameter("Category");
	Category		= Category.replaceAll("!","&");
%>
<title>투자분야 | <%=Category%></title>
<style>
html,body{margin:0;padding:0;font-family:NanumGothic, NG, dotum, gulim, Arial,"sans-serif";font-size:13px;color:#555555;}

img{margin:0;padding:0;border:none;vertical-align:top;}
img.event{cursor:pointer;}

a{color: #555555;text-decoration: none;}
a:hover{text-decoration:none;}

ul, ol {
    list-style: none;
    margin: 0;
    padding: 0;
}

li {
    display: list-item;
    text-align: -webkit-match-parent;
}
.mgr5 {
    margin-right: 5px;
}

.right {
    text-align: right;
}
.popWrap{text-align:left;}

.top{font-family:"NGB";color:#0066be;font-size:14px;background:url(/images/icon/icon_title.gif) left 3px no-repeat;padding:0 0 8px 20px; text-align:left; margin:10px 0 0 5px;}
.top h1{font-size:18px;
    clear: both;
    margin: 0;
    padding: 0;
    font-family: "NGB";
}

.invest_box{border:1px solid #d4d4d4;padding:15px 15px 8px 5px;font-family:dotum;font-size:12px;margin:0 5px 5px 5px;}
.invest_box ul li{background:url(/images/icon/dtitle.gif) left 0px no-repeat;position:relative;padding:2px 0 6px 23px; text-align:left;}
.invest_box ul li.none{background:none;padding:2px 0 6px 15px;}
</style>

<script>
$(document).ready(function() {

});
</script>

<!-- Global Site Tag (gtag.js) - AdWords: 827205478 -->
<!-- <script async src="https://www.googletagmanager.com/gtag/js?id=AW-827205478"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'AW-827205478');
</script> -->

</head>
<body>

<div class="popWrap">
	<div class="top"><h1><%=Category%></h1></div>
	<div class="invest_box">
		<!-- <ul>
			<li>농림수산식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체 중 연간 매출액 30억원 이하의 농식품경영체(신설 포함)</li>
			<li>R&D 기술 또는 새로운 비즈니스 모델의 도입, 타산업과의 융.복합, 경영혁신, 사업의 기업화 등을 계획하여 새로운 가치창조를 모색하는 사업준비단계 또는 개시 후 1년 미만의 농식품경영체로서, 투자대상으로 선정되어 보육시스템을 이수한 경영체</li>
			<li class="none">* 중앙행정기관이 법령에 근거하여 연구개발과제를 특정하여 그 연구개발비의 전부 또는 일부를 출연하거나 공공기금 등으로 지원하는 과학기술분야의 연구개발사업</li>
		</ul> -->
		<ul>
		<%if (Category.equals("소형프로젝트")){%>
		<li>농림수산식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체 중 연간 매출액 30억원 이하의 농식품경영체(신설 포함)</li>
		<%}else if (Category.equals("푸드테크")) {%>
		<li>푸드테크* 10대 핵심분야에 종사하(려)는 농식품경영체(사업 준비 또는 사업 개시 후 7년 미만)<br>* 식품의 생산, 유통, 소비 전반에 인공지능(AI), 사물인터넷(IoT), 바이오기술(BT) 등 첨단기술이 결합된 신산업을 의미</li>
		<%}else if (Category.equals("지역특성화(전북)")) {%>
		<li>출자한 지자체 내 본점 또는 주된 사무소의 소재지를 두고 있는 농식품경영체 또는 출자 지자체 내 투자를 통해 고용창출 효과가 예상되는 농식품경영체</li>
		<%}else if (Category.equals("수출")) {%>
		<li>국내산 신선 농·임산물 및 가공식품을 해외에 수출하(려)는 농식품경영체 중 상호출자제한기업집단에 속하지 않는 경영체. 단, 수출실적이 없는 경영체가 신규로 수출을 하려는 경우와 3년합산 수출실적이 10만$ 이하인 기업은 자금이 수출을 위한 직접자금(운영자금 제외)으로 사용되는 경우에 한함</li>
		<%}else if ( Category.equals("AgroSeed") ) {%>
		<li>R&D 기술 또는 새로운 비즈니스 모델의 도입, 타산업과의 융․복합, 경영혁신, 사업의 기업화 등을 계획하여 새로운 가치창조를 모색하는 사업준비단계 또는 개시 후 1년 미만의 농식품경영체로서, 투자대상으로 선정되어 보육시스템을 이수한 경영체</li>
		<%}else if ( Category.equals("R&D") ) {%>
		<li>농림축산식품산업 관련 국가연구개발사업*을 통해 도출된 결과물을 이전받아 사업을 영위하(려)는 농식품경영체 및 국가연구개발사업을 직접 수행하여 도출된 결과물을 자체적으로 사업화하(려)는 농식품 경영체</li>
		<li class="none">* 중앙행정기관이 법령에 근거하여 연구개발과제를 특정하여 그 연구개발비의 전부 또는 일부를 출연하거나 공공기금 등으로 지원하는 과학기술분야의 연구개발사업</li>
		<%}else if ( Category.equals("6차 산업화") ) {%>
		<li>농축산물을 포함, 농촌에 존재하는 모든 유·무형의 자원을 바탕으로 타산업(2,3차 산업)과의 융·복합을 도모하거나 산업적 고도화를 추구하여 새로운 부가가치를 창출하(려)는 사업</li>
		<%}else if ( Category.equals("농림축산식품") ) {%>
		<li>농림수산식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체 중 농림축산식품분야 사업을 영위하(려)는 경영체</li>
		<li>대기업 프랜차이즈로 운영되는 사업은 제외</li>
		<%}else if ( Category.equals("수산업") ) {%>
		<li>농림수산식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체 중 수산업, 수산식품 분야 사업을 영위하(려)는 경영체 또는 수산업 관련 업무에 종사하는 자, 원양산업자 및 수산 관련 R&D에 종사하는 자</li>
		<%}else if ( Category.equals("식품산업") ) {%>1
		<li>농수산물에 인공을 가하여 생산·가공·제조·조리하는 산업 등</li>
		<li>위 산업으로부터 생산된 산물을 포장·보관·수송 또는 판매하는 산업 등</li>
		<%}else if ( Category.equals("농림축산업") ) {%>
		<li>농림수산식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체 중 농림축산분야 사업을 영위하(려)는 경영체</li>
		<li>대기업 프랜차이즈로 운영되는 사업은 제외</li>
		<%}else if ( Category.equals("8대 사업") ) {%>
		<li>농림수산식품투자조합의 결성 및 운용에 관한 법률 제3조, 영 제3조 및 규칙 제2조의 규정에 의한 농식품경영체 중 8대사업(①대규모농어업회사, ②첨단유리온실, ③식품클러스터, ④농림수산식품R&D, ⑤종자종묘산업, ⑥염산업, ⑦한식세계화, ⑧원양어선 신조)(이하 “8대사업”이라 한다)을 영위하는 농식품경영체</li>
		<%}else if (Category.equals("농림수산식품") ) {%>
		<li>농림수산식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체 중 농림식품분야 사업을 영위하(려)는 경영체</li>
		<li>농림수산식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체 중 수산업, 수산식품 분야 사업을 영위하(려)는 경영체 또는 수산업 관련 업무에 종사하는 자, 원양산업자 및 수산 관련 R&D에 종사하는 자</li>
		<li>대기업 프랜차이즈로 운영되는 사업은 제외</li>
		<%}else if (Category.equals("스마트팜") ) {%>
		<li>농림축산업에 ICT를 접목하거나 시설신축 및 현대화를 통해 생산성 향상 및 품질제고를 도모하(려)는 경영체 및 관련 장치 및 시스템을 개발·유통 및 판매하는 기업</li>
		<li>생산·유통·소비 등 농림축산업의 가치사슬(Value-chain)과 관련된 사업을 영위하는 경영체에 ICT를 융복합하여 생산의 정밀화, 유통의 지능화, 경영의 선진화 등 새로운 가치를 창출하려는 경영체</li>
		<%}else if (Category.equals("ABC펀드") ) {%>
		<li>농림수산식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체 중 농림축산식품분야 사업을 영위하(려)는 경영체<br>※ 대기업 프랜차이즈로 운영되는 사업에는 투자금지</li>
		<%}else if (Category.equals("세컨더리펀드") ) {%>
		<li>농식품모태펀드 출자 자펀드가 농식품경영체에 신규로 투자한 투자자산의 인수<br>※ 프로젝트 투자 방식의 투자 지분은 인수대상에서 제외<br>※ 단, Agroseed 펀드 투자건 중 농식품경영체에 출자전환한 투자지분은 포함</li>
		<%}else if (Category.equals("농식품벤처펀드") ) {%>
		<li>사업 개시 후 5년 미만으로 R&D기술, 새로운 비즈니스 모델 등을 활용하여 농업분야 가치창조를 모색하면서 다음 ①, ②, ③, ④ 중 하나의 조건을 충족하는 농식품경영체<br>
		    ① 농업계열 고교 및 농식품계열 대학 졸업자가 대표자, 최대주주이거나, 등기임원 중 2인 이상인 경영체<br> 
		    ② 대표자가 만 39세 이하 이거나, 만 39세 이하 임직원 비중이 50% 이상인 경영체<br>
		    ③ 사업 준비단계 또는 사업개시 후 3년 미만의 농식품경영체<br>
		    ④ 스마트팜 보육센터 수료생 창업 경영체</li>
		<%}else if (Category.equals("지역특성화펀드(경기도)") ) {%>
		<li>농림수산식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체로서 출자한 지자체 내 본점 또는 주된 사무소의 소재지를 두고 있는 농식품 경영체</li>
		<%}else if (Category.equals("마이크로") ) {%>
		<li>사업준비 단계 또는 사업 개시 후 5년 미만의 농식품 경영체</li>
		<%}else if (Category.equals("징검다리") ) {%>
		<li>농식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체 중, 기존 농식품투자조합으로부터 투자금을 받아 향후 일자리 창출이 기대되는 농식품경영체</li>
		<%}else if (Category.equals("수산벤처창업") ) {%>
		<li>농림수산식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농림수산식품경영체 중 수산업, 수산식품분야 사업을 영위하(려)는 경영체 또는 수산업 관련 업무에 종사하는 자, 원양산업자 및 수산 관련 R&D에 종사하는 자(이하 수산경영체)로서, 다음중 하나의 요건을 충족하는 수산경영체<br>
			   ① 사업 준비단계 또는 사업개시 후 7년이 지나지 아니한 기업
			   ② 정부‧공공기관이 인증‧확인한 수산분야 벤처기업, 스타트업 기업 등
			   ③ 정부‧지자체‧공공기관이 주관한 창업경진대회에서 입상한 수산분야 창업아이템을 활용하는 기업
			   ④ 수산 관련 공공‧민간의 연구개발 성과 또는 정부‧공공기관 인증을 받은 신기술을 사업화‧활용하는 기업
			   ⑤ 수산물‧수산업과 관련된 ICT 등 융복합 기술을 사업화‧활용하는 기업
			   ⑥ 수산분야 청년기업(대표자 또는 임직원의 50% 이상이 만 39세 이하)</li>
		<%}else if (Category.equals("지역특성화펀드(경북)") ) {%>
		<li>농식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체로서 ① 출자한 지자체 내 본점이나 주된 사무소의 소재지를 두고 있는(두려는) 경영체 또는 ② 출자 지자체 내 투자를 통해 고용창출 효과가 예상되는 경영체<br> 
    			* 사업장 및 제품생산시설 등에 대한 신규 투자액이 5억원 이상(토지·건물 매입 및 임차비용 제외)</li>
		<%}else if (Category.equals("영파머스") ) {%>
		<li>농림수산식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체로서 1차 농산업*을 영위하(려)는 경영체 중 ① 대표자가 만 49세 이하이거나, 만 49세 이하의 임직원 비중이 50% 이상 또는, ② 대표자가 만 49세 이하이며 청년창업농 또는 후계농업인에 선정**된 경영체 또는 ③ 창업 7년 미만이고 대표자가 만 49세 이하인 농업법인에 건당 5억원 이내(특별결의 시 약정총액의 20% 한도이내)투자<br>
			    * 농업ㆍ농촌 및 식품산업 기본법 제3조 제1호에 따른 농업(농작물 재배업, 축산업, 임업)으로 ① 1천 제곱미터 이상의 농지를 경영·경작하거나, ② 농업경영을 통한 농산물의 연간 판매액이 120만원 이상일 경우 농업종사자로 인정<br>
			   ** 농식품부(경영인력과) 청년농업인 영농정착지원사업 및 후계농업경영인(청년창업형 후계농)지원사업에 의거하여 해당 투자연도 및 그 이전에 선발된 이력이 있는 인원에 한함<br>
			  *** 주목적 투자대상이 법인인 경우 청년농이 당해 회사 대표권이 있는 임원으로 투자 시점 6개월 전부터 계속하여 등기되어 있어야 함</li>
		<%}else if (Category.equals("그린바이오") ) {%>
		<li>농식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체 중 그린바이오산업에서 사업을 하(려)는 농식품경영체<br>
   			 ※ 그린바이오산업은 생명자원 및 정보에 생명공학 기술을 적용하여 다양한 부가가치를 창출하는 산업으로 마이크로바이옴, 대체식품·메디푸드, 종자 산업, 동물용 의약품, 기타 생명소재 5대 분야로 구분<br>
   			※ 식품용 미생물제, 해양 생명소재 분야 제외(단, 환경 미생물제는 농업 환경 개선용 미생물제에 한하여 대상에 포함)<br>
   			※ 동물용 의료기기 분야 제외(단, 항원 등 생물학적 표지를 이용한 진단키트 등은 대상에 포함)		</li>
		<%}else if (Category.equals("스마트농업") ) {%>
		<li>농식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의 규정에 의한 농식품경영체 중에 ① 또는 ②의 조건을 충족하는 농식품경영체<br>
			 ① 스마트팜 : ICT 및 각종 첨단기술과 농업 생산을 비롯해 농업 밸류체인(생산 준비단계, 생산, 유통 등) 전반을 접목한 농업의 스마트화를 선도할 경영체<br>
 		           ② 탄소중립 : 혁신기술을 활용하여 농업분야의 탄소저감 효과를 가져올 수 있는 경영체</li>
		<%}else if (Category.equals("세컨더리(혼합형)") ) {%>
		<li>① 농식품모태펀드로부터 출자받은 자펀드가 농식품경영체에 신규투자한 투자자산의 인수 또는 <br>
    		 ② 농식품모태펀드로부터 출자받은자펀드의 지분 매입<br><br> 
			 ※ ①의 경우, 프로젝트 투자 방식의 투자 지분은 인수대상에서 제외</li>
		<%}else if (Category.equals("창업보육") ) {%>
		<li>농식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 <br>
		      제2조의 규정에 의한 농식품경영체로서  벤처·창업 지원 수혜 경영체에<br>3억 원 이내로 투자<br><br> 
	                       ※ 농식품 벤처·창업 활성화 지원사업 또는 청년식품창업Lab 사업을 통해 초기 창업보육을 거친,창업 7년 이내 농식품 기업 등</li>
		<%}else if (Category.equals("농식품 통합지원") ) {%>
		<li>농식품경영체1) 중, 「농식품 기술창업 액셀러레이터 육성지원사업」2)을 통<br>해 선행 투자 및 보육이 이루어진 창업기업3) 및 청년농어업인4)<br>
			1) 농식품경영체 :「농림수산식품투자조합 결성 및 운용에 관한 법률」제3조,<br> 같은법 시행령 제3조 및 시행규칙 제2조에 따른 농식품 경영체를 말함<br>
 			2) 한국농업기술진흥원이 주최하는 농식품 전문 기술창업 액셀러레이터 육성지원사업(`20～)<br>
 			3) 창업기업: 「중소기업창업 지원법」에 따른 창업기업을 말함<br>
 			4) 청년농어업인: 「후계농어업인 및 청년농어업인 육성ㆍ지원에 관한 법률」에<br> 따른 청년농어업인</li>
 		<%}else if (Category.equals("스마트양식산업혁신") ) {%>
		<li>농림수산식품투자조합 결성 및 운용에 관한 법률 제3조, 시행령 제3조 및 시행규칙 제2조의<br>규정에 의한 농림수산식품경영체 중 미래지향적 스마트양식 및
            수산부산물 관련 사업을<br>영위하(려)는 경영체 중 다음 ①, ② 중 하나에 해당하는 경영체<br>
            ① 스마트양식 : ICT 및 각종 첨단 기술을 양식 산업에 접목하여 양식의 자동화ㆍ지능화 등을<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;선도할 수산경영체<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(수질변화 예측, 사료공급 지능화, 성장 예측, 에너지 관리 및 절감,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;시스템 고장진단 및 예측, 생산관리)<br>
            ② 수산부산물 : 수산부산물의 친환경적ㆍ위생적 처리 및 고부가가치 재활용을 통해<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;폐기율 저감 효과를 가져올 수 있는 수산경영체<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(수산부산물 수집 및 운반, 수산부산물 전처리 및 재활용)</li>
		<%}%>

		</ul>

	</div>
	<!-- 내용끝 -->
	<div class="right mgr5"><a href="javascript:self.close()"><img alt="close" src="/images/icon/btn_close.gif"></a></div>
</div>
</body>
</html>