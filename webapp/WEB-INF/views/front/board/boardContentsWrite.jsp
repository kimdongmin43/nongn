<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.security.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var listUrl = "<c:url value='/front/board/boardContentsListPage.do'/>";
var insertBoardContentsUrl = "<c:url value='/front/board/insertBoardContents.do'/>";
var insertBoardContentsReplyUrl = "<c:url value='/front/board/insertBoardContentsReply.do'/>";
var updateBoardContentsUrl = "<c:url value='/front/board/updateBoardContents.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";
var emaileUrl = "<c:url value='/front/board/insertBoardContentsEmail.do'/>";
var maxNoti = "${boardinfo.noti_num}";
var notiCnt = "${boardinfo.noti_cnt}";

var memId = "${Member.memId}";

//240103 작성 테이블 비밀글 공개/비공개 비밀번호 입력란 활성화
$(document).ready(function(){
	var passwordInput = document.getElementById("password");
	$("input:password[name=password]").attr("disabled",true);
    $("input:radio[name=openYn]").click(function(){
        if($("input[name=openYn]:checked").val() == "Y"){
            $("input:password[name=password]").attr("disabled",true);
            passwordInput.value=null;
        }else if($("input[name=openYn]:checked").val() == "N"){
              $("input:password[name=password]").attr("disabled",false);
              passwordInput.value=null;
        }
    });
});

function fileTransfer(){

	if(!confirm("저장하시겠습니까?")){
		return;
	}

}

function replaceAt(string, index, replace){
	return string.substring(0, index) + replace + string.substring(index+1);
}

function delFile(fileId,attachId,idx){

	if (!confirm("파일을 삭제하시겠습니까?")) {
		return;
	}

	 var data = new Object();
	 var html = "";
	 data.fileId = fileId;
	 data.attachId = attachId;

	$.ajax({
		type: "POST",
		url: "/commonfile/deleteFile.do",
		data :data,
		dataType: 'json',
		success:function(data){
			if(data.success == "true"){
				alert(data.message);
				$("#attach_file").css("display","");
				$("#file_area1").css("display","none");
			} else {
				alert("실패");
			}
		}
	});
}

function checkFile(el){
	
	// files 로 해당 파일 정보 얻기.
	var file = el.files;

	// file[0].size 는 파일 용량 정보입니다.
	if(file[0].size > 1024 * 1024 * 10){
		// 용량 초과시 경고후 해당 파일의 용량도 보여줌
		alert('10MB 이하 파일만 등록할 수 있습니다.\n\n' + '현재파일 용량 : ' + (Math.round(file[0].size / 1024 / 1024 * 100) / 100) + 'MB');
	}

	// 체크를 통과했다면 종료.
	else return;

	// 체크에 걸리면 선택된 내용 취소 처리를 해야함.
	// 파일선택 폼의 내용은 스크립트로 컨트롤 할 수 없습니다.
	// 그래서 그냥 새로 폼을 새로 써주는 방식으로 초기화 합니다.
	// 이렇게 하면 간단 !?
	el.outerHTML = el.outerHTML;
	
}

</script>


