/**
 * @Class Name : GENCMS001Controller.java
 * @Description : CMS 동작관련 Class
 * @Modification Information  
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2016.03.14    김상진       최초생성
 * 
 * @author 개발팀 
 * @since 2016.03.14 
 * @version 1.0
 * @see Copyright (C) by Gentrust All right reserved.
 */

package kr.apfs.local.mypage.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.apfs.local.mypage.service.GENCMS004Service;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class GEMCMS004Controller {
	private static final Log logger = LogFactory.getLog(GEMCMS004Controller.class);
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Resource(name="messageSource")
	MessageSource messageSource;

/*	@Autowired
	private GENCMS001Service gencms001Service;

	@Autowired
	private CMS001Service cms001Service;
	*/
	@Autowired
	private GENCMS004Service gencms004Service;
	/*
	@Autowired
	private CommonService commonService;
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;*/

	
    
    @RequestMapping("/GenCMS/gencms/cropList.do")
    public String cropList(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {
    	log.debug("\n 게시판 조회 running !!");
    	
    	try {
    		
    		HashMap menuInfoMap = (HashMap)model.get("MENU_INFO");
    		HashMap menuBoardInfoMap 	= (HashMap)model.get("BOARD_INFO");
    		
    		model.addAttribute("cropList",	gencms004Service.getCropCodeList(commandMap));
    		
    		return "GenCMS/gencms/cropList";
    		
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        	throw e;
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw e;
        } catch (Exception e) {
			log.error("bbsList exception : " + e);
			throw e;
		}
    }
    
    @RequestMapping(value="/GenCMS/gencms/cropListData.do", method = RequestMethod.POST)
    @ResponseBody
    public  HashMap cropListData(@RequestBody HashMap paramMap) throws Exception{

      	try{
//      		commandMap.put("I_CODE", "22600");
//    		commandMap.put("I_QTY", "2");
//    		commandMap.put("I_UNIT_CD", "01");
//    		commandMap.put("I_GRADE", "0");
//    		commandMap.put("I_FROM_DT", "2015-12-30");
//    		commandMap.put("I_TO_DT", "2016-03-30");
    		
      		paramMap.put("list", gencms004Service.getCropList(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
        	logger.error("Exception error===", e);
     		paramMap.put("result","1");
     	}

      	return paramMap;

    }
    
    @RequestMapping(value="/GenCMS/gencms/getCropQTYList.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getCropQTYList(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getCropQTYList(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
        	logger.error("Exception error===", e);
     		paramMap.put("result","1");
     	}

      	return paramMap;

    }
    
    @RequestMapping(value="/GenCMS/gencms/getCropUnitCdList.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getCropUnitCdList(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getCropUnitCdList(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
        	logger.error("Exception error===", e);
     		paramMap.put("result","1");
     	}

      	return paramMap;

    }
    
    @RequestMapping(value="/GenCMS/gencms/getCropGradeList.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getCropGradeList(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getCropGradeList(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
        	logger.error("Exception error===", e);
     		paramMap.put("result","1");
     	}

      	return paramMap;

    }
    
    @RequestMapping("/GenCMS/gencms/registerPage.do")
    public ModelAndView registerPage(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {
    	ModelAndView mav = new ModelAndView();
    	log.debug("\n CMS(컨텐츠관리) running!!!"); 
		try {
			String returnUrl = "";
			//HashMap menuInfo = cms001Service.getMenuInfo(commandMap);
			
			model.addAttribute("SUB_NUM", 		commandMap.get("sub_num"));
			model.addAttribute("LIC_NO", 		commandMap.get("licenseNo"));
			//model.addAttribute("ImgPath", 		propertyService.getString("ImgPath")); 
			
			mav.addObject(model);
			mav.setViewName("GenCMS/gencms/registerPage");
			
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw e;
        } catch(Exception e) {  
			log.error("CMS(컨텐츠관리)  exception : " + e);
			throw e;
		}
		return mav;
    }
    
    @RequestMapping("/GenCMS/gencms/registerEduPage.do")
    public ModelAndView registerEduPage(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {
    	ModelAndView mav = new ModelAndView();
    	log.debug("\n CMS(컨텐츠관리) running!!!"); 
		try {
			String returnUrl = "";
			//HashMap menuInfo = cms001Service.getMenuInfo(commandMap);
			
			model.addAttribute("SUB_NUM", 		commandMap.get("sub_num"));
			model.addAttribute("LIC_NO", 		commandMap.get("licenseNo"));
			//model.addAttribute("ImgPath", 		propertyService.getString("ImgPath")); 
			
			mav.addObject(model);
			mav.setViewName("GenCMS/gencms/registerEduPage");
			
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw e;
        } catch(Exception e) {  
			log.error("CMS(컨텐츠관리)  exception : " + e);
			throw e;
		}
		return mav;
    }
    
    @RequestMapping("/GenCMS/gencms/registerEduList.do")
    public ModelAndView registerEduList(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {
    	ModelAndView mav = new ModelAndView();
    	log.debug("\n CMS(컨텐츠관리) running!!!"); 
		try {
			String returnUrl = "";
			//HashMap menuInfo = cms001Service.getMenuInfo(commandMap);
			
			model.addAttribute("SUB_NUM", 		commandMap.get("sub_num"));
			model.addAttribute("LIC_NO", 		commandMap.get("LIC_NO"));
			
			mav.addObject(model);
			mav.setViewName("GenCMS/gencms/registerEduList");
			
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw e;
        } catch(Exception e) {  
			log.error("CMS(컨텐츠관리)  exception : " + e);
			throw e;
		}
		return mav;
    }

    
 
    
    @RequestMapping("/GenCMS/gencms/registerAuthPage.do")
    public ModelAndView registerAuthPage(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {
    	ModelAndView mav = new ModelAndView();
    	log.debug("\n CMS(컨텐츠관리) running!!!"); 
		try {
			
			
			String returnUrl = "";
			//HashMap menuInfo = cms001Service.getMenuInfo(commandMap);
			
			model.addAttribute("SUB_NUM", 			commandMap.get("sub_num"));
			model.addAttribute("LIC_NO", 			commandMap.get("licenseNo"));
			model.addAttribute("SAFE_WRITER_NAME", 	commandMap.get("SAFE_WRITER_NAME"));
			model.addAttribute("pageGubun", 	commandMap.get("pageGubun"));
			//model.addAttribute("ImgPath", 		propertyService.getString("ImgPath")); 
			
			mav.addObject(model);
//			mav.addObject("SUB_NUM", commandMap.get("sub_num"));
//			mav.addObject("licenseNo", commandMap.get("licenseNo").toString());
			
			mav.setViewName("GenCMS/gencms/registerAuthPage");
			
			
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw e;
        } catch(Exception e) {  
			log.error("CMS(컨텐츠관리)  exception : " + e);
			throw e;
		}
		return mav;
    }
    
    @RequestMapping("/GenCMS/gencms/authRegisterPage.do")
    public ModelAndView authRegisterPage(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception { 
    	
    	//System.out.println("이리오너라");
    	
    	
		try { 
			
			ModelAndView mav = null;
			
			HttpSession session = request.getSession();
			
			if(commandMap.get("licenseNo") == null && session.getAttribute("licenseNo") != null){
				commandMap.put("licenseNo", session.getAttribute("licenseNo"));
			}
			if(commandMap.get("sN") == null && session.getAttribute("sN") != null){
				commandMap.put("sN", session.getAttribute("sN"));
			}
			if(commandMap.get("sB") == null && session.getAttribute("sB") != null){
				commandMap.put("sB", session.getAttribute("sB"));
			}

			//commandMap.put("sN", "XXXXXXXXXX");
			
			if(commandMap.get("licenseNo") == null){
//				mav = registerPage(model, commandMap, request);
				mav = registerSearchPage(model, commandMap, request);
			}
			else if(commandMap.get("sN") == null){
//				mav = registerEduPage(model, commandMap, request);
				
//				mav = registerPage(model, commandMap, request);
				mav = registerAuthPage(model, commandMap, request);
			}
			else{
				List<HashMap> authList = gencms004Service.getAuthCheck(commandMap);
				if(authList.size() > 0){
					session.setAttribute("licenseNo", commandMap.get("licenseNo"));
					session.setAttribute("sN", commandMap.get("sN"));
					session.setAttribute("sB", commandMap.get("sB"));
					
					if(commandMap.get("pageGubun").toString().equals("reg")){
						mav = registerPage(model, commandMap, request);
					} else if (commandMap.get("pageGubun").toString().equals("edu")){
						mav = registerEduPage(model, commandMap, request);
					} else {
						//mav = dmgAsmtVideoPage(model, commandMap, request);
					}
				}
				else{
					model.addAttribute("viewType", "fail");
					mav = registerSearchPage(model, commandMap, request);
				}
			}
			mav = registerPage(model, commandMap, request);
			return mav;
    	 
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        	throw e;
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw e;
        } catch(Exception e) {  
			log.error("CMSEngine  exception : " + e);
			throw e;
		}			

    }
    
    @RequestMapping("/GenCMS/gencms/registerSearchPage.do")
    public ModelAndView registerSearchPage(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {
    	ModelAndView mav = new ModelAndView();
    	log.debug("\n CMS(컨텐츠관리) running!!!"); 
		try {
			String returnUrl = "";
			//HashMap menuInfo = cms001Service.getMenuInfo(commandMap);
			
			model.addAttribute("SUB_NUM", 			commandMap.get("sub_num"));
			model.addAttribute("pageGubun", 		commandMap.get("pageGubun"));
			//model.addAttribute("ImgPath", 		propertyService.getString("ImgPath")); 
			
			mav.addObject(model);
			mav.setViewName("GenCMS/gencms/registerSearchPage");
			
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw e;
        } catch(Exception e) {  
			log.error("CMS(컨텐츠관리)  exception : " + e);
			throw e;
		}
		return mav;
    }
    
    @RequestMapping("/GenCMS/gencms/registerSearch.do")
    public String registerSearch(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {
    	log.debug("\n CMS(컨텐츠관리) running!!!"); 
		try {
			String returnUrl = "";
			//HashMap menuInfo = cms001Service.getMenuInfo(commandMap);
			
			model.addAttribute("SUB_NUM", 			commandMap.get("sub_num"));
			
			return "GenCMS/gencms/registerSearch";
			
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw e;
        } catch(Exception e) {  
			log.error("CMS(컨텐츠관리)  exception : " + e);
			throw e;
		}			
    }
    
    @RequestMapping("/GenCMS/gencms/registerList.do")
    public ModelAndView registerList(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {
    	log.debug("\n 게시판 조회 running !!");
    	ModelAndView mav = new ModelAndView();
    	try {
    		
    		HashMap menuInfoMap = (HashMap)model.get("MENU_INFO");
    		HashMap menuBoardInfoMap 	= (HashMap)model.get("BOARD_INFO");
    		
//    		model.addAttribute("cropList",	gencms001Service.getCropCodeList(commandMap));
    		mav.addObject(model);
    		mav.setViewName("GenCMS/gencms/registerList");
    		
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw e;
        } catch (Exception e) {
			log.error("bbsList exception : " + e);
			throw e;
		}
    	return mav;
    }
    
    @RequestMapping(value="/GenCMS/gencms/getRegisterInfo.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getRegisterInfo(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getRegisterInfo(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;

    }
    
    @RequestMapping(value="/GenCMS/gencms/getRegisterActiveTime.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getRegisterActiveTime(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getRegisterActiveTime(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping(value="/GenCMS/gencms/getRegisterCropList.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getRegisterCropList(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getRegisterCropList(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping(value="/GenCMS/gencms/getRegisterRegList.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getRegisterRegList(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getRegisterRegList(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping(value="/GenCMS/gencms/getCropAllCodeTypeList.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getCropAllCodeTypeList(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getCropAllCodeTypeList(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping(value="/GenCMS/gencms/getCropAllCodeList.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getCropAllCodeList(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getCropAllCodeList(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping(value="/GenCMS/gencms/getRegCityCdList.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getRegCityCdList(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getRegCityCdList(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping(value="/GenCMS/gencms/getRegSigunguCdList.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getRegSigunguCdList(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getRegSigunguCdList(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping(value="/GenCMS/gencms/updateRegisterInfo.do", method = RequestMethod.POST)
    public @ResponseBody HashMap updateRegisterInfo(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("map", gencms004Service.updateRegisterInfo(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping("/GenCMS/gencms/registerAuth.do")
    public ModelAndView registerAuth(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {
    	ModelAndView mav = new ModelAndView();
    	log.debug("\n 게시판 글쓰기 인증 running !!");
    	try {
    		
    		/*model.addAttribute("SiteName", 		propertyService.getString("SiteName"));   
			model.addAttribute("webPath", 		propertyService.getString("webPath"));	 			
			model.addAttribute("CssPath", 		propertyService.getString("CssPath"));	 			
			model.addAttribute("ScriptPath", 	propertyService.getString("ScriptPath"));			
			model.addAttribute("ImgPath", 		propertyService.getString("ImgPath"));   
			model.addAttribute("EngineURL",		propertyService.getString("EngineURL")); */
			
    		// [개인정보 취급방침 조회]
			HashMap tempMap = new HashMap();
			tempMap.put("SUB_NUM", "92"); //사이트안내 > 개인정보취급방침
			//model.addAttribute("personalText",  gencms001Service.getHTMLInfo(tempMap));
//			model.addAttribute("LIC_NO", 	commandMap.get("licenseNo"));
			
			// [ipin 인증코드]
			model.addAttribute("iEncData",  	"");
			
			mav.addObject(model);
			mav.setViewName("GenCMS/gencms/authRegister");
    		
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw e;
        } catch (Exception e) {
			log.error("bbsAuth exception : " + e);
			throw e;
		}
    	return mav;
	}
    
    @RequestMapping("/im_mapLNStatistics_s003.do")
    public String im_mapLNStatistics_s003(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {
    	log.debug("\n 게시판 조회 running !!");
    	
    	try {
    		
    		HashMap menuInfoMap = (HashMap)model.get("MENU_INFO");
    		HashMap menuBoardInfoMap 	= (HashMap)model.get("BOARD_INFO");
    		
//    		model.addAttribute("cropList",	gencms001Service.getCropCodeList(commandMap));
    		
    		return "GenCMS/gencms/maps/im_mapLNStatistics_s003";
    		
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw e;
        } catch (Exception e) {
			log.error("bbsList exception : " + e);
			throw e;
		}
    }
    
    @RequestMapping(value="/GenCMS/gencms/getSearchRegister.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getSearchRegister(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getSearchRegister(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping(value="/GenCMS/gencms/getSearchMapData.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getSearchMapData(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getSearchMapData(paramMap));
      		
      		List<HashMap> totalList = (List<HashMap>)paramMap.get("list");
      		List<HashMap> sidoList = new ArrayList<HashMap>();
      		List<HashMap> sigunguList = new ArrayList<HashMap>();
      		
      		for(HashMap map : totalList){
      			if(map.get("시도시군구").toString().length() == 2){
      				sidoList.add(map);
      			}
      			else{
      				sigunguList.add(map);
      			}
      		}
      		
      		Double sidoParam1 = 0.0;
      		Double sidoParam2 = 0.0;
      		Double sidoParam3 = 0.0;
      		Double sidoParam4 = 0.0;
      		Double sidoParam5 = 0.0;
      		
      		for(HashMap map : sidoList){
      			if(Double.parseDouble(map.get("위험보험료").toString()) > sidoParam1){
      				sidoParam1 = Double.parseDouble(map.get("위험보험료").toString());
      			}
      			
      			if(Double.parseDouble(map.get("가입금액").toString()) > sidoParam2){
      				sidoParam2 = Double.parseDouble(map.get("가입금액").toString());
      			}
      			if(Double.parseDouble(map.get("지급금액").toString()) > sidoParam3){
      				sidoParam3 = Double.parseDouble(map.get("지급금액").toString());
      			}
      			if(Double.parseDouble(map.get("보험금지급건수").toString()) > sidoParam4){
      				sidoParam4 = Double.parseDouble(map.get("보험금지급건수").toString());
      			}
      			if(Double.parseDouble(map.get("인원").toString()) > sidoParam5){
      				sidoParam5 = Double.parseDouble(map.get("인원").toString());
      			}
      		}
      		
      		paramMap.put("sidoMax위험보험료", sidoParam1);
      		paramMap.put("sidoMax가입금액", sidoParam2);
      		paramMap.put("sidoMax지급금액", sidoParam3);
      		paramMap.put("sidoMax보험금지급건수", sidoParam4);
      		paramMap.put("sidoMax인원", sidoParam5);
      		
      		sidoParam1 = 0.0;
      		sidoParam2 = 0.0;
      		sidoParam3 = 0.0;
      		sidoParam4 = 0.0;
      		sidoParam5 = 0.0;
      		
      		for(HashMap map : sigunguList){
      			if(Double.parseDouble(map.get("위험보험료").toString()) > sidoParam1){
      				sidoParam1 = Double.parseDouble(map.get("위험보험료").toString());
      			}
      			if(Double.parseDouble(map.get("가입금액").toString()) > sidoParam2){
      				sidoParam2 = Double.parseDouble(map.get("가입금액").toString());
      			}
      			if(Double.parseDouble(map.get("지급금액").toString()) > sidoParam3){
      				sidoParam3 = Double.parseDouble(map.get("지급금액").toString());
      			}
      			if(Double.parseDouble(map.get("보험금지급건수").toString()) > sidoParam4){
      				sidoParam4 = Double.parseDouble(map.get("보험금지급건수").toString());
      			}
      			if(Double.parseDouble(map.get("인원").toString()) > sidoParam5){
      				sidoParam5 = Double.parseDouble(map.get("인원").toString());
      			}      		
      		}
      		
      		paramMap.put("sigunguMax위험보험료", sidoParam1);
      		paramMap.put("sigunguMax가입금액", sidoParam2);
      		paramMap.put("sigunguMax지급금액", sidoParam3);
      		paramMap.put("sigunguMax보험금지급건수", sidoParam4);
      		paramMap.put("sigunguMax인원", sidoParam5);
      		
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping(value="/GenCMS/gencms/getSearchTypeGubun.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getSearchTypeGubun(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getSearchTypeGubun(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping("/GenCMS/gencms/addrPopup.do")
    public ModelAndView addrPopup(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {
    	ModelAndView mav = new ModelAndView();
    	log.debug("\n CMS(컨텐츠관리) running!!!"); 
		try {
			
			mav.addObject(model);			
			mav.setViewName("GenCMS/gencms/jusoPopup"); // 2017.04.04 도로명주소 팝업창 오픈API 사용으로 변경.			
			
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw e;
        } catch(Exception e) {  
			log.error("CMS(컨텐츠관리)  exception : " + e);
			throw e;
		}
		return mav;
    }
    
    @RequestMapping(value="/GenCMS/gencms/searchHistoryEdu.do", method = RequestMethod.POST)
    public @ResponseBody HashMap searchHistoryEdu(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.searchHistoryEdu(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping(value="/GenCMS/gencms/searchEdu.do", method = RequestMethod.POST)
    public @ResponseBody HashMap searchEdu(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.searchEdu(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping(value="/GenCMS/gencms/getEduStatusCode.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getEduStatusCode(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getEduStatusCode(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping(value="/GenCMS/gencms/updateEdu.do", method = RequestMethod.POST)
    public @ResponseBody HashMap updateEdu(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		HashMap map = gencms004Service.updateEdu(paramMap);
      		if(map.get("result").toString().equals("0")){
      			paramMap.put("result","0");
      		}
      		else{
      			paramMap.put("result","1");
      		}

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    @RequestMapping("/GenCMS/gencms/colorPopup.do")
    public ModelAndView colorPopup(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {
    	ModelAndView mav = new ModelAndView();
    	log.debug("\n CMS(컨텐츠관리) running!!!"); 
		try {
			
			mav.addObject(model);
			
			mav.setViewName("GenCMS/gencms/colorPopup");
			
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw e;
        } catch(Exception e) {  
			log.error("CMS(컨텐츠관리)  exception : " + e);
			throw e;
		}
		return mav;
    }
    
    @RequestMapping(value="/GenCMS/gencms/mapTypeCodeList.do", method = RequestMethod.POST)
    public @ResponseBody HashMap mapTypeCodeList(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.mapTypeCodeList(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
    
    //2016.10.05 보험1부 성혜수 요청 농작물공시 년도별 조회로 변경
    @RequestMapping(value="/GenCMS/gencms/getSearchCodeYear.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getSearchTypeYear(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", gencms004Service.getSearchCodeYear(paramMap));
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }
   
    /**
     * 손행평가사 교육 동영상 재생 팝업 호출
     * @param model
     * @param commandMap
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/GenCMS/gencms/playerPopup.do")
    public ModelAndView playerPopup(ModelMap model, Map<String, Object> commandMap, HttpServletRequest request) throws Exception {
    	ModelAndView mav = new ModelAndView();
    	
    	String fileName = commandMap.get("fileName").toString();
    	String playFileName = "edu";
    	
    	if(StringUtils.isNotEmpty(fileName)) {
    		playFileName = playFileName + fileName.substring(0, 1); 
    	}
    	
    	String filePath = "/data/" + playFileName + ".mp4";
    	
    	model.addAttribute("fileName", fileName);
    	model.addAttribute("filePath", filePath);
    				
		mav.addObject(model);			
		mav.setViewName("GenCMS/gencms/playerPopup");			
		
		return mav;
    }
    
}
