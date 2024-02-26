package kr.apfs.local.contents.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.StatutepageDao;
import kr.apfs.local.contents.service.StatutepageService;
import kr.apfs.local.contents.service.StatutepageService;

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
 * @ 2015.05.09           최초생성
 *
 * @author jangcw
 * @since 2016. 06.10
 * @version 1.0
 * @se
 *
 *  Copyright (C) by Intocps All right reserved.
 */

@Service("StatutepageService")
public class StatutepageServiceImpl implements StatutepageService {
	private static final Logger logger = LogManager.getLogger(StatutepageServiceImpl.class);

	@Resource(name = "StatutepageDao")
    protected StatutepageDao statutepageDao;





	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int selectStatutepageExist(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return statutepageDao.selectStatutepageExist(param);
	}




	/**
     * 법령 데이터를 가져온다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public Map<String, Object> selectStatutepage(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return statutepageDao.selectStatutepage(param);
	}

	@Override
	public List <Map<String, Object>> selectStatutepage2(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return statutepageDao.selectStatutepage2(param);
	}


	/**
     * 법령 데이터를 입력한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertStatutepage(Map<String, Object> param) throws Exception {
		return statutepageDao.insertStatutepage(param);
	}


	/**
     * 법령 데이터를 수정한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int updateStatutepage(Map<String, Object> param) throws Exception {
		return statutepageDao.updateStatutepage(param);
	}





}
