package kr.apfs.local.contents.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import kr.apfs.local.common.fileupload.model.CommonFileVO;
import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.JsonUtil;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.fileupload.FileUploadModel;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.GreetingpageService;
import kr.apfs.local.file.service.AttachFileService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : GreetingpageController.java
 * @Description : GreetingpageController.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2017.06.26   최초생성
 *
 * @author moonsu
 * @since 2017. 06.26
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Intocps All right reserved.
 */
 
//컨텐츠 인사말 컨트롤러
@Controller
public class GreetingpageController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(GreetingpageController.class);
	
	public final static String  FRONT_PATH = "/front/content/";
	public final static String  BACK_PATH = "/back/contents/";
	
	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;
	
	@Resource(name = "GreetingpageService")
    private GreetingpageService greetingpageService;
	
	@Resource(name = "AttachFileService")
    private AttachFileService fileService;
	
	
	/**
     * 인사말 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/contents/greetingpageWrite.do")
	public String greetingpageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
				
		Map<String, Object> param = _req.getParameterMap();
		//임시지역코드
		String jsp = BACK_PATH + "greetingpageWrite";			
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);		
		Map<String, Object> greetingpageinfo = greetingpageService.selectGreetingpage(param);
		
		if (greetingpageinfo != null && greetingpageinfo.get("contents")!=null){
			greetingpageinfo.put("contents", greetingpageinfo.get("contents").toString().replaceAll("\'", "\\&#39;"));
			
			}
		
		model.addAttribute("greetingpageinfo",greetingpageinfo);		
		
        return jsp;	
	}		
	
	/**
     * 데이터를 저장,수정한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	
    @RequestMapping(value = "/back/contents/greetingpageUpdate.do")
	public ModelAndView updateGreetingPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
    	
    	int rv =0;    	
		//NavigatorInfo navigator = new NavigatorInfo(_req);	
        //Map<String, Object> param  = navigator.getParam();
        Map<String, Object> param = _req.getParameterMap();
        
        try{
        
        	
        	List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("/greeting/"));
    		FileUploadModel file = null;
    		
    		//단건처리용 파라메터 맵 생성   fileVo 제거 중
    		Map<String, Object> fileParam = new HashMap<String, Object>();
    		
    		if(fileList != null && fileList.size()>0){
    		   file = (FileUploadModel)fileList.get(0);
    		   fileParam.put("attachId", CommonUtil.createUUID());    		   
    		   fileParam.put("fileNm", file.getFileName());
    		   fileParam.put("originFileNm", file.getOriginalFileName());
    		   fileParam.put("fileType", file.getExtension());
    		   fileParam.put("fileSize", file.getFileSize());
    		   fileParam.put("filePath", "/greeting/");
    		   fileParam.put("*userId", param.get("*userId"));
   	   	       commonFileService.insertCommonFile(fileParam);
               param.put("attachId",fileParam.get("attachId"));
    		}    		
    		
            rv = greetingpageService.insertGreetingpage(param);
       	
	       	
	       	if(rv > 0){																	// 저장한다
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
    


		
		  @RequestMapping(value = "/back/file/updateFileTest.do")
		    public ModelAndView updateFile(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		    	Map<String, Object> param = _req.getParameterMap();

		    	int rv =0;
		        Map<String,Object> inFileMap =JsonUtil.jacksonToObj((String) param.get("inFile"));
		        Map<String,Object> delFileMap =JsonUtil.jacksonToObj((String) param.get("delFile"));
		        String[] delFileArray = (delFileMap.get("fileId").toString().replace("\"", "")).split(",");
		        param.put("delFileArray", delFileArray);

		        try{

		        	for (Entry<String, Object> entry : inFileMap.entrySet()) {
		        		//System.out.println("Key : " + entry.getKey() + " Value : " + entry.getValue());
		        		inFileMap.put(entry.getKey(), entry.getValue().toString().replaceAll("\"", "").replace("[", "").replace("]", ""));
		        	}

		        	rv = fileService.updateFile(param);
					param.put("rv", rv );
					param.put("success", rv > 0 ? "true" : "false" );

				}catch (IOException e) {
		        	logger.error("IOException error===", e);
		        	param.put("success", "false"); // 실패여부 삽입
		 			return ViewHelper.getJsonView(param);

		        } catch (NullPointerException e) {
		        	logger.error("NullPointerException error===", e);
		        	param.put("success", "false"); // 실패여부 삽입
		 			return ViewHelper.getJsonView(param);

		        }catch(Exception e){
					//e.printStackTrace();
					logger.error("error===", e);
		 			param.put("success", "false"); // 실패여부 삽입

		 			return ViewHelper.getJsonView(param);
		 		}

		        return ViewHelper.getJsonView(param);
		    }
	

    

    
}
