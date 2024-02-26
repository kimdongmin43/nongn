
// 페이지 이동 1,2, ... 하는 HTML 코드를 생성해서 돌려준다.
//	funcName : 실제 페이지 이동을 위한 함수이름 (예: gotoPage)
//	pageNum : 현재 페이지 번호
//	pageSize : 한 페이지당 결과 갯수
//	total : 전체 결과 갯수

function navAnchor( funcName, pageNo, anchorText,classNm )
{
    var font_class = "<a href=\"javascript:{" + funcName + "(" + pageNo + ")}\" class=\""+classNm+"\">" + anchorText + "</a>";
	return font_class;
}

function pageNav( funcName, pageNum, pageSize, total )
{
	if( total < 1 )
		return "";

	var ret = "";
	var PAGEBLOCK=10;
	var totalPages = Math.floor((total-1)/pageSize) + 1;

	var firstPage = Math.floor((pageNum-1)/PAGEBLOCK) * PAGEBLOCK + 1;
	if( firstPage <= 0 ) // ?
		firstPage = 1;

	var lastPage = firstPage-1 + PAGEBLOCK;
	if( lastPage > totalPages )
		lastPage = totalPages;

	if( firstPage > PAGEBLOCK )
	{
        ret += navAnchor(funcName, 1, "<img src='/images/icon_arr_total_01.png' alt='처음으로' />",'btn-total');
		ret += navAnchor(funcName, firstPage-1, "<img src='/images/icon_arr_total_02.png' alt='이전' />",'btn-total') ;
	}
	ret += "<span class='mobileoff_in'>";
	for( i=firstPage; i<=lastPage; i++ )
	{
		if( pageNum == i )
			ret += "<a href='#' class='on'>" + i + "</a>";
		else
			ret += "" + navAnchor(funcName, i, i) + "";
	}
	ret += "</span>";
	ret += "<span class='mobileon_in'>";
	for( i=firstPage; i<=lastPage; i++ )
	{
		if( pageNum == i )
			ret += "<a href='#' class='on'>" + i + "</a>";
		else
			ret += "" + navAnchor(funcName, i, i) + "";
	}
	ret += "</span>";
	if( lastPage < totalPages )
	{
		ret += navAnchor(funcName, lastPage+1, "<img src='/images/icon_arr_total_03.png' alt='다음' />",'btn-total') + "";
		ret += "" + navAnchor(funcName, totalPages, "<img src='/images/icon_arr_total_04.png' alt='마지막으로' />",'btn-total') + "\n";
	}
	$('.paging_total').html(ret);
	//return ret;
}
