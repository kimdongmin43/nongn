﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script src="/js/apfs/board.js"></script>
<script>
var boardContentsListPageUrl = "<c:url value='/front/board/boardContentsListPage.do'/>";
var boardContentsWriteUrl = "<c:url value='/front/board/boardContentsWrite.do'/>";
var boardContentsListUrl = "<c:url value='/front/board/boardContentsList.do'/>";
var boardContentsViewUrl = "<c:url value='/front/board/boardContentsView.do'/>";
var boardEtcContentsViewUrl = "<c:url value='/front/board/boardEtcContentsView.do'/>";
var authCheckUrl = "<c:url value='/front/auth/authCheck.do'/>";

var auth_sname = "${MEMBER_AUTH.sName}";
var memId = "${MEMBER.memId}";

$(document).ready(function(){

	$('#modal-pwdCheck-write').popup();
	if("${param.miv_pageNo}"){
		go_Page("${param.miv_pageNo}");
	}
	else{
		search();
	}
	
	if("${param.t}" != "" || "${param.selTab}" != ""){
		var  param_t = ${param.t}+0;
		var  param_t2 = ${param.selTab}+0;
		if(param_t<1){param_t=0;}
		if(param_t2<1){param_t2=0;}
		if(param_t2>0){param_t=param_t2;}
		if(param_t>3 ){param_t++;}
		setTimeout("searchTab("+param_t+")",100);
		if(param_t==10 ){param_t=4;}
		setTimeout("type_list("+param_t+")",200);
	}
	else{
	}

	$("#skip_nav").focus();
});
// 검색
function search(){
	boardLiat();
}
//240119 검색버튼 클릭시 페이징번호 초기화
function searchBtn(){
	$("#miv_pageSize").val($("#pageSize").val());
	$("#miv_pageNo").val(1);		//페이징번호를 초기화
	boardLiat();
}


//엔터검색
function enter(){
    if(event.keyCode == 13) {
    	$("#miv_pageSize").val($("#pageSize").val());
    	$("#miv_pageNo").val(1);	//페이징번호를 초기화
    	search();
    }
}

function popupShow(){
	$("#modal-pwdCheck-write").popup('show');
}

function popupClose(){
	$("#modal-pwdCheck-write").popup('hide');
}

//초기화
function formReset(){
	$("#reply_ststus").val("");
	$("#cate_id").val("");
	$("#searchKey").val("T").prop("selected", true);
	$("#searchTxt").val("");
}

//페이징 사이즈
function changePageSize(){
	$("#miv_pageSize").val($("#pageSize").val());
	$("#miv_pageNo").val(1);
 	search();
}

// 페이지 이동
function go_Page(page){
	$("#miv_pageNo").val(page);
	search();
}


//게시판 리스트 불러오기
function boardLiat(){
	$.ajax({
        url: boardContentsListUrl,
        dataType: "html",
        type:"post",
        data: jQuery("#listFrm").serialize(),
        success: function(data) {
        	$(".contents_detail").html(data);
        	$('#preSearch').html(''); 
        },
        error: function(e) {
        }
    });
}

function searchTab(num){
	$("#miv_pageNo").val(${param.miv_pageNo eq null?'1':param.miv_pageNo});
}

function searchTabClick(num){
	
	$("#miv_pageNo").val(1);
	if(num==0){num='';}
	// 2018.04.09 : 알림마당>공지사항의 기타Tab을 9로 만들기 위해 아래와 같이 처리가 되어 농업정책보험>보험금 지급 사례의 '농업인안전보험'탭이 4인데 9로 변경되어 조회되지 않는 오류 발생함.
	// 농업인안전보험 탭의 값을 -4로 변경 후 예외 처리 추가함.
	if(num == -4) {
		num = 4;
	} else {
		if(num==4){num=10;}
		if(num>4){num--;}	
	}	
	$("#selTab").val(num);
	
	search();
}

function searchAll(){
	type_list(0);
	$("#miv_pageNo").val(1);
	$("#selTab").val('');
	search();
}

