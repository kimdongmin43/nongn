<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://www.gstatic.com/charts/loader.js"></script>

<script>

var IndicatorsUrl =  "<c:url value='/front/contents/Indicators.do'/>";
function getSelectValue(frm)
{

 frm.searchTxt.value = frm.searchKey.options[frm.searchKey.selectedIndex].value;
}


function search() {

	var f = document.listFrm;
    f.target = "_self";
    f.action = IndicatorsUrl;
    f.submit();


}


google.charts.load('current', {'packages':['line'], 'language': 'kr'});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ['', '농작물', '가축']
<c:forEach var="orgchartall" items="${orgchartall}">
	,['\'${fn:substring(orgchartall.year,2,4)}', ${orgchartall.frate},      ${orgchartall.lrate}]
</c:forEach>
  ]);

  var options = {
	        hAxis: {
	          title: '년도'
	        },
	        vAxis: {
	          title: '%'
	        },
	        colors: ['#4b7ebb', '#c0504d']
	      };

	var chart = new google.charts.Line(document.getElementById('linechart_material'));
	chart.draw(data, options);
}

</script>

<input type="hidden" name="year" value="">
		<div class="content_tit">
			<h3>${MENU.menuNm}</h3>
		</div>


                	<h5 class="title_h5">농작물·가축재해보험 가입현황</h5>
                    <!--검색부분-->
                    <div class="cont_search_area mt25">
                        <div class="cont_search_box">
                            <form name="listFrm"  id="listFrm" method="post" onsubmit="return false;">
                                <fieldset>
                                    <label for="" >기준년도</label>
                       				 <select id="searchKey" name = "searchKey" class = "in_w15" data-parsley-required="true" onChange="getSelectValue(this.form);" >
                              			 <c:set var="today" value="<%=new java.util.Date()%>" />
                              			 <fmt:formatDate value="${today}" pattern="yyyy" var="end"/>
                              			 <c:forEach begin="2001" end="${end}" var="idx" step="1">
                               			 <option value="<c:out value="${end-idx+2001}" />"  ${param.searchKey eq end-idx+2001?' selected':''}>
                         			  			<c:out value="${end-idx+2001}" /></option>
                              			 </c:forEach>
                       				 </select>
                       		   <button type="button" class="btn_search" title="조회" onclick="search();">조회</button>
                                </fieldset>
                                     <input type="hidden" name="searchTxt" id="searchTxt" value="${param.searchTxt}">

                               </form>
                     </div>
                    </div>



                    <!--//검색부분-->

                    <p class="tar">(단위: 개(종), ha(천두), 호, 백만원)</p>
                    <div class="table_area" >
                        <table class="table_style">
                            <caption>농업재해재보험심의회</caption>
                            <colgroup>
                                <col style="*" />
                                <col style="16%" />
                                <col style="16%" />
                                <col style="16%" />
                                <col style="16%" />
                                <col style="16%" />
                                <col style="16%" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">구분</th>
                                    <th scope="col">대상품목(축종)수</th>
                                    <th scope="col">가입면적(두수)</th>
                                    <th scope="col">가입농가수</th>
                                    <th scope="col">가입금액</th>
                                    <th scope="col">순보험료</th>
                                    <th scope="col">가입률</th>
                                </tr>
                            </thead>
                      	<c:forEach var="orgchartlist" items="${orgchartlist}" varStatus="loop">
                            <tbody class="tb_tar">
                               <c:if test="${orgchartlist.gubun == 'F'}">
                                <tr>
                                    <th>농작물</th>
                                    <td>${orgchartlist.itemNum}</td>
                                    <td><fmt:formatNumber value="${orgchartlist.joinNum}" pattern="#,###" /></td>
                                    <td><fmt:formatNumber value="${orgchartlist.houseNum}" pattern="#,###" /></td>
                                    <td><fmt:formatNumber value="${orgchartlist.subFee}" pattern="#,###" /></td>
                                    <td><fmt:formatNumber value="${orgchartlist.premium}" pattern="#,###" /></td>
                                    <td>${orgchartlist.subRate}%</td>
                                </tr>
                                </c:if>
                               <c:if test="${orgchartlist.gubun != 'F'}">
                                <tr>
                                    <th>가축</th>
                                    <td>${orgchartlist.itemNum}</td>
                                    <td><fmt:formatNumber value="${orgchartlist.joinNum}" pattern="#,###" /></td>
                                    <td><fmt:formatNumber value="${orgchartlist.houseNum}" pattern="#,###" /></td>
                                    <td><fmt:formatNumber value="${orgchartlist.subFee}" pattern="#,###" /></td>
                                    <td><fmt:formatNumber value="${orgchartlist.premium}" pattern="#,###" /></td>
                                    <td>${orgchartlist.subRate}%</td>
                                </tr>
                                </c:if>

				</tbody>
                           </c:forEach>
                           	<c:if test="${empty orgchartlist }">
						<tr>
							<td colspan="7" class="">조회된 결과가 없습니다.</td>
						</tr>
					</c:if>
                        </table>
                    </div>
                    <p class="fs_13 pb20">* 대상품목(축종)수는 농식품부, 그 외에는 보험사업자 제공 데이터를 기반으로 산출되었습니다.</p>
					<br/><br/>
                    <h5 class="title_h5 mb20">연도별 농작물·가축재해보험 가입률 추이</h5>
					<p class="tar">(단위: %)</p>
                    <div class="charts_area" style="border:1px solid #dedede; padding:20px;margin-top: 10px;">
                    	<div id="linechart_material" style="width: 100%; height:300px"></div>
                    </div>
					<br/><br/><br/><br/>


