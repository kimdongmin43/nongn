<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<form id="writeFrm" name="writeFrm" method="post" data-parsley-validate="true">
					<!-- write_basic -->
					<div class="table_area">
						<table class="write">
							<caption>코드구분 등록화면</caption>
							<colgroup>
								<col style="width: 120px;" />
								<col style="width: *;" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">코드구분ID  <span class="asterisk">*</span></th>
								<td>
								    <input class="in_w100" type="text" id="cMstId" name="cMstId" value="${codemaster.mstId}" placeholder="코드구분ID" style="width:100%" data-parsley-required="true" data-parsley-maxlength="50" <c:if test="${!empty codemaster.mstId}">readOnly</c:if>  />
								</td>
							</tr>
							<tr>
								<th scope="row">코드구분명  <span class="asterisk">*</span></th>
								<td>
                                    <input class="in_w100" type="text" id="mstNm" name="mstNm" value="${codemaster.mstNm}" placeholder="코드구분명"  style="width:100%" data-parsley-required="true" data-parsley-maxlength="100" />								
								</td>
							</tr>
							<tr>
								<th scope="row">설명</th>
								<td>
							        <textarea class="in_w100" id="mstDesc" name="mstDesc" placeholder="코드구분설명" rows="3" data-parsley-maxlength="1000" >${codemaster.mstDesc}</textarea>
								</td>
							</tr>
							<tr>
								<th scope="row">사용여부</th>
								<td>
									 <input type="radio" name="useYn" value="Y" <c:if test="${codemaster.useYn == 'Y'}">checked</c:if>> 사용 
									 <input type="radio" name="useYn" value="N"  <c:if test="${codemaster.useYn == 'N'}">checked</c:if>> 미사용 
								</td>
							</tr>
							<c:if test="${param.mode == 'E' }">
							<tr>
								<th scope="row">등록자</th>
								<td>
	                                 ${USER.userNm}
								</td>
							</tr>
							<tr>
								<th scope="row">등록일</th>
								<td>
	                                 ${codemaster.regDt}
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
							<a href="javascript:codemasterInsert()" class="btn save" title="등록">
								<span>등록</span>
							</a>
						  </c:if>
		                  <c:if test="${param.mode == 'E' }">
		                  	<a href="javascript:codemasterInsert()" class="btn save" title="수정">
								<span>수정</span>
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