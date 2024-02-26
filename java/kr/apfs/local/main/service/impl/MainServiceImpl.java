package kr.apfs.local.main.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.apfs.local.main.dao.MainDao;
import kr.apfs.local.main.service.MainService;

/**
 * @Class Name : MainServiceImpl.java
 * @Description : MainServiceImpl.Class
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

@Service("MainService")
public class MainServiceImpl implements MainService {
	private static final Logger logger = LogManager.getLogger(MainServiceImpl.class);

	@Resource(name = "MainDao")
    protected MainDao mainDao;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMainList(Map<String, Object> param) throws Exception{
		return mainDao.selectMainList(param);
	}

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertMain(Map<String, Object> param) throws Exception{
		return mainDao.insertMain(param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMain(Map<String, Object> param) throws Exception{
		return mainDao.updateMain(param);
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteMain(Map<String, Object> param) throws Exception{
		return mainDao.deleteMain(param);
	}


	/**
    *
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectSearchContents(Map<String, Object> param) throws Exception{
		return mainDao.selectSearchContents(param);
	}
	public List<Map<String, Object>> selectSearchList(Map<String, Object> param) throws Exception{
		return mainDao.selectSearchList(param);
	}
}
