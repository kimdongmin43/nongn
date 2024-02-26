package kr.apfs.local.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView { 

	private static final Logger log = LogManager.getLogger(DownloadView.class);
	
    public void Download() {                   
    	setContentType("application/x-download; utf-8");            		//	2021.07.02 download -> x-download -> 변경해 보았으나 영향 없음
    }

	@Override
	public void renderMergedOutputModel(Map<String, Object> model,	HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
//System.out.println("여기오는거니?");
	 
		HashMap map = (HashMap) model.get("map");
		String org_file_name = (String) map.get("org_file_name");
		File file = (File) map.get("downloadFile");
		
    			
    	log.info("DownloadView --> file.getPath() : " + file.getPath());         
    	log.info("DownloadView --> file.getName() : " + file.getName());   
    	log.info("DownloadView --> org_file_name : " + org_file_name);   
    	
    	response.setContentType(getContentType());         
    	response.setContentLength((int)file.length());                   
    	String userAgent = request.getHeader("User-Agent");                   
    	boolean ie = userAgent.indexOf("Trident") > -1;  
    	
    
    	///String fileName = null; 
    	String browser = request.getHeader("User-Agent");
        if(ie){                    
    	//if(browser.contains("MSIE")) {
        	org_file_name = URLEncoder.encode(org_file_name, "UTF-8").replaceAll("\\+", "%20"); 
        	log.info("---------------> IE");   
        	
    	} else {                           
    		org_file_name = new String(org_file_name.getBytes("UTF-8"), "ISO-8859-1");
    		log.info("----------------> CROME");   
        	
    	}
     
    	//org_file_name = new String(org_file_name.getBytes("UTF-8"), "ISO-8859-1");
    	log.info("DownloadView --> org_file_name : " + org_file_name);   
    	
        response.setHeader("Content-Disposition", "attachment; filename=\"" + org_file_name + "\";");  
        response.setHeader("Content-Transfer-Encoding", "binary");             
        OutputStream out = response.getOutputStream();                 
        FileInputStream fis = null; 
        
        try {                     
        	fis = new FileInputStream(file);  
        	FileCopyUtils.copy(fis, out);            
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }finally{                        
        	if(fis != null){                           
        		try{               
        			fis.close();             
        		}catch (IOException e) {
                	logger.error("IOException error===", e);
                } catch (NullPointerException e) {
                	logger.error("NullPointerException error===", e);
                }         
        	}                     
        } 
	} 
}

