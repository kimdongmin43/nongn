<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@page import="kr.apfs.local.common.util.StringUtil"%>
<%@page import="kr.apfs.local.common.util.ConfigUtil"%>
<%@ page import="java.io.IOException" %>
<%!
    public static String cutStr(String str,int cutByte)
    {
      byte [] strByte = str.getBytes();
      if( strByte.length < cutByte )
        return str;
      int cnt = 0;
      for( int i = 0; i < cutByte; i++ )
      {
         if( strByte[i] < 0 )
         cnt++;
      }

     String r_str;
     if(cnt%2==0) r_str = new String(strByte, 0, cutByte );
     else r_str = new String(strByte, 0, cutByte + 1 );

     return r_str;
    }

private String subString(String strData, int iStartPos, int iByteLength) throws Exception{
	byte[] bytTemp = null;
	int iRealStart = 0;
	int iRealEnd = 0;
	int iLength = 0;
	int iChar = 0;

	try {
		// UTF-8로 변환하는경우 한글 2Byte, 기타 1Byte로 떨어짐
		bytTemp = strData.getBytes("EUC-KR");
		iLength = bytTemp.length;

		for(int iIndex = 0; iIndex < iLength; iIndex++) {
			if(iStartPos <= iIndex) {
				break;
			}
			iChar = (int)bytTemp[iIndex];
			if((iChar > 127)|| (iChar < 0)) {
				// 한글의 경우(2byte 통과처리)     -   한글은 2Byte이기 때문에 다음 글자는 볼것도 없이 스킵한다
				iRealStart++;
				iIndex++;
			} else {
				// 기타 글씨(1Byte 통과처리)
				iRealStart++;
			}
		}

		iRealEnd = iRealStart;
		int iEndLength = iRealStart + iByteLength;
		for(int iIndex = iRealStart; iIndex < iEndLength; iIndex++)
		{
			iChar = (int)bytTemp[iIndex];
			if((iChar > 127)|| (iChar < 0)) {
				// 한글의 경우(2byte 통과처리)    -    한글은 2Byte이기 때문에 다음 글자는 볼것도 없이 스킵한다
				iRealEnd++;
				iIndex++;
			} else {
				// 기타 글씨(1Byte 통과처리)
				iRealEnd++;
			}
		}
	}catch(IOException e) {
		System.out.println("IOException 에러!" + e);
	}
	finally{
		return strData.substring(iRealStart, iRealEnd);
	}
}



%>

<%-- 230808 자동 캐시 삭제 --%>
<% 
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<!--[if lt IE 9]><script src="/js/html5.js"></script><![endif]-->
<title>농업정책보험금융원</title>
<link rel="shortcut icon" href="/images/common/kr.ico" /><!--즐겨찾기 아이콘-->
<meta name="description" content="모태펀드, 크라우드펀딩, 농업정책보험, 재해재보험기금, 농림수산정책자금 검사, 농특회계, 관련법령 안내"/>
<meta name="keywords" content="농업정책보험금융원"/>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='pragma' content='no-cache'>


<link rel="stylesheet" type="text/css" href="/css/default.css?ver=24.1" />
<link rel="stylesheet" type="text/css" href="/css/common.css?ver=24.1" />
<link rel="stylesheet" type="text/css" href="/css/layout.css?ver=24.1" />
<link rel="stylesheet" type="text/css" href="/css/main.css?ver=24.1" />
<style>
.hidden{line-height: 0; position: absolute; width: 0; height: 0; overflow: hidden;}
</style>
<script src="/js/jquery-1.11.3.min.js"></script>
<script src="/js/apfs/common.js"></script>
<script src="/js/apfs/layout.js"></script> <!-- 20230419 신규추가 -->
<script src="/js/apfs/pzone.js?ver=24.1"></script>
<script src="/js/jquery.bpopup.min.js"></script>
<script>
	function openWin( winName ) {

		var blnCookie    = getCookie( winName );  
		var obj = eval( "window." + winName );  
		if( (!blnCookie) && (blnCookie != "") ) {  
			obj.style.display = "block";  
		}

		$("#skip_nav").focus();
		
// 	    //페이지 로딩시 강력 새로고침
// 	 	var link = document.location.href;
// 		console.log("link : " + link);
// 		console.log("self.name : " + self.name);
// 			if(self.name != link){
// 			self.name = link;
// 			self.location.reload(true);
// 			console.log("새로고침");
// 		}
		
	}  
	
	function getCookie( name ) {  
		var nameOfCookie = name + "=";  
		var x = 0;  
		while ( x <= document.cookie.length )  {  
			var y = (x+nameOfCookie.length);  
		    if ( document.cookie.substring( x, y ) == nameOfCookie ) {  
		    	if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) endOfCookie = document.cookie.length;  
		            return unescape( document.cookie.substring( y, endOfCookie ) );  
		    }  
		    x = document.cookie.indexOf( " ", x ) + 1;  
			if ( x == 0 ) break;  
		}  
		return "";  
	}
	
	function setCookie( name, value, expiredays ) {   
		var todayDate = new Date();   
		todayDate.setDate( todayDate.getDate() + expiredays );   
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"   
	}  
	
	function closeWin(winName, expiredays) {
		setCookie( winName, "done" , expiredays);   
		var obj = eval( "window." + winName );  
		obj.style.display = "none";  
	}  

	$(document).ready( function() {
		
		var filter = "win16|win32|win64|mac|macintel"; 
		var strTel = "";
		var strTel2 = "";

		if ( navigator.platform ) { 
			if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) { 
				strTel = "${footerInfopage.telMobile}";
				strTel2 = "<a href='tel:02-3771-6816'>02-3771-6816</a>(손해평가사)";
			} else { 
				strTel = "${footerInfopage.tel}";
				strTel2 = "02-3771-6816(손해평가사)";
			} 
		}
		$("#telInfo").html(strTel);
		$("#telInfo2").html(strTel2);
		
				
		$("#lastItem1").focusout( function(e) {		//	키보드로 이동 시, 주메뉴 팝업 닫기 - 2020.10.20
			$(".top2m").css("display", "none");	
		});
		
		
		$("#allMenuLastItem").focusout( function(e) {		//	키보드로 이동 시, 전체메뉴 팝업 닫기 - 2020.10.20		//	아래 함수와 연동
			closePopup();
		});

		//	Enter 키 입력 이벤트 감지
		window.addEventListener("keydown", function(e) {
			if(event.keyCode == 13)
		     {
				if (document.activeElement.id == "hrefAllMenu") {
					e.preventDefault();
			$('#allmenu').bPopup();
			$("#allMenuItem1").focus();			//	첫 번째 요소로 포커스 이동
				}
		     }
		});

		$("#skip_nav").focus();
		
	});
	
	function closePopup(){
		$('#allmenu').removeAttr("tabindex");
		$('#allmenu').bPopup().close();
		$("#hrefAllMenu").focus();
	}
	
	
	//챗봇 버튼 스크립트
	
	$(document).ready(function(){ 
    	cookiedata = document.cookie; 
        if(cookiedata.indexOf("close=Y")<0){ 
        	$("#chatbot").show(); 
        }else{ 
        	$("#chatbot").hide(); 
        }
        
        //페이지 로딩시 강력 새로고침
      	var link = document.location.href;
     	//console.log("link : " + link);
     	//console.log("self.name : " + self.name);
     		if(self.name != link){
     		self.name = link;
     		self.location.reload(true);
     		console.log("새로고침");
     		localStorage.clear();
     	}
    }); 
	
	function exit2(){ 
    	$("#chatbot").hide(); 
        setCookie("close","Y",1); 
    } 
    
    function setCookie(cname, cvalue, exdays) { 
    	var d = new Date(); 
        d.setTime(d.getTime() + (exdays*24*60*60*1000)); //시간설정 
        var expires = "expires="+d.toUTCString(); var temp = cname + "=" + cvalue + "; " + expires; 
        document.cookie = temp; 
    } 
		/*function playExe(){
			$.ajax({
				url: "/front/user/playexe.do",	// 컨트롤러 매핑주소
				type: 'POST',
//				data: params,		// 넘길 파라미터 있는 경우 설정
				dataType : 'json',
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				async: true,
				success: function(returnData){
				}
			});
		}*/
	
