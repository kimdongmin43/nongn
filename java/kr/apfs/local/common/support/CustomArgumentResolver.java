package kr.apfs.local.common.support;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.apfs.local.common.Const;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.util.DateUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.JsonUtil;
import kr.apfs.local.common.util.LocaleUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.menu.service.MenuService;
import kr.apfs.local.site.vo.SiteVO;
import kr.apfs.local.user.model.UserAuthVO;
import kr.apfs.local.user.model.UserVO;

/**
 * Custom Binding
 *
 * @Class Name : CustomArgumentResolver.java
 * @Description : 클래스 설명을 기술합니다.
 * @author 김상준
 * @since 2011. 9. 9.
 * @version 1.0
 * @see
 *
 * @Modification Information
 *
 *               <pre>
 *    수정일         수정자              수정내용
 *  ===========    =========    ===========================
 *  2011. 9. 9.      김상준      최초 생성
 * </pre>
 */
public class CustomArgumentResolver implements HandlerMethodArgumentResolver {
   public final static String KEY_CURRENT_USER 		= "*userId";
   public final static String KEY_CURRENT_USER_CD 		= "*userCd";
   public final static String KEY_CURRENT_MENU 		= "*menuId";
   public final static String KEY_CURRENT_SITE 		= "*siteId";
   public final static String KEY_CURRENT_SITE_CD 	= "*siteCd";
   public final static String KEY_CURRENT_TIME   	= "*curTime";
   public final static String KEY_MOBILE_YN   		= "*mobileYn";

   private static final Log logger = LogFactory.getLog(CustomArgumentResolver.class);


   @Resource(name = "MenuService")
   private MenuService menuService;


   @Override
   public boolean supportsParameter(MethodParameter parameter) {

      /*if(Map.class.isAssignableFrom(parameter.getParameterType()) && parameter.hasParameterAnnotation(CommandMap.class)) {
         return true;
      }else */if(ExtHtttprequestParam.class.isAssignableFrom(parameter.getParameterType())){
         return true;
      }else if(ListOp.class.isAssignableFrom(parameter.getParameterType())){
         return true;
      }
      else {
         return false;
      }
   }

   public Object resolveArgument(MethodParameter methodparameter,
         ModelAndViewContainer mavContainer, NativeWebRequest nativewebrequest
         ,WebDataBinderFactory binderFactory) throws Exception {

      Class<?> type = methodparameter.getParameterType();
      String paramName = methodparameter.getParameterName();
      HttpServletRequest hReq= (HttpServletRequest) nativewebrequest.getNativeRequest();

      if (type.equals(ExtHtttprequestParam.class)) {
         return bindExtParam(hReq);
      } else if (type.equals(ListOp.class)) {
          return bindListOp(hReq);
        } else if ((type.equals(Map.class)) && (paramName.equals("commandMap"))) {
            return bindCommMap(hReq);
        }


      return new Object();
   }

   /**
    * ListOp 자동 매핑
    * ListOp가 여러개일 경우 Controller에서 수동 처리
    * @param request
    * @return
    */
   public  Object bindListOp(HttpServletRequest request) {
      ListOp listOp = new ListOp(request.getParameter("LISTOP"));
      request.setAttribute(ListOp.LIST_OP_NAME, listOp);
      return listOp;
   }

   /**
    * ExtHtttprequestParam Parameter 매핑
    *
    * @param nativewebrequest
    * @return
    * @throws Exception
    */
   public  Object bindExtParam(HttpServletRequest request)
         throws Exception {
      ExtHtttprequestParam eReq = new ExtHtttprequestParam();

      String cntType = request.getHeader("Content-Type");
      // logger.debug("Content-Type : " + cntType);

      if (cntType != null && cntType.startsWith("application/json")) {
         logger.debug(" >> Start JSON Parse ");
         ServletInputStream fi = request.getInputStream();

         StringWriter writer = new StringWriter();

         IOUtils.copy(fi, writer, "UTF-8");
         String jsonStr = writer.toString();
         Map<String, Object> obj = (Map<String, Object>) JsonUtil.fromJsonStr(jsonStr);
         eReq.setParam(obj);
      } else {
         eReq =  RequestParamParser.parse(request);
      }
      LocaleResolver localeResolver = RequestContextUtils
            .getLocaleResolver(request);
      Locale locale = localeResolver.resolveLocale(request);
      eReq.setLocale(locale);

      // db에서는 SIMPLE 로케일만 사용
      eReq.put("LOCALE", LocaleUtil.getSimpleLocale(locale));

      HttpSession session = request.getSession();



      UserVO userVO = (UserVO) session.getAttribute(Const.SESSION_USER);
      SiteVO siteVO = (SiteVO) session.getAttribute(Const.SESSION_SITE);
      String mobileYn = (String) session.getAttribute(Const.SESSION_MOBILE_YN);
      String siteCd = (String) session.getAttribute(Const.SESSION_STIE_CD);

      eReq.put(KEY_CURRENT_USER, userVO!=null?userVO.getUserId():null);
      eReq.put(KEY_CURRENT_USER_CD, userVO!=null?userVO.getUserCd():null);
      eReq.put(KEY_CURRENT_SITE, siteVO!=null?siteVO.getSiteId():null);
      eReq.put(KEY_CURRENT_TIME, DateUtil.getCurrentDateTime());
      eReq.put(KEY_MOBILE_YN, mobileYn);
      eReq.put(KEY_CURRENT_SITE_CD, siteCd);

      if(session.getAttribute(KEY_CURRENT_MENU)!=null &&!session.getAttribute(KEY_CURRENT_MENU).equals("")&&!session.getAttribute(KEY_CURRENT_MENU).equals(session.getAttribute("savedMenuId")) ){

	      	Map<String, Object> param = eReq.getParameterMap();
	  	    Map<String, Object> menu = menuService.selectMenu(param);
	  	    ////System.out.println("menu++++++++++++++++++++++++++++++++" + menu);
	  	    session.setAttribute("MENU", menu);
	  	    //System.out.println(menu);
	  	    session.setAttribute("savedMenuId", session.getAttribute(KEY_CURRENT_MENU));
	  	    eReq.put(KEY_CURRENT_MENU, (String) session.getAttribute(KEY_CURRENT_MENU));
      }

      if(request.getParameter("defaulttype")!=null && !request.getParameter("defaulttype").equals("")){

  	    session.setAttribute("defaulttype", request.getParameter("defaulttype"));
  	    eReq.put("defaulttype", request.getParameter("defaulttype"));
    }

      return eReq;
   }

   public  Object bindCommMap(HttpServletRequest request) throws Exception {
      Map<String, Object> commandMap = new HashMap<String, Object>();
      Enumeration<?> enumeration = request.getParameterNames();

      while (enumeration.hasMoreElements()) {
         String key = (String) enumeration.nextElement();
         String[] values = request.getParameterValues(key);
         if (values != null) {
            commandMap.put(key, (values.length > 1) ? values
                  : values[0]);
         }
      }
      return commandMap;
   }


}