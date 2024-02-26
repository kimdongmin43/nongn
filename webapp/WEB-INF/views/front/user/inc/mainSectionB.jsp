<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.*"%>
<%
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy.MM.dd");
String now = formatter.format(new java.util.Date());
String devServer = "";
pageContext.setAttribute("now",now);
pageContext.setAttribute("devServer",devServer);
%>
					<c:set var="boardCount" value="${mainMap.mainCd eq 'A' or mainMap.mainCd eq 'C' ?2:3}"/>
					<!--  연계 데이터 -->
					<div class="tabbable tabbable-tabdrop">
						<ul class="tab_type2">
							<c:forEach  var="row" items="${mainBoardList}" varStatus="status">
							<c:if test="${status.index < boardCount}">
							<li<c:if test="${status.index eq 0}"> class="active"</c:if><c:if test="${empty row.boardId}"> class="none"</c:if>>
								<a href="#tab${row.sectionCd}_${status.index}" data-toggle="tab">${empty row.title? '&nbsp;':row.title }</a>
								<c:choose>
								<c:when test="${row.boardId eq 1}">
									<!--  1.경제지표 -->
									<a class="more prospect" href="#none"><img src="/images/more.png" alt="더보기" /></a>
								</c:when>
								<c:when test="${row.boardId eq 2}">
									<!--  2.E-Contents -->
									<a class="more econtents" href="#none"><img src="/images/more.png" alt="더보기" /></a>
								</c:when>
								<c:when test="${row.boardId eq 3}">
									<!--// 3. 온라인세미나 -->
									<a class="more" href="http://www.korcham.net/nCham/Service/Economy/appl/OnlineSeminarList.asp"><img src="/images/more.png" alt="더보기" /></a>
								</c:when>
								<c:when test="${row.boardId eq 4}">
									<!--// 3. 행사/교육 -->
									<a class="more" href="/front/event/eventList.do?menuId=202"><img src="/images/more.png" alt="더보기" /></a>
								</c:when>
								<c:otherwise>
									<!--  일반게시판 -->
									<a class="more" href="${row.refUrl}"><img src="/images/more.png" alt="더보기"></a>
								</c:otherwise>
								</c:choose>
							</li>
							</c:if>
							</c:forEach>
						</ul>
						<div class="tab-content">
							<c:forEach  var="row" items="${mainBoardList}" varStatus="status">
							<c:if test="${status.index < boardCount}">
							<div class="tab-pane<c:if test="${status.index eq 0}"> active</c:if>" id="tab${row.sectionCd}_${status.index}">
							<c:choose>
								<c:when test="${row.boardId eq 1}">
									<!--  1.경제지표 -->

										<ul class="nav tab_type1">
											<c:set  var="tempDiv" value=""/>
											<c:forEach  var="eRow" items="${prospectList}" varStatus="status1">
											<c:if test="${eRow.divCd ne tempDiv}">
											<li data-href="${eRow.moreUrl}" <c:if test="${tempDiv eq ''}" >class="active"</c:if> data-name="prospect">
												<a href="#tab${row.sectionCd}_${eRow.divCd}" data-toggle="tab">${eRow.divNm}</a>
											</li>
											<c:set  var="tempDiv" value="${eRow.divCd}"/>
											</c:if>
											</c:forEach>
										</ul>
										<div class="tab-content">
										<c:forEach  var="eRow" items="${prospectList}" varStatus="status1">
										<c:if test="${eRow.divCd ne tempDiv}">
										<c:set  var="tempDiv" value="${eRow.divCd}"/>
											<!-- ${eRow.divNm} -->
											<div class="tab-pane <c:if test="${status1.index eq 0}">active</c:if>" id="tab${row.sectionCd}_${eRow.divCd}">
											<table style="text-align: center; width: 100%;background-color:  #6cb0e8;border-collapse: inherit;border-spacing: 1px;">
												<colgroup>

												<col width="33.3%"/>
												<col />
												<col width="33.3%" />

												</colgroup>
												<tr align="center" valign="middle" style="font-weight:bold;font-size:13px;">

												    <td style="height:40px;background-color: #1a67a8;color:#fff;">날짜</td>
												    <td style="background-color: #1a67a8;color:#fff;">${eRow.divNm}</td>
												    <td style="background-color: #1a67a8;color:#fff;">전일비</td>

												</tr>
											    <c:forEach  var="dRow" items="${prospectList}" varStatus="status2">
												<c:if test="${ dRow.divCd eq tempDiv}">
												<tr>

													<td style="height:40px;background-color: #fff">${dRow.inDate}</td>
													<td style="background-color: #fff">
														${dRow.title}
													</td>
													<td style="background-color: #fff">
														${fn:trim(dRow.writer) != '0.00' && fn:substring(fn:trim(dRow.writer),0,1) != '-' ?'<font color=red size=2>▲</font>&nbsp;&nbsp;':'<font color=blue size=2>▼</font>&nbsp;&nbsp;'}${fn:trim(fn:replace(dRow.writer,'-',''))}
													</td>

												</tr>
												</c:if>
												</c:forEach>
											  </table>
											</div>
											<!-- // ${eRow.divNm} -->
										</c:if>
										</c:forEach>
										</div>

								</c:when>
								<c:when test="${row.boardId eq 2}">
									<!--  2.E-Contents -->

										<ul class="nav tab_type1">
											<c:set  var="tempDiv" value=""/>
											<c:forEach  var="eRow" items="${eContentsList}" varStatus="status1">
											<c:if test="${eRow.divCd ne tempDiv}">
											<li data-href="${eRow.moreUrl}" <c:if test="${tempDiv eq ''}">class="active"</c:if> data-name="econtents">
												<a href="#tab${row.sectionCd}_${eRow.divCd}" data-toggle="tab">${eRow.divNm}</a>
											</li>
											<c:set  var="tempDiv" value="${eRow.divCd}"/>
											</c:if>
											</c:forEach>
										</ul>
										<div class="tab-content">
										<c:forEach  var="eRow" items="${eContentsList}" varStatus="status1">
										<c:if test="${eRow.divCd ne tempDiv}">
										<c:set  var="tempDiv" value="${eRow.divCd}"/>
											<!-- ${eRow.divNm} -->
											<div class="tab-pane <c:if test="${status1.index eq 0}">active</c:if>" id="tab${row.sectionCd}_${eRow.divCd}">
												<ul class="econtent_list">
													<c:forEach  var="dRow" items="${eContentsList}" varStatus="status2">
													<c:if test="${ dRow.divCd eq tempDiv}">
													<li ${dRow.divCd eq 'SERI_PRO' ? 'class="seripro"':''}>
														<a href="${dRow.detailUrl}" target="_blank">
															<img src="${dRow.imgUrl}" alt="${dRow.title}"/>
															<h4>${dRow.title}</h4>
															<span class="name">${dRow.divCd eq 'MAGAZINE' ? dRow.subTitle: (dRow.divCd eq 'SERI_PRO' ? dRow.summ:dRow.author)}</span>
														</a>
													</li>
													</c:if>
													</c:forEach>
												</ul>
											</div>
											<!-- // ${eRow.divNm} -->
										</c:if>
										</c:forEach>
										</div>

								</c:when>
								<c:when test="${row.boardId eq 3}">
									<!--// 3. 온라인세미나 -->
									<div class="online_semina">
									<a href="http://www.korcham.net/nCham/Service/Economy/appl/OnlineSeminarDetail.asp?ONSEMI_ID=${seminarMap.seqNoD010}" >
										<img src="http://www.korcham.net/FileWebKorcham/OnlineSeminar/Image/${seminarMap.eventImg}" alt="${seminarMap.title}" class="online_img" />
										<span class="online_content">
											<h4>${seminarMap.title}</h4>
											<%-- <span class="onlin_date">${seminarMap.eventDate}</span> --%>
										</span>
									</a>
									</div>
								</c:when>

								<c:when test="${row.boardCd eq 'A' or row.boardCd eq 'W'}">
									<!-- 포토뉴스 -->
									<ul class="boardlist_t2">
									<c:set var="cnt" value="0"/>
									<c:forEach  var="sRow" items="${mainBoardContentsList}" varStatus="status1">
									<c:if test="${row.sectionCd eq sRow.sectionCd and row.tabSeq eq sRow.tabSeq}">
									<c:if test="${cnt<3}">
									<li class="mainPhotoNews">
										<a href="${sRow.refUrl}<c:if test="${not empty sRow.refUrl}">&menuId=${row.menuId}</c:if>" class="board_tit" style="vertical-align: text-top; ">
										<img src="${devServer}${sRow.filePath}" alt="${sRow.title}" class="mainPhotoNewsImg"/></a>
										<span class="new_type"><c:if test="${sRow.regDt eq now}"><img src="/images/new_icon.jpg" alt="new"/></c:if></span>
										<div class="mainPhotoNewsTitle"><a href="${sRow.refUrl}<c:if test="${not empty sRow.refUrl}">&menuId=${row.menuId}</c:if>">${sRow.title}</a></div>

										<%-- <div>${sRow.contents}</div> --%>
										<%-- <div class="date">${sRow.regDt}</div> --%>
									</li>
									<c:set var="cnt" value="${cnt+1}"/>
									</c:if>
									</c:if>
									</c:forEach>
									</ul>
									<!--// 포토뉴스 -->
								</c:when>

								<c:otherwise>
									<!-- 일반게시판 및 행사/교육 -->
									<ul class="boardlist_t2">
									<c:forEach  var="sRow" items="${mainBoardContentsList}" varStatus="status1">
									<c:if test="${row.sectionCd eq sRow.sectionCd and row.tabSeq eq sRow.tabSeq}">
									<li>
										<a href="${sRow.refUrl}<c:if test="${not empty sRow.refUrl}">&menuId=${row.boardId eq '4'?'202':row.menuId}</c:if>" class="board_tit">
											<span class="new_type"><c:if test="${sRow.regDt eq now}"><img src="/images/new_icon.jpg" alt="new"/></c:if></span>${sRow.title}
										</a>
										<div class="date">${sRow.regDt}</div>
									</li>
									</c:if>
									</c:forEach>
									</ul>
									<!--// 일반게시판 및 행사/교육 -->
								</c:otherwise>
							</c:choose>
							</div>
							</c:if>
							</c:forEach>
						</div>
					</div>
					<!--  연계 데이터 -->


