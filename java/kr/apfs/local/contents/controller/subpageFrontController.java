package kr.apfs.local.contents.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
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

import org.apache.commons.lang.StringEscapeUtils;

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
public class subpageFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(subpageFrontController.class);
	
	public final static String  FRONT_PATH = "/front/contents/";
	public final static String  BACK_PATH = "/back/contents/";
	//임시 지역 세션값
		//public final static String S_SITE_ID = "3";
		//public final static String S_USER_ID = "0000000000";
	
	@Resource(name = "IntropageService")
    private IntropageService intropageService;
	
	@RequestMapping(value ="/front/contents/sub.do")
	public String sub(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
		
		Map<String, Object> param = _req.getParameterMap();
		
		// 추가코드 2018.06.14(목) (주)아사달 대리 함민석 - 2022.01.26 여기서부터
		String t = param.get("t") == null ? "" : (String)param.get("t");
		t = StringUtil.cleanXSSResult(t);
		
		String boardId = param.get("boardId") == null ? "" : (String)param.get("boardId");
		boardId = StringUtil.matchStringReplace(boardId);
    	param.put("boardId", boardId);
    	
    	String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
    	menuId = StringEscapeUtils.escapeSql(StringUtil.matchStringReplace(menuId));
    	param.put("menuId", menuId);
    	
    	String contId = param.get("contId") == null ? "" : (String)param.get("contId");
    	contId = StringUtil.matchStringReplace(contId);
    	param.put("contId", contId);
		
		if(!t.equals("")) {
			param.put("t", t);
		}
		//	2022.01.26 여기까지는 실제 운영서버 클래스에 존재하지 않음
		
		String jsp = FRONT_PATH + "sub";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		Map<String, Object> memlist = intropageService.selectIntropage(param);
		model.addAttribute("defaulttype",_req.getP("defaulttype"));
		model.addAttribute("memlist",memlist);
		
		return jsp;
	}
	
}