<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var reply_status = "N";
var link = "N";
var secret_yn = "N";
var comment_yn = "N";
var selectBoardContentsPageListUrl = "<c:url value='/back/board/selectBoardContentsPageList.do'/>";

$(document).ready(function(){

	//alert($("#subMenu > li").removeClass("on"));
	//alert($("#subMenu > li").eq(1).addClass("on"));

	<c:if test="${fn:indexOf(boardinfo.viewPrint, 'ope_yn') != -1}">secret_yn = "Y";</c:if>
	<c:if test="${fn:indexOf(boardinfo.viewPrint, 'reply_status') != -1}">reply_status = "Y";</c:if>
	<c:if test="${fn:indexOf(boardinfo.viewPrint, 'link') != -1}">link = "Y";</c:if>
	<c:if test="${fn:indexOf(boardinfo.viewPrint, 'comment') != -1}">comment_yn = "Y";</c:if>

	$('#contents_list').jqGrid({
		datatype: 'json',
		url: selectBoardContentsPageListUrl,
		mtype: 'POST',
		colModel: [
		<c:forEach items="${viewSortList }" var="list">
			<c:if test="${list.vPrint ne 'openYn' &&  list.vPrint ne 'reply_status' && list.vPrint ne 'link' && view.vPrint ne 'comment'}">
				<c:if test="${list.vPrint eq 'number' }">{ label: '${list.iOut}', index: 'rnum', name: 'rnum', width: '${list.vSize}', align : 'center', sortable:false, formatter:jsRownumFormmater},</c:if>
				/* <c:if test="${list.vPrint eq 'cate' }">{ label: '${list.iOut}', index: 'cate_nm', name: 'cate_nm', width: '${list.vSize}', align : 'center', sortable:false},</c:if> */
				<c:if test="${list.vPrint eq 'title' }">{ label: '${list.iOut}', index: 'title', name: 'title', width: '${list.vSize}', align : 'left', sortable:false, formatter:jsTitleFormmater},</c:if>
				<c:if test="${list.vPrint eq 'contents' }">{ label: '${list.iOut}', index: 'contents', name: 'contents', width: '${list.vSize}', align : 'center', sortable:false},</c:if>
				/* <c:if test="${list.vPrint eq 'thumb' }">{ label: '${list.iOut}', index: 'thumb', name: 'thumb', width: '${list.vSize}', align : 'center', sortable:false, formatter:jsThumbFormmater},</c:if> */
				<c:if test="${list.vPrint eq 'attach' }">{ label: '${list.iOut}', index: 'attach', name: 'attach', width: '${list.vSize}', align : 'center', sortable:false, formatter:jsAttachFormmater},</c:if>
				<c:if test="${list.vPrint eq 'reg_mem_nm' }">{ label: '${list.iOut}', index: 'regMemNm', name: 'regMemNm', width: '${list.vSize}', align : 'center', sortable:false},</c:if>
				<c:if test="${list.vPrint eq 'reg_dt' }">{ label: '${list.iOut}', index: 'regDt', name: 'regDt', width: '${list.vSize}', align : 'center', sortable:false},</c:if>
				<c:if test="${list.vPrint eq 'hit' }">{ label: '${list.iOut}', index: 'hit', name: 'hit', width: '${list.vSize}', align : 'center', sortable:false},</c:if>				
				<c:if test="${list.vPrint eq 'etc0' }">{ label: '${list.iOut}', index: 'etc0', name: 'etc0', width: '${list.vSize}', align : 'center', sortable:false},</c:if>
				<c:if test="${list.vPrint eq 'etc1' }">{ label: '${list.iOut}', index: 'etc1', name: 'etc1', width: '${list.vSize}', align : 'center', sortable:false},</c:if>
				<c:if test="${list.vPrint eq 'etc2' }">{ label: '${list.iOut}', index: 'etc2', name: 'etc2', width: '${list.vSize}', align : 'center', sortable:false},</c:if>
				<c:if test="${list.vPrint eq 'etc3' }">{ label: '${list.iOut}', index: 'etc3', name: 'etc3', width: '${list.vSize}', align : 'center', sortable:false},</c:if>
				<c:if test="${list.vPrint eq 'etc4' }">{ label: '${list.iOut}', index: 'etc4', name: 'etc4', width: '${list.vSize}', align : 'center', sortable:false},</c:if>
				<c:if test="${list.vPrint eq 'etc5' }">{ label: '${list.iOut}', index: 'etc5', name: 'etc5', width: '${list.vSize}', align : 'center', sortable:false},</c:if>
				<c:if test="${list.vPrint eq 'etc6' }">{ label: '${list.iOut}', index: 'etc6', name: 'etc6', width: '${list.vSize}', align : 'center', sortable:false},</c:if>
				<c:if test="${list.vPrint eq 'etc7' }">{ label: '${list.iOut}', index: 'etc7', name: 'etc7', width: '${list.vSize}', align : 'center', sortable:false},</c:if>
				<c:if test="${list.vPrint eq 'etc8' }">{ label: '${list.iOut}', index: 'etc8', name: 'etc8', width: '${list.vSize}', align : 'center', sortable:false},</c:if>
				<c:if test="${list.vPrint eq 'etc9' }">{ label: '${list.iOut}', index: 'etc9', name: 'etc'9, width: '${list.vSize}', align : 'center', sortable:false},</c:if>
				

			</c:if>
		</c:forEach>
		],
		postData :{
			defaulttype : "${boardinfo.boardCd}",
			boardId : $("#boardId").val(),
			cateId : $("#cateId").val(),
        	reply_ststus : $("#reply_ststus").val(),
        	etc0 : $("#etc0").val(),
        	searchKey : $("#searchKey").val(),
        	searchTxt : $("#searchTxt").val(),
        	searchYn : $("#searchYn").val(),
        	delYn : $("#searchdelyn").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#contents_pager',
		viewrecords : true,
		<c:if test="${boardinfo.boardCd ne 'P' and boardinfo.boardCd ne 'R' and boardinfo.boardCd ne 'I' }">sortname : "noti_yn DESC,noti_seq DESC,reg_dt DESC, ref_seq DESC, restep_seq",</c:if>
		<c:if test="${boardinfo.boardCd eq 'P' or boardinfo.boardCd eq 'R' or boardinfo.boardCd eq 'I' }">sortname : "ref_seq DESC, reg_dt DESC,title",</c:if>/* title을 임시로 2번째 오더바이로 넣어둠 */
		sortorder : "asc",
		height : "500px",
		gridview : true,
		autowidth : true,
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
			$("#searchYn").val(data.searchYn);
        },
      	//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
		loadComplete : function(data) {
			showJqgridDataNon(data, "contents_list", 5);
		}
	});
	//jq grid 끝

	bindWindowJqGridResize("contents_list", "contents_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.notiYn == "Y"){
		str = "공지";
	}else{
		str = $("#total_cnt").val() - (rowObject.rnum-1);
	}
	return str;
}

function replaceAll(inputString, targetString, replacement){
	  var v_ret = null;
	  var v_regExp = new RegExp(targetString, "g");
	  v_ret = inputString.replace(v_regExp, replacement);
	  return v_ret;
}

// 제목
function jsTitleFormmater(cellvalue, options, rowObject) {
	var str = "";
	var title = rowObject.title;
	title = replaceAll(title,"RE : ", "");

	<%-- 제목링크 확인 --%>
	if(rowObject.titleLink == null){
		<%-- 디테일 사용여부 확인 --%>
		if("${boardinfo.detailYn}" == "Y"){
			if(secret_yn == "Y" && rowObject.openYn == "Y" ){ // 비밀글 추가
				str += " <img src=\"/images/back/icon/icon_lock.png\" alt=\"비밀글\" /> ";
			}
			<%-- 답글여부 --%>
			if(rowObject.relevelSeq > 0){
				for(var i=0; i<rowObject.relevelSeq; i++){
					str += "<img src=\"/images/back/icon/icon_reply.png\" alt=\"답글\" /> ";
				}
			}
			if("${boardinfo.boardCd}" == "P" || "${boardinfo.boardCd}" == "R" || "${boardinfo.boardCd}" == "I"){
				str += "<a href=\"javascript:contentsEdit('"+rowObject.contId+"')\">"+title+"</a>";
			}
			else {
				str += "<a href=\"javascript:contentsEdit('"+rowObject.contId+"')\">"+title+"</a>";
				<c:if test = "${boardinfo.boardCd eq 'Q' and (boardinfo.boardId eq '51' or boardinfo.boardId eq '20057' ) }">
				
				if(rowObject.replyYn != "Y"){ // 답변대기
					str += " <img src=\"/images/back/icon/icon_txt_01_01.png\" alt=\"답변대기\" /> ";
				}
				if(rowObject.replyYn == "Y" ){ // 답변완료
					str += " <img src=\"/images/back/icon/icon_txt_01_02.png\" alt=\"답변완료\" /> ";
				}
				
				
				</c:if>
			}
			if(reply_status == "Y" && rowObject.replyYn != "Y"){ // 답변대기
				str += " <img src=\"/images/back/icon/icon_txt_01_01.png\" alt=\"답변대기\" /> ";
			}
			if(reply_status == "Y" && rowObject.replyYn == "Y" ){ // 답변완료
				str += " <img src=\"/images/back/icon/icon_txt_01_02.png\" alt=\"답변완료\" /> ";
			}
			if(comment_yn == "Y" && rowObject.commentCnt > 0){
				str += "[<strong class=\"color_pointr\">"+rowObject.commentCnt+"</strong>]";
			}			
		}else{
			str = title;
		}
	}else{
		if("${boardinfo.detailYn}" == "N"){
			if(secret_yn == "Y" && rowObject.openYn == "Y" ){ // 비밀글 추가
				str += " <img src=\"/images/back/icon/icon_lock.png\" alt=\"비밀글\" /> ";
			}
			<%-- 답글여부 --%>
			if(rowObject.relevelSeq > 0){
				for(var i=0; i<rowObject.relevelSeq; i++){
					str += "<img src=\"/images/back/icon/icon_reply.png\" alt=\"답글\" /> ";
				}
			}
			str += "<a href=\"javascript:contentsEdit('"+rowObject.contId+"')\">"+title+"</a>";
			if(reply_status == "Y" && rowObject.replyYn != "Y"){ // 답변대기
				str += " <img src=\"/images/back/icon/icon_txt_01_01.png\" alt=\"답변대기\" /> ";
			}
			if(reply_status == "Y" && rowObject.replyYn == "Y" ){ // 답변완료
				str += " <img src=\"/images/back/icon/icon_txt_01_02.png\" alt=\"답변완료\" /> ";
			}
			if(comment_yn == "Y" && rowObject.commentCnt > 0){
				str += "[<strong class=\"color_pointr\">"+rowObject.commentCnt+"</strong>]";
			}
		}else{
			str = "<a href=\""+rowObject.titleLink+"\"  target=\"_blank\">"+title+"</a>";
		}
	}
	return str;
}

// 썸네일
function jsThumbFormmater(cellvalue, options, rowObject) {
	var str = "";
	var img = "/upload/board/"+rowObject.imageFileNm;
	if(rowObject.imageFileNm != undefined) {
		str = "<img src=\""+img+"\" alt=\"썸네일\" width=\"82\" height=\"100\" />";
	}else{
		str = '<img src="/images/back/common/no_img.png" alt="썸네일" />';
	}
	return str;
}

// 첨부파일
function jsAttachFormmater(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.attachId != undefined) {
		str = '<img src="/images/back/icon/icon_file.png" alt="첨부파일" />';
	}
	return str;
}

</script>

<table id="contents_list"></table>
<div id="contents_pager"></div>