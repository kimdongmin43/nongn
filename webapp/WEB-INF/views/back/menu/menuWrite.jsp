<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<form id="writeFrm" name="writeFrm" method="post" data-parsley-validate="true" enctype="multipart/form-data">
<input type="hidden" id="refUrl" name="refUrl" value="${menu.refUrl}" />
<input type="hidden" name="mainMenuId" id="mainMenuId" value="${menu.menuId}" />
<input type="hidden" id="originMenuNm" name="originMenuNm" value="${menu.menuNm}"/>


				<!-- write_basic -->
			<div class="table_area" style="margin-top:10px;padding-left:10px;padding-right:10px;">
				<table class="write">
					<caption>메뉴 등록화면</caption>
					<colgroup>
						<col style="width: 120px;" />
						<col style="width: *;" />
					</colgroup>
					<tbody>
					<c:if test="${param.mode == 'E'}">
					<tr style="display:none;">
						<th scope="row">메뉴코드</th>
						<td>
						    ${menu.menuId}
						</td>
					</tr>
					</c:if>

					<!-- 메뉴형태 -->
					<tr>
						<th scope="row">메뉴형태 <span class="asterisk">*</span></th>
						<td>
						     <g:radio id="refCd" name="refCd" codeGroup="REF_CD" cls="text-middle" curValue="${menu.refCd}"  onChange="changeMenuType()" />
						</td>
					</tr>
					<tr id="refCd_F" style="display:<c:if test="${menu.refCd != 'F'}">none</c:if>">
						<th scope="row">참조메뉴</th>
						<td>
							<input class="w100" type="text" id="refMenuNm" name="refMenuNm" value="${menu.refMenuNm}" placeholder="메뉴명" readonly/>
							<input type="hidden" id="refMenuId" name="refMenuId" value="${menu.refMenuId}" />
							<a href="javascript:menuPopup('F')" class="btn acti" title="선택">
								<span>선택</span>
							</a>
							<input class="in_w100" type="text" name="url" value="<c:if test="${menu.refCd eq 'F'}">${menu.refUrl}</c:if>" placeholder="메뉴 선택시 보여질 하위메뉴를 선택" data-parsley-required="false" data-parsley-maxlength="100" readonly style="display:none;" />
						</td>
					</tr>
					<tr id="refCd_C" style="display:<c:if test="${menu.refCd != 'C'}">none</c:if>">
						<th scope="row">콘텐츠</th>
						<td>
							<input class="w100" type="text" id="refContNm" name="refContNm" value="${menu.refContNm}" placeholder="콘텐츠명" readonly/>
							<input type="hidden" id="refContId" name="refContId" value="${menu.refContId}" />
							<a href="javascript:menuPopup('C')" class="btn acti" title="선택">
								<span>선택</span>
							</a>
							<input class="in_w100" type="text" name="url" value="<c:if test="${menu.refCd eq 'C'}">${menu.refUrl}</c:if>" placeholder="콘텐츠 선택" data-parsley-required="false" data-parsley-maxlength="100" readonly  style="display:none;" />
						</td>
					</tr>
					<tr id="refCd_B" style="display:<c:if test="${menu.refCd != 'B'}">none</c:if>">
						<th scope="row">게시판</th>
						<td>
							<input class="w100" type="text" id="refBoardNm" name="refBoardNm" value="${menu.refBoardNm}"placeholder="게시판명" readonly/>
							<input type="hidden" id="refBoardId" name="refBoardId" value="${menu.refBoardId}" />
							<a href="javascript:menuPopup('B')"class="btn acti" title="선택">
								<span>선택</span>
							</a>
							 <input class="in_w100" type="text" name="url" value="<c:if test="${menu.refCd eq 'B'}">${menu.refUrl}</c:if>" placeholder="게시판 선택" data-parsley-required="false" data-parsley-maxlength="100" readonly style="display:none;" />
						</td>
					</tr>
					<tr id="refCd_K" style="display:<c:if test="${menu.refCd != 'K'}">none</c:if>">
						<th scope="row">게시판</th>
						<td>
							<input class="w100" type="text" id="refKorBoardNm" name="refKorBoardNm" value="${menu.refBoardNm}"placeholder="게시판명" readonly/>
							<input type="hidden" id="refKorBoardId" name="refKorBoardId" value="${menu.refBoardId}" />
							<a href="javascript:menuPopup('K')"class="btn acti" title="선택">
								<span>선택</span>
							</a>
							 <input class="in_w100" type="text" name="url" value="<c:if test="${menu.refCd eq 'K'}">${menu.refUrl}</c:if>" placeholder="게시판 선택" data-parsley-required="false" data-parsley-maxlength="100" readonly style="display:none;" />
						</td>
					</tr>
					<%-- <tr id="refCd_K" style="display:<c:if test="${menu.refCd != 'K'}">none</c:if>">
						<th scope="row">게시판</th>
						<td>
							<input class="w100" type="text" id="refKorBoardNm" name="refKorBoardNm" value="${menu.refBoardNm}"placeholder="게시판명" readonly/>
							<input type="hidden" id="refKorBoardId" name="refKorBoardId" value="${menu.refBoardId}" />
							<a href="javascript:menuPopup('K')"class="btn acti" title="선택">
								<span>선택</span>
							</a>
							 <input class="in_w100" type="text" name="rl" value="<c:if test="${menu.refCd eq 'K'}">${menu.refUrl}</c:if>" placeholder="게시판 선택" data-parsley-required="false" data-parsley-maxlength="100" readonly style="display:none;" />
						</td>
					</tr> --%>
					<tr id="refCd_P" style="display:<c:if test="${menu.refCd != 'P'}">none</c:if>">
						<th scope="row">프로그램</th>
						<td>
							 <input class="in_w100" type="text" name="url" value="<c:if test="${menu.refCd eq 'P'}">${menu.refUrl}</c:if>" placeholder="http://xxx.xxx.xxx 제외" data-parsley-required="false" data-parsley-maxlength="100" />
						</td>
					</tr>
					<tr id="refCd_L" style="display:<c:if test="${menu.refCd != 'L'}">none</c:if>">
						<th scope="row">URL</th>
						<td>
							 <input class="in_w100" type="text" name="url" value="<c:if test="${menu.refCd eq 'L'}">${menu.refUrl}</c:if>" data-parsley-required="false" data-parsley-maxlength="200"  />
						</td>
					</tr>
					<tr>
						<th scope="row">메뉴명  <span class="asterisk">*</span></th>
						<td>
							 <c:set var="menuNavi" value="${fn:split(menu.menuNavi2, '>')}" />
 							<span id="menuNavi_W" style="font-weight:bold;"> ${fn:replace(fn:replace(menu.menuNavi2,menuNavi[fn:length(menuNavi)-1],''),'>',' > ')}</span><input class="w100" type="text" id="menuNm" name="menuNm" value="${menu.menuNm}" placeholder="메뉴명" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">메뉴설명</th>
						<td>
					         <textarea class="in_w100" id="menuDesc" name="menuDesc" placeholder="메뉴설명" rows="4" data-parsley-maxlength="1000" >${menu.menuDesc}</textarea>
						</td>
					</tr>
					<!--// 메뉴형태 -->
					<tr style="display:none;">
						<th scope="row">GNB 사용여부</th>
						<td>
						     <input type="radio" name="gnbYn" value="Y"  checked> 사용 <input type="radio" name="gnbYn" value="N"> 미사용
						</td>
					</tr>
					<tr style="display:none;">
						<th scope="row">사이트맵 사용여부</th>
						<td>
						     <input type="radio" name="sitemapYn" value="Y" checked> 사용 <input type="radio" name="gnbYn" value="N"> 미사용
						</td>
					</tr>
					<c:if test="${param.siteCd eq 'F'}">
					<tr style="display:none;">
						<th scope="row">로그인여부</th>
						<td>
						     <input type="radio" name="loginYn" value="Y" <c:if test="${menu.loginYn eq 'Y' or menu.loginYn eq 'N'}">checked</c:if>> 사용 <input type="radio" name="loginYn" value="N"  <c:if test="${menu.loginYn == 'N'}">checked</c:if>> 미사용
						</td>
					</tr>
					</c:if>
					<c:if test="${param.siteCd eq 'B'}">
					       <input type="hidden" name="loginYn" value="Y" />
					</c:if>
					<tr name="refCd_L" style="display:<c:if test="${menu.refCd != 'L'}">none</c:if>">
						<th scope="row">타겟설정</th>
						<td>
						     <g:radio id="targetCd" name="targetCd" codeGroup="TARGET_CD" cls="text-middle" curValue="${menu.targetCd ne ''?menu.targetCd:'_self'}" onChange="changeTargetSet()" />
						</td>
					</tr>
					<tr id="popup_field" style="display:<c:if test="${menu.targetCd != '3'}">none</c:if>">
						<th scope="row">팝업크기  <span class="asterisk">*</span></th>
						<td>
						     가로 <input class="form-control onlynum" type="text" id="width" name="width" value="${menu.width}" placeholder="팝업크기 가로" data-parsley-type="number" style="width:50px"/> X
							 세로 <input class="form-control onlynum" type="text" id="height" name="height" value="${menu.height}" placeholder="팝업크기 세로" data-parsley-type="number" style="width:50px"/>
						</td>
					</tr>
					<tr id="popup_field" style="display:<c:if test="${menu.targetCd != '3'}">none</c:if>">
						<th scope="row">팝업위치  <span class="asterisk">*</span></th>
						<td>
			    			Top <input class="form-control onlynum" type="text" id="top" name="top" value="${menu.top}" placeholder="팝업위치 Top" style="width:50px"/> X
							 Left <input class="form-control onlynum" type="text" id="left" name="left" value="${menu.left}" placeholder="팝업위치 Left" style="width:50px"/>
						</td>
					</tr>
					<tr>
						<th scope="row">사용여부</th>
						<td>
 						   <input type="radio" name="useYn" value="Y" <c:if test="${menu.useYn eq 'Y' or menu.useYn eq null}">checked</c:if>> 사용 <input type="radio" name="useYn" value="N"  <c:if test="${menu.useYn eq 'N'}">checked</c:if>> 미사용
						</td>
					</tr>
					<tr>
						<th scope="row">번호</th>
						<td>
 						   <input type="text" name="sort" value="${empty menu.sort or menu.sort eq ''?'0':menu.sort}" />
						</td>
					</tr>
					<c:if test="${param.siteCd eq 'B'}">
					<tr>
						<th scope="row">접근제한</th>
						<td>
 						   <g:select id="userCd" name="userCd"  codeGroup="USER_CD" selected="${menu.userCd}" cls="in_wp100" titleCode="제한없음" showTitle="true"/> 이상 접근 허용
						</td>
					</tr>
					</c:if>
					</tbody>
				</table>
			</div>
			<!--// write_basic -->
			<!-- footer -->
			<div id="footer">
			<footer>
				<div class="button_area alignc">
				   <c:if test="${param.mode == 'W'}">
					<a href="javascript:menuInsert()" class="btn save" title="등록">
						<span>등록</span>
					</a>
				  </c:if>
                  <c:if test="${param.mode == 'E' }">
                  	<a href="javascript:menuInsert()" class="btn save" title="수정">
						<span>수정</span>
					</a>
					<a href="javascript:menuDelete()" class="btn save" title="삭제">
						<span>삭제</span>
					</a>
					</c:if>
					<a href="javascript:popupClose()" class="btn cancel" title="닫기">
						<span>취소</span>
					</a>
				</div>
			</footer>
			</div>
			<!-- //footer -->
		</form>