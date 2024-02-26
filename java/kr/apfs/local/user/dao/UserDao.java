package kr.apfs.local.user.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.user.model.UserVO;

/**
 * @author jangcw
 *
 */
@Repository("UserDao")
public class UserDao extends AbstractDao {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */

	public List<Map<String, Object>> selectUserPageList(Map<String, Object> param) throws Exception{
		return selectPageList("UserDao.selectUserPageList", param);
	}

 	/**
      * 검색 사용자 페이지리스트를 가져온다.
      * @param param
      * @return
      * @throws Exception
      */
 	public List<Map<String, Object>> selectUserSearchPageList(Map<String, Object> param) throws Exception{
 		return selectPageList("UserDao.selectUserSearchPageList", param);
 	}

 	/**
     *  지역 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectCityList(Map<String, Object> param) throws Exception{
		return selectList("UserDao.selectCityList", param);
	}

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */

	public List<Map<String, Object>> selectUserList(Map<String, Object> param) throws Exception{
		return selectList("UserDao.selectUserList", param);
	}

  	/**
       * 선택된 행의 값을 가지고 온다
       * @param param
       * @return
       * @throws Exception
       */

  	public UserVO selectUser(Map<String, Object> param) throws Exception{
  		return selectOne("UserDao.selectUser", param);
  	}

	/**
     * 중복검사를 한다
     * @param param
     * @return
     * @throws Exception
     */

	public int selectUserExist(Map<String, Object> param) throws Exception{
		return selectOne("UserDao.selectUserExist", param);
	}

