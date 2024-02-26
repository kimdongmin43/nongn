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
var boardContentsListPageUrl = "<c:url value='/front/boardlink/boardlinkContentsListPage.do?boardId=3&menuId=${param.menuId}'/>";

var boardContentsViewUrl = "<c:url value='/front/boardlink/boardlinkSeminaView.do?menuId=${param.menuId}'/>";

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

//게시물 수정
function contentsEdit(){
  var f = document.writeFrm;

    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
}


//답글 쓰기
function contentsReply(){
  var f = document.writeFrm;

  $("#mode").val("R");

    f.target = "_self";
    f.action = boardContentsWriteUrl;
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



// 추천하기
function saveRecommend(){

  // 로그인 여부 확인하기
  var sid = "${s_user_no }";
  if(sid == ""){
    alert("로그인이 후 참여 가능합니다.");
    goPage('7d8de154663840ad83ae6d93bf539c5c', '', '');
    return;
  }

  var url = saveRecommendUrl;
  $.ajax({
    type: "POST",
    url: url,
    data : {
      contId : "${param.contId}",
      recommend_yn : $("#recommend_yn").val()
    },
    dataType: 'json',
    success:function(data){
      alert(data.message);
      // 추천가져오기
      //loadRecommend();
    }
  });
}

// 추천가져오기
function loadRecommend(){
  return;
  var url = loadRecommendUrl;
  $.ajax({
    type: "POST",
    url: url,
    data : {
      contId : "${param.contId}",
    },
    dataType: 'json',
    success:function(data){
      if(data.recommend_yn == "Y"){
        $("#recommend_cnt").html(data.recommend_cnt);
        $("#recommend_yn").val(data.recommend_yn);
        $(".btn_recommend").addClass("pick");
      }else{
        $("#recommend_cnt").html(data.recommend_cnt);
        $("#recommend_yn").val(data.recommend_yn);
        $(".btn_recommend").removeClass("pick");
      }
    }
  });
}

function video(cntid,seid){
	var sid = "${s_user_no }";
	if(sid == ""){
		if(confirm('회원전용입니다. 로그인페이지로 이동하시겠습니까?')){
			location.href='/front/user/login.do';
			return;
		}else{
			return;
		}
	}


	makeLecWnd('1010','645',cntid,seid, 'semiWnd', 'no');


}

function report_down(file){
	var sid = "${s_user_no }";
	if(sid == ""){
		if(confirm('회원전용입니다. 로그인페이지로 이동하시겠습니까?')){
			location.href='/front/user/login.do';
			return;
		}else{
			return;
		}
	}

	var len, fileType;
	len = file.length
	fileType = file.substring( (len-3), len);
	fileType = fileType.toUpperCase();
	if ( fileType == "PDF" ) {
		window.open( "http://www.korcham.net/FileWebKorcham/OnlineSeminar/File/"+file, "openWin" );
	} else {
		//location.href = "/nCham/lib/Download_jp.asp?filename="+file;
		location.href = "http://www.korcham.net/FileWebKorcham/OnlineSeminar/File/"+file;
	}
}


function makeLecWnd(x,y,oid,sid) {
  x = "620";
  y = "600";
	objWnd = window.open("http://www.korcham.net/nCham/Service/Economy/appl/OnlineSeminarPlay2.asp?ONSEMI_ID="+oid+"&SESSION_ID="+sid,"","scrollbars=no,resizable=no,menubar=no,top=0, left=0,fullscreen=no,width="+ x +",height="+ y +"");
}

</script>


<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
  <input type='hidden' id="mode" name='mode' value="E" />
  <input type='hidden' id="boardId" name='boardId' value="${param.boardId}" />
  <input type='hidden' id="contId" name='contId' value="${param.contId}" />
  <input type='hidden' id="recommend_yn" name='recommend_yn' value="" />
  <input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${param.miv_pageNo }" />
  <input type='hidden' id="s_reply_ststus" name='s_reply_ststus' value="${param.reply_ststus }" />
  <input type='hidden' id="searchkey" name='searchKey' value="${param.searchKey }" />
  <input type='hidden' id="searchtxt" name='searchTxt' value="${param.searchTxt }" />
  <input type='hidden' id="s_cate_id" name='s_cate_id' value="${param.cate_id }" />


</form>

  <div class="contents_title">
    <h2>${MENU.menuNm}</h2>
  </div>
  <div class="contents_detail">
    <!--//S: 공지사항보기 -->
    <div class="boardveiw">
      <table cellspacing="0" cellpadding="0">
        <caption>온라인세미나 상세보기.온라인세미나 상세보기를 제목 순으로 보실 수 있습니다.</caption>
        <colgroup>
          <col style="width:100%" />
        </colgroup>
        <tbody>
          <tr>
            <th scope="row">${contentsinfo.title }</th>
          </tr>
          <tr>
            <td scope="row" class="td_n">
              <ul class="table_detail">
                <li class="img_li">
                  <div class="table_box2">
                    <div class="cell_box">
                      <img class="table_img" src="http://www.korcham.net/FileWebKorcham/OnlineSeminar/Image/${contentsinfo.fileNm}" alt="온라인세미나이미지" />
                    </div>
                  </div>
                </li>
                <li>
                  <div class="datalist5">
                    <table class="no_line" cellspacing="0" cellpadding="0">
                      <caption>온라인세미나 상세.온라인세미나 게시글을 주최, 문의처, 일시, 장소, 요약정보 순으로 정보를 작성하실 수 있습니다.</caption>
                      <colgroup>
                        <col style="width:15%" />
                        <col style="width:30%" />
                        <col style="width:15%" />
                        <col style="width:40%" />
                      </colgroup>
                      <tbody>
                        <tr>
                          <th scope="col">주최</th>
                          <td>${contentsinfo.host }</td>
                          <th scope="col">문의처</th>
                          <td>${contentsinfo.contact}</td>
                        </tr>
                        <tr>
                          <th scope="col">일시</th>
                          <td>${fn:replace(contentsinfo.regDt,'/','.') }</td>
                          <th scope="col">장소</th>
                          <td>${contentsinfo.place }</td>
                        </tr>
                        <tr>
                          <th scope="col">요약정보</th>
                          <td colspan="3">${fn:replace(contentsinfo.contents, cn, br)}</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </li>
              </ul>
              <ul class="online_list">
                <c:forEach items="${seminainfo }" var="list" varStatus="status">
                <li>
                  <div class="online_list_txt"><span class="online_list_title">${status.index+1}. ${list.sessionName} ( ${list.sessionTime}분)</span><span class="online_list_name">${list.sessionTchname} - ${list.sessionTchinfo}</span></div>
                  <div class="online_list_btn">
                    <button onclick="javascript:video('${contentsinfo.contId}','${list.sessionId}');" type="button" class="btn4 btn-blue">영상보기</button>
                    <c:if test="${list.sessionFile ne null}">
                    <button onclick="javascript:report_down('${list.sessionFile}','online');" type="button" class="btn4 btn-violet">REPROT</button>
                    </c:if>
                  </div>
                </li>
                </c:forEach>
              </ul>
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
        <caption>이전글, 다음글.이전글, 다음글 확인하실수 있습니다</caption>
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
