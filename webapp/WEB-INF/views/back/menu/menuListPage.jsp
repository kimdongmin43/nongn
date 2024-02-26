<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link href="/assets/jstree/dist/themes/default/style.min.css" rel="stylesheet" />
<script src="/assets/jstree/dist/jstree.js"></script>

<script>
var selectMenuTreeListUrl = "<c:url value='/back/menu/menuTreeList.do'/>";
var selectMenuListUrl = "<c:url value='/back/menu/menuList.do'/>";
var selectMenuUrl = "<c:url value='/back/menu/menu.do'/>";
var menuWriteUrl = "<c:url value='/back/menu/menuWrite.do'/>";
var insertMenuUrl = "<c:url value='/back/menu/insertMenu.do'/>";
var updateMenuUrl = "<c:url value='/back/menu/updateMenu.do'/>"
var deleteMenuUrl = "<c:url value='/back/menu/deleteMenu.do'/>";
var menuReorderUrl = "<c:url value='/back/menu/updateMenuReorder.do'/>";

var savedRow = null;
var savedCol = null;
var refresh_check = "N";
var menu_jstree = null;
var menu_jqgrid = null;
var hideInProgress = false;
var showModalId = '';



$(document).ready(function(){



	menu_jstree = $('#menu_jstree').jstree({
		"core" : {
			"data" : {
				'cache':false,
				'url' : selectMenuTreeListUrl,
				'data' : {
					siteCd : $("#siteCd").val()
				},
				//"dataType" : "json",
				'success': function(res) {
					//console.log(JSON.stringify(res));


				},
				'error' : function (e) {
					//alert(e);
				}
			},
			"check_callback" : true
		},
		'search' : {
			'fuzzy' : false
		},
        "types": {
        	   'default': {
                   'icon': 'jstree-folder'
               },
        	   'file': {
                   'icon': 'jstree-file'
               },
               'default-x': {
                   'icon': 'jstree-folder-x'
               },
        	   'file-x': {
                   'icon': 'jstree-file-x'
               }
        },
		"plugins" : [ "types", "search","contextmenu" ],
		"contextmenu" : {items: customMenu}
	}).bind("loaded.jstree refresh.jstree",function(event,data){


		menu_jstree.jstree("open_all");
		menu_jstree.jstree("select_node", '#'+$("#menuId").val());


		$(".jstree-anchor").click(function(){

			if($(this).find("i:first-child").hasClass("jstree-file")){

				menuWrite('E',$(this).closest("li").attr("id"));
				if($(this).closest("li").closest("li")!=undefined){
					setMenuInfo($(this).closest("li").closest("li").attr("id"));
		   		}
			}
		});


	}).bind("select_node.jstree", function (event, data) {

		$("#menuNavi").html("HOME");
		$("#menuId").val(data.node.id);
		$("#upMenuId").val(data.node.parent);
    		$("#depth").val(data.node.parents.length);

    		if(data.node.type = "default" ){
    			menuList(data.node.id);
        		setMenuInfo(data.node.id);
        	}else{

        		var parent = data.node.parent=="#"?"0":data.node.parent;
        		menuList(parent);
        		setMenuInfo(parent);
        	}
	});

	menu_jqgrid = $('#menuList').jqGrid({
		datatype: 'json',
		url: selectMenuListUrl,
		mtype: 'post',
		postData : {
			'siteCd' : $("#siteCd").val(),
			'menuId' : $("#menuId").val()
		},
		colModel: [
			{ label: '번호', index: 'sort', name: 'sort', width: 40, align : 'center' , sortable:false, editable:true,editoptions:{dataInit: function(element) {
				$(element).keyup(function(){
					chkNumber(element);
				});
			}}  },
			{ label: '메뉴타입', index: 'refCd', name: 'reCd', align : 'center', width:60, sortable:false , formatter:menuTypeFormmater},
			{ label: '메뉴명', index: 'menuNm', name: 'menuNm', align : 'left', width:80, sortable:false , formatter:jsTitleLinkFormmater},
			{ label: '경로', index: 'refUrl', name: 'refUrl', align : 'left', width:200, sortable:false},
			{ label: '사용여부', index: 'useYn', name: 'useYn', align : 'center', width:40, sortable:false},
			{ label: 'upMenuIdid', index: 'upMenuId', name: 'upMenuId',  hidden:true},
			{ label: 'menuId', index: 'menuId', name: 'menuId',  hidden:true},
			{ label: 'siteId', index: 'siteId', name: 'siteId',  hidden:true}
		],
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow;
			savedCol = iCol;
	    },
		loadComplete : function(data) {
			showJqgridDataNon(data, "menuList",4);
			$(".jstree-folder-x").closest("a").css("text-decoration","line-through");
			$(".jstree-file-x").closest("a").css("text-decoration","line-through");
		} ,
		onCellSelect: function(rowid, iCol,	cellcontent, e) {
			var ret = menu_jqgrid.jqGrid('getRowData', rowid);
			$("#ref_data_id").val(ret.ref_data_id);
		},
		onSelectRow: function(rowid, status) {
			$('#menuList').resetSelection();
			$("#menuList").jqGrid('setSelection',rowid);
		},
		rowNum : -1,
		autowidth: true,
		cellEdit: true,
		editable: true,
		edittype :"text",
		viewrecords : true,
		forceFit : false,
		shrinkToFit : true,
		cellsubmit : 'clientArray',
		height:"530px"
	});

	bindWindowJqGridResize("menuList", "menuListDiv");
});


