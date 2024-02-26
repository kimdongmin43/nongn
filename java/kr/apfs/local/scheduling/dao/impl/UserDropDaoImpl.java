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
import kr.apfs.local.scheduling.dao.UserDropDao;

@Repository("UserDropDao")
public class UserDropDaoImpl extends AbstractDao implements UserDropDao {
	
     @SuppressWarnings("unchecked")
	public void userAutoDropOut() throws Exception{
		update("UserDao.userAutoDropOut");
	}
     
     @SuppressWarnings("unchecked")
 	public void userAutoDropOut2(Map<String, Object> param) throws Exception{
 		update("UserDao.userDropOut", param);
 	}
}
