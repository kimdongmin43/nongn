package kr.apfs.local.faq.controller;

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

import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.JsonUtil;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.faq.service.FaqService;

/**
 * @Class Name : FaqFrontController.java
 * @Description : FaqFrontController.Class
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
public class FaqFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(FaqFrontController.class);
	
	public final static String  FRONT_PATH = "/front/faq/";
	
	@Resource(name = "FaqService")
    private FaqService faqService;
	
	/**
     * 리스트 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/front/faq/faqListPage.do")
	public String faqListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
		String jsp = FRONT_PATH + "faqListPage";	
		Map<String, Object> param = _req.getParameterMap();
		param.put("use_yn", "Y");
		List<Map<String, Object>> faqList = faqService.selectFaqList(param);
		
		model.addAttribute("faqList", faqList);
		
        return jsp;	
	}
	
	/**
     * 게시판 메인 출력용 Faq
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/loadMainFaq.do")
    public ModelAndView loadMainBoard(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = faqService.selectLoadMainFaq(param);	
        param.put("list", list );
        return ViewHelper.getJsonView(param);
    }
	
	
}
