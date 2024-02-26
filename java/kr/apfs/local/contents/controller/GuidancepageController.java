package kr.apfs.local.contents.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.GreetingpageService;
import kr.apfs.local.contents.service.GuidancepageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : GuidancepageController.java
 * @Description : GuidancepageController.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2017.06.26   최초생성
 *
 * @author msu
 * @since 2017. 06.28
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Intocps All right reserved.
 */
 
@Controller
public class GuidancepageController extends ComAbstractController {
	
	private static final Logger logger = LogManager.getLogger(GuidancepageController.class);
	
	public final static String  FRONT_PATH = "/front/content/";
	public final static String  BACK_PATH = "/back/contents/";	
	

	
	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;
	
	@Resource(name = "GuidancepageService")
    private GuidancepageService guidancepageService;
	
	
	/**
     * 안내 저장페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	
	@RequestMapping(value = "/back/contents/guidancepageWrite.do")
	public String guidancepageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
				
		Map<String, Object> param = _req.getParameterMap();
		//임시지역코드

		String jsp = BACK_PATH + "guidancepageWrite";			
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		Map<String, Object>guidancePageInfo = guidancepageService.selectGuidancepage(param);
		model.addAttribute("guidancePageInfo",guidancePageInfo);
		//Map<String, Object> guidancepageinfo = guidancepageService.selectGuidancepage(param);
				
		
        return jsp;	
	}		
	
	
	
	/**
     * 안내 데이터 저장 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */	
	@RequestMapping(value = "/back/contents/guidancepageUpdate.do")
	public ModelAndView guidancepageUpdate(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		int rv = 0;
		int cnt = 0;
		Map<String, Object> param = _req.getParameterMap();
		
		//임시지역코드

		
		cnt = guidancepageService.selectGuidancepageExist(param);
		
		
		if (cnt<=0) {
			try {
				
				rv = guidancepageService.insertGuidancepage(param);			
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
	        } catch (Exception e) {
				//e.printStackTrace();
				logger.error("error===", e);
	 			param.put("success", "false"); 													// 실패여부 삽입
	 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
	 			return ViewHelper.getJsonView(param);
	 		}
			
		}else{
		
		
		try {
			
			rv = guidancepageService.updateGuidancepage(param);			
			if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
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
        } catch (Exception e) {
			//e.printStackTrace();
			logger.error("error===", e);
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}
		}
		
        return ViewHelper.getJsonView(param);
	}		
		
	

}
