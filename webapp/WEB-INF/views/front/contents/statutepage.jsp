<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<style>
.box1 {
	float: left;
	margin-left: 40px;
	vertical-align: top;
	width: 240px;
	height: 100px;
}

.modal {
	height: 600px;
	vertical-align: middle;
	top: 20%;
	overflow-y: hidden;
	width: 900px;
	top: 20%;
}

.leg {
	width: 95%;
	height: 245px;
	background:gainsboro;
	color: #7d7d7d;
	font-size: 13px;
	line-height: 24px;
	overflow-y: scroll;
	margin-bottom: 35px;
	padding: 30px 40px;
}

.sta {
	height: 50px;
}

.stabtn {
	margin-left: 70px;
	 vertical-align: middle;
}

</style>




<div class="contents_title">
	<h2>${MENU.menuNm}</h2>
</div>



<c:forEach var="statutelist" items="${statutelist}">
<h3 class="type2">${statutelist.title}</h3>
&nbsp;&nbsp;
<pre class="legislation">
${statutelist.contents}
</pre>
</c:forEach>

<%-- <c:forEach var="statutelist" items="${statutelist}">
	<div class="box1">
		<ul class="member_list">
			<li><c:set var="i" value="${i+1}" />
				<div class="sta" align="center">
					<c:forTokens items="${statutelist.title}" delims="-" var="ti">
						<h3 class="type2">${ti}</h3>
					</c:forTokens>
					&nbsp;&nbsp;
				</div>
				<div class="stabtn">
					<button id="id" class="btn btn-default" data-target="#layerpop${i}"
						data-toggle="modal">본문보기</button>
				</div></li>
		</ul>

	</div>
</c:forEach> --%>




<%-- <!-- modal-->
<div class="modal fade" id="layerpop1">
	<button type="button" class="btn btn-default"
		style="background-color: transparent; font-size: 30px; float: right; border: 0; outline: 0;"
		data-dismiss="modal">X</button>

	<c:forEach var="statutelist" items="${statutelist}">
		<c:if test="${statutelist.sort=='1'}">
			<pre class="leg">${statutelist.contents}</pre>
		</c:if>
	</c:forEach>

</div>


<!-- modal -->
<div class="modal fade" id="layerpop2">
	<button type="button" class="btn btn-default"
		style="background-color: transparent; font-size: 30px; float: right; border: 0; outline: 0;"
		data-dismiss="modal">X</button>

	<c:forEach var="statutelist" items="${statutelist}">
		<c:if test="${statutelist.sort=='2'}">
			<pre class="leg">${statutelist.contents}</pre>
		</c:if>
	</c:forEach>

</div>


<!-- modal -->
<div class="modal fade" id="layerpop3">
	<button type="button" class="btn btn-default"
		style="background-color: transparent; font-size: 30px; float: right; border: 0; outline: 0;"
		data-dismiss="modal">X</button>

	<c:forEach var="statutelist" items="${statutelist}">
		<c:if test="${statutelist.sort=='3'}">
			<pre class="leg">${statutelist.contents}</pre>
		</c:if>
	</c:forEach>

</div>
 --%>