<form id="writeFrm" name="writeFrm" method="post" enctype="multipart/form-data">
	<input type='hidden' id="mode" name='mode' value="${param.mode eq '' or param.mode eq null?'W':param.mode}" />
	<input type='hidden' id="board_id" name='boardId' value="${param.boardId}" />
	<input type='hidden' id="menuId" name='menuId' value="${param.menuId}" />
	<input type='hidden' id="contId" name='contId' value="<c:if test="${param.mode eq 'E'}">${contentsinfo.contId }</c:if>" />
	<input type='hidden' id="imgAttachId" name='imgAttachId' value="${contentsinfo.imgAttachId }" />
	<input type='hidden' id="attachId" name='attachId' value="${contentsinfo.attachId }" />
	<input type='hidden' id="refSeq" name='refSeq' value="${contentsinfo.refSeq }" />
	<input type='hidden' id="restepSeq" name='restepSeq' value="${contentsinfo.restepSeq }" />
	<input type='hidden' id="relevelSeq" name='relevelSeq' value="${contentsinfo.relevelSeq }" />
	<!-- <input type='hidden' id="selTab" name='selTab' value="${param.selTab}" />  -->
	<input type='hidden' id="boardCd" name='boardCd' value="${boardinfo.boardCd }" />
	<input type='hidden' id="thumb" name='thumb' value="${boardinfo.thumb }" />
	<input type='hidden' id="btitle" name='btitle' value="${MENU.menuNm}" />
	<div class="content_tit" id="containerContent">
		<h3>${MENU.menuNm}</h3>
	</div>
	<div class="content">
		
		<c:choose>
			<c:when test="${param.boardId eq '20082'}">
			
		<div class="table_area table_wrap scroll">
			
			<ul class="list_type_daopen">
				<li>작성된 정보는 농식품모태펀드 컨설팅지원사업을 위해 활용되며 사업목적에 맞지 않는 글이나 타인에 대한 비방·명예훼손의 글은 삭제될 수 있음을 알려드립니다.</li>
				<li>개인정보보호를 위해 주민등록번호, 전화번호, 이메일 등의 개인정보를 입력하지 마시기 바랍니다.</li>
				<li><span style="color:#f00">(*)</span> 표시항목은 <span style="color:#f00">필수적으로 입력</span>하여야 합니다.</li>
			</ul>
			<table class="tstyle_write" >
				<caption>농식품모태펀드 컨설팅 지원사업 신청 정보를 비밀번호, 경영체명, 대표자명, 사업자 등록번호, 법인 등록번호, 설립연도, 본사 소재지, 전화번호, 팩스,
							  임직원수, 담당자 유선 직통 전화번호, 사업분야, 사업내용, 주생산품목, 매출액, 홈페이지, 투자유치 희망 금액, 사업계획서 파일, 컨설팅 확인서 파일, 자동등록방지 등의 순으로 작성하실 수  있습니다.</caption>
				<colgroup>
					<col style="width:20%" />
					<col style="width:*" />
					<col style="width:*" />
					<col style="width:12%" />
					<col style="width:*" />
					<col style="width:20%" />
					<col style="width:*" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">공개여부</th>
						<td colspan="3">비공개</td>
						<th class="required">* 비밀번호</th>
						<td colspan="2">
							<div class="inpbox"><input type = "password" name="password" id="password" title="비밀번호" data-parsley-required="true"/></div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="required">* 경영체명</th>
						<td colspan="3">
							<div class="inpbox"><input type="text" name="etc1" class="in_w100" value="${contentsinfo.etc1}" data-parsley-required="true" title="경영체명"/></div>
						</td>
						<th class="required">* 대표자명</th>
						<td colspan="2">
							<div class="inpbox"><input type="text" name="etc2" class="in_w100" value="${contentsinfo.etc2}" data-parsley-required="true" title="대표자명" /></div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="required">* 사업자등록번호</th>
						<td colspan="2">
							<div class="inpbox"><input type="text" name="etc3" class="in_w100" value="${contentsinfo.etc3}" data-parsley-required="true"  placeholder="000-00-00000" title="000-00-00000 형식으로 사업자등록번호 입력"/></div>
						</td>
						<th scope="row">법인등록번호</th>
						<td>
							<div class="inpbox"><input type="text" name="etc4" class="in_w100" value="${contentsinfo.etc4}"  title="법인등록번호" /></div>
						</td>
						<th class="required">* 설립연도</th>
						<td>
							<div class="inpbox"><input type="text" name="etc5" class="in_w100" value="${contentsinfo.etc5}"  data-parsley-required="true" title="설립연도" /></div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="required">* 소재지(본사)</th>
						<td colspan="6">
							<div class="inpbox"><input type="text" name="etc6" class="in_w100" value="${contentsinfo.etc6}" data-parsley-required="true"  title="소재지(본사)" /></div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="required">* 전화번호</th>
						<td colspan="2">
							<div class="inpbox"><input type="text" name="etc7" class="in_w100" value="${contentsinfo.etc7}" data-parsley-required="true" title="전화번호" /></div>
						</td>
						<th scope="row">팩스</th>
						<td>
							<div class="inpbox"><input type="text" name="etc8" class="in_w100" value="${contentsinfo.etc8}" title="팩스" /></div>
						</td>
						<th>임직원수</th>
						<td>
							<div class="inpbox"><input type="text" name="etc9" class="in_w100" value="${contentsinfo.etc9}" title="임직원수" /></div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="required">* 담당자 직통전화(유선)</th>
						<td colspan="6">
							<div class="inpbox"><input type="text" name="etc11" class="in_w100" value="${contentsinfo.etc11}" data-parsley-required="true" title="담당자 직통전화(유선)" /></div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="required">* 사업분야</th>
						<td class="usrView" colspan="6">
							
							<div class="inpbox">
								<label for="etc0">농업 &nbsp;/&nbsp;임산&nbsp;/&nbsp;축산&nbsp;/&nbsp;수산&nbsp;/&nbsp;식품제조가공&nbsp;/&nbsp;유통&nbsp;/&nbsp;기타 연관산업</label>
								<input type="text" name="etc0" class="in_w50" value="${contentsinfo.etc0}" data-parsley-required="true"  placeholder="ex)농업/축산/유통" title="농업/임산/축산/수산/식품제조가공/유통/기타 연관산업 중 중복선택 입력"/></div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="required">* 사업내용</th>
						<td colspan="3">
							<div class="inpbox"><input type="text" name="etc13" class="in_w100" value="${contentsinfo.etc13}" data-parsley-required="true" title="사업내용" /></div>
						</td>
						<th class="required">* 주생산품목</th>
						<td colspan="2">
							<div class="inpbox"><input type="text" name="etc14" class="in_w100" value="${contentsinfo.etc14}" data-parsley-required="true" title="주생산품목" /></div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="required">* 매출액</th>
						<th scope="row">’17년</th>
						<td>
							<div class="inpbox">(<input type="text" name="etc15" class="in_w50" value="${contentsinfo.etc15}"  data-parsley-required="true"  title="17년도 매출액"/>)억원</div>
						</td>
						<th>’18년</th>
						<td>
							<div class="inpbox">(<input type="text" name="etc16" class="in_w50" value="${contentsinfo.etc16}"  data-parsley-required="true" title="18년도 매출액" />)억원</div>
						</td>
						<th>’19년</th>
						<td>
							<div class="inpbox">(<input type="text" name="etc17" class="in_w50" value="${contentsinfo.etc17}"  data-parsley-required="true" title="19년도 매출액" />)억원</div>
						</td>
					</tr>
					<tr>
						<th scope="row">홈페이지</th>
						<td colspan="3">
							<div class="inpbox"><input type="text" name="etc18" class="in_w100" value="${contentsinfo.etc18}" title="홈페이지" /></div>
						</td>
						<th class="required">* 투자 유치 <br>&nbsp;&nbsp;희망 금액</th>
						<td colspan="2">
							<div class="inpbox">(<input type="text" name="etc19" class="in_w70" value="${contentsinfo.etc19}" data-parsley-required="true" title="투자 유치 희망 금액"  />)억원</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="required">* 첨부파일 1</th>
						<td  colspan="6">
							<div id="attach_file" style = "<c:if test="${fn:length(fileList) > 0}">display:none</c:if>">
							<div class="file_area">
								사업계획서(형식 및 양식자율) &nbsp;&nbsp;&nbsp;&nbsp;
								<input id="attached_file" name="attached_file" type="file" class="in_wp300"  data-parsley-required="true" onchange="checkFile(this)"
									<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}"></c:if> 
								 title="자율적인 형식 및 양식의 사업계획서 파일 첨부" />
								<div class="fc_red">※ 사업계획서 상에 개인정보를 반드시 삭제하여 제출요망</div>
						</td>	
					</tr>
					<tr>
						<th scope="row" class="required">* 첨부파일2</th>
						<td colspan="3">
							<div id="attached_file" style = "<c:if test="${fn:length(fileList) > 1}">display:none</c:if>">
								<div class="file_area">컨설팅확인서&nbsp;&nbsp;
									<input id="attached_file" name="attached_file" type="file" class="in_wp200"  data-parsley-required="true" onchange="checkFile(this)"
										<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}"></c:if> 
									 title="컨설팅 확인서 파일 첨부" />								
								</div>
								<div class="fc_red">(오른쪽 양식 다운로드 후 작성하여 스캔)</div>
						</div>
						</td>
						<th>양식다운로드</th>
						<td colspan="2">
							<div class="inpbox">
								<a title="컨설팅 확인서 다운받기" class="download" href="/commonfile/fileidDownLoad.do?fileId=2003213489&attachId=ea2b647cfcd64493bbaa511479815f64" target="_blank">컨설팅 확인서.hwp(11776KB)</a>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="required">* 자동등록방지</th>
						<td colspan="6">
							<div class="captcha_area">
								<div class="img"><!-- 2020.10.16 대체/보완 -->
									<img title="보안문자" src="/captchaImg.do" alt="보안문자" id="captchaImg" />
								</div> 
								<div class="ctl">
									<input id="reload" class="refresh" type="button" onclick="javaScript:getImage()" value="새로고침" title="새로 고침"/><br />
									<input id="soundOn" class="listening" type="button" onclick="javaScript:audio()" value="음성듣기" title="음성 듣기"/>
								</div>							 
								<div class="txt">
									<label for="captchaAnswer" class="hidden">보안문자 입력</label>
									<input type="text" name="captchaAnswer" id="captchaAnswer" class="in_w100" title="보안문자 입력" data-parsley-required="true" /><br />
									<span class="tip_txt">※ 좌측에 표시된 보안문자를 입력하세요</span>
									<div id="ccaudio" style="display:none" tabindex="-1"></div>
								</div>
							</div>							
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		</c:when>

			<c:when test="${param.boardId eq '20083'}">
			
				<div class="table_area table_wrap scroll">
				
					<ul class="list_type_daopen">
						<li>작성된 정보는 농식품 크라우드펀딩 지원사업을 위해 활용되며 사업목적에 맞지 않는 글이나 타인에 대한 비방·명예훼손의 글은 삭제될 수 있음을 알려드립니다.</li>
						<li>개인정보보호를 위해 주민등록번호, 전화번호, 이메일 등의 개인정보를 입력하지 마시기 바랍니다.</li>
						<li>지원사업의 세부운영지침 및 작성 예시는 지원사업 자료실을 참고해주시길 바랍니다.</li>
						<li><span style="color:#f00">(*)</span> 표시항목은 <span style="color:#f00">필수적으로 입력</span>하여야 합니다.</li>
					</ul>
					<table class="tstyle_write">
						<caption>농식품 크라우드펀딩 지원사업 신청 정보를 비밀번호, 경영체명, 사업자 등록번호, 법인 등록번호, 설립연도, 본사 소재지, 전화번호, 팩스, 직원수, 담당자 성명, 담당자 직통 전화번호, 사업분야, 사업내용, 
									 주생산품목, 펀딩 품목, 펀딩 유형, 홈페이지, 자동등록방지 등의 순으로 작성하실 수 있습니다.</caption>
						<colgroup>
							<col style="width:15%" />
							<col style="width:15%" />
							<col style="width:10%" />
							<col style="width:15%" />
							<col style="width:20%" />
							<col style="width:10%" />
							<col style="width:15%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">공개여부</th>
								<td colspan="3">비공개</td>
								<th class="required">* 비밀번호</th>
								<td colspan="2">
									<div class="inpbox"><input type = "password" name="password" id="password" title="비밀번호"  data-parsley-required="true" /></div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="required">* 경영체명</th>
								<td colspan="3">
									<div class="inpbox"><input type="text" name="etc1" class="in_w100" value="${contentsinfo.etc1}" data-parsley-required="true"  title="경영체명" /></div>
								</td>
								<th class="required">* 대표자명</th>
								<td colspan="2">
									<div class="inpbox"><input type="text" name="etc2" class="in_w100" value="${contentsinfo.etc2}" data-parsley-required="true"  title="대표자명" /></div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="required">* 사업자등록번호</th>
								<td colspan="2">
									<div class="inpbox"><input type="text" name="etc3" class="in_w100" value="${contentsinfo.etc3}" data-parsley-required="true"  placeholder="000-00-00000" title="000-00-00000 형식으로 사업자등록번호 입력" /></div>
								</td>
								<th scope="row">법인등록번호</th>
								<td>
									<div class="inpbox"><input type="text" name="etc4" class="in_w100" value="${contentsinfo.etc4}"  title="법인등록번호"  /></div>
								</td>
								<th class="required">* 설립연도</th>
								<td>
									<div class="inpbox"><input type="text" name="etc5" class="in_w100" value="${contentsinfo.etc5}"  data-parsley-required="true"  title="설립연도" /></div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="required">* 소재지(본사)</th>
								<td colspan="6">
									<div class="inpbox"><input type="text" name="etc6" class="in_w100" value="${contentsinfo.etc6}" data-parsley-required="true"  title="소재지(본사)"  /></div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="required">* 전화번호</th>
								<td colspan="2">
									<div class="inpbox"><input type="text" name="etc7" class="in_w100" value="${contentsinfo.etc7}" data-parsley-required="true"  title="전화번호" /></div>
								</td>
								<th scope="row">팩스</th>
								<td>
									<div class="inpbox"><input type="text" name="etc8" class="in_w100" value="${contentsinfo.etc8}" title="팩스"  /></div>
								</td>
								<th>직원수</th>
								<td>
									<div class="inpbox"><input type="text" name="etc9" class="in_w100" value="${contentsinfo.etc9}" title="직원수"  /></div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="required">담당자</th>
								<th scope="row" class="required">* 성명</th>
								<td colspan="2">
									<div class="inpbox"><input type="text" name="etc10" class="in_w100" value="${contentsinfo.etc10}" data-parsley-required="true"  title="담당자 성명" /></div>
								</td>
								<th scope="row" class="required">* 직통전화</th>
								<td colspan="2">
									<div class="inpbox"><input type="text" name="etc11" class="in_w100" value="${contentsinfo.etc11}" data-parsley-required="true" title="담당자 직통전화"  /></div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="required">* 사업분야</th>
								<td class="usrView" colspan="6">
									<input type="checkbox" id="item01" name="items01" value="1" onclick=""/><label for="item01">농업</label>
									&nbsp;&nbsp;&nbsp;
									<input type="checkbox" id="item02" name="items01" value="2" onclick="" /><label for="item02">임산</label>
									&nbsp;&nbsp;&nbsp;
									<input type="checkbox" id="item03"  name="items01" value="3" onclick=""/><label for="item03">축산</label>
									&nbsp;&nbsp;&nbsp;
									<input type="checkbox" id="item04" name="items01" value="4" onclick="" /><label for="item04">식품제조가공</label>
									&nbsp;&nbsp;&nbsp;
									<input type="checkbox" id="item05" name="items01" value="5" onclick="" /><label for="item05">유통</label>
									&nbsp;&nbsp;&nbsp;
									<input type="checkbox" id="item06" name="items01" value="6" onclick=""/><label for="item06">기타 연관산업</label>
								</td>
							</tr>
							<tr>
								<th scope="row" class="required">* 사업내용</th>
								<td>
									<div class="inpbox"><input type="text" name="etc13" class="in_w100" value="${contentsinfo.etc13}" data-parsley-required="true" title="사업내용"  /></div>
								</td>
								<th>주생산품목</th>
								<td>
									<div class="inpbox"><input type="text" name="etc14" class="in_w100" value="${contentsinfo.etc14}"  title="주생산품목" /></div>
								</td>
								<th class="required">* 펀딩 품목</th>
								<td colspan="2">
									<div class="inpbox"><input type="text" name="etc15" class="in_w100" value="${contentsinfo.etc15}"  title="펀딩 품목" /></div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="required">* 펀딩유형</th>
								<td class="usrView" colspan="6">
									<input type="checkbox" id="item07" name="items02" value="1" onclick=""/><label for="item07">후원형</label>
									&nbsp;&nbsp;&nbsp;
									<input type="checkbox" id="item08" name="items02" value="2" onclick="" /><label for="item08">증권형</label>
								</td>
							</tr>
							<tr>
								<th scope="row">홈페이지</th>
								<td colspan="6">
									<div class="inpbox"><input type="text" name="etc16" class="in_w100" value="${contentsinfo.etc18}" title="홈페이지" /></div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="required">* 자동등록방지</th>
								<td colspan="6">
									<div class="captcha_area">
										<div class="img"><!-- 2020.10.16 대체/보완 -->
											<img title="보안문자" src="/captchaImg.do" alt="보안문자" id="captchaImg" />
										</div> 
										<div class="ctl">
											<input id="reload" class="refresh" type="button" onclick="javaScript:getImage()" value="새로고침" title="새로 고침"/><br />
											<input id="soundOn" class="listening" type="button" onclick="javaScript:audio()" value="음성듣기" title="음성 듣기"/>
										</div>							 
										<div class="txt">
											<label for="captchaAnswer" class="hidden">보안문자 입력</label>
											<input type="text2" name="captchaAnswer" id="captchaAnswer" class="in_w100" title="보안문자 입력" data-parsley-required="true" /><br />
											<span class="tip_txt">※ 좌측에 표시된 보안문자를 입력하세요</span>
											<div id="ccaudio" style="display:none" tabindex="-1"></div>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</c:when>
		
		<c:otherwise>
		<div class="table_area table_wrap scroll">
			<div class="board_top_info">
				<p>타인에 대한 비방이나 명예훼손에 관한 글은 삭제될 수 있음을 알려드립니다.<br />
				개인정보보호를 위해 주민등록번호, 전화번호, 이메일 등의 개인정보를 제목 및 게시내용에 절대 입력하지 마시기 바랍니다.<br />
				<span class="required">(*)</span> 표시항목은 <span class="required">필수적으로 입력</span>하여야 합니다.</p>
			</div>
			<table class="tstyle_write">
				<caption>
				<c:choose>
					<c:when test="${param.boardId eq '51'}">질의응답(Q&A) 정보를 구분, 제목, 작성자, 공개여부, 자동등록방지, 비밀번호, 내용 등의 순으로 작성하실 수 있습니다.</c:when>
					<c:when test="${param.boardId eq '20057'}">농림수산식품모태펀드 상담신청 정보를 제목, 경영체명, 대표번호,기업형태, 자본금, 주소(본사), 주요제품, 전년도매출액, 공개여부, 자동등록방지, 비밀번호, 내용 등의 순으로 작성하실 수 있습니다.</c:when>
					<c:when test="${param.boardId eq '20062'}">고객제안 정보를 제목, 공개여부, 자동등록방지, 비밀번호, 내용 등의 순으로 작성하실 수 있습니다.</c:when>
					<c:when test="${param.boardId eq '20072'}">부정부패 신고마당 등록 표로 제목, 첨부파일, 자동등록방지, 비밀번호, 내용을 작성하실 수 있습니다.</c:when>
					<c:when test="${param.boardId eq '20075'}">농림수산정책자금 부당사용 신고센터 등록 표로 제목, 첨부파일, 작성자, 자동등록방지, 비밀번호, 내용을 작성하실 수 있습니다.</c:when>
					<c:otherwise>${MENU.menuNm} 게시물 정보를 작성하실 수 있습니다..</c:otherwise>
				</c:choose>
				</caption>
				<colgroup>
					<col width="20%" />
					<col />
					<col width="20%" />
					<col />
				</colgroup>
				<tbody>
				
				<tr>
					<c:if test="${param.boardId eq '51'}">
						<th scope="row" class="required">* 구분</th>
						<td>
						<div class="inpbox">
						<select class = "in_w26" id = "etc0" name ="etc0" title="구분" data-parsley-required="true">
							<option value = "" selected>구분 선택</option>
							<option value = "1" >농림수산식품모태펀드</option>
							<option value = "3" >농업정책보험</option>
							<option value = "7" >양식수산물재해보험</option><!-- 2021.07.14 -->
							<option value = "4" >손해평가사</option>
							<option value = "5" >농림수산정책자금 검사</option>
							<option value = "6" >농특회계 융자금 관리</option>
							<option value = "9" >기타</option>
						</select>
						</div>
					</c:if>
					<c:if test="${param.boardId eq '51'}">	
						<th scope="row">공개여부</th>
							<td>
								<input id="openY" name="openYn" value="Y" type="radio" class="radio" checked />
								&nbsp;<label for="openY">공개</label>&nbsp;&nbsp;
								<input id="openN" name="openYn" value="N" type="radio" class="radio" />
								&nbsp;<label for="openN">비공개</label>
						</td>
					</c:if>
				</tr>
				
					<tr>
						<th scope="row" class="required">* 제목</th>
						<td colspan="3">
							<div class="inpbox">
								<input type="text" id="title" name="title" class="in_w100" value="${contentsinfo.title}"  data-parsley-required="true" style="ime-mode:active;" title="제목"/>
								<span class="tip_txt">※ 작성 내용을 잘 나타낼 수 있는 단어를 사용하세요. 한글 120자, 영문 240자 이하로 입력하셔야 합니다.</span>
							</div>
						</td>
					</tr>
					<c:if test="${param.boardId eq '20062'}">
						<th scope="row">공개여부</th>
							<td colspan="3">
								<input id="openY" name="openYn" value="Y" type="radio" class="radio" checked />
								&nbsp;<label for="openY">공개</label>&nbsp;&nbsp;
								<input id="openN" name="openYn" value="N" type="radio" class="radio" />
								&nbsp;<label for="openN">비공개</label>
						</td>
					</c:if>
					<c:if test="${param.boardId eq '20057'}">
					<tr>
						<th scope="row" class="required">* 경영체명</th>
						<td>
							<div class="inpbox"><input type="text" name="etc1" class="in_w50" value="${contentsinfo.etc1}" data-parsley-required="true" title="경영체명" /></div>
						</td>
						<th scope="row" class="required">* 대표번호<br>&nbsp;(휴대전화번호 입력금지)</th>
						<td>
							<div class="inpbox"><input type="text"  name="etc2" class="in_w50" value="${contentsinfo.etc2}" data-parsley-required="true" title="휴대전화번호가 아닌 대표번호" /></div>
						</td>
					</tr>
					<tr>
						<th scope="row">기업형태</th>
						<td>
							<div class="inpbox">
								<select name="etc3" class="in_w50" title="기업형태">
									<option value="개인">개인</option>
									<option value="농어업법인">농어업법인</option>
									<option value="일반법인">일반법인</option>
								</select>
							</div>
						</td>
						<th scope="row">자본금</th>
						<td>
							<div class="inpbox"><input type="text" name="etc4" class="in_w50" value="${contentsinfo.etc4}"  data-parsley-type="integer"  title="백만원 단위의 자본금"/>백만원</div>
						</td>
					</tr>
					<tr>
						<th scope="row">주소(본사)</th>
						<td colspan="3"><div class="inpbox"><input type="text" name="etc5" class="in_w50" value="${contentsinfo.etc5}" title="주소(본사)"/></div></td>
					</tr>
					<tr>
						<th scope="row">주요제품</th>
						<td>
							<div class="inpbox"><input type="text" name="etc6" class="in_w50" value="${contentsinfo.etc6}" title="주요제품" /></div>
						</td>
						<th scope="row">전년도매출액</th>
						<td>
							<div class="inpbox"><input type="text" name="etc7" class="in_w50" value="${contentsinfo.etc7}"  data-parsley-type="integer" title="백만원 단위의 전년도매출액"/>백만원</div>
						</td>
					</tr>
					</c:if>

					<!--  2019.04.05 개인정보 처리 지적 후속 조치1 : 이 주석이 반복되고 있음-->
					<c:forEach var="itemFront" items="${viewSortList}" varStatus="status">
					 					
					<c:if test="${itemFront.iUser eq '1' and itemFront.iUse eq 'reg_mem_nm'}">					
					<tr>
						<th scope="row">작성자</th>
						<td colspan="3">
							<div class="inpbox">
								<input type="text" id="regMemNm" name="regMemNm" class="in_w100" value="${sName}" readonly title="작성자" />
								<!-- 240202 본인인증 우회 취약점 조치를 위한 SAFE_WRITER_NAME 값 저장 인증 강화 테스트 -->
