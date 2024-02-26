/**
 * @Class Name : IntropageDao.java
 * @Description : IntropageDao.Class
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

package kr.apfs.local.contents.dao;

import java.util.List;
import java.util.Map;


public interface NormalContentsMenuDao {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
    
	public List<Map<String, Object>> selectNormalContentsMenuList(Map<String, Object> param) throws Exception;

	

	//투자조합 그리드 데이터를 가저온다
	public List<Map<String, Object>> selectInvestGridData(Map<String, Object> param) throws Exception ;
	//투자조합 글쓰기 데이터
	public Map<String, Object> selectInvestWritePage(Map<String, Object> param) throws Exception;
	//투자조합 인서트
	public int investInsert(Map<String, Object> param)throws Exception;
	//투자조합 업데이트
	public int investUpdate(Map<String, Object> param)throws Exception;
	
	public int investDelete(Map<String, Object> param)throws Exception;

	
    
	
}
