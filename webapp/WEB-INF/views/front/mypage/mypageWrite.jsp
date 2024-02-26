<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>





<script>
var listUrl = "<c:url value='/front/board/boardContentsListPage.do'/>";
var insertBoardContentsUrl = "<c:url value='/front/board/insertBoardContents.do'/>";
var insertBoardContentsReplyUrl = "<c:url value='/front/board/insertBoardContentsReply.do'/>";
var updateBoardContentsUrl = "<c:url value='/front/board/updateBoardContents.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";
var maxNoti = "${boardinfo.noti_num}";
var notiCnt = "${boardinfo.noti_cnt}";
var productCnt = 0;
var areaCnt = 0;


$(document).ready(function(){		
	if("${cnt}"!= 1 || "${cnt}" == null){
		alert("해당하는 손해평가사 정보가 없습니다.")
		history.back();		
	}
	
 
	
	
	$(document).on("change","select[name=productFirst]",function(){
		
		var firstId = $(this).attr('id').substring($(this).attr('id').length-2,$(this).attr('id').length);
		var firstCd = $(this).val().substring(0,1);
		var num = 0;
		var nummax = 0;
		var str = "";
		
		num = firstCd*10000;
		nummax = (firstCd*1+1)*10000;	
		  
		
		   $("#productSecond"+firstId).find("option").remove();
		   $("#productAllCode").find("option").each(function() {      
		    if($(this).val()>=num && $(this).val()<nummax){     
		    	$("#productSecond"+firstId).append("<option value='" + this.value +"'>" + this.text +"</option>");     
		    }
		   });
	
	$("#skip_nav").focus();		//	키보드 이동을 위해 포커스 - 2020.10.19

}); 
	
	

$(document).on("change","select[name=areasFirts]",function(){
		
		var firstId = $(this).attr('id').substring($(this).attr('id').length-2,$(this).attr('id').length);
		var firstCd = $(this).val().substring(0,2);		
		
		   $("#areasSecond"+firstId).find("option").remove();
		   $("#areasSecond"+firstId).append("<option value='"+firstCd+"000'>" + "- 전체 -"+"</option>");  
		   $("#areasAllCode").find("option").each(function() {  
		    if($(this).val().substring(0,2)==firstCd)
		    {     
		    	$("#areasSecond"+firstId).append("<option value='" + this.value +"'>" + this.text +"</option>");     
		    }
		   });
		
	});



	

		$(document).on("click","input[name=productAllCheck]",function(){
			
			  if($("#productAllCheck").prop("checked")){		            
		            $("input[name=productCheck]").prop("checked",true);		            
		        }else{		            
		            $("input[name=productCheck]").prop("checked",false);
		        }
		});
		
		$(document).on("click","input[name=areaAllCheck]",function(){
			
			  if($("#areaAllCheck").prop("checked")){		            
		            $("input[name=areaCheck]").prop("checked",true);		            
		        }else{		            
		            $("input[name=areaCheck]").prop("checked",false);
		        }
		});

});

function contentsWrite(){

	var url = "";

	// 썸네일은 이미지형식으로저장
	if ($("#thumb").val() != "" && !$("#thumb").val().toLowerCase().match(/\.(jpg|png|gif)$/)){
		alert("확장자가 jpg,png,gif 파일만 업로드가 가능합니다.");
		return;
	}

   if ( $("#writeFrm").parsley().validate() ){
		// 로그인 여부 확인하기
		var sid = "${Member.memId}";
		if($("#mode").val() != "E"){
			if(sid == ""){
				// 개인정보 동의 여부 확인
				if($("#phone2").val() != undefined && $("#phone3").val() != undefined){
					if(!$("#agreement").is(":checked")){
						alert("개인정보 동의가 필요합니다.");
						return;
					}
				}
			}
		}

	   if($("#mode").val() == "E"){
		   url = updateBoardContentsUrl;
	   }else if($("#mode").val() == "R"){
		   url = insertBoardContentsReplyUrl;
	   }else{
		   url = insertBoardContentsUrl;
	   }

	   // 데이터를 등록 처리해준다.
	   $("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					list();
				}
			},
			dataType: "json",
			url: url
	    });
   }

}