<!-- 								<input type="text" id="regMemNm" name="regMemNm" class="in_w100" value="test" readonly title="작성자" /> -->
								<!-- 240202 본인인증 우회 취약점 조치를 위한 SAFE_WRITER_NAME 값 저장 인증 강화 테스트 끝-->
								<span class="tip_txt">※ 작성자 이름은 본인 인증 후 자동으로 입력됩니다.(수정 불가)</span>
							</div>
						</td>
					</tr>
					</c:if>
					
					<c:if test="${itemFront.iUser eq '1' and itemFront.iUse eq 'attach'}">
					<tr>
						<th scope="row">첨부파일</th>
						<td colspan="3">
						<div id="attach_file" style = "<c:if test="${fn:length(fileList) > 0}">display:none</c:if>">
							<div class="file_area">
								<label for="attached_file" class="hidden" style="display:none;">파일 선택하기</label>
								<input id="attached_file" name="attached_file" type="file" class="in_w100" onchange="checkFile(this)"
									<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}">data-parsley-required="true"</c:if>
								/><br />
								<span class="tip_txt">※ 10MB 이하 파일만 등록할 수 있습니다.</span>
							</div>
						</div>
						<c:if test="${param.mode eq 'E' and fn:length(fileList) > 0 }">
						<div class="file_area" id="file_area1">
							<ul class="file_list">
								<c:forEach items="${fileList}" var="list">
								<li>
									<a href="/commonfile/fileidDownLoad.do?fileId=${list.fileId}&attachId=${list.attachId}"  target="_blank" class="download" title="다운받기">
										${list.originFileNm }(${list.fileSize}KB)
									</a>
									<a href='javascript:delFile("${list.fileId}","${list.attachId}");' class="btn_file_delete" data-file_id="${list.file_id}" title="파일 삭제">
										<img src="/images/back/icon/icon_delete.png" alt="삭제" />
									</a>
								</li>
								</c:forEach>
							</ul> 
						</div>
						</c:if>
						</td>
					</tr>
					</c:if>		<!-- ===== 아래에서 "내용" 항목을 만드는 듯 : 강철구 -->
					<c:if test="${itemFront.iUser eq '1' and itemFront.iUse ne 'title' and itemFront.iUse ne 'reg_mem_nm' and itemFront.iUse ne 'contents' and itemFront.iUse ne 'attach'  and itemFront.iUse ne 'reg_dt'}">
					<c:set var="inputName" value="${itemFront.iUse}" />
					<c:if test="${itemFront.iUse eq 'organization'}"><c:set var="inputName" value="source" /></c:if>
					<tr>
						<th scope="row">${itemFront.iOut}</th>
						<td colspan="3">
							<div class="inpbox"><input type="text"  title="${itemFront.iOut}" name="${inputName}" class="in_w50" value="${contentsinfo[itemFront.iUse]}" <c:if test="${fn:indexOf(boardinfo.itemRequired, itemFront.iUse) != -1}">data-parsley-required="true"</c:if> /></div>
						</td>
					</tr>
					</c:if>
					</c:forEach>
					<c:if test="${boardinfo.boardCd eq 'Q' and  !(boardinfo.boardId eq '20075' or boardinfo.boardId eq '20072' )}">
