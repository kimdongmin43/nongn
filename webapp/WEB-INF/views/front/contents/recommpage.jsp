<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>

	.incoTitle {color:#b99042; font-size:14px; font-weight:600;}
	.incoContents {padding-bottom:15px;}
	.moreBt {text-align:center; padding:10px;border:1px solid #dedede; background-color:#eeeee;}
</style>
<script>
var PageUrl = "<c:url value='/front/contents/recommPage.do'/>";
var titles = ['','','경제단체', '금융기관','교육기관','언론기관','연구기관','','정부기관','지방자치단체',''];
function type_list(str){
	// 타입별 리스트 리동
	var f = document.listFrm;

    f.target = "_self";
    f.cate1.value = str;
    f.action = PageUrl;
    f.submit();
}
$(function (){
	var cate1 = '${param.cate1}';
	cate1 *= 1;
	$('#recomm_title').html(titles[cate1]);
});
</script>
<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="menuId" name='menuId' value="${param.menuId }" />
	<input type='hidden' id="boardId" name='boardId' value="${param.boardId }" />
	<input type='hidden' id="cate1" name='cate1' value="" />
		<div class="contents_title">
			<h2>유관기관</h2>
		</div>
		<div class="contents_detail" >
			<section class="recmdsite_search">
				<ul class="recmdsite_search_list">
					<li><a href="javascript:type_list('08')"  class="curr" ><span>정부기관</span></a></li>
					<li><a href="javascript:type_list('09')" ><span>지방자치단체</span></a></li>
					<li><a href="javascript:type_list('06')"	><span>연구기관</span></a></li>
					<li><a href="javascript:type_list('05')"	><span>언론기관</span></a></li>
					<li><a href="javascript:type_list('03')"	><span>금융기관</span></a></li>
					<li><a href="javascript:type_list('04')"	><span>교육기관</span></a></li>
					<li><a href="javascript:type_list('02')"	><span>경제단체</span></a></li>
				</ul>
			</section>
			<!-- site_title_area -->
			<h3 id="recomm_title">정부기관</h3>
			<!--// site_title_area -->
			<c:set var="tempCate" value="0" />
			<c:forEach var="list" items="${recommlist}" varStatus="i">
			<c:if test="${tempCate ne list.cate}">
				<c:if test="${tempCate ne '0'}"></ul></c:if>
			<h4 class="marb8">${list.cate}</h4>
			<ul class="recmdsite_list">
			<!--
				기본 : <ul class="recmdsite_list">
				하위메뉴 있을시 : <ul class="recmdsite_list floatnone">
			 -->
			</c:if>
					<li>

						<c:if test="${fn:indexOf(list.homepage,'http') != -1}">
						<span class="recmdTitle"><a href="${list.homepage}" target="_blank">${list.name}</a></span>
						</c:if>
						<c:if test="${fn:indexOf(list.homepage,'http') == -1}">
						<span class="recmdTitle"><a href="http://${list.homepage}" target="_blank">${list.name}</a></span>
						</c:if>
					</li>
			<c:set var="tempCate" value="${list.cate}"/>
			</c:forEach>
		</div>
				<!-- <ul>
							<li>
								<span><a href="#none" target="_blank">TESTTESTTESTTESTTESTTESTTESTTEST</a></span>
							</li>
							<li>
								<span><a href="#none" target="_blank">TEST</a></span>
							</li>
							<li>
								<span><a href="#none" target="_blank">TEST</a></span>
							</li>
							<li>
								<span><a href="#none" target="_blank">TEST</a></span>
							</li>
						</ul> -->
</form>