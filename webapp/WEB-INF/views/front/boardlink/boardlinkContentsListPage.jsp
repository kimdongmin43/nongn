<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var boardlinkContentsListPageUrl = "<c:url value='/front/boardlink/boardlinkContentsListPage.do'/>";
var boardlinkContentsWriteUrl = "<c:url value='/front/boardlink/boardlinkContentsWrite.do'/>";
var boardlinkContentsListUrl = "<c:url value='/front/boardlink/boardlinkContentsList.do'/>";

var boardlinkNewsListUrl = "<c:url value='/front/board/boardNewsList.do'/>";
var boardlinkContentsViewUrl = "<c:url value='/front/boardlink/boardlinkContentsView.do?menuId=${param.menuId}'/>";
var boardlinkSeminaViewUrl = "<c:url value='/front/boardlink/boardlinkSeminaView.do?menuId=${param.menuId}'/>";
var boardlinkBookViewUrl =  "<c:url value='/front/boardlink/boardlinkBookView.do?menuId=${param.menuId}'/>";
var boardlinkNewsViewUrl =  "<c:url value='/front/board/boardNewsView.do?menuId=${param.menuId}'/>";

$(document).ready(function(){
	if("${param.miv_pageNo}" != null ){
		go_Page("${param.miv_pageNo}");
	}else{
		search();
	}

});

// 검색
function search(){
	boardlinkLiat();
}

//엔터검색
function enter(){

    if(event.keyCode == 13)
    {
    	search();
    }
}



//게시물 등록
function contentsWrite(){

	// 회원 비회원 확인후 등록페이지 이동

	var f = document.listFrm;

    f.target = "_self";
    f.action = boardlinkContentsWriteUrl;
    f.submit();
}

//게시물 뷰
function contentsView(contentsid){
	var f = document.listFrm;

	$("#contId").val(contentsid);

    f.target = "_self";
    f.action = boardlinkContentsViewUrl;
    f.submit();
}

//게시물 뷰
function seminaView(contentsid){
	var f = document.listFrm;

	$("#contId").val(contentsid);

    f.target = "_self";
    f.action = boardlinkSeminaViewUrl;
    f.submit();
}

//게시물 뷰
function bookView(contentsid){
	var f = document.listFrm;

	$("#contId").val(contentsid);

    f.target = "_self";
    f.action = boardlinkBookViewUrl;
    f.submit();
}


//게시물 뷰
function newsView(contentsid){
	var f = document.listFrm;

	$("#contId").val(contentsid);

  f.target = "_self";
  f.action = boardlinkNewsViewUrl;
  f.submit();
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
function boardlinkLiat(){
	url2 = boardlinkContentsListUrl;
	if(${param.boardId}==18){
		if($("#miv_pageSize").val() == '')
			$("#miv_pageSize").val("10");
	}

	if(${param.boardId}==12){
		var dd = new Date();
		dat1 = new Date(Date.parse(dd) - 3 * 1000 * 60 * 60 * 24);

		$("#searchSt").val( dat1.getFullYear() + Right("0"+(dat1.getMonth()+1),2) +  Right("0"+dat1.getDate(),2));
		$("#searchDt").val(dd.getFullYear() + Right("0"+(dd.getMonth()+1),2) +  Right("0"+dd.getDate(),2));
		url2 = boardlinkNewsListUrl;
	}

	$("#s_searchkey").val($("#searchKey").val());
	$("#s_searchtxt").val($("#searchTxt").val());
	$.ajax({
        url: url2,
        dataType: "html",
        type: "post",
        data: jQuery("#listFrm").serialize(),
        success: function(data) {
        	$(".contents_detail").html(data);
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}


function Right(str, n){
	  if (n <= 0)
	     return "";
	  else if (n > String(str).length)
	     return str;
	  else {
	     var iLen = String(str).length;
	     return String(str).substring(iLen, iLen - n);
	  }
	}
</script>

<!-- search_area -->
<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="linkKind" name='linkKind' value="W" />
	<input type='hidden' id="mode" name='mode' value="W" />
	<input type='hidden' id="contId" name='contId' value="" />
	<input type='hidden' id="boardId" name='boardId' value="${param.boardId }" />

	<input type='hidden' id="searchSt" name='searchSt' value="" />
	<input type='hidden' id="searchDt" name='searchDt' value="" />

<!--// search_area -->

<!-- contentsList -->
<div id="contentsList">
	<div class="contents_title">
		<h2 >${MENU.menuNm}</h2><!--tabindex="0"-->
	</div>
	<div class="contents_detail">	</div>
</div>
<!-- //contentsList -->

</form>