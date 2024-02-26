<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<c:set var="today" value="<%=new java.util.Date()%>" />
<fmt:formatDate value="${today}" pattern="yyyy" var="end"/>
<fmt:formatDate value="${today}" pattern="MM" var="todayMonth"/>
<script>
	var gridUrl = "<c:url value='/front/contents/chartDownload.do'/>";
	var IndicatorsUrl =  "<c:url value='/front/contents/chart3ListPage.do'/>";
	function getSelectValue(obj)
	{
		$("#Month").find("option").remove();
		if($(obj).val()*1 < ${end}){
		 $("#Month").append("<option value='12'>12</option>");
		}else{
			for(var i=1; i<13; i++){
				$("#Month").append("<option value='"+i+"'>"+i+"</option>");
			}
		}
	}


	function search() {
		mon = '0'+$('#Month').val(); 
		searchYM = $('#searchKey').val()+mon.substring(mon.length-2,mon.length);
		$('#searchYM').val(searchYM);
		var f = document.listFrm;
		f.target = "_self";
		f.action = IndicatorsUrl;
		f.submit();


	}
</script>

<!--content_tit-->
<div class="content_tit" id="containerContent">
	<h3>가축재해보험</h3>
</div>
<!--//content_tit-->

<!--content-->
<div class="content">
	<!-- tab_style -->
	<div class="tab_style">
		<ul>
			<li class="w2"><a href="#none" class="active" title="선택됨">축종별</a></li>
			<li class="w2"><a href="/front/contents/chart4ListPage.do?menuId=5367">지역별</a></li>
		</ul>
	</div>
	<!-- //tab_style -->
	<div class="cont_search_area">
		<div class="cont_search_box">
			<form name="listFrm"  id="listFrm" method="post" onsubmit="return false;" onchange="changeDecember();">
				<input type="hidden" name="searchType"  id="searchType" value="607">    
				<input type="hidden" name="searchYM"  id="searchYM" value="${param.searchYM}">
				<input type="hidden" name="menuId"  value="${param.menuId}">
				<div class="con_wrap">
					<dl>
						<dt><label for="searchKey">기준년도</label></dt>
						<dd>
							<fieldset>
								<!-- <select id="searchKey" name = "searchKey" class = "in_w15" data-parsley-required="true" onChange="getSelectValue(this);" > --> <!-- 2022.06.30 김동민 대리 함수 제거-->
								<select id="searchKey" name = "searchKey" class = "select_style" data-parsley-required="true" >
									<c:forEach begin="2015" end="${end}" var="idx" step="1">
									<option value="<c:out value="${end-idx+2015}" />"  ${fn:substring(param.searchYM,0,4) eq end-idx+2015?' selected':''}><c:out value="${end-idx+2015}" /></option>
									</c:forEach>
								</select>
							</fieldset>
						</dd>
					</dl>
					<dl>
						<dt><label for="Month">기준월</label></dt>
						<dd>
							<fieldset>
								<select name="strsearch" id="Month" class="select_style" title="검색옵션">
									<%-- <c:set var="st" value="${fn:substring(param.searchYM,0,4) eq '2021' or param.searchYM eq null?1:12}"/> --%>	<!-- 2022.06.30 김동민 대리 조건문 제거-->
									<c:set var="st" value="${fn:substring(param.searchYM,0,4) eq '2019' eq '2018' eq '2017' eq '2016' eq '2015' or param.searchYM eq null?'':12}"/>	<!-- 2022.09.30 김동민 대리-->
									<c:forEach begin="1" end="12" var="idx" step="1">
									<option value="${idx}"  ${fn:substring(param.searchYM,4,6) eq idx?'selected':''}>${idx}</option>
									</c:forEach>
								</select>
								<script>
									if(!$("#searchYM").val()){
										$("#Month").val("${todayMonth}"-1);
									}
									else if($("#searchYM").val()){
										$("#Month").val("#searchYM".val());
									}
								</script>
							</fieldset>
						</dd>
					</dl>
					<button class="btn_search" title="검색하기" onclick="search();">검색</button>
				</div>
			</form>
        </div>
		<div class="btn_area fl_right"><a href="javascript:excelDown()" class="btn_down mb30" title="엑셀 다운로드">엑셀 다운로드</a></div>
	</div>
	
	<div class="date_choice fl_right">(단위: 천두, 호, 백만원)</div>
	<div class="table_auto_area table_wrap scroll">
		<table class="table_style_auto">
			<caption>축종별 가축재해보험 정보표로 축종,가입두수,가입농가수,가입금액,영업보험료,지급보험금,가입률 정보를 제공함.</caption>
			<colgroup>
				<col width="22%" />
				<col span="6" width="13%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">축종</th>
					<th scope="col">가입두수</th>
					<th scope="col">가입농가수</th>
					<th scope="col">가입금액</th>
					<th scope="col">영업보험료</th>
					<th scope="col">지급보험금</th>
					<th scope="col">가입률</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="chartlist2" items="${chartlist2}" varStatus="loop2">
				<tr>
					<td class="txt_cen">${chartlist2.c1}</td>
					<td><fmt:formatNumber value="${chartlist2.v1}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${chartlist2.v2}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${chartlist2.v4}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${chartlist2.v5}" pattern="#,###" /></td><!-- 윤여경 : 보험금-->
					<td><fmt:formatNumber value="${chartlist2.v6}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${chartlist2.v7}" pattern="0.0" />%</td>
				</tr>
				</c:forEach>
				<c:if test="${empty chartlist2}">
					<tr>
						<td colspan="7" class="txt_cen borBNone">조회된 결과가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>				
	</div>
	<p class="mt10">* 보험사업자(농협손보, KB손보, 한화손보, DB손보, 현대해상) 제공 데이터를 기반으로 산출되었습니다.<br />
	* 매월 20일 전후로 전월 실적이 업데이트됩니다.</p>
	
	<div class="board_bot_info mt50">
		<p><strong>※ 축종 구분(2023년 기준, 16종)</strong></p>
		<ul class="mt10">
			<li>소, 돼지, 말
			<li>가금(8종) : 닭, 오리, 꿩, 메추리, 칠면조, 거위, 타조, 관상조</li>
			<li>기타가축(5종) : 사슴, 양, 꿀벌, 토끼, 오소리</li>
			<li>축사(5) : 우사, 돈사, 마사, 가금사, 기타가축사</li><br />
			<li>* 2022년 이후 축산시설물이 주계약으로 변경됨에 따라 축사실적 분리 집계.<br />따라서, 동일 계약 내 가축과 축사가 함께 가입된 경우 건수 및 농가수가 중복 계상될 수 있음.</li>
		</ul>
	</div>
