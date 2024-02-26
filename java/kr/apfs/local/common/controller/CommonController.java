package kr.apfs.local.common.controller;

import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.apfs.local.board.service.BoardService;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.menu.service.MenuService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : CommonController.java
 * @Description : CommonController.Class
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
public class CommonController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(CommonController.class);
	

	@Resource(name = "MenuService")
    private MenuService menuService;


	@Resource(name = "BoardService")
    private BoardService boardService;

	/**
	 * 세션에 저장할 정보를 인자로 보낸다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/common/setSession.do")
	public ModelAndView setSession(ExtHtttprequestParam _req, HttpServletRequest req, HttpSession session) throws Exception {


	    Map<String, Object> param = _req.getParameterMap();
	    //System.out.println("_req > "+req );
	    Enumeration nmEnum = req.getParameterNames();

	    while (nmEnum.hasMoreElements()) {
	    	String nm = (String) nmEnum.nextElement();
	    	//System.out.println(nm + " > "+req.getParameter(nm) );
	    	session.setAttribute(nm, req.getParameter(nm));
	    }
	    return ViewHelper.getJsonView(param);
	}

	/**
	 * 특정 메뉴로 이동한다
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/common/sessionPage.do")
	public ModelAndView sessionFrontPage(HttpServletRequest request,ExtHtttprequestParam _req, HttpServletRequest req,  HttpSession session) throws Exception {
		session.setAttribute("*menuId", request.getParameter("menu_id"));
		session.setAttribute("savedMenuId", request.getParameter("menu_id"));
	    Map<String, Object> param = _req.getParameterMap();
	    param.put("*menuId", request.getParameter("menu_id"));
	    Map<String, Object> menu = menuService.selectMenu(param);
	    System.out.println("session==="+session);
	    System.out.println("param==="+param);
	    System.out.println("menu==="+menu);
	    session.setAttribute("MENU", menu);
	    param.put("menu", menu);
	    param.put("success", "true");

	    return ViewHelper.getJsonView(param);
	}

	/**
     * 서브 메뉴 리스트를 가져온다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	
     @RequestMapping(value = "/front/common/naviSubmenuList.do", method = RequestMethod.POST)	//	개발용 - 원래 옵션 없었음 - 2020.11.02				,  produces = "application/json; charset=utf-8"  이거 뺌 - 2021.11.26
	//@RequestMapping(value = "/front/common/naviSubmenuList.do")				//	운영용
	public @ResponseBody Map<String, Object> naviSubmenuList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        Map<String, Object> param = _req.getParameterMap();
        param.put("*siteId", "3"); // 추가코드 2018.06.18(월) (주)아사달 대리 함민석
        param.put("*siteCd", "F");
		List<Map<String, Object>> list = menuService.selectNaviMenuList(param);
		param.put("naviSubmenuList", list);
		
		return param;
	}

    
	/**
     * 서브 메뉴 리스트를 가져온다. 개발에서만 사용한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/testNavi.do", method = RequestMethod.POST)	//	원래 옵션 없었음 - 2020.11.02   - 위 naviSubmenuList() 메서드의 개발PC 테스트용
	public @ResponseBody Map<String, Object> testNavi(ExtHtttprequestParam _req, ModelMap model) throws Exception {		//	naviSubmenuList() 이걸로 호출하면 오류나는 이유는 뭐냐?  produces 이거 때문인가?
Set<String> keyName = _req.getKeySet();
System.out.println("--------------/testNavi.do--------------");
for (String key:keyName){
    System.out.println(key + " : " +_req.getParameter(key));
}
System.out.println("--------------/testNavi.do--------------");

        Map<String, Object> param = _req.getParameterMap();			//	Key는 있는데 값이 없으면 오류난다.
        param.put("*siteId", "3"); // 추가코드 2018.06.18(월) (주)아사달 대리 함민석
        param.put("*siteCd", "F");
		
		List<Map<String, Object>> list = menuService.selectNaviMenuList(param);
		param.put("naviSubmenuList", list);
        
		return param;
	}
    
    
    
	/**
	 * 통합검색으로 이동한다
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/search/searchPage.do")
	public String searchPage(HttpServletRequest request,ExtHtttprequestParam _req, HttpServletRequest req,  HttpSession session) throws Exception {
		String jsp = "/search/front/search/searchPage";

	    return jsp;
	}



	/**
     * 에러 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/error.do")
	public String error(ExtHtttprequestParam _req, ModelMap model) throws Exception {
	     String jsp = "/error"	;
	     Map<String, Object> param = _req.getParameterMap();
        return jsp;
	}

	/**
     * 권한없음 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/auth.do")
	public String auth(ExtHtttprequestParam _req, ModelMap model) throws Exception {
	     String jsp = "/auth"	;
	     Map<String, Object> param = _req.getParameterMap();
        return jsp;
	}


}
