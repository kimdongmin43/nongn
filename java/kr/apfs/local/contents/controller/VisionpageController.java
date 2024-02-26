package kr.apfs.local.contents.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.common.fileupload.model.CommonFileVO;
import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.fileupload.FileUploadModel;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.VisionpageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : VisionpageController.java
 * @Description : VisionpageController.Class
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
public class VisionpageController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(VisionpageController.class);
	
	public final static String  FRONT_PATH = "/front/content/";
	public final static String  BACK_PATH = "/back/contents/";
	//임시 지역 세션값
	
	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;
	
	@Resource(name = "VisionpageService")
    private VisionpageService visionpageService;
	
	
	/**
     * 인사말 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/contents/visionpageWrite.do")
	public String visionpageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
				
		Map<String, Object> param = _req.getParameterMap();
		//임시지역코드
		String jsp = BACK_PATH + "visionpageWrite";			
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);		
		Map<String, Object> visionpageinfo = visionpageService.selectVisionpage(param);
		if (visionpageinfo!=null){
			visionpageinfo.put("contents", visionpageinfo.get("contents").toString().replaceAll("\'", "\\&#39;"));
			}
		model.addAttribute("visionpageinfo",visionpageinfo);		
		
        return jsp;	
	}		
	
	/**
     * 데이터를 저장,수정한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	
    @RequestMapping(value = "/back/contents/visionpageUpdate.do")
	public ModelAndView updateVisionPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
    	
    	int rv =0;    	
		//NavigatorInfo navigator = new NavigatorInfo(_req);	
        //Map<String, Object> param  = navigator.getParam();
        Map<String, Object> param = _req.getParameterMap();
        
        try{
        	//System.out.println("중복체크"+visionpageService.selectVisionpageExist(param));
            if (visionpageService.selectVisionpageExist(param)>0) 
            {        	
               	rv = visionpageService.updateVisionpage(param);
    			
    		}
            else
            {
            	rv = visionpageService.insertVisionpage(param);
            }
       	
	       	
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
    
    


	

    

    
}
