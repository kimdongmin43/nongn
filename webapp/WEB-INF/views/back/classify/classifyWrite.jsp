<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
   <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">	
      <input type="hidden" id="up_classify_id" name="up_classify_id" value="${classify.up_classify_id}" />
 
			<!-- write_basic -->
			<div class="table_area" style="margin-top:10px;padding-left:10px;padding-right:10px;">
				<table class="write">
					<caption>카테고리 등록화면</caption>
					<colgroup>
						<col style="width: 120px;" />
						<col style="width: *;" />
					</colgroup>
					<tbody>			
					<tr>
						<th scope="row">상위카테고리명</th>
						<td>
   						       ${classify.up_classify_nm}
						</td>
					</tr>
					<tr>
						<th scope="row">카테고리명  <span class="asterisk">*</span></th>
						<td>
   						       <input class="in_w100" type="text" id="classify_nm" name="classify_nm" value="${classify.classify_nm}" placeholder="카테고리명" data-parsley-required="true" data-parsley-maxlength="100" />
						</td>
					</tr>
					<tr>
						<th scope="row">설명</th>
						<td>
					         <textarea class="in_w100" id="classify_desc" name="classify_desc" placeholder="설명" rows="2" data-parsley-maxlength="500" >${classify.classify_desc}</textarea>
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
					<a href="javascript:classifyInsert()" class="btn save" title="등록">
						<span>등록</span>
					</a>
				  </c:if>
                  <c:if test="${param.mode == 'E' }">
                  	<a href="javascript:classifyInsert()" class="btn save" title="수정">
						<span>수정</span>
					</a>
					<a href="javascript:classifyDelete()" class="btn save" title="삭제">
						<span>삭제</span>
					</a>
					</c:if>
				</div>
			</footer>
			</div>
			<!-- //footer -->
</form>			          