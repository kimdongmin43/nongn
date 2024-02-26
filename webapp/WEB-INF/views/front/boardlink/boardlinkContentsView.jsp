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
<style>
div.board-img {
	overflow:hidden;
	padding:0px;
	margin-bottom:20px;
}

div.board-img p.img{
	vertical-align:baseline;
	width:480px;
	height:360px;
	float:left;
	/* margin-right:40px; */
}

div.board-img p.img img {
	width:480px;
	height:360px;
	display:none;
}
div.board-img p.img img.curr {
	display:block;
}

div.board-img ul{
	margin:0;
	vertical-align:baseline;
	float:left;
	width:190px;
	height:360px;
	background:url(/images/bg_boardview_img.png) no-repeat;
	padding:20px 29px 0 28px;
}

div.board-img ul li{
	padding-bottom:15px;
}

div.board-img ul li a{
	display:block;
	overflow:hidden;
	width:133px;
	height:100px;
}

div.board-img ul li a.curr{
	border:3px solid #03b1ed;
	width:133px;
	height:100px;
}

div.board-img ul li a img{
	display:block;
	width:133px;
	height:100px;
}

div.board-img ul li a.curr img{
	margin:-3px;
}

</style>

<script>
var boardlinkContentsListPageUrl = "<c:url value='/front/boardlink/boardlinkContentsListPage.do'/>";
var boardlinkContentsViewUrl = "<c:url value='/front/boardlink/boardlinkContentsView.do'/>";
var boardNewsViewUrl = "<c:url value='/front/board/boardNewsView.do'/>";

var cmt_el;
var cmt_commentid;
var mode;

$(document).ready(function() {
	$(".board-img ul li a").click(function() {
		if($(this).hasClass("curr")) return false;

		$t = $(this).attr("href");
		$(".board-img p.img img").removeClass("curr");
		$($t).addClass("curr");
		$(this).parents("ul").find("a").removeClass("curr").end().end().addClass("curr");
		return false;
	});
});


//목록으로
function list(){
	var f = document.writeFrm;

    f.target = "_self";
    f.action = boardlinkContentsListPageUrl;
    f.submit();
}

//게시물 뷰
function contentsView(contentsid){
	var f = document.writeFrm;

	$("#contId").val(contentsid);

    f.target = "_self";
    f.action = boardlinkContentsViewUrl;
    f.submit();
}

//게시물 뷰
function newsView(contentsid){
	var f = document.writeFrm;

	$("#contId").val(contentsid);

    f.target = "_self";
    f.action = boardNewsViewUrl;
    f.submit();
}



function down( file , dirName ) 			{
	var len, fileType, httpType;
	var filePath;

	len = file.length
	fileType = file.substring( (len-3), len);
	fileType = fileType.toUpperCase();

	httpType =  file.substring( 0, 4);
	httpType = httpType.toUpperCase();

	if( httpType != "HTTP" ) {
			filePath = "http://www.korcham.net/FileWebKorcham/Notice/"+dirName+"/";
			//http://www.korcham.net/FileWebKorcham/Notice/"+dir+"/"+file
			file = filePath + file;
		}
		if (fileType == "HWP") {
			location.href=file;
		} else {
			window.open( file, "openWin" );
		}

}

function down2( file ) 			{
	var len, fileType, httpType;
	var filePath;

	len = file.length
	fileType = file.substring( (len-3), len);
	fileType = fileType.toUpperCase();

	httpType =  file.substring( 0, 4);
	httpType = httpType.toUpperCase();

	if ( fileType == "PDF" || fileType == "DOC" || fileType == "XLS" || fileType == "HWP" || fileType == "PPT" || fileType == "OCX" || fileType == "LSX" ) {
		if( httpType != "HTTP" ) {
			filePath = "http://www.korcham.net/FileWebKorcham/EconInfo/";
			file = filePath + file;
		}
		if (fileType == "HWP") {
			location.href=file;
		} else {
			window.open( file, "openWin" );
		}
	} else {
		if( httpType != "HTTP" ) {
			filePath = "http://www.korcham.net/FileWebKorcham/EconInfo/";
			location.href=filePath;
		} else {
			window.open( file, "openWin" );
		}
	}
}
function open_pdf(name)
{
	m_url = 'http://www.korcham.net/new_pdf/target/' + name;

	window.open(m_url);
}
</script>


