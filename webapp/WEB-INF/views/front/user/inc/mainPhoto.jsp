<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.*"%>
				<c:forEach  var="sRow" items="${mainPhotoList}" varStatus="status">
				<li <c:if test="${sRow.mainDiv ne 'PHOTO' and mainMap.mainImgCd eq 'P0'}">style="width:100%;"</c:if> class="MAIN_${sRow.mainDiv}${status.index}_BOX">
					<a href="${sRow.refUrl}" <c:if test="${sRow.mainDiv ne 'PHOTO' and mainMap.mainImgCd eq 'P0'}">style="width:100%;"  </c:if>target="_blank">
				<img src="${sRow.filePath}" alt="${sRow.title}" width="100%" height="100%" />
						<c:if test="${sRow.mainDiv ne 'IMG'}"><span class="img_tit">${sRow.title}</span></c:if>
					</a>
				</li>
				</c:forEach>


