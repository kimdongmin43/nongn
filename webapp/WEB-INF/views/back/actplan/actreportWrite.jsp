<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script>

$(document).ready(function(){
	$(".onlynum").keyup( setNumberOnly );
	
	actplanCnt =1;
	attainCnt =1;
	programCnt =1;
	
    $.ajax({
        url: "/back/actplan/reportActplanList.do",
        dataType: "json",
        type: "post",
        data: {
        	announc_id : $("#announc_id").val(),
        	act_seq : $("#act_seq").val(),
        	aply_id : $("#aply_id").val()
		},
        success: function(data) {
        	if(data != null && data.list.length > 0){
        		 var actplan = "";
        		for(var i =0; i < data.list.length;i++){
        			actplan = data.list[i];
        			addActivetarget(actplan.activ_target1, actplan.activ_target2);
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
        url: "/back/actplan/reportattainmentList.do",
        dataType: "json",
        type: "post",
        data: {
        	announc_id : $("#announc_id").val(),
        	act_seq : $("#act_seq").val(),
        	aply_id : $("#aply_id").val()
		},
        success: function(data) {
        	if(data != null && data.list.length > 0){
	       		 var actplan = "";
	       		for(var i =0; i < data.list.length;i++){
	       			actplan = data.list[i];
	       			addReportattainment(actplan.attain_cd1, actplan.attain_cd2, actplan.attain_cd3, actplan.attain_rate);
	       		}
	       	}else{
	       		addReportattainment('','','','0');
        	}		
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
    
    $.ajax({
        url: "/back/actplan/selectJoinprogramList.do",
        dataType: "json",
        type: "post",
        data: {
        	announc_id : $("#announc_id").val(),
        	act_seq : $("#act_seq").val(),
        	aply_id : $("#aply_id").val()
		},
        success: function(data) {
        	debugger;
        	if(data != null && data.list.length > 0){
	       		 var program = "";
	       		for(var i =0; i < data.list.length;i++){
	       			program = data.list[i];
	       			addProgram(program.program, program.satis, program.reason, jsNvl(program.etc_reason));
	       		}
	       	}else{
	       		addProgram('','4','1','');
        	}	
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
    
});

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

var attainCnt = 1;
function addReportattainment(upupAttain, upAttain, attain, attainRate){
	var str = "", selyn = "";
	
	if(attainCnt > 3) {
		alert("활동계획 및 달성도를 더 이상 입력할 수 없습니다.");
		return;
	}

	str +='<li id="reportattainment_'+attainCnt+'">';
	str +='<div class="list_row">';
	str +='	<div class="head_area">';
	str +='		<strong>활동계획 및 달성도</strong>';
	str +='	</div>';
	str +='	<div class="body_area">';
	str +='		<label for="reportattainmentcode'+attainCnt+'" class="hidden">활동계획 및 달성도 '+attainCnt+'단계</label>';
	str +='		<select class="in_w20" id="reportattainmentcode1'+attainCnt+'" name="reportattainmentcode1" onchange="changeReportattainment1('+attainCnt+')">';
	<c:forEach var="row" items="${reportattainmentList}" varStatus="status">
	                if(upupAttain == "") upupAttain = "<c:if test="${ status.index== 0}">${row.code}</c:if>"; 
				    if('${row.code}' == upupAttain) selyn = "selected";
				    else selyn = "";
	str += '				<option value="${row.code}" '+selyn+'>${row.codenm}</option>';
	</c:forEach>
	str +='		</select>';
	str +='		<label for="reportattainmentcode2'+attainCnt+'" class="hidden">활동계획 및 달성도 '+attainCnt+'단계</label>';
	str +='		<select class="in_w20" id="reportattainmentcode2'+attainCnt+'" name="reportattainmentcode2" onchange="changeReportattainment2('+attainCnt+')">';
	var pdata = {
			gubun : "REPORT_ATTAINMENT",
			up_classify_id : upupAttain
		};
	str += getCodeListStr("/back/classify/classifyCodeList.do", pdata, upAttain, "선택") ;
	str +='		</select>';
	str +='		<label for="reportattainmentcode3'+attainCnt+'" class="hidden">활동계획 및 달성도 '+attainCnt+'단계</label>';
	str +='		<select class="in_w20" id="reportattainmentcode3'+attainCnt+'" name="reportattainmentcode3">';
	var pdata = {
			gubun : "REPORT_ATTAINMENT",
			up_classify_id : upAttain
		};
	str += getCodeListStr("/back/classify/classifyCodeList.do", pdata, attain, "선택") ;
	str +='		</select>';	
	str +='		<div class="contents_list_btn_area">';
	str +='			<a href="javascript:delReportattainment(\''+attainCnt+'\')" class="plus_btn" title="활동계획 및 달성도 빼기 버튼">';
	str +='				<img src="/images/back/common/btn_minus.png" alt="빼기 버튼" />';
	str +='			</a>';
	str +='		</div>';
	str +='	</div>';
	str +='</div>';
	str +='<div class="list_row">';
	str +='<div class="head_area">';
	str +='	<strong>달성도(%)</strong>';
	str +='</div>';
	str +='<div class="body_area">';
	str +='	<label for="input_percent" class="hidden">달성도 입력</label>';
	str +='	<input type="text" class="m_in_w2030 onlynum" id="attainRate'+attainCnt+'" name="attainRate" value="'+attainRate+'" data-parsley-min="0" data-parsley-max="100"/>';
	str +='</div>';
	str +='</div>';
	str +='</li>';
	
	attainCnt++;
	
	$("#reportattainment_list").append(str);
	$(".onlynum").keyup( setNumberOnly );
}

function changeReportattainment1(idx){
	var upActplan = $("#reportattainmentcode1"+idx).val();
	var pdata = {
			gubun : "REPORT_ATTAINMENT",
			up_classify_id : upActplan
		};
	selectbox_deletelist("reportattainmentcode3"+idx);
	getCodeList("/back/classify/classifyCodeList.do", pdata, "reportattainmentcode2"+idx, "", "", "", false); 
}

function changeReportattainment2(idx){
	var upActplan = $("#reportattainmentcode2"+idx).val();
	var pdata = {
			gubun : "REPORT_ATTAINMENT",
			up_classify_id : upActplan
		};
	//selectbox_deletelist("reportattainmentcode3"+idx);
	getCodeList("/back/classify/classifyCodeList.do", pdata, "reportattainmentcode3"+idx, "", "", "", false); 
}

function delReportattainment(idx){
    if(attainCnt < 3){
  	   alert("활동계획 및 달성도는 최소 하나는 입력하셔야 합니다.");
  	   return;
    }
   $("#reportattainment_"+idx).remove();
   attainCnt--;
}


var programCnt =1;
function addProgram(selval, satis, reasoncd, etc){
	   var str = "", selyn ="";
	   
		if(programCnt > 3) {
			alert("참여프로그램을 더 이상 입력할 수 없습니다.");
			return;
		}

		str += '<li id="program_'+programCnt+'">';
		str += '	<div class="list_row">';
		str += '		<div class="head_area">';
		str += '			<strong>프로그램</strong>';
		str += '		</div>';
		str += '		<div class="body_area">';
		str += '			<label for="step01" class="hidden">프로그램 '+programCnt+'단계</label>';
		str += ' <input type="hidden" name="programCnt" value="'+programCnt+'" /> ';
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
		str += '<div class="list_row">';
		str += '	<div class="head_area">';
		str += '		<strong>프로그램 만족도</strong>';
		str += '	</div>';
		str += '	<div class="body_area">';
		str += '		<ul class="left_list">';
		str += '			<li>';
		str += '				<input type="radio" id="satis1'+programCnt+'" name="satis'+programCnt+'" value="4" '+(satis==4?"checked":"")+' />';
		str += '				<label for="statis1'+programCnt+'" class="marginr10">아주만족</label>';
		str += '			</li>';
		str += '			<li>';
		str += '				<input type="radio" id="satis2'+programCnt+'" name="satis'+programCnt+'" value="3" '+(satis==3?"checked":"")+' />';
		str += '				<label for="statis2'+programCnt+'" class="marginr10">대체로 만족</label>';
		str += '			</li>';
		str += '			<li>';	
		str += '				<input type="radio" id="satis3'+programCnt+'" name="satis'+programCnt+'"statis" value="2" '+(satis==2?"checked":"")+' />';
		str += '				<label for="statis3'+programCnt+'" class="marginr10">보통</label>';
		str += '			</li>';
		str += '			<li>';	
		str += '				<input type="radio" id="satis4'+programCnt+'" name="satis'+programCnt+'" value="1" '+(satis==1?"checked":"")+' />';
		str += '				<label for="statis4'+programCnt+'" class="marginr10">대체로 불만족</label>';
		str += '			</li>';
		str += '			<li>';	
		str += '				<input type="radio" id="satis5'+programCnt+'" name="satis'+programCnt+'" value="0" '+(satis==0?"checked":"")+' />';
		str += '				<label for="statis5'+programCnt+'">아주 불만족</label>';
		str += '			</li>	';
		str += '		</ul>';
		str += '	</div>';
		str += '</div>';
		str += '<div class="list_row">';
		str += '	<div class="head_area">';
		str += '		<strong>기타 사유</strong>';
		str += '	</div>';
		str += '	<div class="body_area">';
		str += '		<ul class="bottom_list">';
		str += '			<li>';
		str += '				<input type="radio" id="reasonCd1'+programCnt+'" name="reasonCd'+programCnt+'" value="1" '+(reasoncd==1?"checked":"")+' onClick="changeReason('+programCnt+')" />';
		str += '				<label for="reasonCd1'+programCnt+'">프로그램이 나의 기대와 부합했다.</label>';
		str += '			</li>';
		str += '			<li>';
		str += '				<input type="radio" id="reasonCd2'+programCnt+'" name="reasonCd'+programCnt+'" value="2" '+(reasoncd==2?"checked":"")+' onClick="changeReason('+programCnt+')" />';
		str += '				<label for="reasonCd2'+programCnt+'">사후 관리 및 후속 연계가 잘 이루어졌다.</label>';
		str += '			</li>';
		str += '			<li>';	
		str += '				<input type="radio" id="reasonCd3'+programCnt+'" name="reasonCd'+programCnt+'" value="3" '+(reasoncd==3?"checked":"")+' onClick="changeReason('+programCnt+')" />';
		str += '				<label for="reasonCd3'+programCnt+'">시간 또는 장소가 적절했다.</label>';
		str += '			</li>';
		str += '			<li>';	
		str += '				<input type="radio" id="reasonCd4'+programCnt+'" name="reasonCd'+programCnt+'" value="4" '+(reasoncd==4?"checked":"")+' onClick="changeReason('+programCnt+')" />';
		str += '				<label for="reasonCd4'+programCnt+'">프로그램이 나의 기대에 못 미쳤다.</label>';
		str += '			</li>';
		str += '			<li>';	
		str += '				<input type="radio" id="reasonCd5'+programCnt+'" name="reasonCd'+programCnt+'" value="5" '+(reasoncd==5?"checked":"")+' onClick="changeReason('+programCnt+')" />';
		str += '				<label for="reasonCd5'+programCnt+'">사후 관리 및 후속 연계가 잘 이루어지지 않았다.</label>';
		str += '			</li>';
		str += '			<li>';	
		str += '				<input type="radio" id="reasonCd6'+programCnt+'" name="reasonCd'+programCnt+'" value="6" '+(reasoncd==6?"checked":"")+' onClick="changeReason('+programCnt+')" />';
		str += '				<label for="reasonCd6'+programCnt+'">시간 또는 장소가 적절하지 않았다.</label>';
		str += '			</li>';
		str += '			<li>';	
		str += '				<input type="radio" id="reasonCd7'+programCnt+'" name="reasonCd'+programCnt+'" value="7" '+(reasoncd==7?"checked":"")+' onClick="changeReason('+programCnt+')" />';
		str += '				<label for="reasonCd7'+programCnt+'">나의 상황 변화로 필요가 없어졌다.</label>';
		str += '			</li>';
		str += '			<li>';	
		str += '				<input type="radio" id="reasonCd8'+programCnt+'" name="reasonCd'+programCnt+'" value="8" '+(reasoncd==8?"checked":"")+' onClick="changeReason('+programCnt+')" />';
		str += '				<label for="reasonCd8'+programCnt+'">충분히 홍보가 되지 않았다.</label>';
		str += '			</li>';
		str += '			<li>';	
		str += '				<input type="radio" id="reasonCd9'+programCnt+'" name="reasonCd'+programCnt+'" value="9" '+(reasoncd==9?"checked":"")+' onClick="changeReason('+programCnt+')" />';
		str += '				<label for="reasonCd9'+programCnt+'">기타</label>';
		str += '				<label for="etc" class="hidden">기타의견 입력</label>';
		str += '				<input type="text" class="in_w60 marginl10" id="etc'+programCnt+'" name="etc" value="'+etc+'" '+(reasoncd==9?"":"readOnly")+' />';
		str += '			</li>	';
		str += '		</ul>';
		str += '	</div>';
		str += '</div>';
		str += '</li>';
		
		programCnt++;
		
		$("#program_list").append(str);
}

function delProgram(idx){
	 if(programCnt < 3){
		 alert("참여프로그램은 최소 하나는 입력하셔야 합니다.");
		 return;
	 }
	 $("#program_"+idx).remove();
	 programCnt--;
}

function changeReason(idx){
	var reasonCd = $(':radio[name="reasonCd'+idx+'"]:checked').val();
	
	if(reasonCd == "9") $("#etc"+idx).attr("readonly", false);
	else {
		$("#etc"+idx).val("");
		$("#etc"+idx).attr("readonly", true); 	
	}
}

function insertActplan(){
	   var check = true;
	   $("select[name='reportattainmentcode2']").each(function(i,e){
		   if(e.value == ""){
			   check = false;
			   return;
		   }
	   });
	   
	   $("select[name='reportattainmentcode3']").each(function(i,e){
		   if(e.value == ""){
			   check = false;
			   return;
		   }
	   });

	   if(!check){
		   alert("활동계획및달성도를 모두 선택해 주세요.");
		   return;
	   }

	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){
	        url = "/front/actplan/updateActreport.do"; 

		   if(!confirm("활동보고서를 저장하시겠습니까?")) return;
		   
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
				},
				dataType: "json", 				
				url: url
		    });	
	   }
}    
</script>
<form id="writeFrm" name="writeFrm" method="post"  onSubmit="return false;" data-parsley-validate="true">
    <input type='hidden' id="announc_id" name='announc_id' value="${actreport.announc_id}" />
	<input type='hidden' id="act_seq" name='act_seq' value="${actreport.act_seq}" />
	<input type='hidden' id="aply_id" name='aply_id' value="${actreport.aply_id}" />
	<div id="wrap">
		
		<!-- popup_content -->
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 class="pop_title">보고서 보기</h1>
			<a href="javascript:window.close()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area">
				<div id="pop_content">
					
					<!-- title_area -->
					<div class="title_area">
						<h2 class="pop_title">활동 보고서</h2>
					</div>
					<!--// title_area -->
					<!-- table_area -->
					<div class="table_area">
						<table class="write">
							<caption>활동 보고서 화면</caption>
							<colgroup>
								<col style="width: 150px;">
								<col style="width: *;">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">이름</th>
								<td>${actreport.user_nm}</td>
							</tr>
							<tr>
								<th scope="row">생년월일</th>
								<td>${actreport.birth}</td>
							</tr>
							</tbody>
						</table>
					</div>
					<!--// table_area -->
										
					<!-- title_area -->
					<div class="title_area">
						<h2 class="pop_title">활동결과서</h2>
					</div>
					<!--// title_area -->
					
					<!-- contents_table -->
					<div class="contents_table">
						<!-- contents_title -->
						<div class="contents_title">
							<strong>활동목표</strong>
							<div class="contents_title_btn_area">
								<a href="javascript:addActivetarget('','');" class="plus_btn" title="활동목표 더하기 버튼">
									<img src="/images/front/icon/faq_plus.png" alt="더하기 버튼" />
								</a>
							</div>
						</div>
						<!--// contents_title -->
						<!-- contents_list -->
						<div class="contents_list">
							<ul class="line_list"  id="activetarget_list">
						
							</ul>
						</div>
						<!--// contents_list -->
					</div>
					<!--// contents_table -->	
					<!-- contents_table -->
					<div class="contents_table">
						<!-- contents_title -->
						<div class="contents_title">
							<strong>활동계획 및 달성도</strong>
							<div class="contents_title_btn_area">
								<a href="javascript:addReportattainment('','','','');" class="plus_btn" title="활동계획 및 달성도 더하기 버튼">
									<img src="/images/front/icon/faq_plus.png" alt="더하기 버튼" />
								</a>
							</div>							
						</div>
						<!--// contents_title -->
						<!-- contents_list -->
						<div class="contents_list">
							<ul class="no_list"  id="reportattainment_list">
							
							</ul>
						</div>
						<!--// contents_list -->
					</div>
					<!--// contents_table -->
					
					<!-- contents_table -->
					<div class="contents_table">
						<!-- contents_title -->
						<div class="contents_title">
							<strong>참여프로그램</strong>
							<div class="contents_title_btn_area">
								<a href="javascript:addProgram('','4','1','');" class="plus_btn" title="활동목표 더하기 버튼">
									<img src="/images/front/icon/faq_plus.png" alt="더하기 버튼" />
								</a>
							</div>							
						</div>
						<!--// contents_title -->
						<!-- contents_list -->
						<div class="contents_list">
							<ul class="no_list" id="program_list">
							
							</ul>
						</div>
						<!--// contents_list -->
					</div>
					<!--// contents_table -->
					
					<!-- contents_table -->
					<div class="contents_table">
						<!-- contents_title -->
						<div class="contents_title">
							<strong>기타</strong>
						</div>
						<!--// contents_title -->
						<!-- contents_list -->
						<div class="contents_list">
							<ul class="no_list">
								<li>
									<div class="list_row">
										<div class="head_area">
											<strong><label for="input_textarea">활동내용/느낀점</label></strong>
										</div>
										<div class="body_area">
											<textarea cols="5" rows="5" id="opinion" name="opinion" class="in_w100" data-parsley-maxlength="4000">${actreport.opinion }</textarea>
											<p class="body_txt margint3">※ 활동내용 및 기억에 남는 에피소드나 우수사례 등</p>
										</div>
									</div>
								</li>
								<li style="display:none"> <!-- 20170417 숨김요청 -->
									<div class="list_row">
										<div class="head_area">
											<strong><label for="input_textarea02">요청사항</label></strong>
										</div>
										<div class="body_area">
											<textarea cols="5" rows="5" id="require" name="require" class="in_w100" data-parsley-maxlength="4000">${actreport.require }</textarea>
										</div>
									</div>
								</li>
								<li>
									<div class="list_row">
										<div class="head_area">
											<strong><label for="input_textarea03">상공회의소에 전하고 싶은 이야기</label></strong>
										</div>
										<div class="body_area">
											<textarea cols="5" rows="5" id="whatsay" name="whatsay" class="in_w100" data-parsley-maxlength="4000">${actreport.whatsay }</textarea>
											<p class="body_txt margint3">※ 예) 나는 (  )를 느꼈다. (   )를 건의한다.</p>
										</div>
									</div>
								</li>								
							</ul>
						</div>
						<!--// contents_list -->
					</div>
					<!--// contents_table -->
										
					<!-- button_area -->
					<div class="button_area">
						<div class="float_left">
							<button onClick="contentsPrint('pop_content');return false;"class="btn list" title="인쇄하기">
								<span>인쇄</span>
							</button>
						</div>
						<div class="alignc">
							<button onClick="insertActplan()" class="btn save" title="수정하기">
								<span>수정</span>
							</button>
						</div>
					</div>
					<!--// button_area -->
</form>
			</div>
		</article>	
		</div>
		<!--// popup_content -->
		
	</div>