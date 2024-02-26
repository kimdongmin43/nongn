package kr.apfs.local.login.service;

import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.stereotype.Service;

import kr.apfs.local.common.Const;
import kr.apfs.local.common.util.CryptoUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.user.model.UserAuthVO;
import kr.apfs.local.user.model.UserVO;
import kr.apfs.local.user.service.UserService;
/**
 *
 * @author h2y
 *
 */
@Service
public class LoginSuccessHandler
extends SavedRequestAwareAuthenticationSuccessHandler {
	/**
	 *
	 */
	@Autowired
	private LoginService loginService;

	@Autowired
	private UserService userService;

	public final void onAuthenticationSuccessSingle(
			final HttpServletRequest request,
			final HttpServletResponse response,
			final Authentication authentication)
					throws ServletException, IOException {

		String username = authentication.getName();
		HttpSession session = request.getSession();
		UserVO user = loginService.loadUserByUsername(username);
		session.setAttribute(Const.SESSION_USER, user);
		session.setAttribute("*userId", user.getLoginId());
		session.setAttribute("*loginId", user.getLoginId());
		session.setAttribute("*userNm", user.getUserNm());
		try{
			session.setAttribute("*email", CryptoUtil.AES_Decode(user.getEmail()));
			session.setAttribute("*mobile", CryptoUtil.AES_Decode(user.getMobile()));
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        } catch (InvalidKeyException e) {
        	logger.error("InvalidKeyException error===", e);
		} catch (NoSuchAlgorithmException e) {
			logger.error("NoSuchAlgorithmException error===", e);
		} catch (NoSuchPaddingException e) {
			logger.error("NoSuchPaddingException error===", e);
		} catch (InvalidAlgorithmParameterException e) {
			logger.error("InvalidAlgorithmParameterException error===", e);
		} catch (IllegalBlockSizeException e) {
			logger.error("IllegalBlockSizeException error===", e);
		} catch (BadPaddingException e) {
			logger.error("BadPaddingException error===", e);
		}
		String userCd = user.getUserCd();
		session.setAttribute("*userCd", userCd);
		response.sendRedirect("/Main.do");
	}

	@Override
	public final void onAuthenticationSuccess(
			final HttpServletRequest request,
			final HttpServletResponse response,
			final Authentication authentication)
					throws ServletException, IOException {
		String siteCd = "";
		String url = request.getRequestURL().toString();
		siteCd = url.indexOf("front") > -1?"F":"B";

		HttpSession session = request.getSession();

		UserVO user = null;
		try{
			user = (UserVO) authentication.getPrincipal();
		}catch (NullPointerException e) {
        	logger.error("사용자 정보를 찾을 수 없습니다.", e);
        }

		if(user!=null){
			session.setAttribute(Const.SESSION_USER, user);
			session.setAttribute(Const.SESSION_USER_AUTH, user.getUserCd());
			session.setAttribute("*siteCd", siteCd);
			session.setAttribute("*userId", user.getUserId());
			session.setAttribute("*siteId", user.getSiteId());
			session.setAttribute("*loginId", user.getLoginId());
			session.setAttribute("*userCd", user.getUserCd());
			session.setAttribute("*userNm", user.getUserNm());
			try{
			session.setAttribute("*email", CryptoUtil.AES_Decode(user.getEmail()));
			session.setAttribute("*mobile", CryptoUtil.AES_Decode(user.getMobile()));
			}catch (IOException e) {
	        	logger.error("IOException error===", e);
	        } catch (NullPointerException e) {
	        	logger.error("NullPointerException error===", e);
	        } catch (InvalidKeyException e) {
	        	logger.error("InvalidKeyException error===", e);
			} catch (NoSuchAlgorithmException e) {
				logger.error("NoSuchAlgorithmException error===", e);
			} catch (NoSuchPaddingException e) {
				logger.error("NoSuchPaddingException error===", e);
			} catch (InvalidAlgorithmParameterException e) {
				logger.error("InvalidAlgorithmParameterException error===", e);
			} catch (IllegalBlockSizeException e) {
				logger.error("IllegalBlockSizeException error===", e);
			} catch (BadPaddingException e) {
				logger.error("BadPaddingException error===", e);
			}

			Map<String, Object> param = new HashMap<String, Object>();
			param.put("userId", user.getUserId());
			param.put("siteId", session.getAttribute("*siteId"));
			param.put("siteCd", siteCd);
			param.put("ip", request.getRemoteAddr());
			try{
				userService.insertUserLog(param);
			}catch (IOException e) {
	        	logger.error("사용자 접속정보를 등록하는데 실패하였습니다.(IOException error)===", e);
	        } catch (NullPointerException e) {
	        	logger.error("사용자 접속정보를 등록하는데 실패하였습니다.(NullPointerException error)===", e);
	        }catch(Exception e){
	        	logger.error("사용자 접속정보를 등록하는데 실패하였습니다.", e);
	        }

			if(siteCd.equals("F")) {
				/*if("Y".equals(pwdChgYn)){
					response.sendRedirect("/front/user/pwdChangePage.do");
				}else{*/
					response.sendRedirect("/front/user/main.do");
				/*}*/
			} else {
				response.sendRedirect("/back/main.do");
			//response.sendRedirect("/front/contents/contentsMain.do");
			}
		}
	}

}
