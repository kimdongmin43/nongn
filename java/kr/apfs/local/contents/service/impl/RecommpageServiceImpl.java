package kr.apfs.local.contents.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.RecommpageDao;
import kr.apfs.local.contents.service.RecommpageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @Class Name : IntropageServiceImpl.java
 * @Description : IntropageServiceImpl.Class
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

@Service("RecommpageService")
public class RecommpageServiceImpl implements RecommpageService {
	private static final Logger logger = LogManager.getLogger(RecommpageServiceImpl.class);

	@Resource(name = "RecommpageDao")
    protected RecommpageDao recommpageDao;

	/**
    * 추천사이트, 유관기관
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectRecommPageList(Map<String, Object> param) throws Exception{
		return recommpageDao.selectRecommPageList(param);
	}

}
