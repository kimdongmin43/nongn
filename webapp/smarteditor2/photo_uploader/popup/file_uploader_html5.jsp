<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.*"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.UUID"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="kr.apfs.local.common.util.ConfigUtil"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="org.apache.commons.logging.Log" %>
<%@page import="org.apache.commons.logging.LogFactory" %>
<%@ page import="java.io.IOException" %>



<%
	
	//파일정보
	String sFileInfo = "";
	//파일명을 받는다 - 일반 원본파일명
	String filename = request.getHeader("file-name");
	//파일 확장자
	String filename_ext = filename.substring(filename.lastIndexOf(".")+1);
	//확장자를소문자로 변경
	filename_ext = filename_ext.toLowerCase();

	//이미지 검증 배열변수
	String[] allow_file = {"jpg","png","bmp","gif"};

	//돌리면서 확장자가 이미지인지
	int cnt = 0;
	for(int i=0; i<allow_file.length; i++) {
		if(filename_ext.equals(allow_file[i])){
			cnt++;
		}
	}

	//이미지가 아님
	if(cnt == 0) {
		out.println("NOTALLOW_"+filename);
	} else {
	//이미지이므로 신규 파일로 디렉토리 설정 및 업로드
	//파일 기본경로
	String dftFilePath = (String)ConfigUtil.getProperty("common.upload.basePath");



	//추후 수정 필요
	String url = this.getClass().getResource("").getPath();
    url = url.substring(1,url.indexOf(".metadata"))+"apfs/src/main/webapp/upload/";
	//추후 수정 필요



	//파일 기본경로 _ 상세경로
	String filePath = url + "commoneditor" + File.separator;



	File file = new File(filePath);
	if(!file.exists()) {
		file.mkdirs();
	}
	String realFileNm = "";
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	String today= formatter.format(new java.util.Date());
	realFileNm = today+UUID.randomUUID().toString() + filename.substring(filename.lastIndexOf("."));
	String rlFileNm = filePath + realFileNm;


	///////////////// 서버에 파일쓰기 /////////////////
	
	InputStream is = null;
	OutputStream os= null;
	try{
		is = request.getInputStream();
		os=new FileOutputStream(rlFileNm);
		int numRead;
		byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
		while((numRead = is.read(b,0,b.length)) != -1){
			os.write(b,0,numRead);
		}
	}
	catch(IOException e){
		//System.out.println("IOException error : " + e);
		System.out.println("IOException error");
	}
	finally{
		if(is != null) {
			try{
				is.close();
			}catch(IOException e){
				//System.out.println("IOException error : " + e);
				System.out.println("IOException error");
			}
		}
		if(os != null) {
			try{
				os.flush();
				os.close();
			}catch(IOException e){
				//System.out.println("IOException error : " + e);
				System.out.println("IOException error");
			}
		}
	}
	
// 	InputStream is = request.getInputStream();
// 	OutputStream os=new FileOutputStream(rlFileNm);
// 	int numRead;
// 	byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
// 	while((numRead = is.read(b,0,b.length)) != -1){
// 		os.write(b,0,numRead);
// 	}
// 	if(is != null) {
// 		is.close();
// 	}
// 	os.flush();
// 	os.close();
	///////////////// 서버에 파일쓰기 /////////////////



	//정보 출력
	sFileInfo += "&bNewLine=true";
	//sFileInfo += "&sFileName="+ realFileNm;
	//img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
	sFileInfo += "&sFileName="+ filename;
	sFileInfo += "&sFileURL="+"/upload/commoneditor/"+realFileNm;

	System.out.println(sFileInfo);


	out.println(sFileInfo);
	}
%>