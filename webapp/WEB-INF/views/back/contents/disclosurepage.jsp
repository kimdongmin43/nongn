<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
var savedRow = null;
var savedCol = null;
var selectdisclosureUrl = "<c:url value='/back/contents/disclosurePageList.do'/>";
var disclosureWriteUrl =  "<c:url value='/back/contents/disclosureWrite.do'/>";
var insertdisclosureUrl = "<c:url value='/back/contents/insertdisclosure.do'/>";
var updatedisclosureUrl =  "<c:url value='/back/contents/updatedisclosure.do'/>";
var disUrl =  "<c:url value='/back/contents/disclosurePage.do'/>";

$(document).ready(function(){
	
	
	/* alert(JSON.stringify(intropage)); */
	
	
	$('#intropage_list').jqGrid({
		datatype: 'json',
		url: selectdisclosureUrl,
		mtype: 'POST',
		colModel: [
			//{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', formatter:jsRownumFormmater},
			{ label: '연도', index: 'year', name: 'year', align : 'center', width:50 },
			{ label: '공시일자', index: 'disDt', name: 'disDt', align : 'center', width:50 , formatter:jsTitleLinkFormmater},
			{ label: '공시품목', index: 'disItem', name: 'disItem', align : 'left', width:100},
			{ label: '공시단위', index: 'disUnit', name: 'disUnit', align : 'left', width:50},
			{ label: '산출가격구분', index: 'gu', name: 'gu', align : 'center', width:50},
			{ label: '공시금액', index: 'disPrice', name: 'disPrice', align : 'left', width:50},
	
		],
		postData :{	
		 	searchKey : $("#searchKey").val(),
		 	searchKey2 : $("#searchKey2").val(),
		 	searchKey3 : $("#searchKey3").val(),
        	searchTxt : $("#searchTxt").val(),
        	searchTxt2 : $("#searchTxt2").val(),
        	searchTxt3 : $("#searchTxt3").val()
		
		},
/* 		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#intropage_pager', */
		viewrecords : true,
		height : "1500px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit: true,
		editable: true,
		edittype :"text",
		cellsubmit : 'clientArray',
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
		},
		onSelectRow : function(rowid, status, e) {
			var ret = jQuery("#intropage_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "intropage_list");
		   return 'stop';
		},   
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },	
		//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
		loadComplete : function(data) {
			
			showJqgridDataNon(data, "intropage_list",7);

		}

		$("#skip_nav").focus();		//	키보드 이동을 위해 포커스 - 2020.10.19    

	});
	//jq grid 끝 
	
	jQuery("#intropage_list").jqGrid('navGrid', '#intropage_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("intropage_list", "intropage_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:disclosureWrite('"+rowObject.disId+"')\">"+rowObject.disDt+"</a>";
	
	return str;
}






function disclosureWrite(disId) {
    var f = document.listFrm;
    var mode = '';
    mode = 'W';
    if(disId != "") mode = "E";
    
	$("#mode").val(mode);
	$("#disId").val(disId);
	
    f.action = disclosureWriteUrl;
    f.submit();
  
}

function getSelectValue(frm)
{

 frm.searchTxt.value = frm.searchKey.options[frm.searchKey.selectedIndex].value;
 frm.searchTxt2.value = frm.searchKey2.options[frm.searchKey2.selectedIndex].value;
 frm.searchTxt3.value = frm.searchKey3.options[frm.searchKey3.selectedIndex].value;
}



function search() {

	var f = document.listFrm;
    f.target = "_self";
    f.action = disUrl;
    f.submit();


}



</script>

<!--// content -->
<div id="content">
	<!-- title_and_info_area -->
	<div class="title_and_info_area">
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title">${MENU.menuNm}</h3>
		</div>
	<div class="float_right">
			<a href="javascript:disclosureWrite('')" class="btn acti" title="등록">
				<span>등록</span>
			</a>
	</div>
		
		<!--// main_title -->
		 <jsp:include page="/WEB-INF/views/back/menu/menuDescInclude.jsp"/>
	</div>	
	<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="mode" name='mode' value="W" />
    <input type='hidden' id="disId" name='disId' value="${param.disId}" />
	
	<%-- <div class="cont_search_area">
                    	<div class="cont_search_box">
                       	  <dl>
                            	<dt><label for="" >기준년도</label></dt>
                                <dd>
                                 <fieldset>
                                	<select name="searchKey" id="searchKey" title="검색옵션"  onChange="getSelectValue(this.form);">
                                        <option value="" selected>전체</option>
                                        <option value="2017" <c:if test="${param.searchTxt == '2017'}">selected</c:if>>2017</option>
                                        <option value="2016" <c:if test="${param.searchTxt == '2016'}">selected</c:if>>2016</option>
                          
                                    </select>
                                    </fieldset>
                                  <input type="hidden" name="searchTxt" id="searchTxt" value="${param.searchTxt}">
                      
                                </dd>
                            </dl>
                          <dl>
                            	<dt><label for="" class="pl20">품목</label></dt>
                                <dd>
                                   <fieldset>
                                	<select name="searchKey2" id="searchKey2" title="품목 옵션" onChange="getSelectValue(this.form);">
                                    	<option value="" selected>전체</option>
                                        <option value="감자 대지" <c:if test="${param.searchTxt2 == '감자 대지'}">selected</c:if>>감자 대지</option>
                                        <option value="고구마 풍원미" <c:if test="${param.searchTxt2 == '고구마 풍원미'}">selected</c:if>>고구마 풍원미</option>
                                        <option value="나물콩" <c:if test="${param.searchTxt2 == '나물콩'}">selected</c:if>>나물콩</option>
                                        <option value="마늘(난지형 남도종)" <c:if test="${param.searchTxt2 == '마늘(난지형 남도종)'}">selected</c:if>>마늘(난지형 남도종)</option> 
                                        <option value="마늘(난지형 대서종)" <c:if test="${param.searchTxt2 == '마늘(난지형 대서종)'}">selected</c:if>>마늘(난지형 대서종)</option> 
                                        <option value="마늘(한지형)" <c:if test="${param.searchTxt2 == '마늘(한지형)'}">selected</c:if>>마늘(한지형)</option> 
                                        <option value="밤고구마" <c:if test="${param.searchTxt2 == '밤고구마'}">selected</c:if>>밤고구마</option> 
                                        <option value="배추" <c:if test="${param.searchTxt2 == '배추'}">selected</c:if>>배추</option> 
                                        <option value="양파" <c:if test="${param.searchTxt2 == '양파'}">selected</c:if>>양파</option> 
                                        <option value="콩 백태" <c:if test="${param.searchTxt2 == '콩 백태'}">selected</c:if>>콩 백태</option> 
                                        <option value="콩 서리태" <c:if test="${param.searchTxt2 == '콩 서리태'}">selected</c:if>>콩 서리태</option> 
                                        <option value="콩 흑태" <c:if test="${param.searchTxt2 == '콩 흑태'}">selected</c:if>>콩 흑태</option>
                                        <option value="포도 거봉" <c:if test="${param.searchTxt2 == '포도 거봉'}">selected</c:if>>포도 거봉</option>                                     
                                        <option value="포도 델라웨어" <c:if test="${param.searchTxt2 == '포도 델라웨어'}">selected</c:if>>포도 델라웨어</option>
                                        <option value="포도 마스캇베리에이" <c:if test="${param.searchTxt2 == '포도 마스캇베리에이'}">selected</c:if>>포도 마스캇베리에이</option>
                                        <option value="포도 샤인마스캇" <c:if test="${param.searchTxt2 == '포도 샤인마스캇'}">selected</c:if>>포도 샤인마스캇</option>
                                        <option value="포도 캠벨얼리" <c:if test="${param.searchTxt2 == '포도 캠벨얼리'}">selected</c:if>>포도 캠벨얼리</option>   
                                        <option value="호박고구마" <c:if test="${param.searchTxt2 == '호박고구마'}">selected</c:if>>호박고구마</option>          
                                    </select>
                                    </fieldset>
                                          <input type="hidden" name="searchTxt2" id="searchTxt2" value="${param.searchTxt2}">
                                </dd>
                                <dt><label for="" class="pl20">산출구분</label></dt>
                                <dd>
                                   <fieldset>
                                	<select name="searchKey3" id="searchKey3" title="산출구분 옵션" onChange="getSelectValue(this.form);">
                                        <option value="" selected>전체</option>
                                        <option value="F" <c:if test="${param.searchTxt3 == 'F'}">selected</c:if>>기준가격</option>
                                        <option value="L" <c:if test="${param.searchTxt3 == 'L'}">selected</c:if>>수확기가격</option>                            
                                    </select>
                                    </fieldset>
                                      <input type="hidden" name="searchTxt3" id="searchTxt3" value="${param.searchTxt3}">
                                </dd>
                            </dl>
                            <button class="btn sch" title="검색하기" onclick="search();">
                                검색
                            </button>
       
                        </div>
                    </div> --%>
		<div class="search_area">
			<table class="search_box">
				<caption>코드구분검색</caption>
				<colgroup>
					<col style="width: 80px;" />

				</colgroup>
				<tbody>
					<tr>
						<th><label for="p_searchkey">검색조건</label></th>
						<td><label for="p_searchkey">기준년도: </label> <select
							name="searchKey" id="searchKey" title="검색옵션"
							onChange="getSelectValue(this.form);">
								<option value="" selected>전체</option>
								<option value="2017"
									<c:if test="${param.searchTxt == '2017'}">selected</c:if>>2017</option>
								<option value="2016"
									<c:if test="${param.searchTxt == '2016'}">selected</c:if>>2016</option>

						</select> <input type="hidden" name="searchTxt" id="searchTxt"
							value="${param.searchTxt}"> <label for="" class="pl20">품목: </label>


							<select name="searchKey2" id="searchKey2" title="품목 옵션"
							onChange="getSelectValue(this.form);">
								<option value="" selected>전체</option>
								<option value="감자 대지"
									<c:if test="${param.searchTxt2 == '감자 대지'}">selected</c:if>>감자
									대지</option>
								<option value="고구마 풍원미"
									<c:if test="${param.searchTxt2 == '고구마 풍원미'}">selected</c:if>>고구마
									풍원미</option>
								<option value="나물콩"
									<c:if test="${param.searchTxt2 == '나물콩'}">selected</c:if>>나물콩</option>
								<option value="마늘(난지형 남도종)"
									<c:if test="${param.searchTxt2 == '마늘(난지형 남도종)'}">selected</c:if>>마늘(난지형
									남도종)</option>
								<option value="마늘(난지형 대서종)"
									<c:if test="${param.searchTxt2 == '마늘(난지형 대서종)'}">selected</c:if>>마늘(난지형
									대서종)</option>
								<option value="마늘(한지형)"
									<c:if test="${param.searchTxt2 == '마늘(한지형)'}">selected</c:if>>마늘(한지형)</option>
								<option value="밤고구마"
									<c:if test="${param.searchTxt2 == '밤고구마'}">selected</c:if>>밤고구마</option>
								<option value="배추"
									<c:if test="${param.searchTxt2 == '배추'}">selected</c:if>>배추</option>
								<option value="양파"
									<c:if test="${param.searchTxt2 == '양파'}">selected</c:if>>양파</option>
								<option value="콩 백태"
									<c:if test="${param.searchTxt2 == '콩 백태'}">selected</c:if>>콩
									백태</option>
								<option value="콩 서리태"
									<c:if test="${param.searchTxt2 == '콩 서리태'}">selected</c:if>>콩
									서리태</option>
								<option value="콩 흑태"
									<c:if test="${param.searchTxt2 == '콩 흑태'}">selected</c:if>>콩
									흑태</option>
								<option value="포도 거봉"
									<c:if test="${param.searchTxt2 == '포도 거봉'}">selected</c:if>>포도
									거봉</option>
								<option value="포도 델라웨어"
									<c:if test="${param.searchTxt2 == '포도 델라웨어'}">selected</c:if>>포도
									델라웨어</option>
								<option value="포도 마스캇베리에이"
									<c:if test="${param.searchTxt2 == '포도 마스캇베리에이'}">selected</c:if>>포도
									마스캇베리에이</option>
								<option value="포도 샤인마스캇"
									<c:if test="${param.searchTxt2 == '포도 샤인마스캇'}">selected</c:if>>포도
									샤인마스캇</option>
								<option value="포도 캠벨얼리"
									<c:if test="${param.searchTxt2 == '포도 캠벨얼리'}">selected</c:if>>포도
									캠벨얼리</option>
								<option value="호박고구마"
									<c:if test="${param.searchTxt2 == '호박고구마'}">selected</c:if>>호박고구마</option>
						</select> <input type="hidden" name="searchTxt2" id="searchTxt2"
							value="${param.searchTxt2}"> <label for="" class="pl20">산출구분:</label>

							<select name="searchKey3" id="searchKey3" title="산출구분 옵션"
							onChange="getSelectValue(this.form);">
								<option value="" selected>전체</option>
								<option value="F"
									<c:if test="${param.searchTxt3 == 'F'}">selected</c:if>>기준가격</option>
								<option value="L"
									<c:if test="${param.searchTxt3 == 'L'}">selected</c:if>>수확기가격</option>
						</select> <input type="hidden" name="searchTxt3" id="searchTxt3"
							value="${param.searchTxt3}"></td>

					</tr>
				</tbody>
			</table>
			<div class="search_area_btnarea">
				<a href="javascript:search();" class="btn sch" title="조회"> <span>조회</span>
				</a>

			</div>
		</div>




		<!-- table 1dan list -->
	<div class="table_area" id="intropage_list_div" >
	    <table id="intropage_list"></table>
        <div id="intropage_pager"></div>
	</div>
	<!--// table 1dan list -->
<!--// content -->
		</form>
	</div>
