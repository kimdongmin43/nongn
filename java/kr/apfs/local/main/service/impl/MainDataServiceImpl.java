package kr.apfs.local.main.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.main.dao.MainDataDao;
import kr.apfs.local.main.service.MainDataService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @Class Name : MainDataServiceImpl.java
 * @Description : MainDataServiceImpl.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2015.05.09           최초생성
 *
 * @author kkh
 * @since 2016. 06.10
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Intocps All right reserved.
 */

@Service("MainDataService")
public class MainDataServiceImpl implements MainDataService {
	private static final Logger logger = LogManager.getLogger(MainDataServiceImpl.class);

	@Resource(name = "MainDataDao")
    protected MainDataDao mainDataDao;

	/**
     * E-Contents
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEContentsList(Map<String, Object> param) throws Exception{
		return mainDataDao.selectEContentsList(param);
	}

	/**
     * 경제지표
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectProspectList(Map<String, Object> param) throws Exception{
		return mainDataDao.selectProspectList(param);
	}

	/**
     * 온라인세미나
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectSeminarList(Map<String, Object> param) throws Exception{
		return mainDataDao.selectSeminarList(param);
	}

}
