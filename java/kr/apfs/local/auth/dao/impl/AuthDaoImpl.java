/**
 * @Class Name : AuthDaoImpl.java
 * @Description : AuthDaoImpl.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2015.05.10           최초생성
 *
 * @author jangcw
 * @since 2016. 06.10
 * @version 1.0
 *
 *  Copyright (C) by Intocps All right reserved.
 */
 
package kr.apfs.local.auth.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.auth.dao.AuthDao;

@Repository("AuthDao")
public class AuthDaoImpl extends AbstractDao implements AuthDao {

	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAuthPageList(Map<String, Object> param) throws Exception{
		return selectPageList("AuthDao.selectAuthPageList", param);
	}
	
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAuthList(Map<String, Object> param) throws Exception{
		return selectList("AuthDao.selectAuthList", param);
	}
	
	
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectAuth(Map<String, Object> param) throws Exception{
		return selectOne("AuthDao.selectAuth", param);
	}
	
	
	/**
     * 중복검사를 한다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int selectAuthExist(Map<String, Object> param) throws Exception{
		return selectOne("AuthDao.selectAuthExist", param);
	}
	
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertAuth(Map<String, Object> param) throws Exception{
		 return update("AuthDao.insertAuth", param);
	}
	
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateAuth(Map<String, Object> param) throws Exception{
		return update("AuthDao.updateAuth", param);
	}
	
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteAuth(Map<String, Object> param) throws Exception{
		return delete("AuthDao.deleteAuth", param);
	
	}
	/**
     *  권한별 관리자 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> managerAuthPageList(Map<String, Object> param) throws Exception{
		return selectPageList("AuthDao.managerAuthPageList", param);
	}
	
	/**
     * 관리자 권한 매핑 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertManagerAuth(Map<String, Object> param) throws Exception{
		return update("AuthDao.insertManagerAuth", param);
	}
	
	/**
     * 관리자 권한 매핑 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deleteManagerAuth(Map<String, Object> param) throws Exception{
		return update("AuthDao.deleteManagerAuth", param);
	}
	
}
