package kr.apfs.local.contents.controller;

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
import kr.apfs.local.contents.service.LocationpageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : LocationpageController.java
 * @Description : LocationpageController.Class
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
public class LocationpageFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(LocationpageFrontController.class);

	public final static String  FRONT_PATH = "/front/contents/";
	public final static String  BACK_PATH = "/back/contents/";
	//임시 지역 세션값
		//public final static String S_SITE_ID = "3";
		//public final static String S_USER_ID = "0000000000";

	@Resource(name = "LocationpageService")
    private LocationpageService locationpageService;

	@RequestMapping(value ="/front/contents/locationpageList.do")
	public String locationpageList(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();

		//임시지역코드
		//param.put("*siteId", S_SITE_ID);
		String jsp = FRONT_PATH + "locationpage";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		List<Map<String, Object>> locationlist = locationpageService.selectLocationpage2(param);

		model.addAttribute("defaulttype",_req.getP("defaulttype"));
		model.addAttribute("locationlist",locationlist);

		return jsp;
	}

}