package kr.apfs.local.contents.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.LocationpageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : LocationpageController.java
 * @Description : LocationpageController.Class
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
public class LocationpageController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(LocationpageController.class);
	
	public final static String  FRONT_PATH = "/front/content/";
	public final static String  BACK_PATH = "/back/contents/";
	//임시 지역 세션값

	
	@Resource(name = "LocationpageService")
    private LocationpageService locationpageService;
	
	
	/**
     * 리스트 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/contents/locationpageListPage.do")
	public String locationpageListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
		
		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();
		
		String jsp = BACK_PATH + "locationpageListPage";			
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

		//해당 지역코드를 가지고 데이터의 로우를 가져온다
		rv = locationpageService.selectLocationpageExist(param);
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
    @RequestMapping(value = "/back/contents/locationpagePageList.do")
	public ModelAndView locationpagePageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
		NavigatorInfo navigator = new NavigatorInfo(_req);	
        Map<String, Object> param  = navigator.getParam();
        
        //System.out.println("파라메터" + param);
		navigator.setList(locationpageService.selectLocationpagePageList(param));     
		
        return ViewHelper.getJqGridView(navigator);
	}
		
	/**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */													  
/*    @RequestMapping(value = "/back/contents/locationpageList.do")
	public @ResponseBody Map<String, Object> locationpageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        String jsp = BACK_PATH + "locationpageListPage";
        
        Map<String, Object> param = _req.getParameterMap();
        param.put("*siteId", S_SITE_ID);
		List<Map<String, Object>> list = locationpageService.selectLocationpageList(param);		
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
    @RequestMapping(value = "/back/contents/locationpageWrite.do")
	public String locationpageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
         
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);
    	
        String jsp = BACK_PATH + "locationpageWrite";    									  
		
        Map<String, Object> param = _req.getParameterMap();        
        
        
        
        Map<String, Object> locationPageInfo = new HashMap();       
        //System.out.println("gubun = " + param.get("gubun"));        
        locationPageInfo.put("gubun", param.get("gubun"));
        model.addAttribute("locationPageInfo",locationPageInfo);
        
        return jsp;
	}
    
    @RequestMapping(value = "/back/contents/locationpageEdit.do")
 	public String locationpageEdit(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
          
     	model.addAttribute(ListOp.LIST_OP_NAME, listOp);
     	
         String jsp = BACK_PATH + "locationpageWrite";    									  
 		
         Map<String, Object> param = _req.getParameterMap();        
         
         
         
         Map<String, Object> locationPageInfo = new HashMap();
         //System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
         //System.out.println(locationpageService.selectLocationpage(param));
         //System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
         locationPageInfo = locationpageService.selectLocationpage(param)!=null?locationpageService.selectLocationpage(param):new HashMap<String, Object>();
         //System.out.println("gubun = " + param.get("gubun"));        
         locationPageInfo.put("gubun", param.get("gubun"));         
         model.addAttribute("locationPageInfo",locationPageInfo);
         
         
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
    @RequestMapping(value = "/back/contents/insertLocationpage.do")
    public ModelAndView insertLocationpage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
        
        
        try{
        	param.put("page_id", CommonUtil.createUUID());
	       	rv = locationpageService.insertLocationpage(param);
	       	
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
    @RequestMapping(value = "/back/contents/updateLocationpage.do")
    public ModelAndView updateLocationpage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        
       	try{
       		if (param.get("locId")==null) {
				rv = locationpageService.insertLocationpage(param);
			  	if(rv > 0){																	// 저장한다
					param.put("success", "true" );													
		        	param.put("message", MessageUtil.getInsertMsg(rv, _req));
				}else{
					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
				}					
				
			}
       		else
       		{
       			rv = locationpageService.updateLocationpage(param);
       			if(rv > 0){																	// 저장한다
					param.put("success", "true" );													
		        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
				}else{
					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
				}		
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
    @RequestMapping(value = "/back/contents/deleteLocationpage.do")
    public ModelAndView deleteLocationpage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        
       	try{
       		rv = locationpageService.deleteLocationpage(param);
       		
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
     * 미리보기 페이지로 이동한다  
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/locationpagePreview.do")
	public String locationpagePreview(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        String jsp = "/popup"+BACK_PATH + "locationpagePreview";
		
        Map<String, Object> param = _req.getParameterMap();
        
        
        model.addAttribute("locationpage",param);
        
        return jsp;
	}
    
	/**
     * 소개페이지 팝업 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/contents/locationpageSearchPopup.do")
	public String locationpageSearchPopup(ExtHtttprequestParam _req, ModelMap model) throws Exception {
		
		String jsp = "/sub"+BACK_PATH + "locationpageListPopup";
		
        
        return jsp;	
	}
	
	/**
     * 소개페이지 리스트 페이지로딩후 list 데이터를 가지고 온다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/locationpageSearchList.do")
	public @ResponseBody Map<String, Object> locationpageSearchList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
		List<Map<String, Object>> list = locationpageService.selectLocationpageList(param);		
		param.put("rows", list);

		return param;
	}
	
	/**
     * 인트로 보기 페이지로 이동을 한다.  
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    									  
    @RequestMapping(value = "/front/locationpage/locationpageShow.do")
	public String locationpageShow(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        String jsp = "/front/common/locationpageShow";
        
        Map<String, Object> param = _req.getParameterMap();
        
        Map<String, Object> locationPageInfo = locationpageService.selectLocationpage(param);	
        model.addAttribute("locationPageInfo",locationPageInfo);
        
        return jsp;
	}
    
}
