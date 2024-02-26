package kr.apfs.local.login.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.login.dao.LoginDao;
import kr.apfs.local.user.model.UserVO;

/**
 *
 * @author h2y
 *
 */
@Repository("loginDao")
public class LoginDao extends AbstractDao{

	public final UserVO selectUser(Map<String,Object> map) {
		return selectOne("selectUser", map);
	}
	/**
	 * WEB_LOG MAXSEQ값 리턴
	 * @return
	 */

	public String getWebLogMaxSeq() {
		return selectOne("sqlGetWebLogMaxSeq");
	}
	/**
	 * 로그인시 WEB_LOG 등록
	 * @param logMap
	 * @return
	 */

	public int setWebLog(Map<String, Object> logMap) {
		return insert("sqlSetWebLog",logMap);
	}
}
