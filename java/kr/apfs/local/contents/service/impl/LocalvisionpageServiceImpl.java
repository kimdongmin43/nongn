package kr.apfs.local.contents.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.LocalvisionpageDao;
import kr.apfs.local.contents.service.LocalvisionpageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @Class Name : VisionpageServiceImpl.java
 * @Description : VisionpageServiceImpl.Class
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

@Service("LocalvisionpageService")
public class LocalvisionpageServiceImpl implements LocalvisionpageService {
	private static final Logger logger = LogManager.getLogger(LocalvisionpageServiceImpl.class);

	@Resource(name = "LocalvisionpageDao")
    protected LocalvisionpageDao localvisionpageDao;


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	@Override
	public Map<String, Object> selectLocalvisionpage(Map<String, Object> param) throws Exception{
		return localvisionpageDao.selectLocalvisionpage(param);
	}

	@Override
	public List <Map<String, Object>> selectLocalvisionpage2(Map<String, Object> param) throws Exception{
		return localvisionpageDao.selectLocalvisionpage2(param);
	}



	/**
     * 인사말을 수정한다 온다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int updateLocalvisionpage(Map<String, Object> param) throws Exception {
		return localvisionpageDao.updateLocalvisionpage(param);
	}

	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int selectLocalvisionpageExist(Map<String, Object> param) throws Exception {
		return localvisionpageDao.selectLocalvisionpageExist(param);
	}

	/**
     * 값을 입력한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertLocalvisionpage(Map<String, Object> param) throws Exception {
		return localvisionpageDao.insertLocalvisionpage(param);
	}

	@Override
	public int insertMastervisionpage(Map<String, Object> param) throws Exception {
		return localvisionpageDao.insertMasterVision(param);
	}

	@Override
	public int updateMastervisionpage(Map<String, Object> param) throws Exception {
		return localvisionpageDao.updateMasterVision(param);
	}

	@Override
	public Map<String, Object> selectMasterVisionpage(Map<String, Object> param)throws Exception {
		return localvisionpageDao.selectMasterVision(param);
	}



}
