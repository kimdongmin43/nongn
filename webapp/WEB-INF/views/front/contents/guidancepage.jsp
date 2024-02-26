<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

		<div class="contents_title">
			<h2>${MENU.menuNm}</h2>
		</div>
		<div class="contents_detail">
			<ul class="infomation">

		<c:forEach var="guidancepage" items="${guidancepage}">
			<c:set var="i" value="${i+1}" />
			<c:if test="${guidancepage.contents != null}">
				<li class="info_line${i}">&nbsp;&nbsp;
					<h3>${guidancepage.title}</h3>
					<div class="basic_txt">${guidancepage.contents}</div>
				</li>
			</c:if>
		</c:forEach>

	</ul>
		</div>
