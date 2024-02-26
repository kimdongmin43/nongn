package kr.apfs.local.common.web.interceptor;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.apfs.local.banner.service.BannerService;
import kr.apfs.local.common.Const;
import kr.apfs.local.common.support.RequestParamParser;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.main.service.MainService;
import kr.apfs.local.site.service.SiteService;
import kr.apfs.local.site.vo.SiteVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public  class DefaultInterceptor extends HandlerInterceptorAdapter {
    private Log logger = LogFactory.getLog(DefaultInterceptor.class);

    @Resource(name = "SiteService")
    private SiteService siteService;

    @Resource(name = "MainService")
    private MainService mainService;

    @Resource(name = "BannerService")
    private BannerService bannerService;


    public static final String DEFAULT_PARAM_NAME = "locale";
    private String localeParamName;

    public DefaultInterceptor() {
        this.localeParamName = "locale";
    }

    public void setLocaleParamName(String localeParamName) {
        this.localeParamName = localeParamName;
    }

    public String getLocaleParamName() {
        return this.localeParamName;
    }

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	HttpSession session = request.getSession();
        StringBuffer sb = new StringBuffer();

        //메뉴

        if(request.getQueryString()!=null && request.getQueryString().indexOf("menuId")>-1){
        	session.setAttribute("*menuId", request.getParameter("menuId"));
        }


        //회원정보 확인
        Map<String,Object> member = (Map<String, Object>) session.getAttribute(Const.SESSION_MEMBER);
        if(member== null){
        	Cookie[] cookies = request.getCookies();

        	if(cookies!=null){
        		member = new HashMap<String,Object>();
        		for(int i=0; i < cookies.length; i++){
            		if(cookies[i].getName().equals("c_membid")){
            			member.put("memId",cookies[i].getValue());
        				//System.out.println(cookies[i].getName()+ " : " + cookies[i].getValue());
        			}
            		if(cookies[i].getName().equals("c_setyn")){
            			member.put("memNm",cookies[i].getValue());
            			//System.out.println(cookies[i].getName()+ " : " + cookies[i].getValue());
        			}

            	}

        		if(member.size() > 0)session.setAttribute(Const.SESSION_MEMBER, member);
        	}
        }
        //권한

        List<String> authorities = getAuthorities();

        HandlerMethod hm=(HandlerMethod)handler;
        Method method=hm.getMethod();

        //session.setAttribute("SITE_LIST",siteService.selectSiteList());

        Map<String,Object> map= new HashMap<String,Object>();

        String s_clientId = (String) session.getAttribute("s_clientId");

        String siteCd =request.getRequestURI().indexOf("front/")>-1  ?"F":"B";
		session.setAttribute("*siteCd", siteCd);
		if(siteCd == "F"){
	        String url = request.getServerName();
	        //url = url.indexOf("localhost") > -1 || url.indexOf("127.0.0.1") > -1 ? "" :  url;
	        url = url.indexOf("localhost") > -1 || url.indexOf("127.0.0.1") > -1 || url.indexOf("insu.apfs.kr") > -1 ? "" :  url;
	        String clientId =  StringUtil.isEmpty(s_clientId) && url.length() >0 &&  url.substring(0,url.indexOf(".") ).length() > 3? url.substring(0,url.indexOf(".") ):s_clientId;
	        clientId = StringUtil.isEmpty(clientId) ?  "daejeoncci" : clientId;

	        map.put("clientId",clientId);
	        /*map.put("clientId", s_clientId == null? url.substring(0,url.indexOf(".") ): s_clientId);*/

	       SiteVO siteVO  = (SiteVO) session.getAttribute(Const.SESSION_SITE);
	       if(siteVO == null){
	    	   siteVO  = siteService.selectSite(map);
	       }

	        String header = request.getHeader("User-Agent").toLowerCase().replaceAll(" ", "");
	    	session.setAttribute(Const.SESSION_MOBILE_YN, header.indexOf("mobile") != -1?"Y":"N");

			if (siteVO != null){

				session.setAttribute(Const.SESSION_SITE, siteVO);
				session.setAttribute("*siteId", siteVO.getSiteId());
			}

			List<Map<String, Object>> banner = (List<Map<String, Object>>) session.getAttribute(Const.SESSION_BANNER);
			if(banner != null){
				if (banner.size() < 1 ){
					List<Map<String, Object>> mainBannerList = bannerService.selectBannerList(map);
					session.setAttribute(Const.SESSION_BANNER,mainBannerList );
				}
			}else{
				List<Map<String, Object>> mainBannerList = bannerService.selectBannerList(map);
				session.setAttribute(Const.SESSION_BANNER,mainBannerList );
			}
			//메인정보

			Map<String, Object> mainParam = new HashMap<String, Object>();

			mainParam.put("pubYn", "Y" );
			mainParam.put("useYn", "Y" );
			mainParam.put("region", "1" );
			mainParam.put("siteId", session.getAttribute("*siteId") );


			//List<Map<String,Object>> mainList = mainService.selectMainList(mainParam);

			/*if(mainList.size() > 0)
			{
				Map<String,Object> mainMap = mainList.get(0);
			    session.setAttribute(Const.SESSION_MAIN,mainMap );
			    mainMap.put("siteCd", "F" );

			    //배너정보
				List<Map<String, Object>> mainBannerList = bannerService.selectBannerList(mainMap);
				 session.setAttribute(Const.SESSION_BANNER,mainBannerList );
			}*/


	        // request 정보
	        sb.append("\n<=================================================================================>");
	        sb.append("\n#Request URL : " + request.getRequestURL());
	        sb.append("\n#CLIENT IP : " + request.getRemoteAddr());
	        sb.append("\n#SITE : " + siteVO.getSiteId());
	        sb.append("\n#User Agent : " + request.getHeader("User-Agent"));
	        //sb.append("\n#Handler(Controller)  : " + handler.getClass().getName());
	        if(method.getDeclaringClass().isAnnotationPresent(Controller.class)){
	        	sb.append("\n#SpringController  : " +method.getDeclaringClass());
	        	sb.append("\n#ControllerMethod  : " +method.getName());
	        }else{
	        	sb.append("\n#Handler(Controller)  : " + handler.getClass().getName());
	        }
	        sb.append("\n#USER :" + session.getAttribute("LOCALE") );
	        sb.append("\n#LOCALE :" + LocaleContextHolder.getLocale());
	        String xmlreq = request.getHeader("x-requested-with");

	        boolean isAjaxRequest = false;
	        if (xmlreq != null && xmlreq.startsWith("XMLHttpRequest")) {
	            isAjaxRequest = true;
	            sb.append("\n#Request Method : " + xmlreq);
	        } else {
	            sb.append("\n#Request Method : " + request.getMethod());
	        }
	        ExtHtttprequestParam extParam = RequestParamParser.parse(request);
	        sb.append("\n#Parameters : ");
	        sb.append(extParam.toString());

	        sb.append("\n<=================================================================================>");
	        logger.info(sb.toString());		//	원래 debug  였음 2022.02.17
		}else{

	        String url = request.getServerName();
	        url = url.indexOf("localhost") > -1 || url.indexOf("127.0.0.1") > -1 ? "" :  url;
	        String clientId =  StringUtil.isEmpty(s_clientId) && url.length() >0 &&  url.substring(0,url.indexOf(".") ).length() > 3? url.substring(0,url.indexOf(".") ):s_clientId;
	        clientId = StringUtil.isEmpty(clientId) ?  "" : clientId;

	        map.put("clientId",clientId);
	        /*map.put("clientId", s_clientId == null? url.substring(0,url.indexOf(".") ): s_clientId);*/
	        if(s_clientId != null){
		       SiteVO siteVO  = siteService.selectSite(map);
		       String header = request.getHeader("User-Agent").toLowerCase().replaceAll(" ", "");
		       session.setAttribute(Const.SESSION_MOBILE_YN, header.indexOf("mobile") != -1?"Y":"N");

		       if (siteVO != null){

					session.setAttribute(Const.SESSION_SITE, siteVO);
					session.setAttribute("*siteId", siteVO.getSiteId());
		       }
	        }
		}

        // set requestURI for JSP context (it has context path)
        request.setAttribute("controlAction", request.getRequestURI());
        //ironoh72 : 추후 메뉴고한련 세션 생성
        //if (user != null && (request.getRequestURI().indexOf("Ajax.do") == -1 && request.getRequestURI().indexOf("Popup.do") == -1 ) ) {

        /*if (user != null && (request.getRequestURI().indexOf("Ajax.do") == -1)) {
        	//setMenuInfo(request);
        }*/



        setForRM(request);
        return super.preHandle(request, response, handler);
    }



    /**
	 * 관리자단 네비게이션을 만들어준다.
	 * @param menuNavi
	 * @return
	 */
	private String getBackNavi(String menuNavi){
		StringBuffer retVal = new StringBuffer().append("<li>HOME</li>");
		String[] menuArr = StringUtil.split(menuNavi, ",");
		for(int i =0; i < menuArr.length;i++){
			if(i == (menuArr.length-1)){
				retVal.append("<li style=\"font-weight: bold; color : #0256ac;\">").append(menuArr[i]).append("</li>");
			}else{
				retVal.append("<li>").append(menuArr[i]).append("</li>");
			}
		}
		return retVal.toString();
	}
    /**
     * 웹 로그정보를 생성한다.
     *
     * @param HttpServletRequest
     *            request, HttpServletResponse response, Object handler
     * @return
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modeAndView)
            throws Exception {

        if (logger.isDebugEnabled() && modeAndView != null) {
            StringBuffer sb = new StringBuffer();

            try{
	            // request 정보
	            sb.append("\n<=================================================================================>");
	            org.springframework.web.servlet.View view = modeAndView.getView();
	            sb.append("\n#URL : " + request.getRequestURL());
	            //sb.append("\n#Handler(Controller)  : " + handler.getClass().getName());
	            if (view == null) {
	                sb.append("\n##View Name  : " + modeAndView.getViewName() + ".jsp");
	            } else {
	                sb.append("\n#$View Name  : " + modeAndView.getViewName() + " , " + modeAndView.getView());
	            }

	            sb.append("\n<=================================================================================>");
	            logger.debug(sb.toString());
            }catch(Exception e){
            	logger.debug(" notFound viewName!!!");
            }
        }
    }

    protected void setForRM(HttpServletRequest request) {

        String cxtPath = request.getContextPath();
        request.setAttribute("cxtPath", cxtPath);
        request.setAttribute("imgPath", cxtPath + "/img");
        request.setAttribute("cssPath", cxtPath + "/css");
        request.setAttribute("jsPath",  cxtPath + "/js");

        // set siteLanguage value to session (by CUPIA)
        if (request.getParameter("siteLanguage") != null) {
            String siteLanguage = org.apache.commons.lang.StringUtils.defaultString(request.getParameter("siteLanguage"));
            request.getSession(true).setAttribute("siteLanguage", siteLanguage);
        }
    }


	/**
	 *스프링시큐리티 인정 정보를 리턴한다
	 * @return
	 */
	public Authentication authentication() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if(authentication == null){
			return null;
		}

		return authentication;
	}

	/**
	 * role 정보를 가지고 온다
	 * @return
	 */
	public List<String> getAuthorities() {
		List<String> listAuth = new ArrayList<String>();
		Authentication authentication = authentication();

		if (authentication == null) {
			return null;
		}
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

		for (GrantedAuthority authority : authorities) {
			listAuth.add(authority.getAuthority());
		}

		return listAuth;
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		Enumeration params = request.getParameterNames();
		//System.out.println("<=================================================================================>");
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    //System.out.println(name + " : " +request.getParameter(name));
		}
		//System.out.println("<=================================================================================>");

		Enumeration params1 = request.getAttributeNames();
		//System.out.println("<=================================================================================>");
		while (params1.hasMoreElements()){
		    String name = (String)params1.nextElement();
		    //System.out.println(name + " : " +request.getAttribute(name));
		}
		//System.out.println("<=================================================================================>");

		Enumeration se = request.getSession().getAttributeNames();

		while(se.hasMoreElements()){
		   String getse = se.nextElement()+"";
		   //System.out.println("@@@@@@@ session : "+getse+" : "+request.getSession().getAttribute(getse));
		}

		super.afterCompletion(request, response, handler, ex);
	}

}
