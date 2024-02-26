<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
	$(document).ready(function(){
		$("#crqfc_no").focus();
	});

	function search() {
		
		var crqfc_no = $.trim($("#crqfc_no").val());
		var user_nm = $.trim($("#user_nm").val());
		
		//		2021.08.20 두 항목 입력하여야 하는 것으로 조건 수정
		if (crqfc_no == "") {			
			alert("조회할 손해평가사 자격증번호를 입력하세요.");
			$("#crqfc_no").val("");
			$("#crqfc_no").focus();
			return;
		} else if (user_nm == "") {			
			alert("조회할 손해평가사 성명을 입력하세요.");
			$("#user_nm").val("");
			$("#user_nm").focus();
			return;
		} else {
			if (crqfc_no.length > 0 && crqfc_no.length < 6) {
				alert("자격증번호 6자리를 입력하세요.")
				$("#crqfc_no").focus();
				return;
			} else {
				var frm = $("#searchForm");
				frm.action = "/front/agrInsClaAdj/selectAgrInsClaAdj.do";
				frm.submit();				
			}
		}		
	}
	
	function search2(){
		
		var crqfc_no = $.trim($("#crqfc_no").val());
		var user_nm = $.trim($("#user_nm").val());
		
		var allData = {"crqfc_no" : crqfc_no, "user_nm" : user_nm};
		
		$.ajax({
			type : 'GET',
			url : 'https://ais.apfs.kr/apfs/data/agrInsClaAdj.do?crqfc_no='+crqfc_no+'&user_nm='+user_nm+'&data_type=json',
			dataType : 'json',
			data : allData,
			success : function(data){
					console.log(data);
			},
			error : function(error) {
	        	alert("Error!");
	    	}
		});
		
	}
	

</script>
<div class="content_tit" id="containerContent">
	<h3>손해평가사 조회</h3>
</div>
<div class="content">
	
	<h4 class="title_h4">손해평가사 조회</h4>
	<div class="cont_search_area">
		<div class="cont_search_box">
			<form id="searchForm" name="searchForm" method="get">
				<input type="hidden" name="mode" value="search" />
				<div class="con_wrap">
					<dl>
						<dt class="w110px"><label for="crqfc_no">자격증번호</label></dt>
						<dd><input id="crqfc_no" type="text" name="crqfc_no" class="input_style01 w100per" maxlength="6" value="${info.licenseKey}"/></dd>
					</dl>
					<dl>
						<dt><label for="user_nm">성 명</label></dt>
						<dd><input id="user_nm" type="text" name="user_nm" class="input_style01 w100per" maxlength="20" value="${info.name}"/></dd>
					</dl>
					<button type="button" class="btn_search" title="조회" onclick="search();">조회</button>
				</div>
				<!-- <table class="table_style4">
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
								<label for="crqfc_no" class="hidden">자격증번호 입력</label>
								<input id="crqfc_no" type="text" name="crqfc_no" class="in_W70" maxlength="6" value="${info.licenseKey}"/>
							</td>
							<th scope="row">성 명</th>
							<td>
								<label for="user_nm" class="hidden">성명 입력</label>
								<input id="user_nm" type="text" name="user_nm" class="in_W70" maxlength="20" value="${info.name}"/>
							</td>
							<td>
								<button type="button" class="table_btn" title="조회" onclick="search()"><span>조회</span></button>
							</td>
						</tr>
					</tbody>
				</table> -->
			</form>
		</div>
	</div>
	
	<h4 class="title_h4">손해평가사 조회 결과</h4>
	<div class="table_auto_area table_wrap scroll">
		<table class="table_style_auto">
			<caption>손해평가사 조회 결과표로 자격증번호,성명,실무교육 이수여부,실무교육 이수일자,보수교육 이수여부,보수교육 이수일자 정보를 제공함.</caption>
			<colgroup>
				<col width="20%" />
				<col width="12%" />
				<col span="4" />
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
				<c:forEach items="${lossAssessor}" var="lossAssessor">
				<tr>
					<td>${lossAssessor.crqfc_no}</td>
					<td>${lossAssessor.user_nm}</td>
					<td>${lossAssessor.prcafs_edc_compl_at}</td>
					<td>${lossAssessor.prcafs_edc_compl_dt}</td>
					<td>${lossAssessor.mendng_edc_compl_at}</td>
					<td>${lossAssessor.mendng_edc_compl_dt}</td>
				</tr>
				</c:forEach>
				<c:if test="${empty lossAssessor}">
				<tr>
					<td colspan="6">조회 정보가 없습니다.</td>
				</tr>
				</c:if>
			</tbody>
		</table>
	</div>

</div>