/*******************************************************
* 프로그램명 : search.js   # 검색기능
* 설명             : 통합검색용 자바스크립트
* 작성일         :  2010.04.05
* 작성자         : 정민철
* 수정내역     :
  *****************************************************/


/**
* gnb검색창 Object 리턴
* @ param  
* @ return  searchForm 폼 객체 리턴
**/
function getGnbForm()
{
	return document.forms["searchForm"];
}

/**
* History폼 Object 리턴
* @ param  
* @ return  historyForm 폼 객체 리턴
**/
function getHistoryForm()
{
	return document.forms["historyForm"];
}

/**
* 상세검색 form Object 리턴
* @ param  
* @ return  detailSearchForm 폼 객체 리턴
**/
function getDetailForm()
{
	return document.forms["detailSearchForm"];
}


/**
* 검색어 체크 
* @ param	frm			- form Object
*
* @ return   true / false 		- 키워드 있음(true) , 없음(false)
**/
function seachKwd(frm)
{
	var kwd = CommonUtil.getValue(frm, "kwd");
	if (kwd == "")
	{
		alert("검색어를 입력해 주세요");
		return false;
	}
	else
		return true;
}
function detailSeachKwd(frm)
{
	seachKwd(frm);
}

/**
* 특정 kwd로 검색( historyForm사용)
* @ param	str			- 검색어
*
* @ return   void
**/
function goKwd(str)
{
	var frm = getHistoryForm();
	
	CommonUtil.setValue(frm,"kwd",str);
	CommonUtil.setValue(frm,"pageNum","1");
	CommonUtil.setValue(frm,"reSrchFlag",false);
	
	frm.submit();
}

/**
* 특정 카테고리로 이동 ( historyForm사용)
* @ param	str			- 카테고리명
*
* @ return   void
**/
function goCategory(str)
{
	var frm = getHistoryForm();
	
	CommonUtil.setValue(frm,"pageNum","1");
	CommonUtil.setValue(frm,"category",str);
	
	frm.submit();
}

/**
* 정렬조건 변경 ( historyForm사용)
* @ param	str			- 정렬코드
*
* @ return   void
**/
function goSort(str)
{
	var frm = getHistoryForm();
	
	CommonUtil.setValue(frm,"pageNum","1");
	CommonUtil.setValue(frm,"sort",str);
	
	frm.submit();
}

/**
* 페이지 이동 ( historyForm사용)
* @ param	pagenum		- 페이지 번호
*
* @ return   void
**/
function gotoPage(pagenum)
{
	var frm = getHistoryForm();
	
	CommonUtil.setValue(frm,"pageNum",pagenum);
	frm.submit();
}

/*******************************************************
* 프로그램명 : search.js   # 공통기능
* 설명             : 통합검색용  범용 코드 구현 js Class (CommonUtil)
* 작성일         :  2010.04.05
* 작성자         : 정민철
* 수정내역     :
*
* 2010.03.25 - 첨부파일미리보기 펑션수정
* 2010.03.24 - trim, replaceAll 추가
* 2010.03.23 - getValues 기능추가
* 2010.03.17 - getValue의 checkbox 리턴값 버그 수정
  *****************************************************/
