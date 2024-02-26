package kr.apfs.local.common.web.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.apfs.local.common.Const;
import kr.apfs.local.user.model.UserVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.view.RedirectView;



public class SessionInterceptor  extends HandlerInterceptorAdapter  {
    protected Log logger = LogFactory.getLog(SessionInterceptor.class);

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
logger.info("SessionInterceptor 시작");
        /**
         * 세션 확인
         */
        HttpSession session = request.getSession();
        boolean sessionInvalid = true;
        UserVO user = null;
        Map<String,Object> member = null;
        try {
        	if (!"".equals(session.getId())) {
                user = (UserVO) session.getAttribute(Const.SESSION_USER);
                member = (Map<String, Object>) session.getAttribute(Const.SESSION_MEMBER);
                if (user != null) {
                    sessionInvalid = false;
                }else{
            		sessionInvalid = member!=null?true:false;
                }
            }
        } catch (Exception ignore) {
            logger.debug(ignore.getMessage());
        }

        if (sessionInvalid) {
        	ModelAndView modelAndView = new ModelAndView(new RedirectView("/auth.do"));
			throw new ModelAndViewDefiningException(modelAndView);

        }
       	return true;
    }
}