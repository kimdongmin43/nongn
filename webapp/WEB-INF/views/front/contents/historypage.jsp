<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.history_tit {padding-left: 305px;background: url('/images/logo/logo_top/${SITE.clientId}_top_logo.png') 0 15px no-repeat;}
</style>
<div class="contents_title">
	<h2>${MENU.menuNm}</h2>
</div>
<div class="contents_detail">
	<div class="history">
		<div>

				<img src="/images/logo/logo_top/${SITE.clientId}_top_logo.png" style="float: left;">

			<h3 class="commpany_h3" style="padding-left: 305px" >
				성공비즈니스와 함께하는 최고의 경제단체<br /> <span>지역경제의 미래</span>를 이끌어 나가겠습니다.
			</h3>
		</div>
		<div class="history_list" style="">

			<c:forEach var="historylist" items="${historylist}">
					&nbsp;&nbsp;
						<h4>${historylist.title}</h4>
				<ul>
					<li>${historylist.contents}</li>
				</ul>
			</c:forEach>

		</div>
	</div>
</div>



<!-- <div class="history_list">
							<h4>태동기  창립 ~ 1930년대</h4>
							<ul>
								<li class="line_top">
									<dl>
										<dt>1932.6.</dt>
										<dd>${SITE.siteNm} 창립총회 (조선상공회의소령에 의거)</dd>
									</dl>
								</li>
								<li class="line_center">
									<dl>
										<dt>1933.11.</dt>
										<dd>${SITE.siteNm} 설립인가</dd>
									</dl>
								</li>
								<li class="line_bottom">
									<dl>
										<dt>1932.3.</dt>
										<dd>${SITE.siteNm} 초대 의원선거 실시 (일반의원 18명, 특별의원 3명 선출)</dd>
									</dl>
								</li>
							</ul>
						</div>
						<div class="history_list">
							<h4>도약기(1940년대~1960년대)</h4>
							<ul>
								<li class="line_top">
									<dl>
										<dt>1944.10.</dt>
										<dd>충남상공경제회 개편</dd>
									</dl>
								</li>
								<li class="line_center">
									<dl>
										<dt>1946.12.</dt>
										<dd>충청남도 상공회의소 개편</dd>
									</dl>
								</li>
								<li class="line_center">
									<dl>
										<dt>1954.1.</dt>
										<dd>${SITE.siteNm}로 개칭</dd>
									</dl>
								</li>
								<li class="line_center">
									<dl>
										<dt>1954.1.</dt>
										<dd>초대 의원총회 실시 (초대 회장 문갑동 충남미유㈜ 대표, 1~4대 회장 연임)</dd>
									</dl>
								</li>
								<li class="line_center">
									<dl>
										<dt>1961.8.</dt>
										<dd>제4대 회장 선출 (이장우 신성나사 대표)</dd>
									</dl>
								</li>
								<li class="line_center">
									<dl>
										<dt>1962.2.</dt>
										<dd>제5대 회장 선출 (문갑동 충남미유㈜ 대표)</dd>
									</dl>
								</li>
								<li class="line_bottom">
									<dl>
										<dt>1967.8.</dt>
										<dd>제6대 회장 선출 (이웅렬 중도일보사 사장)</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 충청은행 설립</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 무역진흥상사 사무소 유치</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 대전공업단지 조성</dd>
									</dl>
								</li>
							</ul>
						</div>
						<div class="history_list">
							<h4>발전기(1970년대~1990년대)</h4>
							<ul>
								<li class="line_top">
									<dl>
										<dt>1972.9.</dt>
										<dd>제7대 회장 선출 (홍광표 대전주정공업㈜ 대표 *7~8대 회장 연임)</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 충남수출진흥관 개설</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 기업경영 종합상담실 운영</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 대전상업기술연구원 개설</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 대전경제연구실 운영</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 대전마케팅 개발센터 설립</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 대전지방개발 추진위원회 구성</dd>
									</dl>
								</li>
								<li class="line_center">
									<dl>
										<dt>1974.1.</dt>
										<dd>업무구역 확대 (대덕군 편입)</dd>
									</dl>
								</li>
								<li class="line_center">
									<dl>
										<dt>1976.6.</dt>
										<dd>제9대 회장 선출 (송덕영 대륙고무벨트공업사 대표 *9~10대 회장 연임)</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 대전투자금융주식회사 설립</dd>
									</dl>
								</li>
								<li class="line_bottom">
									<dl>
										<dt>1980.8.</dt>
										<dd>업무구역 확장 (충남 7개군 편입)</dd>
									</dl>
								</li>
							</ul>
						</div>
						<div class="history_list">
							<h4>현 재 (2000년대 ~ )</h4>
							<ul>
								<li class="line_top">
									<dl>
										<dt>2004.2.</dt>
										<dd>2004년 2월   업무구역 조정 (2003년 9월 “계룡시”출범에 따라 충남 9개 시·군으로 조정)</dd>
									</dl>
								</li>
								<li class="line_center">
									<dl>
										<dt>2006.3.</dt>
										<dd>제19대 회장 선출 (송인섭 ㈜진미식품 대표이사 *19~20대 연임)</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 소상공인진흥원 대전 유치</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 기업사랑운동 확대</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 지역상품 팔아주기 운동 전개</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 회원증강 최우수 상의 선정(2010년 10월 21일)</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 국제과학비즈니스벨트 충청권 조성 운동 전개</dd>
									</dl>
								</li>
								<li class="line_center">
									<dl>
										<dt>2011.4.</dt>
										<dd>서부(논산), 북부(연기) 지소 개소</dd>
									</dl>
								</li>
								<li class="line_center">
									<dl>
										<dt>2012.3.</dt>
										<dd>제21대 회장 선출 (손종현 ㈜남선기공 대표이사)</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 북대전세무서 신설 기여</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 대전·세종·공주지역 인적자원개발위원회 출범</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 대전지역FTA활용지원센터 운영(상주관세사 도입)</dd>
									</dl>
								</li>
								<li class="line_only">
									<dl>
										<dt>&nbsp;</dt>
										<dd>- 대전상의 본관 희망카페 개점</dd>
									</dl>
								</li>
								<li class="line_bottom">
									<dl>
										<dt>2015.3.</dt>
										<dd>제22대 회장 선출 (박희원 ㈜라이온켐텍 대표이사)</dd>
									</dl>
								</li>
							</ul> -->
