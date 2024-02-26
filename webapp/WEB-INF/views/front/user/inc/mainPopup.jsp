<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- layer popup content -->
<div class="layerPopup">
    <div class="layerBox">
        <!-- <h1 class="title">시스템 작업 안내</h1> -->

<!--         <div class="cont"> -->
<!-- 			<div style="font-size:20px; font-weight:boler; text-align:center; padding:4px;" >2023년 제4차 신규직원 채용 공고</div><br/> -->
<!-- 농업정책보험금융원에서 농림수산정책자금을 효율적으로 관리함으로써<br/>농림수산업의 발전에 기여할 유능한 인재를 채용하고자<br/>다음과 같이 공개모집 하오니 뜻있는 분들의 많은 지원을 바랍니다. -->

<!-- 1. 채용형태: 정규직 1명, 계약직 1명<br/> -->

<!-- 2. 채용분야<br/> -->

<!--  - 정규직(일반직 5급, 신입): 행정사무(정책금융): 1명<br/> -->

<!--  - 계약직(기간제, 신입): 행정사무(정책금융): 1명<br/> -->

<!-- 3. 임용예정일<br/> -->

<!--  - 정규직(일반직 5급, 신입): 2023. 8월말<br/> -->

<!--  - 계약직(기간제, 신입): 2023. 8월말<br/> -->

<!-- 4. 지원방법: 우리원 채용페이지(<a href="https://apfs.saramin.co.kr/">https://apfs.saramin.co.kr/</a>)을 통해 지원<br/> -->

<!--       * 채용공고 및 원서접수기간: 2023.7.7.(금) 17:00 ~ 7.24.(월) 11:00(17일간)<br/> -->

<!--       * 세부사항은 우리원 채용페이지 또는 공고문 참조<br/> -->
<!--         </div> -->

        <div class="cont">
			<a href="https://www.apfs.kr/front/board/boardContentsView.do?miv_pageNo=&miv_pageSize=&total_cnt=&LISTOP=&mode=W&contId=13727&delYn=N&menuId=41&boardId=10026&selTab=&requestUrl=&searchKey=A&searchTxt=" target="_blank"><img src="/images/OS업그레이드 작업공지.jpeg"/></a>
<!-- 			<div class="linkBtn"><a href="https://www.apfs.kr/front/board/boardContentsView.do?boardId=43&contId=13623&menuId=43">&nbsp;&nbsp;&nbsp;&nbsp;자세한 채용 정보로 이동</a></div> -->
        </div>
        
        <a href="javascript:;" class="btnClose">닫기</a>
        <a href="javascript:;" class="btnTodayHide">오늘 하루 보지 않기</a>
    </div>
</div>
<div class="maskLayer"></div>


<style>
/* CSS 
.layerPopup:before {display:block; content:""; position:fixed; left:0; top:0; width:100%; height:100%; background:rgba(0,0,0,.5); z-index:99999999;}
*/
.maskLayer {display:none; }
.maskLayer:before {display:block; content:""; position:fixed; left:0; top:0; width:100%; height:100%; background:rgba(0,0,0,.5); z-index:9999999;}
.layerPopup {display:none; }
.layerPopup .layerBox {position:fixed; left:50%; top:50%; transform:translate(-50%, -50%); padding:30px; background:#fff; border-radius:6px;z-index:999999999; width:635px; height:380px;}
.layerPopup .layerBox .title {margin-bottom:10px; padding-bottom:10px; font-weight:600; border-bottom:1px solid #d9d9d9; line-height:1.3em; text-align:center;}
.layerPopup .layerBox .cont {margin-bottom:40px;}
/* .layerPopup .layerBox p {line-height:20px; font-size:13px;line-height:1.5em; text-align:left;} */
.layerPopup .layerBox .btnClose {display:inline-block; position:absolute; right:34px; top:10px; padding:1px 1px; font-weight:600; color:#444; font-size:12px; text-decoration:underline;}
.layerPopup .layerBox .btnTodayHide {font-size:12px; font-weight:600; text-decoration:underline; position:absolute; left:490px; top:343px; padding:6px 12px;}

@media screen and (max-width: 640px){
.layerPopup .layerBox {width:385px; height:232px;}
.layerPopup .layerBox .linkBtn{font-size:8px;}
.layerPopup .layerBox .btnClose{font-size:8px;}
.layerPopup .layerBox .btnTodayHide{font-size:8px; left:273px; top:204px;}
}

</style>

<script>
/* Javascript */
var $maskLayer = document.querySelector('.maskLayer');
var $layerPopup = document.querySelector('.layerPopup');
var $btnLayerPopupClose = document.querySelector('.layerPopup .btnClose');
var $btnLayerPopupTodayHide = document.querySelector('.layerPopup .btnTodayHide');

//최초 레이어팝업 노출
//layerPopupShow();

//레이어팝업 닫기 버튼 클릭
$btnLayerPopupClose.addEventListener('click', function(){
    layerPopupHide(0);
});

//레이어팝업 오늘 하루 보지 않기 버튼 클릭
$btnLayerPopupTodayHide.addEventListener('click', function(){
    layerPopupHide(1);
});

$maskLayer.addEventListener('click', function(){
    layerPopupHide(0);
});

//레이어팝업 노출
function layerPopupShow(){
	$maskLayer.style.display = 'block';
    $layerPopup.style.display = 'block';
}
//레이어팝업 비노출
function layerPopupHide(state){
    $layerPopup.style.display = 'none';
    $maskLayer.style.display = 'none';
    if(state === 1){
    	//cookie처리
    	setCookie("noToday", "Y", "1")
    }
}



//쿠키설정	
function setCookie( name, value, expiredays ) {			//	-> 화면 전체 소스코드에 이미 이 함수가 있음
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + '=' + escape( value ) + '; path=/; expires=' + todayDate.toGMTString() + ';'
}

//쿠키 불러오기
function getCookie(name) 
{ 
    var obj = name + "="; 
    var x = 0; 
    while ( x <= document.cookie.length ) 
    { 
        var y = (x+obj.length); 
        if ( document.cookie.substring( x, y ) == obj ) 
        { 
            if ((endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
                endOfCookie = document.cookie.length;
            return unescape( document.cookie.substring( y, endOfCookie ) ); 
        } 
        x = document.cookie.indexOf( " ", x ) + 1; 
        if ( x == 0 ) 
            break; 
    } 
    return ""; 
}
	
$(function(){	
	if(getCookie("noToday") !="Y"){
		layerPopupShow();
	}
});


</script>