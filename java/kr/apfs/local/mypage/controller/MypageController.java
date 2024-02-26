package kr.apfs.local.mypage.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.mypage.service.MypageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : mypageController.java
 * @Description : mypageController.Class
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
public class MypageController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(MypageController.class);
	
	public final static String  FRONT_PATH = "/front/content/";
	public final static String  BACK_PATH = "/back/contents/";
	//임시 지역 세션값
	
	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;
	
	@Resource(name = "MypageService")
    private MypageService mypageService;
	
	/**
     * 인사말 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	
	@RequestMapping(value = "/front/mypage/mypageWrite.do")
	public String mypageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model,HttpSession session) throws Exception {
				
		Map<String, Object> auth = new HashMap();
		Map<String, Object> param = _req.getParameterMap();
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		//임시지역코드
		String jsp = BACK_PATH + "mypageWrite";		
		
		auth =  (Map<String, Object>) session.getAttribute("MEMBER_AUTH");         
        if (auth==null || !auth.containsKey("sName")) 
        {  
        	model.addAttribute("requestUrl","/front/mypage/mypageWrite.do");
        	jsp = "/front/auth/auth";			
		}
        else
        {
        	
        	Map<String, Object> existCheck = mypageService.selectExist((Map<String, Object>)session.getAttribute("MEMBER_AUTH"));
        	Map<String, Object> mypageinfo = mypageService.selectMypage(param);
        	//List<Map<String, Object>> months = mypageService.selectMonths(param);
        	//List<Map<String, Object>> areas = mypageService.selectAreas(param);
        	//List<Map<String, Object>> items = mypageService.selectItems(param);
        	
        	
    		model.addAttribute("mypageinfo",mypageinfo);	 
    		model.put("cnt", existCheck.get("cnt"));
        }
        
		
					
				
			
		
        return jsp;	
	}		
	
	
	@RequestMapping(value = "/front/mypage/mypageCheck.do")
	public String mypageCheck(ExtHtttprequestParam _req, ListOp listOp, ModelMap model, HttpSession session) throws Exception {
				
		Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> auth = new HashMap();       
		String key="";

		String jsp = "/front/auth/auth.jsp";
		
		// 추가 코드(menuId) - 2018.06.18(월) - (주)아사달 대리 함민석 - 2022.01.26 - 이 부분은 운영에 없었음
		String menuId = param.get("menuId") == null ? "" : String.valueOf(param.get("menuId"));	//2022.06.27 김동민 대리 추가
		//String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
		menuId = StringUtil.cleanSQLInjection(StringUtil.matchStringReplace(menuId));
		param.put("menuId", menuId);
		
		// 테스트용
		//	param.put("sName", "엄선래");		//	2022.01.26 주석 처리
		
		if (param.containsKey("sName")) 
		{
			session.setAttribute("MEMBER_AUTH", param);								
		}		        
		auth =  (Map<String, Object>) session.getAttribute("MEMBER_AUTH");         
        if (auth==null || !auth.containsKey("sName")) 
        {  
        	model.addAttribute("requestUrl","/front/mypage/mypageWrite.do");
        	jsp = "/front/auth/auth";			
		}
        else
        {
        	
        	if (!auth.get("sName").equals(""))
        	{
        		Map<String, Object> existCheck = mypageService.selectExist((Map<String, Object>)session.getAttribute("MEMBER_AUTH"));
        		param.put("pKey", existCheck.get("pKey"));	// 2022.06.27 운영과 동일하게 주석 해제 - 김동민 대리
        		param.put("pKey", "150004");	// 손해평가사 마이페이지를 보기 위한 개발테스트용도(150004 이문락	1964-01-27)
        		Map<String, Object> mypageInfo = mypageService.mypageInfo(param);
        		List<Map<String, Object>> sosokCd = mypageService.selectSosokCd(param);        		
        		Map<String, Object> months = mypageService.selectMonths(param);
        		List<Map<String, Object>> productCd = mypageService.selectProductCd(param);
        		List<Map<String, Object>> myProduct = mypageService.selectMyProduct(param);
        		List<Map<String, Object>> areas = mypageService.selectAreas(param);
        		List<Map<String, Object>> myAreasList = mypageService.selectMyAreas(param);

        		
        		
        		model.put("myProduct", myProduct);
        		model.put("mypageInfo", mypageInfo);
        		model.put("months", months);
        		model.put("sosokCd", sosokCd);
        		model.put("productCd", productCd);
        		model.put("myAreasList", myAreasList);
        		model.put("areas",areas);
        		
        		//model.put("cnt", existCheck.get("cnt"));
        		model.put("cnt", "1");
        		jsp = "/front/mypage/mypageWrite";
        	}
        }
				
		
		
		
        return jsp;	
	}		
	
	/**
     * 데이터를 저장,수정한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	
    @RequestMapping(value = "/front/mypage/mypageUpdate.do")
	public ModelAndView updatemypage(ExtHtttprequestParam _req, ModelMap model,String [] productSecond ,String[]areasSecond) throws Exception {
        
    	
    	int rv =0;    	
		//NavigatorInfo navigator = new NavigatorInfo(_req);	
        //Map<String, Object> param  = navigator.getParam();
        Map<String, Object> param = _req.getParameterMap();     
        param.put("arrayProductSecond", productSecond);
        param.put("arrayAreasSecond", areasSecond);
        
        
        try{
               	rv = mypageService.updateMypage(param);    		
               	
	       	
	       	if(rv > 1){																	// 저장한다
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
    
    /*오늘 수정하던거..
    @RequestMapping(value = "/front/mypage/myEdupageCheck.do")
	public String mypageEduCheck(ExtHtttprequestParam _req, ListOp listOp, ModelMap model, HttpSession session) throws Exception {
				
		Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> auth = new HashMap(); 
		
		List<Map<String, Object>> myEdduHistory = new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> myEduFuture = new ArrayList<Map<String,Object>>();
		
		String key="";

		String jsp = "/front/auth/auth.jsp";
		
		// 추가코드 - 2018.06.19(화) - (주)아사달 대리 함민석 - 2022.01.26 여기서부터
		System.out.println("===================================================================================");
		System.out.println("menuId >>> " + param.get("menuId"));
		System.out.println("enc_data >>> " + param.get("enc_data"));
//		String enc_data = param.get("enc_data") == null ? "" : String.valueOf(param.get("enc_data"));	//2022.06.17 김동민 대리 아래 주석이 원본
		String enc_data = param.get("enc_data") == null ? "" : (String)param.get("enc_data");
		enc_data = StringUtil.matchStringReplace(enc_data);
		param.put("enc_data", enc_data);
		
		String menuId = param.get("menuId") == null ? "" : String.valueOf(param.get("menuId"));			//2022.06.17 김동민 대리 아래 주석이 원본
//		String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
		menuId = StringUtil.cleanSQLInjection(StringUtil.matchStringReplace(menuId));
		param.put("menuId", menuId);		//	--	2022.01.26 여기까지 운영에 없음
		
		if (param.containsKey("sName")) 
		{
			session.setAttribute("MEMBER_AUTH", param);								
		}		        
		auth =  (Map<String, Object>) session.getAttribute("MEMBER_AUTH");         
        if (auth==null || !auth.containsKey("sName")) 
        {  
        	model.addAttribute("requestUrl","/front/mypage/mypageEduList.do");
        	jsp = "/front/auth/auth";			
		}
        else
        {
        	
        	if (!auth.get("sName").equals(""))
        	{
        		System.out.println("000");
//        		Map<String, Object> existCheck = mypageService.selectExist((Map<String, Object>)session.getAttribute("MEMBER_AUTH"));
//        		param.put("pKey", existCheck.get("pKey"));		//	2022.01.26 운영과 동일하게 주석 해제
//        		//param.put("pKey", "150141");			//	2022.01.26 바로 위 문장을 주석 풀고 여기를 주석 처리함 <- 운영과 동일하게
        		// -------------------------------------

        			Map<String, Object> existCheck = mypageService.selectExist((Map<String, Object>)session.getAttribute("MEMBER_AUTH"));
	        		existCheck.containsKey("pKey")
	        		param.put("pKey", existCheck.get("pKey"));//	2022.01.26 운영과 동일하게 주석 해제
//	        			param.put("pKey", "150141");
        		}
        		System.out.println("222");
        		//param.put("pKey", "150141");			//	2022.01.26 바로 위 문장을 주석 풀고 여기를 주석 처리함 <- 운영과 동일하게
        		// ============================
        		System.out.println("333");
        		myEdduHistory = mypageService.selectMyEduHistory(param);
        		System.out.println("444");
        		myEduFuture = mypageService.selectMyEduFuture(param);
        		System.out.println("555");
        		
        		model.put("myEdduHistory", myEdduHistory);
        		model.put("myEduFuture", myEduFuture);
        		//model.put("cnt", existCheck.get("cntRow"));
        		model.put("cnt", "1");
        		
        		jsp = "/front/mypage/mypageEduList";
        	}
        }
				
		
		
		
        return jsp;	
	}		
    */
    
    
    @RequestMapping(value = "/front/mypage/myEdupageCheck.do")
    	public String mypageEduCheck(ExtHtttprequestParam _req, ListOp listOp, ModelMap model, HttpSession session) throws Exception {
    				
    		Map<String, Object> param = _req.getParameterMap();
    		Map<String, Object> auth = new HashMap(); 
    		List<Map<String, Object>> myEdduHistory = new ArrayList<Map<String,Object>>();
    		List<Map<String, Object>> myEduFuture = new ArrayList<Map<String,Object>>();		
    		String key="";

    		String jsp = "/front/auth/auth.jsp";
    		
//    		// 추가코드 - 2018.06.19(화) - (주)아사달 대리 함민석 - 2022.01.26 여기서부터
//    		String enc_data = param.get("enc_data") == null ? "" : String.valueOf(param.get("enc_data"));	//2022.06.17 김동민 대리 아래 주석이 원본
//    		System.out.println("enc_data===" + param.get("enc_data"));
//    		//String enc_data = param.get("enc_data") == null ? "" : (String)param.get("enc_data");
//    		enc_data = StringUtil.matchStringReplace(enc_data);
//    		param.put("enc_data", enc_data);
//    		
//    		//날짜값_김동민 대리 2022.06.20
//    		String sBirthDate = param.get("sBirthDate") == null ? "" : (String)param.get("sBirthDate");
//    		sBirthDate = StringUtil.matchStringReplace(sBirthDate);
//    		param.put("sBirthDate", sBirthDate);
//    		
//    		String menuId = param.get("menuId") == null ? "" : String.valueOf(param.get("menuId"));
//    		//String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
//    		menuId = StringUtil.cleanSQLInjection(StringUtil.matchStringReplace(menuId));
//    		param.put("menuId", menuId);		//	--	2022.01.26 여기까지 운영에 없음
    		
    		
    		
    		//param.put("sName", "서DEV9");
    		//param.put("sBirthDate", "19781109");
    		
    		if (param.containsKey("sName")) 
    		{
    			session.setAttribute("MEMBER_AUTH", param);								
    		}		        
    		auth =  (Map<String, Object>) session.getAttribute("MEMBER_AUTH");         
            if (auth==null || !auth.containsKey("sName")) 
            {  
            	model.addAttribute("requestUrl","/front/mypage/mypageEduList.do");
            	jsp = "/front/auth/auth";			
    		}
            else
            {
            	
            	if (!auth.get("sName").equals(""))
            	{
            		Map<String, Object> existCheck = mypageService.selectExist((Map<String, Object>)session.getAttribute("MEMBER_AUTH"));
            		System.out.println("=================================================");
            		System.out.println("sName==="+param.get("sName"));
            		System.out.println("sBirthDate==="+param.get("sBirthDate"));
            		System.out.println("param ===" + param);
            		System.out.println("=================================================");
            		param.put("pKey", existCheck.get("pKey"));		//	2022.01.26 운영과 동일하게 주석 해제
            		//param.put("pKey", "150141");			//	2022.01.26 바로 위 문장을 주석 풀고 여기를 주석 처리함 <- 운영과 동일하게
            		myEdduHistory = mypageService.selectMyEduHistory(param);
            		myEduFuture = mypageService.selectMyEduFuture(param);
            		
            		model.put("myEdduHistory", myEdduHistory);
            		model.put("myEduFuture", myEduFuture);
            		//model.put("cnt", existCheck.get("cnt"));
            		model.put("cnt", "1");
            		
            		jsp = "/front/mypage/mypageEduList";
            	}
            }
    				
    		
    		
    		
            return jsp;	
    	}		    
	 /**
     * 주소호출
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */

	@RequestMapping(value = "/front/mypage/memberJusoPopup.do")
	public String memberJusoPopup(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		String jsp =  "/sub/front/common/jusoPopup";
        return jsp;
	}

	


	

    

    
}