function list(){
	var f = document.writeFrm;

    f.target = "_self";
    f.action = listUrl;
    f.submit();
}


function fileTransfer(){

	if(!confirm("저장하시겠습니까?")){
		return;
	}
}

function productAdd(){
	
	productCnt++;
	
	
	var str = "";
	str		 += "<tr>";
    str		 += "<td>";
    str		 += "<label for='' class='hide2'>선택</label>";
    str     += "<input id='' name='productCheck' type='checkbox' value=''>";
    str     += "</td>";
    str     += "<td>";     
    str     += "<label for='productFirst_"+productCnt+"' class='hide2'>품목분류 선택</label>";
    str     += "<select name='productFirst' id='productFirst_"+productCnt+"' class='in_w95'>";
    <c:forEach var = "productCd" items="${productCd}">
	<c:if test="${fn:substring(productCd.code,1,5) eq '0000' }">
		str    += "<option value='${productCd.code}'";
		<c:if test="${fn:substring(productCd.code,0,1) eq '1' }">
		str += "selected='selected'";
		</c:if> 
		str += ">${productCd.name}</option>";
	</c:if>
</c:forEach>
	str += "</select>";
	str += "</td>";
	str += "<td>";
	str += "<label for='productSecond_"+productCnt+"' class='hide2'>품목명 선택</label>";
	str += "<select name='productSecond' id='productSecond_"+productCnt+"' class='in_w95'>";
	<c:forEach var = "productCd" items="${productCd}">
	<c:if test="${fn:substring(productCd.code,0,1) eq '1' }">
    str += "<option value='${productCd.code}'";
  			  <c:if test="${productCd.code eq '10000' }">
    str+= "selected='selected'";
   				 </c:if>
    str += ">${productCd.name}</option>";
    </c:if>
    </c:forEach>
    str += "</select>";
    str += "</td>";
    str += "</tr>";   
	$("#productThead").append(str);
	
}


function productDel(){	
	
	$(':checkbox[name="productCheck"]:checked ').parents("tr").remove();	
}



function areaAdd(){
	areaCnt++;
	
	var str = "";
	
	
	
    str+= "<tr>";
    str+= "<td>";
    str+= "	<label for='areaCheck' class='hide2'>선택</label>";
    str+= "      <input id='areaCheck' name='areaCheck' type='checkbox' value=''>";
    str+= " </td>";
    str+= "<td>";
    str+= "	<label for='areasFirts' class='hide2'>시도 선택</label> ";
    str+= "    <select name='areasFirts' id='areasFirts_"+areaCnt+"' class='in_w95'>";
    str+= "		  	<option value='11' selected = 'selected'>서울특별시</option>";
    str+= "        	<option value='26'>부산광역시</option>";
    str+= "			<option value='27'>대구광역시</option>";
    str+= "			<option value='28'>인천광역시</option>";
    str+= "			<option value='29'>광주광역시</option>";
    str+= "			<option value='30'>대전광역시</option>";
    str+= "			<option value='31'>울산광역시</option>";
    str+= "			<option value='36'>세종특별자치시</option>";
    str+= "			<option value='41'>경기도</option>";
    str+= "			<option value='42'>강원도</option>";
    str+= "			<option value='43'>층청북도</option>";
    str+= "			<option value='44'>충청남도</option>";
    str+= "			<option value='45'>전라북도</option>";
    str+= "			<option value='46'>전라남도</option>";
    str+= "			<option value='47'>경상북도</option>";
    str+= "			<option value='48'>경상남도</option>";
    str+= "			<option value='50'>제주특별자치도</option>"; 
    str+= "</select>";
    str+= "</td>";
    str+= "<td>";
    str+= "<label for='areasSecond' class='hide2'>시군구 선택</label>";
    str+= "    <select name='areasSecond' id='areasSecond_"+areaCnt+"' class='in_w95'>";
    str+= " 			<option value='11000' selected = 'selected'>- 전체 -</option>";
            <c:forEach var = 'areas' items='${areas}'>
            	  <c:if test='${fn:substring(areas.code,0,2) eq 11 }'> 
    str+="       			 <option value='${areas.code}' >${areas.name}</option>";                                             	
      	 			</c:if> 
           	</c:forEach>
    str+="    </select>";
    str+="</td>";
	str+="</tr>";
	
	$("#areaThead").append(str);
	
}

