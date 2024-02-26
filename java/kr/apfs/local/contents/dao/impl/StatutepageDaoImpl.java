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
import kr.apfs.local.contents.dao.StatutepageDao;

import org.springframework.stereotype.Repository;

@Repository("StatutepageDao")
public class StatutepageDaoImpl extends AbstractDao implements StatutepageDao {

public static final int STATUTE_ROWS = 3;

	/**
     * 안내데이터를 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectStatutepage(Map<String, Object> param) throws Exception{
		return selectOne("StatutepageDao.selectStatutepage", param);
	}

     @SuppressWarnings("unchecked")
	public List <Map<String, Object>> selectStatutepage2(Map<String, Object> param) throws Exception{
		return selectList("StatutepageDao.selectStatutepage2", param);
	}



	/**
     * 중복 체크를 한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectStatutepageExist(Map<String, Object> param) throws Exception {
		return selectOne("StatutepageDao.selectStatutepageExist", param);
	}

	/**
     *  값을 저장한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertStatutepage(Map<String, Object> param) throws Exception {

		int rv = 0;


		for (int i = 1; i <= STATUTE_ROWS; i++) {
			param.put("title",param.get("title"+i));
			param.put("contents",param.get("contents"+i));
			param.put("sort", i);
			rv += insert("StatutepageDao.insertStatutepage", param);
		}
		return rv==STATUTE_ROWS?1:0;
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateStatutepage(Map<String, Object> param) throws Exception{

		int rv=0;
		for (int i = 1; i <= STATUTE_ROWS; i++) {
			param.put("contId",param.get("contId"+i));
			param.put("title",param.get("title"+i));
			param.put("contents",param.get("contents"+i));

			rv += update("StatutepageDao.updateStatutepage", param);

		}


		return rv;
	}


}
