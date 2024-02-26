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
var boardContentsListPageUrl = "<c:url value='/back/board/boardContentsListPage.do'/>";
var boardContentsWriteUrl = "<c:url value='/back/board/boardContentsWrite.do'/>";
var saveBoardAnswerUrl = "<c:url value='/back/board/saveBoardContentsAnswer.do'/>";
var boardContentsViewUrl = "<c:url value='/back/board/boardContentsView.do'/>";
var deleteBoardContentsUrl = "<c:url value='/back/board/deleteBoardContents.do'/>";
var saveCommentUrl = "<c:url value='/back/board/saveComment.do'/>";
var deleteCommentUrl = "<c:url value='/back/board/deleteComment.do'/>";
var boardCommentListUrl = "<c:url value='/back/board/boardCommentList.do'/>";
var saveSatisfyUrl = "<c:url value='/back/board/saveSatisfy.do'/>";
var saveRecommendUrl = "<c:url value='/back/board/saveRecommend.do'/>";
var loadRecommendUrl = "<c:url value='/back/board/loadRecommend.do'/>";

// 목록으로 
function list(){
	var f = document.writeFrm;
	   
    f.target = "_self";
    f.action = boardContentsListPageUrl;
    f.submit();	
}

// 답변 등록
function answerSave(){
	var url = saveBoardAnswerUrl;
	if (confirm('답변을 등록하시겠습니까?')) {
    	
		$.ajax({
			type: "POST",
			url: url,
			data :jQuery("#answerFrm").serialize(),
			dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					list();
				}	
			}
		});
		
    }
}

//게시물 수정
function contentsEdit(){
	var f = document.writeFrm;
	
    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
}

// 게시물 삭제/복원
function contentsDelete(delyn){
    var url = deleteBoardContentsUrl;
    var confirmMsg;
    confirmMsg = delyn == 'N' ? "게시물을 복원하시겠습니까?" : "게시물을 삭제하시겠습니까?" ;
    
    $("#del_yn").val(delyn);
    
	if (confirm(confirmMsg)) {
		$.ajax({
			type: "POST",
			url: url,
			data :jQuery("#writeFrm").serialize(),
			dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					list();
				}
			}
		});
    }
}

//답글 쓰기
function contentsReply(){
	var f = document.writeFrm;
	
	$("#mode").val("R");
	
    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
}

//답변 쓰기(QNA)
function contentsAnswer(){
	var f = document.writeFrm;
	
	$("#mode").val("A");
	
    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
}

//게시물 뷰
function contentsView(contentsid){
	var f = document.writeFrm;
	
	$("#cont_id").val(contentsid);
	   
    f.target = "_self";
    f.action = boardContentsViewUrl;
    f.submit();
}

// 추천하기
function saveRecommend(){
	var url = saveRecommendUrl;
	$.ajax({
		type: "POST",
		url: url,
		data : {
			cont_id : "${param.cont_id}",
			recommend_yn : $("#recommend_yn").val()
		},
		dataType: 'json',
		success:function(data){
			alert(data.message);
			// 추천가져오기
			loadRecommend();
		}
	});
}

