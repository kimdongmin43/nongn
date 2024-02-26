package kr.apfs.local.contents.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.StatutepageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : StatutepageController.java
 * @Description : StatutepageController.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2017.06.26   최초생성
 *
 * @author msu
 * @since 2017. 06.28
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Intocps All right reserved.
 */

@Controller
public class StatutepageFrontController extends ComAbstractController {

	private static final Logger logger = LogManager.getLogger(StatutepageFrontController.class);

	public final static String  FRONT_PATH = "/front/contents/";
	public final static String  BACK_PATH = "/back/contents/";


	//임시 지역 세션값
	//public final static String S_SITE_ID = "3";
	//public final static String S_USER_ID = "0000000000";
	//법령 갯수
	public final static int STATUTE_ROWS = 3;


	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;

	@Resource(name = "StatutepageService")
    private StatutepageService statutepageService;

	@RequestMapping(value ="/front/contents/statutepageList.do")
	public String statutepageList(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();

		//임시지역코드
		//param.put("*siteId", S_SITE_ID);
		String jsp =  FRONT_PATH +"statutepage";


		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		List <Map<String, Object>> statutelist = statutepageService.selectStatutepage2(param);


		model.addAttribute("defaulttype",_req.getP("defaulttype"));
		model.addAttribute("statutelist",statutelist);


		return jsp;
	}


}
