<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
            </div>
			<!--//content_area-->
		</div>
		<!--//container_area-->
	</div>
	<!--//container-->

	<!--footer-->
    <footer id="footer">
    	<!--footer_warp-->
    	<div class="footer_warp">
			<!-- foot_top -->
			<div class="foot_top">
				<!--fLink-->
				<div class="fLink">
					<ul>
						<!--<li><a href="/front/user/apiTest.do">APITEST</a></li>-->
						<!-- <li><a href="/front/user/userRegistStep2Page.do" title="회원가입으로 이동">회원가입</a></li> -->
						<li class="point"><a href="/front/contents/sub.do?contId=46&menuId=5372" title="개인정보처리방침">개인정보처리방침</a></li>
					</ul>
					<ul class="list2">
						<li><a href="/front/contents/sub.do?contId=47&menuId=5373" title="이메일무단수집거부">이메일무단수집거부</a></li>
						<li><a href="/front/contents/sub.do?contId=74&menuId=5344" title="찾아오시는길">찾아오시는길</a></li>
					</ul>
				</div>
				<!--//fLink-->
				<!--site_url_area-->
				<div class="site_url_area">
					<div class="site_url">
						<button class="title" type="button" title="펼치기">유관기관 바로가기<span>펼치기</span></button>
						<ul class="select">
							<c:forEach  var="row" items="${BANNER}" varStatus="status">
							<c:if test="${row.sectionCd eq '7'}">
							<li onclick="$('.select').css('display','none');$('.title > span').text('펼치기')"><a href="${row.url}" target="${row.targetCd}" title="새창열림">${row.title}</a></li>
							</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="site_url">
						<button class="title" type="button" title="펼치기">관련사이트 바로가기<span>펼치기</span></button>
						<ul class="select">
							<c:forEach  var="row" items="${BANNER}" varStatus="status">
							<c:if test="${row.sectionCd eq '3'}">
							<li onclick="$('.select').css('display','none');$('.title > span').text('+')"><a href="${row.url}" target="${row.targetCd}" title="새창열림">${row.title}</a></li>
							</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="site_url">
						<button class="title" type="button" title="펼치기">해외 사이트 바로가기<span>펼치기</span></button>
						<ul class="select">
							<c:forEach  var="row" items="${BANNER}" varStatus="status">
							<c:if test="${row.sectionCd eq '5'}">
							<li onclick="$('.select').css('display','none');$('.title > span').text('+')"><a href="${row.url}" target="${row.targetCd}" title="새창열림">${row.title}</a></li>
							</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
				<script>
					(function(){
						var param = ".site_url";
						var btn = ".title";
						var obj = ".select";
						footersitelink(param,btn,obj);
					}());
				</script>				
				<!--//site_url_area-->
			</div>
			<!-- //foot_top -->
			
			<!-- foot_bot -->
			<div class="foot_bot">
				<!--copy_wrap-->
				<div class="copy_wrap">
					<h2>농업정책보험금융원</h2>
					<div class="add_copy">
						<address>${SITE.addr} <br /> 
					<span id="telInfo"></span><br/>
					webmaster : dmkim@apfs.kr
					<%-- <span id="telInfo2"></span><br>webmaster : dmkim@apfs.kr--%>
					</address>
						<p class="copyright">Copyright ⓒ 농업정책보험금융원 All rights reserved.</p>
					</div>
					<p class="wa-area"><a href="/download/2023-0367%20정보통신접근성%20품질인증서-농업정책보험금융원.pdf" title="pdf 파일보기 새창" target="_blank"><img src="/images/common/wa_mark.png" alt="(사)한국장애인단체총연합회 한국웹접근성인증평가원 웹 접근성 우수사이트 인증마크(WA인증마크)" width="140"></a></p><!-- //2023-03-23 -->
				</div>
				<!--//copy_wrap-->
			</div>
			<!-- //foot_bot -->
		</div>
        <!--//footer_warp-->
    </footer>
    <!--//footer-->
<!--//warp-->

<script>
$(document).ready(function(){
	var strDevice = findOutDevice();
	var strTel2 = "";

	if (strDevice == "MO") {
		strTel = "${SITE.tel_mobile}";
		strTel2 = "<a href='tel:02-3771-6816'>02-3771-6816</a>(손해평가사)";
	} else { 
		strTel = "${SITE.tel}";
		strTel2 = "02-3771-6816(손해평가사)";
	} 
	$("#telInfo").html(strTel);
	//$("#telInfo2").html(strTel2);
	
	
	changeTelLink(); //	로딩한 콘텐츠 내에 전화번호 개체가 있는 지 검사
});



</script>