// 추천가져오기
function loadRecommend(){
	var url = loadRecommendUrl;
	$.ajax({
		type: "POST",
		url: url,
		data : {
			cont_id : "${param.cont_id}",
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

</script>

<!--// content -->
<div id="content">
	<!-- title_and_info_area -->
	<div class="title_and_info_area">
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title">${MENU.menuNm}</h3>
		</div>
		<!--// main_title -->
		<jsp:include page="/WEB-INF/views/back/menu/menuDescInclude.jsp"/>
	</div>
	<!--// title_and_info_area -->
	
	<!-- sns_btn_area -->
	<%-- <div class="sns_btn_area">
		<button class="btn_recommend " onclick="saveRecommend()"> <!-- 내가 클릭했을때 -->
			<span id="recommend_cnt">0</span>
		</button>
		<a href="javascript:;" onclick="goTwitter('${contentsinfo.title }','http://localhost/back/board/boardContentsView.do?cont_id=${param.cont_id}&board_id=${param.board_id}')" title="해당 게시물 트위터로 공유하기">
			<img src="/images/back/icon/sns_twitter.png" alt="" />
		</a>
		<a href="javascript:;" onclick="goFacebook('http://localhost/back/board/boardContentsView.do?cont_id=${param.cont_id}&board_id=${param.board_id}')" title="해당 게시물 페이스북으로 공유하기">
			<img src="/images/back/icon/sns_facebook.png" alt="" /> 
		</a>
		<a href="javascript:;" onclick="contentsPrint('content');" title="해당 게시물 프린트 하기">
			<img src="/images/back/icon/sns_print.png" alt="" />
		</a>
	</div> --%>
	<!--// sns_btn_area -->
	
	<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
		<input type='hidden' id="write_mem_cd" name='write_mem_cd' value="" />
		<input type='hidden' id="read_mem_cd" name='read_mem_cd' value="" />
		<input type='hidden' id="mode" name='mode' value="E" />
		<input type='hidden' id="board_id" name='board_id' value="${param.board_id}" />
		<input type='hidden' id="cont_id" name='cont_id' value="${param.cont_id}" />
		<input type='hidden' id="gubun" name='gubun' value="${param.gubun}" />
		<input type='hidden' id="recommend_yn" name='recommend_yn' value="" />
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		<input type='hidden' id="s_reply_ststus" name='s_reply_ststus' value="${param.reply_ststus }" />
		<input type='hidden' id="s_searchKey" name='s_searchKey' value="${param.searchKey }" />
		<input type='hidden' id="s_searchTxt" name='s_searchTxt' value="${param.searchTxt }" />
		<input type='hidden' id="s_cate_id" name='s_cate_id' value="${param.cate_id }" />
		<input type='hidden' id="boardCd" name='boardCd' value="${boardinfo.boardCd }" />
		<input type='hidden' id="del_yn" name='del_yn' value="" />
		
		
		<!-- view_title_area -->
		<h4 class="view_title">
			<span>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'cate') != -1}">
					<c:if test="${not empty contentsinfo.cate_nm}">[${contentsinfo.cate_nm }]</c:if>
				</c:if>
				${contentsinfo.title }
			</span>
			<c:if test="${fn:indexOf(boardinfo.item_use, 'hit') != -1}">
				<span style="float:right">조회수 : ${contentsinfo.hit }</span>
			</c:if>
		</h4>
		<!--// view_title_area -->

		<!-- division view_area -->
		<div class="view_area" id="contentsView">
			<!-- dl_view -->
			<div class="dl_view viewdlpad">
				<c:if test="${fn:indexOf(boardinfo.item_use, 'link') != -1}">
					<c:if test="${not empty contentsinfo.title_link }">
					<dl class="view">
						<dt class="vdt"><span>URL명</span></dt>
						<dd class="vdd">
							<a href="${contentsinfo.title_link }" title="URL 링크" target="_blank">${contentsinfo.title_link }</a>
						</dd>
					</dl>
					</c:if>
				</c:if>
				<dl class="view">
					<dt class="vdt"><span>작성자</span></dt>
					<dd class="vdd">${contentsinfo.reg_mem_nm }</dd>
				
					<%-- <dt class="vdt"><span>휴대전화</span></dt>
					<dd class="vdd">${contentsinfo.mobile }</dd> --%>
				
					<%-- <dt class="vdt"><span>sms수신여부</span></dt>
					<dd class="vdd">
						<c:if test="${contentsinfo.sms_yn eq 'Y'}">사용</c:if>
						<c:if test="${contentsinfo.sms_yn ne 'Y'}"><dd class="vdd">사용안함</c:if>
					</dd> --%>
				
					<%-- <dt class="vdt"><span>작성일</span></dt>
					<dd class="vdd">${contentsinfo.book_dt }</dd> --%>
					
					<%-- <dt class="vdt"><span>IP</span></dt>
					<dd class="vdd">${contentsinfo.reg_ip }</dd> --%>
				</dl>
				<dl class="view">
					<dt class="vdt"><span>작성일</span></dt>
					<dd class="vdd">${contentsinfo.book_dt }</dd>
				</dl>
				
				<c:if test="${fn:indexOf(boardinfo.item_use, 'url') != -1}">
					<c:if test="${not empty contentsinfo.url_nm }">
					<dl class="view">
						<dt class="vdt"><span>URL명</span></dt>
						<dd class="vdd">
							<a href="${contentsinfo.url_link }" title="URL 링크" target="_blank">${contentsinfo.url_nm }</a>
						</dd>
					</dl>
					</c:if>
				</c:if>
				
				<c:if test="${fn:indexOf(boardinfo.item_use, 'attach') != -1}">
					<c:if test="${not empty fileList }">
					<dl class="view">
						<dt class="vdt"><span>첨부파일</span></dt>
						<dd class="vdd">
							<c:forEach items="${fileList }" var="list">
								<c:set var="file_size" value="${list.file_size/1024}" />
								<fmt:formatNumber value="${file_size}" var="size" pattern="0" />
								<a href="/commonfile/fileidDownLoad.do?file_id=${list.file_id}"  target="_blank" class="download" title="다운받기">
									<c:if test="${list.file_type eq 'hwp'}"><img src="/images/back/icon/icon_hwp.png" alt="한글파일" /></c:if>
									<c:if test="${list.file_type eq 'pdf'}"><img src="/images/back/icon/icon_pdf.png" alt="pdf파일" /></c:if>
									<c:if test="${list.file_type eq 'xls' or list.file_type eq 'xlsx'}"><img src="/images/back/icon/icon_excel.png" alt="엑셀파일" /></c:if>
									<c:choose>
										<c:when test="${list.file_type eq 'hwp'}"><img src="/images/back/icon/icon_hwp.png" alt="한글파일" /></c:when>
										<c:when test="${list.file_type eq 'pdf'}"><img src="/images/back/icon/icon_pdf.png" alt="pdf파일" /></c:when>
										<c:when test="${list.file_type eq 'xls'}"><img src="/images/back/icon/icon_excel.png" alt="엑셀파일" /></c:when>
										<c:when test="${list.file_type eq 'xlsx'}"><img src="/images/back/icon/icon_excel.png" alt="엑셀파일" /></c:when>
										<c:otherwise><img src="/images/back/icon/icon_file.png" alt="파일" /></c:otherwise>
									</c:choose>
									${list.source_file_nm }(${size }KB)
								</a>
							</c:forEach>
						</dd>
					</dl>
					</c:if>
				</c:if>
				
				<c:if test="${fn:indexOf(boardinfo.item_use, 'source') != -1}">
					<c:if test="${not empty contentsinfo.source }">
					<dl class="view">
						<dt class="vdt"><span>출처</span></dt>
						<dd class="vdd">${contentsinfo.source }</dd>
					</dl>
					</c:if>
				</c:if>
				
			</div>
			<!--// dl_view -->

			<!-- editor -->
			<c:if test="${fn:indexOf(boardinfo.item_use, 'contents') != -1}">
			<div class="editor_area view">${fn:replace(contentsinfo.contents, cn, br)}</div>
			</c:if>
			<!--// editor -->
		</div>
		<!--// division view_area -->
	</form>
	</br>
	
	<%-- 답변사용여부 --%>
	<%-- <c:if test="${fn:indexOf(boardinfo.item_use, 'reply_yn') != -1}">
	<!--// division view_area -->
	<div class="title_area margint40">
		<h4 class="title">답변</h4>
	</div>
	
	<!-- division view_area -->
	<form id="answerFrm" name="answerFrm" onsubmit="return false;">
		<input type="hidden" name="board_id" value="${param.board_id}" />
		<input type="hidden" name="cont_id" value="${param.cont_id}" />
		
		<!-- answer_area -->
		<div class="answer_area">
			<!-- answer -->
			<dl class="answer">
				<dt class="adt"><span>답변일</span></dt>
				<dd class="add">${contentsinfo.contents_date }</dd>
			</dl>
			<!--// answer -->
			<!-- editor -->
			<div class="editor_area">
				<textarea class="in_w100" cols="5" rows="7" id="contents_txt" name="contents_txt">${contentsinfo.contents_txt }</textarea>
			</div>
			<!--// editor -->
		</div>
		<!--// answer_area -->
		
	</form>
	<!--// division view_area -->
	</c:if> --%>
	
	<!-- button_area -->
	<div class="button_area">
		<div class="float_left">
			<c:if test="${not empty prenext.pre_id }">
			<a href="javascript:contentsView('${prenext.pre_id }')" title="${prenext.pre_title }">
				<img src="/images/back/common/btn_prev.png" alt="이전 페이지로 이동" />
			</a>
			</c:if>
			<c:if test="${not empty prenext.next_id }">
			<a href="javascript:contentsView('${prenext.next_id }')" title="${prenext.next_title }">
				<img src="/images/back/common/btn_next.png" alt="다음 페이지로 이동" />
			</a>
			</c:if>
		</div>
		<div class="float_right">
			<%-- 답변은 관리자만 저장할 수 있음(front 제거) --%>
			<c:if test="${contentsinfo.del_yn eq 'N'}">
			<c:if test="${fn:indexOf(boardinfo.item_use, 'reply_yn') != -1}">
			<!-- <button id="answerSave" class="btn save" onclick="answerSave()" title="답변저장하기">
				<span>답변저장</span>
			</button> -->
			<button id="answerSave" class="btn save" onclick="contentsAnswer()" title="답변하기">
				<span>답변하기</span>
			</button>
			</c:if>
			<c:if test="${boardinfo.boardCd ne 'Q' }">
			<button id="replyBtn" onclick="contentsReply()" class="btn save" title="답글쓰기" >
				<span>답글</span>
			</button>
			</c:if>
			<button id="modBtn" onclick="contentsEdit()" class="btn save" title="수정하기">
				<span>수정</span>
			</button>
			<button id="delBtn" onclick="contentsDelete('Y')" class="btn cancel" title="삭제하기">
				<span>삭제</span>
			</button>
			</c:if>
			<c:if test="${contentsinfo.del_yn eq 'Y'}">
			<button id="delBtn" onclick="contentsDelete('N')" class="btn cancel" title="복원하기">
				<span>복원</span>
			</button>
			</c:if>
			<a href="javascript:list()" class="btn list" title="목록 페이지로 이동">
				<span>목록</span>
			</a>
		</div>
	</div>
	<!--// button_area -->
	
	<%-- 댓글 사용여부 --%>
	<c:if test="${fn:indexOf(boardinfo.item_use, 'comment') != -1}">
	<div class="comment_area">
		<div class="comment_title_area">
			<h5 class="comment_title">댓글</h5><strong class="number"><span id="commentCnt">0</span></strong>
		</div>
		<div class="commentbox_area">
		<!-- 댓글 입력 -->
		<form id="commentFrm" name="commentFrm" method="post" onsubmit="saveComment(this); return false;">
			<input type="hidden" name="mode" value="W" />
			<input type='hidden' id="cont_id" name="cont_id" value="${param.cont_id}" />
			<input type='hidden' id="comment_id" name="comment_id" value="" />
			<input type='hidden' id="reg_mem_nm" name="reg_mem_nm" value="${reg_mem_nm }" />
			<input type='hidden' id="grp" name="grp" value="0" />
			<input type='hidden' id="sort" name="sort" value="0" />
			<input type='hidden' id="depth" name="depth" value="0" />
			
			<div class="txtinput_area">
				<div class="txtbox">
					<textarea class="txtinput" id="contents" name="contents" title="댓글 입력" onkeyup="pubByteCheckTextarea(this)"></textarea>
					<div class="count_number">
						<strong id="strCnt">0</strong> / 300
					</div>
				</div>
				<button id="commentSave" class="btn_comment_save" title="등록하기">
					<span>등록하기</span>
				</button>
			</div>
		</form>
		<!--// 댓글 입력 -->

		<!--- list -->
		<div id="commentList"><div>
	</c:if>
	
</div>

<script>

$(document).ready(function(){
	loadRecommend(); // 추천수 가져오기
	
	<c:if test="${fn:indexOf(boardinfo.item_use, 'comment') != -1}">
	loadCommentList(); // 댓글 불러오기		
	</c:if>
});

//댓글 리스트 불러오기
function loadCommentList(){
	$.ajax({
        url: boardCommentListUrl,
        dataType: "html",
        type: "post",
        data: {
        	cont_id : "${param.cont_id}"
		},
        success: function(data) {
        	$("#commentList").html(data);
        	$("#commentCnt").text($(".comment_list li").length);   	
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

function saveComment(frm) {
	if(frm.contents.value == ""){
		alert("댓글을 입력하여야 합니다.");
		return;
	}
	
    if (confirm('저장하시겠습니까?')) {
        $.ajax({
            type: 'post',
            url: saveCommentUrl,
            dataType: 'json',
            data: $(frm).serialize(),
            success: function(data) {
            	if(data.success == "true"){
                    frm.contents.value = "";
                    loadCommentList();
                } else {
                    alert(data.message);
                }
            }
        });
    }
}

function delComment(idx) {
    if (confirm('삭제하시겠습니까?')) {
        $.ajax({
            type: 'post',
            url: deleteCommentUrl,
            dataType: 'json',
            data: {
            	cont_id : "${param.cont_id}",
            	comment_id : idx
            },
            success: function(data) {
            	if(data.success == "true"){
                    loadCommentList();
                } else {
                	alert(data.message);
                }
            }
        });
    }
}

function reComment(el, idx, grp, sort) {
    var fid = "reFrm"+idx;
    var cont_id = "${param.cont_id}";
    var reg_mem_nm = "${reg_mem_nm }";
    
    if ($('.'+fid).length>0) return;
    var date = getTimeStamp();

    var html = '<li class="' + fid + '">';
    html += '<div class="info_arae"><strong>'+name+'</strong><span>' + date + '</span></div>';
    html += '<form id="modFrm_'+idx+'" method="post" onsubmit="saveComment(this); return false;">';
    html += '<input type="hidden" name="mode" value="R" />';
    html += '<input type="hidden" id="cont_id" name="cont_id" value="'+cont_id+'" />';
    html += '<input type="hidden" id="reg_mem_nm" name="reg_mem_nm" value="'+reg_mem_nm+'" />';
    html += '<input type="hidden" id="grp" name="grp" value="'+grp+'" />';
    html += '<input type="hidden" id="sort" name="sort" value="'+sort+'" />';
    html += '<input type="hidden" id="depth" name="depth" value="1" />';    
    html += '<div class="txtinput_area">';
    html += '    <div class="txtbox">';
    html += '        <textarea class="txtinput" name="contents" title="댓글 입력" onkeyup="pubByteCheckTextarea(this)"></textarea>';
    html += '        <div class="count_number">';
    html += '            <strong>0</strong> / 300';
    html += '        </div>';
    html += '    </div>';
    html += '    <button class="btn_comment_save" title="등록하기">';
    html += '        <span>등록하기</span>';
    html += '    </button>';
    html += '    <button type="button" class="btn_comment_cancel" title="취소" onclick="$(\'.' + fid + '\').remove();">';
    html += '        <span><img src="/images/back/common/btn_comment_delete.png" alt="삭제하기" /></span>';
    html += '    </button>';
    html += '</div>';
    html += '</form></li>';


    if ($('#child_'+idx).length) {
        $('#child_'+idx).append(html);
    } else {
        var div = '<li class="' + fid + '"><div class="recommentbox">';
            div += '<ul class="comment_list">' + html + '<ul></div></li>';

        $(el).parent().parent().after(div);
    }
}

function modComment(el, idx) {
    if ($("#modFrm_"+idx).length>0) return;
    
    var cont = $(el).parent().siblings(".contents");
    var cont_id = "${param.cont_id}";
    
    var txt = $(cont).text();
    txt = $.trim(txt);

    var html = '<form id="modFrm_'+idx+'" method="post" onsubmit="saveComment(this); return false;">';
    html += '<input type="hidden" name="mode" value="E" />';
    html += '<input type="hidden" id="cont_id" name="cont_id" value="'+cont_id+'" />';
    html += '<input type="hidden" id="comment_id" name="comment_id" value="'+idx+'" />';
    html += '<div class="txtinput_area">';
    html += '    <div class="txtbox">';
    html += '        <textarea class="txtinput" name="contents" title="댓글 입력" onkeyup="pubByteCheckTextarea(this)">' + txt + ' </textarea>';
    html += '        <div class="count_number">';
    html += '            <strong>0</strong> / 300';
    html += '        </div>';
    html += '    </div>';
    html += '    <button class="btn_comment_save" title="등록하기">';
    html += '        <span>등록하기</span>';
    html += '    </button>';
    html += '    <button type="button" class="btn_comment_cancel" title="취소" onclick="removeFrm(this);">';
    html += '        <span><img src="/images/back/common/btn_comment_delete.png" alt="삭제하기" /></span>';
    html += '    </button>';
    html += '</div>';
    html += '</form>';

    $(cont).hide();
    $(el).parent().after(html);
}

function removeFrm(el) {
    $(el).parent().parent().siblings('.contents').show();
    $(el).parent().parent().remove();
}

function getTimeStamp() {
  var d = new Date();
  var s =
    leadingZeros(d.getFullYear(), 4) + '-' +
    leadingZeros(d.getMonth() + 1, 2) + '-' +
    leadingZeros(d.getDate(), 2) + ' ' +

    leadingZeros(d.getHours(), 2) + ':' +
    leadingZeros(d.getMinutes(), 2) + ':' +
    leadingZeros(d.getSeconds(), 2);

  return s;
}

function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}


//byte check
function pubByteCheckTextarea(obj) {
    var byteTxt = "";
    var byte = function(str){
        var byteNum=0;
        for(i=0;i<str.length;i++){
            byteNum+=(str.charCodeAt(i)>127)?2:1;
            if(byteNum < 600){
                byteTxt+=str.charAt(i);
            };
        };
        return Math.round( byteNum/2 );
    };

    if(byte($(obj).val()) > 300){
        alert("300자 이상 입력할수 없습니다.");
        $(obj).val("");
        $(obj).val(byteTxt);
    } else {
        $(obj).next().children().html( byte($(obj).val()) );
    }
}

</script>