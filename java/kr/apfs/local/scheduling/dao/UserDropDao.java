/**
 * @Class Name : PopnotiDao.java
 * @Description : PopnotiDao.Class
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
 
package kr.apfs.local.scheduling.dao;

import java.util.List;
import java.util.Map;


public interface UserDropDao {
	
	public void userAutoDropOut() throws Exception;
	
	public void userAutoDropOut2(Map<String, Object> param) throws Exception;
}
