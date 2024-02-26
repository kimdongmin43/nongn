<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.*"%>
<%
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy.MM.dd");
String now = formatter.format(new java.util.Date());
String devServer = "";
pageContext.setAttribute("now",now);
pageContext.setAttribute("devServer",devServer);
%>
				<div class="slidebanner">
					<ul>
						<c:forEach  var="row" items="${mainBannerList}" varStatus="status">
						<c:if test="${row.sectionCd eq '1'}">
						<li><a href="${row.url}" target="${row.targetCd}" title="${row.targetCdNm}"><img src="${devServer}${row.filePath}" alt="${row.alt}"  style="width:168px;height:42px;"/></a></li>
						</c:if>
						</c:forEach>
					</ul>
					<button type="button" class="slick-pause" title="정지">정지</button>
				</div>


