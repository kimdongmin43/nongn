package kr.apfs.local.login;

import java.util.Collection;
import java.util.List;

import kr.apfs.local.common.util.CryptoUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.login.service.LoginService;
import kr.apfs.local.user.model.UserAuthVO;
import kr.apfs.local.user.model.UserVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
/**
 *
 * @author h2y
 *
 */
@Component
public class LoginAuthenticationProvider implements AuthenticationProvider {
	/**
	 *
	 */
	private final Logger logger =
			LoggerFactory.getLogger(LoginAuthenticationProvider.class);

	/**
	 *
	 */
	@Autowired
	private LoginService loginService;

	public final Authentication authenticateSingle(
			final Authentication authentication)
			throws AuthenticationException {
		// TODO Auto-generated method stub

		String username = authentication.getName();
		String password = CryptoUtil.SHA_encrypt((String) authentication.getCredentials());

//		logger.info("######" + username);
//		logger.info("######" + password);
System.out.println("###### LoginAuthenticationProvider.authenticateSingle() ###### : " + password + " #### PASSWOD");
		UserVO user = null;;
		Collection<? extends GrantedAuthority> authorities;

		try {
			user = loginService.loadUserByUsername(username);

			if (user == null) {
				throw new UsernameNotFoundException("접속자 정보를 찾을 수 없습니다.");
			}

//			logger.info("###: " + user.toString());
			logger.info("######| " + username + "|" + user.getUserId());
			logger.info("######| " + password + "|" + user.getPassword());

			if (!password.equals(user.getPassword())) {
				throw new BadCredentialsException("비밀번호가 일치하지 않습니다.\n" + password);
			}

			if (StringUtil.isNull(user.getUserCd(), "").equals("")) {
				throw new BadCredentialsException("해당 사용자의 권한이 없습니다. 시스템 관리자에게 문의하세요.");
			}

			authorities = user.getAuthorities();
		} catch (UsernameNotFoundException e) {
			logger.info(e.toString());
			throw new UsernameNotFoundException(e.getMessage());
		} catch (BadCredentialsException e) {
			logger.info(e.toString());
			throw new BadCredentialsException(e.getMessage());
		} catch (Exception e) {
			logger.info(e.toString());
			throw new RuntimeException(e.getMessage());
		}

		return new UsernamePasswordAuthenticationToken(
				user, password, authorities);
	}

	@Override
	public final Authentication authenticate(
			final Authentication authentication)
			throws AuthenticationException {
		// TODO Auto-generated method stub

		String username = authentication.getName();
		String password = CryptoUtil.SHA_encrypt((String) authentication.getCredentials());

//		logger.info("######" + username);
//		logger.info("######" + password);

		UserVO user = null;;
		List<UserAuthVO> userAuthList = null;
		Collection<? extends GrantedAuthority> authorities;

		try {
			user = loginService.loadUserByUsername(username);

			if (user == null) {
				throw new UsernameNotFoundException("접속자 정보를 찾을 수 없습니다.");
			} else {
				userAuthList = loginService.getUserAuthList(user.getUserId());
			}

			if (!password.equals(user.getPassword())) {
				throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
			}

			authorities = user.getAuthorities();
		} catch (UsernameNotFoundException e) {
			logger.info(e.toString());
			throw new UsernameNotFoundException(e.getMessage());
		} catch (BadCredentialsException e) {
			logger.info(e.toString());
			throw new BadCredentialsException(e.getMessage());
		} catch (Exception e) {
			logger.info(e.toString());
			throw new RuntimeException(e.getMessage());
		}

		return new UsernamePasswordAuthenticationToken(
				user, password, authorities);
	}

	@Override
	public final boolean supports(final Class<?> authentication) {
		// TODO Auto-generated method stub
		return true;
	}

}