</div>

<script>
	var jq=true;

	function excelDown(){
		if(jq){dn()};
		setTimeout("exportExcel('Chart3')",1000);
	}
	 function dn(){

		 $('#event_list').jqGrid({
				datatype: 'json',
				url: gridUrl,
				mtype: 'POST',
				colModel: [
					{ label: '중분류', index: 'c1', name: 'c1',  align : 'center', sortable:false},
					{ label: '소분류', index: 'c2', name: 'c2',  align : 'center', sortable:false},
					{ label: '가입두수', index: 'v1', name: 'v1',  align : 'center', sortable:false},
					{ label: '가입농가수', index: 'v2', name: 'v2',  align : 'center', sortable:false},
					{ label: '가입건수', index: 'v3', name: 'v3', align : 'center', sortable:false},
					{ label: '가입금액', index: 'v4', name: 'v4',  align : 'left', sortable:false},
					{ label: '영업보험료', index: 'v5', name: 'v5', align : 'center', sortable:false},
					{ label: '지급보험금', index: 'v6', name: 'v6',  align : 'center', sortable:false},
					{ label: '가입률', index: 'v7', name: 'v7', align : 'center', sortable:false }
				],
				postData :{
					//searchTxt : $("#searchTxt").val(),
					searchYM : $('#searchYM').val(),
					//searchYM : '201706',
					//chartKey : '3'
					searchKey : $('#searchKey').val(),
					strsearch : $('#Month').val(),
					searchType : '606'

				},

				viewrecords : true,
				height : "350px",
				gridview : true,
				autowidth : true,
				forceFit : false,
				rowNum:-1,
				shrinkToFit : true,
				cellEdit : false,
				cellsubmit : 'clientArray',
				beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
					savedRow = iRow;
					savedCol = iCol;
				},
				onSelectRow : function(rowid, status, e) {
					var ret = jQuery("#event_list").jqGrid('getRowData', rowid);
				},
				onSortCol : function(index, iCol, sortOrder) {
					 jqgridSortCol(index, iCol, sortOrder, "event_list");
				   return 'stop';
				},
				beforeProcessing: function (data) {
					$("#LISTOP").val(data.LISTOPVALUE);
					$("#miv_pageNo").val(data.page);
					$("#miv_pageSize").val(data.size);
					$("#totalCnt").val(data.records);
				},
				//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
				loadComplete : function(data) {
					//showJqgridDataNon(data, "event_list",8);

					jq=false;

				}
			});
			//jq grid 끝

			jQuery("#event_list").jqGrid('navGrid', '#event_list_pager', {
					add : false,
					search : false,
					refresh : false,
					del : false,
					edit : false
				});


	 }



	//excel로 출력
	 function  exportExcel( pFileName ) {





		  var pGridObj = $('#event_list');
		  var mya = pGridObj.getDataIDs();
		  var data = pGridObj.getRowData(mya[0]);
		  var colNames=new Array();
		  var ii=0;
		  for (var d in data){ colNames[ii++] = d; }

		  //컬럼 헤더 가져오기
		  var columnHeader = pGridObj.jqGrid('getGridParam','colNames') + '';
		  var arrHeader = columnHeader.split(',');
		  var html = "";
		  html+="<table>";
		  html+="<tr><td colspan  ='9' bgcolor='#ffff99'>[주석]<br><br>1. 보험사업자(농협손보, KB손보, 한화손보, DB손보, 현대해상) 제공 데이터를 기반으로 산출되었습니다.<br>";
		  html+="2. 계약 변경, 해지 등으로 인한 보험료 환입의 합계가 보험료의 합계보다 큰 경우, 보험료가 음수(-)값으로 조회될 수 있습니다.<br>";
		  html+="3. 보험금 환입의 합계가 보험금 지급의 합계보다 큰 경우, 보험금이 음수(-)값으로 조회될 수 있습니다.<br>";
		  html+="4. 가입률(％, 면적기준)=가입면적&#47;대상면적*100<br>";
		  html+="5. 대상면적은 통계청 농림어업총조사 자료를 토대로 산출되었습니다.<br>";
		  html+="6. 19년도까지 데이터는 연도말(12월말) 기준으로만 조회가 가능하며, 20년 이후 실적에 한해 연중 월별 조회 가능합니다.<br>";
		  html+="<tr><td colspan  ='9' align='right'>(단위 : 천두, 호, 건, 백만원, ％)</td></tr>";
		  html+="</table>";

		  html+="<table border=1><tr>";
		  for ( var y = 0; y < arrHeader.length; y++ ) {
			   html = html + "<td><b>" + encodeURIComponent(arrHeader[y])  + "</b></td>";
		  }
		  html = html + "</tr>";
		  //값 불러오기
		  for(var i=0;i< mya.length;i++) {
			   var datac= pGridObj.getRowData(mya[i]);
			   html = html +"<tr>";
			   for(var j=0; j< colNames.length;j++) html=html + '<td>' + encodeURIComponent(datac[colNames[j]])+"</td>";
			   html = html+"</tr>";
		  }
		  html=html+"</table>";  // end of line at the end

		  document.EXCEL_.csvBuffer.value = html;
		  document.EXCEL_.fileName.value = encodeURIComponent(pFileName);
		  document.EXCEL_.target='_blank';
		  document.EXCEL_.submit();
	 }