</script>

</head>



<body onload="openWin('div_laypopup');">
<!-- skipNav -->
<div class="skip_nav" id="skip_nav">
    <ul>
    	<li><a href="#gnb">주메뉴 바로가기</a></li>
        <li><a href="#containerContent">본문 바로가기</a></li>
    </ul>
</div>
<!-- //skipNav -->

<!--warp-->
<div id="warp" >
	<div class="header_bg"></div>
	<!-- header -->
	<header id="header">
		<div class="eg_logo"><!-- 20220928 김동민 대리 웹 품질진단 -->
			<div class="inner">
				<p class="eg"><img src="/images/main/eg_logo.png" alt="eg(전자정부)" />이 누리집은 대한민국 공식 전자정부 누리집입니다.</p>
			</div>
		</div>
		<!-- 230823 이의신청 팝업크기 조절 테스트 -->
<!-- 	<a href="http://121.135.104.58:30880/objcaply/" target="_blank">온라인(전체화면)</a> -->
<!-- 	<a href="http://121.135.104.58:30880/objcaply/" onclick="window.open(this.href, '_blank', 'width=1270, height=680, left=370,top=170'); return false;" class="btn_dental big">온라인</a> -->
<!-- 	<a href="#none" target="_blank" onClick="window.open('http://inveseum.apfs.kr/goal-cms/fundCounsel/req1List.do','pagename','resizable,height=870,width=1680,left=100,top=50'); return false;">가온누리인베지움</a> -->
<!-- 	<a href="#none" target="_blank" onClick="window.open('https://naver.com','pagename','resizable,height=870,width=1680,left=100,top=50'); return false;">네이버</a> -->
		<!-- nav -->
		<nav class="nav">
			<div class="inner">
				<h1 class="logo"><a href="/front/user/main.do"><span class="hide2">농업정책보험금융원(Agricultural Policy Insurance & Finance Service)</span></a></h1>
				<!-- gnb -->
				<div id="gnb">
					<h2 class="skip">주메뉴</h2>
					<ul class="depth01">
						<li class="depth1">
							<a href="javascript:goTopMenu('/front/contents/sub.do?contId=48','11','정보공개','11','undefined','///');" class="tit" title="정보공개">정보공개</a>
							<div class="depth02_wrap">
								<div class="inner">
									<div class="list">
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=48','11','undefined','///');" title="정보공개 안내">정보공개 안내</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=79','12','undefined','///');" title="사전공개정보">사전공개정보</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=20035','13','undefined','///');" title="정보공개 목록">정보공개 목록</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=49','14','undefined','///');" title="정보공개 청구">정보공개 청구</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=51','15','undefined','///');" title="공공데이터 개방">공공데이터 개방</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=12','16','undefined','///');" title="사업실명제">사업실명제</a></li>
										</ul>
									</div>
								</div>
							</div>
						</li>
						<li class="depth1">
							<a href="javascript:goTopMenu('/front/contents/sub.do?contId=44','21','주요업무','5320','undefined','///');" class="tit" title="주요업무">주요업무</a>
							<div class="depth02_wrap">
								<div class="inner">
									<div class="list">
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/contents/sub.do?contId=44','5320','undefined','///');" title="농림수산식품모태펀드">농림수산식품모태펀드</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=44','5320','undefined','///');" title="업무소개">업무소개</a></li>
													<li><a href="javascript:goSubMenu('/front/invest/investListPage.do?contId=45&amp;menuId=5321','5321','undefined','///');" title="농림수산식품투자조합">농림수산식품투자조합</a></li>
												</ul>
											</li>
										</ul>
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/contents/sub.do?contId=53','5322','undefined','///');" title="농식품전문 크라우드펀딩">농식품전문 크라우드펀딩</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=53','5322','undefined','///');" title="업무소개">업무소개</a></li>
													<li><a href="javascript:goSubMenu('http://agrocrowd.kr/','5323','undefined','///');" title="농식품 크라우드펀딩 전용관 새창 바로가기">농식품 크라우드펀딩 전용관 &nbsp;<img src="/images/common/ico_new_win.png" alt="새창"></a></li>
												</ul>
											</li>
										</ul>
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/contents/sub.do?contId=54','5324','undefined','///');" title="농업정책보험">농업정책보험</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=54','5324','undefined','///');" title="업무소개">업무소개</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=55','5325','undefined','///');" title="상품소개">상품소개</a></li>
												</ul>
											</li>
										</ul>
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/contents/sub.do?contId=137','5474','undefined','///');" title="양식수산물재해보험">양식수산물재해보험</a><!-- 2021.07.14 -->
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=137','5474','undefined','///');" title="업무소개">업무소개</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=138','5475','undefined','///');" title="상품소개">상품소개</a></li>
												</ul>
											</li>
										</ul>
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/contents/sub.do?contId=57','5327','undefined','///');" title="손해평가사">손해평가사</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=57','5327','undefined','///');" title="손해평가사 안내">손해평가사 안내</a></li>
													<li><a href="javascript:goSubMenu('/front/event/eventList.do?menuId=5369','5369','undefined','///');" title="교육">교육</a></li>
													<%-- <li><a href="javascript:goSubMenu('/front/mypage/mypageCheck.do?menuId=5378','5378','undefined','///');" title="마이페이지">마이페이지</a></li>--%>
													<li><a href="javascript:goSubMenu('/front/agrInsClaAdj/selectAgrInsClaAdj.do?menuId=5458','5458','undefined','///');" title="손해평가사조회">손해평가사조회</a></li>
												</ul>
											</li>
										</ul>
										<!-- 20210408 -->
										<ul class="depth02">
											<li>
												<a href="https://assist.apfs.kr" target="_blank" title="ASSIST(농식품 투자정보 플랫폼) 새창 바로가기">ASSIST<br />(농식품 투자정보 플랫폼) &nbsp;<img src="/images/common/ico_new_win.png" alt="새창"></a>
											</li>
										</ul>
										<!-- //20210408 -->
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/contents/sub.do?contId=58','5456','undefined','///');" title="농어업재해재보험기금">농어업재해재보험기금</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=58&menuId=5456','5456','undefined','///');" title="기금공시">기금공시</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=59','5329','undefined','///');" title="개요">개요</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=60','5330','undefined','///');" title="설치 목적 및 근거">설치 목적 및 근거</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=61','5331','undefined','///');" title="기금의 조성 및 용도">기금의 조성 및 용도</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=62','5332','undefined','///');" title="기금운용체계 및 관리 기관">기금운용체계 및 관리 기관</a></li>
												</ul>
											</li>
										</ul>
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/contents/sub.do?contId=63','5333','undefined','///');" title="농림수산정책자금 검사">농림수산정책자금 검사</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=63','5333','undefined','///');" title="업무소개">업무소개</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=64','5334','undefined','///');" title="검사절차">검사절차</a></li>
													<li><a target="_blank" href="/file/inspectExample/2021_Inspect_Examples.pdf" title="검사사례 새창 바로가기">검사사례 &nbsp;<img src="/images/common/ico_new_win.png" alt="새창"></a></li>
												</ul>
											</li>
										</ul>
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/contents/sub.do?contId=65','5335','undefined','///');" title="농특회계 융자금 관리">농특회계 융자금 관리</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=65','5335','undefined','///');" title="업무소개">업무소개</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=66','5336','undefined','///');" title="사업현황">사업현황</a></li>
												</ul>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</li>
						<li class="depth1">
							<a href="javascript:goTopMenu('/front/board/boardContentsListPage.do?boardId=20076','5347','자료실','5347','undefined','///');" class="tit" title="자료실">자료실</a>
							<div class="depth02_wrap">
								<div class="inner">
									<div class="list">
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=20076','5347','_self','///');" title="농림수산식품모태펀드">농림수산식품모태펀드</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=20076','5347','undefined','///');" title="투자유치 자료실">투자유치 자료실</a></li>
													<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=20038','5348','undefined','///');" title="동영상자료실">동영상자료실</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=97','5350','undefined','///');" title="관련 법령">관련 법령</a></li>
												</ul>
											</li>
										</ul>
										<ul class="depth02" style="display:none;">
											<li>
												<a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=35','5351','undefined','///');" title="농식품전문 크라우드펀딩">농식품전문 크라우드펀딩</a>
												<ul class="depth03">
													<li style="display:none;"><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=20037','5351','undefined','///');" title="투차유치 자료실">투차유치 자료실</a></li>
	                    						<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=20055','5352','undefined','///');" title="동영상자료실">동영상자료실</a></li>
	                    						<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=98','5353','undefined','///');" title="관련 법령">관련 법령</a></li>
												</ul>
											</li>
										</ul>
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=20047','5361','undefined','///');" title="농업정책보험">농업정책보험</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/disclosurePage.do?&amp;menuId=5361','5361','undefined','///');" title="기준가격공시">기준가격공시</a></li>
													<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=20046','5362','undefined','///');" title="사업시행지침">사업시행지침</a></li>
													<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=20086','5472','undefined','///');" title="농업재해보험심의회 페이지로 이동">농업재해보험심의회</a></li>
													<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=20058','5363','undefined','///');" title="보험금 지급 사례">보험금 지급 사례</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=99','5364','undefined','///');" title="관련 법령">관련 법령</a></li>
												</ul>
											</li>
										</ul>
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/contents/sub.do?contId=133','5365','undefined','///');" title="농업정책보험 실적집계">농업정책보험 실적집계</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=133','5365','undefined','///');" title="주요지표">주요지표</a></li> 
													<li><a href="javascript:goSubMenu('/front/contents/chart1ListPage.do?menuId=5366','5366','undefined','///');" title="농작물재해보험">농작물재해보험</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/chart3ListPage.do?menuId=5367','5367','undefined','///');" title="가축재해보험">가축재해보험</a></li> 
													<li><a href="javascript:goSubMenu('/front/contents/chart5ListPage.do?menuId=5368','5368','undefined','///');" title="보험료 수준">보험료 수준</a></li>
												</ul>
											</li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=20061','5370','undefined','///');" title="손해평가사 자료실">손해평가사 자료실</a></li>
										</ul>
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/contents/sub.do?contId=100','5358','undefined','///');" title="농림수산정책자금 검사 관련법령">농림수산정책자금 검사</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=100','5358','undefined','///');" title="관련 법규">관련 법규</a></li>       
													<li><a target="_blank" href="/file/inspectExample/2021_Inspect_Examples.pdf" title="검사사례 새창 바로가기">검사사례 &nbsp;<img src="/images/common/ico_new_win.png" alt="새창"></a></li>
												</ul>
											</li>
										</ul>
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/contents/sub.do?contId=101','5337','undefined','///');" title="농특회계 융자금 관리">농특회계 융자금 관리</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=101','5376','undefined','///');" title="관련 법령">관련 법령</a></li>
												</ul>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</li>
						<li class="depth1">
							<a href="javascript:goTopMenu('/front/board/boardContentsListPage.do?boardId=10026','41','알림마당','41','undefined','///');" class="tit" title="알림마당">알림마당</a>
							<div class="depth02_wrap">
								<div class="inner">
									<div class="list">
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=10026','41','undefined','///');" title="공지사항">공지사항</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=42','42','undefined','///');" title="보도자료">보도자료</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=43','43','undefined','///');" title="채용·행사">채용·행사</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=44','44','undefined','///');" title="해명·설명">해명·설명</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=45','45','undefined','///');" title="포토뉴스">포토뉴스</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=96','5379','undefined','///');" title="입찰정보">입찰정보</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=46','5482','undefined','///');" title="개인정보처리방침">개인정보처리방침</a></li>
										</ul>
									</div>
								</div>
							</div>
						</li>
						<li class="depth1">
							<a href="javascript:goSubMenu('/front/contents/sub.do?contId=129','5462','undefined','///');" class="tit" title="고객참여">고객참여</a>
							<div class="depth02_wrap">
								<div class="inner">
									<div class="list">
										<ul class="depth02">
											<li>
												<a href="/front/contents/sub.do?contId=129&menuId=5462" title="전문 페이지로 이동">고객헌장</a>
												<ul class="depth03">
													<li><a href="/front/contents/sub.do?contId=129&menuId=5462" title="전문 페이지로 이동">전문</a></li>
													<li><a href="/front/contents/sub.do?contId=130&menuId=5463" title="핵심서비스 이행표준 페이지로 이동">핵심서비스 이행표준</a></li>
													<li><a href="/front/contents/sub.do?contId=131&menuId=5464" title="고객응대서비스 이행표준 페이지로 이동">고객응대서비스 이행표준</a></li>
												</ul>
											</li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=51','51','undefined','///');" title="질의응답(Q&amp;A)">질의응답(Q&amp;A)</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=52','52','undefined','///');" title="FAQ">FAQ</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=20062','55','undefined','///');" title="고객제안">고객제안</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=84','56','undefined','///');" title="국민신문고">국민신문고</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=140','5481','undefined','///');" title="국민제안">국민제안</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=85','57','undefined','///');" title="부정부패&nbsp;&middot;&nbsp;공익 신고마당">부정부패&nbsp;&middot;&nbsp;공익 신고마당</a></li>
										</ul>
										<ul class="depth02">
											<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=82','58','undefined','///');" title="농림수산정책자금 부당사용 신고센터">농림수산정책자금<br> 부당사용 신고센터</a></li>
										</ul>
									</div>
								</div>
							</div>
						</li>
						<li class="depth1">
							<a href="javascript:goTopMenu('/front/contents/sub.do?contId=68','61','기관 소개','5338','undefined','///');" class="tit" title="기관 소개">기관 소개</a>
							<div class="depth02_wrap">
								<div class="inner">
									<div class="list">
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/contents/sub.do?contId=68','5338','undefined','///');" title="농업정책보험금융원 소개">농업정책보험금융원 소개</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=68','5338','undefined','///');" title="임무">임무</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=69','5339','undefined','///');" title="인사말">인사말</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=70','5340','undefined','///');" title="연혁">연혁</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=71','5341','undefined','///');" title="미션/비전">미션/비전</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=72','5342','undefined','///');" title="조직 및 직원">조직 및 직원</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=73','5343','undefined','///');" title="CI소개">CI소개</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=74','5344','undefined','///');" title="찾아오시는 길">찾아오시는 길</a></li>
												</ul>
											</li>
										</ul>
										<ul class="depth02">
											<li>
												<a href="javascript:goSubMenu('/front/contents/sub.do?contId=75','5345','undefined','///');" title="열린경영">열린경영</a>
												<ul class="depth03">
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=75','5345','undefined','///');" title="경영공시(알리오)">경영공시(알리오)</a></li>
													<li><a href="javascript:goSubMenu('/front/contents/sub.do?contId=76','5346','undefined','///');" title="윤리경영">윤리경영</a></li>
													<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=61','5374','undefined','///');" title="청렴한 농금원">청렴한 농금원</a></li>
													<li><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=62','5375','undefined','///');" title="사회공헌">사회공헌</a></li>      
													<li id="lastItem1"><a href="javascript:goSubMenu('/front/board/boardContentsListPage.do?boardId=20081','5468','undefined','///');" title="인권경영">인권경영</a></li>
												</ul>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</li>
					</ul>
				</div>
				<!-- //gnb -->
				<!-- utile_allmenu -->
				<div class="utile_allmenu">
					<a href="javascript:void(0);" class="header_search">통합검색하기</a>
					<!-- 검색박스 -->
					<div class="header_search_box">
							<div class="inner">
								<div class="search_box01">
									<form action="/front/main/searchPage.do" method="get">									
										<input name="total_searchTxt" title="검색어" class="search_keyword" type="text" style="ime-mode:active;" value="" placeholder="검색어를 입력하세요">
										<input type="image" class="search_btn" alt="검색하기" src="/images/common/btn_search.png">
									</form>
								</div>
								<a href="javascript:void(0);" class="search_close"><span class="hide2">통합검색 닫기</span></a>
							</div>
					</div>
					<!-- //검색박스 -->
					<a href="javascript:void(0);" class="allmenu_open">전체메뉴</a>
					<!-- 전체메뉴 -->
					<div class="allmenu">
						<div class="inner">
							<div class="allmenu_title">전체메뉴</div>
							<c:import url = "/WEB-INF/views/front/user/inc/allMenu.jsp"/>
							<a href="javascript:void(0);" class="allmenu_close" data-focus="allmenu_focus01" data-focus-next="allmenu_focus01"><span class="hide2">전체메뉴닫기</span></a>
						</div>
					</div>
					<!-- //전체메뉴 -->
				</div>
				<!-- //utile_allmenu -->
				<button class="mobile_btn_outer open_mn">
					<span class="hide2">모바일 메뉴 열기</span>
					<span class="mobile_btn"></span>
				</button>
			</div>
		</nav>
		<!-- //nav -->
    </header>
    <!-- //header -->
	