function menuTypeFormmater(cellvalue, options, rowObject){
	var str = "";
	if(rowObject.refCd == 'C'){
		str = "콘텐츠";
	}
	else if(rowObject.refCd == 'F'){
		str = "폴더";		
	}
	else if(rowObject.refCd == 'B'){
		str = "게시판";
	}
	else if(rowObject.refCd == 'L'){
		str = "외부링크";
	}
		
	
	return str;
}

function searchMenuTree() {
	menu_jstree.jstree().settings.core.data.data = {'siteCd' : $("#siteCd").val() };
	menu_jstree.jstree().refresh();
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	var str = "<a href=\"javascript:menuWrite('E','"+rowObject.menuId+"')\">"+rowObject.menuNm+"</a>";
	return str;
}

function customMenu(node){
	   var items =  null
	   items =  {
                "create" : {
                    "separator_before" : false,
                    "separator_after"  : false,
                    "label"            : "추가",
                    "action"           : function (obj) {
                    	create(obj);
                      }
                }
	   }

	   return items;
}

function create(obj){
	var seq = 0;
	var arrrows = $("#menuList").getRowData(); //그리드에 있는 데이터를 배열화해 갖고온다
	seq = arrrows.length;

	menuWrite("W", $("#menuId").val(), seq);
}

function menuList(id){
	menu_jqgrid.jqGrid('setGridParam', {
		//datatype : 'json',
		url : selectMenuListUrl,
		page : 1,
		postData :{
			'siteCd' : $("#siteCd").val(),
			'upMenuId' : id
		},
		mtype : 'post'
	}).trigger("reloadGrid");

}

function setMenuInfo(menuId){

	if(menuId == '0'){
		return;
	}

	$.ajax({
        url: selectMenuUrl,
        //dataType: 'json',
        type: "post",
        data: {
        		siteCd : $("#siteCd").val(),
       	   	menuId : menuId
		},
        	success: function(data) {
        		if(data.menu!=null){
	        		var navi = data.menu.menuNavi2;
	        		navi = navi.split('>').join(' > ');
	        		$("#menuNavi").html(navi);
        		}
		}
    });

}

