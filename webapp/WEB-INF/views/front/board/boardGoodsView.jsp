<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%
     //치환 변수 선언합니다.
   pageContext.setAttribute("cr", "\r"); //Space
   pageContext.setAttribute("cn", "\n"); //Enter
   pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
   pageContext.setAttribute("br", "<br/>"); //br 태그
%>

<script>
var boardContentsListPageUrl = "<c:url value='/front/board/boardContentsListPage.do'/>";
var boardContentsWriteUrl = "<c:url value='/front/board/boardContentsWrite.do'/>";
var boardEtcContentsViewUrl = "<c:url value='/front/board/boardEtcContentsView.do'/>";
var mode;

<%--
//목록으로
function list(){
	var f = document.writeFrm;

    f.target = "_self";
    f.action = boardContentsListPageUrl;
    f.submit();
}

  //게시물 뷰
  function contentsEtcView(contentsid){
	var f = document.writeFrm;

	$("#contId").val(contentsid);

    f.target = "_self";
    f.action = boardEtcContentsViewUrl;
    f.submit();
}
--%>

</script>


<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="mode" name='mode' value="E" />
	<input type='hidden' id="boardId" name='boardId' value="${contentsinfo.boardId}" />
	<input type='hidden' id="contId" name='contId' value="${param.contId}" />
	<input type='hidden' id="recommend_yn" name='recommend_yn' value="" />
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${param.miv_pageNo }" />
	<input type='hidden' id="s_reply_ststus" name='s_reply_ststus' value="${param.reply_ststus }" />
	<input type='hidden' id="s_searchkey" name='s_searchkey' value="${param.searchkey }" />
	<input type='hidden' id="s_searchtxt" name='s_searchtxt' value="${param.searchtxt }" />
	<input type='hidden' id="s_cate_id" name='s_cate_id' value="${param.cate_id }" />


</form>
<div id="location_area">
	<div class="content_tit">
		<h3>${MENU.menuNm}</h3>
	</div>


					<div class="table_area">
                    	<table class="tstyle_view">
                        	<caption>IR 상세보기 화면</caption>
                            <colgroup>
                                <col style="width: 15%;" />
                                <col style="width: *;" />
                                <col style="width: 15%;" />
                                <col style="width: *;" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">기업명</th>
                                    <td><span class="fc_blue">${contentsinfo.companyNm}</span></strong></td>
                                    <th scope="row">대표자</th>
                                    <td>${contentsinfo.ceo}</td>
                                </tr>
                                <tr>
                                    <th scope="row">주요품목</th>
                                    <td colspan="3">${contentsinfo.note}</td>
                                </tr>
                                <tr>
                                    <th scope="row">연락처</th>
                                    <td>${contentsinfo.tel}</td>
                                    <th scope="row">이메일</th>
                                    <td>${contentsinfo.email}</td>
                                </tr>
                                <tr>
                                    <th scope="row">기타</th>
                                    <td colspan="3">${contentsinfo.productDesc}</td>
                                </tr>
                                <tr>
                                    <th scope="row">작성일</th>
                                    <td colspan="3">${contentsinfo.regDt}</td>
                                </tr>
                                <tr>
                                    <td colspan="4" scope="row">
                                    	<div class="editor_ir">
                                        <img src="${contentsinfo.imgPath}${contentsinfo.imgNm}" alt="${contentsinfo.imgNm}">

                                        </div>
                                        <p class="tac">
                                            <a href="${contentsinfo.imgPath}${contentsinfo.imgNm2}" class="btn_download" alt="${contentsinfo.imgNm2}" >PDF 다운로드</a>
                                        <p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        </div>



		<div class="btn_area fl_right">
			<a href="#;"  class="btn_list">목록</a>
		</div>

</div>

<%-- <div class="befor_next">
			<table cellspacing="0" cellpadding="0">
				<caption>이전글,다음글표.이전글, 다음글 확인하실수 있습니다.</caption>
				<colgroup>
					<col style="width:8%">
					<col style="width:92%">
				</colgroup>
				<tbody>
				<c:if test="${prenext.preId ne null}">
						<tr>
						<th scope="row"  style="font-size:10px;">▲</th>
						<td><a href="#none" style="font-size:12px;" onclick="contentsEtcView('${prenext.preId }')">${prenext.preTitle }</a></td>
					</tr>
					</c:if>

				<tr>
					<th scope="row"  style="font-size:10px;"> ‒</th>
					<td><c:if
							test="${fn:indexOf(boardinfo.itemUse, 'cate') != -1}">
							<c:if test="${not empty contentsinfo.cateNm}">[${contentsinfo.cateNm }]</c:if>
						</c:if> ${contentsinfo.title }</td>
				</tr>

								<c:if test="${prenext.nextId ne null}">
						<tr>
						<th scope="row" style="font-size:10px;">▼</th>
						<td ><a href="#none"  style="font-size:12px;" onclick="contentsEtcView('${prenext.nextId }')" >${prenext.nextTitle }</a></td>
					</tr>
					</c:if>

				</tbody>
			</table>
		</div>
 --%>

<script src="/js/apfs/board.js"></script>