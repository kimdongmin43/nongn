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
	var IndicatorsUrl =  "<c:url value='/front/contents/chart1ListPage.do'/>";
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
	<h3>농작물재해보험</h3>
</div>
<!--//content_tit-->

<!--content-->
<div class="content">
	<!-- tab_style -->
	<div class="tab_style">
		<ul>
			<li class="w2"><a href="#none" class="active" title="선택됨">품목별</a></li>
			<li class="w2"><a href="/front/contents/chart2ListPage.do?menuId=5366">지역별</a></li>
		</ul>
	</div>
	<!-- //tab_style -->

	<div class="cont_search_area">
		<div class="cont_search_box">
			<form name="listFrm"  id="listFrm" method="post" onsubmit="return false;" onchange="changeDecember();">
				<input type="hidden" name="searchType"  id="searchType" value="604">
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
		<div class="btn_area fl_right"><a href="javascript:excelDown();" class="btn_down mb30" title="엑셀 다운로드">엑셀 다운로드</a></div>
	</div>

	<div class="date_choice fl_right">(단위: ha, 호, 백만원)</div>
	<div class="table_auto_area table_wrap scroll">
	<input type="hidden" name="searchYM"  id="searchYM" value="${param.searchYM}">
		<table class="table_style_auto">
			<caption>품목별 농작물재해보험 정보표로 품목,가입면적,가입농가수,가입금액,순보험료,지급보험금,가입률 정보를 확인 할 수 있습니다. 엑셀 다운로드시 자세한 내용을 확인 가능합니다.</caption>
			<colgroup>
				<col width="12%" />
				<col width="10%" />
				<col span="6" width="13%" />
			</colgroup>
			<thead>
				<tr>
					<th id="abc1" scope="col" colspan="2">품목</th>
					<th id="abc2" scope="col">가입면적</th>
					<th id="abc3" scope="col">가입농가수</th>
					<th id="abc4" scope="col">가입금액</th>
					<th id="abc5" scope="col">순보험료</th>
					<th id="abc6" scope="col">지급보험금</th>
					<th id="abc7" scope="col">가입률</th>
				</tr>
			</thead>
			<!-- 230920 김동민 19년도 이전 데이터 하드코딩 -->
<%-- 			<c:choose> --%>
<%-- 			<c:when test="${fn:substring(param.searchYM,0,4) eq '2015'}"> --%>
<!-- 				<tbody> -->
<!-- 				<tr> -->
<!-- 				<td headers="abc2 abc9">2016</td> -->
<!-- 				</tr> -->
<!-- 				</tbody> -->
<%-- 			</c:when> --%>
<%-- 			<c:when test="${fn:substring(param.searchYM,0,4) eq '2016'}"> --%>
<!-- 				<tbody> -->
<!-- 				<tr> -->
<!-- 				<td headers="abc2 abc9">2016</td> -->
<!-- 				</tr> -->
<!-- 				</tbody> -->
<%-- 			</c:when> --%>
<%-- 			<c:when test="${fn:substring(param.searchYM,0,4) eq '2017'}"> --%>
<!-- 				<tbody> -->
<!-- 				<tr> -->
<!-- 				<td headers="abc2 abc9">2017</td> -->
<!-- 				</tr> -->
<!-- 				</tbody> -->
<%-- 			</c:when> --%>
<%-- 			<c:when test="${fn:substring(param.searchYM,0,4) eq '2018'}"> --%>
<!-- 				<tbody> -->
<!-- 				<tr> -->
<!-- 				<td headers="abc2 abc9">2018</td> -->
<!-- 				</tr> -->
<!-- 				</tbody> -->
<%-- 			</c:when> --%>
<%-- 			<c:when test="${fn:substring(param.searchYM,0,4) eq '2019'}"> --%>
<!-- 				<tbody> -->
<!-- 				<tr> -->
<!-- 				<td id="abc9" class="txt_cen" colspan="2">삼겹살</td> -->
<!-- 					<td headers="abc2 abc9">1,000</td> -->
<!-- 					<td headers="abc3 abc9">2,000</td> -->
<!-- 					<td headers="abc4 abc9">3,000</td>윤여경 : 보험금 -->
<!-- 					<td headers="abc5 abc9">4,000</td> -->
<!-- 					<td headers="abc6 abc9">5,000</td> -->
<!-- 					<td headers="abc7 abc9">10%</td> -->
<!-- 				</tr> -->
<!-- 				</tbody> -->
<%-- 			</c:when> --%>
<%-- 			<c:otherwise> --%>
			<tbody>
				<c:forEach var="chartlist2" items="${chartlist2}" varStatus="loop2">
				<tr>
					<c:if test="${loop2.count eq 2 or loop2.count eq 4}">
					<td id="abc8" class="txt_cen" rowspan="2"> ${loop2.count<3?'과수':'식량작물'}</td>
					</c:if>
					<td id="abc9" class="txt_cen" ${loop2.count<6 and loop2.count ne 1?'':'colspan="2"'}>${chartlist2.c2 eq null?'합계':chartlist2.c2}</td>
					<td headers="abc2 abc9"><fmt:formatNumber value="${chartlist2.v1}" pattern="#,###" /></td>
					<td headers="abc3 abc9"><fmt:formatNumber value="${chartlist2.v2}" pattern="#,###" /></td>
					<td headers="abc4 abc9"><fmt:formatNumber value="${chartlist2.v5}" pattern="#,###" /></td><!-- 윤여경 : 보험금-->
					<td headers="abc5 abc9"><fmt:formatNumber value="${chartlist2.v6}" pattern="#,###" /></td>
					<td headers="abc6 abc9"><fmt:formatNumber value="${chartlist2.v7}" pattern="#,###" /></td>
					<td headers="abc7 abc9"><fmt:formatNumber value="${chartlist2.v8}" pattern="0.0" />%</td>
				</tr>
				</c:forEach>
				<c:if test="${empty chartlist2}">
				<tr>
					<td colspan="8" class="txt_cen borBNone">조회된 결과가 없습니다.</td>
				</tr>
				</c:if>
			</tbody>
