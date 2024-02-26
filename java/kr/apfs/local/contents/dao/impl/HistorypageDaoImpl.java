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
import kr.apfs.local.contents.dao.HistorypageDao;

import org.springframework.stereotype.Repository;

@Repository("HistorypageDao")
public class HistorypageDaoImpl extends AbstractDao implements HistorypageDao {
public final static String [] GUIDPAGE_ID = {"contents_history_content1","contents_history_content2","contents_history_content3"};


	/**
     * 안내데이터를 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectHistorypage(Map<String, Object> param) throws Exception{
		return selectList("HistorypageDao.selectHistorypage", param);
	}
     
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateHistorypage(Map<String, Object> param) throws Exception{		
		
		return update("updateHistorypage", param);
	}
	
	
	/**
     * 중복 체크를 한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectHistorypageExist(Map<String, Object> param) throws Exception {		
		return selectOne("HistorypageDao.selectHistorypageExist", param);
	}

	/**
     *  값을 저장한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertHistorypage(Map<String, Object> param) throws Exception {		
		return insert("HistorypageDao.insertHistorypage", param);
	}

	/**
     *  값을 삭제한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int deleteHistorypage(Map<String, Object> param) throws Exception {
		return update("HistorypageDao.deleteHistorypage",param);
	}
}
