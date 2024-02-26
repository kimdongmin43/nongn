<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=kKJugBCHz4MBevafwgCL"></script>


		<div class="contents_title">
			<h2><!-- 찾아오시는 길 -->${MENU.menuNm}</h2>
		</div>
		<div class="contents_detail">
			<c:set var="i" value="0" />
			<c:forEach var="locationlist" items="${locationlist}" varStatus="loop">
				<c:set var="i" value="${i+1}" />
				<h3 class="type2">${locationlist.branchNm}</h3>
				<div id="map_${i}" style="width: 100%; height: 550px;" align="center"></div>

				<script>
						var map = new naver.maps.Map('map_${i}', {
							center : new naver.maps.LatLng(
									'${locationlist.lat}',
									'${locationlist.lng}'),
							zoom : 10,
							zoomControl : true, //줌 컨트롤의 표시 여부
							zoomControlOptions : { //줌 컨트롤의 옵션
								position : naver.maps.Position.TOP_RIGHT
							}
						});


						map.setOptions("mapTypeControl", true);

						var marker = new naver.maps.Marker({
							position : new naver.maps.LatLng(
									'${locationlist.lat}',
									'${locationlist.lng}'),
							map : map
						});
						<c:if test="${locationlist.branchNm != null}">
						var contentString = ['<div >',
								'	 <h2>${locationlist.branchNm}</h2>  ',
								'</div> ','</br>' ].join('');
						</c:if>
						var infowindow = new naver.maps.InfoWindow({
							content : contentString
						});
						naver.maps.Event.addListener(marker, "click", function(
								e) {
							if (infowindow.getMap()) {
								infowindow.close();
							} else {
								infowindow.open(map, marker);
							}
						});

						infowindow.open(map, marker);

						var map = new naver.maps.Map('map_${i}', mapOptions);


					</script>


				<div class="datalist4">
					<table cellspacing="0" cellpadding="0">
						<caption>찾아오시는 길.찾아오시는길을 주소, 전화번호, 위치, 비고 순으로 정보를 확인하실 수 있습니다..</caption>
						<colgroup>
							<col style="width: 20%" />
							<col style="width: 80%" />
							<col style="" />
						</colgroup>
						<tbody>
							<c:if test="${locationlist.addr2 != null}">
								<tr>
									<th scope="col">주소</th>
									<td>${locationlist.addr2}</td>
								</tr>
							</c:if>
							<c:if test="${locationlist.tel != null}">
								<tr>
									<th scope="col">전화번호</th>
									<td>${locationlist.tel}</td>
								</tr>
							</c:if>
							<c:if test="${locationlist.locDesc != null}">
								<tr>
									<th scope="col">위치</th>
									<td>${locationlist.locDesc}</td>
								</tr>
							</c:if>
							<c:if test="${locationlist.locComment != null}">
								<tr>
									<th scope="col">비고</th>
									<td>
										<ul>
											<li>${locationlist.locComment}</li>
										</ul>
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</c:forEach>

			</div>

