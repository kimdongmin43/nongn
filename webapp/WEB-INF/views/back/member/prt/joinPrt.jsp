<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ page import="java.util.*, java.text.*"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="/assets/jquery/jquery-1.9.1.min.js"></script>
<script>
$(document).ready(function(){

var today = "";
var year = "";
var month = "";
var day = "";

var dbdate = '${memberInfo.regDt}';
today = new Date(dbdate);
year = today.getFullYear();
month = today.getMonth()+1;
day = today.getDate();
month = '0'+month;
month = month.substring(month.length-2);

$("#year").html(year);
$("#month").html(month);
$("#day").html(day);



});
</script>
<!DOCTYPE html>
<html lang="ko" xml:lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<title>신청서</title>
		<link rel="stylesheet" type="text/css" href="/css/back/form.css" />
		<link rel="stylesheet" type="text/css" href="/css/back/table.css" />
		<link rel="stylesheet" type="text/css" href="/css/back/default.css" />
		<link rel="stylesheet" type="text/css" href="/css/back/nanumgothic.css" />
		<!--[if lt IE 9]>
			<script src="../../js/html5.js"></script>
		<![endif]-->
	</head>
	<body>
	<div id="wrap">
		<!-- popup_content -->
		<!-- header -->

		<!-- //header -->
		<!-- container -->
		<div id="form_container">
		<article>
			<div class="form_content_area">
				<!-- division -->
				<div id="form_content">
					<!-- print_area -->
					<div class="print_area">
						<div class="form_title_area">
							<strong>${memberInfo.siteNm}구 상공회 회원가입 신청서</strong>
						</div>
						<!-- table_area -->
						<div class="table_area">
							<table class="form_view fixed">
								<caption>가입신청서 화면</caption>
								<colgroup>
									<col style="width: 40px;">
									<col style="width: 90px;">
									<col style="width: *;">
									<col style="width: 90px;">
									<col style="width: 130px;">
									<col style="width: 90px;">
									<col style="width: *;">
								</colgroup>
								<tbody>
								<tr>
									<th scope="row" colspan="2">회사명<strong class="color_pointr">*</strong></th>
									<td colspan="2">${memberInfo.companyNm}</td>
									<th scope="row">사업자등록번호<strong class="color_pointr">*</strong></th>
									<td colspan="2">${memberInfo.bsnregno}</td>
								</tr>
								<tr>
									<th scope="row" rowspan="4" class="middle">대<br />표<br />자</th>
									<th scope="row">성명<strong class="color_pointr">*</strong></th>
									<td colspan="2">${memberInfo.repNm}</td>
									<th scope="row">전화번호<strong class="color_pointr">*</strong></th>
									<td colspan="2">${memberInfo.repTel}</td>
								</tr>
								<tr>
									<th scope="row">생년월일</th>
									<td colspan="2">${memberInfo.birthDy}</td>
									<th scope="row">팩 스</th>
									<td colspan="2">${memberInfo.fax}</td>
								</tr>
								<tr>
									<th scope="row">휴대전화<strong class="color_pointr">*</strong></th>
									<td colspan="2">${memberInfo.repHp}</td>
									<th scope="row">홈 페 이 지</th>
									<td colspan="2">${memberInfo.homepage}</td>
								</tr>
								<tr>
									<th scope="row">이메일<strong class="color_pointr">*</strong></th>
									<td colspan="5">${memberInfo.repEmail}</td>
								</tr>
								<tr>
									<th scope="row" colspan="2">회사주소<strong class="color_pointr">*</strong></th>
									<td colspan="5">
										<div>(우편번호 : ${memberInfo.post})</div>
										<div>${memberInfo.addr1} &nbsp; ${memberInfo.addr2}</div>
									</td>
								</tr>
								<tr>
									<th scope="row" colspan="2">업종<strong class="color_pointr">*</strong></th>
									<td colspan="2">${memberInfo.indkindNm} </td>
									<th scope="row">주요품목<strong class="color_pointr">*</strong></th>
									<td colspan="2">${memberInfo.prodhanNm}</td>
								</tr>
								<tr>
									<th scope="row" colspan="2">종업원수<strong class="color_pointr">*</strong></th>
									<td colspan="2" class="alignr">
										<strong class="marginl5">${memberInfo.empCnt}명</strong>
									</td>
									<th scope="row">설립일자<strong class="color_pointr">*</strong></th>
									<td colspan="2">${memberInfo.establishDy}
								</tr>
								<tr>
									<th scope="row" colspan="2">연매출액</th>
									<td colspan="2" class="alignr">
										<fmt:formatNumber value="${memberInfo.sales}" pattern="#,###" /><strong class="marginl5">백만원</strong>
									</td>
									<th scope="row">자본금</th>
									<td colspan="2" class="alignr">
										<fmt:formatNumber value="${memberInfo.fund}" pattern="#,###" /><strong class="marginl5">백만원</strong>
									</td>
								</tr>
								<tr>
									<th scope="row" colspan="2">담당자 성명<strong class="color_pointr">*</strong></th>
									<td>${memberInfo.chargeNm}</td>
									<th scope="row">전화번호<strong class="color_pointr">*</strong></th>
									<td>${memberInfo.chargeHp}</td>
									<th scope="row">이메일<strong class="color_pointr">*</strong></th>
									<td>${memberInfo.chargeEmail}</td>
								</tr>
								</tbody>
							</table>
						</div>
						<!--// table_area -->
						<!-- form_txt_area -->
						<div class="form_txt_area">
							<p class="form_txt01">본인은 상공인간 상호 협력 및 지식ㆍ정보의 교류를 촉진하고, 지역경제 활성화에 기여하는 ${memberInfo.siteNm}구상공회 회원으로 가입하고자 신청서를 제출합니다.</p>
							<p class="form_txt02">※ 필수 제출서류 : 사업자등록증 또는 고유번호증 사본 1부. </p>
						</div>
						<!--// form_txt_area -->
						<!-- form_date_area -->
						<div class="form_date_area">
							<p class="form_date">
								<strong id = "year"></strong>년
								<strong id = "month"></strong>월
								<strong id = "day"></strong>일
							</p>
							<ul class="form_sign">
								<li>
									<strong>회사명:</strong>
									<span> ${memberInfo.companyNm}</span>
								</li>
								<li>
									<strong>대표자:</strong>
									<span> ${memberInfo.repNm} (서명)</span>
								</li>
							</ul>
							<div class="form_organization">
								<img src="/images/form/logo.png" /><strong>서울상공회의소  ${memberInfo.siteNm}구상공회 귀중</strong>
							</div>
						</div>
						<!--// form_date_area -->
					</div>
					<!--// print_area -->
					<!-- print_area -->
					<div class="print_btn" onclick="print();"> </div>
					<!--// print_area -->
				</div>
				<!--// division -->
			</div>
		</article>
		</div>
		<!--// popup_content -->

	</div>
	</body>
</html>

