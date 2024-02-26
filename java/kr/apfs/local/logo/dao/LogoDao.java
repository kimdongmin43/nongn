/**
 * @Class Name : LogoDao.java
 * @Description : LogoDao.Class
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
 
package kr.apfs.local.logo.dao;

import java.util.List;
import java.util.Map;


public interface LogoDao {

	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
    
	public Map<String, Object> selectLogo(Map<String, Object> param) throws Exception;
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertLogo(Map<String, Object> param) throws Exception;
	
}
