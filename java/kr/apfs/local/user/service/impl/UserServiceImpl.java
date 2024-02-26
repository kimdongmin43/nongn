package kr.apfs.local.user.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.common.util.CryptoUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.user.dao.UserDao;
import kr.apfs.local.user.model.UserVO;
import kr.apfs.local.user.service.UserService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @author P068995
 *
 */
@Service("UserService")
public class UserServiceImpl implements UserService{
	private static final Logger logger = LogManager.getLogger(UserServiceImpl.class);

	@Resource(name = "UserDao")
    protected UserDao userDao;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectUserPageList(Map<String, Object> param) throws Exception{
		return userDao.selectUserPageList(param);
	}

	/**
     * 검색 사용자 페이지리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectUserSearchPageList(Map<String, Object> param) throws Exception{
		return userDao.selectUserSearchPageList(param);
	}

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectUserList(Map<String, Object> param) throws Exception{
		return userDao.selectUserList(param);
	}

	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public UserVO selectUserId(Map<String, Object> param) throws Exception{
		return userDao.selectUser(param);
	}

  	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */

	public UserVO selectUser(Map<String, Object> param) throws Exception{
		UserVO user = userDao.selectUser(param);
		if(user.getMobile() != null){
			user.setMobile(CryptoUtil.AES_Decode(StringUtil.nvl(user.getMobile())));
		}
		if(user.getEmail() != null){
			user.setEmail(CryptoUtil.AES_Decode(StringUtil.nvl(user.getEmail())));
		}
		if(user.getTel() != null){
			user.setTel(CryptoUtil.AES_Decode(StringUtil.nvl(user.getTel())));
		}

		return user;

			/*return userDao.selectUser(param);*/
	}

	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectUserExist(Map<String, Object> param) throws Exception {
		return userDao.selectUserExist(param);
	}

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertUser(Map<String, Object> param) throws Exception{
		int rt = userDao.insertUser(param);
		/*
		ArrayList authList = (ArrayList)param.get("manager_auth") ;
		Map<String, Object> auth = new HashMap();
		auth.put("userId", param.get("userId"));
		auth.put("s_userId", param.get("s_userId"));
		userDao.deleteManagerAuth(auth);
		if(authList != null && authList.size() > 0)
		   for(int i =0; i < authList.size(); i++){
			  auth.put("auth_id", authList.get(i));
			  userDao.insertManagerAuth(auth);
		   }
		*/
		return rt;
	}

