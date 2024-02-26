/**
 * @Class Name : PopnotiDaoImpl.java
 * @Description : PopnotiDaoImpl.Class
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
 
package kr.apfs.local.popnoti.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.popnoti.dao.PopnotiDao;

@Repository("PopnotiDao")
public class PopnotiDaoImpl extends AbstractDao implements PopnotiDao {

	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPopnotiPageList(Map<String, Object> param) throws Exception{
		return selectPageList("PopnotiDao.selectPopnotiPageList", param);
	}
	
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPopnotiList(Map<String, Object> param) throws Exception{
		return selectList("PopnotiDao.selectPopnotiList", param);
	}
	
	
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectPopnoti(Map<String, Object> param) throws Exception{
		return selectOne("PopnotiDao.selectPopnoti", param);
	}
	
	
	/**
     * 중복검사를 한다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int selectPopnotiExist(Map<String, Object> param) throws Exception{
		return selectOne("PopnotiDao.selectPopnotiExist", param);
	}
	
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertPopnoti(Map<String, Object> param) throws Exception{
		 return update("PopnotiDao.insertPopnoti", param);
	}
	
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updatePopnoti(Map<String, Object> param) throws Exception{
		return update("PopnotiDao.updatePopnoti", param);
	}
	
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deletePopnoti(Map<String, Object> param) throws Exception{
		return delete("PopnotiDao.deletePopnoti", param);
	}

	/**
     * 메인페이지 팝업 리스트
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMainPopnotiList(Map<String, Object> param) throws Exception{
		return selectList("PopnotiDao.selectMainPopnotiList", param);
	}
}
