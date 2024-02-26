<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder, java.net.URLEncoder" %>
<%@ page import="kr.apfs.local.common.util.StringUtil" %>
<%
	
    try {

        String docName  = "";
        String data = request.getParameter("csvBuffer");
        
        /* 추가/수정 코드(2018.06.20) - (주)아사달 대리 함민석 */
        if(data == null) {
        	data = ""; 
        } else {
        	data = data.replaceAll("eval\\((.*)\\)", "");
        	data = data.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
			data = data.replaceAll("script", "");
			data = data.replaceAll("alert", "");
			
			data = data.replaceAll("& lt;", "<").replaceAll("& gt;", ">");
	        
	        // 특수 문자 제거
	        data = data.replaceAll("&amp;", "&").replaceAll("&lt;", "<");
	        data = data.replaceAll("&gt;", ">");
	        
	        
	        data = data.replaceAll("& #40;", "\\(").replaceAll("&#41;", "\\)");
	        data = data.replaceAll("%00", null);
	        data = data.replaceAll("&#34;", "\"");
	        data = data.replaceAll("&#39;", "\'");
	        data = data.replaceAll("&#37;", "%");
	        
	        data = data.replaceAll("&l", "<");
	        
	        // 허용할 HTML tag만 변경
	        data = data.replaceAll("&lt;p&gt;", "<p>");
	        data = data.replaceAll("&lt;P&gt;", "<P>");
	        data = data.replaceAll("&lt;br&gt;", "<br>");
	        data = data.replaceAll("&lt;BR&gt;", "<BR>");
        }
        
        String fileName = request.getParameter("fileName");

        //헤더 선택
        String header2 = request.getHeader("User-Agent");
        String header = header2.replaceAll("\n","").replaceAll("\r", "");
        if (header.contains("MSIE"))       { header = "MSIE";   }
        else if(header.contains("Chrome")) { header = "Chrome"; }
        else if(header.contains("Opera"))  { header  = "Opera"; }

        if (data != null && fileName != null ) {
             data = URLDecoder.decode(data, "UTF-8");
             fileName = URLDecoder.decode(fileName, "UTF-8");
             response.setContentType("application/vnd.ms-excel");
             //response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
             
             String docName2 = fileName;
             docName2 = docName2.replaceAll("\\.","").replaceAll("/","").replaceAll("\\\\","");
             if (header.contains("MSIE")) {
                  docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
                  docName.replaceAll("(\r\n|\r|\n|\n\r)", "");
                  response.setHeader("Content-Disposition", "attachment;filename=" + docName2 + ".xls;");
             } else if (header.contains("Firefox")) {
                  docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
                  docName.replaceAll("(\r\n|\r|\n|\n\r)", "");
                  response.setHeader("Content-Disposition", "attachment; filename=\"" + docName2 + ".xls\"");
             } else if (header.contains("Opera")) {
                  docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
                  docName.replaceAll("(\r\n|\r|\n|\n\r)", "");
                  response.setHeader("Content-Disposition", "attachment; filename=\"" + docName2 + ".xls\"");
             } else if (header.contains("Chrome")) {
                  docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
                  docName.replaceAll("(\r\n|\r|\n|\n\r)", "");
                  response.setHeader("Content-Disposition", "attachment; filename=\"" + docName2 + ".xls\"");
             }else{
            	 response.setHeader("Content-Disposition", "attachment;filename=" + docName2 + ".xls;");
             }
             response.setHeader("Content-Description", "JSP Generated Data");
             response.setHeader("Pragma", "no-cache;");
             response.setHeader("Expires", "-1;");

             out.println(data);
        }
    }catch (NullPointerException e) {
    	out.println("엑셀다운로드 에러!");
    } catch ( Exception e ) {
         //e.printStackTrace();
         out.println("엑셀다운로드 에러!");
    }
%>
