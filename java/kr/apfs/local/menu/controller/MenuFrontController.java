package kr.apfs.local.menu.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;


import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.menu.service.MenuService;
import kr.apfs.local.site.vo.SiteVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Class Name : MenuFrontController.java
 * @Description : MenuFrontController.Class
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
public class MenuFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(MenuFrontController.class);

	public final static String  FRONT_PATH = "/front/common/";

	@Resource(name = "MenuService")
    private MenuService menuService;

	/**
     * 사이트맵으로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/common/front/siteMap.do")
	public String siteMap(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = "/comm"+ FRONT_PATH + "siteMap";
		Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> siteMapList = menuService.selectSiteMapList(param);

		model.addAttribute("siteMapList", siteMapList);
		model.addAttribute("leftNm", "사이트맵");
        return jsp;
	}

	@RequestMapping(value = "/common/front/join.do")
	public String join(ExtHtttprequestParam _req, ModelMap model,HttpSession session) throws Exception {

		String jsp =  "/comm"+FRONT_PATH + "join";
		Map<String, Object> param = _req.getParameterMap();
		SiteVO siteVO = (SiteVO) session.getAttribute("SITE");
		model.addAttribute("clientId", StringUtil.nvl(siteVO.getClientId()));
        model.addAttribute("leftNm", "회원가입");
        return jsp;
	}

	@RequestMapping(value = "/common/front/login.do")
	public String login(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp =  "/comm"+FRONT_PATH + "login";
		Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("leftNm", "로그인");
        return jsp;
	}

}
