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
var selectMainandPopupListUrl = "<c:url value='/back/main/mainImgList.do'/>";


var selectMainListUrl = "<c:url value='/back/main/mainListPage.do'/>";
var updateMainImgUrl = "<c:url value='/back/main/updateMainImg.do'/>";
var deleteMainImgUrl = "<c:url value='/back/main/deleteMainImg.do'/>";





$(document).ready(function(){

	$('#modal-banner-write').popup(); 

	$('#mainAndPopup_list').jqGrid({
		datatype: 'json',
		url: selectMainandPopupListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rNum', name: 'rNum', align : 'center', width:10, sortable:false},
			{ label: '코드', index: 'imgId', name: 'imgId', align : 'center', width:100, sortable:false,hidden:true},
			{ label: '코드2', index: 'notiId', name: 'notiId', align : 'center', width:100, sortable:false,hidden:true},
			{ label: '제목', index: 'title', name: 'title', align : 'center', sortable:false, width:200, formatter:jsTitleLinkFormmater},
			{ label: '사용여부', align : 'center', sortable:false, width:60, formatter:jsUseynLinkFormmater},
			{ label: '사용여부', index: 'useYn', name: 'useYn', align : 'left', width:0,sortable:false, hidden:true}
			
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
			showJqgridDataNon(data, "mainAndPopup_list",6);
		}
	});
	//jq grid 끝

	bindWindowJqGridResize("mainAndPopup_list", "mainAndPopup_list_div");

});

function jsTitleLinkFormmater(cellvalue, options, rowObject) {

	var str = "<a href=\"javascript:mainAndPopWrite('"+rowObject.imgId+"')\">"+rowObject.title+"</a>";

	return str;
}





function jsUseynLinkFormmater(cellvalue, options, rowObject) {

	var str = "사용";

	if(rowObject.useYn == "N") str = "미사용";

	return str;
}

function search() {


	jQuery("#mainAndPopup_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectMainandPopupListUrl,
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


function mainImgPop(imgId) {

	var mainId = $("#mainId").val();


	$("#imgId").val(imgId);


}

function mainAndPopWrite(imgId) {
	

    var f = document.listFrm;
	var mode = '';
	var useYnCnt = 0;
	var url = '';
	mode = 'W';    
	if(imgId != "") mode = "E";

	$('#pop_content').html("");
	$("#mode").val(mode);
	$("#imgId").val(imgId);
		
	url = $("#tabGbn").val()=="A"?"/back/main/mainImageWrite.do":"/back/main/popnotiWrite.do";

	$("#listFrm").ajaxSubmit({
        url: url,
        dataType: "html",
        success: function(data) {
        	$('#pop_content').html(data);
        	if($("#tabGbn").val()=='A'){
        		$(".pop_title").text("메인이미지 등록")
        	}else
        	{
        		$(".pop_title").text("팝업 등록")
        	}
        	
        	popupShow();
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });

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
  						closePopup();
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
					closePopup();
				}
			}
		});
}



function popupShow(){
	$("#modal-banner-write").popup('show');
}

function closePopup(){
	$("#modal-banner-write").popup('hide');
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
	<input type='hidden' id="imgId" name='imgId' />
	<input type='hidden' id="notiId" name='notiId'  />
	<input type = "hidden" id = "sectionCd" name = "sectionCd" value = "${sectionCd}">

		<!-- main_list_box -->
	<div class="main_list_box">
		<!-- <img height="550px" class="main_img" src="/images/back/common/main_list_img.pdng" alt="메인 레이아웃 이미지" /> -->
		<!-- main_list_area -->
		<div class="main_list_area">

			<!-- search_area -->
			
			<!--// search_area -->
			<c:if test ="${arearCd eq '5'}">
			<div class="information_area">
				- B타입 중간 영역 입니다.
			</div>
			</c:if>
			<div class="float_right">
					
					<a href="javascript:mainAndPopWrite('')" class="btn acti" title="등록">
						<span>등록</span>
					</a>
				</div>
			</div>


			<!-- tab_area -->
			<div class="tab_area" >
				<ul class="tablist"  >
					<li class="on">
						<a onclick="goTab('tabA',this);" title="메인이미지">
							<span>메인이미지</span>
						</a>
					</li>
					<li>
						<a onclick="goTab('tabC',this);" title="팝업">
							<span>팝업</span>
						</a>
					</li>
				</ul>
			</div>
			<!-- tab_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="mainAndPopup_list_div" >
	    <table id="mainAndPopup_list"></table>
	</div>
	<!--// table 1dan list -->
		<!-- tabel_search_area -->
		
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
				<h1 class="pop_title">배너 등록</h1>
				<a href="javascript:closePopup()" class="pop_close" title="페이지 닫기">
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
