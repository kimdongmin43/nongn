<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
		<div class="contents_title">
			<h2>${MENU.menuNm}</h2>
		</div>
		<div class="contents_detail" style="display:">
			<ul class="meantime_chairman">
			<c:forEach var="ceolist" items="${ceolist}" varStatus="loop">
				<li>
					<h3>${ceolist.ceoNm}&nbsp;회장</h3>
					<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${ceolist.filePath}" alt="${ceolist.ceoNm}회장"
					style="width:120px;height: 150px;"/>
					<div class="meantime_txt">
						<p>${ceolist.stageDesc}</p>
						<p>${ceolist.startDy}~${ceolist.endDy}</p>
						<div class="chairman_career">${ceolist.companyNm}</div>
					</div>
				</li>
			</c:forEach>
			</ul>
		</div>

