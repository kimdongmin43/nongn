package kr.apfs.local.login.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.apfs.local.login.dao.LoginDao;
import kr.apfs.local.login.model.Role;
import kr.apfs.local.user.dao.UserDao;
import kr.apfs.local.user.model.UserAuthVO;
import kr.apfs.local.user.model.UserVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
/**
 *
 * @author h2y
 *
 */
@Service
public class LoginService implements UserDetailsService {
	/**
	 *
	 */
	private final Logger logger =
			LoggerFactory.getLogger(LoginService.class);
	/**
	 *
	 */
	@Autowired
	private LoginDao loginDao;

	@Autowired
	private UserDao userDao;

	@Override
	public final UserVO loadUserByUsername(final String username)
			throws UsernameNotFoundException {
		// TODO Auto-generated method stub

		logger.debug("username : " + username);

		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
	    HttpServletRequest req = sra.getRequest(); // 리퀘스트 가져오기

	    HttpSession session = req.getSession(); // 세션가져오기

		Map<String,Object> param = new HashMap<String,Object>();
		param.put("loginId",username);
		param.put("*siteId", session.getAttribute("*siteId"));
		UserVO userInfo = loginDao.selectUser(param);

		if (userInfo != null) {

			userInfo.setUserNm(userInfo.getUserNm());
			userInfo.setPassword(userInfo.getPassword());

			Role role = new Role();
			role.setName("ROLE_USER");

			List<Role> roles = new ArrayList<Role>();
			roles.add(role);

			userInfo.setAuthorities(roles);
		}

		return userInfo;
	}

	public List<UserAuthVO> getUserAuthList(String empId) {
		List<UserAuthVO> returnList = null;

		//returnList = empDao.getUserAuthList(empId);

		return returnList;
	}




}
