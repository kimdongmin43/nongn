package kr.apfs.local.main.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.apfs.local.main.dao.MainBoardDao;
import kr.apfs.local.main.service.MainBoardService;

/**
 * @Class Name : MainBoardServiceImpl.java
 * @Description : MainBoardServiceImpl.Class
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

@Service("MainBoardService")
public class MainBoardServiceImpl implements MainBoardService {
	private static final Logger logger = LogManager.getLogger(MainBoardServiceImpl.class);

	@Resource(name = "MainBoardDao")
    protected MainBoardDao mainBoardDao;

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectBoardList(Map<String, Object> param) throws Exception{
		return mainBoardDao.selectBoardList(param);
	}

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectMainPhotoList(Map<String, Object> param) throws Exception{
		return mainBoardDao.selectMainPhotoList(param);
	}

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectMainEventList(Map<String, Object> param) throws Exception{
		return mainBoardDao.selectMainEventList(param);
	}

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMainBoardList(Map<String, Object> param) throws Exception{
		return mainBoardDao.selectMainBoardList(param);
	}

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectMainBoardContentsList(Map<String, Object> param) throws Exception{
		return mainBoardDao.selectMainBoardContentsList(param);
	}
	
	
	public List<Map<String, Object>> selectMainBoardContentsList2(Map<String, Object> param) throws Exception{
		return mainBoardDao.selectMainBoardContentsList2(param);
	}
	

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertMainBoard(Map<String, Object> param) throws Exception{
		return mainBoardDao.insertMainBoard(param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMainBoard(Map<String, Object> param) throws Exception{
		return mainBoardDao.updateMainBoard(param);
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteMainBoard(Map<String, Object> param) throws Exception{
		return mainBoardDao.deleteMainBoard(param);
	}

}
