<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var updateApplyActplanUrl = "<c:url value='/front/apply/updateApplyActplan.do'/>"

$(document).ready(function(){
	actplanCnt =1;
	programCnt =1;
	
    $.ajax({
        url: "/front/actplan/applyActplanList.do",
        dataType: "json",
        type: "post",
        data: {
        	aply_id : $("#aply_id").val()
		},
        success: function(data) {
        	if(data != null && data.list.length > 0){
        		 var actplan = "";
        		for(var i =0; i < data.list.length;i++){
        			actplan = data.list[i];
        			addActivetarget(actplan.up_activ_target, actplan.activ_target);
        		}
        	}else{
        		addActivetarget('','');
        	}	
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
    
    $.ajax({
        url: "/front/actplan/applyWishprogList.do",
        dataType: "json",
        type: "post",
        data: {
  		   aply_id : $("#aply_id").val()
		},
        success: function(data) {
        	if(data != null && data.list.length > 0){
	       		 var actplan = "";
	       		for(var i =0; i < data.list.length;i++){
	       			actplan = data.list[i];
	       			addProgram(actplan.wish_prog);
	       		}
	       	}else{
	       		addProgram("");
	       	}	
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });

});

var updateCheck = 0;
function updateApplyActplan(){
	   if(updateCheck == 1) return;
	   updateCheck = 1;
	   
	  $("#update_applyactplan_btn").hide();
	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){

		   var actplan = new Map();
		   var program = new Map();
		   var actplan1Row = new Array();
		   var actplan2Row = new Array();
		   $("select[name='activetargetcode1']").each(function(i,e){
			   actplan1Row.push(e.value);
		   });
		   $("select[name='activetargetcode2']").each(function(i,e){
			   actplan2Row.push(e.value);
		   });
		   var key = "";
		   var dupcheck = true;
		   for(var i =0; i < actplan1Row.length;i++){
			    key = actplan1Row[i]+"/"+actplan2Row[i];
			    if(actplan.containsKey(key)){
			    	alert("중복된 활동목표가 있습니다.");
			    	dupcheck = false;
			    }
			    actplan.put(key,"");
		   }
		   $("select[name='programcode']").each(function(i,e){
			   key = e.value;
			    if(program.containsKey(key)){
			    	alert("중복된 프로그램이 있습니다.");
			    	dupcheck = false;
			    }
			    program.put(key,"");
		   });

		   if(!dupcheck) {
			   $("#update_applyactplan_btn").show();
			   updateCheck = 0;
			   return;
		   }
		   
		   if(!confirm("신청을 완료하시겠습니까?")) {
			   $("#update_applyactplan_btn").show();
			   updateCheck = 0;
			   return;
		   }
		   
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					if(responseText.success == "true"){
						applyComplete()
					}else{
						alert(responseText.message);
						 $("#update_applyactplan_btn").show();
						 updateCheck = 0;
					}
					
				},
				dataType: "json", 				
				url: updateApplyActplanUrl
		    });	
		   
	   }else{
		   $("#update_applyactplan_btn").show();
		   updateCheck = 0;
	   }
}


var actplanCnt =1;
function addActivetarget(upActplan, actplan){
	var str = "", selyn = "";
	
	if(actplanCnt > 3) {
		alert("활동목표를 더 이상 입력할 수 없습니다.");
		return;
	}

	str +='<li id="activetarget_'+actplanCnt+'">';
	str +='<div class="list_row">';
	str +='	<div class="head_area">';
	str +='		<strong>활동목표</strong>';
	str +='	</div>';
	str +='	<div class="body_area">';
	str +='		<label for="activetargetcode1'+actplanCnt+'" class="hidden">활동목표 '+actplanCnt+'단계</label>';
	str +='		<select class="in_w20" id="activetargetcode1'+actplanCnt+'" name="activetargetcode1" onchange="changeActivetarget('+actplanCnt+')">';
	<c:forEach var="row" items="${activetargetList}" varStatus="status">
	                if(upActplan == "") upActplan = "<c:if test="${ status.index== 0}">${row.code}</c:if>"; 
				    if('${row.code}' == upActplan) selyn = "selected";
				    else selyn = "";
	str += '				<option value="${row.code}" '+selyn+'>${row.codenm}</option>';
	</c:forEach>
	str +='		</select>';
	str +='		<label for="activetargetcode2'+actplanCnt+'" class="hidden">활동목표 '+actplanCnt+'단계</label>';
	str +='		<select class="in_w20" id="activetargetcode2'+actplanCnt+'" name="activetargetcode2">';
	var pdata = {
			gubun : "ACTIVE_TARGET",
			up_classify_id : upActplan
		};
	str += getCodeListStr("/front/classify/classifyCodeList.do", pdata, actplan, "") ;
	str +='		</select>';
	str +='		<div class="contents_list_btn_area">';
	str +='			<a href="javascript:delActivetarget(\''+actplanCnt+'\')" class="plus_btn" title="활동목표 빼기 버튼">';
	str +='				<img src="/images/back/common/btn_minus.png" alt="빼기 버튼" />';
	str +='			</a>';
	str +='		</div>';
	str +='	</div>';
	str +='</div>';
	str +='</li>';
	
	actplanCnt++;
	
	$("#activetarget_list").append(str);
}

