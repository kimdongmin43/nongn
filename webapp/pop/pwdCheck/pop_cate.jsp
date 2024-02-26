<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=5.0, minimum-scale=1.0, width=device-width" />
<title>농식품모태펀드</title>
<style>
html,body{margin:0;padding:0;font-family:NanumGothic, NG, dotum, gulim, Arial,"sans-serif";font-size:13px;color:#555555;}

img{margin:0;padding:0;border:none;vertical-align:top;}
img.event{cursor:pointer;}

a{color: #555555;text-decoration: none;}
a:hover{text-decoration:none;}

ul, ol {
    list-style: none;
    margin: 0;
    padding: 0;
}

li {
    display: list-item;
    text-align: -webkit-match-parent;
}
.mgr5 {
    margin-right: 5px;
}

.right {
    text-align: right;
}
.popWrap{text-align:left;}

.top{font-family:"NGB";color:#0066be;font-size:14px;background:url(/images/icon/icon_title.gif) left 3px no-repeat;padding:0 0 8px 20px; text-align:left; margin:10px 0 0 5px;}
.top h1{font-size:18px;
    clear: both;
    margin: 0;
    padding: 0;
    font-family: "NGB";
}

.invest_box{border:1px solid #d4d4d4;padding:15px 15px 8px 5px;font-family:dotum;font-size:12px;margin:0 5px 5px 5px;}
.invest_box ul li{background:url(/images/icon/dtitle.gif) left 0px no-repeat;position:relative;padding:2px 0 6px 23px; text-align:left;}
.invest_box ul li.none{background:none;padding:2px 0 6px 15px;}
</style>

<script>
$(document).ready(function() {

});
</script>

<!-- Global Site Tag (gtag.js) - AdWords: 827205478 -->
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-827205478"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'AW-827205478');
</script>

</head>
<body>
<%
	String Category = request.getParameter("Category");
	Category		= Category.replaceAll("!","&");
%>
<div class="popWrap">
	<div class="top"><h1>비공개 게시물 입니다.</h1></div>
	<div class="invest_box">
	<table>
		<tr>
		<td>비밀번호</td>
		<td><input type = "password" name="pwd" />
		</tr>
	
	</table>
		
	</div>
	<!-- 내용끝 -->
	<div class="right mgr5"><a href="javascript:self.close()"><img alt="close" src="/images/icon/btn_close.gif"></a></div>
</div>
</body>
</html>