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
import kr.apfs.local.contents.dao.GreetingpageDao;

import org.springframework.stereotype.Repository;

@Repository("GreetingpageDao")
public class GreetingpageDaoImpl extends AbstractDao implements GreetingpageDao {


	/**
     * 인사말을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectGreetingpage(Map<String, Object> param) throws Exception{
		return selectOne("GreetingpageDao.selectGreetingpage", param);
	}	
     
     @SuppressWarnings("unchecked")
	public List <Map<String, Object>> selectGreetingpage2(Map<String, Object> param) throws Exception{
		return selectList("GreetingpageDao.selectGreetingpage2", param);
	}	
     
     
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateGreetingpage(Map<String, Object> param) throws Exception{
		return update("GreetingpageDao.updateGreetingpage", param);
	}
	
	
	/**
     * 중복 체크를 한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectGreetingpageExist(Map<String, Object> param) throws Exception {		
		return selectOne("GreetingpageDao.selectGreetingpageExist", param);
	}

	/**
     * 값을 저장한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertGreetingpage(Map<String, Object> param) throws Exception {		
		return insert("insertGreetingpage", param);
	}
}
