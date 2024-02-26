<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var selectMenuSearchListUrl = "<c:url value='/back/menu/menuSearchList.do'/>";
var selectExeRankListUrl = "<c:url value='/back/contents/exeRankList.do'/>";
var boardContentsReorderNotiUrl = "<c:url value='/back/board/updateBoardContentsReorderNoti.do'/>";
var rankInsertpageUrl = "<c:url value='/back/contents/exeRankInsertpage.do'/>";
var rankInsertUrl = "<c:url value='/back/contents/exeRankInsert.do'/>";
var rankDeleteUrl = "<c:url value='/back/contents/exeRankDelete.do'/>";

var savedRow = null;
var savedCol = null;
</script>
<script>
function rankdataInsert(){
	  
   var url = "";
   if ( $("#insertFrm").parsley().validate() ){
	   url = rankInsertUrl;
	   // 데이터를 등록 처리해준다.	   
	   $("#insertFrm").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						
						popupClose2();
						rankSearch();
					}	
				},
				dataType: "json", 				
				url: url
		    });	
	   
   }
}

function rankdataDelete(){
	
	
	if ($("#rankId").val() == "W") {
		alert("삭제할 데이터가 없습니다.")
		return;
	}
	
	if (!confirm("정말 삭제하시겠습니까?")) {
		return;
	}
		   url = rankDeleteUrl;
		   // 데이터를 등록 처리해준다.	   
		   $("#insertFrm").ajaxSubmit({
					success: function(responseText, statusText){
						alert(responseText.message);
						if(responseText.success == "true"){
							popupClose2();
							rankSearch();
						}	
					},
					dataType: "json", 				
					url: url
			    });	
	   
}

</script>

<div class="search_area" align="center" >
		 <form id="insertFrm" name="insertFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
		 <table class="search_box"  >
			<caption>코드구분검색</caption>
			<colgroup>
				<col style="width: 80px;" />
				<col style="width: 40%;" />		
			</colgroup>
			<tbody>
			<tr>
				<th>직위명</th>
				<td>          
                  <input type="text" class="in_wp200" id="rankNm" name="rankNm" value="${exeRankInfo.rankNm}"  placeholder="" data-parsley-required="true">
                  <input type = "hidden" id="rankId" name = "rankId" value = '${exeRankInfo.rankId}' />
				</td>	
				</tr>
			</tbody>
		</table>	
		</form>
		
	</div>	
		
		<!-- tabel_search_area -->
		<div class="table_search_area">
		<div class="float_right">
					<a href="javascript:rankdataInsert()" class="btn acti" title="저장">
						<span>저장</span>
					</a>
				 	<c:if test="${exeRankInfo.rankId.toString() ne 'W' }">
					<a href="javascript:rankdataDelete()" class="btn acti" title="삭제">
						<span>삭제</span>					
					</a>
					</c:if> 
					<a href="javascript:popupClose2()" class="btn acti" title="취소">
						<span>취소</span>
					</a>
			     
		</div>
	</div>
		<!--// tabel_search_area -->
		
		
	
