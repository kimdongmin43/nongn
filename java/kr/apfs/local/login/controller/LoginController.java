package kr.apfs.local.login.controller;

import java.net.InetAddress;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.logo.service.LogoService;
import kr.apfs.local.menu.service.MenuService;
import kr.apfs.local.user.model.UserVO;
import kr.apfs.local.common.Const;
import kr.apfs.local.site.service.SiteService;
import kr.apfs.local.site.vo.SiteVO;


@Controller
public class LoginController {

	@Resource(name = "LogoService")
	private LogoService logoService;

	@Resource(name = "MenuService")
	private MenuService menuService;

	@Resource(name = "SiteService")
    private SiteService siteService;

	/**
	 *
	 */
	private final Logger logger =  LoggerFactory.getLogger(LoginController.class);


	/**
     * 로그인 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/sadm18.do")
	public String login(
			final HttpServletRequest request,
			final HttpServletResponse response,
			ExtHtttprequestParam _req,
			ModelMap model) throws Exception {
		String jsp = "/login";
		String errorMessage = null;

		String ip = request.getHeader("X-FORWARDED-FOR");
		System.out.println("X-FORWARDED-FOR==="+ip);										
		if (ip == null){ip = request.getRemoteAddr();}
		System.out.println("아이피 확인==="+ip);												
		
		
		String ipAddress=request.getRemoteAddr();
		if(ipAddress.equalsIgnoreCase("0:0:0:0:0:0:0:1")){
		    InetAddress inetAddress=InetAddress.getLocalHost();
		    ipAddress=inetAddress.getHostAddress();
		}
		
		//	121.162.157.1 ~ 63  대역만 허용하게 만듦 - 2021.11.26
		// 20221025 김동민 : 211.57.144.9(예천) 추가하는 과정에서 tmpIP가 이유는 모르겠지만 필요없는걸로 확인
		// [운영] 운영부분의 if문을 살리다.
		// [개발] 개발부분의 if문을 살린다.
		
		/*int tmpIP;
		if (ip.indexOf("121.162.157.")>-1) {
			String[] arrIP = ip.split(".");
			tmpIP = Integer.parseInt(arrIP[3]);
			if ((tmpIP > 0) && (tmpIP < 64)) {
				tmpIP = 0;
			} else {
				tmpIP = -1;
			}
		} 	
		else {
			tmpIP = 0;
		}*/
		
		//[운영] (현재 운영에는 여의도 4곳, 익산 3곳, 예천1곳 추가)
		//if(!(ip.indexOf("121.162.157.1")>-1 || ip.indexOf("121.162.157.40")>-1 || ip.indexOf("121.162.157.41")>-1 || ip.indexOf("121.162.157.14")>-1 ||  ip.indexOf("221.159.62.223")>-1 ||  ip.indexOf("221.159.62.214")>-1 ||  ip.indexOf("221.159.62.218")>-1 || ip.indexOf("211.57.144.9")>-1)){response.sendRedirect("/front/user/main.do");} //20221024 김동민 접속IP : 221.57.144.9 추가
		
		//[개발]
		if(!(ip.indexOf("0:0:0:0:0:0:0:1")>-1 || ip.indexOf("121.162.157.1")>-1 || ip.indexOf("121.162.157.40")>-1 || ip.indexOf("121.162.157.41")>-1 || ip.indexOf("121.162.157.14")>-1 ||  ip.indexOf("221.159.62.223")>-1 ||  ip.indexOf("221.159.62.214")>-1 ||  ip.indexOf("221.159.62.218")>-1 || ip.indexOf("211.57.144.9")>-1 || ip.indexOf("192.168.60.30")>-1 || ip.indexOf("192.168.60.31")>-1 || ip.indexOf("192.168.60.32")>-1 || ip.indexOf("192.168.60.180")>-1)){response.sendRedirect("/front/user/main.do");}
		
		//미사용코드로 추정되어 주석처리
		//if(!(tmpIP>-1 ||  ip.indexOf("221.159.62.223")>-1 ||  ip.indexOf("221.159.62.214")>-1 ||  ip.indexOf("221.159.62.218")>-1 || ip.indexOf("211.57.144.9")>-1)){response.sendRedirect("/front/user/main.do");}
		//int tmpIP = 0;

		Map<String, Object> param = _req.getParameterMap();

	    HttpSession session = request.getSession();
		Map<String, Object> logo = (Map<String, Object>)session.getAttribute("Logo");
		if(logo == null) {
			logo = logoService.selectLogo(param);
			session.setAttribute("Logo", logo);
		}
		errorMessage = (String) request.getAttribute("errorMessage");
		logger.debug("errorMessage : {} ", errorMessage);
		if(errorMessage!=null){
			request.setAttribute("errorMessage", errorMessage);
		}
		
		request.setAttribute("ip", ip);
		request.setAttribute("ipAddress", ipAddress);
		return jsp;
	}

	/**
     * 메인 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/main.do")
	public String Main(HttpServletRequest request,  HttpSession session,ExtHtttprequestParam _req,  ModelMap model) throws Exception {

		/*HttpSession session = request.getSession();
	    session.setAttribute("g_top_menu_id", "");
	    session.setAttribute("g_topmenu_nm", "");
	    session.setAttribute("g_sub_menu_id", "");
	    session.setAttribute("g_menu_navi", "");*/

		Map<String, Object> param = _req.getParameterMap();
		param.put("siteCd","B");
		param.put("userCd",( (UserVO)session.getAttribute("USER")).getUserCd());
		param.put("siteId",( (UserVO)session.getAttribute("USER")).getSiteId());
		param.put("password",( (UserVO)session.getAttribute("USER")).getPassword());		//20220921 김동민 대리 추가(로그인 횟수 차단 확인용)
		System.out.println("유저정보==="+param);
		List<Map<String, Object>> sitemapList = menuService.selectSitemapList(param);

		SiteVO siteVO  = siteService.selectSite(param);
		String s_clientId = (String) session.getAttribute("s_clientId");
		if(s_clientId == null){
			session.setAttribute("s_clientId",siteVO.getClientId());
		}
        String header = request.getHeader("User-Agent").toLowerCase().replaceAll(" ", "");
    	session.setAttribute(Const.SESSION_MOBILE_YN, header.indexOf("mobile") != -1?"Y":"N");

		if (siteVO != null){

			session.setAttribute(Const.SESSION_SITE, siteVO);
			session.setAttribute("*siteId", siteVO.getSiteId());
			session.setAttribute("loginId",( (UserVO)session.getAttribute("USER")).getLoginId());	//230907 중복로그인 방지를 위한 ID값 세션 저장
		}



		model.addAttribute("sitemapList", sitemapList);
		System.out.println("ID값 체크 : " + session.getAttribute("loginId"));						//230907 중복로그인 방지를 위한 ID값 세션 저장
		return "/back/index";
	}

}
