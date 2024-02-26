<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="contents_title">
	<h2><!-- 비전/CI -->${MENU.menuNm}</h2>
</div>
<c:forEach var="localvisionlist" items="${localvisionlist}">
<div>
		${localvisionlist.contents}

	</div>
<div align="center" >
<ul>
	<li>
	<a class="btn3 btn-green"
		style="min-width: 170px; height: 35px; color: #fff; font-size: 14px; background: #18c190; padding: 8px 50px;"
		href="${localvisionlist.picFilePath}"
		download="${localvisionlist.picOriginFileNm}">AI 다운로드</a>


	<a class="btn3 btn-blue2"
		style="min-width: 170px; height: 35px; color: #fff; font-size: 14px; background: #18bfc1; padding: 8px 50px;"
		href="${localvisionlist.sinFilePath}"
		download="${localvisionlist.sinOriginFileNm}">JPG 다운로드</a>
</li>
</ul>
</div>
</c:forEach>


