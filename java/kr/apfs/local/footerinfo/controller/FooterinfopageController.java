package kr.apfs.local.footerinfo.controller;

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
import kr.apfs.local.footerinfo.service.FooterinfopageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : FooterInfopageController.java
 * @Description : FooterInfopageController.Class
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
public class FooterinfopageController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(FooterinfopageController.class);
	
	public final static String  FRONT_PATH = "/front/footerinfo/";
	public final static String  BACK_PATH = "/back/footerinfo/";
	
	
	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;
	
	@Resource(name = "FooterinfopageService")
    private FooterinfopageService footerinfopageService;
	
	
	
	/**
     * 하단정보 페이지로 이동
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/footerinfo/footerinfopageWrite.do")
	public String footerInfopageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
				
		Map<String, Object> param = _req.getParameterMap();
		//임시지역코드
		
		String jsp = BACK_PATH + "footerinfopageWrite";
											  
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);		
		Map<String, Object> footerInfopage = footerinfopageService.selectFooterinfopage(param);
		model.addAttribute("footerInfopage",footerInfopage);		
		
        return jsp;	
	}		
	
	
    @RequestMapping(value = "/back/footerinfo/footerinfopageUpdate.do")
	public ModelAndView updateGreetingPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
    	    	int rv =0;    	

        Map<String, Object> param = _req.getParameterMap();
        
        
        try{
        	
    		
        	if(footerinfopageService.selectFooterinfopageExist(param)<1){
        		rv = footerinfopageService.insertFooterinfopage(param);        	
    		}
            else
            {
            	rv = footerinfopageService.updateFooterinfopage(param);
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
