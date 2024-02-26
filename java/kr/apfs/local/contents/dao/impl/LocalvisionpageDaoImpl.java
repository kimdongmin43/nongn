/**
 * @Class Name : IntropageDaoImpl.java
 * @Description : IntropageDaoImpl.Class
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
import kr.apfs.local.contents.dao.LocalvisionpageDao;

import org.springframework.stereotype.Repository;

@Repository("LocalvisionpageDao")
public class LocalvisionpageDaoImpl extends AbstractDao implements LocalvisionpageDao {


	/**
     * 인사말을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectLocalvisionpage(Map<String, Object> param) throws Exception{
		return selectOne("LocalvisionpageDao.selectLocalvisionpage", param);
	}

     @SuppressWarnings("unchecked")
 	public List <Map<String, Object>> selectLocalvisionpage2(Map<String, Object> param) throws Exception{
 		return selectList("LocalvisionpageDao.selectLocalvisionpage2", param);
 	}


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateLocalvisionpage(Map<String, Object> param) throws Exception{
		return update("LocalvisionpageDao.updateLocalvisionpage", param);
	}


	/**
     * 중복 체크를 한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectLocalvisionpageExist(Map<String, Object> param) throws Exception {
		return selectOne("LocalvisionpageDao.selectLocalvisionpageExist", param);
	}

	/**
     * 값을 저장한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertLocalvisionpage(Map<String, Object> param) throws Exception {
		return insert("insertLocalvisionpage", param);
	}

	@Override
	public int insertMasterVision(Map<String, Object> param) throws Exception {
		return insert("insertMaterVision", param);
	}

	@Override
	public int updateMasterVision(Map<String, Object> param) throws Exception {
		return update("updateMaterVision", param);
	}

	@Override
	public Map<String, Object> selectMasterVision(Map<String, Object> param)throws Exception {
		return selectOne("selectMasterVision",param);
	}
}
