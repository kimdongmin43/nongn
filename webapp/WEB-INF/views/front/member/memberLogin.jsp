<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var listUrl = "<c:url value='/front/board/boardContentsListPage.do'/>";
var insertBoardContentsUrl = "<c:url value='/front/board/insertBoardContents.do'/>";
var insertBoardContentsReplyUrl = "<c:url value='/front/board/insertBoardContentsReply.do'/>";
var updateBoardContentsUrl = "<c:url value='/front/board/updateBoardContents.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";
var maxNoti = "${boardinfo.noti_num}";
var notiCnt = "${boardinfo.noti_cnt}";
var productCnt = 0;

var menuId = "${param.menuId}";
var boardId = "${param.boardId}";
</script>

<div class="content" id="containerContent">
    <!--login_area-->
    <div class="login_area">
    	<div class="login_box">
        	<div class="login_head">
            	<p>로그인 후 이용하실 수 있습니다.</p>
            </div>
            <div class="login_input">
                <label for="id" class="hide2">아이디 입력</label>
                <input type="text" id="id" name="id"  placeholder="아이디" />
                <label for="password" class="hide2">비밀번호 입력</label>
                <input type="password" id="password" name="password" placeholder="비밀번호" title="비밀번호" />
            </div>

            <button type="button" class="login" title="LOGIN">
                <span>LOGIN</span>
            </button>
        </div>
        <p class="login_comment">본 메뉴는 로그인한 특정회원만 사용이 가능합니다</p>
    </div>
    <!--//login_area-->
</div>

<style>
	.login{display: inline-block; width: 380px; height: 45px; background-color: #07a7e3;}

</style>


<script src="/js/apfs/board.js"></script>
