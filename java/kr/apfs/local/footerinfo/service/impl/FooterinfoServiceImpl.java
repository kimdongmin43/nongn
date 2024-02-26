package kr.apfs.local.footerinfo.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.footerinfo.dao.FooterinfopageDao;
import kr.apfs.local.footerinfo.service.FooterinfopageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;
/**
 * @Class Name : StatutepageServiceImpl.java
 * @Description : StatutepageServiceImpl.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2017.07.03           최초생성
 *
 * @author msu
 * @since 2017.07.03
 * @version 1.0
 * @se
 *
 *  Copyright (C) by Intocps All right reserved.
 */

@Service("FooterinfopageService")
public class FooterinfoServiceImpl implements FooterinfopageService {
	private static final Logger logger = LogManager.getLogger(FooterinfoServiceImpl.class);
	
	@Resource(name = "FooterinfopageDao")
    protected FooterinfopageDao footerinfopageDao;
	
	@Override
	public int selectFooterinfopageExist(Map<String, Object> param)	throws Exception {		
		return footerinfopageDao.selectFooterinfopageExist(param);
	}

	@Override
	public Map<String, Object> selectFooterinfopage(Map<String, Object> param) throws Exception {
		return footerinfopageDao.selectFooterinfopage(param);
	}

	@Override
	public int insertFooterinfopage(Map<String, Object> param) throws Exception {
		return footerinfopageDao.insertFooterinfopage(param);
	}

	@Override
	public int updateFooterinfopage(Map<String, Object> param) throws Exception {
				return footerinfopageDao.updateFooterinfopage(param);
	}
	

}