var CommonUtil = {
	
	/**
	* URL을 받아서 해당 결과를 String으로 리턴해줌
	* @ param   url		- 읽어올 페이지의 주소
	* 
	* @ return   str		-  url에서 보여지는 페이지 결과의 string
	*
	**/
	UtltoHtml : function (url) {
		var str = "";

		var xmlhttp = null;

		if(window.XMLHttpRequest) {
		   // FF 로 객체선언
		   xmlhttp = new XMLHttpRequest();
		} else {
		   // IE 경우 객체선언
		   xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		if ( xmlhttp ) 
		{//비동기로 전송
			xmlhttp.open('GET', url, false);
			xmlhttp.send(null);
			str = xmlhttp.responseText;
		}
		return str;
	},
	
	/**
	* form 의 특정 name에 값을 세팅해줌 (라디오버튼, input,hidden, 셀렉트 박스) 알아서 처리해줌
	* @ param   frmobj		- 폼오브젝트
	* @ param	name			- 해당 데이터의 name
	* @ param	value			- 세팅될 값
	*
	* @ return   void
	* 
	* 주의사항
	* name이 복수개일경우 첫번째에 값을 세팅해줌
	**/
	setValue : function (frmobj, name, value) {
		if ( typeof(frmobj) == "object" && typeof(frmobj.length) == "number");
		{
			for (var i=0; i< frmobj.length; i++)
			{
				if (frmobj[i].name == name)
				{
					if (frmobj[i].type=="text" || frmobj[i].type=="hidden" )
					{// hidden , text
						frmobj[i].value = value;
						break;
					}//--end: hidden, text
					else if (frmobj[i].type=="radio" && frmobj[i].value == value )
					{// radio 버튼
						 frmobj[i].checked = true;
						 break;
					}//--end:radio
					else if (frmobj[i].type=="checkbox")
					{//checkbox박스
						if (value == true)
							frmobj[i].checked = true;
						else
							frmobj[i].checked = false;
						
						break;
					}//--end:checkbox
					else if (frmobj[i].type=="select-one" && typeof(frmobj[i].options) == "object" && typeof(frmobj[i].length) == "number")
					{//select박스
						var selectidx = 0;
						for(var j=0; j<frmobj[i].length; j++)
						{
							if (value == frmobj[i].options[j].value)
							{
								selectidx = j;
								break;
							}
						}
						frmobj[i].selectedIndex = selectidx;
					}//--end:select
					
				}
				
			}
		}
	},
	
	/**
	* form 의 특정 name에 값을 가져옴 (라디오버튼, input,hidden, 셀렉트 박스 알아서 처리됨  )
	* @ param   frmobj		- 폼오브젝트
	* @ param	name			- 해당 데이터의 name
	*
	* @ return   해당 frmobj의 특정 name에 있는 값(value)
	* 
	* 주의사항
	* name이 복수개일경우 첫번째에 값을 리턴
	**/
	getValue : function (frmobj, name)	{
		var result = null;

		if ( typeof(frmobj) == "object" && typeof(frmobj.length) == "number");
		{
			for (var i=0; i< frmobj.length; i++)
			{
				if (frmobj[i].name == name)
				{
					if (frmobj[i].type=="text" || frmobj[i].type=="hidden" )
					{// hidden , text
						result = frmobj[i].value;
						break;
					}//--end: hidden, text
					else if (frmobj[i].type=="radio" && frmobj[i].checked == true)
					{// radio 버튼
						 result = frmobj[i].value;
						 break;
					}//--end:radio
					else if (frmobj[i].type=="checkbox")
					{//checkbox박스
						result = frmobj[i].checked;
						break;
					}//--end:checkbox
					else if (frmobj[i].type=="select-one" && typeof(frmobj[i].options) == "object" && typeof(frmobj[i].length) == "number")
					{//select박스
						var idx = frmobj[i].selectedIndex;
						result = frmobj[idx].value;
						break;
					}
				}
			}
		}
		return result;
	},
	
	/**
	* form 의 특정 name에 값을 가져옴(라디오버튼, input,hidden, 셀렉트 박스 알아서 처리됨  )
	*
	* @ param   frmobj		- 폼오브젝트
	* @ param	name			- 해당 데이터의 name
	*
	* @ return   해당 frmobj의 특정 name에 있는 값(value)
	* 
	* 주의사항
	* name이 복수개일경우 공백(space)을 넣어 나열된 값을 리턴
	**/
	getValues : function (frmobj, name)	{
		var result = "";

		if ( typeof(frmobj) == "object" && typeof(frmobj.length) == "number");
		{
			for (var i=0; i< frmobj.length; i++)
			{
				if (frmobj[i].name == name)
				{
					if (frmobj[i].type=="text" || frmobj[i].type=="hidden" )
					{// hidden , text
						result += frmobj[i].value;
					}//--end: hidden, text
					else if (frmobj[i].type=="radio" && frmobj[i].checked == true)
					{// radio 버튼
						 result += frmobj[i].value;
					}//--end:radio
					else if (frmobj[i].type=="checkbox")
					{//checkbox박스
						result += frmobj[i].checked;
					}//--end:checkbox
					else if (frmobj[i].type=="select-one" && typeof(frmobj[i].options) == "object" && typeof(frmobj[i].length) == "number")
					{//select박스
						var idx = frmobj[i].selectedIndex;
						result += frmobj[idx].value;
					}
					
					result += " ";
				}
			}
		}
		return result;
	},
	
	/**
	* 문자열 치환
	*
	* @ param   target		- 원본 text
	* @ param   oldstr		- 변경 대상 string
	* @ param   newstr	- 변경될 string
	*
	* @ return   		- 치환된 text
	**/	
	replaceAll : function (target, oldstr, newstr)
	{
		var result = target;
		if (target != null)
		{
			result = target.split(oldstr).join(newstr);
		}
		return result;
	},
	
	/**
	* white Space제거
	*
	* @ param   str		- 문자열
	*
	* @ return   		- 제거된 문자열
	**/	
	trim : function (str)
	{
		var result = str;
		if (str != null)
		{
			result = result.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		}
		return result;
	},
	
	//엘레먼트의 절대값 y픽셀을 구함
	getElementY : function(element)
	{
		var targetTop = 0;

		if (element.offsetParent)
		{
			while (element.offsetParent)
			{
				targetTop += element.offsetTop;
	            element = element.offsetParent;
			}
		}
		else if(element.y)
		{
			targetTop += element.y;
	    }

		return targetTop;
	},
	//엘레먼트의 절대값 x픽셀을 구함
	getElementX : function(element)
	{
		var targetTop = 0;

		if (element.offsetParent)
		{
			while (element.offsetParent)
			{
				targetTop += element.offsetLeft;
	            element = element.offsetParent;
			}
		}
		else if(element.x)
		{
			targetTop += element.x;
		}

		return targetTop;
	}
}
