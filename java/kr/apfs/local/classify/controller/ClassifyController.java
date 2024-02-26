package kr.apfs.local.classify.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.apfs.local.classify.service.ClassifyService;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;

/**
 * @Class Name : ClassifyController.java
 * @Description : ClassifyController.Class
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
public class ClassifyController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(ClassifyController.class);
	
	public final static String  FRONT_PATH = "/front/classify/";
	public final static String  BACK_PATH = "/back/classify/";
	
	@Resource(name = "ClassifyService")
    private ClassifyService classifyService;
	
	
	/**
     * 리스트 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/classify/classifyListPage.do")
	public String classifyListPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
		
		String jsp = BACK_PATH + "classifyListPage";	
        
        return jsp;	
	}

	/**
	 * 목차 트리 리스트  
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/classify/classifyTreeList.do")
	public @ResponseBody List<Map<String, Object>> itemTreeList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
	    
	    Map<String, Object> param = _req.getParameterMap();
	    
		List<Map<String, Object>> list = classifyService.selectClassifyTreeList(param);		

		return list;
	}
	
	/**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/classify/classifyPageList.do")
	public ModelAndView classifyPageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
		NavigatorInfo navigator = new NavigatorInfo(_req);	
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(classifyService.selectClassifyPageList(param));		
        
        return ViewHelper.getJqGridView(navigator);
	}
		
	/**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/classify/classifyList.do")
	public String classifyList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        String jsp = BACK_PATH + "classifyListPage";
        
        Map<String, Object> param = _req.getParameterMap();
        
		List<Map<String, Object>> list = classifyService.selectClassifyList(param);		
		model.addAttribute("itemList", list);

        return jsp;
	}
    
    /**
     *  카테고리 코드 리스트를 돌려준다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/classify/classifyCodeList.do")
	public ModelAndView classifyCodeList(ExtHtttprequestParam _req, ModelMap model)  throws Exception{
		Map<String, Object> param 		= _req.getParameterMap();
		
		List list = classifyService.selectClassifyCodeList(param);
		HashMap retMap = new HashMap();
		retMap.put("list",list);	    

	    return ViewHelper.getJsonView(retMap);
	}
    
	/**
     *  카테고리 코드 리스트를 돌려준다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/front/classify/classifyCodeList.do")
	public ModelAndView frontClassifyCodeList(ExtHtttprequestParam _req, ModelMap model)  throws Exception{
		Map<String, Object> param 		= _req.getParameterMap();
		
		List list = classifyService.selectClassifyCodeList(param);
		HashMap retMap = new HashMap();
		retMap.put("list",list);	    

	    return ViewHelper.getJsonView(retMap);
	}
	
    /**
     *  카테고리 메뉴 리스트를 돌려준다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/classify/classifyMenuList.do")
	public ModelAndView classifyMenuList(ExtHtttprequestParam _req, ModelMap model)  throws Exception{
		Map<String, Object> param 		= _req.getParameterMap();
		
		List list = classifyService.selectClassifyList(param);
		ArrayList menuList = new ArrayList();
		ArrayList subList = null;
		Map classify = null, upclassify = null;
		int upclassifyId = 0;
		if(list != null && list.size() > 0)
			for(int i =0; i < list.size();i++){
				classify = (Map)list.get(i);
				upclassifyId = StringUtil.nvl(classify.get("up_classify_id"),0);
				 if(upclassifyId == 0){
					  menuList.add(classify);
				 }else{
					 upclassify = getUpClassify(menuList, upclassifyId);
					 subList = (ArrayList)upclassify.get("classifyList");
					 if(subList != null){
						 subList.add(classify);
					 }else{
						 subList = new ArrayList();
						 subList.add(classify);
						 upclassify.put("classifyList", subList);
					 }
				 }
			}
		
		HashMap retMap = new HashMap();
		retMap.put("list",menuList);	    

	    return ViewHelper.getJsonView(retMap);
	}
	
	private Map getUpClassify(List list, int upclassify){
		Map classify = null;
		int classifyId = 0;
		for(int i =0; i < list.size();i++){
			classify = (Map)list.get(i);
			classifyId = StringUtil.nvl(classify.get("classify_id"),0);
			 if(classifyId == upclassify){
				 return classify;
			 }
		}
		
		return classify;
	}
	
	/**
     * 쓰기 페이지로 이동한다  
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/classify/classifyWrite.do")
	public String classifyWrite(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        String jsp = "/sub"+BACK_PATH + "classifyWrite";
        												
		Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> classify = new HashMap();
		if(!StringUtil.nvl(param.get("mode"),"W").equals("W")){
			classify = classifyService.selectClassify(param);
		}else{
			Map<String, Object> param2 = new HashMap();
			param2.put("gubun", param.get("gubun"));
			classify.put("icon_type", "fa-laptop");
			// 상위 카테고리명을 가져온다.
			classify.put("up_classify_id", param.get("up_classify_id"));
			if(StringUtil.nvl(param.get("up_classify_id"),"0").equals("0")){
				classify.put("up_classify_nm", "카테고리");
			}else{
				param2.put("classify_id", param.get("up_classify_id"));
				param2 = classifyService.selectClassify(param2);
				if(param2 != null)
					classify.put("up_classify_nm", param2.get("classify_nm"));
				else 
					classify.put("up_classify_nm", "카테고리");
			}
		}
		model.addAttribute("classify", classify);
		
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
    @RequestMapping(value = "/back/classify/insertClassify.do")
    public ModelAndView insertClassify(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
            
        try{
	       	rv = classifyService.insertClassify(param);
	       	
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
     * 선택된 항목의 detail 값을 가지고 온다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/classify/Classify.do")
	public String getClassify(ExtHtttprequestParam _req, ModelMap model) throws Exception {
		
		String jsp = BACK_PATH + "classifyEdit";		
		
		Map<String, Object> param = _req.getParameterMap();
		
        model.addAttribute("item", classifyService.selectClassify(param));
        										
        return jsp;
	}
		
	/**
     * 데이타를 수정한다 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/classify/updateClassify.do")
    public ModelAndView updateClassify(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
       	try{
	       	rv = classifyService.updateClassify(param);
	       	
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
    @RequestMapping(value = "/back/classify/deleteClassify.do")
    public ModelAndView deleteClassify(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
       	try{
       		rv = classifyService.deleteClassify(param);
       		
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
     * 카테고리의 순서를 조정해준다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/classify/updateClassifyReorder.do")
    public ModelAndView updateItemReorder(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
       	try{
	       	rv = classifyService.updateClassifyReorder(param);
	       	
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", "카테고리 순서를 조정하였습니다.");
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