function menuWrite(mode, menuId) {
    
	var f = document.listFrm;

    if(mode == 'W' && $("#depth").val() > 3){
    	alert("메뉴는 3단계까지 생성이 가능합니다.");
    	return;
    }
    else if(mode == 'W' && $('#menuList').getGridParam('records')>=10){
    	var cnt=0;

    	console.log($('#menuList'));
  			/*
   		if($('#menuList')[i].getGridParam('use_yn')=='Y')
		{
  				cnt++;
		}
   			*/
   			
    	alert(cnt);
    	if(cnt>10)
   		{
	    	alert("메뉴는 최대 10개까지 생성 가능합니다");
	    	return;
   		}

    }



    if(menuId != "") $("#selMenuId").val(menuId);

    if($("#menuId").val() == ""){
    	alert("상위 메뉴를 선택해 주십시요.");
    	return;
    }

    if(menuId == '0') menuId = "";
	$('#pop_content').html("");
	$("#mode").val(mode);
     $.ajax({
        url: menuWriteUrl,
        dataType: "html",
        type: "post",
        data: {
        		siteCd : $("#siteCd").val(),
             	mode : mode,
       	   	menuId : menuId
		},
        	success: function(data) {
        	$('#pop_content').html(data);
        	popupShow();
        	$(".onlynum").keyup( setNumberOnly );

        	if(mode=='W'){
        		$('input:radio[name=refCd]').removeAttr("checked");
        		$('input:radio[name=refCd]:input[value=F]').prop("checked", true);

        		$("#menuNavi_W").html($("#menuNavi").html() + "> ");
        	}
        	changeMenuType();

        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });



}

function menuInsert(){



	   var url = "";
	   var target = $('input:radio[name=target_set]:checked').val();
	   var refCd = $('input:radio[name=refCd]:checked').val();
	   $("#refUrl").val($("#refCd_"+refCd+"").find("input[name=url]").val());

	   if($("#refUrl").val()=="" && refCd != "F"){
		   /* if(refCd=="F")
		 	   alert("참조메뉴 선택은 필수 입니다.");
		   else */

		   if(refCd=="C")
			   alert("콘텐츠 선택은 필수 입니다.");
		   else if(refCd=="B")
			   alert("게시판 선택은 필수 입니다.");
		   else if(refCd=="F")
			   alert("게시판 선택은 필수 입니다.");
		   else if(refCd=="P")
			   alert("프로그램 경로는 필수 입니다.");
		   else if(refCd=="L")
			   alert("외부링크 경로는 필수 입니다.");
		   else if(refCd=="K")
			   alert("연동게시판 선택은 필수 입니다.");
		   return;

	   }


		if(target == "_popup"){
			$('#width').attr('data-parsley-required', 'true');
			$('#height').attr('data-parsley-required', 'true');
			$('#top').attr('data-parsley-required', 'true');
			$('#left').attr('data-parsley-required', 'true');
		}else{
			$('#width').attr('data-parsley-required', 'false');
			$('#height').attr('data-parsley-required', 'false');
			$('#top').attr('data-parsley-required', 'false');
			$('#left').attr('data-parsley-required', 'false');
		}


	   if ( $("#writeFrm").parsley().validate() ){
		   
		   url = insertMenuUrl;
		   if($("#mode").val() == "E") url = updateMenuUrl;
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					//alert(responseText.message);
  					if(responseText.success == "true"){
  						popupClose();
  						searchMenuTree();
  						menuList();
  					}
  				},
  				dataType: "json",
  				url: url,
  				async : false,
  				data : {
  		        	siteCd : $("#siteCd").val(),
  		           	menuId : $("#selMenuId").val(),
  		            upMenuId : $("#menuId").val()
  				}
  		    });
	


	   }


}

function menuDelete(itemId){
	   if(!confirm("선택하신 메뉴 삭제 시 하부의 모든 메뉴도 삭제됩니다. 정말 삭제하시겠습니까?")) return;

		$.ajax
		({
			type: "POST",
	           url: deleteMenuUrl,
	           data:{
 		        	siteCd : $("#siteCd").val(),
  		           	menuId : $("#selMenuId").val(),
  		            upMenuId : $("#menuId").val()
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					searchMenuTree();
					menuList();
					popupClose();
				}
			}
		});
}

