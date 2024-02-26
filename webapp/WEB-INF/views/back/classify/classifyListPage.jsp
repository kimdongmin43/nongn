<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link href="/assets/jstree/dist/themes/proton/style.min.css" rel="stylesheet" />
<script src="/assets/jstree/dist/jstree.js"></script>

<script>
var selectClassifyTreeListUrl = "<c:url value='/back/classify/classifyTreeList.do'/>";
var classifyWriteUrl = "<c:url value='/back/classify/classifyWrite.do'/>";
var insertClassifyUrl = "<c:url value='/back/classify/insertClassify.do'/>";
var updateClassifyUrl = "<c:url value='/back/classify/updateClassify.do'/>"
var deleteClassifyUrl = "<c:url value='/back/classify/deleteClassify.do'/>";
var classifyReorderUrl = "<c:url value='/back/classify/updateClassifyReorder.do'/>";

$(document).ready(function(){

 	$('#classify_jstree').jstree({
		"core" : {
			"data" : {
				 'cache':false,
				'url' : selectClassifyTreeListUrl,
				'data' : {
					gubun : $("#gubun").val()
				},
				"dataType" : "json",
				'success': function(res) {
					//console.log(res);
				},
				'error' : function (e) {
					//console.log(e);
				}
			},
            'themes': {
                'name': 'proton',
                'responsive': true
            },
			"check_callback" : true
		},
		'search' : {
			'fuzzy' : false
		},
		"plugins" : [ "types", "search","dnd"]
	}).bind("loaded.jstree refresh.jstree",function(event,data){
    	$(this).jstree("open_all");
    	$(this).jstree("select_node", '#'+$("#classify_id").val());
    }).bind("select_node.jstree", function (event, data) {
    	//console.log(data); 
		$("#classify_id").val(data.node.id);
     	if(data.node.id == 0)
     		classifyWrite("W");
     	else	
			classifyWrite("E");
    }).bind('move_node.jstree',function(event,data){
    	//console.log(data);
         classifyReorder(data);
    });
 
});

function classifyReorder(data){
	$.ajax
	({
		type: "POST",
           url: classifyReorderUrl,
           data:{
        	   gubun : $("#gubun").val(),
               classify_id : data.node.id,
               sort : data.position+1,
               up_classify_id : data.parent,
               old_sort : data.old_position+1,
               old_up_classify_id : data.old_parent
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				refreshClassifyTree();
			}	
		}
	});
}

function classifyWrite(mode){
	var classifyId =  "0";
	var upClassifyId= $("#classify_id").val();
	$('#classifyArea').html("");
	
	$("#mode").val(mode);
	if(mode == "E") classifyId = $("#classify_id").val();
    $.ajax({
        url: classifyWriteUrl,
        dataType: "html",
        type: "post",
        data: {
           gubun : $("#gubun").val(),
           mode : mode,
           classify_id : classifyId,
           up_classify_id : upClassifyId
		},
        success: function(data) {
        	$('#classifyArea').html(data);
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

function classifyInsert(){
	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){

		   url = insertClassifyUrl;
		   if($("#mode").val() == "E") url = updateClassifyUrl; 
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						refreshClassifyTree();
  					}	
  				},
  				dataType: "json",
  				data : {
  					gubun : $("#gubun").val(),
  					classify_id : $("#classify_id").val()
  				},
  				url: url
  		    });	
		   
	   }
}

function refreshClassifyTree() {
	$('#classify_jstree').jstree().settings.core.data.data = { gubun : $("#gubun").val() };
	$('#classify_jstree').jstree().refresh();
}

function classifyDelete(){
	   if(!confirm("선택하신 카테고리와 하위의 모든 카테고리가 삭제됩니다. 정말 삭제하시겠습니까?")) return;
	   
		$.ajax
		({
			type: "POST",
	           url: deleteClassifyUrl,
	           data:{
	        	gubun : $("#gubun").val(),
	           	classify_id : $("#classify_id").val(),
	           	up_classify_id : $("#up_classify_id").val()
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					$("#classify_id").val("0");
					refreshClassifyTree();
				}	
			}
		});
}

function changeGubun(){
	$("#classify_id").val("0");
	refreshClassifyTree();
}

</script>
   <form id="listFrm" name="listFrm" method="post" >
	<input type='hidden' id="mode" name='mode' value="${params.mode}" />
	<input type='hidden' id="classify_id" name='classify_id' value="0" />
  </form>  

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
		<div class="search_area">
			 <table class="search_box">
				<caption>메뉴타이틀</caption>
				<colgroup>
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>
					카테고리 구분 :  <g:select id="gubun" name="gubun"  codeGroup="CLASSIFY_TYPE" cls="in_wp150"  onChange="changeGubun()" />
					</th>
				</tr>
				</tbody>
			</table>
		</div>
		<!--// search_area -->
		
		<!-- area40 -->
		<div class="area40 marginr10">
              <div id="classify_jstree" style="height:630px;overflow:auto; border:1px solid silver; min-height:565px;">
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
			<div class="title_area marginb8">	
				<div class="float_right">
					<a href="javascript:classifyWrite('W')" class="btn acti" title="등록">
						<span>카테고리등록</span>
					</a>					
				</div>
			</div>
			<!--// title_area -->
     		  <div class="panel-body"  id="classifyArea" style="padding:2px">
           
              </div>
		
		</div>
		<!--// division -->		

</div>
<!--// content -->