</script>

<div class="table_area" id="event_list_div" style="display: none;">
	<table id="event_list"></table>
	<div class="table_search_area" style="margin-top:10px;"></div>
</div>

<form id="EXCEL_" name="EXCEL_" action="/excel/down_excel.jsp"  method="post">
	 <input type="hidden" name="csvBuffer" id="csvBuffer" value="">
	 <input type="hidden" name="fileName" id="fileName" value="">
</form>

<script>
	$(document).ready(function(){		//	웹 품질 진단 조치 - 2022.02.22
		var strTitleText = $("#txtTitle").text();
		$("#txtTitle").text(strTitleText + " > 축종별");
	});
</script>

<script>
	function changeDecember(){
		var searchKey = $("#searchKey").val();
		if( searchKey == "2019"){
			$("#Month").find("option").remove();
			 $("#Month").append("<option value='12'>12</option>");
		}
		if( searchKey == "2018"){
			$("#Month").find("option").remove();
			 $("#Month").append("<option value='12'>12</option>");
		}
		if( searchKey == "2017"){
			$("#Month").find("option").remove();
			 $("#Month").append("<option value='12'>12</option>");
		}
		if( searchKey == "2016"){
			$("#Month").find("option").remove();
			 $("#Month").append("<option value='12'>12</option>");
		}
		if( searchKey == "2015"){
			$("#Month").find("option").remove();
			 $("#Month").append("<option value='12'>12</option>");
		}
	};
</script>