package kr.apfs.local.user.service;

import java.util.List;
import java.util.Map;

import com.google.gson.JsonArray;

import kr.apfs.local.user.model.UserAuthVO;
import kr.apfs.local.user.model.UserVO;

public interface UserService {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectUserPageList(Map<String, Object> param) throws Exception;

	/**
     * 검색 사용자 페이지리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectUserSearchPageList(Map<String, Object> param) throws Exception;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectUserList(Map<String, Object> param) throws Exception;


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public UserVO selectUserId(Map<String, Object> param) throws Exception;

  	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */

	public UserVO selectUser(Map<String, Object> param) throws Exception;

	/**
     * 중복 여부를 체크한다
     * @param param
     * @return
     * @throws Exception
     */
	public int selectUserExist(Map<String, Object> param) throws Exception;

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertUser(Map<String, Object> param) throws Exception;

 	/**
      * 사용자 가입을 처리해준다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
 	public int insertUserRegist(Map<String, Object> param) throws Exception;

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateUser(Map<String, Object> param) throws Exception;

	/**
     * 내 정보를 수정해준다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateUserModify(Map<String, Object> param) throws Exception;

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteUser(Map<String, Object> param) throws Exception;

 	/**
      * 성명과 이메일이 맞는지를 확인해준다.
      * @param param
      * @return
      * @throws Exception
      */

	public int selectUserEmailExist(Map<String, Object> param) throws Exception;

      /**
       * 패스워드가 맞는지를 확인해준다.
       * @param param
       * @return
       * @throws Exception
       */

	public int selectUserPassExist(Map<String, Object> param) throws Exception;

      /**
      *  비밀번호 변경 설정 문자를 저장한다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
	public int updatePwdConfirmWord(Map<String, Object> param) throws Exception;

     /**
      *  비밀번호 변경 설정 문자를 저장한다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
 	public int updatePasswordChange(Map<String, Object> param) throws Exception;

	/**
     *  권한 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectAuthList(Map<String, Object> param) throws Exception;

	/**
     *  지역 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectCityList(Map<String, Object> param) throws Exception;

	/**
     *  관리자 권한 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectManagerAuthList(Map<String, Object> param) throws Exception;

	/**
     *  권한별 관리자 페이지 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectAuthUserPageList(Map<String, Object> param) throws Exception;

	/**
     *  회원정보재동의 수정
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateAgreement(Map<String, Object> param) throws Exception;

	/**
	 * 회원 탈퇴
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int userDropOut(Map<String, Object> param) throws Exception;

	/**
     *  접속 처리
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertUserLog(Map<String, Object> param) throws Exception;

	/**
     * 오늘 방문 접속자
     * @param param
     * @return
     * @throws Exception
     */
	public int selectTodayConn(Map<String, Object> param) throws Exception;

	/**
	 * 재 동의 및 탈퇴 사용자 목록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectReAgreeUserList(Map<String, Object> param) throws Exception;

	/**
     * 성명과 핸드폰이 맞는지를 확인해준다.
     * @param param
     * @return
     * @throws Exception
     */

	public Map<String, Object> selectUserPhoneExist(Map<String, Object> param) throws Exception;

   	/**
      * 접속현황 통계를 가져온다.
      * @param param
      * @return
      * @throws Exception
      */

 	public Map<String, Object> selectHomepageconnTotal(Map<String, Object> param) throws Exception;

  	/**
  	 * 시간대별 접속현황을 가져온다.
  	 * @param param
  	 * @return
  	 * @throws Exception
  	 */
  	public Map<String, Object> selectHomepageconnHour(Map<String, Object> param) throws Exception;

	/**
	 * 일별접속 현황을 가져온다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectHomepageconnDay(Map<String, Object> param) throws Exception;

	/**
	 * 년별 접속 현황을 가져온다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectHomepageconnYear(Map<String, Object> param) throws Exception;

	/**
    * 내부사용자계정(SSO) list 데이터를 가지고 온다 
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectManagerList(Map<String, Object> param) throws Exception;
}