<!-- 	<a href="https://download.apfs.kr:5050/AssessorSimulator.zip">.</a> -->
	
	
	<!--mobileNavi-->
    <div id="mobileNavi">
		<div>
			<nav class="side_menu" id="slide_menu">
			<h2>농업정책보험금융원</h2>
			<ul class="depth1">
				<li class="on"><a>정보공개</a>
					<ul class="depth2">
						<li>
							<a href="/front/contents/sub.do?contId=48&menuId=11" title="정보공개안내 페이지로 이동">정보공개 안내</a>
						</li>

						<li>
							<a href="/front/contents/sub.do?contId=79&menuId=12" title="사전공개정보 페이지로 이동">사전공개정보</a>
						</li>

						<li>
							<a href="/front/board/boardContentsListPage.do?boardId=20035&menuId=13" title="정보공개 목록 페이지로 이동">정보공개 목록</a>
						</li>

						<li>
							<a href="/front/contents/sub.do?contId=49&menuId=14" title="정보공개 청구 페이지로 이동">정보공개 청구</a>
						</li>

						<li>
							<a href="/front/contents/sub.do?contId=51&menuId=15" title="공공데이터 개방 페이지로 이동">공공데이터 개방</a>
						</li>

						<li>
							<a href="/front/board/boardContentsListPage.do?boardId=12&menuId=16" title="사업설명제 페이지로 이동">사업설명제</a>
						</li>
					</ul>
				</li>

				<li><a>주요업무</a>
					<ul class="depth2">
						<li>
							<a class="depth3_open">농림수산식품모태펀드</a>
							<ul class="depth3">
							   <li><a href="/front/contents/sub.do?contId=44&menuId=5320" title="업무소개 페이지로 이동">업무소개</a></li>
							   <li><a href="/front/invest/investListPage.do?contId=45&menuId=5321" title="농림수산식품투자조합 페이지로 이동">농림수산식품투자조합</a></li>
							</ul>
						</li>
						<li>
							<a class="depth3_open">농식품전문 크라우드펀딩</a>
							<ul class="depth3">
								<li><a href="/front/contents/sub.do?contId=53&menuId=5322" title="업무소개 페이지로 이동">업무소개</a></li>
								<li><a href="https://assist.apfs.kr" target="_blank" title="새창으로 열림">ASSIST &nbsp;<img src="/images/common/ico_new_win.png" alt="ASSIST 바로가기 새창열림"></a></li>
								<li><a href="http://agrocrowd.kr" target="_blank" title="새창으로 열림">농식품 크라우드펀딩 전용관 &nbsp;<img src="/images/common/ico_new_win.png" alt="농식품 크라우드펀딩 전용관 바로가기 새창열림"></a></li>
							</ul>
						</li>
