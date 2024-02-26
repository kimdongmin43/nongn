<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

		<div class="contents_title">
			<h2>의원현황</h2>
			<div class="tab_box" align="right">
				<a class="tab1" href="exepageList.do?exeGbn=1">임원</a>
				<a class="tab2 on" href="exepageList.do?exeGbn=2">의원</a>
			</div>
		</div>
		<div class="contents_detail">
			<div class="present_member">
				<ul class="member_list">
				<c:set var="k" value="0" />
				<c:forEach var="exepagelist" items="${exepagelist}" varStatus="loop">
					<c:if test="${exepagelist.exeCd == '2' }">
					<c:set var="k" value="${k+1 }" />
					<li>
						<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${exepagelist.filePath}" alt="${exepagelist.exeNm}"
						style="width: 120px;height: 150px;" />
						<p>${exepagelist.companyNm}</p>
						<p><strong>${exepagelist.exeNm}</strong></p>
					</li>
				<c:if test="${k%4==0 && k!=0}">
					</ul>
				<ul class="member_list line" >
						</c:if>
					</c:if>
				</c:forEach>
				</ul>
			</div>
		</div>
