<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<c:set var="today" value="<%=new java.util.Date()%>" />
<fmt:formatDate value="${today}" pattern="yyyy" var="end"/>
<script>
	var IndicatorsUrl =  "<c:url value='/front/contents/chart5ListPage.do'/>";
	var gridUrl = "<c:url value='/front/contents/chartDownload.do'/>";
	var gubunArr = [];

	<c:forEach var="codelist" items="${codelist}" varStatus="loop">
	gubunArr[${loop.count}] = '${codelist.m1}/${codelist.m2}/${codelist.gubun}';
	</c:forEach>

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

		searchYM = $('#searchKey').val();
		$('#searchYM').val(searchYM);
		var f = document.listFrm;
		f.target = "_self";
		f.action = IndicatorsUrl;
		f.submit();


	}

	function makeM2(str){
		var temp='';
		$("#searchB").find("option").remove();
		$("#searchB").append("<option value=''>중분류</option>");
		$("#searchB").append("<option value=''>전체</option>");
		$("#searchC").find("option").remove();
		$("#searchC").append("<option value=''>소분류</option>");
		$("#searchC").append("<option value=''>전체</option>");
		if(str==''){return;}
		gubunArr.forEach(function(entry) {
			txtArr = entry.split('/');
			if (txtArr[0] == str){
				if(txtArr[1] != temp){
					temp = txtArr[1];
					$("#searchB").append("<option value='"+txtArr[1]+"'>"+txtArr[1]+"</option>");
				}
			}
		  }, this);

	}

	function makeM3(str){
		var temp='';
		$("#searchC").find("option").remove();
		$("#searchC").append("<option value=''>소분류</option>");
		$("#searchC").append("<option value=''>전체</option>");
		if(str==''){return;}
		gubunArr.forEach(function(entry) {
			txtArr = entry.split('/');
			if (txtArr[1] == str){
					$("#searchC").append("<option value='"+txtArr[2]+"'>"+txtArr[2]+"</option>");
			}
		  }, this);

	}

	$(document).ready(function(){
		makeM2('${param.searchA}');
		makeM3('${param.searchB}');
		var tempSearchCStr = '${param.searchC}';
		tempSearchCStr = tempSearchCStr.replace("&amp; #40;", "(");
		tempSearchCStr = tempSearchCStr.replace("&amp;#41;", ")");
		tempSearchCStr = tempSearchCStr.replace("& #40;","(");
		tempSearchCStr = tempSearchCStr.replace("& #41;", ")");
		$('#searchB').val('${param.searchB}');
		$('#searchC').val(tempSearchCStr);
	});
</script>

<!--content_tit-->
<div class="content_tit" id="containerContent">
   <h3>보험료수준</h3>
</div>
<!--//content_tit-->

<!--content-->
<div class="content">
	<!-- tab_style -->
	<div class="tab_style">
		<ul>
			<li class="w2"><a href="#none" class="active" title="선택됨">농작물</a></li>
			<li class="w2"><a href="/front/contents/chart6ListPage.do?menuId=5368">가축</a></li>
		</ul>
	</div>
	<!-- //tab_style -->
	<div class="cont_search_area">
		<div class="cont_search_box w100">
			<form name="listFrm"  id="listFrm" method="post" onsubmit="return false;">
				<input type="hidden" name="searchType"  id="searchType" value="610">
				<input type="hidden" name="searchYM"  id="searchYM">
				<input type="hidden" name="menuId"  value="${param.menuId}">
				<div class="con_wrap">
					<dl>
						<dt><label for="searchA">품목</label></dt>
						<dd class="step_con">
							<fieldset>
								<select id="searchA" name = "searchA" class = "select_style" data-parsley-required="true" onchange="makeM2($(this).val());" title="품목 대분류">
									<option value="">대분류</option>
									<c:set var="temp" value=""/>
									<c:forEach var="codelist" items="${codelist}" varStatus="loop">
                          			<c:if test="${temp ne codelist.m1}">
									<option value="${codelist.m1}"  ${param.searchA eq codelist.m1?' selected':''}>${codelist.m1}</option>
									<c:set var="temp" value="${codelist.m1}"/>
									</c:if>
									</c:forEach>
								</select>
								<select id="searchB" name = "searchB" class = "select_style" data-parsley-required="true"  onchange="makeM3($(this).val());" title="품목 중분류">
									<option value="">중분류</option>
								</select>
								<select id="searchC" name = "searchC" class = "select_style" data-parsley-required="true"  title="품목 소분류">
									<option value="">소분류</option>
								</select>
							</fieldset>
						</dd>
					</dl>
					<dl>
						<dt><label for="searchKey">기준년도</label></dt>
						<dd>
							<fieldset>                          	
								<select id="searchKey" name = "searchKey" class = "select_style" data-parsley-required="true" >
									<c:forEach begin="2015" end="${end}" var="idx" step="1">
										<option value="<c:out value="${end-idx+2015}" />"  ${fn:substring(param.searchYM,0,4) eq end-idx+2015?' selected':''}><c:out value="${end-idx+2015}" /></option>
									</c:forEach>
								</select>
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
		<table class="table_style_auto">
			<caption>농작물 보험료수준 정보표로 지역,가입면적,가입농가수,순보험료,국고지원,시도지원,시군구지원,농가부담,ha당순보험료(원),ha당농가부담보험료(원) 정보를 제공함.</caption>
			<colgroup>
				<col width="12%" />
				<col width="8%" />
				<col span="2" width="10%" />
				<col span="2" width="8%" />
				<col width="10%" />
				<col width="8%" />
				<col width="12%" />
				<col width="14%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">지역</th>
					<th scope="col">가입면적</th>
					<th scope="col">가입농가수</th>
					<th scope="col">순보험료</th>
					<th scope="col">국고지원</th>
					<th scope="col">시도지원</th>
					<th scope="col">시군구지원</th>
					<th scope="col">농가부담</th>
					<th scope="col">ha당<br/>순보험료(원)</th>
					<th scope="col">ha당<br/>농가부담보험료(원)</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="chartlist2" items="${chartlist2}" varStatus="loop2">
				<tr>
					<td class="txt_cen">${chartlist2.c1}</td>
					<td><fmt:formatNumber value="${chartlist2.v1}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${chartlist2.v2}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${chartlist2.v3}" pattern="#,###" /></td><!-- 윤여경 : 가입금액 -->
					<td><fmt:formatNumber value="${chartlist2.v4}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${chartlist2.v5}" pattern="#,###" /></td><!-- 윤여경 : 보험금-->
					<td><fmt:formatNumber value="${chartlist2.v6}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${chartlist2.v7}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${chartlist2.v8}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${chartlist2.v9}" pattern="#,###" /></td>
				</tr>
				</c:forEach>
				<c:if test="${empty chartlist2}">
					<tr>
						<td colspan="10" class="txt_cen borBNone">조회된 결과가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>				
	</div>
	<p class="mt10">* 농협손보 제공 데이터를 기반으로 산출되었습니다.<br />
	<span style="color:#ea4200;">* 위 보험료는 실적 기준의 평균 보험료이며, 가입금액 및 개인별 할인·할증률에 따른 보험료가 달라질 수 있습니다.<br /></span>
	* 품목별 지역별 세부 자료는 엑셀 다운로드를 하시면 보실 수 있습니다.</p>