function changeActivetarget(idx){
	var upActplan = $("#activetargetcode1"+idx).val();
	var pdata = {
			gubun : "ACTIVE_TARGET",
			up_classify_id : upActplan
		};
	selectbox_deletealllist("activetargetcode2"+idx);
	getCodeList("/front/classify/classifyCodeList.do", pdata, "activetargetcode2"+idx, "", "", "", true); 
}

function delActivetarget(idx){
 if(actplanCnt < 3){
	 alert("활동목표는 최소 하나는 입력하셔야 합니다.");
	 return;
 }
 $("#activetarget_"+idx).remove();
 actplanCnt--;
}

var programCnt =1;
function addProgram(selval){
	   var str = "", selyn ="";
		if(programCnt > 3) {
			alert("활동목표를 더 이상 입력할 수 없습니다.");
			return;
		}

		str += '<li id="program_'+programCnt+'">';
		str += '	<div class="list_row">';
		str += '		<div class="head_area">';
		str += '			<strong>프로그램</strong>';
		str += '		</div>';
		str += '		<div class="body_area">';
		str += '			<label for="programcode" class="hidden">프로그램 '+programCnt+'단계</label>';
		str += '			<select class="in_w20" id="programcode" name="programcode">';
		<c:forEach var="row" items="${programList}">
		                         if('${row.code}' == selval) selyn = "selected";
		                         else selyn = "";
		str += '				<option value="${row.code}" '+selyn+'>${row.codenm}</option>';
		</c:forEach>
		str += '			</select>';
		str += '			<div class="contents_list_btn_area">';
		str += '				<a href="javascript:delProgram(\''+programCnt+'\')" class="plus_btn" title="프로그램 빼기 버튼">';
		str += '					<img src="/images/back/common/btn_minus.png" alt="빼기 버튼" />';
		str += '				</a>';
		str += '			</div>';
		str += '		</div>';
		str += '	</div>';
		str += '</li>';
		
		programCnt++;
		
		$("#program_list").append(str);
}

function delProgram(idx){
	 if(programCnt < 3){
		alert("희망프로그램은 최소 하나는 입력하셔야 합니다.");
		return;
	 }
	 $("#program_"+idx).remove();
	 programCnt--;
}

function applyDocument(){
	var f = document.writeFrm;
    f.action = "/front/apply/applyDocument.do";
    f.submit();
}

function applyComplete(){
	var f = document.writeFrm;
    f.action = "/front/apply/applyComplete.do";
    f.submit();
}

</script>
 <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