 	/**
      * 사용자 가입을 처리해준다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
 	public int insertUserRegist(Map<String, Object> param) throws Exception{
 		int rt = update("UserDao.insertUser", param);
		if(rt > 0){
			if(StringUtil.nvl(param.get("user_gb"),"N").equals("N"))
				param.put("hist_msg", "사용자를 등록하였습니다.");
			else
				param.put("hist_msg", "관리자를 등록하였습니다.");

			 insert("UserDao.insertUserModHIstory",param);
		}
		return rt;
 	}

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertUser(Map<String, Object> param) throws Exception{
		int rt = update("UserDao.insertUser", param);
		/*
		if(rt > 0){
			if(StringUtil.nvl(param.get("user_gb"),"N").equals("N"))
				param.put("hist_msg", "사용자를 등록하였습니다.");
			else
				param.put("hist_msg", "관리자를 등록하였습니다.");

			 insert("UserDao.insertUserModHIstory",param);
		}*/
		return rt;
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateUser(Map<String, Object> param) throws Exception{
		int rt = update("UserDao.updateUser", param);
		/*
		if(rt > 0){
			if(StringUtil.nvl(param.get("user_gb"),"N").equals("N"))
				param.put("hist_msg", "사용자를 수정 하였습니다.");
			else
				param.put("hist_msg", "관리자를 수정 하였습니다.");

			   insert("UserDao.insertUserModHIstory",param);
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
		int rt = update("UserDao.updateUser", param);
		if(rt > 0){
			if(StringUtil.nvl(param.get("user_gb"),"N").equals("N"))
				param.put("hist_msg", "사용자를 수정 하였습니다.");
			else
				param.put("hist_msg", "관리자를 수정 하였습니다.");

			   insert("UserDao.insertUserModHIstory",param);
		}
		return rt;
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteUser(Map<String, Object> param) throws Exception{
		return delete("UserDao.deleteUser", param);
	}

 	/**
      * 성명과 이메일이 맞는지를 확인해준다.
      * @param param
      * @return
      * @throws Exception
      */

 	public int selectUserEmailExist(Map<String, Object> param) throws Exception{
 		return selectOne("UserDao.selectUserEmailExist", param);
 	}

      /**
       * 패스워드가 맞는지를 확인해준다.
       * @param param
       * @return
       * @throws Exception
       */

  	public int selectUserPassExist(Map<String, Object> param) throws Exception{
  		return selectOne("UserDao.selectUserPassExist", param);
  	}

   /**
   *  비밀번호 변경 설정 문자를 저장한다.
   * @param 	param
   * @return 	int
   * @throws 	Exception
   */
  	public int updatePwdConfirmWord(Map<String, Object> param) throws Exception{
  		 return update("UserDao.updatePwdConfirmWord", param);
  	}

    /**
     *  비밀번호 변경 설정 문자를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updatePasswordChange(Map<String, Object> param) throws Exception{
		 return update("UserDao.updatePasswordChange", param);
	}

	/**
     *  권한 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectAuthList(Map<String, Object> param) throws Exception{
		return selectList("UserDao.selectAuthList", param);
	}

	/**
     *  관리자 권한 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectManagerAuthList(Map<String, Object> param) throws Exception{
		return selectList("UserDao.selectManagerAuthList", param);
	}

	/**
     * 매니저 권한을 등록해준다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertManagerAuth(Map<String, Object> param) throws Exception{
		return update("UserDao.insertManagerAuth", param);
	}

	/**
     * 매너지 권한을 삭제해준다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteManagerAuth(Map<String, Object> param) throws Exception{
		return update("UserDao.deleteManagerAuth", param);
	}

	/**
     *  권한별 관리자 페이지 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectAuthUserPageList(Map<String, Object> param) throws Exception{
		return selectPageList("UserDao.selectAuthUserPageList", param);
	}

	/**
     * 회원정보재동의 수정
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateAgreement(Map<String, Object> param) throws Exception{
		return update("UserDao.updateAgreement", param);
	}

	/**
     * 회원 탈퇴
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int userDropOut(Map<String, Object> param) throws Exception{
		return update("UserDao.userDropOut", param);
	}

	/**
     *  접속 처리
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertUserLog(Map<String, Object> param) throws Exception{
		return update("UserDao.insertUserLog", param);
	}

	/**
     * 오늘 방문 접속자
     * @param param
     * @return
     * @throws Exception
     */
	public int selectTodayConn(Map<String, Object> param) throws Exception{
		return selectOne("UserDao.selectTodayConn", param);
	}

	/**
     *  재 동의 및 탈퇴 사용자 목록
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectReAgreeUserList(Map<String, Object> param) throws Exception{
		return selectPageList("UserDao.selectReAgreeUserList", param);
	}

	/**
     * 성명과 핸드폰이 맞는지를 확인해준다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectUserPhoneExist(Map<String, Object> param) throws Exception{
		return selectOne("UserDao.selectUserPhoneExist", param);
	}

   	/**
      * 접속현황 통계를 가져온다.
      * @param param
      * @return
      * @throws Exception
      */

 	public Map<String, Object> selectHomepageconnTotal(Map<String, Object> param) throws Exception{
		return selectOne("UserDao.selectHomepageconnTotal", param);
	}

  	/**
  	 * 시간대별 접속현황을 가져온다.
  	 * @param param
  	 * @return
  	 * @throws Exception
  	 */
  	public Map<String, Object> selectHomepageconnHour(Map<String, Object> param) throws Exception{
		return selectOne("UserDao.selectHomepageconnHour", param);
	}

	/**
	 * 일별접속 현황을 가져온다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectHomepageconnDay(Map<String, Object> param) throws Exception{
		return selectList("UserDao.selectHomepageconnDay", param);
	}

	/**
	 * 년별 접속 현황을 가져온다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectHomepageconnYear(Map<String, Object> param) throws Exception{
		return selectList("UserDao.selectHomepageconnYear", param);
	}
	
	/**
    * 내부사용자계정(SSO) list 데이터를 가지고 온다 
    * @param param
    * @return
    * @throws Exception
    */
    @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectManagerList(Map<String, Object> param) throws Exception{
		return selectList("UserDao.selectManagerList", param);
	}

}