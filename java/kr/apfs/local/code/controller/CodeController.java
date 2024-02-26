package kr.apfs.local.code.controller;

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

import kr.apfs.local.code.service.CodeService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.JsonUtil;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;

/**
 * @Class Name : CodeController.java
 * @Description : CodeController.Class
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
public class CodeController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(CodeController.class);
	
	public final static String  FRONT_PATH = "/front/code/";
	public final static String  BACK_PATH = "/back/code/";
	
	@Resource(name = "CodeService")
    private CodeService codeService;
	
	/**
     * 리스트 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/code/codemasterListPage.do")
	public String codemasterListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
		
		String jsp = BACK_PATH + "codemasterListPage";	

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		
		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@");
		//System.out.println(listOp);
		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@");
		
			
        return jsp;	
	}
		
	/**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/code/codemasterPageList.do")
	public ModelAndView codemasterPageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
		NavigatorInfo navigator = new NavigatorInfo(_req);	
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(codeService.selectCodemasterPageList(param));		
       
        return ViewHelper.getJqGridView(navigator);
	}
			
	/**
     * 쓰기 페이지로 이동한다  
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/code/codemasterWrite.do")
	public String codemasterWrite(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        String jsp = "/sub"+BACK_PATH + "codemasterWrite";
        
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> codemaster = new HashMap(); 
        //System.out.println();
        if(!StringUtil.nvl(param.get("mode")).equals("W")){
        	 // 코드 정보를 가져온다.
       	codemaster = codeService.selectCodemaster(param);	
        }else{
        	codemaster.put("useYn","Y");
        }
        model.addAttribute("codemaster",codemaster);
             
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
    @RequestMapping(value = "/back/code/insertCodemaster.do")
    public ModelAndView insertCodemaster(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{
        	// 중복 코드가 있는지를 체크한다.
        	rv = codeService.selectCodemasterExist(param);
        	if(rv < 1){
	           // 등록 처리를 해준다.
		       	rv = codeService.insertCodemaster(param);
		       	
		       	if(rv > 0){																	// 저장한다
					param.put("success", "true" );													
		        	param.put("message", MessageUtil.getInsertMsg(rv, _req));
				}else{
					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
				}
        	}else{
				param.put("success", "false"); 
				param.put("message", "대코드가 이미 존재합니다."); 
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
    @RequestMapping(value = "/back/code/updateCodemaster.do")
    public ModelAndView updateCodemaster(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
       	try{
	       	rv = codeService.updateCodemaster(param);
	       	
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
    @RequestMapping(value = "/back/code/deleteCodemaster.do")
    public ModelAndView deleteCodemaster(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
       	try{
       		rv = codeService.deleteCodemaster(param);
       		
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
     * 리스트 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/code/codeListPage.do")
	public String codeListPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
		
		String jsp = BACK_PATH + "codeListPage";	
        
		Map<String, Object> param = _req.getParameterMap();
	
		Map<String, Object> codemaster = codeService.selectCodemaster(param);	
        model.addAttribute("codemaster",codemaster);
    
        return jsp;	
	}
		
	/**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/code/codeList.do")
	public @ResponseBody Map<String, Object> codeList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
		List<Map<String, Object>> list = codeService.selectCodeList(param);		
		
		param.put("rows", list);

        return param;
	}
	
    
    /**
     *  공통 코드 리스트를 돌려준다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/code/commonCodeList.do")
	public ModelAndView commonCodeList(ExtHtttprequestParam _req, ModelMap model)  throws Exception{
		Map<String, Object> param 		= _req.getParameterMap();
		
		List list = codeService.selectCodeMasterCodeList(StringUtil.nvl(param.get("master")));
		HashMap retMap = new HashMap();
		retMap.put("list",list);	    

	    return ViewHelper.getJsonView(retMap);
	}
    
	/**
     * 쓰기 페이지로 이동한다  
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/code/codeWrite.do")
	public String codeWrite(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        String jsp = "/sub"+BACK_PATH + "codeWrite";
        							
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> code = new HashMap(); 
        if(!StringUtil.nvl(param.get("mode")).equals("W")){
        	 // 코드 정보를 가져온다.
        	code = codeService.selectCode(param);	
        }
        else code.put("useYn","Y"); 

        code.put("mstId", param.get("mstId"));
        code.put("mstNm", param.get("mstNm"));
        model.addAttribute("code",code);
        
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
    @RequestMapping(value = "/back/code/insertCode.do")
    public ModelAndView insertCode(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
            
        try{
        	// 중복 코드가 있는지를 체크한다.
        	rv = codeService.selectCodeExist(param);
        	if(rv < 1){
		       	rv = codeService.insertCode(param);
		       	
		       	if(rv > 0){																	// 저장한다
					param.put("success", "true" );													
		        	param.put("message", MessageUtil.getInsertMsg(rv, _req));
				}else{
					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
				}
        	}else{
        		param.put("success", "false"); 
				param.put("message", "코드가 이미 존재합니다."); 
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
    @RequestMapping(value = "/back/code/updateCode.do")
    public ModelAndView updateCode(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
       	try{
        	// 중복 코드가 있는지를 체크한다.
	       	rv = codeService.updateCode(param);
	       	
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
    @RequestMapping(value = "/back/code/deleteCode.do")
    public ModelAndView deleteCode(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
       	try{
       		rv = codeService.deleteCode(param);
       		
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
	 * 코드 순서를 재조정해준다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/code/updateCodeReorder.do")
	public ModelAndView updateCodeReorder(ExtHtttprequestParam _req, ModelMap model) throws Exception {
	    
	   	int rv = 0;
	    Map<String, Object> param = _req.getParameterMap();
	    
        List<Map<String, Object>> list = (ArrayList<Map<String ,Object>>)JsonUtil.fromJsonStr(param.get("code_list").toString().replace("&quot;","'"));
	    param.put("code_list", list);
	   	try{
	   		rv = codeService.updateCodeReorder(param);
	   		
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
