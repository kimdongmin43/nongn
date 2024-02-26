package kr.apfs.local.contents.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.common.fileupload.model.CommonFileVO;
import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.util.fileupload.FileUploadModel;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.OrgchartpageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : OrgchartpageController.java
 * @Description : OrgchartpageController.Class
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
public class OrgchartpageController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(OrgchartpageController.class);
	
	public final static String  FRONT_PATH = "/front/content/";
	public final static String  BACK_PATH = "/back/contents/";


	
	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;
	
	@Resource(name = "OrgchartpageService")
    private OrgchartpageService orgchartpageService;
	
	
	
	/**
     * 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/contents/IndicatorsListPage.do")
	public String intropageListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		String jsp = BACK_PATH + "IndicatorsList";
		Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> indica = orgchartpageService.selectIndicators(param);
        
        model.addAttribute("indica",indica);
		
		
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

        return jsp;
	}

	/**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/IndicatorsPageList.do")
	public ModelAndView intropagePageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(orgchartpageService.selectIndicators(param));
		
        return ViewHelper.getJqGridView(navigator);
	}
	
	
	
    
    
	@RequestMapping(value = "/back/contents/IndicatorsWrite.do")
	public String IndicatorsWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
				
		Map<String, Object> param = _req.getParameterMap();
		String jsp = BACK_PATH + "IndicatorsWrite";	
		
	    Map<String, Object> indica = new HashMap();
		
	       if(!StringUtil.nvl(param.get("mode")).equals("W")){
	        	 // 
	            indica = orgchartpageService.selectIndicatorsback(param);
	        }else{
	        	indica.put("farmId",param.get("farmId"));
	        }

        model.addAttribute("indica",indica);	
        
        
        
		
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
	    @RequestMapping(value = "/back/contents/insertIndicators.do")
	    public ModelAndView insertBanner(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	        int rv = 0;
	        Map<String, Object> param = _req.getParameterMap();

	
		       	rv = orgchartpageService.insertIndicators(param);

		       	if(rv > 0){																	// 저장한다
					param.put("success", "true" );
		        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
				}else{
					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
				}
	       

	        return ViewHelper.getJsonView(param);
	    }

		/**
	     * 데이타를 수정한다
	     * @param _req
	     * @param model
	     * @param validator
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value = "/back/contents/updateIndicators.do")
	    public ModelAndView updateBanner(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	        int rv = 0;
	        Map<String, Object> param = _req.getParameterMap();

	
		       	rv = orgchartpageService.updateIndicators(param);

		       	if(rv > 0){																	// 저장한다
					param.put("success", "true" );
		        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
				}else{
					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
				}
	     
	        return ViewHelper.getJsonView(param);
	    }
	    
	    
	    
	    @RequestMapping(value = "/back/contents/deleteIndicators.do")
	    public ModelAndView deleteIndicators(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	        int rv = 0;
	        Map<String, Object> param = _req.getParameterMap();

	
		       	rv = orgchartpageService.deleteIndicators(param);

		       	if(rv > 0){																	// 저장한다
					param.put("success", "true" );
		        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
				}else{
					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
				}
	     
	        return ViewHelper.getJsonView(param);
	    }
	
    
    
	
	/**
     * 인사말 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     **/
	@RequestMapping(value = "/back/contents/orgchartpageWrite.do")
	public String orgchartpageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
				
		Map<String, Object> param = _req.getParameterMap();
		String jsp = BACK_PATH + "orgchartpageWrite";			
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);		
		Map<String, Object> orgchartPageInfo = orgchartpageService.selectOrgchartpage(param);
		model.addAttribute("orgchartPageInfo",orgchartPageInfo);		
		
        return jsp;	
	}		
	
	/**
     * 데이터를 저장,수정한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	
    @RequestMapping(value = "/back/contents/orgchartpageUpdate.do")
	public ModelAndView updateOrgchartPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
    	
    	int rv =0;    	
        Map<String, Object> param = _req.getParameterMap();
        
        try{
            if (orgchartpageService.selectOrgchartpageExist(param)>0) 
            {            	
            	rv = orgchartpageService.updateOrgchartpage(param);
    		}
            else
            {
            	rv = orgchartpageService.insertOrgchartpage(param);
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