function menuReorder(){

	var updateRow = new Array();
	var saveCnt = 0;

	jQuery('#menuList').jqGrid('saveCell', savedRow, savedCol);

	var arrrows = $('#menuList').getRowData();
	if(arrrows != undefined && arrrows.length > 0)
		for(var i=0;i<arrrows.length;i++){
			//필수값 체크
			if(arrrows.length>0){
				if(arrrows[i].sort == '' || arrrows[i].sort == null){
					alert("번호는 필수값입니다. 확인후 다시입력해주세요");
					return;
				}
			}
			arrrows[i].menuNm="";
			updateRow[saveCnt++] = arrrows[i];
		}
	else {
		alert("번호를 저장할 코드가 없습니다.");
		return;
	}

	$.ajax
	({
		type: "POST",
           url: menuReorderUrl,
           data:{
            	menuList : JSON.stringify(updateRow)
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				searchMenuTree();
				menuList();
			}
		}
	});
}

function popupShow(){
	showModal('modal-menu-write');
	//$("#modal-menu-write").modal('show');

}

function popupClose(){

	hideModal('modal-menu-write');

	//$("#modal-menu-write").modal("hide");


}

function popupSearchShow(){
	$("#modal-menutype-list").modal('show');
}

function popupSearchClose(){
	$("#modal-menutype-list").modal("hide");
}

function menuListPage() {
    var f = document.listFrm;

    f.target = "_self";
    f.action = "/back/menu/menuListPage.do";
    f.submit();
}

function delFile(){
	$("#image").val("");
	$("#uploadedFile").hide();
}

function changeSiteCd(){
	$("#menuId").val("0");
	searchMenuTree();
	menuList();
}

function changeTargetSet(){
	var target = $('input:radio[name=target_set]:checked').val();

	if(target == "_popup"){
		setIdDisp("popup_field","S");
	}else{
		setIdDisp("popup_field","H");
	}
}

function changeMenuType(){
	var type = $('input:radio[name=refCd]:checked').val();
	$("#menuNm").val($("#originMenuNm").val());
	if(type=="B" || type=="C" || type=="F" || type=="K"){

		$("input:radio[name='targetCd']:radio[value='_self']").prop("checked",true);
		if(type!="F"){
		$("#menuNm").attr("readOnly","readOnly");
		$("#menuNm").attr("style","background-color:#ababab");
		}else
			{
			$("#menuNm").removeAttr("readOnly");
			$("#menuNm").removeAttr("style");
			}

	}else{
		$("input:radio[name='targetCd']:radio[value='_blank']").prop("checked",true);

		$("#menuNm").removeAttr("readOnly");
		$("#menuNm").removeAttr("style");


	}

	$("input[name='refCd']").each(function(){
	     if(type == $(this).val()) {
	    	 	setIdDisp("refCd_"+$(this).val(),"S");
	    	 	// $("#refCd_"+$(this).val()+"").find("input[name=url]").val($("#refUrl").val());
	     }
	     else {
	    	 	setIdDisp("refCd_"+$(this).val(),"H");
	     }
	 });

}

function treeExpand(){
	menu_jstree.jstree("open_all");
}

function treeClose(){
	menu_jstree.jstree("close_all");
}

