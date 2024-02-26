<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var eventListPageUrl = "<c:url value='/front/event/eventList.do?menuId=${param.menuId}'/>";
var eventListPageUrl = "<c:url value='/front/event/eventList.do?menuId=${param.menuId}'/>";
var eventWriteUrl = "<c:url value='/front/event/eventWrite.do?menuId=${param.menuId}'/>";
var eventListYearUrl = "<c:url value='/front/event/eventListYPage.do?menuId=${param.menuId}'/>";
var eventListMonthUrl = "<c:url value='/front/event/eventListMPage.do?menuId=${param.menuId}'/>";
var eventViewUrl = "<c:url value='/front/event/eventView.do?menuId=${param.menuId}'/>";
// var eventCurrentFocus = document.getElementById($(this)).value;

$(document).ready(function(){
	if($("#mode").val()=='Y'){
		eventList();
	}else{
		eventMonth();
	}

	$("#skip_nav").focus();
});

// 검색
function search(){
	eventList();
}

//게시물 뷰
function eventView(eventid){
	var f = document.listFrm;
	/* if($('input [name="eventState'+eventId+'"]').val()!='s'){
		alert('접수중이 아닙니다.');
	} */
	$("#SCHD_IDX").val(eventid);
    f.target = "_self";
    f.action = eventViewUrl;
    f.submit();
}

//초기화
function formReset(){
	$("#reply_ststus").val("");
	$("#cate_id").val("");
	$("#searchkey").val("T");
	$("#searchtxt").val("");
}


//게시판 리스트 불러오기
function eventList(){			//	연간 클릭
	$("#mode").val('Y');	
	//$("#mode").val(encodeURI($("#mode").val()));
	//$("#mode").val(encodeURI(eval($("#mode")).val()));

	$.ajax({
        url: eventListYearUrl,
        dataType: "html",
        type: "post",
        data: jQuery("#listFrm").serialize(),
        success: function(data) {
        	$(".contents_detail").html(data);
        	$("#schedule_y").attr("title", "선택됨");
//         	if(num == "01"){
//         		num = "s1";
//         	}else if(num == "02"){
//         		num = "s2";
//         	}else if(num == "03"){
//         		num = "s3";
//         	}else if(num == "04"){
//         		num = "s4";
//         	}else if(num == "05"){
//         		num = "s5";
//         	}else if(num == "06"){
//         		num = "s6";
//         	}
        	
//         	alert(eventCurrentFocus);
//         	$(".tab_menu ul li #s2").focus();
        	$(".tab_style3 ul li #schedule_y").focus();		//2024 웹 접근성
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

//게시판 리스트 불러오기
function eventMonth(){		//	월간 클릭
	$("#mode").val('M');
	//$("#mode").val(encodeURI(eval($("#mode")).val()));
	
	$.ajax({
        url: eventListMonthUrl,
        dataType: "html",
        type: "post",
        data: jQuery("#listFrm").serialize(),
        success: function(data) {
        	$(".contents_detail").html(data);
        	$("#schedule_m").attr("title", "선택됨");
//         	if(num == "01"){
//         		num = "s1";
//         	}else if(num == "02"){
//         		num = "s2";
//         	}else if(num == "03"){
//         		num = "s3";
//         	}else if(num == "04"){
//         		num = "s4";
//         	}else if(num == "05"){
//         		num = "s5";
//         	}else if(num == "06"){
//         		num = "s6";
//         	}
//         	alert(eventCurrentFocus);
//         	$(".tab_menu ul li #s2").focus();
//         	$('#'+num).focus();//eventCurrentFocus.focus();
        	$(".tab_style3 ul li #schedule_m").focus();		//2024 웹 접근성
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

function eventSearch(num){
// 	eventCurrentFocus = num;
	$("#SCHD_CLASS").val(num);
	if($("#mode").val()=='Y'){
		eventList();
// 		$(".tab_menu ul li a.active").focus();	//2024 웹 접근성
//         $(".tab_style3 ul li #schedule_y").focus();		//2024 웹 접근성
	}else{
		eventMonth();
// 		$(".tab_menu ul li a.active").focus();	//2024 웹 접근성
//         $(".tab_style3 ul li #schedule_m").focus();		//2024 웹 접근성
	}
}

function yearMove(num){
	$("#SEARCH_YEAR").val(num);
	eventList();
}

function monMove(num){
	var nm = $("#mvM").val();
	nm = (nm*1) + (num*1);
	$("#mvM").val(nm);
	eventMonth();
}

</script>

<!-- search_area -->
<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="mode" name='mode' value="${param.mode eq '' or param.mode eq null?'Y':param.mode}" />
	<input type='hidden' id="state" name='state' value="" />
	<input type='hidden' id="SCHD_CLASS" name='SCHD_CLASS' value="${param.SCHD_CLASS eq '' or param.SCHD_CLASS eq null?'01':param.SCHD_CLASS}" />
	<input type='hidden' id="SCHD_IDX" name='SCHD_IDX' value="" />
	<input type='hidden' id="SEARCH_YEAR" name='SEARCH_YEAR' value="${SEARCHYEAR}" />
	<input type='hidden' id="SEARCH_MONTH" name='SEARCH_MONTH' value="${param.SEARCH_MONTH}" />
	<input type='hidden' id="mvM" name="mvM" value="${param.mvM eq '' or param.mvM eq null?'0':param.mvM}" />
	<input type='hidden' id="SEARCHDATE" name='SEARCHDATE' value="2017" />

<!-- contentsList -->
<div id="contentsList">
	<div class="content_tit" id="containerContent">
       <h3>교육</h3>
    </div>
	<div class="contents_detail">	</div>
</div>
<!-- //contentsList -->

</form>