package kr.apfs.local.common.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.apfs.local.common.fileupload.model.CommonFileVO;
import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.util.ConfigUtil;
import kr.apfs.local.common.util.DateUtil;
import kr.apfs.local.common.util.PropertyUtil;
import kr.apfs.local.common.util.fileupload.FileSupport;
//import lofa.glabfw.model.LoginVO;//glabLoginVo 변경시 주석제거


public class ComAbstractController {
	
	private static final Log logger = LogFactory.getLog(ComAbstractController.class);
	
	@Autowired
	private CommonFileService commonFileService;	
	
    /**
     * context 정보를 불러온다 
     * @return
     */
	protected final WebApplicationContext getContext() {
		return ContextLoader.getCurrentWebApplicationContext();
	}
	
	/**
	 * 세션정보를 가지고 온다 
	 * @param key
	 * @return
	 */
	public static final Object getSessionAttribute(String key) {
		try {
			
			 ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		     HttpSession session = servletRequestAttribute.getRequest().getSession(true);
		     //HttpSession session = (HttpSession) RequestContextHolder.getRequestAttributes().getAttribute(LOCAL_SESSION, 1);
			return session.getAttribute(key);
		} catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
		return null;
	}
	
	/**
	 * 세션정보를 저장한다 
	 * @param key
	 * @param value
	 */
	public static final void setSessionAttribute(String key, Object value) {
		try {
			ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		    HttpSession session = servletRequestAttribute.getRequest().getSession(true);
			//HttpSession session = (HttpSession) RequestContextHolder.getRequestAttributes().getAttribute(LOCAL_SESSION, 1);
			session.setAttribute(key, value);
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
	}

	/**
	 * 로컬 세션을 제거 한다 
	 */
	public static final void removeLocalSession(String key) {
		try {
			ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		    HttpSession session = servletRequestAttribute.getRequest().getSession(true);
			//RequestContextHolder.getRequestAttributes().removeAttribute(LOCAL_SESSION, 1);
			session.removeAttribute(key);
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
	}
	
	/**
	 *업로드 디렉토리 정보를 가지고 온다   
	 * @return
	 */
	public String getUploadPath(String subDir)  throws Exception {
		String baseUploadPath = (String)ConfigUtil.getProperty("common.upload.basePath");
		if("".equals(subDir)){
			subDir ="etc/";
		}
		FileSupport.checkAndMakeDir(baseUploadPath + subDir);
		return baseUploadPath + subDir;
	}
	
	
	/**
	 *documentRoot 디렉토리 정보를 가지고 온다   
	 * @return
	 */
	public String getDocRootPath(String subDir)  throws Exception {
		//String docRootPath = (String)ConfigUtil.getProperty("system.server.docroot");
		String docRootPath = (String)PropertyUtil.getString("common.docroot.path");;
		
		if("".equals(subDir)){
			subDir ="files/";
		}
		FileSupport.checkAndMakeDir(docRootPath + subDir);
		return docRootPath + subDir;
	}
	
	/**
	 * 처리기 관련 JAR 파일 업로드 위치를 가지고 온다.
	 * 
	 * @return String : 파일 업로드 위치
	 * */
	public String getHandlerFileUploadPath() throws Exception {
		String baseUploadPath = ( String ) ConfigUtil.getProperty( "common.handler.basePath" );
		FileSupport.checkAndMakeDir( baseUploadPath );
		return baseUploadPath;
	}
	
	/**
	 * 
	 * @param subDir
	 * @return
	 */
	public String getTempUploadPath() throws Exception {
		String toDay          = DateUtil.getCurrentYyyymmdd();
		String baseUploadPath = (String)ConfigUtil.getProperty("common.upload.exceldowntemp")+toDay;
		FileSupport.checkAndMakeDir(baseUploadPath);
		return baseUploadPath;
	}
	
	/**
	 * 그룹에 속한 모든 파일정보를 삭제합니다 
	 * @param attachFileId
	 * @throws Exception 
	 */
	public void deleteFileInfo(String groupId) throws Exception{
		try{
		    Map<String, Object> param = new HashMap<String, Object>();	
		    param.put("group_id", groupId);
			List<Map<String, Object>> infolist = commonFileService.getCommonFileList(param);		// group_id만 넘겨줘야함
			String path = "";
			String filename = "";
			for(int i=0;infolist.size()>i;i++){
				Map<String, Object> fileInfo 	=  infolist.get(i);						
				path = fileInfo.get("filePath").toString();
				filename = fileInfo.get("FileNm").toString();					
				FileSupport.deleteFile(path, filename);
			}
			commonFileService.deleteCommonFileAll(param);
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
	}

	/**
	 * 물리적 파일을 삭제해준다 
	 * @param path
	 * @param filename
	 */
	public void deleteFile(String path, String filename){
		try{
				FileSupport.deleteFile(path, filename);
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
	}
}