function pwdCheck(){
	$.ajax({
        url: "/front/board/pwdCheck.do",
        dataType: "json",
        type:"post",
        data: {
        	contId : $("#contId").val(),			<% // pwdContId -> contId 로 변경 2021.06.30 %>	
        	boardId : $("#boardId").val(),
        	password : $("#password").val()
        },
        success: function(data) {

        	if (data.success == "true") {
        		var f = document.listFrm;
        		f.password = $("#password").val();
                f.target = "_self";
                f.action = boardContentsViewUrl;
                f.submit();
                return;
			}
        	else{
        		alert("비공개 글은 작성자 본인만 열람 하실수 있습니다.");
        		$("#password").focus();		//2024 웹 접근성
        	}
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });


}


function makeTabString(strSelTab, strMenuId) {
	var hiddenString = "";
	if ( strMenuId == "5399" ) {
		switch (strSelTab) {
			case "1" :
				hiddenString = "농작물재해보험";
				break;
			case "2" :
				hiddenString = "농기계종합보험";
				break;
			case "3" :
				hiddenString = "가축재해보험";
				break;
			case "4" :
				hiddenString = "농업인안전보험";
				break;
			default :
				hiddenString = "전체보기";
		}
	} else if ( (strMenuId == "41") || (strMenuId == "51") || (strMenuId == "52") ) {
		switch (strSelTab) {
			case "1" :
				hiddenString = "농림수산식품모태펀드";
				break;
			case "2" :
				hiddenString = "농식품전문 크라우드펀딩";
				break;
			case "3" :
				hiddenString = "농업정책보험";
				break;
			case "9" :
				hiddenString = "기타";
				break;
			case "4" :
				hiddenString = "손해평가사";
				break;
			case "5" :
				hiddenString = "농림수산정책자금 검사";
				break;
			case "6" :
				hiddenString = "농특회계 융자금 관리";
				break;
			default :
				hiddenString = "전체보기";
		}
	} else if ( strMenuId == "5363" ) {
		switch (strSelTab) {
			case "1" :
				hiddenString = "농작물재해보험";
				break;
			case "2" :
				hiddenString = "농기계종합보험";
				break;
			case "3" :
				hiddenString = "가축재해보험";
				break;
			case "4" :
				hiddenString = "농업인안전보험";
				break;
			default :
				hiddenString = "전체보기";
		}
	} else if ( strMenuId == "5370" ) {
		switch (strSelTab) {
			case "1" :
				hiddenString = "시험관련";
				break;
			case "2" :
				hiddenString = "기출문제";
				break;
			case "3" :
				hiddenString = "기타";
				break;
			default :
				hiddenString = "전체보기";
		}
	}
	$("#hiddenString").text(hiddenString);
	
}

//비밀글 엔터검색
function enterPassword(){
    if(window.event.keyCode == 13) {
    	pwdCheck();
    }
}
</script>


<!-- search_area -->
<form id="listFrm" name="listFrm" method="get">
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="mode" name='mode' value="W" />
	<input type='hidden' id="contId" name='contId' value="" />
	<input type='hidden' id="delYn" name='delYn' value="N" />
	<input type='hidden' id="menuId" name='menuId' value="${param.menuId }" />
	<input type='hidden' id="boardId" name='boardId' value="${param.boardId }" />
	<input type='hidden' id="selTab" name='selTab' value="${(param.etc0 == null)?param.selTab:param.etc0}" /> <!--  주요업무 하위에서 질의응답 작성 후 해당 하위메뉴로 전달하기 위해 수정 2021.01.11-->
<%-- 	<% //input type='hidden' id="selTab" name='selTab' value="${!param.t?param.selTab:param.t}" / %>	<!-- 20221013 김동민 웹 품질진단 --> --%>
	<input type='hidden' id="requestUrl" name='requestUrl'  />
	<div id="preSearch">
	<input type='hidden' name='searchKey' value="A" />
	<input type='hidden' name='searchTxt' value="${param.searchTxt}"  />
	</div>

<!--// search_area -->

<!-- contentsList -->
<div id="location_area">
	<div class="content_tit" id="containerContent">
        <h3>${boardinfo.title}</h3>
    </div>
    <div class="content">
    	<c:if test="${param.menuId eq '5469'}">
    		<h4 class="hidden">
    			농식품경영체 투자 전 지원사업 프로세스는 농식품경영체 컨설팅 지원사업 프로그램과 IR로 구성되어 있으며 다음의 4단계로 이루어져 있습니다.
    			1. 현장코칭을 통해 사업계획서 진단, 맞춤형컨설팅을 통해 수요를 조사합니다.
    			2. 맞춤형컨설팅을 통해 사업계획서를 고도화하고 맞춤형 경영컨설팅을 실행합니다.
    			3. 투자유치역량강화 교육을 통해 투자유치 집합 교육, 자금관련 지원사업을 안내하고 사전 IR을 실행하여 공개 사업설명회(IR) 참가 기업을 선정합니다.
    			4. 공개사업설명회(IR)을 통해 농식품투자조합 심사역 및 농식품분야 투자에 관심있는 VC 대상으로 사업을 설명합니다.
    			유의사항으로는,
    			1. 1~3월 중 접수 건은 4월부터 컨설팀 프로그램을 시행하며, 컨설팅 프로그램(현장코칭, 맞춤형컨설팅, 투자유치역량강화 교육)은 3개월 정도 소요됩니다.
    			2. 컨설팅 프로그램 3단계에서 시행하는 사전 IR에서 투자유치 역량을 확보한 기업(10개 내외)이 공개 사업설명회(IR)에 참여 가능하며 공개 IR 미참여 기업은 
    			기업 온라인 IR이 예정되어 있습니다.
    		</h4>
    		<img src="/images/about_apfs/applyinvest.png" alt="농식품경영체 투자 전 지원사업 프로세스" />
    		<br><br>
    	</c:if>
    	<c:if test="${param.menuId eq '5470'}">
    		<h4 class="hidden">
    			크라우드펀딩은 군중 또는 다수를 의미하는 영어단어 크라우드(Crowd)와 자금조달을 뜻하는 펀딩(Funding)을 조합한 용어.
    			크라우드펀딩(Crowd Funding) = 크라우드 Crowd + 펀딩 Funding
    			농식품 크라우드펀딩은 농식품 기업이 창업 초기에 필요한 자금을 마련할 수 있도록 중개업자의 온라인플랫폼에서 "집단지성(The Wisdom of Crowds)" 활용하여 다수의 소액투자자로부터 자금을 조달하는 행위.
    			1. 현장코칭
					1) 지원내용 : 전문 컨설팅 기관이 직접 농식품 기업에 방문하여, 크라우드펀딩 기본교육, 투자유치 등 1:1 상담.
					2) 지원한도 : 선착순 70개사 지원.
    			2. 컨설팅 비용지원
    				1) 지원내용 : 크라우드 펀딩을 위한 법률, 회계자문혹은  홍보 콘텐츠 제작(랜딩페이지에 게재되는 동영상, 사진, 상세페이지 디자인 등) 등 전문컨설팅 비용 지원.
    				2) 지원한도 : 증권형 - 250만 원 이내. 후원형 : 100만 원 이내. (VAT 제외 100%)
    			3. 수수료 지원
    				1) 지원내용 : 펀딩 성공 시 중개사에 지급하는 수수료를 지원.(수수료는 모집금액의 일정 비율을 적용한 금액)
    				2) 지원한도 : 증권형 - 300만 원 이내. 후원형 : 100만 원 이내. (VAT 제외 100%)
    			기타 유의사항으로, 
    			1. 자세한 내용은 "지원사업 자료실-2021년 지원사업 운영기준(안)"을 확인해 주시기 바랍니다.
    			2. 모든 지원사업은 중복 신청이 가능하며, 선착순으로 진행되므로 예산 소진 시 조기 마감될 수 있습니다.
    		</h4>
    		<img src="/images/about_apfs/cloudfundingguide_210225.png" alt="농식품 크라우드펀딩이란?" />
    		<br><br>
    	</c:if>

	    <c:if test="${param.menuId eq '10026' or param.menuId eq '41' or param.menuId eq '52' or param.menuId eq '51' or savedMenuId eq '10026' or savedMenuId eq '41' or savedMenuId eq '52' or savedMenuId eq '51'}">
		<div class="tab_style2"><!-- 공지사항 -->
		    <ul>
		    	<li class="w4" onclick="searchTabClick(0);" id="tab0"><a href="#none" class="active" title="선택됨">전체보기</a></li>
		        <li class="w4" onclick="searchTabClick(1);" id="tab1"><a href="#none">농림수산식품모태펀드</a></li>
		        <li class="w4" onclick="searchTabClick(3);" id="tab3"><a href="#none">농업정책보험</a></li>
		        <li class="w4" onclick="searchTabClick(8);" id="tab8"><a href="#none">양식수산물재해보험</a></li><!-- 2021.07.14 -->
		        <li class="w4" onclick="searchTabClick(4);" id="tab4"><a href="#none">기타</a></li>
		        <li class="w4" onclick="searchTabClick(5);" id="tab5"><a href="#none">손해평가사</a></li>
		        <li class="w4" onclick="searchTabClick(6);" id="tab6"><a href="#none">농림수산정책자금 검사</a></li>
		        <li class="w4" onclick="searchTabClick(7);" id="tab7"><a href="#none">농특회계 융자금 관리</a></li>
		    </ul>
		</div>
		</c:if>
		<c:if test="${param.menuId eq '5363' or savedMenuId eq '5363'
					   or param.menuId eq '5399' or savedMenuId eq '5399'
					   }">
			<div class="tab_style"><!--  농업정책보험 > 보험금 지급 사례 -->
			    <ul>
			        <li class="w5" onclick="searchTabClick(0);" id="tab0"><a href="#none" class="active" title="선택됨">전체보기</a></li>
			        <li class="w5" onclick="searchTabClick(1);" id="tab1"><a href="#none">농작물재해보험</a></li>
			        <li class="w5" onclick="searchTabClick(2);" id="tab2"><a href="#none">농기계종합보험</a></li>
			        <li class="w5" onclick="searchTabClick(3);" id="tab3"><a href="#none">가축재해보험</a></li>
			        <li class="w5" onclick="searchTabClick(-4);" id="tab4"><a href="#none">농업인안전보험</a></li>
			    </ul>
			</div>
		</c:if>
		<c:if test="${(param.menuId eq '5357' or savedMenuId eq '5357'	or param.menuId eq '5408' or savedMenuId eq '5408')and param.boardId ne '20066'	}"><!--  농림수산정책자금 검사 > 검사사례 -->
		<div class="tab_style">
		    <ul>
		    	<li class="w4" onclick="searchTabClick(0);" id="tab0"><a href="#none" class="active" title="선택됨">전체보기</a></li>
		        <li class="w4" onclick="searchTabClick(1);" id="tab1"><a href="#none">대출취급 부적정</a></li>
		        <li class="w4" onclick="searchTabClick(2);" id="tab2"><a href="#none">부당사용 및 중도화수 사유 발생</a></li>
		        <li class="w4" onclick="searchTabClick(3);" id="tab3"><a href="#none">사후관리.채권보전 조치 소홀</a></li>
		    </ul>
		</div>
		</c:if>
		
		<c:if test="${param.menuId eq '5370' or param.menuId eq '5404' }"><!--  자료실 > 손해평가사 자료실 -->
			<div class="tab_style">
			    <ul>
			    	<li class="w4" onclick="searchTabClick(0);" id="tab0"><a href="#none" class="active" title="선택됨">전체보기</a></li>
			        <li class="w4" onclick="searchTabClick(1);" id="tab1"><a href="#none">시험관련</a></li>
			        <li class="w4" onclick="searchTabClick(2);" id="tab2"><a href="#none">기출문제</a></li>
			        <li class="w4" onclick="searchTabClick(3);" id="tab3"><a href="#none">기타</a></li>
			    </ul>
			</div>
		</c:if>
		
		<div class="contents_detail">	</div>
	</div>