 	/**
      * 사용자 가입을 처리해준다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
 	public int insertUserRegist(Map<String, Object> param) throws Exception{
 		return userDao.insertUserRegist(param);
 	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateUser(Map<String, Object> param) throws Exception{
		int rt = userDao.updateUser(param);
		/*
		ArrayList authList = (ArrayList)param.get("manager_auth") ;
		Map<String, Object> auth = new HashMap();
		auth.put("userId", param.get("userId"));
		auth.put("s_userId", param.get("s_userId"));
		userDao.deleteManagerAuth(auth);
		if(authList != null && authList.size() > 0)
		   for(int i =0; i < authList.size(); i++){
			  auth.put("auth_id", authList.get(i));
			  userDao.insertManagerAuth(auth);
		   }
		*/
		return rt;
	}

	/**
     * 내 정보를 수정해준다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateUserModify(Map<String, Object> param) throws Exception{
		if(!StringUtil.nvl(param.get("user_mobile")).equals("")){
			param.put("user_mobile", CryptoUtil.AES_Encode(StringUtil.nvl(param.get("user_mobile"))));
		}
		if(!StringUtil.nvl(param.get("user_email")).equals("")){
			param.put("user_email", CryptoUtil.AES_Encode(StringUtil.nvl(param.get("user_email"))));
		}
		if(!StringUtil.nvl(param.get("user_tel")).equals("")){
    	 	param.put("user_tel", CryptoUtil.AES_Encode((String)param.get("user_tel")));
		}

		return userDao.updateUserModify(param);
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteUser(Map<String, Object> param) throws Exception{
		return userDao.deleteUser(param);
	}

  	/**
       * 성명과 이메일이 맞는지를 확인해준다.
       * @param param
       * @return
       * @throws Exception
       */

	public int selectUserEmailExist(Map<String, Object> param) throws Exception{
		return userDao.selectUserEmailExist(param);
	}

	/**
     * 패스워드가 맞는지를 확인해준다.
     * @param param
     * @return
     * @throws Exception
     */

	public int selectUserPassExist(Map<String, Object> param) throws Exception{
		return userDao.selectUserPassExist(param);
	}

	/**
	   *  비밀번호 변경 설정 문자를 저장한다.
	   * @param 	param
	   * @return 	int
	   * @throws 	Exception
	   */
  	public int updatePwdConfirmWord(Map<String, Object> param) throws Exception{
  		return userDao.updatePwdConfirmWord(param);
  	}

    /**
     *  비밀번호 변경 설정 문자를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updatePasswordChange(Map<String, Object> param) throws Exception{
		return userDao.updatePasswordChange(param);
	}

	/**
     *  권한 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectAuthList(Map<String, Object> param) throws Exception{
		return userDao.selectAuthList(param);
	}

	/**
     *  지역 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectCityList(Map<String, Object> param) throws Exception{
		return userDao.selectCityList(param);
	}

	/**
     *  관리자 권한 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectManagerAuthList(Map<String, Object> param) throws Exception{
		return userDao.selectManagerAuthList(param);
	}

	/**
     *  권한별 관리자 페이지 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectAuthUserPageList(Map<String, Object> param) throws Exception{
		return userDao.selectAuthUserPageList(param);
	}

	/**
     *  회원정보재동의 수정
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateAgreement(Map<String, Object> param) throws Exception{
		return userDao.updateAgreement(param);
	}

	/**
     *  회원 탈퇴
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int userDropOut(Map<String, Object> param) throws Exception{
		return userDao.userDropOut(param);
	}

	/**
     * 오늘 방문 접속자
     * @param param
     * @return
     * @throws Exception
     */
	public int selectTodayConn(Map<String, Object> param) throws Exception{
		return userDao.selectTodayConn(param);
	}

	/**
     *  접속 처리
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertUserLog(Map<String, Object> param) throws Exception{
		return userDao.insertUserLog(param);
	}

	/**
     *  재 동의 및 탈퇴 사용자 목록
     * @param param
     * pday - 재동의 목록 dday 탈퇴회원 목록
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectReAgreeUserList(Map<String, Object> param) throws Exception{
		return userDao.selectReAgreeUserList(param);
	}

	/**
     *  성명과 핸드폰이 맞는지를 확인해준다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public Map<String, Object> selectUserPhoneExist(Map<String, Object> param) throws Exception{
		return userDao.selectUserPhoneExist(param);
	}

   	/**
      * 접속현황 통계를 가져온다.
      * @param param
      * @return
      * @throws Exception
      */

 	public Map<String, Object> selectHomepageconnTotal(Map<String, Object> param) throws Exception{
    	  return userDao.selectHomepageconnTotal(param);
      }

  	/**
  	 * 시간대별 접속현황을 가져온다.
  	 * @param param
  	 * @return
  	 * @throws Exception
  	 */
  	public Map<String, Object> selectHomepageconnHour(Map<String, Object> param) throws Exception{
  		return userDao.selectHomepageconnHour(param);
  	}

	/**
	 * 일별접속 현황을 가져온다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectHomepageconnDay(Map<String, Object> param) throws Exception{
		return userDao.selectHomepageconnDay(param);
	}

	/**
	 * 년별 접속 현황을 가져온다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectHomepageconnYear(Map<String, Object> param) throws Exception{
		return userDao.selectHomepageconnYear(param);
	}

	/**
    * 내부사용자계정(SSO) list 데이터를 가지고 온다 
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectManagerList(Map<String, Object> param) throws Exception{
		return userDao.selectManagerList(param);
	}
}