<!-- 						<li> -->
<!-- 							<a>농업정책보험</a> -->
<!-- 							<ul class="depth3"> -->
<!-- 								<li><a href="/front/contents/sub.do?contId=54&menuId=5324" title="업무소개 페이지로 이동">업무소개</a></li> -->
<!-- 								<li><a href="/front/contents/sub.do?contId=55&menuId=5325" title="상품소개 페이지로 이동">상품소개</a></li> -->
<!-- 								<li><a href="/front/contents/sub.do?contId=55&menuId=5325" style="font-size:2px;" title="농작물재해보험 페이지로 이동">&nbsp;&nbsp;&#183;농작물재해보험</a></li> -->
<!-- 								<li><a href="/front/contents/sub.do?contId=90&menuId=5325" style="font-size:2px;" title="농업수입보장보험 페이지로 이동">&nbsp;&nbsp;&#183;농업수입보장보험</a></li> -->
<!-- 								<li><a href="/front/contents/sub.do?contId=91&menuId=5325" style="font-size:2px;" title="가축재해보험 페이지로 이동">&nbsp;&nbsp;&#183;가축재해보험</a></li> -->
<!-- 								<li><a href="/front/contents/sub.do?contId=92&menuId=5325" style="font-size:2px;" title="농업인안전보험 페이지로 이동">&nbsp;&nbsp;&#183;농업인안전보험</a></li> -->
<!-- 								<li><a href="/front/contents/sub.do?contId=93&menuId=5325" style="font-size:2px;" title="농작업근로자안전보험 페이지로 이동">&nbsp;&nbsp;&#183;농작업근로자안전보험</a></li> -->
<!-- 								<li><a href="/front/contents/sub.do?contId=94&menuId=5325" style="font-size:2px;" title="농기계종합보험 페이지로 이동">&nbsp;&nbsp;&#183;농기계종합보험</a></li> -->
<!-- 							</ul> -->
<!-- 						</li> -->
						<li>
							<a class="depth3_open">농업정책보험</a>
							<ul class="depth3">
								<li><a href="/front/contents/sub.do?contId=54&menuId=5324" title="업무소개 페이지로 이동">업무소개</a></li>
								<li><a class="depth4_open">상품소개</a>
									<ul class="depth4">
										<li><a href="/front/contents/sub.do?contId=55&menuId=5325" title="농작물재해보험 페이지로 이동">농작물재해보험</a></li>
										<li><a href="/front/contents/sub.do?contId=90&menuId=5325" title="농업수입보장보험 페이지로 이동">농업수입보장보험</a></li>
										<li><a href="/front/contents/sub.do?contId=91&menuId=5325" title="가축재해보험 페이지로 이동">가축재해보험</a></li>
										<li><a href="/front/contents/sub.do?contId=92&menuId=5325" title="농업인안전보험 페이지로 이동">농업인안전보험</a></li>
										<li><a href="/front/contents/sub.do?contId=93&menuId=5325" title="농작업근로자안전보험 페이지로 이동">농작업근로자안전보험</a></li>
										<li><a href="/front/contents/sub.do?contId=94&menuId=5325" title="농기계종합보험 페이지로 이동">농기계종합보험</a></li>
									</ul>
								</li>
								<li><a href="/front/contents/disclosurePage.do?&menuId=5396" title="기준가격공시 페이지로 이동">기준가격공시</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=20046&menuId=5398" title="사업시행지침 페이지로 이동">사업시행지침</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=20058&menuId=5399" title="보험금 지급 사례 페이지로 이동">보험금 지급 사례</a></li>
								<li><a href="/front/contents/sub.do?contId=99&menuId=5400" title="관련 법령 사례 페이지로 이동">관련 법령</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=5401&selTab=3" title="공지사항 페이지로 이동">공지사항</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=51&menuId=5402&selTab=3" title="질의응답 페이지로 이동">질의응답</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=52&menuId=5403&selTab=3" title="FAQ 페이지로 이동">FAQ</a></li>
