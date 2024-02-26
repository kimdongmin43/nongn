<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var searchContentsUrl = "<c:url value='/front/main/searchContents.do'/>";
var searchListUrl = "<c:url value='/front/main/searchList.do'/>";

var param_total_searchTxt = "${total_searchTxt}"; // 수정 (2018.06.05)

var boolMore = false;			<%	//	"더보기" 버튼 클릭 시 포커스 이동을 위한 추가 변수 - 웹 접근성 재인증 추가 작업 2022.02.08    %>
var boolMore2 = false;

$(document).ready(function(){
	if(param_total_searchTxt != ""){ 			// 수정 (2018.06.05)
		setTimeout("search()",200);
	}
	$("#txtTitle").text("농업정책보험금융원 > 검색결과");

	$('body').keydown(function(event){			<%	//	"더보기" 버튼 클릭 시 포커스 이동을 위한 이벤트 처리 영역 - 웹 접근성 재인증 추가 작업 2022.02.08    %>
		var tmpKeyCode = event.keyCode;
		var tmpObjId = $(event.target).attr('id');
		if (tmpKeyCode == 13) {
			if (tmpObjId == "more") {
				boolMore = true;
			} else if (tmpObjId == "more2") {
				boolMore2 = true;
			}
		}
	});	

});

// 검색
function search(strAll){
	var searchTxtStr = $('#searchTxt').val();
	
	searchTxtStr = searchTxtStr.replace(/\</g, "& lt;");
	searchTxtStr = searchTxtStr.replace(/\>/g, "& gt;");
	searchTxtStr = searchTxtStr.replace("script", "");
	searchTxtStr = searchTxtStr.replace("/script", "");
    searchTxtStr = searchTxtStr.replace("iframe", "");
	searchTxtStr = searchTxtStr.replace("'", "& quot;");
	searchTxtStr = searchTxtStr.replace("\"", "& #39;");
	searchTxtStr = searchTxtStr.replace("eval\\((.*)\\)", "");
	searchTxtStr = searchTxtStr.replace("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
	
	$('#searchTxt').val(searchTxtStr);
	
	boardLiat(strAll);
}

//엔터검색
function enter(){

    if(event.keyCode == 13)
    {
    	search();
    }
}


// 페이지 이동
function go_Page(page){
	$("#miv_pageNo").val(page);
}


//게시판 리스트 불러오기
function boardLiat(strAll){
	$('.keyword').html($('#searchTxt').val());
	type_list($('#searchMenu').val()*1);
	$('#miv_pageSize').val(3);
	if (strAll == 'A')  $('#miv_pageNo').val(1);
	var ok = 0;
	
	$.ajax({
        url: searchContentsUrl,
        dataType: "html",
        type:"post",
        data: jQuery("#listFrm").serialize(),
        success: function(data) {
        	$(".contents_detail").html(data);
        	$('.search_result').css('display','');
    		CC = $('#Ccnt').html()*1;
    		$('#totalCnt').html(CC);
//    		$('#searchTxt').val(data.searchTxt);		//	받는 값이 존재하지 않으므로 주석 처리   		
    		    		
        	ok++;
        	if(ok>1)	{
        		LC = $('#Lcnt').html()*1;
        		$('#totalCnt').html(LC+CC);
        	}

        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
	$.ajax({
        url: searchListUrl,
        dataType: "html",
        type:"post",
        data: jQuery("#listFrm").serialize(),
        success: function(data) {
        	$(".contents_detail2").html(data);
        	$('.search_result').css('display','');
        	LC = $('#Lcnt').html()*1;
        	$('#totalCnt').html(LC);
        	ok++;
        	if(ok>1)	{
        		CC = $('#Ccnt').html()*1;
        		$('#totalCnt').html(LC+CC);
        	}
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

function searchC(strAll){
	$(".contents_detail").html($('#loading').html());
	if (strAll == 'A')  $('#miv_pageNo').val(1);

	$.ajax({
        url: searchContentsUrl,
        dataType: "html",
        type:"post",
        data: jQuery("#listFrm").serialize(),
        success: function(data) {
			data = data.replace("<li>", "<li id='srch1'>");

        	$(".contents_detail").html(data);
        	$('#Cpage').css('display','');
        	$('#more').css('display','none');
        	$('.contents_detail .paging_area a').click(function (){
    			setTimeout("searchC()",200);
    		});

        	//	검색결과가 있는 경우 첫 번째 아이템에 포커스를 옮긴다
			 var obj = $("#srch1 a").first();
			 obj.focus();
        	 if (!boolMore) {
				/* obj.parent().css({"border" : "2px solid black", "margin" : "5px", "padding" : "2px", "border-radius" : "4px / 4px"});
				 obj.blur(function() { obj.parent().css({"border" : "", "margin" : "", "padding" : "", "border-radius" : ""}); });*/
        	 }
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}
function searchL(strAll){
	$(".contents_detail2").html($('#loading').html());
	if (strAll == 'A')  $('#miv_pageNo').val(1);
	$.ajax({
        url: searchListUrl,
        dataType: "html",
        type:"post",
        data: jQuery("#listFrm").serialize(),
        success: function(data) {
			data = data.replace("<li>", "<li id='srch2'>");

        	$(".contents_detail2").html(data);
        	$('#Lpage').css('display','');
        	$('#more2').css('display','none');
        	$('.contents_detail2 .paging_area a').click(function (){
        		setTimeout("searchL()",200);
    		});

        	//	검색결과가 있는 경우 첫 번째 아이템에 포커스를 옮긴다
			 var obj = $("#srch2 a").first();
			 obj.focus();
        	 if (!boolMore2) {
				/* obj.parent().css({"border" : "2px solid black", "margin" : "5px", "padding" : "2px", "border-radius" : "4px / 4px"});
				 obj.blur(function() { obj.parent().css({"border" : "", "margin" : "", "padding" : "", "border-radius" : ""}); });*/
        	 }
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}


function searchTab(num){
	$("#miv_pageNo").val(1);
	
	//	클릭한 탭과 콤보박스(id="searchMenu") 연동하기
	var cntSelect = $("#searchMenu option").size();
	for (var  i = 0; i < cntSelect; i++) {
		strSelectNm = "#searchMenu option:eq(" + i + ")"; 
		if (i == num) {
			$(strSelectNm).prop("selected", true);
		} else {
			$(strSelectNm).prop("selected", false);
		}	
	}	

	makeTabString(num);
	
	if(num==0){num='';}
	$("#selTab").val(num);
	if($('#searchTxt').val()){     search();      }
}
function searchAll(str){
	$('#miv_pageSize').val(15);
	if(str=='L'){
		searchL('A');
	}else{
		searchC('A');
	}
}

function  changeKey(obj){
	var kc = $('#searchCon').prop('checked');
	var kt = $('#searchTit').prop('checked');
	if(kc && kt){
		$('#searchKey').val('A');
	}else if(kc){
		$('#searchKey').val('C');
	}else if(kt){
		$('#searchKey').val('T');
	}else{
		$('#search'+obj).prop('checked',true);
		changeKey();
	}
}

function  changeDt(obj){
	var nowDate =+ new Date();
	var srchEDate;
	
	var dtA = $('#selA').prop('checked');
	var dtB = $('#selB').prop('checked');
	var dtC = $('#selC').prop('checked');
	if(dtB&&obj=='B'){
		$('#selA').prop('checked',false);
		$('#selC').prop('checked',false);
		$('#searchDt').val('B');
		srchEDate = new Date(nowDate - (365 * 24 * 60 * 60 * 1000));
		$("#searchSdt").val(get_date_str(srchEDate));
		$("#searchEdt").val(get_date_str(new Date(nowDate)));
		return;
	}

	if(dtC&&obj=='C'){
		$('#selA').prop('checked',false);
		$('#selB').prop('checked',false);
		$('#searchDt').val('C');
		srchEDate = new Date(nowDate - (182 * 24 * 60 * 60 * 1000));
		$("#searchSdt").val(get_date_str(srchEDate));
		$("#searchEdt").val(get_date_str(new Date(nowDate)));
		return;
	}

	if(dtA&&obj=='A'){
		$('#selB').prop('checked',false);
		$('#selC').prop('checked',false);
		$('#searchDt').val('A');
		$("#searchSdt").val("");
		$("#searchEdt").val("");
		return;
	}
}

function get_date_str(date)
{
    var sYear = date.getFullYear();
    var sMonth = date.getMonth() + 1;
    var sDate = date.getDate();

    sMonth = sMonth > 9 ? sMonth : "0" + sMonth;
    sDate  = sDate > 9 ? sDate : "0" + sDate;
    return "" + sYear + sMonth + sDate;
}

//	검색결과 선택된 탭 정보 제공(웹 접근성) - 2022.02.03
function makeTabString(num) {
	var hiddenString = "";
	$("#strTabString").text("");
	switch (num) {
		case 1 :
			hiddenString = "정보공개 메뉴 중  검색결과";
			break;
		case 2 :
			hiddenString = "주요업무 메뉴 중  검색결과";
			break;
		case 3 :
			hiddenString = "자료실 메뉴 중  검색결과";
			break;
		case 4 :
			hiddenString = "알림마당 메뉴 중  검색결과";
			break;
		case 5 :
			hiddenString = "고객참여 메뉴 중  검색결과";
			break;
		case 6 :
			hiddenString = "농금원 소개 메뉴 중  검색결과";
			break;
		default :
			hiddenString = "전체 메뉴 검색결과";
	}
	$("#strTabString").text(hiddenString);
}
</script>

<!-- search_area -->
<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /><%//	현재 페이지 번호 %>
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="3" />
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="selTab" name='selTab' value="" />
	<input type='hidden' id="searchKey" name='searchKey' value="A" />
	<input type='hidden' id="searchDt" name='searchDt' value="A" />
	<input type='hidden' id="searchSdt" name='searchSdt' value="" />
	<input type='hidden' id="searchEdt" name='searchEdt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
<!--// search_area -->

<!-- contentsList -->
<div class="total_search_area" id="containerContent">	<!-- 2024 웹 접근성 -->
	<div class="total_search_detail">
		<fieldset>
           	<legend>통합검색조건</legend>
				<ul>
					<li>
						<span class="title">검색범위</span>
						<div class="con">
							<input type="checkbox" name="searchTit" id="searchTit" checked="checked" onchange="changeKey('Con')">
							<label for="searchTit">제목</label>
						</div>
						<div class="con">						
							<input type="checkbox" name="searchCon" id="searchCon" checked="checked" onchange="changeKey('Tit')">
							<label for="searchCon">내용</label>
						</div>
					</li>
					<li>
						<span class="title">검색기간</span>
						<div class="con">
							<input type="checkbox" name="selA" id="selA" checked="checked" onchange="changeDt('A')">
							<label for="selA">전체</label>
						</div>
						<div class="con">
							<input type="checkbox" name="selB" id="selB" onchange="changeDt('B')">
							<label for="selB">최근 1년간</label>
						</div>
						<div class="con">
							<input type="checkbox" name="selC" id="selC" onchange="changeDt('C')">
							<label for="selC">최근 6개월간</label>
						</div>
						<!-- <input id="selSdt" name="sdt" type="text" class="in_wp90" title="날짜를 선택하세요">
						<img src="/images/common/icon_bg_month.png" alt="달력보기">
						~
						<input id="selEdt" name="edt" type="text" class="in_wp90" title="날짜를 선택하세요">
						<img src="/images/common/icon_bg_month.png" alt="달력보기"> -->
					</li>
					<li>
						<div class="table_search_wrap">
							<select name="searchMenu" id="searchMenu" title="검색옵션" class="three_member70 select_style">
								<option value="">전체</option>
								<option value="0001">정보공개</option>
								<option value="0002">주요업무</option>
								<option value="0003">자료실</option>
								<option value="0004">알림마당</option>
								<option value="0005">고객참여</option>
								<option value="0006">농금원 소개</option>
							</select>
							<div class="search_input">
								<label for="searchTxt" class="hidden">검색내용</label>
								<input id="searchTxt" name="searchTxt" type="text" class="txt" style="ime-mode:active;" value="${total_searchTxt}" />
							</div>
							<button class="btn_search" title="검색하기" onclick="search('A')">검색</button>
						</div>
					</li>
               </ul>
       	</fieldset>
    </div>
	
	<div class="tab_style">
	    <ul>
	    	<li class="w7" onclick="searchTab(0);" id="tab0"><a href="#none" class="active">전체</a></li>
	        <li class="w7" onclick="searchTab(1);" id="tab1"><a href="#none">정보공개</a></li>
	        <li class="w7" onclick="searchTab(2);" id="tab2"><a href="#none">주요업무</a></li>
	        <li class="w7" onclick="searchTab(3);" id="tab3"><a href="#none">자료실</a></li>
	        <li class="w7" onclick="searchTab(4);" id="tab4"><a href="#none">알림마당</a></li>
	        <li class="w7" onclick="searchTab(5);" id="tab5"><a href="#none">고객참여</a></li>
	        <li class="w7" onclick="searchTab(6);" id="tab6"><a href="#none">농금원 소개</a></li>
	    </ul>
	</div>
	
	<div class="search_result" style="display:none;">
		<h4 class="hidden" id="strTabString">전체 메뉴 검색결과</h4>
       	<span class="keyword">"${param.searchTxt}"</span>에 대한 검색 결과는 총 <b><span id="totalCnt">0</span>건</b>이 검색되었습니다.
    </div>
	
	<div class="contents_detail"><br /><br /><div style="text-align: center;width:100%;" ><img src="/images/loader.gif" alt="로딩중"/> </div><br /><br /></div>
	<div class="contents_detail2"><br /><br /><div style="text-align: center;width:100%;" ><img src="/images/loader.gif" alt="로딩중"/> </div><br /><br /></div>
	<div id="loading" style="display:none;"><br /><br /><div style="text-align: center;width:100%;" ><img src="/images/loader.gif" alt="로딩중"/> </div><br /><br /></div>
</div>
<!-- //contentsList -->

</form>
