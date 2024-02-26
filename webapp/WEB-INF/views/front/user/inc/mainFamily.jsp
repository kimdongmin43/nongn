<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.*"%>
					   <div id="stack1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <a href="#none" class="close" onclick="hidePop('stack1'); return false;"></a>
                              <h3 id="myModalLabel">패밀리 사이트 더보기</h3>
                                    </div>
                                    <ul class="family_box">
                              <li>
                                 <ul class="family_sub">
                                    <c:set var="j" value="0" />
                                    <c:forEach  var="row" items="${mainBannerList}" varStatus="status">
									<c:if test="${row.sectionCd eq '7'}">
											<c:if test="${j mod 8 eq 0}">
											</ul>
										</li>
										<li>
											<ul class="family_sub">
											</c:if>
												<li><a href="${row.url}" target="${row.targetCd}" title="${row.targetCdNm}">${row.title}</a></li>
											<c:set var="j" value="${j+1}" />
									</c:if>
									</c:forEach>
                                 </ul>
                              </li>
                           </ul>
                                </div>
                            </div>
                        </div>




