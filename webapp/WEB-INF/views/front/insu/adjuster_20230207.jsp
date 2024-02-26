<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%
//	2021.08.20 검색항목 입력 후 false 값 받으면 자격증번호, 성명 중 1개가 미입력
/*String success = (String) request.getAttribute("success");
if (success.equals("false")) {
	out.println("<script>alert('자격증번호, 성명 항목 모두 입력되어야 합니다');</script>");	
}*/
%> 
<script>

	$(document).ready(function(){
		$("#licenseKey").focus();
	});

	function search() {
		
		var licenseKey = $.trim($("#licenseKey").val());
		var name = $.trim($("#name").val());
		
		//		2021.08.20 두 항목 입력하여야 하는 것으로 조건 수정
		if (licenseKey == "") {			
			alert("조회할 손해평가사 자격증번호를 입력하세요.");
			$("#licenseKey").val("");
			$("#licenseKey").focus();
			return;
		} else if (name == "") {			
			alert("조회할 손해평가사 성명을 입력하세요.");
			$("#name").val("");
			$("#name").focus();
			return;
		} else {			if(licenseKey.length > 0 && licenseKey.length < 6) {
				alert("자격증번호 6자리를 입력하세요.")
				$("#licenseKey").focus();
				return;
			} else {
				var frm = $("#searchForm");
				frm.action = "/front/agrInsClaAdj/selectAgrInsClaAdj.do";
				frm.submit();				
			}
		}		
	}

</script>
<div class="content_tit">
	<h3>손해평가사 조회</h3>
</div>
<div class="content" id="containerContent">
	<h5 class="title_h5">손해평가사 조회</h5>
	<div class="table_area bm20">
		<form id="searchForm" name="searchForm" method="post">
			<input type="hidden" name="mode" value="search" />
		<table class="table_style4">
			<caption>손해평가사 조회 양식표로 자격증번호,성명을 입력하여 조회할 수 있음.</caption>
			<colgroup>
				<col style="width:20%"/>
				<col style="width:20%"/>
				<col style="width:20%"/>
				<col style="width:20%"/>
				<col style="width:20%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">자격증번호</th>
					<td>
						<label for="licenseKey" class="hidden">자격증번호 입력</label>
						<input id="licenseKey" type="text" name="licenseKey" class="in_W70" maxlength="6" value="${info.licenseKey}"/>
					</td>
					<th scope="row">성 명</th>
					<td>
						<label for="name" class="hidden">성명 입력</label>
						<input id="name" type="text" name="name" class="in_W70" maxlength="20" value="${info.name}"/>						
					</td>
					<td>
						<button type="button" class="table_btn" title="조회" onclick="search()"><span>조회</span></button>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
	</div>
	
	<div style="padding-top: 20px;"></div>
	<h5 class="title_h5">손해평가사 조회 결과</h5>
	<div class="table_area mb20">
		<table class="table_style">
			<caption>손해평가사 조회 결과표로 자격증번호,성명,실무교육 이수여부,실무교육 이수일자,보수교육 이수여부,보수교육 이수일자 정보를 제공함.</caption>
			<colgroup>
				<col style="width:25%;"/>
				<col style="width:15%"/>
				<col style="width:15%"/>
				<col style="width:15%"/>
				<col style="width:15%"/>
				<col style="width:15%"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">자격증번호</th>
					<th scope="col">성 명</th>
					<th scope="col">실무교육 이수여부</th>
					<th scope="col">실무교육 이수일자</th>
					<th scope="col">보수교육 이수여부</th>
					<th scope="col">보수교육 이수일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="list">
				<tr>
					<td>${list.licenseKey}</td>
					<td>${list.name}</td>
					<td>${list.edcComplAt}</td>
					<td>${list.edcComplDt}</td>
					<td>${list.edcComplAt2}</td>
					<td>${list.edcComplDt2}</td>
				</tr>
				</c:forEach>
				<c:if test="${empty resultList}">
				<tr>
					<td colspan="6">조회 정보가 없습니다.</td>
				</tr>
				</c:if>
			</tbody>
		</table>
	</div>

</div>