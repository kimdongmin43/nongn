/**
 * @Class Name : PopnotiDaoImpl.java
 * @Description : PopnotiDaoImpl.Class
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

package kr.apfs.local.scheduling.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.scheduling.dao.UserAgreeDao;

@Repository("UserAgreeDao")
public class UserAgreeDaoImpl extends AbstractDao implements UserAgreeDao {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */

	public List<Map<String, Object>> selectUserAgreeList(Map<String, Object> param) throws Exception{
		return selectList("UserDao.selectReAgreeUserList", param);
	}

     /**
      *
      * @param param
      * @return
      * @throws Exception
      */

 	public List<Map<String, Object>> selectUserLoginList(Map<String, Object> param) throws Exception{
 		return selectList("UserDao.selectUserLoginList", param);
 	}
}
