package kr.apfs.local.logo.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.apfs.local.logo.dao.LogoDao;
import kr.apfs.local.logo.service.LogoService;

/**
 * @Class Name : LogoServiceImpl.java
 * @Description : LogoServiceImpl.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2015.05.09           최초생성
 *
 * @author jangcw
 * @since 2016. 06.10
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Intocps All right reserved.
 */

@Service("LogoService")
public class LogoServiceImpl implements LogoService {
	private static final Logger logger = LogManager.getLogger(LogoServiceImpl.class);
	
	@Resource(name = "LogoDao")
    protected LogoDao logoDao;
		
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectLogo(Map<String, Object> param) throws Exception{
		return logoDao.selectLogo(param);
	}

	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertLogo(Map<String, Object> param) throws Exception{
		return logoDao.insertLogo(param);
	}

}
