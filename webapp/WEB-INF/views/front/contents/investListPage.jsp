<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var investListPageUrl = "<c:url value='/front/invest/investListPage.do'/>";
var investListUrl = "<c:url value='/front/invest/investGridData.do'/>";

$(document).ready(function(){
	if("${param.miv_pageNo}" != null ){
		go_Page("${param.miv_pageNo}");
	}else{
		search();
	}

	$("#skip_nav").focus();		//	키보드 이동을 위해 포커스 - 2020.10.19
});

// 검색
function search(){
	boardLiat();
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
	search();
}


//게시판 리스트 불러오기
function boardLiat(){
	$.ajax({
        url: investListUrl,
        dataType: "html",
        type:"post",
        data: jQuery("#listFrm").serialize(),
        success: function(data) {
        	$(".contents_detail").html(data);
        	$("#standard").html('${standardDateParam.codeNm}');
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

function searchTab(num){
	$("#miv_pageNo").val(1);
	if(num==0){num='';}
	if(num==4){num=9;}
	if(num>3){num--;}
	$("#selTab").val(num);
	search();
}
function searchAll(){
	type_list(0);
	$("#miv_pageNo").val(1);
	$("#selTab").val('');
	search();
}



</script>

<!-- search_area -->
<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="mode" name='mode' value="W" />
	<input type='hidden' id="contId" name='contId' value="" />
	<input type='hidden' id="delYn" name='delYn' value="N" />
	<input type='hidden' id="menuId" name='menuId' value="${param.menuId }" />
	<input type='hidden' id="boardId" name='boardId' value="${param.boardId }" />
	<input type='hidden' id="selTab" name='selTab' value="${param.t }" />


<!--// search_area -->

<!-- contentsList -->
<div id="location_area">
	<div class="content_tit" id="containerContent">
        <h3>농림수산식품투자조합</h3>
    </div>
    <div class="content">
		<!-- tab_style -->
		<div class="tab_style2">
			<ul>
				<li class="w3"><a class="active" href="/front/invest/investListPage.do?contId=45&amp;menuId=5321" title="선택됨" tabindex="0">농림수산식품투자조합 결성현황</a></li>
				<li class="w3"><a href="/front/contents/sub.do?contId=45&menuId=5321&t=20">투자대상</a></li>
				<li class="w3"><a href="/front/contents/sub.do?contId=45&menuId=5321&t=30">투자절차</a></li>
				<li class="w3"><a href="/front/contents/sub.do?contId=45&menuId=5321&t=40">투자와 융자의 차이</a></li>
				<li class="w3"><a href="/front/contents/sub.do?contId=45&menuId=5321&t=50">투자 전·후 지원</a></li>
				<li class="w3"><a href="/front/contents/sub.do?contId=45&menuId=5321&t=60">투자경영체 확인서 발급</a></li>
			</ul>
		</div>
		<!-- //tab_style -->

		<div class="contents_detail">	</div>
	</div>
</div>
<!-- //contentsList -->

</form>