<!-- 					<tr> -->
<!-- 						<th scope="row">공개여부</th> -->
<!-- 						<td colspan="3"> -->
<!-- 							<input id="openY" name="openYn" value="Y" type="radio" class="radio" checked /> -->
<!-- 							&nbsp;<label for="openY">공개</label>&nbsp;&nbsp; -->
<!-- 							<input id="openN" name="openYn" value="N" type="radio" class="radio" /> -->
<!-- 							&nbsp;<label for="openN">비공개</label> -->
<!-- 						</td> -->
<!-- 					</tr> -->
					</c:if>
					
<!-- 					<tr> -->
<!-- 						<th scope="row" class="required">* 자동등록방지</th> -->
<!-- 						<td colspan="3"> -->
<!-- 							<div class="captcha_area"> -->
<!-- 								<div class="img">2020.10.16 대체/보완 -->
<!-- 									<img title="보안문자" src="/captchaImg.do" alt="보안문자" id="captchaImg" /> -->
<!-- 								</div>  -->
<!-- 								<div class="ctl"> -->
<!-- 									<input id="reload" class="refresh" type="button" onclick="javaScript:getImage()" value="새로고침" title="새로 고침"/><br /> -->
<!-- 									<input id="soundOn" class="listening" type="button" onclick="javaScript:audio()" value="음성듣기" title="음성 듣기"/> -->
<!-- 								</div>							  -->
<!-- 								<div class="txt"> -->
<!-- 									<label for="captchaAnswer" class="hidden">보안문자 입력</label> -->
<!-- 									<input type="text" name="captchaAnswer" id="captchaAnswer" class="in_w100" title="보안문자 입력" data-parsley-required="true" /><br /> -->
<!-- 									<span class="tip_txt">※ 좌측에 표시된 보안문자를 입력하세요</span> -->
<!-- 									<div id="ccaudio" style="display:none" tabindex="-1"></div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</td> -->
<!-- 					</tr> -->
					<!--  2019.04.05 개인정보 처리 지적 후속 조치 -->
					<tr>
						<th scope="row">비밀번호</th>
						<td colspan="3">
							<input type="password" name="password" id="password" title="비밀번호" class="in_w100" /><br />
							<span class="tip_txt">※ 비밀번호는 타인에게 노출되지 않게 주의하시고 대/소영문자, 숫자 등을 조합하여 입력하세요.</span>
						</td>
					</tr>
					<!--  비밀번호 입력란 등록 -->
					<tr>
						<th scope="row" class="required">* 내용</th>
						<td colspan="3" class="td_p">
							<span class="tip_txt">※ 내용 작성에 제한은 없습니다.</span>
							<textarea id="contents" name="contents" class="in_w100" style = "height: 300px;ime-mode:active;" data-parsley-required="true" title="내용">${contentsinfo.contents}</textarea>
						</td>
					</tr>
					<tr>
						<th scope="row" class="required">* 자동등록방지</th>
						<td colspan="3">
							<div class="captcha_area">
								<div class="img"><!-- 2020.10.16 대체/보완 -->
									<img title="보안문자" src="/captchaImg.do" alt="보안문자" id="captchaImg" />
								</div> 
								<div class="ctl">
									<input id="reload" class="refresh" type="button" onclick="javaScript:getImage()" value="새로고침" title="새로 고침"/><br />
									<input id="soundOn" class="listening" type="button" onclick="javaScript:audio()" value="음성듣기" title="음성 듣기"/>
								</div>							 
								<div class="txt">
									<label for="captchaAnswer" class="hidden">보안문자 입력</label>
									<input type="text" name="captchaAnswer" id="captchaAnswer" class="in_w100" title="보안문자 입력" data-parsley-required="true" /><br />
									<span class="tip_txt">※ 좌측에 표시된 보안문자를 입력하세요</span>
									<div id="ccaudio" style="display:none" tabindex="-1"></div>
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		</c:otherwise>
		
		</c:choose>
		<p class="btn_area btn_board">
			<a href="#none" class="btn_list_cancel_submit">취소</a>
			<a href="#none" class="btn_edit_submit">저장</a>
		</p>
		<!--//E: Q&A글쓰기 -->
	</div>
