<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script>
$(document).ready(function(){

	$('#category_list').jqGrid({
		datatype: 'json',
		url: selectBoardCategoryListUrl,
		mtype: 'post',
		colModel: [
			{ label: 'boardId', index: 'boardId', name: 'boardId', hidden:true },
			{ label: 'cateId', index: 'cateId', name: 'cateId', hidden:true },
			{ label: '코드', index: 'sort', name: 'sort', width: 130, align : 'center', sortable:false},
			{ label: '카테고리명', index: 'cateNm', name: 'cateNm', align : 'left', sortable:false, width:300, formatter:jsCateNmLinkFormmater},
			{ label: '사용여부', index: 'useYnNm', name: 'useYnNm', align : 'center', sortable:false, width:130}
		],
		postData :{	
			boardId : $("#boardId").val()
		},
		viewrecords : true,
		gridview : true,
		autowidth : true,
		loadComplete : function(data) {
			showJqgridDataNon(data, "category_list",3);
		}
	});
	//jq grid 끝
	
	//bindWindowJqGridResize("category_list", "category_list_div");

});

</script>

<form id="listFrm2" name="listFrm2" method="post">
	<input type='hidden' id="boardId" name='boardId' value="${param.boardId}" />
	<input type='hidden' id="cateId" name='cateId' value="" />
	<input type='hidden' id="sort" name='sort' value="" />
	<input type='hidden' id="mode" name='mode' value="W" />

<!-- tabel_search_area -->
<div class="table_search_area" style="margin-top:10px;padding-left:10px;padding-right:10px">
	<div class="float_right">
		<a href="javascript:categoryFrm('W')" class="btn acti" title="등록">
			<span>등록</span>
		</a>
	</div>
</div>
<!--// tabel_search_area -->

<!-- table 1dan list -->
<div class="table_area" id="category_list_div" style="margin-top:10px;padding-left:10px;padding-right:10px">
    <table id="category_list"></table>
       <div id="category_pager"></div>
</div>
<!--// table 1dan list -->


<div id="categoryWriteDiv" class="table_area" style="margin :10px;padding-left:10px;padding-right:10px;display:none">
	<!-- write_basic -->
	<table class="write">
		<tbody>
	 		<tr id="regTd" style="display:none">
				<td class="col-md-3 use-head">등록자</td>
				<td class="col-md-3">
					<div class="input-group" id="regUsernm" style="width:100%"></div>
				</td>
				<td class="col-md-3 use-head">등록일</td>
				<td class="col-md-3">
					<div class="input-group" id="regDt" style="width:100%"></div>
				</td>
			</tr>
			<tr>
				<td class="col-md-3 use-head">카테고리명 <span class="asterisk">*</span></td>
				<td class="col-md-9" colspan="3">
					<div class="input-group" style="width:100%">
						<input class="form-control" type="text" id="cateNm1" name="cateNm" value="" placeholder="카테고리명" style="width:100%" data-parsley-required="true" data-parsley-maxlength="100"  />
					</div>
				</td>
			</tr>
			<tr>
				<td class="col-md-3 use-head">사용여부</td>
				<td class="col-md-9" colspan="3">
					<div class="input-group" style="width:100%">
						   <input type="radio" name="useYn" value="Y" checked> 사용 
						   <input type="radio" name="useYn" value="N"> 미사용 
					</div>
				</td>
			</tr>	
	 	</tbody>
	</table>
	<!--// write_basic -->
	<!-- footer --> 
	<footer>
		<div class="button_area alignc"  style="padding-top:10px;">
			<a href="javascript:categorySave()" class="btn save" title="저장">
				<span>저장</span>
			</a>
			<a id="deleteA"  href="javascript:categoryDelete()" class="btn cancel" title="삭제">
				<span>삭제</span>
			</a>
			<a href="javascript:popupClose()" class="btn cancel" title="닫기">
				<span>취소</span>
			</a>
		</div>
	</footer>
</div>

</form>