<!-- 								<li><a href="/front/contents/sub.do?contId=50&menuId=5483&selTab=3" title="이의신청 페이지로 이동">이의신청</a></li> -->
							</ul>
						</li>
						<li>
							<a class="depth3_open">양식수산물재해보험</a>
							<ul class="depth3">
								<li><a href="/front/contents/sub.do?contId=137&menuId=5474" title="업무소개 페이지로 이동">업무소개</a></li>
								<li><a href="/front/contents/sub.do?contId=138&menuId=5475" title="상품소개 페이지로 이동">상품소개</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=20087&menuId=5476" title="사업시행지침 페이지로 이동">사업시행지침</a></li>
								<li><a href="/front/contents/sub.do?contId=139&menuId=5477" title="관련 법령 사례 페이지로 이동">관련 법령</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=5478&selTab=7" title="공지사항 페이지로 이동">공지사항</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=51&menuId=5479&selTab=7" title="질의응답 페이지로 이동">질의응답</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=52&menuId=5480&selTab=7" title="FAQ 페이지로 이동">FAQ</a></li>
							</ul>
						</li>
						<li>
							<a class="depth3_open">손해평가사</a>
							<ul class="depth3">
								<li><a href="/front/contents/sub.do?contId=57&menuId=5327" title="손해평가사 안내 페이지로 이동">손해평가사 안내</a></li>
								<li><a href="/front/event/eventList.do?menuId=5369" title="교육 페이지로 이동">교육</a></li>
