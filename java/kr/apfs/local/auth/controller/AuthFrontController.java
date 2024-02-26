package kr.apfs.local.auth.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import kr.apfs.local.auth.service.AuthService;
import kr.apfs.local.board.controller.BoardFrontController;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.web.ComAbstractController;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
public class AuthFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(AuthFrontController.class);
	
	public final static String  FRONT_PATH = "/front/auth/";
	public final static String  BACK_PATH = "/back/auth/";
	
	@Resource(name = "AuthService")
    private AuthService authService;
	
	
	
	/**
     * 쓰기 페이지로 이동한다  
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/auth/authCheck.do")
	public String authSubmit(ExtHtttprequestParam _req, ModelMap model , HttpSession session) throws Exception {
        
    	
        
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> auth = new HashMap();       
        String jsp = "";        
		if (param.containsKey("sName")) {
			session.setAttribute("MEMBER_AUTH", param);
		}		        
		
		auth =  (Map<String, Object>) session.getAttribute("MEMBER_AUTH");  
		model.addAttribute("s_menuId",param.get("menuId"));		
		model.addAttribute("s_boardId",param.get("boardId"));
		model.addAttribute("s_contId",param.get("contId"));
		model.addAttribute("requestUrl",param.get("requestUrl"));
		
		
        if (auth==null || !auth.containsKey("sName")) {        	
        	jsp = FRONT_PATH + "auth";			
		}
        else
        {
        	if (!auth.get("sName").equals("")){
        		if (param.containsKey("contId")) {
        				jsp = FRONT_PATH+"success";  //view
					}
		        else{
		        	jsp = FRONT_PATH+"success2"; //write
		        	
		        	//redirectAttributes.addAttribute("param", param);
		        	//return "redirect:/front/board/boardContentsWrite.do";
		        	
		        	}
        	}
        	else
        	{
        		jsp = FRONT_PATH + "auth";			
        	}
        }
        						
        
        
        
        model.addAttribute("auth",auth);
        model.addAttribute("param",param);
        
        return jsp;
	}
		
    @RequestMapping(value = "/front/auth/success.do")
   	public String authsuccess(ExtHtttprequestParam _req, ModelMap model , HttpSession session) throws Exception {
           
       	
    	 Map<String, Object> param = _req.getParameterMap();
    	 	
		if (param.containsKey("sName")) {
/*			StringBuilder sName = new StringBuilder(param.get("sName").toString());			//	2022.01.25 - 소스 비교 시 실제 운영서버에는 없음
			sName.replace(1, 1, "*");
			param.put("sName", sName);
*/			session.setAttribute("MEMBER_AUTH", param);
		}	
    	 
    	 String jsp = param.get("requestUrl").toString();
    	 
    	 session.setAttribute("MEMBER_AUTH", param);		        
           
         model.addAttribute("param",param);
           
           return jsp;
   	}
    
    

	
	
	
	
}
