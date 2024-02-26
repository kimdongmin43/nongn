package kr.apfs.local.contents.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.apfs.local.code.service.CodeService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.NormalContentsMenuService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : NormalContentsMenuController.java
 * @Description : NormalContentsMenuController.Class
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
public class NormalContentsMenuController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(NormalContentsMenuController.class);

	public final static String  FRONT_PATH = "/front/contents/";
	public final static String  BACK_PATH = "/back/contents/";

	@Resource(name = "NormalContentsMenuService")
    private NormalContentsMenuService NormalContentsMenuService;

	@Resource(name = "CodeService")
    private CodeService codeService;


	/**
     * 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/contents/normalContentsMenuListPage.do")
	public String NormalContentsMenuListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		String jsp = BACK_PATH + "normalContentsMenuListPage";
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
    @RequestMapping(value = "/back/contents/NormalContentsMenuPageList.do")
	public ModelAndView NormalContentsMenuPageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();

		navigator.setList(NormalContentsMenuService.selectNormalContentsMenuPageList(param));

        return ViewHelper.getJqGridView(navigator);
	}


    /**
     *  투자조합 결성 페이지를 불러온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/investListPage.do")
    	public String InvestListpage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

    		String jsp = BACK_PATH + "investListPage";
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
    @RequestMapping(value = "/back/contents/investGridData.do")
	public ModelAndView invesGridData(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();

		navigator.setList(NormalContentsMenuService.selectInvestGridData(param));

        return ViewHelper.getJqGridView(navigator);
	}

    /**
     * 쓰기 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/investWritePage.do")
	public String intropageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

    	String jsp = BACK_PATH + "investWritePage";
    	Map<String, Object> param = _req.getParameterMap();
    	Map<String, Object> investParam = new HashMap<String, Object>();


    	if (param.get("mode").equals("E")){

    		investParam = NormalContentsMenuService.selectInvestWritePage(param);
		}

    	model.put("investParam",investParam);
    	return jsp;
    }


    @RequestMapping(value = "/back/contents/investInsert.do")
	public ModelAndView investInsert(ExtHtttprequestParam _req, ModelMap model,HttpServletRequest request,String [] chk,String[] sort,String[] title,String[] contents) throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {

				rv = NormalContentsMenuService.investInsert(param);
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getInsertMsg(rv, _req));

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
        } catch (Exception e) {
			//e.printStackTrace();
			logger.error("error===", e);
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}

        return ViewHelper.getJsonView(param);
	}

    @RequestMapping(value = "/back/contents/investUpdate.do")
	public ModelAndView investUpdate(ExtHtttprequestParam _req, ModelMap model,HttpServletRequest request,String [] chk,String[] sort,String[] title,String[] contents) throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {

				rv = NormalContentsMenuService.investUpdate(param);
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));

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
        } catch (Exception e) {
			//e.printStackTrace();
			logger.error("error===", e);
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}

        return ViewHelper.getJsonView(param);
	}

    @RequestMapping(value = "/back/contents/investDelete.do")
   	public ModelAndView investDelete(ExtHtttprequestParam _req, ModelMap model,HttpServletRequest request,String [] chk,String[] sort,String[] title,String[] contents) throws Exception {

   		int rv = 0;
   		Map<String, Object> param = _req.getParameterMap();

   		try {

   				rv = NormalContentsMenuService.investDelete(param);
   				param.put("success", "true" );
   	        	param.put("message", MessageUtil.getDeteleMsg(rv, _req));

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
        } catch (Exception e) {
   			//e.printStackTrace();
   			logger.error("error===", e);
    			param.put("success", "false"); 													// 실패여부 삽입
    			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
    			return ViewHelper.getJsonView(param);
    		}

           return ViewHelper.getJsonView(param);
   	}


    @RequestMapping(value = "/back/contents/standardDate.do")
	public String standardDate(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

    	String jsp = BACK_PATH + "standardDate";
    	Map<String, Object> param = _req.getParameterMap();
    	Map<String, Object> standardDateParam = new HashMap<String, Object>();
    	standardDateParam.put("mstId", "STANDARD_DATE");
    	standardDateParam.put("codeId", "1");

    	standardDateParam = codeService.selectCode(standardDateParam);

    	model.put("standardDateParam",standardDateParam);
    	return jsp;
    }

    /**
     *  투자조합 결성 페이지를 불러온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/invest/investListPage.do")
	public String InvestFrontListpage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
    	
		String jsp = FRONT_PATH + "investListPage";
		
		Map<String, Object> param = _req.getParameterMap(); // 2018.06.14(목) 추가 소스
		
		String boardId = param.get("boardId") == null ? "" : (String)param.get("boardId");
		String miv_pageNo = param.get("miv_pageNo") == null ? "" : (String)param.get("miv_pageNo");
		
		boardId = StringUtil.matchStringReplace(boardId);
		miv_pageNo = StringUtil.matchStringReplace(miv_pageNo);
		
		param.put("boardId", boardId);
		
		listOp.put("ht.miv_pageNo", miv_pageNo);
		
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		
		Map<String, Object> standardDateParam = new HashMap<String, Object>();
    	standardDateParam.put("mstId", "STANDARD_DATE");
    	standardDateParam.put("codeId", "1");
    	
    	standardDateParam = codeService.selectCode(standardDateParam);
    	
    	model.put("standardDateParam",standardDateParam);
    	
        return jsp;
	}

    /**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/invest/investGridData.do")
	public String invesFrontGridData(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
    	String jsp =  "/sub"+FRONT_PATH;
    	jsp +=  "investList";
		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
        param.put("miv_start_index",0);
        param.put("miv_end_index",150);	//230728 김동민 투자조합현황 리스트 목록 100에서 150으로 변경
        param.put("sidx","invest_id");
        param.put("sord","desc");
        navigator.setList(NormalContentsMenuService.selectInvestGridData(param));

		model.addAttribute("boardList", navigator.getList());


        return jsp;
	}






}