<!-- 								<li><a href="/front/mypage/mypageCheck.do?menuId=5378&menuDesc=1111" title="내정보수정 페이지로 이동">내정보수정</a></li> -->
<!-- 								<li><a href="/front/mypage/myEdupageCheck.do?menuId=5378&menuDesc=1112" title="교육신청및이력 페이지로 이동">교육신청및이력</a></li> -->
								<li><a href="/front/board/boardContentsListPage.do?boardId=20061&menuId=5404" title="자료실 페이지로 이동">자료실</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=5405&selTab=4" title="공지사항 페이지로 이동">공지사항</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=51&menuId=5406&selTab=4" title="질의응답 페이지로 이동">질의응답</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=52&menuId=5407&selTab=4" title="FAQ 페이지로 이동">FAQ</a></li>
								<li><a href="/front/agrInsClaAdj/selectAgrInsClaAdj.do?menuId=5458" title="손해평가사 조회 페이지로 이동">손해평가사 조회</a></li>
							</ul>
						</li>
						<li>
							<a class="depth3_open">농어업재해재보험기금</a>
							<ul class="depth3">
								<li><a href="/front/contents/sub.do?contId=58&menuId=5456" title="기금 공시 페이지로 이동">기금 공시</a></li>
								<li><a href="/front/contents/sub.do?contId=59&menuId=5329" title="개요 페이지로 이동">개요</a></li>
								<li><a href="/front/contents/sub.do?contId=60&menuId=5330" title="설치 목적 및 근거 페이지로 이동">설치 목적 및 근거</a></li>
								<li><a href="/front/contents/sub.do?contId=61&menuId=5331" title="기금의 조성 및 용도 페이지로 이동">기금의 조성 및 용도</a></li>
								<li><a href="/front/contents/sub.do?contId=62&menuId=5332" title="기금 운용 체계 및 관리 기관 페이지로 이동">기금 운용 체계 및 관리 기관</a></li>
							</ul>
						</li>
						<li>
							<a class="depth3_open">농림수산정책자금 검사</a>
							<ul class="depth3">
								<li><a href="/front/contents/sub.do?contId=63&menuId=5333" title="업무소개 페이지로 이동">업무소개</a></li>
								<li><a href="/front/contents/sub.do?contId=64&menuId=5334" title="검사절차 페이지로 이동">검사절차</a></li>
								<li><a target="_blank" href="/file/inspectExample/2021_Inspect_Examples.pdf" title="검사사례">검사사례 &nbsp;<img src="/images/common/ico_new_win.png" alt="검사사례 새창열림"></a></li>
							</ul>
						</li>
						<li>
							<a class="depth3_open">농특회계 융자금 관리</a>
							<ul class="depth3">
								<li><a href="/front/contents/sub.do?contId=65&menuId=5335" title="업무소개 페이지로 이동">업무소개</a></li>
								<li><a href="/front/contents/sub.do?contId=66&menuId=5336" title="사업현황 페이지로 이동">사업현황</a></li>
							</ul>
						</li>
					</ul>
				</li>

				<li><a>자료실</a>
					<ul class="depth2">
						<li>
							<a class="depth3_open">농림수산식품모태펀드</a>
							<ul class="depth3">
							<li><a href="/front/board/boardContentsListPage.do?boardId=20076&menuId=5347" title="투자유치 자료실 페이지로 이동">투자유치 자료실</a></li>
							<li><a href="/front/board/boardContentsListPage.do?boardId=20038&menuId=5348" title="동영상 자료실 페이지로 이동">동영상 자료실</a></li>
							<li><a href="/front/board/boardContentsListPage.do?boardId=20039&menuId=5349" title="펀드투자 우수사례 페이지로 이동">펀드투자 우수사례</a></li>
							<li><a href="/front/contents/sub.do?contId=97&menuId=5350" title="관련 법령 페이지로 이동">관련 법령</a></li>
							 </ul>
						</li>
					<li><a class="depth3_open">농업정책보험</a>
						<ul class="depth3">
							<li><a href="/front/contents/disclosurePage.do?&menuId=5361" title="기준가격공시 페이지로 이동">기준가격공시</a></li>
							<li><a href="/front/board/boardContentsListPage.do?boardId=20046&menuId=5362" title="사업시행지침 페이지로 이동">사업시행지침</a></li>
							<li><a href="/front/board/boardContentsListPage.do?boardId=20086&menuId=5472" title="농업재해보험심의회 페이지로 이동">농업재해보험심의회</a></li>
							<li><a href="/front/board/boardContentsListPage.do?boardId=20058&menuId=5363" title="보험금 지급 사례 페이지로 이동">보험금 지급 사례</a></li>
							<li><a href="/front/contents/sub.do?contId=99&menuId=5364" title="관련 법령 페이지로 이동">관련 법령</a></li>
						</ul>
					</li>
					<li>
							<a class="depth3_open">농업정책보험 실적집계</a>
							<ul class="depth3">
								<li><a href="/front/contents/sub.do?contId=133&menuId=5365" title="주요지표 페이지로 이동">주요지표</a></li>
								<li><a href="/front/contents/chart1ListPage.do?menuId=5366" title="농작물재해보험 페이지로 이동">농작물재해보험</a></li>
								<li><a href="/front/contents/chart3ListPage.do?menuId=5367" title="가축재해보험 페이지로 이동">가축재해보험</a></li> 
								<li><a href="/front/contents/chart5ListPage.do?menuId=5368" title="보혐료수준 페이지로 이동">보혐료수준</a></li>
							</ul>
						</li>
					   <li><a href="/front/board/boardContentsListPage.do?boardId=20061&menuId=5370" title="손해평가사 자료실 페이지로 이동">손해평가사 자료실</a></li>
						<li>
							<a class="depth3_open">농림수산정책자금 검사</a>
							<ul class="depth3">
								<li><a href="/front/contents/sub.do?contId=100&menuId=5358" title="관련 법규 페이지로 이동">관련 법규</a></li>
								<li><a target="_blank" href="/file/inspectExample/2021_Inspect_Examples.pdf" title="검사사례">검사사례 &nbsp;<img src="/images/common/ico_new_win.png" alt="검사사례 새창열림"></a></li>
							</ul>
						</li>
						<li>
							<a class="depth3_open">농특회계 융자금 관리</a>
							<ul class="depth3">
								<li><a href="/front/contents/sub.do?contId=101&menuId=5376" title="관련 법령 페이지로 이동">관련 법령</a></li>
							</ul>
						</li>
					</ul>
				</li>

				<li><a>알림마당</a>
					<ul class="depth2">
						<li>
							<a class="depth3_open">공지사항</a>
							<ul class="depth3">
								<li><a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=41&t=1" title="농림수산식품모태펀드 페이지로 이동">농림수산식품모태펀드</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=41&t=3" title="농업정책보험 페이지로 이동">농업정책보험</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=41&t=4" title="손해평가사 페이지로 이동">손해평가사</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=41&t=5" title="농림수산정책자금 검사 페이지로 이동">농림수산정책자금 검사</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=41&t=6" title="농특회계 융자금 관리 페이지로 이동">농특회계 융자금 관리</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=10026&menuId=41&t=9" title="기타 페이지로 이동">기타</a></li>
							</ul>
						</li>
						<li>
							<a href="/front/board/boardContentsListPage.do?boardId=42&menuId=42" title="보도자료 페이지로 이동">보도자료</a>
						</li>
						<li>
							<a href="/front/board/boardContentsListPage.do?boardId=43&menuId=43" title="채용·행사 페이지로 이동">채용·행사</a>
						</li>
						<li>
							<a href="/front/board/boardContentsListPage.do?boardId=44&menuId=44" title="해명·설명 페이지로 이동">해명·설명</a>
						</li>
						<li>
							<a href="/front/board/boardContentsListPage.do?boardId=45&menuId=45" title="포토뉴스 페이지로 이동">포토뉴스</a>
						</li>
						<li>
							<a href="/front/contents/sub.do?contId=96&menuId=5379" title="입찰정보 페이지로 이동">입찰정보</a>
						</li>
						<li>
							<a href="/front/contents/sub.do?contId=46&menuId=5482" title="개인정보처리방침 페이지로 이동">개인정보처리방침</a>
						</li>
					</ul>
				</li>

				<li><a>고객참여</a>
					<ul class="depth2">
						<li>
							<a class="depth3_open">고객헌장</a>
							<ul class="depth3">
								<li><a href="/front/contents/sub.do?contId=129&menuId=5462" title="전문 페이지로 이동">전문</a></li>
								<li><a href="/front/contents/sub.do?contId=130&menuId=5463" title="핵심서비스 이행표준 페이지로 이동">핵심서비스 이행표준</a></li>
								<li><a href="/front/contents/sub.do?contId=131&menuId=5464" title="고객응대서비스 이행표준 페이지로 이동">고객응대서비스 이행표준</a></li>
							</ul>
						</li>
						<li>
							<a class="depth3_open">질의응답(Q&amp;A)</a>
							<ul class="depth3">
								<li><a href="/front/board/boardContentsListPage.do?boardId=51&menuId=51&t=1" title="농림수산식품모태펀드 페이지로 이동">농림수산식품모태펀드</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=51&menuId=51&t=3" title="농업정책보험 페이지로 이동">농업정책보험</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=51&menuId=51&t=4" title="손해평가사 페이지로 이동">손해평가사</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=51&menuId=51&t=5" title="농림수산정책자금 검사 페이지로 이동">농림수산정책자금 검사</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=51&menuId=51&t=6" title="농특회계 융자금 관리 페이지로 이동">농특회계 융자금 관리</a></li>
							</ul>
						</li>
						<li>
							<a class="depth3_open">FAQ</a>
							<ul class="depth3">
								<li><a href="/front/board/boardContentsListPage.do?boardId=52&menuId=52&t=1" title="농림수산식품모태펀드 페이지로 이동">농림수산식품모태펀드</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=52&menuId=52&t=3" title="농업정책보험 페이지로 이동">농업정책보험</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=52&menuId=52&t=5" title="손해평가사 페이지로 이동">손해평가사</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=52&menuId=52&t=6" title="농림수산정책자금 검사 페이지로 이동">농림수산정책자금 검사</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=52&menuId=52&t=7" title="농특회계 융자금 관리 페이지로 이동">농특회계 융자금 관리</a></li>
							</ul>
						</li>
						<li>
							<a href="/front/board/boardContentsListPage.do?boardId=20062&menuId=55" title="고객제안 페이지로 이동">고객제안</a>
						</li>
						<li>
							<a href="/front/contents/sub.do?contId=84&menuId=56" title="국민신문고 페이지로 이동">국민신문고</a>
						</li>
						<li>
							<a href="/front/contents/sub.do?contId=140&menuId=5481" title="국민제안 페이지로 이동">국민제안</a>
						</li>
						<li>
							<a href="/front/contents/sub.do?contId=85&menuId=57" title="부정부패&nbsp;&middot;&nbsp;공익 신고마당 페이지로 이동">부정부패&nbsp;&middot;&nbsp;공익 신고마당</a>
						</li>
						<li>
							<a href="/front/contents/sub.do?contId=82&menuId=58" title="정책자금 부당사용 신고센터 페이지로 이동">정책자금 부당사용 신고센터</a>
						</li>
					</ul>
				</li>

				<li><a>기관 소개</a>
					<ul class="depth2">
						<li>
							<a class="depth3_open">농업정책보험금융원 소개</a>
							<ul class="depth3">
								  <li><a href="/front/contents/sub.do?contId=68&menuId=5338" title="임무 페이지로 이동">임무</a></li>
								  <li><a href="/front/contents/sub.do?contId=69&menuId=5339" title="인사말 페이지로 이동">인사말</a></li>
								  <li><a href="/front/contents/sub.do?contId=70&menuId=5340" title="연혁 페이지로 이동">연혁</a></li>
								  <li><a href="/front/contents/sub.do?contId=71&menuId=5341" title="미션/비전 페이지로 이동">미션/비전</a></li>
								  <li><a href="/front/contents/sub.do?contId=72&menuId=5342" title="조직 및 직원 페이지로 이동">조직 및 직원</a></li>
								  <li><a href="/front/contents/sub.do?contId=73&menuId=5343" title="CI소개 페이지로 이동">CI소개</a></li>
								  <li><a href="/front/contents/sub.do?contId=74&menuId=5344" title="찾아오시는 길 페이지로 이동">찾아오시는 길</a></li>
							</ul>
						</li>
						<li>
							<a class="depth3_open">열린경영</a>
							<ul class="depth3">
							
								<li><a href="/front/contents/sub.do?contId=75&menuId=5345">경영공시(알리오)</a></li>
								<li><a
									href="/front/contents/sub.do?contId=76&menuId=5346&t=1"
									title="추진전략 페이지로 이동">윤리경영</a></li>
								<li><a
									href="/front/board/boardContentsListPage.do?boardId=61&menuId=5374"
									title="청렴한 농금원 페이지로 이동">청렴한 농금원</a></li>
								<li><a
									href="/front/board/boardContentsListPage.do?boardId=62&menuId=5375"
									title="사회공헌 페이지로 이동">사회공헌</a></li>
								<li><a href="/front/board/boardContentsListPage.do?boardId=20081&menuId=5468" 
									title="인권경영페이지로 이동">인권경영</a></li>      
							
						</ul>
					</li>
					</ul>
				</li>

			</ul>

		</nav>
		<!-- 안성맞춤아트홀일 경우 추가 하위 아이콘 적용 -->

		</div>
		<ul class="btn_wrap">
			<li><a href="#none" class="btn_pop_open">팝업열기</a></li>
			<li><a href="#none" class="close">메뉴 닫기</a></li>
		</ul>
	</div>
	<!--//mobileNavi-->
	<!--  <div id="mask_mn"></div> --> <!-- 20230303 웹 접근성 2차 -->
	
	<div id="chatbot" class="chatbot"><!-- 챗봇 김동민 대리 추가 2022.12.23 -->
		<!-- <button id="chatbotbtn" class="chatbotbtn" type="button" onClick="PopupNoDisplay_1()">onclick="this.parentElement.style.display='none'"<span>&times;</span></button> -->
		<!-- <a class="chatbotA" href="javascript:void(0);" onclick="exit2()" style="font-size:small; position: relative; right:-130px; top:110px;"">X</a> -->
		<a href="#none" target="_blank" onClick="window.open('https://answerny.ai/chatbot/projects/apfs/chatbot_apfs.html','pagename','resizable,height=800,width=400,left=1200,top=100'); return false;">
		<img src="/images/common/apfs_챗봇.png" alt="무엇이든 물어보세요! 챗봇 새창 열기"></a>
		<div class="chatbotA"><a class="chatbotA" href="javascript:void(0);" onclick="exit2()">하루동안 보지 않기</a></div>
	</div>
	
	
	<!--<div id="playExe" class="playExe">
			<a onclick="playExe();">손해사정평가 시뮬레이터</a>
        </div>-->
	
	<!--container-->
    <div id="container">

        <!--visual-->
        <div class="visual" id="containerContent">
            <div class="visual_slider over_h swiper-container">
				
				<!--
				<ul class="swiper-wrapper over_h">
					<li class="swiper-slide fl_left"><a href="#none" target="_blank" title="새 창 열림" tabindex="-1"><img src="/images/main/img_visual_1.jpg" alt="" /></a></li>
					<li class="swiper-slide fl_left"><img src="/images/main/img_visual_1.jpg" alt="" class="imgCenter" /></li>
					<li class="swiper-slide fl_left"><img src="/images/main/img_visual_1.jpg" alt="" class="imgCenter" /></li>
					<li class="swiper-slide fl_left"><img src="/images/main/img_visual_1.jpg" alt="" class="imgCenter" /></li>
					<li class="swiper-slide fl_left"><img src="/images/main/img_visual_1.jpg" alt="" class="imgCenter" /></li>
                </ul>
				-->
				
                <ul class="swiper-wrapper over_h">
                <c:forEach  var="sRow" items="${mainPhotoList}" varStatus="status">
					<li class="swiper-slide fl_left" id="slideP3">
						<c:set var="refUrlTmp" value="${sRow.refUrl}" />
						<c:set var="refUrlTmp" value="${fn:replace( fn:replace(refUrlTmp, 'http://', ''), 'https://', '' )}" />
						<c:choose>
							<c:when test="${refUrlTmp ne ''}">
