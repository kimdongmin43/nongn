package kr.apfs.local.logo.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.apfs.local.common.fileupload.model.CommonFileVO;
import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.util.fileupload.FileUploadModel;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.logo.service.LogoService;

/**
 * @Class Name : LogoController.java
 * @Description : LogoController.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2015.05.10           최초생성
 *
 * @author jangcw
 * @since 2015. 05.10
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Intocps All right reserved.
 */
 
@Controller
public class LogoController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(LogoController.class);
	
	public final static String  FRONT_PATH = "/front/logo/";
	public final static String  BACK_PATH = "/back/logo/";
	
	@Resource(name = "LogoService")
    private LogoService logoService;
	
	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;
	
	/**
     * 쓰기 페이지로 이동한다  
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/logo/logoWrite.do")
	public String logoWrite(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        String jsp = BACK_PATH + "logoWrite";
		
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> logo = new HashMap(); 
        if(!StringUtil.nvl(param.get("mode")).equals("W")){
        	 // logo 정보를 가져온다.
        	logo = logoService.selectLogo(param);	
        }
        
        model.addAttribute("logo",logo);
        
        return jsp;
	}
		
	/**
     * 데이타를 저장한다 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/logo/insertLogo.do")
    public ModelAndView insertLogo(ExtHtttprequestParam _req,	HttpServletRequest request,  ModelMap model) throws Exception {
        
        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
            
        try{
       		List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("logo/"));
    		FileUploadModel file = null;
    		CommonFileVO commonFileVO = new CommonFileVO();
    		String fieldNm = "";
    		if(fileList != null && fileList.size()>0)
    		 for(int i =0; i < fileList.size();i++){
    		   file = (FileUploadModel)fileList.get(i);
    		   commonFileVO.setGroup_id(CommonUtil.createUUID());
    		   commonFileVO.setFile_nm(file.getFileName());
    		   commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
    		   commonFileVO.setFile_type(file.getExtension());
    		   commonFileVO.setFile_size(file.getFileSize());
    		   commonFileVO.setFile_path("logo/");
    		   commonFileVO.setS_user_no((String)param.get("s_user_no"));
   	   	       //commonFileService.insertCommonFile(commonFileVO);
   	   	       fieldNm = file.getFieldName();
   	   	       if(fieldNm.equals("uploadFile1")) {
   	   	    	   param.put("front_top",commonFileVO.getFile_id());
   	   	    	   param.put("front_top_file_nm",commonFileVO.getFile_nm());
   	   	       }
   	   	       else if(fieldNm.equals("uploadFile2")){
   	   	    	   param.put("front_bottom",commonFileVO.getFile_id());
   	   	    	   param.put("front_bottom_file_nm",commonFileVO.getFile_nm());
   	   	       }
   	   	       else if(fieldNm.equals("uploadFile3")){
   	   	    	   param.put("back_top",commonFileVO.getFile_id());
   	   	    	   param.put("back_top_file_nm",commonFileVO.getFile_nm());
   	   	       }
   	   	       else if(fieldNm.equals("uploadFile4")){
   	   	    	   param.put("backsub_top",commonFileVO.getFile_id());
   	   	    	   param.put("backsub_top_file_nm",commonFileVO.getFile_nm());
   	   	       }
    		}
	       	rv = logoService.insertLogo(param);
	       	
	       	if(rv > 0){																	// 저장한다
	       		HttpSession session = request.getSession();
    			session.setAttribute("Logo", param);
				param.put("success", "true" );													
	        	param.put("message", MessageUtil.getInsertMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
        }catch(Exception e){
			//e.printStackTrace();
			logger.error("error===", e);
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}					
        									
        return ViewHelper.getJsonView(param);
       
    }

}
