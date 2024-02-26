/**
 * @Class Name : LocationpageDaoImpl.java
 * @Description : LocationpageDaoImpl.Class
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

package kr.apfs.local.contents.dao.impl;

import java.util.List;
import java.util.Map;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.contents.dao.LocationpageDao;

import org.springframework.stereotype.Repository;

@Repository("LocationpageDao")
public class LocationpageDaoImpl extends AbstractDao implements LocationpageDao {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLocationpagePageList(Map<String, Object> param) throws Exception{
		return selectPageList("LocationpageDao.selectLocationpagePageList", param);
	}

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLocationpageList(Map<String, Object> param) throws Exception{
		return selectList("LocationpageDao.selectLocationpageList", param);
	}

	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectLocationpage(Map<String, Object> param) throws Exception{
		return selectOne("LocationpageDao.selectLocationpage", param);
	}


     @SuppressWarnings("unchecked")
 	public List <Map<String, Object>> selectLocationpage2(Map<String, Object> param) throws Exception{
 		return selectList("LocationpageDao.selectLocationpage2", param);
 	}


	/**
     * 중복검사를 한다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int selectLocationpageExist(Map<String, Object> param) throws Exception{
		return selectOne("LocationpageDao.selectLocationpageExist", param);
	}


	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertLocationpage(Map<String, Object> param) throws Exception{
		 return update("LocationpageDao.insertLocationpage", param);
	}


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateLocationpage(Map<String, Object> param) throws Exception{
		return update("LocationpageDao.updateLocationpage", param);
	}


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteLocationpage(Map<String, Object> param) throws Exception{
		return delete("LocationpageDao.deleteLocationpage", param);
	}

}