<%-- 			</c:otherwise> --%>
<%-- 			</c:choose> --%>
			<!-- 230920 김동민 19년도 이전 데이터 하드코딩 -->
		</table>
	</div>
	<p class="mt10">* 농협손보 제공 데이터를 기반으로 산출되었습니다.<br />
	* 매월 20일 전후로 전월 실적이 업데이트됩니다.</p>
	
	<div class="board_bot_info mt50">
		<p><strong>※ 품목 구분(2023년 기준, 70개)</strong></p>
		<ul class="mt10">
			<li><strong>과수4종(4)</strong> : 사과, 배, 단감, 떫은감</li>
			<li><strong>과수기타(9)</strong> : 감귤, 복숭아, 포도, 자두, 매실, 참다래, 무화과, 유자, 살구</li>
			<li><strong>식량작물(10)</strong> : 벼(조사료용 벼), 밀, 감자(가을감자, 봄감자, 고랭지감자), 고구마, 옥수수(사료용 옥수수), 콩, 메밀, 팥, 보리, 귀리</li>
			<li><strong>채소(12)</strong> : 양파, 고추, 마늘, 양배추, 브로콜리, 배추(월동배추, 고랭지배추), 무(월동무, 고랭지무), 단호박, 당근, 파, 시금치, 양상추</li>
			<li><strong>특작(6)</strong> : 차, 오디, 인삼, 느타리버섯, 새송이버섯, 양송이버섯</li>
			<li><strong>임산물(6)</strong> : 표고버섯, 대추, 밤, 복분자, 오미자, 호두</li>
			<li><strong>시설작물(23)</strong> : 딸기, 오이, 참외, 토마토, 국화, 수박, 장미, 풋고추, 호박, 멜론, 파프리카, 상추, 부추, 시금치, 가지, 파, 배추, 무, 백합,<br />카네이션, 미나리, 쑥갓, 감자</li>
			<li><strong>수입보장(7)</strong> : 콩, 포도, 양파, 마늘, 고구마, 가을감자, 양배추</li>
		</ul>
	</div>
</div>
			
