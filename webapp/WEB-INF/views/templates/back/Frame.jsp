<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@page import="kr.apfs.local.common.util.StringUtil"%>
<%@page import="kr.apfs.local.common.util.ConfigUtil"%>
<!DOCTYPE html>
<html lang="ko" xml:lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<title>농업정책보험금융원</title>

		<!--[if lt IE 9]>
			<script src="/js/html5.js"></script>
		<![endif]-->

	    <script src="/assets/jquery/jquery-1.9.1.min.js"></script>
	    <script src="/assets/bootstrap/js/bootstrap.min.js"></script>
	    <script src="/assets/parsley/dist/parsley.js"></script>
	    <script src="/assets/parsley/dist/i18n/ko.js"></script>
	    <script src="/assets/jquery-ui/ui/minified/jquery-ui.min.js"></script>
		<script src="/assets/jquery/jquery.form.js"></script>
		<script src="/assets/jquery/jquery.popupoverlay.js"></script>
	    <script src="/assets/jqgrid/i18n/grid.locale-kr.js"></script>
		<script src="/assets/jqgrid/jquery.jqGrid.js"></script>
		<script src="/assets/jqgrid/jquery.jqGrid.ext.js"></script>
		<script src="/assets/jqgrid/jquery.loadJSON.js"></script>
		<script src="/assets/jqgrid/jquery.tablednd.js"></script>
		<script src="/js/common.js"></script>

	   <link rel="stylesheet" type="text/css" href="/assets/font-awesome/css/font-awesome.min.css"/>
	   <link rel="stylesheet" type="text/css" href="/assets/bootstrap/css/sticky-footer.css" />
	   <link rel="stylesheet" type="text/css" href="/assets/jqgrid/css/ui.jqgrid.css" />
	   <link rel="stylesheet" type="text/css" href="/assets/jqgrid/css/ui.jqgrid-bootstarp.css" />
	   <link rel="stylesheet" type="text/css" href="/assets/jquery-ui/themes/base/jquery-ui.css" />
	   <link rel="stylesheet" type="text/css" href="/css/back/style.css" />
	   <link rel="stylesheet" type="text/css" href="/css/back/default.css" />
	   <link rel="stylesheet" type="text/css" href="/css/back/common.css" />
	   <link rel="stylesheet" type="text/css" href="/css/back/table.css" />
	   <link rel="stylesheet" type="text/css" href="/css/back/layout.css" />
       <link rel="stylesheet" type="text/css" href="/css/back/sub.css" />
		<link rel="stylesheet" type="text/css" href="/css/back/popup.css" />
		<link rel="stylesheet" type="text/css" href="/css/modal.css" />

		<script>
			$(document).ready(function(){
			      // 메뉴를 생성해준다.
			      var tMi = '${MENU.topMenuId}'!=''?parseInt('${MENU.topMenuId}'):'';

				$.ajax
				({
					type: "POST",
		           	url: "/back/menu/authMenuList.do",
		           	data:{
			            userCd : '${USER.userCd}',
			            topMenuId : tMi,
			            upMenuId : '${param.menuId}',
			            gubun : $("#gubun").val()
		           	},
		           	dataType: 'json',
					success:function(data){
						createTopMenu(data.topMenuList);
						createSubMenu(data.subMenuList, data.boardList,data.gubun,data.notBoardList);
					}
				});
			});
			// full bg
			$(document).ready(function(){
				$('.left_area').css('min-height', $(document).height() - 0 );
			});

			$(document).ready(function(){
				$('#lnb_split').css('min-height', $(document).height() - 114 );
			});

			$(document).ready(function(){
				$('.lnb_split_box').css('min-height', $(document).height() - 0 );
			});

			$(document).ready(function(){
				$('.btn_split').css('min-height', $(document).height() - 0 );
			});
			//$(window).height() -> 천체 길이
			//-top height

			function createTopMenu(list){

				var str = "", url = "", sizepos = "", url2 = "";
				var menu;
				url2 = location.href;

				for(var i =0; i < list.length;i++){
					menu = list[i];
					url = "<%=(String)ConfigUtil.getProperty("system.server.backUrl") %>";

					if(menu.httpsYn == 'N') url = 'http://'+url;
					else  url = 'https://'+url+":<%=(String)ConfigUtil.getProperty("system.server.httpsPort") %>";
					url = "";
					sizepos = jsNvl(menu.width)+"/"+jsNvl(menu.height)+"/"+jsNvl(menu.left)+"/"+jsNvl(menu.top);
					if('${MENU.upMenuId}' == menu.menuId && url2.indexOf('main.do')< 0){
						str += '<li class="on">';
					}else{
						str += '<li>'; //  class="on"
					}
					url = menu.refUrl;
					str += '	<a href="javascript:goTopMenu(\''+menu.refUrl+'\',\''+menu.refMenuId+'\',\''+menu.targetCd+'\',\''+sizepos+'\');" title="'+menu.menuNm+'">';

					str += '		<span>'+menu.menuNm+'</span>';
					str += '	</a>';
					str += '</li>';
				}

				$("#TopMenu").html(str);
			}

			function createSubMenu(list,boardList,gubun,notBoardList){
				var str = "", url = "", sizepos = "";
				var menu;
				var board;
				var board2;
				var subIdx = 0;
				var boardIdx = 0;
				var subBoard = false;


				for(var i =0; i < list.length;i++){

					menu = list[i];
					url = "";
					sizepos = jsNvl(menu.width)+"/"+jsNvl(menu.height)+"/"+jsNvl(menu.left)+"/"+jsNvl(menu.top);
					if(menu.lvl == "1"){
						if(subIdx > 0)  str += '</ul>';
						subIdx = 0;
					    if(i > 0) str += '</li>';
						str += '<li ';
						if(menu.menuId == '${MENU.menuNm}') str += 'class="on"';
						if ( !(boardList==null) && gubun=="M" ) str += 'style="display:none"';
						str += '>';

						url = menu.ref_menu_url;
						str += '	<a href="javascript:goSubMenu(\''+menu.refUrl+'\',\''+menu.menuId+'\',\''+menu.targetCd+'\',\''+sizepos+'\');" title="'+menu.menuNm+'">';
						str += '		<span '+(menu.refUrl=='/back/contents/intropageListPage.do'?'':'')+'>'+menu.menuNm+'</span>';
						str += '	</a>';

						//---------------------------------------------------------
						// 게시판 목록 출력하기위해 추가 코딩
						if ( !(boardList==null) && gubun=="M" ){
							str += '</li>';
							str += '<div>';
							str += '<span class="inpbox"><input name="findText" type="text" style="width:90%;margin-left:5px;" class="in_w80" placeholder="찾기.." title="찾기.." onkeyup="findText(this.value);" /></span>';
							str += '</div>';
							for(var j =0; j < boardList.length;j++){
								board = boardList[j];

								if(j+1<boardList.length){
									board2 = boardList[j+1];
									if(board.lvl == "1"){
										subBoard = (board2.refBoardId == "" ||board2.refBoardId == undefined)  ? false : true;
									}
								}
								url = "";

								if(board.lvl == "1" && subBoard){
									if(boardIdx > 0)  str += '</ul>';
									boardIdx = 0;
									str += '<li>';
									str += '	<a href="javascript:goSubMenu(\''+"/back/board/boardContentsListPage.do?gubun=M&boardId="+board2.refBoardId+'\',\''+menu.menuId+'\',\''+menu.targetCd+'\',\''+sizepos+'\');" title="'+board.menuNm+'">';
									//부모ul
									str += '<span style="font-weight: bold;">'+board.menuNm+'</span>';
									str += '</a>';
									//if(boardIdx > 0) str += '</li>';
									//str += '</li>';
									subBoard = false;
								}
								if(board.refCd == "B"){
									if(boardIdx == 0) {
										str += '<ul class="lnb_submenu">';
									}
									str += '<li>';
									str += '	<a href="javascript:goSubMenu(\''+"/back/board/boardContentsListPage.do?gubun=M&boardId="+board.refBoardId+'\',\''+menu.menuId+'\',\''+menu.targetCd+'\',\''+sizepos+'\');" title="'+board.menuNm+'">';
									str += '		<span>'+board.menuNm+'</span>';
									str += '	</a>';
									str += '</li>';
									boardIdx++;
								}
							}

							if ( !(notBoardList==null) ){

								if(boardIdx > 0)  str += '</ul>';
								boardIdx = 0;
								str += '<li><a>'
								str += '<span style="font-weight: bold;">미등록게시판2</span>';
								str += '</a>';
								if(boardIdx > 0) str += '</li>';

								for(var k =0; k < notBoardList.length;k++){
									board = notBoardList[k];
									if(boardIdx == 0) {
										str += '<ul class="lnb_submenu">';
									}
									str += '<li>';
									str += '	<a href="javascript:goSubMenu(\''+"/back/board/boardContentsListPage.do?gubun=M&boardId="+board.boardId+'\',\''+menu.menuId+'\',\''+menu.targetCd+'\',\''+sizepos+'\');" title="'+board.title+'">';
									str += '		<span>'+board.title+'</span>';
									str += '	</a>';
									str += '</li>';
									boardIdx++;
								}
							}str += '</li>';
						}
						//---------------------------------------------------------

					}else if(menu.lvl == "2"){
						if(subIdx == 0) str += '<ul class="lnb_submenu">';
						str += '<li>';

						url += menu.ref_menu_url;
						str += '	<a href="javascript:goSubMenu(\''+menu.refUrl+'\',\''+menu.menuId+'\',\''+menu.targetCd+'\',\''+sizepos+'\');" title="'+menu.menuNm+'">';

						str += '		<span>'+menu.menuNm+'</span>';
						str += '	</a>';
						str += '</li>';
						subIdx++;
					}
				}
					if(subIdx > 0) str += '</ul>';
					str += '</li>';

				$("#subMenu").html(str);
			}

			function findText(txt){

				$(".lnb_submenu").find("li").hide();
				$(".lnb_submenu").find("a").find(":contains("+txt+")").closest("li").show();

				if(txt.length < 1){
					$(".lnb_submenu").find("li").show();
				}
			}

			function goTopMenu(url, menuId, targetCd, sizepos){
				if(url == "undefined"){
					alert("준비중입니다.");
					return;
				}
				sizepos = sizepos.split("/");
				url+= menuId!=""? ((url.indexOf("?") > -1?"&":"?")+"menuId="+menuId):"";
				goUrl(targetCd, url,  sizepos[0],sizepos[1], sizepos[2], sizepos[3]);
			}

			function goSubMenu(url, menuId, targetCd, sizepos){
				if(url == "undefined"){
					alert("준비중입니다.");
					return;
				}
				sizepos = sizepos.split("/");
				url+= menuId!=""? ((url.indexOf("?") > -1?"&":"?")+"menuId="+menuId):"";
				goUrl(targetCd, url,  sizepos[0],sizepos[1], sizepos[2], sizepos[3]);

			}

			function goPage(menuId, param, linkurl){

				$.ajax
				({
					type: "POST",
			           url: "/back/common/sessionPage.do",
			           data:{
			        	   menuId : menuId
			           },
			           dataType: 'json',
					success:function(data){
						  var url = "<%=(String)ConfigUtil.getProperty("system.server.backUrl") %>";
						  if(data.menu.httpsYn == 'N') url = 'http://'+url;
						  else  url = 'https://'+url+":<%=(String)ConfigUtil.getProperty("system.server.httpsPort") %>";
						  url = "";
						  if(linkurl == undefined || linkurl == "") {
							  url += data.menu.ref_menu_url;
						  }else{
							  url += linkurl;
						  }
						  if(param != "") url += (url.indexOf("?") > -1?"&":"?")+param;

						  goUrl(data.menu.targetCd, url, data.menu.width,data.menu.height, data.menu.left, data.menu.top);
 					}
				});
			}

			function goPageUrl(url, menuId, param, targetCd, width, height, left, top){

				url+= menuId!=""? ((url.indexOf("?") > -1?"&":"?")+"menuId="+menuId):"";
				url+= param!="" ? ((url.indexOf("?") > -1?"&":"?")+param):"";
				goUrl(targetCd, url, width, height, left, top);
				return;
			}

			function goUrl(target, url, width,height, xPos, yPos){
				if(target == "_self")
				  	 document.location.href = url;
                 else if(target == "_blank")
               	  window.open(url);
                 else if(target == "_popup")
               	  openPosPopUp(url, "SeoulPopup", width, height, xPos, yPos);
			}

			function goMain(){

				document.location.href = "/back/main.do";


			}

			var foldYn = "Y";
			function changeSplit(){
				if(foldYn == "Y"){
					$("#SplitBar").removeClass("fold");
					$("#SplitBar").addClass("unfold");
					$("#MenuArea").hide();
					foldYn = "N";
				}else{
					$("#SplitBar").removeClass("unfold");
					$("#SplitBar").addClass("fold");
					$("#MenuArea").show();
					foldYn = "Y";
				}
			}
            var menuOpenYn = "N";
			function menuDescOpen(){
				if(menuOpenYn == "N"){
					$("#menu_desc_area").show();
					$("#menu_desc_btn").html("<img src='/images/back/common/btn_info_fold.png' alt='닫기' />");
					menuOpenYn = "Y";
				}else{
					$("#menu_desc_area").hide();
					$("#menu_desc_btn").html("<img src='/images/back/common/btn_info_unfold.png' alt='열기' />");
					menuOpenYn = "N";
				}

			}
			function findSite(txt){

				$("#s_siteList").find("li").hide();
				$("#s_siteList").find("li:contains("+txt+")").show();

				if(txt.length < 1 || $("#s_siteList").find("li:contains("+txt+")").length < 1){
					$("#s_siteList").hide();
				}else{
					$("#s_siteList").show();
					if(window.event.keyCode == 13){
						var id ='';
						$("#s_siteList").children("li").each(function(){
							if($(this).is(":visible")){
								id= $(this).find("input[name=s_selSiteId]").val();
							}
							return;
						});
						var nm ='';
						$("#s_siteList").children("li").each(function(){
							if($(this).is(":visible")){
								nm= $(this).find("input[name=s_selSiteNm]").val();
							}
							return;
						});
						var cd ='';
						$("#s_siteList").children("li").each(function(){
							if($(this).is(":visible")){
								cd= $(this).find("input[name=s_selClientId]").val();
							}
							return;
						});
						var cham ='';
						$("#s_siteList").children("li").each(function(){
							if($(this).is(":visible")){
								cham= $(this).find("input[name=s_selChamCd]").val();
							}
							return;
						});
						setSite(id,nm,cd,cham);
					}
				}
			}
			function setSite(id,nm,cd,cham){

				$("#s_siteNm").val(nm);
				$("#s_siteId").val(id);
				$("#s_clientId").val(cd);
				$("#s_chamCd").val(cham);
				$("#s_siteList").hide();

				$.ajax
				({
					type: "POST",
			           url: "/common/setSession.do",
			           data:{
			        		s_siteId : id,
			        		s_siteNm : nm,
			        		s_clientId : cd,
			        		s_chamCd:cham
			           },
			           dataType: 'json',
					 success:function(data){
						 location.reload();
					}
				});
			}

		</script>
	</head>

	<body>
	<tiles:insertAttribute name="header"/>
	<tiles:insertAttribute name="body"/>
	<tiles:insertAttribute name="footer"/>
  </body>
</html>