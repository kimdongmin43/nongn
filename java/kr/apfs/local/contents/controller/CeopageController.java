package kr.apfs.local.contents.controller;

import java.io.IOException;
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
import kr.apfs.local.common.util.fileupload.FileUploadModel;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.CeopageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


/**
 * @Class Name : CeopageController.java
 * @Description : CeopageController.Class
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
public class CeopageController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(CeopageController.class);
	
	public final static String  FRONT_PATH = "/front/content/";
	public final static String  BACK_PATH = "/back/contents/";
	//임시 지역 세션값
	
	
	@Resource(name = "CommonFileService")
	private CommonFileService commonFileService;	
	
	@Resource(name = "CeopageService")
	private CeopageService ceopageService;
	
	
	/**
     * 리스트 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/contents/ceopageListPage.do")
	public String ceopageListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
		
		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();
		
        
	
		
		String jsp = BACK_PATH + "ceopageListPage";			
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

		//해당 지역코드를 가지고 데이터의 로우를 가져온다
		rv = ceopageService.selectCeopageExist(param);
		//rv > 0 지부등록, rv == 0 신규등록 
		model.put("listSize", rv);				
        return jsp;	
	}
		
	/**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/ceopagePageList.do")
	public ModelAndView ceopagePageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
		NavigatorInfo navigator = new NavigatorInfo(_req);	
        Map<String, Object> param  = navigator.getParam();
        
        //System.out.println("파라메터" + param);
		navigator.setList(ceopageService.selectCeopagePageList(param));     
		
        return ViewHelper.getJqGridView(navigator);
	}
		
	/**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */													  
/*    @RequestMapping(value = "/back/contents/ceopageList.do")
	public @ResponseBody Map<String, Object> ceopageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        String jsp = BACK_PATH + "ceopageListPage";
        
        Map<String, Object> param = _req.getParameterMap();
        param.put("*siteId", S_SITE_ID);
		List<Map<String, Object>> list = ceopageService.selectCeopageList(param);		
		param.put("rows", list);

        return param;
	}*/
	
	/**
     * 쓰기 페이지로 이동한다  
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/ceopageWrite.do")
	public String ceopageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
         
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        String jsp = BACK_PATH + "ceopageWrite";    									  
        Map<String, Object> param = _req.getParameterMap();        
        
        
        return jsp;
	}
    /**
     * 수정 페이지로 이동한다  
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/ceopageEdit.do")
	public String ceopageEdit(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
         
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        String jsp = BACK_PATH + "ceopageWrite";    									  
        Map<String, Object> param = _req.getParameterMap();
        
        Map<String, Object> ceoPageInfo = ceopageService.selectCeopage(param);      
        ceoPageInfo.put("gubun", "E");
        model.addAttribute("ceoPageInfo", ceoPageInfo);      
        
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
    @RequestMapping(value = "/back/contents/ceopageInsert.do")
    public ModelAndView insertCeopage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
        
        try{
        	    
        	
        	if (param.get("ceoYn")!=null) {
        		if (param.get("ceoYn").equals("on")) {
	        		param.put("ceoYn", "Y");				
				}
        		
			}else{
         		param.put("ceoYn", "N");
         	}  	
	       	rv = ceopageService.insertCeopage(param);
	       	
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
		
	/**
     * 데이타를 수정한다 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/ceopageUpdate.do")
    public ModelAndView updateCeopage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
    	 int rv =0;
         Map<String, Object> param = _req.getParameterMap();
         
         try{
         	
     
         
         	if (param.get("ceoYn")!=null) {
         		if (param.get("ceoYn").equals("on")) {
 	        		param.put("ceoYn", "Y");				
 				}
 			}
         	else{
         		param.put("ceoYn", "N");
         	}
         	
         	
 	       	rv = ceopageService.updateCeopage(param);
 	       	
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
        }catch(Exception e){
 			//e.printStackTrace();
 			logger.error("error===", e);
  			param.put("success", "false"); 													// 실패여부 삽입
  			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
  			return ViewHelper.getJsonView(param);
  		}					
         									
         return ViewHelper.getJsonView(param);
    }
		
	/**
     * 데이타를 삭제한다 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/ceopageDelete.do")
    public ModelAndView deleteCeopage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
       	try{
       		rv = ceopageService.deleteCeopage(param);
       		
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", MessageUtil.getDeteleMsg(rv, _req));
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
	
	/**
     * 데이타를 삭제한다 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/updateceoReorder.do")
    public ModelAndView updateCeopageSort(ExtHtttprequestParam _req, ModelMap mode) throws Exception {
        
       	int rv = 0;
       	
        Map<String, Object> param = _req.getParameterMap();        
    
        
       	try{
       		rv = ceopageService.updateCeopageSort(param);
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", "코드 순서를 조정하였습니다.");
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