<script>
	var jq=true;

	function excelDown(){
	//230918 API 변경 작업 중 엑셀다운로드 기능 일시 정지
	//alert("현재 작업중이라 엑셀다운로드가 불가 합니다 \n불편을 드려 죄송합니다.")
	//return false;
	if(jq){dn()};
	setTimeout("exportExcel('Chart2')",1000);
	}
	function dn(){

	 $('#event_list').jqGrid({
			datatype: 'json',
			url: gridUrl,
			mtype: 'POST',
			colModel: [			//	API 요청 방식으로 변경하여 index, name 의 값을 변경함
				{ label: '대분류', index: 'c1', name: 'c1',  align : 'center', sortable:false},
				{ label: '중분류', index: 'c2', name: 'c2',  align : 'center', sortable:false},
				{ label: '소분류', index: 'c3', name: 'c3',  align : 'center', sortable:false},
				{ label: '가입면적', index: 'v1', name: 'v1',  align : 'center', sortable:false},
				{ label: '가입농가수', index: 'v2', name: 'v2', align : 'center', sortable:false},
				{ label: '가입건수', index: 'v3', name: 'v3',  align : 'left', sortable:false},
				{ label: '가입농지수', index: 'v4', name: 'v4', align : 'center', sortable:false},
				{ label: '가입금액', index: 'v5', name: 'v5',  align : 'center', sortable:false},
				{ label: '순보험료', index: 'v6', name: 'v6', align : 'center', sortable:false },
				{ label: '지급보험금', index: 'v7', name: 'v7', align : 'center', sortable:false},
				{ label: '가입률', index: 'v8', name: 'v8', align : 'center', sortable:false }
			],
			postData :{
				//searchTxt : $("#searchTxt").val(),
				searchYM : $('#searchYM').val(),		//	ex) 202108
				//searchYM : '201706',
				//chartKey : '1'
				searchKey : $('#searchKey').val(),
				strsearch : $('#Month').val(),
				searchType : '603'

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
				//exportExcel ('Chart1');

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
	function exportExcel ( pFileName ) {





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
	  html+="<tr><td colspan  ='11' bgcolor='#ffff99'>[주석]<br><br>1. 보험사업자(농협손보) 제공 데이터를 기반으로 산출되었습니다.<br>";
	  html+="2. 계약 변경, 해지 등으로 인한 보험료 환입의 합계가 보험료의 합계보다 큰 경우, 보험료가 음수(-)값으로 조회될 수 있습니다.<br>";
	  html+="3. 보험금 환입의 합계가 보험금 지급의 합계보다 큰 경우, 보험금이 음수(-)값으로 조회될 수 있습니다.<br>";
	  html+="4. 가입률(％, 면적기준)=가입면적&#47;대상면적*100<br>";
	  html+="5. 대상면적은 통계청 농림어업총조사 자료를 토대로 산출되었습니다.<br>";
	  html+="6. 19년도까지 데이터는 연도말(12월말) 기준으로만 조회가 가능하며, 20년 이후 실적에 한해 연중 월별 조회 가능합니다.<br>";
	  html+="<tr><td colspan  ='11' align='right'>(단위:ha, 호, 건, 백만원, ％)</td></tr>";
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
// 	  exportExcel2();
	  document.EXCEL_.submit();
	}
</script>

<script>		<!-- 2022.09.22 김동민 대리 추가 -->
	function s2ab(s) { 
		var buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
		var view = new Uint8Array(buf);  //create uint8array as viewer
		for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; //convert to octet
		return buf;    
	}
	function exportExcel2(){
		alert("exportExcel2실행");
		// step 1. workbook 생성
		var wb = XLSX.utils.book_new();

		// step 2. 시트 만들기 
		var newWorksheet = excelHandler.getWorksheet();
		
		// step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.  
		XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());

		// step 4. 엑셀 파일 만들기 
		var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});

		// step 5. 엑셀 파일 내보내기 
		saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName());
	}
	var excelHandler = {
			getExcelFileName : function(){
				alert("1");
				return 'xlax테스트.xlsx';
			},
			getSheetName : function(){
				alert("2");
				return 'Table Test Sheet';
			},
			getExcelData : function(){
				alert("3");
				return document.getElementById('event_list'); //테이블 아이디 
			},
			getWorksheet : function(){
				alert("4");
				return XLSX.utils.table_to_sheet(this.getExcelData());
			}
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
		$("#txtTitle").text(strTitleText + " > 품목별");
		
		var searchKey = $("#searchKey").val();
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
