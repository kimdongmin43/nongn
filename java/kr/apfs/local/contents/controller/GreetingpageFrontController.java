package kr.apfs.local.contents.controller;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import kr.apfs.local.common.fileupload.model.CommonFileVO;
import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.JsonUtil;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.fileupload.FileUploadModel;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.GreetingpageService;
import kr.apfs.local.file.service.AttachFileService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestParam;




/**
 * @Class Name : GreetingpageController.java
 * @Description : GreetingpageController.Class
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
public class GreetingpageFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(GreetingpageFrontController.class);

	public final static String  FRONT_PATH = "/front/contents/";
	public final static String  BACK_PATH = "/back/contents/";
	//임시 지역 세션값
	//public final static String S_SITE_ID = "3";
	//public final static String S_USER_ID = "0000000000";




	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;

	@Resource(name = "GreetingpageService")
    private GreetingpageService greetingpageService;

	@Resource(name = "AttachFileService")
    private AttachFileService fileService;


	@RequestMapping(value ="/front/contents/greetingpageList.do",method = RequestMethod.GET)
	public String greetingpageList(ExtHtttprequestParam _req, ListOp listOp,ModelMap model)
			throws Exception {

		Map<String, Object> param = _req.getParameterMap();


		//param.put("*siteId", S_SITE_ID);
		String jsp = FRONT_PATH + "greetingpage";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		List <Map<String, Object>> greetinglist = greetingpageService.selectGreetingpage2(param);

        model.addAttribute("defaulttype",_req.getP("defaulttype"));
		model.addAttribute("greetinglist",greetinglist);


		return  jsp;
	}

}