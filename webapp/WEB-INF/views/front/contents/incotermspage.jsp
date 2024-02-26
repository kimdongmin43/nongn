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
function searchCategory(str){
	$('.incoterms > li').hide();
	$('.'+str).show();
	$('#searchText').val('');
}

//엔터검색
function enter(){

    if(event.keyCode == 13)
    {
    	searchWord();
    }
}

function searchWord(){
	var str = $('#searchText').val();
	$('.incoterms > li').hide();
	$('.incoterms > li').filter(":contains("+str+")").show();
}

function more(){
	$('.incoterms > li').show();
	$('.moreBt').css('display','none');
}
</script>
		<div class="contents_title">
			<h2>무역 용어 사전</h2>
		</div>
		<div class="contents_detail" >
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr><td style="padding-bottom:10px; text-align:center;"><a href="javascript:searchCategory('A');">[A]</a>&nbsp;<a href="javascript:searchCategory('B');">[B]</a>&nbsp;<a href="javascript:searchCategory('C');">[C]</a>&nbsp;<a href="javascript:searchCategory('D');">[D]</a>&nbsp;<a href="javascript:searchCategory('E');">[E]</a>&nbsp;<a href="javascript:searchCategory('F');">[F]</a>&nbsp;<a href="javascript:searchCategory('G');">[G]</a>&nbsp;<a href="javascript:searchCategory('H');">[H]</a>&nbsp;<a href="javascript:searchCategory('I');">[I]</a>&nbsp;<a href="javascript:searchCategory('J');">[J]</a>&nbsp;<a href="javascript:searchCategory('K');">[K]</a>&nbsp;<a href="javascript:searchCategory('L');">[L]</a>&nbsp;<a href="javascript:searchCategory('M');">[M]</a>&nbsp;<a href="javascript:searchCategory('N');">[N]</a>&nbsp;<a href="javascript:searchCategory('O');">[O]</a>&nbsp;<a href="javascript:searchCategory('P');">[P]</a>&nbsp;<a href="javascript:searchCategory('Q');">[Q]</a>&nbsp;<a href="javascript:searchCategory('R');">[R]</a>&nbsp;<a href="javascript:searchCategory('S');">[S]</a>&nbsp;<a href="javascript:searchCategory('T');">[T]</a>&nbsp;<a href="javascript:searchCategory('U');">[U]</a>&nbsp;<a href="javascript:searchCategory('V');">[V]</a>&nbsp;<a href="javascript:searchCategory('W');">[W]</a>&nbsp;<a href="javascript:searchCategory('X');">[X]</a>&nbsp;<a href="javascript:searchCategory('Y');">[Y]</a>&nbsp;<a href="javascript:searchCategory('Z');">[Z]</a>&nbsp;</td></tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" summary="용어검색">
						<tr>
							<td style="width:13%; background:#a5a5a5; text-align:center; font-weight:bold; color:#fff;">용어사전</td>
							<td style=" text-align:center; background:#eeeeee; border-top: 1px solid #d6d6d6;border-bottom: 1px solid #d6d6d6; padding:5px;">
								<input type="text" id="searchText" name="searchText" class="input01" style="width:500px; line-height:20px;padding-left:3px;" onKeyDown="enter();"   />
								<button onclick="javascript:searchWord();">검색</button>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="left" style="padding:10px 0 15px 0;" class="comment">※ 검색은 [대소문자]를 구분합니다. </td>
				</tr>
			</table>
			<ul class="incoterms">
				<c:forEach var="list" items="${incolist}" varStatus="i">
					<li class="${list.g010Category}" ${hideClass}>
						<div class="incoTitle">${list.title}</div>
						<div class="incoContents">${list.contents}</div>
					</li>
					<c:if test="${i.index eq 20}">
						<c:set var="hideClass" value="style='display:none'" />
					</c:if>
				</c:forEach>
				<li class="moreBt" onclick="more();">
					더보기
				</li>
			</ul>
		</div>