function areaDel(){	
	
	$(':checkbox[name="areaCheck"]:checked ').parents('tr').remove();	
}


function jusoPopup()
{
	var pop = window.open("/front/mypage/memberJusoPopup.do","pop","width=570,height=420, scrollbars=yes, resizable=yes");
}

function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn , detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo){

	$("#postNum").val(zipNo);
	$("#addr").val(roadAddrPart1);
	$("#addrDetail").val(addrDetail);

}

function mypageUpdate(){
	
	var url = "/front/mypage/mypageUpdate.do";
	
	 $("#mypageForm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){				
					
				}	
			},
			dataType: "json", 				
			url: url
	    });	
}

</script>



<div class="content_tit" id="containerContent">
       <h3>내정보수정</h3>
    </div>



<div class="content">
                    <form id="mypageForm" name="mypageForm" method="post" class="form-horizontal text-left" data-parsley-validate="true">                    
                    <h5 class="title_h5">손해평가사 정보</h5>
                    <div class="table_area mb20">
                        <table class="table_style4">
                            <caption>손해평가사 정보</caption>
                            <colgroup>
                            <col style="width: 20%;" />
                            <col style="width: 30%;" />
                            <col style="width: 20%;" />
                            <col style="width: 30%;" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">자격증번호</th>
                                    <td>
                                    	<label for="licenseKey" class="hide2">자격증번호 입력</label>
                                    	<input id="licenseKey" type="text" name="licenseKey" class="in_w90 in_bg" value="${mypageInfo.licenseKey}" readonly="readonly" />
                                    </td>
                                    <th scope="row">최종발행번호</th>
                                    <td>
                                    	<label for="finalNum" class="hide2">최종발행번호 입력</label>
                                    	<input id="finalNum" type="text" name="finalNum" class="in_w90 in_bg" value="${mypageInfo.finalNum}" readonly="readonly" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">시험년도</th>
                                    <td>
                                    	<label for="year" class="hide">시험년도 입력</label>
                                    	<input id="year" type="text" name="year" class="in_w90 in_bg" value="${mypageInfo.year}" readonly="readonly" />
                                    </td>
                                    <th scope="row">수험번호</th>
                                    <td>
                                    	<label for="suNum" class="hide">수험번호 입력</label>
                                    	<input id="suNum" type="text" name="suNum" class="in_w90 in_bg" value="${mypageInfo.suNum }" readonly="readonly" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">성명</th>
                                    <td>
                                    	<label for="name" class="hide">성명 입력</label>
                                    	<input id="name" type="text" name="name" class="in_w90 in_bg" value="${mypageInfo.name }" readonly="readonly" />
                                    </td>
                                    <th scope="row">생년월일</th>
                                    <td>
                                    	<label for="birth" class="hide">생년월일 입력</label>
                                    	<input id="birth" type="text" name="birth" class="in_w90 in_bg" value="${mypageInfo.birth}" readonly="readonly" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">합격연월일</th>
                                    <td>
                                    	<label for="submitDt" class="hide">합격연월일 입력</label> 
                                        <input id="submitDt" type="text" name="submitDt" class="in_w90 in_bg" value="${mypageInfo.submitDt}" readonly="readonly" />
                                    </td>
                                    <th scope="row">최종발급연월일</th>
                                    <td>
                                    	<label for="issuedDt" class="hide">최종발급연월일 입력</label>
                                        <input id="issuedDt" type="text" name="issuedDt" class="in_w90 in_bg" value="${mypageInfo.issuedDt}" readonly="readonly" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">휴대전화번호</th>
                                    <td>
                                    	<label for="hp" class="hide">휴대전화번호 입력</label>
                                        <input type="text" id= "hp" name="hp" class="in_w90" value="${mypageInfo.hp}" />
                                    </td>
                                    <th scope="row">일반전화번호</th>
                                    <td>
                                    	<label for="tel" class="hide">일반전화번호 입력</label>
                                        <input type="text" id = "tel" name="tel" class="in_w90" value="${mypageInfo.tel}" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">SMS발송동의여부</th>
                                    <td>
                                        <label for="smsYn" class="hide">SMS발송동의여부 선택</label>
                                        <select name="smsYn" id="smsYn">
                                        	<option value="0" <c:if test='${mypageInfo.smsYn eq 0 }'>selected = "selected"</c:if> >미동의</option>
                                            <option value="1" <c:if test='${mypageInfo.smsYn eq 1 }'>selected = "selected"</c:if> >동의</option>                                            
                                        </select>
                                    </td>
                                    <th scope="row">차량사용여부</th>
                                    <td>
                                        <label for="carYn" class="hide">차량사용여부 선택</label>
                                        <select name="carYn" id="carYn">
                                            <option value="0" <c:if test='${mypageInfo.carYn eq 0 }'>selected = "selected"</c:if> >N</option>
                                            <option value="1" <c:if test='${mypageInfo.carYn eq 1 }'>selected = "selected"</c:if> >Y</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">소속</th>
                                    <td colspan="3">
                                        <label for="label" class="hide">소속 선택</label>
                                        <select name="select" id="label">
                                        	<c:forEach var = "sosokCd" items="${sosokCd}">                                            
                                            <option value="${sosorCd.code}"<c:if test = '${sosokCd.code eq mypageInfo.sosokCd }'>selected = "selected"</c:if>>${sosokCd.value}</option>                                            
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                 <tr>
                                    <th scope="row">소재지</th>
                                    <td colspan="3">
                                        <label for="
