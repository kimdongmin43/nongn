package kr.apfs.local.contents.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.GuidancepageDao;
import kr.apfs.local.contents.service.GuidancepageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @Class Name : GuidancepageServiceImpl.java
 * @Description : GuidancepageServiceImpl.Class
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

@Service("GuidancepageService")
public class GuidancepageServiceImpl implements GuidancepageService {
	private static final Logger logger = LogManager.getLogger(GuidancepageServiceImpl.class);

	@Resource(name = "GuidancepageDao")
    protected GuidancepageDao guidancepageDao;


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */

	@Override
	public Map<String, Object> selectGuidancepage(Map<String, Object> param) throws Exception {
		return guidancepageDao.selectGuidancepage(param);
	}

	@Override
	public List <Map<String, Object>> selectGuidancepage2(Map<String, Object> param) throws Exception {
		return guidancepageDao.selectGuidancepage2(param);
	}




	/**
     * 인사말을 수정한다 온다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int updateGuidancepage(Map<String, Object> param) throws Exception {
		return guidancepageDao.updateGuidancepage(param);
	}

	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int selectGuidancepageExist(Map<String, Object> param) throws Exception {
		return guidancepageDao.selectGuidancepageExist(param);
	}

	/**
     * 값을 입력한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertGuidancepage(Map<String, Object> param) throws Exception {
		return guidancepageDao.insertGuidancepage(param);
	}




}