<input type='hidden' id="announc_id" name='announc_id' value="${apply.announc_id}" />
<input type='hidden' id="aply_id" name='aply_id' value="${apply.aply_id}" />
			    
			<!-- division40 -->
			<div class="division40">
				<!-- division50 -->
				<div class="division50">
					<!-- chapter_area -->
					<div class="chapter_area">
						<img src="/images/front/sub/chapter03.png" alt="3. 활동계획서" />
					</div>
					<!--// chapter_area -->
					<!-- division30 -->
					<div class="division30">
						<!-- title_area -->
						<div class="title_area">
							<h3 class="title">활동계획서</h3>
						</div>
						<!--// title_area -->
						
						<!-- contents_table -->
						<div class="contents_table">
							<!-- contents_title -->
							<div class="contents_title">
								<strong>활동목표</strong> <strong style="color:red;">(필수)</strong>
								<div class="contents_title_btn_area">
									<a href="javascript:addActivetarget('','');" class="plus_btn" title="활동목표 더하기 버튼">
										<img src="/images/front/icon/faq_plus.png" alt="더하기 버튼" />
									</a>
								</div>
							</div>
							<!--// contents_title -->
							<div style="margin-top:5px; margin-left:5px">
								<p class="point_txt2"><font color="red">* 최대 3개까지 선택하실 수 있습니다. </font></p>
								<p class="point_txt2"><font color="red">* 청년수당을 받는 기간 동안 실제 본인의 활동하실 내용을 선택하시면 됩니다.</font></p>
								<p class="point_txt2"><font color="red">* 보다 상세한 활동 내용은 아래 (세부활동계획)란에 직접 적어주시면 됩니다</font></p>
							</div>
							<!-- contents_list -->
							<div class="contents_list">
								<ul class="line_list" id="activetarget_list">

								</ul>
							</div>
							<!--// contents_list -->
						</div>
						<!--// contents_table -->	
						<!-- contents_table -->
						<div class="contents_table">
							<!-- contents_title -->
							<div class="contents_title">
								<strong>희망프로그램</strong> <strong style="color:red;">(필수)</strong>
								<div class="contents_title_btn_area">
									<a href="javascript:addProgram('');" class="plus_btn" title="활동목표 더하기 버튼">
										<img src="/images/front/icon/faq_plus.png" alt="더하기 버튼" />
									</a>
								</div>
							</div>
							<!--// contents_title -->
							<div style="margin-top:5px; margin-left:5px">
								<p class="point_txt2"><font color="red">* 참여하실 수 있는 상공회의소에서 운영하는 청년활력프로그램의 주제들입니다. 관심 있는 주제를 선택해 주시면, 상세 내용을 문자로 받아 보실 수 있습니다. </font></p>
								<p class="point_txt2"><font color="red">* 최대 3개까지 선택하실 수 있습니다.</font></p>
							</div>
							<!-- contents_list -->
							<div class="contents_list">
								<ul class="line_list" id="program_list">

								</ul>
							</div>
							<!--// contents_list -->
						</div>
						<!--// contents_table -->
						
						<!-- contents_table -->
						<div class="contents_table">
							<!-- contents_title -->
							<div class="contents_title">
								<strong>세부활동계획</strong> <strong style="color:red;">(필수)</strong>
							</div>
							<!--// contents_title -->
							<!-- contents_list -->
							<div class="contents_list">
								<ul class="no_list">
									<li>
										<div class="list_row">
											<div class="head_area">
												<strong><label for="input_textarea">지원동기</label></strong>
											</div>
											<div class="body_area">
											    <label for="aply_motiv" class="hidden">지원동기</label>
												<textarea cols="5" rows="10" id="aply_motiv" name="aply_motiv" class="in_w100"  data-parsley-required="true" data-parsley-maxlength="4000" >${apply.aply_motiv}</textarea>
											</div>
										</div>
									</li>
									<li>
										<div class="list_row">
											<div class="head_area">
												<strong><label for="input_textarea02">월별활동계획</label></strong>
											</div>
											<div class="body_area">
											    <label for="activ_plan" class="hidden">월별활동계획</label>
												<textarea cols="5" rows="10" id="activ_plan" name="activ_plan" class="in_w100" data-parsley-required="true" data-parsley-maxlength="4000" >${apply.activ_plan}</textarea>
											</div>
										</div>
									</li>								
								</ul>
							</div>
							<!--// contents_list -->
						</div>
						<!--// contents_table -->
						
						<!-- explain_txt_area -->
						<div class="explain_txt_area">
							<div class="explain_txt01">
								<p>본인은 상기 기재내용을 사실대로 기재하였으며, 만일 기재 내용이 <strong>사실과 다를 경우 신청기관이 접수를 취소하거나 이외 상공회의소사업 지원금 환수 또는 제재를 가하더라도 이의를 제기하지 않겠습니다.</strong></p>
							</div>
							<div class="explain_txt02">
								<ul>
									<li>
										<strong>신청일 :</strong>
										<span>${apply.reg_date}</span>
									</li>
									<li>
										<strong>신청자 :</strong>
										<span>${apply.user_nm}(인)</span>
									</li>
								</ul>
							</div>
							<div class="explain_txt03">
								<strong>서울특별시시장 귀하</strong>
							</div>
						</div>
						<!--// explain_txt_area -->
						
						
					</div>
					<!--// division30 -->
					<!-- button_area -->
					<div class="button_area">
		            	<div class="alignc">
		            		<a id="update_applyactplan_btn" href="javascript:updateApplyActplan();" class="btn save2" title="신청완료">
		            			<span>신청완료</span>
		            		</a>
		            		<a href="javascript:applyDocument();" class="btn save2" title="취소">
		            			<span>취소</span>
		            		</a>
		            	</div>
		            </div>
					<!--// button_area -->						
	           	</div>
	           	<!--// division50 -->
           	</div>
           	<!--// division40 -->
		           	
</form>
