<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<link rel="stylesheet" type="text/css" href="/css/back/style.css" />
<link rel="stylesheet" type="text/css" href="/css/back/default.css" />
<link rel="stylesheet" type="text/css" href="/css/back/common.css" />
<link rel="stylesheet" type="text/css" href="/css/back/table.css" />
<link rel="stylesheet" type="text/css" href="/css/back/layout.css" />
<link rel="stylesheet" type="text/css" href="/css/back/sub.css" />
<link rel="stylesheet" type="text/css" href="/css/back/popup.css" />
<link rel="stylesheet" type="text/css" href="/css/modal.css" />

<form id="writeFrm2" name="writeFrm2" method="post" data-parsley-validate="true" enctype="multipart/form-data">
<input type="hidden" id="coNo" name="coNo" value="${companyMap.refUrl}" />
<input type="hidden" id="useDiv" name="useDiv" value="Y" />
<input type="hidden" id="voluDiv" name="voluDiv" value="Y" />
<input type="hidden" id="korchamName" name="korchamName" value="${SITE.siteNm}" />
<input type="hidden" id="associate" name="associate" value="N" />
				<!-- write_basic -->
			<div class="table_area" style="margin-top:10px;padding-left:10px;padding-right:10px;">
				<table class="write">
					<caption>회사 등록화면</caption>
					<colgroup>
						<col style="width: 150px;" />
						<col style="width: *;" />
						<col style="width: 150px;" />
						<col style="width: *;" />
					</colgroup>
					<tbody>
					<c:if test="${param.mode == 'E'}">
					<tr>
						<th scope="row">코참넷</th>
						<td>
						    ${SITE.siteNm}
						</td>
						<th scope="row">회사코드</th>
						<td>
						    ${companyMap.coNo}
						</td>
					</tr>
					</c:if>
					<!-- 업체 구분 -->
					<tr>
						<th scope="row">회사 구분<span class="asterisk">*</span></th>
						<td>
						     <g:radio id="coDiv" name="coDiv" codeGroup="CO_DIV" cls="text-middle" curValue="${companyMap.coDiv}" />
						</td>

					<!-- 사업자 구분 -->

						<th scope="row">사업자 구분<span class="asterisk">*</span></th>
						<td>
						     <g:select id="compDiv" name="compDiv" codeGroup="COMP_DIV"  titleCode="전체" showTitle="true" cls="in_wp100" curValue="${companyMap.compDiv}"/>
						</td>
					</tr>
					<tr>
						<th scope="row">사업자 등록 번호<span class="asterisk">*</span></th>
						<td>
   						       <input class="in_w100" type="text" id="compRegNo" name="compRegNo" value="${companyMap.compNm}" placeholder="사업자 등록 번호" data-parsley-required="true" data-parsley-maxlength="12" readonly/>
						</td>

						<th scope="row">법인번호<span class="asterisk">*</span></th>
						<td>
   						       <input class="in_w100" type="text" id="corpNo" name="corpNo" value="${companyMap.compNm}" placeholder="법인 번호" data-parsley-required="true" data-parsley-maxlength="14" />
						</td>
					</tr>

					<tr>
						<th scope="row">회사명_한글<span class="asterisk">*</span></th>
						<td>
   						       <input class="in_w100" type="text" id="conameHang" name="conameHang" value="${companyMap.conameHang}" placeholder="회사명_한글" data-parsley-required="true" data-parsley-maxlength="100" />
						</td>

						<th scope="row">회사명_영문</th>
						<td>
					         <input class="in_w100" type="text" id="conameEngl" name="conameEngl" value="${companyMap.conameEngl}" placeholder="회사명_영문"/>
						</td>
					</tr>
					<tr>
						<th scope="row">대표자명_한글<span class="asterisk">*</span></th>
						<td>
   						       <input class="in_w100" type="text" id="repNmHang" name="repNmHang" value="${companyMap.repNmHang}" placeholder="대표자명_한글" data-parsley-required="true" data-parsley-maxlength="100" />
						</td>

						<th scope="row">대표자명_영문</th>
						<td>
					         <input class="in_w100" type="text" id="repNmEngl" name="repNmEngl" value="${companyMap.repNmEngl}"  placeholder="대표자명_영문"  data-parsley-maxlength="100"/>
						</td>
					</tr>
					<tr>
						<th scope="row">전화번호</th>
						<td>
					         <input class="in_w100" type="text" id="tel" name="tel" value="${companyMap.tel}"  placeholder="전화번호" data-parsley-maxlength="15" />
						</td>

						<th scope="row">팩스번호</th>
						<td>
					         <input class="in_w100" type="text" id="fax" name="fax" value="${companyMap.fax}"  placeholder="팩스번호" data-parsley-maxlength="15" />
						</td>
					</tr>
					<tr>
						<th scope="row">취급품목리스트</th>
						<td colspan="3">
					         <textarea class="in_w100" id="majorPrd" name="majorPrd" placeholder="취급품목리스트" rows="2" data-parsley-maxlength="300" >${companyMap.majorPrd}</textarea>
						</td>
					</tr>
					<tr>
						<th scope="row">업종</th>
						<td>
					         <input class="in_w100" type="text" id="bizkind" name="bizkind" value="${companyMap.bizkind}"  placeholder="업종" data-parsley-maxlength="30"/>
						</td>

						<th scope="row">원업종-주취급품목</th>
						<td>
					         <textarea class="in_w100" id="bizkindOrg" name="bizkindOrg" placeholder="원업종-주취급품목" rows="2" data-parsley-maxlength="256" >${companyMap.bizkindOrg}</textarea>
						</td>
					</tr>
					<tr>
						<th scope="row">우편번호</th>
						<td colspan="3">
					         <input class="w50" type="text" id="zipcode" name="zipcode" value="${companyMap.zipcode}"  placeholder="우편번호" data-parsley-maxlength="7" />
						</td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td colspan="3">
					         <input class="in_w100" type="text" id="addr" name="addr" value="${companyMap.addr}"  placeholder="주소"/>
						</td>
					</tr>
					<tr>
						<th scope="row">상세주소</th>
						<td colspan="3">
					         <input class="in_w100" type="text" id="addr2" name="addr2" value="${companyMap.addr2}"  placeholder="상세주소"/>
						</td>
					</tr>
					<tr>
						<th scope="row">도로주소</th>
						<td colspan="3">
					         <input class="in_w100" type="text" id="addr3" name="addr3" value="${companyMap.addr3}"  placeholder="도로주소"/>
						</td>
					</tr>
					<tr>
						<th scope="row">영문주소</th>
						<td colspan="3">
					         <input class="in_w100" type="text" id="englAddr" name="englAddr" value="${companyMap.englAddr}"  placeholder="영문주소"/>
						</td>
					</tr>
					<!-- 지역 코드 -->
					<tr>
						<th scope="row">지역 구분<span class="asterisk">*</span></th>
						<td>
						     <g:select id="regnCode" name="regnCode" codeGroup="REGN_CD"  titleCode="선택" showTitle="true" cls="in_wp100" curValue="${companyMap.regnCode}"/>
						</td>

						<th scope="row">홈페이지</th>
						<td>
					         <input class="in_w100" type="text" id="homepage" name="homepage" value="${companyMap.homepage}"  placeholder="홈페이지" data-parsley-maxlength="100"/>
						</td>
					</tr>
					<tr>
						<th scope="row">납품유통업체</th>
						<td>
					         <input class="in_w100" type="text" id="suplyCo" name="suplyCo" value="${companyMap.suplyCo}"  placeholder="납품유통업체" data-parsley-maxlength="100"/>
						</td>

						<th scope="row">연간매출액</th>
						<td>
					         <input class="in_w100" type="text" id="annSales" name="annSales" value="${companyMap.annSales}"  placeholder="연간매출액" data-parsley-maxlength="20"/>
						</td>
					</tr>
					<tr>
						<th scope="row">업태</th>
						<td>
					         <input class="in_w100" type="text" id="bizType" name="bizType" value="${companyMap.bizType}"  placeholder="업태" data-parsley-maxlength="100"/>
						</td>

						<th scope="row">종목</th>
						<td>
					         <input class="in_w100" type="text" id="item" name="item" value="${companyMap.item}"  placeholder="종목" data-parsley-maxlength="100"/>
						</td>
					</tr>
					<tr>
						<th scope="row">창립일자</th>
						<td>
					         <input class="in_w100" type="text" id="fndDate" name="fndDate" value="${companyMap.fndDate}"  placeholder="창립일자" data-parsley-maxlength="10"/>
						</td>

						<th scope="row">상시종업원수</th>
						<td>
					         <input class="in_w100" type="text" id="empCnt" name="empCnt" value="${companyMap.empCnt}"  placeholder="상시종업원수" data-parsley-maxlength="10"/>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
			<!--// write_basic -->
			<!-- footer -->
			<div id="footer">
			<footer>
				<div class="button_area alignc">
				   	<c:if test="${param.mode == 'W'}">
					<a href="javascript:companyInsert()" class="btn save" title="등록">
						<span>등록</span>
					</a>
				  	</c:if>
                 		<c:if test="${param.mode == 'E' }">
                  		<a href="javascript:companyInsert()" class="btn save" title="수정">
						<span>수정</span>
					</a>
					<a href="javascript:companyDelete()" class="btn save" title="삭제">
						<span>삭제</span>
					</a>
					</c:if>
					<a href="javascript:popClose()" class="btn cancel" title="닫기">
						<span>취소</span>
					</a>
				</div>
			</footer>
			</div>
			<!-- //footer -->
</form>