/**
 * @Class Name : LogoDaoImpl.java
 * @Description : LogoDaoImpl.Class
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
 
package kr.apfs.local.logo.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.logo.dao.LogoDao;

@Repository("LogoDao")
public class LogoDaoImpl extends AbstractDao implements LogoDao {

	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectLogo(Map<String, Object> param) throws Exception{
		return selectOne("LogoDao.selectLogo", param);
	}
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertLogo(Map<String, Object> param) throws Exception{
		 return update("LogoDao.insertLogo", param);
	}
	
}