</div>

<script>
	var jq=true;

	function excelDown(){
		if(jq){dn()};
		//setTimeout("exportExcel('Chart5')",1000);
	}
	 function dn(){

		 $('#event_list').jqGrid({
				datatype: 'json',
				url: gridUrl,
				mtype: 'POST',
				colModel: [
					{ label: '대분류', index: 'c1', name: 'c1',  align : 'center', sortable:false},
					{ label: '중분류', index: 'c2', name: 'c2',  align : 'center', sortable:false},
					{ label: '소분류', index: 'c3', name: 'c3',  align : 'center', sortable:false},
					{ label: '지역', index: 'c4', name: 'c4',  align : 'center', sortable:false},
					{ label: '가입면적', index: 'v1', name: 'v1',  align : 'center', sortable:false},
					{ label: '가입농가수', index: 'v2', name: 'v2',  align : 'center', sortable:false},
					{ label: '순보험료', index: 'v3', name: 'v3',  align : 'center', sortable:false},
					{ label: '국고', index: 'v4', name: 'v4', align : 'center', sortable:false},
					{ label: '시도', index: 'v5', name: 'v5',  align : 'left', sortable:false},
					{ label: '시군구', index: 'v6', name: 'v6',  align : 'left', sortable:false},
					{ label: '농가부담', index: 'v7', name: 'v7', align : 'center', sortable:false},
					{ label: 'ha당 순보험료(원)', index: 'v8', name: 'v8',  align : 'center', sortable:false},
					{ label: 'ha당 농가부담보험료(원)', index: 'v9', name: 'v9', align : 'center', sortable:false }
				],
				postData :{
					searchTxt : $("#searchTxt").val(),
					searchYM : $('#searchKey').val(),
					//chartKey : '5'
					searchKey : $('#searchKey').val(),
					searchA : $('#searchA').val(),
					searchB : $('#searchB').val(),
					searchC : $('#searchC').val(),
					searchType : '609'            

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
					exportExcel('Chart5');
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
		  html+="<tr><td colspan='13' bgcolor='#ffff99'>[주석]<br><br>1. 보험사업자(농협손보) 제공 데이터를 기반으로 산출되었습니다.<br>";
		  html+="2. 계약 변경, 해지 등으로 인한 보험료 환입의 합계가 보험료의 합계보다 큰 경우, 보험료가 음수(-)값으로 조회될 수 있습니다.<br>";
		  html+="3. 보험금 환입의 합계가 보험금 지급의 합계보다 큰 경우, 보험금이 음수(-)값으로 조회될 수 있습니다.<br>";
		  html+="4. 가입률(％, 면적기준)=가입면적&#47;대상면적*100<br>";
		  html+="5. 대상면적은 통계청 농림어업총조사 자료를 토대로 산출되었습니다.<br>";
		  html+="6. 19년도까지 데이터는 연도말(12월말) 기준으로만 조회가 가능하며, 20년 이후 실적에 한해 연중 월별 조회 가능합니다.<br>";
		  html+="<tr><td colspan='13' align='right'>(단위:ha, 호, 백만원)</td></tr>";
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
			   for(var j=0; j< colNames.length;j++){
				   html=html + '<td>' + encodeURIComponent(datac[colNames[j]])+"</td>";
			   }
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
		$("#txtTitle").text(strTitleText + " > 농작물");
	});
</script>
