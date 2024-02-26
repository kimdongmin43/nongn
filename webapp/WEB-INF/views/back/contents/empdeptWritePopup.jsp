<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script>
var selectMenuSearchListUrl = "<c:url value='/back/menu/menuSearchList.do'/>";
var selectEmpDeptListUrl = "<c:url value='/back/contents/empDeptList.do'/>";
var boardContentsReorderNotiUrl = "<c:url value='/back/board/updateBoardContentsReorderNoti.do'/>";
var deptInsertpageUrl = "<c:url value='/back/contents/empDeptInsertpage.do'/>";
var deptInsertUrl = "<c:url value='/back/contents/empDeptInsert.do'/>";
var deptDeleteUrl = "<c:url value='/back/contents/empDeptDelete.do'/>";

var savedRow = null;
var savedCol = null;
</script>
<script>
function deptdataInsert(){
	  
   var url = "";
   if ( $("#insertFrm2").parsley().validate() ){
	   url = deptInsertUrl;
	   // 데이터를 등록 처리해준다.	   
	   $("#insertFrm2").ajaxSubmit({
				success: function(responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						
						popupClose4();
						search2();
					}	
				},
				dataType: "json", 				
				url: url
		    });	
	   
   }
}

function deptdataDelete(){
	
	
	if ($("#deptId").val() == "W") {
		alert("삭제할 데이터가 없습니다.")
		return;
	}
	
	
	if (!confirm("정말 삭제하시겠습니까?")) {
		return;
	}
		   url = deptDeleteUrl;
		   // 데이터를 등록 처리해준다.	   
		   $("#insertFrm2").ajaxSubmit({
					success: function(responseText, statusText){
						alert(responseText.message);
						if(responseText.success == "true"){
							popupClose4();
							search2();
						}	
					},
					dataType: "json", 				
					url: url
			    });	
	   
}

</script>

<div class="search_area" align="center" >
		 <form id="insertFrm2" name="insertFrm2" method="post" class="form-horizontal text-left" data-parsley-validate="true">
		 <table class="search_box"  >
			<caption>코드구분검색</caption>
			<colgroup>
				<col style="width: 80px;" />
				<col style="width: 40%;" />		
			</colgroup>
			<tbody>
			<tr>
				<th>업무명</th>
				<td>          
                  <input type="text" class="in_wp200" id="deptNm" name="deptNm" value="${empDeptInfo.deptNm}"  placeholder="" data-parsley-required="true">
                  <input type = "hidden" id="deptId" name = "deptId" value = '${empDeptInfo.deptId}' />
				</td>	
				</tr>
			</tbody>
		</table>	
		</form>
		
	</div>	
		
		<!-- tabel_search_area -->
		<div class="table_search_area">
		<div class="float_right">
					<a href="javascript:deptdataInsert()" class="btn acti" title="저장">
						<span>저장</span>
					</a>
				 	<c:if test="${empDeptInfo.deptId.toString() ne 'W' }">
					<a href="javascript:deptdataDelete()" class="btn acti" title="삭제">
						<span>삭제</span>					
					</a>
					</c:if> 
					<a href="javascript:popupClose4()" class="btn acti" title="취소">
						<span>취소</span>
					</a>
			     
		</div>
	</div>
		<!--// tabel_search_area -->
		
		
	
