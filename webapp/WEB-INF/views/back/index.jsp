<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
table th { text-align:center; bold;}
table td { text-align:center; }
</style>
<script>
$(document).ready(function(){
	$(".left_area").hide();
	$(".location").hide();
});
</script>

				<!-- content -->
				<div id="content">
					<div class="site_area">
						<ul class="site_list">
						    <c:set var="preTopMenuId" value=""/>
						    <c:set var="menuIdx" value="0"/>
						    <c:set var="menuSubCnt" value="0"/>
						    <c:set var="menuSub2Cnt" value="0"/>
						    <c:set var="preLvl" value="2"/>
							<c:forEach var="row" items="${sitemapList}" varStatus="status">

							<c:if test="${preTopMenuId != row.topMenuId}">

								<c:if test="${menuSub2Cnt > 0}">
												</ul>
								 		 </li>
								</c:if>
						        <c:if test="${menuSubCnt > 0}">
						            	</ul>
									</div>
						        </c:if>
						        <c:set var="menuSubCnt" value="0"/>
						        <c:if test="${menuIdx > 0}">
		                     	</li>
						        </c:if>
								<li>
									<div class="site_title">
										<strong>${row.menuNm}</strong>
									</div>
									<c:if test="${row.subCnt > 0}">
									<div class="site_link_area">
										<ul>
									</c:if>
									<c:set var="preLvl" value="2"/>
									<c:set var="menuSubCnt" value="${row.subCnt}"/>
							</c:if>
                            <c:if test="${row.lvl == 2}">
                                    <c:if test="${preLvl != row.lvl}">
                                         </ul>
                                    </c:if>
									<li><!-- goPageUrl(url, menuId, param, targetCd, width, height, left, top) -->
										<a href="javascript:goPageUrl('${row.refUrl}','${row.menuId}','','${row.targetCd}','${row.width}','${row.height}','${row.left}','${row.top}')" title="${row.menuNm} 페이지로 이동">
											<span>${row.menuNm}</span>
										</a>
									<c:if test="${row.subCnt > 0}">
										<ul class="sub_menu">
									</c:if>
									<c:if test="${row.subCnt < 1}">
									</li>
									</c:if>
									<c:set var="menuSub2Cnt" value="${row.subCnt}"/>
							        <c:set var="preLvl" value="${row.lvl}"/>
							</c:if>
                            <c:if test="${row.lvl == 3}">
										<li>
											<a href="javascript:goPageUrl('${row.refUrl}','${row.menuId}','','${row.targetCd}','${row.width}','${row.height}','${row.left}','${row.top}')" title="${row.menu_nm} 페이지로 이동">
												<span>${row.menuNm}</span>
											</a>
										</li>
										<c:set var="preLvl" value="${row.lvl}"/>
							</c:if>

							<c:set var="menuIdx" value="${menuIdx+1}"/>
							<c:set var="preTopMenuId" value="${row.topMenuId}"/>
                        	</c:forEach>
									</ul>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<!--// content -->
				<!--
						    <li>
								<div class="site_title">
									<strong>통계</strong>
								</div>
								<div class="site_link_area">
									<ul>
										<li>
											<a href="#none" title="홈페이지 접속 페이지로 이동">
												<span>홈페이지 접속</span>
											</a>
											<ul class="sub_menu">
												<li>
													<a href="#none" title="시간대별 페이지로 이동">
														<span>시간대별</span>
													</a>
												</li>
												<li>
													<a href="#none" title="일자별 페이지로 이동">
														<span>일자별</span>
													</a>
												</li>
												<li>
													<a href="#none" title="연도별 페이지로 이동">
														<span>연도별</span>
													</a>
												</li>
											</ul>
										</li>
										<li>
											<a href="#none" title="신청/심사현황 페이지로 이동">
												<span>신청/심사현황</span>
											</a>
										</li>
										<li>
											<a href="#none" title="활동계획서 키워드 페이지로 이동">
												<span>활동계획서 키워드</span>
											</a>
										</li>
										<li>
											<a href="#none" title="활동보고서 키워드 페이지로 이동">
												<span>활동보고서 키워드</span>
											</a>
											<ul class="sub_menu">
												<li>
													<a href="#none" title="활동목표/활동계획 페이지로 이동">
														<span>활동목표/활동계획</span>
													</a>
												</li>
												<li>
													<a href="#none" title="참여프로그램 페이지로 이동">
														<span>참여프로그램</span>
													</a>
												</li>
											</ul>
										</li>
									</ul>
								</div>
							</li>

 -->