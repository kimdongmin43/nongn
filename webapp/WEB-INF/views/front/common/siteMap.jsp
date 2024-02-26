<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<div class="contents_title">
	<h2>사이트맵</h2>
</div>
<div class="contents_detail">
	<div class="sitemap_wrap">
	<c:set var="bgNum" value="0"/>
	<c:set var="tempLevel" value="0" />
	<c:forEach var="siteList" items="${siteMapList}" varStatus="j">
		<c:choose>
			<c:when test="${siteList.level=='1'}">
				<c:if test="${tempLevel=='3'}" >
						</ul>
					</dd>
				</c:if>
				<c:if test="${bgNum>0}" >
				</dl></c:if>
				<c:set var="bgNum" value="${bgNum+1}"/>
				<dl>
					<dt>${siteList.menu_nm}</dt>
			</c:when>
			<c:when test="${siteList.level=='2'}">
				<c:if test="${tempLevel>siteList.level}" >
					</dd></c:if>
						<c:if test="${tempLevel==siteList.level}" ></dd></c:if>
						<dd><a href="javascript: goUrl('${siteList.target_cd}','${siteList.ref_url}','${siteList.width}','${siteList.height}','${siteList.top}','${siteList.left}','${siteList.menu_id}')">${siteList.menu_nm}</a>
			</c:when>
			<c:when test="${siteList.level=='3'}">
				<c:if test="${tempLevel<siteList.level}" >
					</dd>
					<dd>
						<ul>
				</c:if>
							<li><a href="javascript: goUrl('${siteList.target_cd}','${siteList.ref_url}','${siteList.width}','${siteList.height}','${siteList.top}','${siteList.left}','${siteList.menu_id}')">${siteList.menu_nm}</a></li>
			</c:when>
		</c:choose>
		<c:set var="tempLevel" value="${siteList.level}" />
	</c:forEach>
		</dl>
	</div>
</div>