function menuPopup(type){
	var title = "";
	var url = "";



	if(type == 'F'){
		title = "참조메뉴";
		url = "/back/menu/menuSearchPopup.do";
	}else if(type == 'C'){
		title = "콘텐츠";
		url = "/back/contents/intropageSearchPopup.do";
	}else if(type == 'B'){
		title = "게시판";
		url = "/back/board/boardSearchPopup.do";
	}else if(type == 'K'){
		title = "코참연동게시판";
		url = "/back/board/korchamBoardSearchPopup.do";
	}


	$("#menutype_title").html(title);

    $.ajax({
        url: url,
        dataType: "html",
        type: "post",
        data: {
        	siteCd : $("#siteCd").val(),
        	mainMenuId : $("#mainMenuId").val()
		},
        success: function(data) {
        	$('#pop_menutype').html(data);
        	popupSearchShow();
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

function showModal(elementId) {
    if (hideInProgress) {
        showModalId = elementId;
    } else {
        $("#" + elementId).modal("show");
    }
};

function hideModal(elementId) {
    hideInProgress = true;
    $("#" + elementId).on('hidden.bs.modal', hideCompleted);
    $("#" + elementId).modal("hide");

    function hideCompleted() {
        hideInProgress = false;
        if (showModalId) {
            showModal(showModalId);
        }
        showModalId = '';
        $("#" + elementId).off('hidden.bs.modal');
    }
};
</script>
   <form id="listFrm" name="listFrm" method="post" >
    <input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" />
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
   <input type='hidden' id="mode" name='mode' value="W" />
	<input type='hidden' id="menuId" name='menuId' value="0" />
	<input type='hidden' id="upMenuId" name='upMenuId' value="" />
    <input type='hidden' id="selMenuId" name='selMenuId' value="" />
    <input type='hidden' id="depth" name='depth' value="0" />

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

		<!-- search_area -->
		<div class="search_area" style="display:none;">
			 <table class="search_box">
				<caption>메뉴타이틀</caption>
				<colgroup>
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>
					사이트구분 : <%-- <g:select id="siteCd" name="siteCd" codeGroup="SITE_CD" selected="F" cls="in_wp200" onChange="changeSiteCd()" /> --%>
					<input name="siteCd" id="siteCd" value="F" />
					</th>
				</tr>
				</tbody>
			</table>
		</div>
		<!--// search_area -->

		<!-- area40 -->
		<div class="area40 marginr10">
              <div id="menu_jstree" style="height:630px;overflow:auto; border:1px solid silver; min-height:565px;">
             </div>
      		<a href="javascript:treeExpand()" class="btn acti" title="모두열기">
				<span>모두열기</span>
			</a>
      		<a href="javascript:treeClose()" class="btn acti" title="모두닫기">
				<span>모두닫기</span>
			</a>
		</div>
		<!--// area40 -->
		<!-- division -->
		<div class="division">
			<!-- title_area -->
			<div class="title_area">
				<h4 class="title">메뉴목록</h4>
			</div>
			<!--// title_area -->
			<!-- title_area -->
			<div class="title_area marginb8">
				<div class="float_left">
					<span id="menuNavi">HOME</span>
				</div>
				<div class="float_right">
					<a href="javascript:menuReorder()" class="btn acti" title="번호저장">
						<span>번호저장</span>
					</a>
					<a href="javascript:menuWrite('W', '')" class="btn acti" title="등록">
						<span>등록</span>
					</a>
				</div>
			</div>
			<!--// title_area -->
     		  <div class="panel-body"  id="menuListDiv" style="padding:2px">
              		<table id="menuList"></table>
              </div>

		</div>
		<!--// division -->

</div>
<!--// content -->
</form>

     <div class="modal fade" id="modal-menu-write" >
		<div class="modal-dialog modal-size-small" id="refresh-modal">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title">메뉴등록</h1>
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

	<div class="modal fade" id="modal-menutype-list">
		<div class="modal-dialog modal-size-small" style="width:910px;">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 id="menutype_title" class="pop_title">메뉴리스트</h1>
				<a href="javascript:popupSearchClose()" class="pop_close" title="페이지 닫기">
					<span>닫기</span>
				</a>
			</header>
			</div>
			<!-- //header -->
			<!-- container -->
			<div id="pop_container">
			<article>
				<div class="pop_content_area" style="text-align:center; width:100%; ">
				    <div  id="pop_menutype"  style="margin:10px;">
				    </div>
				</div>
			</article>
			</div>
			<!-- //container -->
		</div>
	</div>