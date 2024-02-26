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
 
		
		
	
		
	}); 


	$("#skip_nav").focus();		//	키보드 이동을 위해 포커스 - 2020.10.19
	
	
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



function productDel(){	
	
	$(':checkbox[name="productCheck"]:checked ').parents("tr").remove();	
}
</script>



<div class="content_tit" id="containerContent">
       <h3>교육신청 및 이력</h3>
    </div>


 <div class="content">
                    
                    <h5 class="title_h5">교육 현황</h5>
                    <div class="table_area mb20">
                        <table class="table_style">
                            <caption>교육 현황 화면</caption>
                            <colgroup>
                                <col style="width: 10%;" />
                                <col style="width: 10%;" />
                                <col style="width: 10%;" />
                                <col style="width: *;" />
                                <col style="width: 20%;" />
                                <col style="width: 10%;" />
                                <col style="width: 10%;" />
                            </colgroup>
                            <thead>
                            
                                <tr>
                                    <th scope="col">구분</th>
                                    <th scope="col">년도</th>
                                    <th scope="col">회차</th>
                                    <th scope="col">교육명</th>
                                    <th scope="col">교육기간</th>
                                    <th scope="col">이수상태</th>
                                    <th scope="col">이수날짜</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:if test = "${fn:length(myEdduHistory) gt 0 }">
                            <c:forEach	var = "myEduHistory" items="${myEdduHistory}">
                                <tr>                                	
                                    <td>${myEduHistory.gubun}</td>
                                    <td>${myEduHistory.year}</td>
                                    <td>${myEduHistory.num}</td>
                                    <td class="txt_left">${myEduHistory.title}</td>
                                    <td>${myEduHistory.sDay} ~ ${myEduHistory.eDay}</td>
                                    <td><span class="state_on">${myEduHistory.isu}</span></td>
                                    <td>${myEduHistory.eduFinDay}</td>
                                </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test = "${fn:length(myEdduHistory) lt 1 }">                               
                                <tr>
                                    <td colspan="7">등록된 교육 현황이 없습니다.</td>
                                </tr>
                            </c:if>    
                            </tbody>
                        </table>
                    </div>
                    
                    <h5 class="title_h5">교육 예정 현황</h5>
                    <div class="table_area mb20">
                        <table class="table_style">
                            <caption>교육 예정 현황 화면</caption>
                            <colgroup>
                                <col style="width: 10%;" />
                                <col style="width: 10%;" />
                                <col style="width: 10%;" />
                                <col style="width: *;" />
                                <col style="width: 20%;" />
                                <col style="width: 10%;" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">구분</th>
                                    <th scope="col">년도</th>
                                    <th scope="col">회차</th>
                                    <th scope="col">교육명</th>
                                    <th scope="col">교육기간</th>
                                    <th scope="col">참석여부</th>
                                </tr>
                            </thead>
                            <tbody>      
                            <c:if test = "${fn:length(myEduFuture) gt 0 }">
                            <c:forEach var = "myEduFuture" items="${myEduFuture}">
                                <tr>                                	
                                    <td>${myEduFuture.gubun}</td>
                                    <td>${myEduFuture.year}</td>
                                    <td>${myEduFuture.num}</td>
                                    <td class="txt_left">${myEduFuture.title}</td>
                                    <td>${myEduFuture.sDay} ~ ${myEduFuture.eDay}</td>
                                    <td><span class="state_on">${myEduFuture.isu}</span></td>                                    
                                </tr>
                            </c:forEach>    
                            </c:if>
                            <c:if test = "${fn:length(myEduFuture) lt 1 }">                               
                                <tr>
                                    <td colspan="6">등록된 교육 예정 현황이 없습니다.</td>
                                </tr>
                            </c:if>                          
                                
                            </tbody>
                        </table>
                    </div>
                    <!-- btn_area -->
                    <!-- 
                    <div class="btn_area tac pt30">
                        <a href="#none" class="btn_modify" title="수정">수정</a>
                    </div>
                     -->
                    <!--//btn_area -->
                    
                </div>
