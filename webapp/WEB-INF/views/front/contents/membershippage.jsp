<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


		<div class="contents_title">
			<h2>회원구성</h2>
		</div>
<div class="member_composition bg1">

			 <c:forEach var="memlist" items="${memlist}">
				${memlist.contents}
			</c:forEach>

</div>