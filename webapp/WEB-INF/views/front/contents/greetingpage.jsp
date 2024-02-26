<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


	<c:forEach var="greetinglist" items="${greetinglist }">
		<div class="contents_title">
			<h2>${MENU.menuNm}</h2>
		</div>
		<div class=basic_txt  ><%-- style="background: url('${greetinglist.picFilePath}') no-repeat 0% 0%; background-position: left 5%;"0 0 no-repeat;padding-left: 0%; margin-bottom:20px; overflow:hidden;" --%>
			${greetinglist.contents}
			<div style="position:absolute; top:290px; left:330px; width:90px; overflow:hidden;" align="left" >
				<p><img src="/images/commpany_icon1.png"  style="margin-top: 65%;margin-left:5%; " class="ccc1" /></p>
				<p><img src="/images/commpany_icon2.png" style="margin-top: 45%;margin-left:5%; " class="ccc2" /></p>
				<p><img src="/images/commpany_icon3.png" style="margin-top: 45%;margin-left:5%; " class="ccc3" /></p>
			</div>
		</div>
							<div style="position:absolute; top:92px;">
				<img src="${greetinglist.picFilePath}"  width="155px;" height="184px;"  />
				</div>
		<div align="right">
			<img src="${greetinglist.sinFilePath}">
		</div>
	</c:forEach>







<Script>
$(document).ready(function(){

	var hh = $('.contents_detail').outerHeight(true);
	if (hh<=300) {
		$('.ccc2').remove();
		$('.ccc3').remove();
	}else if(hh>300 && hh<600){
		$('.ccc3').remove();
	}
});

</Script>

