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


public interface UserAgreeDao {

	/**
     * 동의후 23개월(700일)인 사용자들
     * @param param
     * @return
     * @throws Exception
     */
    
     public List<Map<String, Object>> selectUserAgreeList(Map<String, Object> param) throws Exception;
     
     /**
      * 로그인 접속이 11개월이 지난 사용자들
      * @param param
      * @return
      * @throws Exception
      */
     
      public List<Map<String, Object>> selectUserLoginList(Map<String, Object> param) throws Exception;
     
}
