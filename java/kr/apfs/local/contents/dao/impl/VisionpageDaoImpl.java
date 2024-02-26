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
import kr.apfs.local.contents.dao.VisionpageDao;

import org.springframework.stereotype.Repository;

@Repository("VisionpageDao")
public class VisionpageDaoImpl extends AbstractDao implements VisionpageDao {


	/**
     * 인사말을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectVisionpage(Map<String, Object> param) throws Exception{
		return selectOne("VisionpageDao.selectVisionpage", param);
	}


     @SuppressWarnings("unchecked")
	public List <Map<String, Object>> selectVisionpage2(Map<String, Object> param) throws Exception{
		return selectList("VisionpageDao.selectVisionpage2", param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateVisionpage(Map<String, Object> param) throws Exception{
		return update("VisionpageDao.updateVisionpage", param);
	}


	/**
     * 중복 체크를 한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectVisionpageExist(Map<String, Object> param) throws Exception {
		return selectOne("VisionpageDao.selectVisionpageExist", param);
	}

	/**
     * 값을 저장한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertVisionpage(Map<String, Object> param) throws Exception {
		return insert("insertVisionpage", param);
	}
}
