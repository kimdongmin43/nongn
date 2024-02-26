<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%
pageContext.setAttribute("cr", "\r"); //Space
pageContext.setAttribute("cn", "\n"); //Enter
pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
pageContext.setAttribute("br", "<br/>"); //br 태그
%>

            <c:if test="${MENU.menuDesc != ''}">
			<!-- menu_info_area -->
			<div class="menu_info_area">
				<!-- info_box -->
				<div id="menu_desc_area" class="info_box" style="display:none">
					<div class="info_box_none">
						<p class="info_ptxt">
						${fn:replace(MENU.menuDesc, cn, br)}
						</p>
					</div>
				</div>
				<!--// info_box -->
				<!-- info_button_area -->
				<!-- <div class="info_button_area">
					<a id="menu_desc_btn" href="javascript:menuDescOpen();" title="설명" class="btn_info">
						<img src="/images/back/common/btn_info_unfold.png" alt="열기" />
					</a>
				</div> -->
				<!--// info_button_area -->
			</div>
			<!--// menu_info_area -->
			</c:if>