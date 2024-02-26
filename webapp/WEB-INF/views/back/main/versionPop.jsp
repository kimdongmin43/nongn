<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
function versionSelect(obj){
	var mainId = $(obj).val();
	$("iframe[name=versionMainFrame]").attr("src","/front/user/main.do?originMainId="+mainId);
}
</script>

<div class="division marginb10 alignr">
	<label for="versionSelect" class="hidden">버전 선택</label>
	<select id="versionSelect" class="in_w35" onChange="versionSelect(this);">
		<option value="">선택</option>
		<c:forEach var="row" items="${saveMainList}" varStatus="status">
			<option value="${row.mainId}" <c:if test="${row.pubYn eq 'Y'}">selected</c:if>>${row.regDt} : ${row.mainCdNm}</option>
		</c:forEach>
	</select>
</div>
<p class="information_area">※ 버전관리범위 : 메인타입, 상단이미지, 컨텐츠영역(탭 등), 경제지표/e-content사용여부</p>
<!-- 사이트미리보기 화면 -->
<div class="division">
<iframe name="versionMainFrame" src="about:blank" height="1500px" width="100%" frameborder="1" scrolling="no"></iframe>
</div>
<!--// 사이트미리보기 화면 -->


