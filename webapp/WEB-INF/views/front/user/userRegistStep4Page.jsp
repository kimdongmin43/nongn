<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<!-- division40 -->
<div class="division40">
	<!-- division60 -->
	<div class="division60">
		<!-- chapter_area -->
		<div class="chapter_area">
			<img src="../../../images/front/sub/member_chapter04.png" alt="4. 회원가입완료" />
		</div>
		<!--// chapter_area -->
		<!-- division30 -->
		<div class="division30">
			<!-- member_com_area -->	
			<div class="member_com_area">
				<div class="member_com_txt_box">
					<p class="member_com_txt1">회원가입이 정상적으로 이루어졌습니다.</p>
					<p class="member_com_txt2" style="font-size:17px"><strong class="color_pointb">서울시 상공회의소 온라인플랫폼</strong> 회원이 되신 것을 환영합니다.</p>
				</div>
				<!-- table_area -->
				<div class="table_area">
					<table class="write fixed">
						<caption>회원가입완료 상세 화면</caption>
						<colgroup>
							<col style="width: 120px;">
							<col style="width: *;">
						</colgroup>
						<tbody>
						<tr>
							<th scope="row" class="first">아이디</th>
							<td class="first">${user.user_id }</td>
						</tr>
						<tr>
							<th scope="row">가입일</th>
							<td>${user.reg_date }</td>
						</tr>
						</tbody>
					</table>
				</div>
				<!--// table_area -->	
			</div>
			<!--// member_com_area -->							
		</div>
		<!--// division30 -->
	</div>
	<!--// division60 -->
</div>
<!--// division40 -->