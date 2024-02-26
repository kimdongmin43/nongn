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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.contents.dao.GuidancepageDao;

import org.springframework.stereotype.Repository;

@Repository("GuidancepageDao")
public class GuidancepageDaoImpl extends AbstractDao implements GuidancepageDao {
public static final int GUIDANCE_ROWS = 6;

	/**
     * 안내데이터를 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectGuidancepage(Map<String, Object> param) throws Exception{
		return selectOne("GuidancepageDao.selectGuidancepage", param);
	}


     @SuppressWarnings("unchecked")
	public List <Map<String, Object>> selectGuidancepage2(Map<String, Object> param) throws Exception{
		return selectList("GuidancepageDao.selectGuidancepage2", param);
	}


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateGuidancepage(Map<String, Object> param) throws Exception{

		int rv=0;
		for (int i = 1; i <= GUIDANCE_ROWS; i++) {
			param.put("contId",param.get("contId"+i));
			param.put("contents",param.get("contents"+i));
			param.put("title",param.get("title"+i));
			//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			//System.out.println(param);
			//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

			rv += update("GuidancepageDao.updateGuidancepage", param);

		}

	return rv;
	}


	/**
     * 중복 체크를 한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectGuidancepageExist(Map<String, Object> param) throws Exception {
		return selectOne("GuidancepageDao.selectGuidancepageExist", param);
	}

	/**
     *  값을 저장한다
     * @param param
     * @return int
     * @throws Exception
     */
	
	@Override
	public int insertGuidancepage(Map<String, Object> param) throws Exception {

		int rv = 0;
		for (int i = 1; i <= GUIDANCE_ROWS; i++) {
			param.put("title",param.get("title"+i));
			param.put("contents",param.get("contents"+i));
			param.put("sort", i);
			rv += insert("insertGuidancepage", param);
		}
		return rv==GUIDANCE_ROWS?1:0;

	}
}