<%-- 								<a href="${sRow.refUrl}" target="_blank" title="새 창 열림" ><!-- tabindex="-1" --><img src="${sRow.filePath}${sRow.fileNm}" alt="${sRow.title}" class="imgCenter"/></a> --%>
								<a href="${sRow.refUrl}" target="_self"><!-- tabindex="-1" --><img src="${sRow.filePath}${sRow.fileNm}" alt="${sRow.title}" class="imgCenter"/></a>
							</c:when>
							<c:otherwise>
								<img src="${sRow.filePath}${sRow.fileNm}" alt="${sRow.title}" class="imgCenter" />
							</c:otherwise>
						</c:choose>
					</li>
				</c:forEach>
                </ul>
			
            </div>
			<div class="main_visual_control"><!--  2020.10.23 추가 -->
				<div class="autoplay_cnt">
					<a href="#n" class="stop" id="btnStop"><img src="/images/main/main_visual_stop.gif" alt="정지"></a>
					<a href="#n" class="start"><img src="/images/main/main_visual_start.gif" alt="재생"></a>
				</div>
				<ul class="visual_paging"></ul>
			</div>
			
			
        </div>
		<script src="/js/apfs/swiper.jquery.min.js"></script><!-- 누락된 내용 추가 = 2020.10.14 -->
		<script>
			//	메인 슬라이드 동작
			var main_visual = new Swiper($('div.visual_slider'), {
				autoplay: 10000,
				autoplayDisableOnInteraction: false,
				setWrapperSize: true,
				pagination: $('ul.visual_paging'),
				paginationClickable: true,
				paginationBulletRender: function (index, className) {
					return '<li class="swiper-pagination-bullet"><a href="#none" class="btn_paging"> 메인 슬라이드 ' + (index + 1) + ' 페이지 </a></li>';
				},
				onInit: function(swiper){
					setTimeout(function(){
						$(".swiper-pagination-bullet").eq(0).find('a').attr('title', '선택됨');
					},100)
				},
				onSlideChangeStart: function(swiper){
					$(".swiper-pagination-bullet > a").removeAttr('title');
					if($('#slideP3').hasClass('swiper-slide-prev') == true){	//2024 웹 접근성 시작
						$(".swiper-slide-prev > a").attr('tabindex', '-1');
						$(".swiper-slide-next > a").removeAttr('tabindex', '-1');
					}else if($('#slideP3').hasClass('swiper-slide-next') == true){
						$(".swiper-slide-next > a").attr('tabindex', '-1');
						$(".swiper-slide-prev > a").removeAttr('tabindex', '-1');
					}else if($('#slideP3').hasClass('swiper-slide-active') == true){
						$(".swiper-slide-active > a").removeAttr('tabindex', '-1');
					}															//2024 웹 접근성 끝
					
					$(".swiper-pagination-bullet-active > a").attr('title', '선택됨');
				}
			});
			$('.main_visual_control .stop').click(function(){
				main_visual.stopAutoplay();
				$(this).hide();
				$('.main_visual_control .start').css('display', 'inline-block');
			});

			$('.main_visual_control .start').click(function(){
				main_visual.startAutoplay();
				$(this).hide();
				$('.main_visual_control .stop').css('display', 'inline-block');
			});                
		</script>
        <!--//visual-->

        <!--section1-->
        <div id="section1">
        	<!--main_business-->
        	<div class="main_business">
				<div class="scroll">
					<ul>
						<li><a href="/front/contents/sub.do?contId=44&menuId=5320" title="농림수산식품 모태펀드" class="main_"><span>농림수산식품<br />모태펀드</span></a></li>
						<li><a href="/front/contents/sub.do?contId=53&menuId=5322" title="농식품전문 크라우드펀딩"><span>농식품전문<br />크라우드펀딩</span></a></li>
						<li><a href="/front/contents/sub.do?contId=54&menuId=5324" title="농업정책보험"><span class="spacing">농업정책보험</span></a></li>
						<li><a href="/front/contents/sub.do?contId=57&menuId=5327" title="손해평가사"><span class="spacing">손해평가사</span></a></li>
						<li><a href="/front/contents/sub.do?contId=58&menuId=5329" title="농어업재해보험기금"><span>농어업재해<br/>재보험기금</span></a></li>
						<li><a href="/front/contents/sub.do?contId=63&menuId=5333" title="농림수산 정책자금 검사"><span>농림수산<br />정책자금 검사</span></a></li>
						<li><a href="/front/contents/sub.do?contId=65&menuId=5335" title="농특회계 융자금 관리"><span>농특회계<br />융자금 관리</span></a></li>
					</ul>
				</div>
            </div>
            <!--//main_business-->
        </div>
		<!--//section1-->
		
		<!--//section2-->		
		<div id="section2">
			<!--news_area-->
            <div class="news_area">
                <ul class="list">
              	<c:forEach  var="row" items="${mainBoardList}" varStatus="status">
                    <li class="news0${status.index+1}">
                        <p class="tit"><a href="${row.refUrl}" title="${row.title}으로 이동">${row.title}</a></p>
                        <ul class="news_list">		
                        	<c:forEach  var="sRow" items="${mainBoardContentsList2}" varStatus="status1">
								<c:if test="${row.boardId eq sRow.boardId}">
								<li>		<!-- 23년 웹접근성 tabindex 추가 -->
									<a href="${sRow.refUrl}<c:if test="${not empty sRow.refUrl}">&menuId=${row.menuId}</c:if>">
										<c:if test="${sRow.regDt eq now}"><img src="/images/main/icon_new.gif" alt="새글"></c:if>
										<strong>${fn:substring(sRow.title,0,50)}</strong>
										<span class="date">
										${fn:substring(sRow.regDt,0,4)}-${fn:substring(sRow.regDt,4,6)}-${fn:substring(sRow.regDt,6,8)}
										</span>
									</a>
	
									
	
								</li>
								</c:if>
							</c:forEach>
                        </ul>
                        <!-- <div class="more"><a href="${row.refUrl}" title="${row.title}으로 이동"><img src="/images/main/btn_more.gif" alt="${row.title} 더보기" /></a></div> -->
                    </li>
				</c:forEach>
                </ul>
            </div>
            <!--//news_area-->

            <!--pzone-->
            <div id="popupzone">
      			<div id="popupzone_group">
                    <div class="mh_group">
                    	<h3>팝업존</h3>
                    </div>
                    <div class="auto_btn">
                        <span><button class="play cursor" title="배너 재생하기">재생</button></span>
                        <span><button class="stop cursor" title="배너 정지하기">정지</button></span>
                    </div>
                    <dl class="slide-list" id="slides1">
                    	<c:forEach var ="mainPopupList" items="${mainPopupList}" varStatus="status">
                    		<c:if test="${mainPopupList.useYn eq 'Y'}"><%//  2021.05.06  이동할 링크가 없는 경우 보완 %>
								<c:set var="banUrlTmp" value="${fn:replace( fn:replace(mainPopupList.url, 'http://', ''), 'https://', '' )}" />
                        		<dt><a href="#slides1"><c:out value="${status.count}"/></a></dt>
                        		<dd id="slideP">
								<c:choose>
									<c:when test="${banUrlTmp ne ''}">
	                        			<a href="${mainPopupList.url}" title="새창" target="_blank"><img  src="${mainPopupList.filePath}${mainPopupList.fileNm}" alt="${mainPopupList.title}" id="slideP2"/></a>
									</c:when>
									<c:otherwise>
	                        			<img  src="${mainPopupList.filePath}${mainPopupList.fileNm}" alt="${mainPopupList.title}"/>
		    						</c:otherwise>
								</c:choose>
                        		</dd>
                        	</c:if>
                        </c:forEach>
                    </dl>
        		</div>
        	</div>
		</div>
		<script>
		//팝업존 컨트롤
		$('#popupzone_group').moveContents({
		  eventEl: '.slide-list>dt>a',
		  conEl: '.slide-list>dd',
		  controlFlag: true,
		  iconFlagEvent: "click focus",
		  btnPlay: '.play',
		  btnStop: '.stop',
		  effect: 'slide',
 		  autoPlay: true,
		  slideRepeat: true,
		  slideFor: "left",
// 		  slideValue: 487,
		  slideValue: 530,	//2024 웹 접근성
		  changeTimer: 5000,
		  aniTimer: 300
		});
		
