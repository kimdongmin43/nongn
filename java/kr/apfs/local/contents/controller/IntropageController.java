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
import kr.apfs.local.contents.service.IntropageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : IntropageController.java
 * @Description : IntropageController.Class
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
public class IntropageController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(IntropageController.class);

	public final static String  FRONT_PATH = "/front/content/";
	public final static String  BACK_PATH = "/back/contents/";

	@Resource(name = "IntropageService")
    private IntropageService intropageService;


	/**
     * 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/contents/intropageListPage.do")
	public String intropageListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		String jsp = BACK_PATH + "intropageListPage";
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
    @RequestMapping(value = "/back/contents/intropagePageList.do")
	public ModelAndView intropagePageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(intropageService.selectIntropagePageList(param));
		
        return ViewHelper.getJqGridView(navigator);
	}

	/**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     *//*
    @RequestMapping(value = "/back/contents/intropageList.do")
	public @ResponseBody Map<String, Object> intropageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = BACK_PATH + "intropageListPage";

        Map<String, Object> param = _req.getParameterMap();
        param.put("*siteId", S_SITE_ID);
		List<Map<String, Object>> list = intropageService.selectIntropageList(param);
		param.put("rows", list);

        return param;
	}
	*/
	/**
     * 쓰기 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/intropageWrite.do")
	public String intropageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);

        String jsp = BACK_PATH + "intropageWrite";

        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> intropage = new HashMap();



        if(!StringUtil.nvl(param.get("mode")).equals("W")){
        	 // intropage 정보를 가져온다.

        	intropage = intropageService.selectIntropage(param);

        	if (intropage.get("contents")!=null)intropage.put("contents", intropage.get("contents").toString().replaceAll("\'", "\\&#39;"));

        }else{
        	intropage.put("satis_yn", "Y");
        }
        //System.out.println("콘텐츠"+intropage);
        model.addAttribute("intropage",intropage);

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
    @RequestMapping(value = "/back/contents/insertIntropage.do")
    public ModelAndView insertIntropage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
        try{
        	param.put("page_id", CommonUtil.createUUID());
	       	rv = intropageService.insertIntropage(param);

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
    @RequestMapping(value = "/back/contents/updateIntropage.do")
    public ModelAndView updateIntropage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
       	try{
	       	rv = intropageService.updateIntropage(param);

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
    @RequestMapping(value = "/back/contents/deleteIntropage.do")
    public ModelAndView deleteIntropage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

        //System.out.println("param"+ param);

       	try{
       		rv = intropageService.deleteIntropage(param);

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
    @RequestMapping(value = "/back/contents/intropageView.do")
	public String intropagePreview(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = "/popup"+BACK_PATH + "intropageView";
        Map<String, Object> intropage = new HashMap();
        Map<String, Object> param = _req.getParameterMap();

        intropage = intropageService.selectIntropage(param);

    	if (intropage.get("contents")!=null)intropage.put("contents", intropage.get("contents").toString().replaceAll("\'", "\\&#39;"));


        model.addAttribute("intropage",intropage);

        return jsp;
	}

	/**
     * 소개페이지 팝업 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/contents/intropageSearchPopup.do")
	public String intropageSearchPopup(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = "/sub"+BACK_PATH + "intropageListPopup";
		/*String jsp = BACK_PATH + "intropageListPopup";*/
		//System.out.println("여기??");

        return jsp;
	}

	/**
     * 소개페이지 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/intropageSearchList.do")
	public @ResponseBody Map<String, Object> intropageSearchList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();
		List<Map<String, Object>> list = intropageService.selectIntropageList(param);

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

    @RequestMapping(value = "/front/intropage/intropageShow.do")
	public String intropageShow(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = "/front/common/intropageShow";

        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> intropage = intropageService.selectIntropage(param);
        model.addAttribute("intropage",intropage);

        return jsp;
	}
    
	@RequestMapping(value ="/back/contents/disclosurePage.do")
	public String disclosurePage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		//param.put("contId", CONT_ID);
		//param.put("*siteId", S_SITE_ID);
		String jsp = BACK_PATH + "disclosurepage";
		
		List <Map<String, Object>> dis = intropageService.selectDisclosurePage(param);
		
		model.addAttribute("dis",dis);
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		
		return jsp;
	}
	
	
    @RequestMapping(value = "/back/contents/disclosurePageList.do")
	public ModelAndView disclosurePageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(intropageService.selectDisclosurePage(param));
		
        return ViewHelper.getJqGridView(navigator);
	}
    
    
    @RequestMapping(value = "/back/contents/disclosureWrite.do")
	public String disclosuresWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
				
		Map<String, Object> param = _req.getParameterMap();
		String jsp = BACK_PATH + "disclosureWrite";	
		
	    Map<String, Object> dis = new HashMap();
		
	       if(!StringUtil.nvl(param.get("mode")).equals("W")){
	        	 // 
	    	    dis = intropageService.selectDisclosurePageback(param);
	        }else{
	        	dis.put("disId",param.get("disId"));
	        }

        model.addAttribute("dis",dis);	
        
        
        
		
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
    @RequestMapping(value = "/back/contents/insertDis.do")
    public ModelAndView insertdisclosure(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();


	       	rv = intropageService.insertDisclosure(param);

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
    @RequestMapping(value = "/back/contents/updateDis.do")
    public ModelAndView updatedisclosure(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();


	       	rv = intropageService.updateDisclosure(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
     
        return ViewHelper.getJsonView(param);
    }

}
                                                                                                                            