" class="hide">소재지 주소 입력</label>
                                        <input id="postNum" name="postNum" type="text" class="in_w30" value="${mypageInfo.postNum}" />
                                        <button type = "button" class="table_btn" title="주소찾기" onclick="jusoPopup()"> <span>주소찾기</span> </button>
                                        <label for="addr" class="hide">소재지 주소 입력</label>
                                        <input id="addr" name="addr" type="text" class="in_w100 mt5"  value = "${mypageInfo.addr }"/>
                                        <label for="addrDetail" class="hide">소재지 주소 입력</label>
                                        <input id="addrDetail" name="addrDetail" type="text" class="in_w100 mt5" value = "${mypageInfo.addrDetail }" />
                                    </td>
                                </tr> 
                                <%-- <tr>
                                    <th scope="row">우편번호</th>
                                    <td colspan="3">
                                        <label for="postNum" class="hide">소재지 주소 입력</label>
                                        <input id="postNum" name="postNum" type="text" class="in_w20" value="${mypageInfo.postNum}" />                                     
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">주소</th>
                                    <td>
                                        <label for="addr" class="hide">소재지 주소 입력</label>
                                        <input id="addr" name="addr" type="text" class="in_w90" value = "${mypageInfo.addr }"/>                                     
                                    </td>
                                    <th scope="row">상세주소</th>
                                    <td >
                                        <label for="addrDetail" class="hide">소재지 주소 입력</label>
                                        <input id="addrDetail" name="addrDetail" type="text" class="in_w90" value = "${mypageInfo.addrDetail }"/>                                     
                                    </td>
                                </tr> --%>
                                
                                
                            </tbody>
                        </table>
                        <p class="tar fs_12">※ 차량사용여부 : 손해평가사 활동에 차량을 이동할 의항이 있으십니까?</p>
                    </div>
                    
                    <h5 class="title_h5">활동가능 시기</h5>
                    <div class="table_area mb20">
                        <table class="table_style">
                            <caption>활동가능 시기 화면</caption>
                            <colgroup>
                                <col style="width: ;" />
                                <col style="width: ;" />
                                <col style="width: ;" />
                                <col style="width: ;" />
                                <col style="width: ;" />
                                <col style="width: ;" />
                                <col style="width: ;" />
                                <col style="width: ;" />
                                <col style="width: ;" />
                                <col style="width: ;" />
                                <col style="width: ;" />
                                <col style="width: ;" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">1월</th>
                                    <th scope="col">2월</th>
                                    <th scope="col">3월</th>
                                    <th scope="col">4월</th>
                                    <th scope="col">5월</th>
                                    <th scope="col">6월</th>
                                    <th scope="col">7월</th>
                                    <th scope="col">8월</th>
                                    <th scope="col">9월</th>
                                    <th scope="col">10월</th>
                                    <th scope="col">11월</th>
                                    <th scope="col">12월</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                    	<label for="jan" class="hide">1월 선택</label>
                                        <input id="jan" name="jan" type="checkbox"  <c:if test ="${months.jan eq '1' }"> checked="checked" </c:if> > 
                                    </td>
                                    <td>
                                    	<label for="feb" class="hide">2월 선택</label>
                                        <input id="feb" name="feb" type="checkbox"  <c:if test ="${months.feb eq '1' }"> checked="checked"</c:if> > 
                                    </td>
                                    <td>
                                    	<label for="mar" class="hide">3월 선택</label>
                                        <input id="mar" name="mar" type="checkbox"  <c:if test ="${months.mar eq '1' }"> checked="checked"</c:if> > 
                                    </td>
                                    <td>
                                    	<label for="apr" class="hide">4월 선택</label>
                                        <input id="apr" name="apr" type="checkbox"  <c:if test ="${months.apr eq '1' }"> checked="checked"</c:if> > 
                                    </td>
                                    <td>
                                    	<label for="may" class="hide">5월 선택</label>
                                        <input id="may" name="may" type="checkbox"  <c:if test ="${months.may eq '1' }"> checked="checked"</c:if> > 
                                    </td>
                                    <td>
                                    	<label for="jun" class="hide">6월 선택</label>
                                        <input id="jun" name="jun" type="checkbox"  <c:if test ="${months.jun eq '1' }"> checked="checked"</c:if> > 
                                    </td>
                                    <td>
                                    	<label for="jul" class="hide">7월 선택</label>
                                        <input id="jul" name="jul" type="checkbox"  <c:if test ="${months.jul eq '1' }"> checked="checked"</c:if> > 
                                    </td>
                                    <td>
                                    	<label for="aug" class="hide">8월 선택</label>
                                        <input id="aug" name="aug" type="checkbox"  <c:if test ="${months.aug eq '1' }"> checked="checked"</c:if> > 
                                    </td>
                                    <td>
                                    	<label for="sep" class="hide">9월 선택</label>
                                        <input id="sep" name="sep" type="checkbox"  <c:if test ="${months.sep eq '1' }"> checked="checked"</c:if> > 
                                    </td>
                                    <td>
                                    	<label for="oct" class="hide">10월 선택</label>
                                        <input id="oct" name="oct" type="checkbox"  <c:if test ="${months.oct eq '1' }"> checked="checked"</c:if> > 
                                    </td>
                                    <td>
                                    	<label for="nov" class="hide">11월 선택</label>
                                        <input id="nov" name="nov" type="checkbox"  <c:if test ="${months.nov eq '1' }"> checked="checked"</c:if> > 
                                    </td>
                                    <td>
                                    	<label for="dec" class="hide">12월 선택</label>
                                        <input id="dec" name="dec" type="checkbox"  <c:if test ="${months.dec eq '1' }"> checked="checked"</c:if> > 
                                    </td>    
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <h5 class="title_h5">주력품목</h5>
                    <div class="table_area mb20">
                        <table class="table_style">
                            <caption>주력품목 화면</caption>
                            <colgroup>
                                <col style="width: 10%;" />
                                <col style="width: 45%;" />
                                <col style="width: 45%;" />
                            </colgroup>
                            <thead >
                                <tr>
                                    <th scope="col">
                                    	<label for="productAllCheck" class="hide">전체 선택</label>
                                        <input id="productAllCheck" name="productAllCheck" type="checkbox" value="">
                                    </th>
                                    <th scope="col">품목분류</th>
                                    <th scope="col">품목명</th>
                                </tr>
                            </thead>
                            <tbody id = "productThead">
                            <c:forEach var = 'myProduct' items="${myProduct}" varStatus="status">
                            <script>
                            	productCnt = "${status.index+1}";                            	
                            </script>
                                <tr >
                                    <td>
                                    	<label for="productCheck" class="hide">선택</label>
                                        <input id="productCheck" name="productCheck" type="checkbox" value="">
                                    </td>                   
                                    
                                    <td>                                    
                                    	<label for="productFirst_${status.index+1}" class="hide">품목분류 선택</label>
                                        <select name="productFirst" id="productFirst_${status.index+1}" class="in_w95">                                        
                                            <c:forEach var = "productCd" items="${productCd}">
                                                 <c:if test="${fn:substring(productCd.code,1,5) eq '0000' }">  
                                                 	<option value="${productCd.code}" <c:if test="${fn:substring(productCd.code,0,1) eq  fn:substring(myProduct.productCd,0,1) }">selected="selected"</c:if> >${productCd.name}</option>
                                                 </c:if>  
                                            </c:forEach>
                                        </select>
                                    </td>
                                    
                                    <td>
                                    	<label for="productSecond_${status.index+1}" class="hide">품목명 선택</label>
                                        <select name="productSecond" id="productSecond_${status.index+1}" class="in_w95">
                                            <c:forEach var = "productCd" items="${productCd}">
                                                 <c:if test="${fn:substring(myProduct.productCd,0,1) eq fn:substring(productCd.code,0,1) }">  
                                                 	<option value="${productCd.code}" <c:if test="${fn:substring(productCd.code,1,5) eq  fn:substring(myProduct.productCd,1,5) }">selected="selected"</c:if> >${productCd.name}</option>
                                                 </c:if>  
                                            </c:forEach>                                            
                                        </select>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="tar">
                        	<button type = "button" class="btn_add" title="행추가" onclick="productAdd()"> <span>행추가</span> </button>
                            <button type = "button" class="btn_del" title="행삭제" onclick="productDel()"> <span>행삭제</span> </button>
                        </div>
                    </div>
                    
                    <h5 class="title_h5">활동 지역</h5>
                    <div class="table_area mb20">
                        <table class="table_style">
                            <caption>활동 지역 화면</caption>
                            <colgroup>
                                <col style="width: 10%;" />
                                <col style="width: 45%;" />
                                <col style="width: 45%;" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">
                                    	<label for="areaAllCheck" class="hide">전체 선택</label>
                                        <input id="areaAllCheck" name="areaAllCheck" type="checkbox" value="">
                                    </th>
                                    <th scope="col">시도</th>
                                    <th scope="col">시군구</th>
                                </tr>
                            </thead>
                            <tbody id="areaThead">
                            
                            <c:forEach var = "myAreasList" items="${myAreasList}" varStatus="status" >            
									<script>
		                            	areaCnt = "${status.index+1}";                            	
		                            </script>               
                                <tr>
                                    <td>
                                    	<label for="areaCheck" class="hide">선택</label>
                                        <input id="areaCheck" name="areaCheck" type="checkbox" value="">
                                    </td>
                                    <td>
                                    	<label for="areasFirts" class="hide">시도 선택</label>
                                        <select name="areasFirts" id="areasFirts_${status.index}" class="in_w95">
                                            <option value="11" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 11}"> selected = "selected"</c:if>>서울특별시</option>
                                            <option value="26" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 26}"> selected = "selected"</c:if>>부산광역시</option>
                                            <option value="27" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 27}"> selected = "selected"</c:if>>대구광역시</option>
                                            <option value="28" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 28}"> selected = "selected"</c:if>>인천광역시</option>
                                            <option value="29" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 29}"> selected = "selected"</c:if>>광주광역시</option>
                                            <option value="30" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 30}"> selected = "selected"</c:if>>대전광역시</option>
                                            <option value="31" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 31}"> selected = "selected"</c:if>>울산광역시</option>
                                            <option value="36" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 36}"> selected = "selected"</c:if>>세종특별자치시</option>
                                            <option value="41" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 41}"> selected = "selected"</c:if>>경기도</option>
                                            <option value="42" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 42}"> selected = "selected"</c:if>>강원도</option>
                                            <option value="43" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 43}"> selected = "selected"</c:if>>층청북도</option>
                                            <option value="44" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 44}"> selected = "selected"</c:if>>충청남도</option>
                                            <option value="45" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 45}"> selected = "selected"</c:if>>전라북도</option>
                                            <option value="46" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 46}"> selected = "selected"</c:if>>전라남도</option>
                                            <option value="47" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 47}"> selected = "selected"</c:if>>경상북도</option>
                                            <option value="48" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 48}"> selected = "selected"</c:if>>경상남도</option>
                                            <option value="50" <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq 50}"> selected = "selected"</c:if>>제주특별자치도</option> 
                                        </select>
                                    </td>
                                    <td>
                                    	<label for="areasSecond" class="hide">시군구 선택</label>
                                        <select name="areasSecond" id="areasSecond_${status.index}" class="in_w95">
                                        				<option value="${fn:substring(myAreasList.areaCd,0,2)}000" <c:if test = "${fn:substring(myAreasList.areaCd,3,5) eq '000'}">selected = "selected"</c:if> >- 전체 -</option>
                                            <c:forEach var = "areas" items="${areas}">                                      
                                            	  <c:if test="${fn:substring(myAreasList.areaCd,0,2) eq fn:substring(areas.code,0,2)}"> 
                                            			 <option value="${areas.code}"  <c:if test = "${myAreasList.areaCd eq areas.code   }">selected = "selected"</c:if>    >${areas.name}</option>                                             	
                                            	 </c:if>
                                           </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="tar">
                        	<button type="button" class="btn_add" title="행추가" onclick="areaAdd()"> <span>행추가</span> </button>
                            <button type="button" class="btn_del" title="행삭제" onclick="areaDel()"> <span>행삭제</span> </button>
                        </div>
                    </div>
                    </form>
                    <!-- btn_area -->
                    <div class="btn_area tac">
                        <a href="javascript:mypageUpdate()" class="btn_modify" title="수정">수정</a>
                    </div>
                    <!--//btn_area -->
                    
                </div>
               							 <select name="productAllCode" id="productAllCode" class="in_w95" style = "display: none">
                                            <c:forEach var = "productCd" items="${productCd}">                                                   
                                                 	<option value="${productCd.code}" >${productCd.name}</option>                                                   
                                            </c:forEach>                                            
                                        </select>
                                        
                                        <select name="areasAllCode" id="areasAllCode" class="in_w95" style = "display: none">
                                            <c:forEach var = "areas" items="${areas}">                                                   
                                                 	<option value="${areas.code}" >${areas.name}</option>                                                   
                                            </c:forEach>                                            
                                        </select>
