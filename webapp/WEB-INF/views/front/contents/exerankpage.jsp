<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

		<div class="contents_title">
			<h2>임원현황</h2>
			<div class="tab_box" align="right">
				<a class="tab1 on" href="exepageList.do?exeGbn=1">임원</a>
				<a class="tab2" href="exepageList.do?exeGbn=2">의원</a>
			</div>
		</div>
		<div class="contents_detail" >
			<c:set var="sortTemp" value="0" />
			<c:forEach var="exerank" items="${exerank}" varStatus="loop">
			<c:if test="${sortTemp ne exerank.sortA and exerank.exeCd=='1'}">
				<c:set var="k" value="0" />
				<c:if test="${exerank.sortA>1}">
				</ul>
			</div>
				</c:if>
			<div class="present_member">
				<h3>${exerank.ranm}</h3>
				<ul class="member_list">
			</c:if>
				<c:if test="${exerank.exeCd=='1' }">
					<c:set var="k" value="${k+1 }" />
					<li>
						<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${exerank.filePath}" alt="${exerank.exeNm}"
						style="width: 120px;height: 150px;" />
						<p>${exerank.companyNm}</p>
						<p><strong>${exerank.exeNm}</strong></p>
					</li>
					<c:if test="${k%4==0 && k!=0}">
				</ul>
				<ul class="member_list line" >
					</c:if>
					<c:set var="sortTemp" value="${exerank.sortA}" />
				</c:if>


			</c:forEach>
				</ul>
			</div>
		</div>



