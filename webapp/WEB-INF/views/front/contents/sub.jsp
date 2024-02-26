<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var boardContentsListPageUrl = "<c:url value='/front/board/boardContentsListPage.do'/>";
var paramT = "${param.t}";

$( document ).ready(function() {
	if ( (paramT != null) && (paramT != '') ) {
		var  param_t = parseInt(paramT)+0;
		if(param_t<1){param_t=1;}

		setTimeout("type_list("+param_t+")",200);
	} else {
		setTimeout("type_list(1)",200);
	}
	
	$("#skip_nav").focus();		//	키보드 이동을 위해 포커스 - 2020.10.19
 });


 function goSearch(str){
	 var f = document.goPost;

		$("#searchTxt").val(str);

	    f.target = "_self";
	    f.action = boardContentsListPageUrl;
	    f.submit();
 }

 function selDepart(num){
		$('.staff').css('display','none');
		$('#staff-'+num).css('display','');
		$('.stafff-'+num).attr('title','선택됨');		//23년 웹접근성
		/* $('#staff-'+num).attr('title','선택됨'); */
	}

</script>




<div class="content_tit" id="containerContent">
    <h3>${memlist.title}</h3>
</div>
<!--content-->
<div class="content">
<div class="ed">${fn:replace(memlist.contents,"iffm","iframe")}</div>
</div>
<form name="goPost" method="post">
<input type="hidden" name="searchTxt" id="searchTxt" />
<input type="hidden" name="menuId" value="5389" />
<input type="hidden" name="boardId" value="20071" />
</form>

 