</div>
<!-- //contentsList -->

</form>


<div id="modal-pwdCheck-write" style="width:300px;background-color:white">
		<div id="wrap">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title">비공개 게시물 입니다.</h1>
				<a href="javascript:popupClose()" class="pop_close" title="페이지 닫기">
					<span>닫기</span>
				</a>
			</header>
			</div>
			<!-- //header -->
			<!-- container -->
			<div id="pop_container">
			<article>
				<div class="pop_content_area">
				    <div  id="pop_content" >
				    	<table>
				    		<tr>
				    			<td style="vertical-align:middle;">
				    				비밀번호 : <input title="비밀번호" type = "password" id = "password" name = "password" onKeyDown="enterPassword()" class="pwdSize"/>
				    				<input type = "button" class = "btn_search" value = "확인" style="color: #ffffff;background-color: #5a6273; outline-style: dashed; outline-width: 2px;"  onclick="pwdCheck()">	<!-- 20230110 김동민 웹품질진단 -->
				    			</td>
				    		</tr>
				    	</table>
				    </div>
				</div>
			</article>
			</div>
			<!-- //container -->
		</div>
  </div>

<script>
// $(document).ready(function(){		//	웹 품질 진단 조치 - 2021.04.30
// 	var strTitleText = $("#txtTitle").text();
// 	$("#txtTitle").text(strTitleText + " 목록");
// });
</script>