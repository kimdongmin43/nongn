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
import kr.apfs.local.contents.service.StatutepageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : StatutepageController.java
 * @Description : StatutepageController.Class
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
public class StatutepageController extends ComAbstractController {
	
	private static final Logger logger = LogManager.getLogger(StatutepageController.class);
	
	public final static String  FRONT_PATH = "/front/content/";
	public final static String  BACK_PATH = "/back/contents/";	
	
	
	//법령 갯수
	public final static int STATUTE_ROWS = 3;

	
	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;
	
	@Resource(name = "StatutepageService")
    private StatutepageService statutepageService;
	
	
	/**
     *법령저장페이지 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	
	@RequestMapping(value = "/back/contents/statutepageWrite.do")
	public String statutepageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
				
		Map<String, Object> param = _req.getParameterMap();
		//
		
		String jsp = BACK_PATH + "statutepageWrite";			
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		Map<String, Object>statutePageInfo = statutepageService.selectStatutepage(param);
		if (statutePageInfo != null) {
			statutePageInfo.put("contents1", statutePageInfo.get("contents1").toString().replaceAll("\'", "\\&#39;"));
			statutePageInfo.put("contents2", statutePageInfo.get("contents2").toString().replaceAll("\'", "\\&#39;"));
			statutePageInfo.put("contents3", statutePageInfo.get("contents3").toString().replaceAll("\'", "\\&#39;"));
		}
		
		model.addAttribute("statutePageInfo",statutePageInfo);
		
		

				
		
        return jsp;	
	}		
	
	
	
	/**
     * 안내 데이터 저장 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */	
	@RequestMapping(value = "/back/contents/statutepageUpdate.do")
	public ModelAndView statutepageUpdate(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		int rv = 0;
		int cnt=0;
		Map<String, Object> param = _req.getParameterMap();
		
		cnt = statutepageService.selectStatutepageExist(param);
		
		
		if (cnt<=0) {
			
			
			
			try {
					rv = statutepageService.insertStatutepage(param);
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
		
				rv = statutepageService.updateStatutepage(param);
	
				
				if(rv > 0){																	// 저장한다
					param.put("success", "true" );													
		        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
				}else{
					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
					param.put("message", MessageUtil.getUpdatedMsg(rv, _req)); // 실패 메시지		
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