//  		$("#popupzone .mh_group h3").css('color', 'red');
 		if($("#slideP").hasClass('on') != true){
 			$("#slideP2").attr('tabindex', '-1');
 		}
	 	else if($("#slideP").hasClass('on') == true){
	 			$("#slideP2").removeAttr('tabindex', '-1');
	 		}
		</script>
		<!--//pzone-->        
        <!--//section2-->

        <!--section3-->
        <div id="section3">
            <div class="section3_inner">
            	<div class="m_communi">
                	<!-- <h3>고객참여</h3> -->
                    <ul>
                        <li class="icon_communi01"><a href="https://assist.apfs.kr/usr/main/main.do" title="ASSIST(농식품 투자정보 플랫폼) 새 창 열림" target="_blank"><span>ASSIST<br />(농식품 투자정보 플랫폼)</span></a></li>
                        <li class="icon_communi02"><a href="/front/contents/sub.do?contId=82&menuId=58" title="농림수산정책자금 부당사용 신고센터 바로가기"><span>농림수산정책자금<br />부당사용 신고센터</span></a></li>
                        <li class="icon_communi03"><a href="/front/board/boardContentsListPage.do?boardId=20062&menuId=55" title="고객제안 바로가기"><span>고객제안</span></a></li>
                        <li class="icon_communi04"><a href="/front/contents/sub.do?contId=84&menuId=56" title="국민신문고 바로가기"><span>국민신문고</span></a></li>
                        <li class="icon_communi05"><a href="/front/contents/sub.do?contId=85&menuId=57" title="부정부패&nbsp;&middot;&nbsp;공익 신고마당 바로가기"><span>부정부패&nbsp;&middot;&nbsp;공익<br />신고마당</span></a></li>
                        <li class="icon_communi06"><a href="https://api.apfs.kr/" title="가축재해지방비 바로가기"><span>가축재해지방비</span></a></li>
<!--                         <li class="icon_communi06"><a href="https://api.apfs.kr/" title="가축재해지방비 바로가기"><span>7번째</span></a></li> -->
<!--                         <li class="icon_communi06"><a href="https://api.apfs.kr/" title="가축재해지방비 바로가기"><span>8번째</span></a></li> -->
                    </ul>
                </div>
                <!-- <div class="quick_service">
                	<h3>자주 찾는 서비스</h3>
                    <ul>
                        <li class="icon_quick01"><a href="/front/contents/sub.do?contId=79&menuId=12&t=4" title="농어업재해재보험기금공시 바로가기">농어업재해재보험기금공시</a></li>
                        <li class="icon_quick02"><a href="http://api.apfs.kr/" title="가축재해보험 지방비관리시스템 새 창 열림" target="_blank">가축재해보험 지방비관리시스템 </a></li>
                        <li class="icon_quick03"><a href="/front/contents/sub.do?contId=72&menuId=5342" title="조직 및 직원 바로가기">조직 및 직원</a></li>
                        <li class="icon_quick04"><a href="/front/board/boardContentsListPage.do?boardId=43&menuId=43" title="채용안내 바로가기">채용안내</a></li>
                    </ul>
                </div> -->
            </div>
        </div>
        <!--//section3-->
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
						<button class="title" type="button" title="펼치기">해외사이트 바로가기<span>펼치기</span></button>
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
						<address>${footerInfopage.addr} <br />
                    <span id="telInfo"></span><br>
                    webmaster : dmkim@apfs.kr
                    <%-- <span id="telInfo2"></span><br>webmaster : dmkim@apfs.kr--%>
                		</address>
						<p class="copyright">Copyright ⓒ 농업정책보험금융원 All rights reserved.</p>
					</div>
					<p	 class="wa-area"><a href="/download/2023-0367%20정보통신접근성%20품질인증서-농업정책보험금융원.pdf" title="pdf 파일보기 새창" target="_blank"><img src="/images/common/wa_mark.png" alt="(사)한국장애인단체총연합회 한국웹접근성인증평가원 웹 접근성 우수사이트 인증마크(WA인증마크)" width="140"></a></p><!-- //2023-03-23 -->
				</div>
				<!--//copy_wrap-->
			</div>
			<!-- //foot_bot -->
        </div>
        <!--//footer_warp-->
    </footer>
    <!--//footer-->

</div>
<!--//warp-->

 <%-- <c:import url = "/WEB-INF/views/front/user/inc/mainPopup.jsp"/> --%> <!-- 공지 띄우는 용도 -->



</body>
</html>
