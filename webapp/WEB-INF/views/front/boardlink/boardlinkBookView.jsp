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
var boardContentsListPageUrl = "<c:url value='/front/boardlink/boardlinkContentsListPage.do'/>";
var boardContentsViewUrl = "<c:url value='/front/boardlink/boardlinkBookView.do'/>";

var cmt_el;
var cmt_commentid;
var mode;


//목록으로
function list(){
	var f = document.writeFrm;

    f.target = "_self";
    f.action = boardContentsListPageUrl;
    f.submit();
}

//게시물 뷰
function contentsView(contentsid){
	var f = document.writeFrm;

	$("#contId").val(contentsid);

    f.target = "_self";
    f.action = boardContentsViewUrl;
    f.submit();
}

function MM_openBrwindow(theURL, winName, features) { //v2.0
	window.open(theURL, winName, features);
}


function open_popup3(name,gubun,login)
{
	if (login=="1")
	{
	m_url = '/nCham/Service/lib/pdf_popup_member3.asp?name=' + name +'&gubun=' + gubun;
	}else{
	m_url = 'http://www.korcham.net/nCham/Service/lib/pdf_popup.asp?name=' + name +'&gubun=' + gubun;
	}
	//alert(m_url);
	window.open(m_url,'pdf','resizable=1,width=800,height=700,scrollbars=yes');
}

</script>


<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="mode" name='mode' value="E" />
	<input type='hidden' id="boardId" name='boardId' value="${param.boardId}" />
	<input type='hidden' id="contId" name='contId' value="${param.contId}" />
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${param.miv_pageNo }" />
	<input type='hidden' id="s_searchkey" name='s_searchkey' value="${param.searchkey }" />
	<input type='hidden' id="s_searchtxt" name='s_searchtxt' value="${param.searchtxt }" />


</form>

	<div class="contents_title">
		<h2>${MENU.menuNm}</h2>
	</div>
	<div class="contents_detail">
		<!--//S: 공지사항보기 -->
		<div class="boardveiw">
			<table cellspacing="0" cellpadding="0">
				<caption>발간자료 상세보기.발간자료보기 상세보기를 제목,  작성일, 내용 순으로 보실 수 있습니다.</caption>
				<colgroup>
					<col style="width:60%" />
					<col style="width:40%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="row">${bookinfo.title}</th>
						<th scope="row" class="date">발간일 : ${fn:substring(fn:replace(bookinfo.regDt,'-','.'),0,10)}</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="2">
							<div class="file_area">
								<div class="alignr">
									<span class="file_txt">⊙ 컨텐츠보기</span>
									<c:if test="${!empty bookinfo.ebookFile02}">
									<a class="btn_pdf" href="javascript: open_popup3('${bookinfo.ebookFile02}','publish',2);" title="PDF보기">
										<span>PDF 보기</span>
									</a>
									</c:if>
									<a class="btn_ebook" href="javascript:MM_openBrwindow('http://www.korcham.net/FileWebKorcham/PublishData/eBook/${fn:replace(bookinfo.ebookFile01,'.html','')}/${bookinfo.ebookFile01}','publish','menubars=no, toolbars=no, resizable=yes');" title="e-Book 보기">
										<span>e-Book 보기</span>
									</a>
								</div>
							</div>
							<img class="img" src="http://www.korcham.net/FileWebKorcham/PublishData/Image/${bookinfo.fileNm}" alt="${bookinfo.title}" />
							<div class="txt">
								요약정보<br />
								${fn:replace(bookinfo.contents, cn, br)}
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<p class="btnjustify">
			<button  onclick="list()" type="button" class="btn btn-gray">목록</button>
		</p>
		<div class="befor_next">
			<table cellspacing="0" cellpadding="0">
				<caption>이전글, 다음글.이전글, 다음글을 확인하실수 있습니다 </caption>
				<colgroup>
					<col style="width:15%">
					<col style="width:85%">
				</colgroup>
				<tbody>

		<c:if test="${prenext.nextId ne '0'}">
          <tr>
            <th scope="row" style="font-size:10px;">▲</th>
            <td><a href="#none" style="font-size:12px;" onclick="contentsView('${prenext.nextId }')" >${prenext.nextTitle }</a></td>
          </tr>
          </c:if>

          			<tr>
					<th scope="row"  style="font-size:10px;"> ‒</th>
					<td><c:if
							test="${fn:indexOf(boardinfo.itemUse, 'cate') != -1}">
							<c:if test="${not empty contentsinfo.cateNm}">[${contentsinfo.cateNm }]</c:if>
						</c:if> ${contentsinfo.title }</td>
					</tr>

   		<c:if test="${prenext.preId ne '0'}">
          <tr>
            <th scope="row" style="font-size:10px;">▼</th>
            <td><a href="#none" style="font-size:12px;" onclick="contentsView('${prenext.preId }')">${prenext.preTitle }</a></td>
          </tr>
          </c:if>

				</tbody>
			</table>
		</div>
		<!--//E: 공지사항보기 -->
	</div>
