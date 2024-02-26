<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>


<script>
var savedRow = null;
var savedCol = null;
var selectBannerListUrl = "<c:url value='/back/banner/bannerList.do'/>";
var bannerWriteUrl =  "<c:url value='/back/banner/bannerWrite.do'/>";
var insertBannerUrl = "<c:url value='/back/banner/insertBanner.do'/>";
var updateBannerUrl = "<c:url value='/back/banner/updateBanner.do'/>"
var deleteBannerUrl = "<c:url value='/back/banner/deleteBanner.do'/>";
var bannerReorderUrl = "<c:url value='/back/banner/updateBannerReorder.do'/>";

$(document).ready(function(){

	$('#modal-banner-write').popup();

	$('#banner_list').jqGrid({
		datatype: 'json',
		url: selectBannerListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'sort', name: 'sort', width: 50, align : 'center', editable : true, sortable:false,editoptions:{dataInit: function(element) {
				$(element).keyup(function(){
					chkNumber(element);
				});
			}}  },
			{ label: '코드', index: 'bannerId', name: 'bannerId', align : 'center', width:100, sortable:false,hidden:true},
			{ label: '제목', index: 'title', name: 'title', align : 'left', sortable:false, width:200, formatter:jsTitleLinkFormmater},
			{ label: '사용여부', align : 'center', sortable:false, width:60, formatter:jsUseynLinkFormmater},
			{ label: '사용여부', index: 'useYn', name: 'useYn', align : 'left', width:0,sortable:false, hidden:true},
			{ label: '클릭수', index: 'hit', name: 'hit', width: 40, align : 'center', sortable:false }
		],
		postData :{
			sectionCd : $("#sectionCd").val(),
			useYn : $("#pUseYn").val(),
			tabGbn : $("#tabGbn").val()
		   },
		rowNum : -1,
		viewrecords : true,
		height : "350px",
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
		loadComplete : function(data) {
			showJqgridDataNon(data, "banner_list",6);
		}
	});
	//jq grid 끝

	bindWindowJqGridResize("banner_list", "banner_list_div");

});

function jsTitleLinkFormmater(cellvalue, options, rowObject) {

	var str = "<a href=\"javascript:bannerWrite('"+rowObject.bannerId+"')\">"+rowObject.title+"</a>";

	return str;
}

function jsUseynLinkFormmater(cellvalue, options, rowObject) {

	var str = "사용";

	if(rowObject.useYn == "N") str = "미사용";

	return str;
}

function search() {


	jQuery("#banner_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectBannerListUrl,
		page : 1,
		postData : {
			sectionCd : $("#sectionCd").val(),
			useYn : $("input[name=pUseYn]:checked").val(),
			tabGbn : $("#tabGbn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");

}

function bannerWrite(bannerId) {

    var f = document.listFrm;
	var mode = '';
	var useYnCnt = 0;
	mode = 'W';



    if(bannerId != "") mode = "E";


    if(mode == 'W' && "${arearCd}" == 7 ){
    	var arrrows = $('#banner_list').getRowData();
    	if(arrrows != undefined && arrrows.length > 0)
    		for(var i=0;i<arrrows.length;i++){
    			if(arrrows.length>0){
    				if(arrrows[i].useYn == 'Y'){
    					useYnCnt++;
    				}
    			}
    		}
    	if (useYnCnt >= 23 ) {
    		alert("패밀리사이트는 최대 23개까지 생성 가능합니다");
    		return;
		}
    }

	$('#pop_content').html("");

	$("#mode").val(mode);
    $.ajax({
        url: bannerWriteUrl,
        dataType: "html",
        type: "post",
        data: {
           mode : mode,
  		   bannerId : bannerId,
  		   sectionCd : $("#sectionCd").val(),
  		   cTabGbn : $("#tabGbn").val()
		},
        success: function(data) {
        	$('#pop_content').html(data);
        	popupShow();
        	$("#sectionNm").val($("#sectionCd option:selected").text());
        	$("#cSectionCd").val($("#sectionCd option:selected").val());
        	$("#cTabGbn").val($("#tabGbn").val());
        	        	


        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });

}

function bannerInsert(){
	   var url = "";

	   if ( $("#writeFrm").parsley().validate() ){

		   url = insertBannerUrl;
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						search();
  						popupClose();
  					}
  				},
  				dataType: "json",
  				url: url
  		    });

	   }
}



function bannerSave(){


	   var url = "";

	   if ( $("#writeFrm").parsley().validate() ){

		   url = updateBannerUrl;
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						search();
  						popupClose();
  					}
  				},
  				dataType: "json",
  				url: url
  		    });

	   }
	}


function bannerDelete(bannerId){
	   if(!confirm("선택하신 배너를 정말 삭제하시겠습니까?")) return;

		$.ajax
		({
			type: "POST",
	           url: deleteBannerUrl,
	           data:{
	           	bannerId : bannerId
	           	,cTabGbn : $("#tabGbn").val()
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					search();
					popupClose();
				}
			}
		});
}