<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="mode" name='mode' value="E" />
	<input type='hidden' id="boardId" name='boardId' value="${param.boardId}" />
	<input type='hidden' id="contId" name='contId' value="${param.contId}" />
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${param.miv_pageNo }" />
	<input type='hidden' id="searchkey" name='searchKey' value="${param.searchKey }" />
	<input type='hidden' id="searchtxt" name='searchTxt' value="${param.searchTxt }" />


</form>

	<div class="contents_title">
		<h2>${MENU.menuNm}</h2>
	</div>
	<div class="contents_detail">
		<!--//S: 공지사항보기 -->
		<div class="boardveiw">
			<table cellspacing="0" cellpadding="0">
				<caption>${MENU.menuNm} 상세보기.${MENU.menuNm} 상세보기를 제목, 작성자, 작성일, 첨부 순으로 보실 수 있습니다. </caption>
				<colgroup>
					<col style="width:20%" />
					<col style="width:30%" />
					<col style="width:20%" />
					<col style="width:30%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">제목</th>
						<td colspan="3">
						<c:if test="${fn:indexOf(boardinfo.itemUse, 'cate') != -1}">
							<c:if test="${not empty contentsinfo.cateNm}">[${contentsinfo.cateNm }]</c:if>
						</c:if>
						${contentsinfo.title }</td>
					</tr>
					<c:choose>
					<c:when  test="${param.boardId=='19' or param.boardId=='15'}">
					<tr>
						<th scope="row">작성일</th>
						<td colspan="3">${fn:substring(fn:replace(contentsinfo.regDt,'-','.'),0,10)}</td>
					</tr>
					</c:when>
					<c:when test="${param.boardId=='11' or param.boardId=='7'}">
					<tr>
						<th scope="row">담당부서</th>
						<td>${contentsinfo.author }</td>
						<th scope="row">작성일</th>
						<td>${fn:substring(fn:replace(contentsinfo.regDt,'-','.'),0,10) }</td>
					</tr>
					<tr>
						<th scope="row">첨부파일</th>
						<td colspan="3">
							<ul class="file_view">
								<c:forEach items="${fileinfo}" var="list">
									<li><a href="javascript:open_pdf('${list.fileName}');">${list.fileName}</a></li>
								</c:forEach>
							</ul>
						</td>
					</tr>
					</c:when>
					<c:when test="${param.boardId=='12'}">
					<tr>
						<th scope="row">작성일</th>
						<td colspan="3">${fn:substring(contentsinfo.regDt,0,4)}.${fn:substring(contentsinfo.regDt,4,6)}.${fn:substring(contentsinfo.regDt,6,8)}</td>
					</tr>
					</c:when>
					<c:when test="${param.boardId=='13'}">
					<tr>
						<th scope="row">담당부서</th>
						<td>${contentsinfo.author }</td>
						<th scope="row">작성일</th>
						<td>${fn:substring(fn:replace(contentsinfo.regDt,'-','.'),0,10)}</td>
					</tr>
					<tr>
						<th scope="row">첨부파일</th>
						<td colspan="3">
							<ul class="file_view">
								<c:forEach items="${fileinfo}" var="list">
									<li><a href="javascript:down('${list.fileName}','${list.dirName}');">${list.fileName}</a></li>
								</c:forEach>
							</ul>
						</td>
					</tr>
					</c:when>
					<c:when test="${param.boardId=='14'}">
					<tr>
						<th scope="row">출처</th>
						<td>국제무역연구원</td>
						<th scope="row">작성일</th>
						<td>${fn:substring(fn:replace(contentsinfo.regDt,'-','.'),0,10)}</td>
					</tr>
					<tr>
						<th scope="row">첨부파일</th>
						<td colspan="3">
							<ul class="file_view">
								<c:set var="orig_name" value="${fn:substring(contentsinfo.fileNm,fn:indexOf(contentsinfo.fileNm,'=')+1,fn:length(contentsinfo.fileNm)) }"/>
								<c:if test="${orig_name!=''}"><c:set var="orig_name" value="${fn:substring(orig_name,0,fn:indexOf(orig_name,'&')) }"/><li><a href="${contentsinfo.fileNm}">${orig_name}</a></li></c:if>
							</ul>
						</td>
					</tr>
					</c:when>
					<c:when test="${param.boardId=='16'}">
					<tr>
						<th scope="row">등록기관</th>
						<td>${contentsinfo.author }</td>
						<th scope="row">작성일</th>
						<td>${fn:substring(fn:replace(contentsinfo.regDt,'-','.'),0,10)}</td>
					</tr>
					<tr>
						<th scope="row">첨부파일</th>
						<td colspan="3">
							<ul class="file_view">
								<c:forEach items="${fileinfo}" var="list">
									<li><a href="javascript:down('${list.fileName}','${list.dirName}');">${list.fileName}</a></li>
								</c:forEach>
							</ul>
						</td>
					</tr>
					</c:when>
					<c:when test="${param.boardId=='17'}">
					<tr>
						<th scope="row">출처</th>
						<td>${contentsinfo.author }</td>
						<th scope="row">작성일</th>
						<td>${fn:substring(fn:replace(contentsinfo.regDt,'-','.'),0,10)}</td>
					</tr>
					<tr>
						<th scope="row">첨부파일</th>
						<td colspan="3">
							<ul class="file_view">
								<c:if test="${contentsinfo.fileNm!=''}"><li><a href="javascript:down2('${contentsinfo.fileNm}');">${contentsinfo.fileNm}</a></li></c:if>
								<c:if test="${contentsinfo.fileNm2!=''}"><li><a href="javascript:down2('${contentsinfo.fileNm2}');">${contentsinfo.fileNm2}</a></li></c:if>
								<c:if test="${contentsinfo.fileNm3!=''}"><li><a href="javascript:down2('${contentsinfo.fileNm3}');">${contentsinfo.fileNm3}</a></li></c:if>
							</ul>
						</td>
					</tr>
					</c:when>
					<c:otherwise>
					<tr>
						<th scope="row">작성자</th>
						<td>${contentsinfo.author }</td>
						<th scope="row">작성일</th>
						<td>${fn:substring(fn:replace(contentsinfo.regDt,'-','.'),0,10)}</td>
					</tr>
					</c:otherwise>
					</c:choose>
					<tr>
						<td scope="row" colspan="4" class="td_p">
							<c:if test="${param.boardId=='19'}">
							<div class="board-img">
								<p class="img">
									<c:forEach items="${fileinfo}" var="list" varStatus="stauts">
									<img src="http://www.korcham.net/FileWebKorcham/PhotoNews/Image/${list.fileName}" alt="" id="boardimg0${stauts.index+1}" class="<c:if test="${stauts.index==0}">curr</c:if>" width='334' height='250'/>
									</c:forEach>
								</p>
								<ul>
									<c:forEach items="${fileinfo}" var="list" varStatus="stauts">
									<li>
										<a href="#boardimg0${stauts.index+1}" class="<c:if test="${stauts.index==0}">curr</c:if>"><img src="http://www.korcham.net/FileWebKorcham/PhotoNews/Image/${list.fileName}" alt="" id="boardimg0${stauts.index+1}" class="" width='334' height='250'/></a>
									</li>
									</c:forEach>
								</ul>
							</div>
							</c:if>
							<c:if test="${param.boardId=='14'}">
							[저자]<br /><br />
							${contentsinfo.author}<br />
							<hr />
							<br />[목차]<br /><br />
							</c:if>
							${fn:replace(contentsinfo.contents, cn, br)}
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<p class="btnjustify">
			<%-- 회원이면서 답글쓰기 권한이 있는경우 --%>
			<c:if test="${not empty MEMBER.memberId }">
				<c:if test="${MEMBER.memberId  eq contentsinfo.regMemId}">
				<button onclick="contentsEdit()" type="button" class="btn btn-blue">수정</button>
				<button type="button" onclick="contentsDelete()" class="btn btn-sky">삭제</button>
				</c:if>
			</c:if>
			<button  onclick="list()" type="button" class="btn btn-gray">목록</button>
		</p>
		<div class="befor_next">
			<table cellspacing="0" cellpadding="0">
				<caption>이전글, 다음글.이전글, 다음글 확인하실수 있습니다</caption>
				<colgroup>
					<col style="width:15%">
					<col style="width:85%">
				</colgroup>
				<c:if test="${param.boardId !='12'}">
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
				</c:if>
			 	<%-- <c:if test="${param.boardId!='12'}">
				<tbody>
					<tr>
						<th scope="row">이전글</th>
						<td><c:if test="${prenext.preId ne '0'}"><a href="#none" onclick="contentsView('${prenext.preId }')">${prenext.preTitle }</a></c:if></td>
					</tr>
					<tr>
						<th scope="row">다음글</th>
						<td><c:if test="${prenext.nextId ne '0'}"><a href="#none" onclick="contentsView('${prenext.nextId }')" >${prenext.nextTitle }</a></c:if></td>
					</tr>
				</tbody>
				</c:if> --%>
			</table>
		</div>
		<!--//E: 공지사항보기 -->
	</div>

