<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
    <style type="text/css">
      div#doc-pop-up {
        display: none;
        position: absolute;
        width: 200px;
        padding: 10px;
        background: #eeeeee;
        color: #000000;
        border: 1px solid #1a1a1a;
        font-size: 90%;
      }

	 #modal-apply-write {
	   overflow: auto;
	 }
    </style>
<script>
var applyWriteUrl =  "<c:url value='/back/apply/applyWrite.do'/>";
var applyUpdateUrl =  "<c:url value='/back/apply/updateApply.do'/>";

function applyWrite(resultGb, aplyId) {
    var f = document.listFrm;
    var mode = "W";
    if(aplyId != "") mode = "E";
    
	$('#pop_content').html("");
	
	$("#mode").val(mode);
    $.ajax({
        url: applyWriteUrl,
        dataType: "html",
        type: "post",
        data: {
           result_gb : resultGb,
           mode : mode,
  		   aply_id : aplyId
		},
        success: function(data) {
        	$('#pop_content').html(data);

        	$('.datepicker').each(function(){
        	    $(this).datepicker({
        			  format: "yyyy-mm-dd",
        			  language: "kr",
        			  keyboardNavigation: false,
        			  forceParse: false,
        			  autoclose: true,
        			  todayHighlight: true,
        			  showOn: "button",
        			  buttonImage:"/images/back/icon/icon_calendar.png",
        			  buttonImageOnly:true,
        			  changeMonth: true,
        	          changeYear: true,
        	          showButtonPanel:false
        			 });
        	});
        	
        	popupShow();
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
  
}

function applyInsert(){
	
	   if($('#id_file_id').val() == "")
	   	  $('#uploadFile1').attr('data-parsley-required', 'true');	
	   if($('#health_file_id').val() == "")
		   	  $('#uploadFile2').attr('data-parsley-required', 'true');	
	   if($('#unemplyinsur_file_id').val() == "")
		   	  $('#uploadFile3').attr('data-parsley-required', 'true');	
	   if($('#deploma_file_id').val() == "")
		   	  $('#uploadFile4').attr('data-parsley-required', 'true');	
   
	   var url = applyUpdateUrl; 
	   if ( $("#writeFrm").parsley().validate() ){
		   
		   $("#hometel").val($("#tel_1").val()+"-"+$("#tel_2").val()+"-"+$("#tel_3").val());
		   $("#mobile").val($("#mobile_1").val()+"-"+$("#mobile_2").val()+"-"+$("#mobile_3").val());
		   $("#email").val($("#email_1").val()+"@"+$("#email_2").val());
		   
		   for(var i =1; i < 5; i++ ){
				if ($("#uploadFile"+i).val() != "" && !$("#uploadFile"+i).val().toLowerCase().match(/\.(ppt|pptx|xls|xlsx|doc|docx|hwp|txt|pdf|zip)$/)){
				    alert("확장자가 ppt,pptx,xls,xlsx,doc,docx,hwp,txt,pdf,zip 파일만 업로드가 가능합니다.");
				    return;
				}  
	       }
		
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

		   if(!dupcheck) return;
		   
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
	str +='		<label for="activetargetcode'+actplanCnt+'" class="hidden">활동목표 '+actplanCnt+'단계</label>';
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
	str += getCodeListStr("/back/classify/classifyCodeList.do", pdata, actplan, "") ;
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
	getCodeList("/back/classify/classifyCodeList.do", pdata, "activetargetcode2"+idx, "", "", "", true); 
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
		str += '			<label for="step01" class="hidden">프로그램 '+programCnt+'단계</label>';
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

function changeEmailDomain(){
	   $("#email_2").val($("#email_domain").val());
}

function delFile(gubun){
	   if(gubun == "1") $("#id_file_id").val("");
	   else	if(gubun == "2") $("#health_file_id").val("");
	   else	if(gubun == "3") $("#unemplyinsur_file_id").val("");
	   else	if(gubun == "4") $("#deploma_file_id").val("");
	   
		$("#upFile"+gubun).hide();
}

$(document).ready(function(){
	
	$('#receiver_list').jqGrid({
		datatype: 'local',
		mtype: 'POST',
		colModel: [
			{ label: '이름', index: 'user_nm', name: 'user_nm', width: 100, align : 'center', sortable:false },
			{ label: '전화번호', index: 'mobile', name: 'mobile', align : 'left', sortable:false, width:100},
			{ label: '사용자번호', index: 'user_no', name: 'user_no',  hidden:true},
			{ label: '사용자ID', index: 'user_id', name: 'user_id',  hidden:true}
		],
		rowNum : -1,
		viewrecords : true,
		height : "200px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit: true,
		editable: true,
		edittype :"text",
		cellsubmit : 'clientArray'
	});
	
});

function smsWrite(listnm){

	 var s = jQuery("#"+listnm).jqGrid('getGridParam','selarrrow');

     if(s.length < 1){
     	alert("대상자를 선택해 주십시요.");
     	return;
     }
     $('#receiver_list').jqGrid('clearGridData');
     var data = {
           user_no:"",
           user_id:"",
           user_nm:"",
           mobile: ""
     };
     
	 for(var i = 0 ; i<s.length ; i++){		
			var ret = jQuery("#"+listnm).jqGrid('getRowData',s[i]);
			data.user_no = ret.user_no;
			data.user_id = ret.user_id;
			data.user_nm = ret.user_nm;
			data.mobile = ret.mobile;
			
			$("#receiver_list").addRowData(undefined, data);
	 }
     smsPopupShow(); 
}

function sendSms(){
	if($("#message").val() == ""){
		alert("문자 메시지를 입력해 주십시요.");
		return;
	}
	
	var limitByte = parseInt($("#limitByte").html());
	var totalByte = parseInt($("#messagebyte").html());
	
	if(totalByte > limitByte){
		alert("메시지 입력 범위를 초과하였습니다.");
		return;
	}
	
	if($("#sender").val() == ""){
		alert("발송번호를 입력해 주십시요.");
		return;
	}
	var type = $('input:radio[name=send_type]:checked').val();
	var insertRow = new Array();
	var arrrows = $("#receiver_list").getRowData();
	for (var i = 0; i < arrrows.length; i++) {
		 insertRow.push(arrrows[i]);
    }
	
    $.ajax({
        url: "/back/apply/smsSend.do",
        dataType: "json",
        type: "post",
        data: {
           send_type : type,
  		   message : $("#message").val(),
  		   sender : $("#sender").val(),
  		   receiver_list : JSON.stringify(insertRow)
		},
        success: function(data) {
        	alert(data.message);
        	smsPopupClose(); 
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });

}

function checkByte() {
	var limitByte = 80;
    var totalByte = 0;
    
    limitByte = parseInt($("#limitByte").html());
    
	var message = $("#message").val();

    for(var i =0; i < message.length; i++) {
          var currentByte = message.charCodeAt(i);
          if(currentByte > 128) totalByte += 3;
          else totalByte++;
    }
   $("#messagebyte").html(totalByte);
    /*
    if(totalByte > limitByte) {
           alert( limitByte+"바이트까지 전송가능합니다.");
            $("#message").val( message.substring(0,limitByte));
    }
    */
}

var mouseX;
var mouseY;
$(document).mousemove( function(e) {
   mouseX = e.pageX; 
   mouseY = e.pageY;
});
function showSubmitPopup(idFile,healthFile,unemplyinsurFile,deplomaFile){
    var moveLeft = 20;
    var moveUp = 120;
    var str = "";
    $("div#doc-pop-up").html(str);
    if(idFile != "undefined")
    	str += "<a href='/commonfile/fileidDownLoad.do?file_id="+idFile+"' >주민등록등본</a><br>";
/*      if(healthFile != "undefined")
     	str += "<a href='/commonfile/fileidDownLoad.do?file_id="+healthFile+"' >건강보험료납부확인서</a><br>"; */
     if(unemplyinsurFile != "undefined")
     	str += "<a href='/commonfile/fileidDownLoad.do?file_id="+unemplyinsurFile+"' >고용보험 피보험자격내역서</a><br>";
     if(deplomaFile != "undefined")
     	str += "<a href='/commonfile/fileidDownLoad.do?file_id="+deplomaFile+"' >최종학력 졸업증명서</a><br>";
     $("div#doc-pop-up").html(str);
     $("div#doc-pop-up").css('top',  mouseY- moveUp).css('left',  mouseX).css('width','200px');
	 $("div#doc-pop-up").show();
}
function showFailPopup(message){
    var moveLeft = 130;
    var moveUp = 120;
    $("div#doc-pop-up").html("");
     $("div#doc-pop-up").html(message);
     $("div#doc-pop-up").css('top',  mouseY- moveUp).css('left',  mouseX-moveLeft).css('width','100px');
	 $("div#doc-pop-up").show();
}

function applyPrint(div){
	    popupClose();
		var initBody = document.body.innerHTML;
		
		var beforePrint = function() {
			 document.body.innerHTML = document.getElementById("printArea").innerHTML;
		};
		
		var afterPrint = function() {
			document.body.innerHTML = initBody;
			popupShow();
		}
		
		if (window.matchMedia) {
	        var mediaQueryList = window.matchMedia('print');
	        mediaQueryList.addListener(function(mql) {
	            if (mql.matches) {
	                beforePrint();
	            } else {
	                afterPrint();
	            }
	        });
	    }
		window.onbeforeprint = beforePrint;
	    window.onafterprint = afterPrint;
	    
	    window.print();
}

function hideSubmitPopup(){
	$("div#doc-pop-up").hide();
}
function viewSubmitPopup(){
	$("div#doc-pop-up").show();
}

function changeSendType(limitbyte){
	$("#limitByte").html(limitbyte);
}

function smsPopupShow(){
	$('#modal-sms-write').modal('show');
}

function smsPopupClose(){
	$('#modal-sms-write').modal('hide');
}

function popupShow(){
	$('#modal-apply-write').modal('show');
}

function popupClose(){
	$('#modal-apply-write').modal('hide');
}

function evalPopupShow(){
	$('#modal-eval-write').modal('show');
}

function evalPopupClose(){
	$('#modal-eval-write').modal('hide');
}
</script>	

    <div class="modal" id="modal-apply-write">
		<div class="modal-dialog modal-size-normal">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title">신청서보기</h1>
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

     <div class="modal fade" id="modal-eval-write" >
		<div class="modal-dialog modal-size-small">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title" id="evalFailTitle" >Fail 사유</h1>
				<a href="javascript:evalPopupClose()" class="pop_close" title="페이지 닫기">
					<span>닫기</span>
				</a>
			</header>
			</div>
			<!-- //header -->
			<!-- container -->
			<div id="pop_container">
			<article>
				<div class="pop_content_area">
				    <div  id="eval_pop_content" >
	<form id="evalFrm" name="evalFrm" method="post" data-parsley-validate="true">
					<!-- write_basic -->
					<div class="table_area">
						<table class="write">
							<caption>Fail 사유 등록화면</caption>
							<colgroup>
								<col style="width: 120px;" />
								<col style="width: *;" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">사유</th>
								<td>
										<c:choose>
									        <c:when test="${applyGb == 'P'}">
											    <g:select id="fail_reason" name="fail_reason"  codeGroup="EVAL_FAIL_REASON" cls="in_wp300" />
									       </c:when>
									        <c:when test="${applyGb == 'F'}">
											    <g:select id="fail_reason" name="fail_reason"  codeGroup="FIRST_FAIL_REASON" cls="in_wp300" />
									       </c:when>
									        <c:when test="${applyGb == 'S'}">
											    <g:select id="fail_reason" name="fail_reason"  codeGroup="SECOND_FAIL_REASON" cls="in_wp300" />
									       </c:when>
									        <c:when test="${applyGb == 'O'}">
											    <g:select id="fail_reason" name="fail_reason"  codeGroup="CANCEL_REASON" cls="in_wp300" />
									       </c:when>
									        <c:when test="${applyGb == 'A'}">
											    <g:select id="fail_reason" name="fail_reason"  codeGroup="GIVE_STOP_REASON" cls="in_wp300" />
									       </c:when>
									    </c:choose> 
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<!--// write_basic -->
					<!-- footer --> 
					<div id="footer">
					<footer>
						<div class="button_area alignc">
		                  	<a href="javascript:updateEvalResult('F')" class="btn save" title="저장">
								<span>저장</span>
							</a>
						</div>
					</footer>
					</div>
					<!-- //footer -->
</form>
				    </div>
				</div>
			</article>	
			</div>
			<!-- //container -->			
		</div>
	</div>

 <div class="modal fade" id="modal-sms-write" >
		<div class="modal-dialog modal-size-small">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title">SMS 발송</h1>
				<a href="javascript:smsPopupClose()" class="pop_close" title="페이지 닫기">
					<span>닫기</span>
				</a>
			</header>
			</div>
			<!-- //header -->
			<!-- container -->
			<div id="pop_container">
			<article>
				<div class="pop_content_area">
				    <div  id="sms_pop_content" >

					<!-- area40 -->
					<div class="area50 marginr20" style="margin-top:10px">
						<!-- table_area -->
						<div style="height: 400px;">
							<div class="table_area" id="receiver_list_div" style=" margin-left:20px;margiin-top:20px;; " >
							    <table id="receiver_list"></table>
							</div>
						</div>
						<!--// table_area -->
						<!-- button_area -->
						<div class="button_area">
							<div class="float_right">
								<a href="javascript:sendSms()" class="btn save" title="전송하기">
									<span>전송</span>
								</a>
								<a href="javascript:smsPopupClose()" class="btn cancel" title="취소하기">
									<span>취소</span>
								</a>
							</div>
						</div>	
						<!--// button_area -->					
					</div>
					<!--// area40 -->	
									
					<!-- division -->
					<div class="division" style="margin-top:30px">
						<!-- phone_area -->
						<div class="phone_area">
							<!-- phone_box -->
							<div class="phone_box">
								<div class="phoneb">
									<div class="phonet">
										<div class="phonem">
											<div>
												<input type="radio" id="send_sms" name="send_type" value="SMS" checked onClick="changeSendType(80)" />
												<label for="sms_radio" class="marginr5">SMS</label>
												<input type="radio" id="send_lms" name="send_type" value="LMS"  onClick="changeSendType(2000)" />
												<label for="lms_radio" class="marginr5">LMS</label>
												<input type="radio" id="send_mms" name="send_type" value="MMS"  onClick="changeSendType(1000)" />
												<label for="mms_radio">MMS</label>
											</div>
											<div class="phone_text">
												<textarea id="message" name="message" cols="80" rows="5" class="letter" title="문자 내용 입력" onkeyup="checkByte()" ></textarea>
											</div>
											<p class="margint5 alignr">
												<span class="color_point bold" id="messagebyte">0</span> bytes (최대 <span id="limitByte">80</span>bytes)
											</p>
											<div class="number_area">
												<strong class="title"><label for="input_num">발송번호</label></strong>
												<input class="in_w80" type="text" id="sender" name="sender" value="0221336588" placeholder="발송번호" /> 
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- //phone_box -->
						</div>
						<!--// phone_area -->
					</div>
					<!--// division -->

				    </div>
				</div>
			</article>	
			</div>
			<!-- //container -->			
		</div>
	</div>

      <div id="doc-pop-up" style="display:none" onmouseover="viewSubmitPopup()" onmouseout="hideSubmitPopup()">

      </div>
      
  <jsp:include page="/WEB-INF/views/back/user/jusoSearchPopup.jsp"/>