package kr.apfs.local.contents.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.VisionpageDao;
import kr.apfs.local.contents.service.VisionpageService;

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

@Service("VisionpageService")
public class VisionpageServiceImpl implements VisionpageService {
	private static final Logger logger = LogManager.getLogger(VisionpageServiceImpl.class);

	@Resource(name = "VisionpageDao")
    protected VisionpageDao visionpageDao;


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	@Override
	public Map<String, Object> selectVisionpage(Map<String, Object> param) throws Exception{
		return visionpageDao.selectVisionpage(param);
	}

	@Override
	public List <Map<String, Object>> selectVisionpage2(Map<String, Object> param) throws Exception{
		return null;//visionpageDao.selectVisionpage(param);
	}

	/**
     * 인사말을 수정한다 온다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int updateVisionpage(Map<String, Object> param) throws Exception {
		return visionpageDao.updateVisionpage(param);
	}

	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int selectVisionpageExist(Map<String, Object> param) throws Exception {
		return visionpageDao.selectVisionpageExist(param);
	}

	/**
     * 값을 입력한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertVisionpage(Map<String, Object> param) throws Exception {
		return visionpageDao.insertVisionpage(param);
	}



}
