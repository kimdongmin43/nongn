<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@page import="kr.apfs.local.common.util.StringUtil"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="ko" xml:lang="ko">
<!--<![endif]-->
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="/assets/jquery/jquery-1.9.1.min.js"></script>
    <script src="/assets/parsley/dist/parsley.js"></script>
    <script src="/assets/jquery-ui/ui/minified/jquery-ui.min.js"></script>
	<script src="/assets/jquery/jquery.form.js"></script>
    <script src="/assets/jqgrid/i18n/grid.locale-kr.js"></script>
	<script src="/assets/jqgrid/jquery.jqGrid.js"></script>
	<script src="/assets/jqgrid/jquery.jqGrid.ext.js"></script>
	<script src="/assets/jqgrid/jquery.loadJSON.js"></script>
	<script src="/assets/jqgrid/jquery.tablednd.js"></script>
	<script src="/js/common.js"></script>

   <link rel="stylesheet" type="text/css" href="/assets/font-awesome/css/font-awesome.min.css"/>
   <link rel="stylesheet" type="text/css" href="/assets/bootstrap/css/sticky-footer.css" />
   <link rel="stylesheet" type="text/css" href="/assets/jqgrid/css/ui.jqgrid.css" />
   <link rel="stylesheet" type="text/css" href="/assets/jqgrid/css/ui.jqgrid-bootstarp.css" />
   <link rel="stylesheet" type="text/css" href="/assets/jquery-ui/themes/base/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="/css/back/default.css" />
	<link rel="stylesheet" type="text/css" href="/css/back/common.css" />
	<link rel="stylesheet" type="text/css" href="/css/back/table.css" />
	<link rel="stylesheet" type="text/css" href="/css/back/popup.css" />

</head>
  <body>
	<tiles:insertAttribute name="body"/>
  </body>
</html>