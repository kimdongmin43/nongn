package kr.apfs.local.auth.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.apfs.local.board.controller.BoardFrontController;
import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.JsonUtil;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.auth.service.AuthService;

/**
 * @Class Name : AuthController.java
 * @Description : AuthController.Class
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
public class AuthController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(AuthController.class);
	
	public final static String  FRONT_PATH = "/front/auth/";
	public final static String  BACK_PATH = "/back/auth/";
	
	@Resource(name = "AuthService")
    private AuthService authService;
	
	
	/**
     * 리스트 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/auth/authListPage.do")
	public String authListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
		
		String jsp = BACK_PATH + "authListPage";	
		
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        
        return jsp;	
	}
		
	/**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/auth/authPageList.do")
	public ModelAndView authPageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
    	NavigatorInfo navigator = new NavigatorInfo(_req);	
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(authService.selectAuthPageList(param));		
        
        return ViewHelper.getJqGridView(navigator);
	}
	
	/**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/auth/authList.do")
	public @ResponseBody Map<String, Object> authList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();
        
		List<Map<String, Object>> list = authService.selectAuthList(param);		
		param.put("rows", list);

		return param;
	}
	
    
	/**
     * 쓰기 페이지로 이동한다  
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/auth/authWrite.do")
	public String authWrite(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        String jsp = "/sub"+BACK_PATH + "authWrite";
        										
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> auth = new HashMap(); 
        if(!StringUtil.nvl(param.get("mode")).equals("W")){
        	 // 권한 정보를 가져온다.
        	auth = authService.selectAuth(param);	
        }
        
        auth.put("use_yn","Y");

        model.addAttribute("auth",auth);
        
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
    @RequestMapping(value = "/back/auth/insertAuth.do")
    public ModelAndView insertAuth(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
  
        try{
        	param.put("auth_id", CommonUtil.createUUID());
	       	rv = authService.insertAuth(param);
	       	
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", MessageUtil.getInsertMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
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
    @RequestMapping(value = "/back/auth/Auth.do")
	public String getAuth(ExtHtttprequestParam _req, ModelMap model) throws Exception {
		
		String jsp = BACK_PATH + "authEdit";		
		
		Map<String, Object> param = _req.getParameterMap();
		
        model.addAttribute("item", authService.selectAuth(param));
        										
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
    @RequestMapping(value = "/back/auth/updateAuth.do")
    public ModelAndView updateAuth(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
     
       	try{
	       	rv = authService.updateAuth(param);
	       	
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}					
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
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
    @RequestMapping(value = "/back/auth/deleteAuth.do")
    public ModelAndView deleteAuth(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
            
       	try{
       		rv = authService.deleteAuth(param);
       		
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", MessageUtil.getDeteleMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}					
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
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
     * 권한 메뉴 리스트 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/auth/authMenuListPage.do")
	public String authMenuListPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
		
		String jsp = BACK_PATH + "authMenuListPage";	
        
        return jsp;	
	}
    
	/**
     * 메니저 권한 사용자 리스트 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/auth/managerAuthListPage.do")
	public String managerAuthListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
		
		String jsp = BACK_PATH + "managerAuthListPage";	
        
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
	@RequestMapping(value = "/back/auth/managerAuthPageList.do")
	public ModelAndView managerAuthPageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
	    
		NavigatorInfo navigator = new NavigatorInfo(_req);	
	    Map<String, Object> param  = navigator.getParam();
		navigator.setList(authService.managerAuthPageList(param));		
	    
	    return ViewHelper.getJqGridView(navigator);
	}
		
	/**
	 * 관리자 권한 매핑을 해준다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/auth/insertManagerAuth.do")
	public ModelAndView insertManagerAuth(ExtHtttprequestParam _req, ModelMap model) throws Exception {
	    
	   	int rv = 0;
	    Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = (ArrayList<Map<String ,Object>>)JsonUtil.fromJsonStr(param.get("user_list").toString().replace("&quot;","'"));
	    param.put("user_list", list);    
	   	try{
	   		rv = authService.insertManagerAuth(param);
	   		
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", "권한 매핑에 성공하였습니다.");
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", "권한 매핑에 실패하였습니다."); // 실패 메시지
			}					
	    }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }catch(Exception e){
	    	//e.printStackTrace();
	    	logger.error("error===", e);
				param.put("success", "false"); 													// 실패여부 삽입
				param.put("message", "권한 매핑에 실패하였습니다."); 				// 실패 메시지
				return ViewHelper.getJsonView(param);
			}						
	    									
	    return ViewHelper.getJsonView(param);
	}
		
	/**
	 * 관리자 권한 매핑을 삭제한다 
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/auth/deleteManagerAuth.do")
	public ModelAndView deleteManagerAuth(ExtHtttprequestParam _req, ModelMap model) throws Exception {
	    
	   	int rv = 0;
	    Map<String, Object> param = _req.getParameterMap();
	    List<Map<String, Object>> list = (ArrayList<Map<String ,Object>>)JsonUtil.fromJsonStr(param.get("user_list").toString().replace("&quot;","'"));
	    param.put("user_list", list);    
	   	try{
	   		rv = authService.deleteManagerAuth(param);
	   		
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", "권한 매핑 삭제에 성공하였습니다.");
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", "권한 매핑 삭제에 실패하였습니다."); // 실패 메시지
			}					
	    }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }catch(Exception e){
	    	//e.printStackTrace();
	    	logger.error("error===", e);
				param.put("success", "false"); 													// 실패여부 삽입
				param.put("message", "권한 매핑 삭제에 실패하였습니다."); 				// 실패 메시지
				return ViewHelper.getJsonView(param);
			}						
	    									
	    return ViewHelper.getJsonView(param);
	}
	
	
	
	

	
	
	
	
	
	
	
	
	
}
