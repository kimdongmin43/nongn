<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

    <div class="contents_title">
			<h2>임직원현황</h2>
		</div>
		<div class="contents_detail" >
			<div class="present_member">
				<h3>사무국장</h3>
				<ul class="member_list">
				<c:set var="k" value="0" />
				<c:forEach var="emprank" items="${emprank}" varStatus="loop">
					<c:if test="${emprank.deptNm=='사무국장' && emprank.deptId=='40' }">
					<c:set var="k" value="${k+1 }" />
					<li>
						<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${emprank.filePath}" alt="${emprank.empNm}"
						style="width: 120px;height: 150px;" />
						<p>${emprank.rankNm}</p>
						<p><strong>${emprank.empNm}</strong></p>
					</li>
					</c:if>
					<c:if test="${k%4==0 && k!=0}">
				</ul>
				<ul class="member_list line" >
					</c:if>
				</c:forEach>
				</ul>
			</div>

<%-- 	<c:if test="${not empty emprank.deptNm=='총무경영지원부' }"> --%>
			<div class="present_member">
				<h3>총무경영지원부</h3>
				<ul class="member_list">
				<c:set var="k" value="0" />
				<c:forEach var="emprank" items="${emprank}" varStatus="loop">
					<c:if test="${emprank.deptNm=='총무경영지원부' && emprank.deptId=='41'}">
					<c:set var="k" value="${k+1 }" />
					<li>
						<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${emprank.filePath}" alt="${emprank.empNm}"
						style="width: 120px;height: 150px;"/>
						<p>${emprank.rankNm}</p>
						<p><strong>${emprank.empNm}</strong></p>
					</li>
		<c:if test="${k%4==0 && k!=0}">
					</ul>
				<ul class="member_list line" >
						</c:if>
					</c:if>
				</c:forEach>
				</ul>
			</div>


			<div class="present_member">
				<h3>기획국제사업부</h3>
				<ul class="member_list">
				<c:set var="k" value="0" />
				<c:forEach var="emprank" items="${emprank}" varStatus="loop">
					<c:if test="${emprank.deptNm=='기획국제사업부' && emprank.deptId=='42' }">
					<c:set var="k" value="${k+1 }" />
					<li>
						<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${emprank.filePath}" alt="${emprank.empNm}"
						style="width: 120px;height: 150px;"/>
						<p>${emprank.rankNm}</p>
						<p><strong>${emprank.empNm}</strong></p>
					</li>
						<c:if test="${k%4==0 && k!=0}">
					</ul>
				<ul class="member_list line" >
						</c:if>
					</c:if>
				</c:forEach>
				</ul>
			</div>



			<div class="present_member">
				<h3>회원사업부</h3>
				<ul class="member_list">
				<c:set var="k" value="0" />
				<c:forEach var="emprank" items="${emprank}" varStatus="loop">
					<c:if test="${emprank.deptNm=='회원사업부' && emprank.deptId=='43' }">
					<c:set var="k" value="${k+1 }" />
					<li>
						<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${emprank.filePath}" alt="${emprank.empNm}"
						style="width: 120px;height: 150px;"/>
						<p>${emprank.rankNm}</p>
						<p><strong>${emprank.empNm}</strong></p>
					</li>
					</c:if>
					<c:if test="${k%4==0 && k!=0}">
				</ul>
					<ul class="member_list line" >
			</c:if>
				</c:forEach>
			</div>


						<div class="present_member">
				<h3>제주지식재산센터</h3>
				<ul class="member_list">
				<c:set var="k" value="0" />
				<c:forEach var="emprank" items="${emprank}" varStatus="loop">
					<c:if test="${emprank.deptNm=='제주지식재산센터' && emprank.deptId=='44' }">
					<c:set var="k" value="${k+1 }" />
					<li>
						<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${emprank.filePath}" alt="${emprank.empNm}"
						style="width: 120px;height: 150px;"/>
						<p>${emprank.rankNm}</p>
						<p><strong>${emprank.empNm}</strong></p>
					</li>
					</c:if>
					<c:if test="${k%4==0 && k!=0}">
				</ul>
			</c:if>
				</c:forEach>
			</div>

						<div class="present_member">
				<h3>FTA활용지원센터</h3>
				<ul class="member_list">
				<c:set var="k" value="0" />
				<c:forEach var="emprank" items="${emprank}" varStatus="loop">
					<c:if test="${emprank.deptNm=='FTA활용지원센터' && emprank.deptId=='121' }">
					<c:set var="k" value="${k+1 }" />
					<li>
						<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${emprank.filePath}" alt="${emprank.empNm}"
						style="width: 120px;height: 150px;"/>
						<p>${emprank.rankNm}</p>
						<p><strong>${emprank.empNm}</strong></p>
					</li>
					</c:if>
					<c:if test="${k%4==0 && k!=0}">
				</ul>
					<ul class="member_list line" >
			</c:if>
				</c:forEach>
			</div>

						<div class="present_member">
				<h3>인적자원개발위원회 </h3>
				<ul class="member_list">
				<c:set var="k" value="0" />
				<c:forEach var="emprank" items="${emprank}" varStatus="loop">
					<c:if test="${emprank.deptNm=='인적자원개발위원회' && emprank.deptId=='221' }">
					<c:set var="k" value="${k+1 }" />
					<li>
						<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${emprank.filePath}" alt="${emprank.empNm}"
						style="width: 120px;height: 150px;"/>
						<p>${emprank.rankNm}</p>
						<p><strong>${emprank.empNm}</strong></p>
					</li>
					</c:if>
					<c:if test="${k%4==0 && k!=0}">
				</ul>
					<ul class="member_list line" >
			</c:if>
				</c:forEach>
			</div>

		</div>