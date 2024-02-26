<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script src="/js/common.js">
function intropageListPage() {

    var f = document.writeFrm;
    f.target = "_self";
    f.action = "/back/contents/intropageListPage.do";
    f.submit();
}
</script>



<div class="section">
	<div class="container">
		<div class="row">
			<div class="col-md-12">${intropage.contents}</div>
		</div>
	</div>
</div>
<!-- <div class="button_area">
	<div class="float_right">


		<a href="javascript:intropageListPage();" class="btn cancel" title="목록"> <span>목록</span>
		</a>
	</div>
</div> -->
