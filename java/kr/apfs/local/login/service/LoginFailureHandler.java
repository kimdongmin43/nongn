package kr.apfs.local.login.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.login.LoginAuthenticationProvider;

public class LoginFailureHandler implements AuthenticationFailureHandler {
	/**
	 *
	 */
	private final Logger logger =
			LoggerFactory.getLogger(LoginAuthenticationProvider.class);

	@Override
	public void onAuthenticationFailure(
			final HttpServletRequest request,
			final HttpServletResponse response,
			final AuthenticationException exception) throws IOException, ServletException {
		// TODO Auto-generated method stub

		String url = request.getRequestURL().toString();
		String siteCd = url.indexOf("front") > -1?"F":"B";

		logger.debug(exception.getMessage());

		request.setAttribute("errorMessage", exception.getMessage());

		if(siteCd.equals("B"))
			request.getRequestDispatcher("/sadm18.do").forward(request, response);
		else
			request.getRequestDispatcher("/front/user/login.do").forward(request, response);
	}


}
