<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var boardContentsListPageUrl = "<c:url value='/front/board/boardContentsListPage.do'/>";
var boardContentsViewUrl = "<c:url value='/front/board/boardContentsView.do'/>";
var boardContentsWriteUrl = "<c:url value='/front/board/boardContentsWrite.do'/>";
var deleteBoardContentsUrl = "<c:url value='/front/board/deleteBoardContents.do'/>";
var chkBoardPassUrl = "<c:url value='/front/board/chkBoardPass.do'/>";

var rtValue = "${rt}";
var chk = "N";
</script>

<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="mode" name='mode' value="${param.mode}" />
	<input type='hidden' id="board_id" name='board_id' value="${param.board_id}" />
	<input type='hidden' id="contents_id" name='contents_id' value="${param.contents_id}" />
	<input type='hidden' id="chkpass" name='chkpass' value="N" />
	
	<!-- table_area -->
	<div class="table_area">
		<table class="write fixed">
			<caption>패스워드 화면</caption>
			<colgroup>
				<col style="width: 120px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<tr>
				<th scope="row" class="first">
					<label for="input_password"><strong class="color_pointr">*</strong> 비밀번호</label>
				</th>
				<th scope="row" class="first">
					<input type="password" class="in_w100" id="pass" name="pass" data-parsley-required="true" title="비밀번호" />									
				</td>
			</tr>
			</tbody>
		</table>
	</div>
	<!--// table_area -->
	
	<!-- button_area -->
	<div class="button_area">
		<div class="float_right">
			<button id="saveBtn" class="btn save2" title="확인">
				<span>확인</span>
			</button>
			<button class="btn list2" title="취소">
				<span>취소</span>
			</button>
		</div>
	</div>
	<!--// button_area -->
	
</form>

<script src="/js/apfs/board.js"></script>