function bannerReorder(){
	var dataArray = new Array();
	var data = new Object();
	var saveCnt = 0;

	jQuery('#banner_list').jqGrid('saveCell', savedRow, savedCol);

	var arrrows = $('#banner_list').getRowData();
	if(arrrows != undefined && arrrows.length > 0)
		for(var i=0;i<arrrows.length;i++){
			//필수값 체크
			if(arrrows.length>0){
				if((arrrows[i].sort == '' || arrrows[i].sort == null) && arrrows[i].useYn == 'Y'){
					alert("사용중인 배너의 번호는 필수값입니다. 확인 후 다시입력해주세요");
					return;
				}
			}
			arrrows[i].title="";
			var bannerSort =  new Object();
			if (arrrows[i].useYn == 'Y') {
				bannerSort.sort= arrrows[i].sort;
				bannerSort.bannerId=arrrows[i].bannerId;
				bannerSort.cTabGbn = $("#tabGbn").val();
				dataArray.push(bannerSort);
			}

		}
	else {
		alert("번호를 저장할 코드가 없습니다.");
		return;
	}
	data.data = JSON.stringify(dataArray) ;
	$.ajax
	({
		type: "POST",
           url: bannerReorderUrl,
           data: data,
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				search();
			}
		}
	});
}

function formReset(){
	$("select[name=p_use_yn] option[value='']").attr("selected",true);
}

function popupShow(){
	$("#modal-banner-write").popup('show');
}

function popupClose(){
	$("#modal-banner-write").popup('hide');
}

function delFile(){
	$("#image").val("");
	$("#uploadedFile").hide();
}

function goTab(id, obj){

	$(obj).parents(".tablist").find("li").removeClass("on");
	$(obj).parent().addClass("on");

	if (id=="tabA") {
		$("#tabGbn").val("A");
	}
	else
	{
		$("#tabGbn").val("B");
	}
	search();
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
		<!--// main_title -->
		<jsp:include page="/WEB-INF/views/back/menu/menuDescInclude.jsp"/>
	</div>
    <!--// title_and_info_area -->
	<form id="listFrm" name="listFrm" method="post">
	<input type='hidden' id="mode" name='mode' value="W" />
	<input type='hidden' id="tabGbn" name='tabGbn' value="A" />
	<input type = "hidden" id = "sectionCd" name = "sectionCd" value = "${sectionCd}">

		<!-- main_list_box -->
	<div class="main_list_box">
		<!-- <img height="550px" class="main_img" src="/images/back/common/main_list_img.pdng" alt="메인 레이아웃 이미지" /> -->
		<!-- main_list_area -->
		<div class="main_list_area">

			<!-- search_area -->
			<div class="search_area">
				 <table class="search_box">

					<caption>배너검색</caption>
					<colgroup>
						<col style="width: 70px;" />
						<col style="width: 200px;" />
					</colgroup>
					<tbody>

					<tr>
						<th>사용여부</th>
						<td>
		                  	<input type="radio" id = "pUseYn" name = "pUseYn" checked="checked" value = "">&nbsp;전체
		                 	<input type="radio" id = "pUseYn" name = "pUseYn" value = "Y">&nbsp;사용
		                 	<input type="radio" id = "pUseYn" name = "pUseYn" value = "N">&nbsp;미사용

						</td>

						<td>
						<!-- onchange="search()" -->
						<!-- <div style="visibility: hidden;"> -->
						<div>

						</div>
						</td>
					</tr>
					</tbody>
				</table>
				<div class="search_area_btnarea">
					<a href="javascript:search();" class="btn sch" title="조회">
						<span>조회</span>
					</a>
					<a href="javascript:formReset();" class="btn clear" title="초기화">
						<span>초기화</span>
					</a>
				</div>
			</div>
			<!--// search_area -->
			<c:if test ="${arearCd eq '5'}">
			<div class="information_area">
				- B타입 중간 영역 입니다.
			</div>
			</c:if>
			<div class="float_right">
					<a href="javascript:bannerReorder()" class="btn acti" title="번호저장">
						<span>번호저장</span>
					</a>
					<a href="javascript:bannerWrite('')" class="btn acti" title="등록">
						<span>등록</span>
					</a>
				</div>
			</div>


			<!-- tab_area -->
			<div class="tab_area" >
				<ul class="tablist"  >
			<%-- 		<li class="on">
						<a onclick="goTab('tabA',this);" title="지역">
							<span>지역</span>
						</a>
					</li>
					<c:if test = "${USER.userCd eq '999' and arearCd ne '7'}">
					<li>
						<a onclick="goTab('tabC',this);" title="일괄">
							<span>일괄</span>
						</a>
					</li>
					</c:if> --%>
				</ul>
			</div>
			<!-- tab_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="banner_list_div" >
	    <table id="banner_list"></table>
	</div>
	<!--// table 1dan list -->
		<!-- tabel_search_area -->

		<div class="information_area">
								<c:if test="${arearCd eq '1'}">- 배너 6개 이상 등록시,자동롤링<br></c:if>
								<c:if test="${arearCd eq '7'}">- 패밀리사이트는 23개 이하에 최적화 되어있습니다. <br></c:if>
								- 번호를 클릭하여 숫자를 입력한 후, "번호저장" 버튼을 누르면 적용됩니다. (작은 숫자가 우선표시됨)
		</div>
			<!--// tabel_search_area -->
			</div>

		<!--// main_list_area -->
	</form>
	</div>
	<!--// main_list_box -->


<!--// content -->

  <div id="modal-banner-write" style="width:600px;background-color:white">
		<div id="wrap">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title">${MENU.menuNm}</h1>
				<a href="javascript:popupClose()" class="pop_close" title="페이지 닫기">
					<span>닫기</span>
				</a>
			</header>
			</div>
			<!-- //header -->
			<!-- container -->
			<div id="pop_container">
			<article>
				<div class="pop_content_area">
				    <div  id="pop_content" >
				    </div>
				</div>
			</article>
			</div>
			<!-- //container -->
		</div>
  </div>