</form>

<script src="/js/apfs/board.js"></script>
<script>
	//	보안문자 이미지 리프레시/음성출력 시작
	function audio(){ 
		event.preventDefault();
		
		var rand = Math.random(); 
		var uAgent = navigator.userAgent; 
		var soundUrl = '${ctx}/captchaAudio.do?rand='+rand; 
		if(uAgent.indexOf('Trident')>-1 || uAgent.indexOf('MISE')>-1){    /*IE 경우 */ 
			audioPlayer(soundUrl); 
		} else if(!!document.createElement('audio').canPlayType){ 		/*Chrome 경우 */ 
			try { 
				new Audio(soundUrl).play(); 
			} catch (e) { 
				audioPlayer(soundUrl); 
			} 
		} else { 
			window.open(soundUrl,'','width=1,height=1'); 
		} 
	} 
	
	function getImage(){ 
		event.preventDefault();
	
		var rand = Math.random(); 
		var url = '${ctx}/captchaImg.do?rand='+rand;
		$('#captchaImg').attr('src', url); 
	} 
	
	function audioPlayer(objUrl){ 
		var htmlString = '<object type="audio/x-wav" data="' + objUrl 
			+ '" width="0" height="0"><param name="src" value="' 
			+ objUrl +'"/><param name="autostart" value="true" /><param name="controller" value="false" /></object>';
		document.getElementById('ccaudio').innerHTML = htmlString;
		
		document.getElementById('captchaAnswer').focus();
	}
	//	보안문자 이미지 리프레시/음성출력 끝

	$(document).ready(function(){		//	웹 품질 진단 조치 - 2021.04.30
		var strTitleText = $("#txtTitle").text();
		$("#txtTitle").text(strTitleText + " 등록하기");
	});
</script>