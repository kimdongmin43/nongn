package kr.apfs.local.contents.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.LocationpageDao;
import kr.apfs.local.contents.service.LocationpageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @Class Name : LocationpageServiceImpl.java
 * @Description : LocationpageServiceImpl.Class
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

@Service("LocationpageService")
public class LocationpageServiceImpl implements LocationpageService {
	private static final Logger logger = LogManager.getLogger(LocationpageServiceImpl.class);

	@Resource(name = "LocationpageDao")
    protected LocationpageDao locationpageDao;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectLocationpagePageList(Map<String, Object> param) throws Exception{
		return locationpageDao.selectLocationpagePageList(param);
	}

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectLocationpageList(Map<String, Object> param) throws Exception{
		return locationpageDao.selectLocationpageList(param);
	}

	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectLocationpage(Map<String, Object> param) throws Exception{
		return locationpageDao.selectLocationpage(param);
	}

	public List <Map<String, Object>> selectLocationpage2(Map<String, Object> param) throws Exception{
		return locationpageDao.selectLocationpage2(param);
	}

	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectLocationpageExist(Map<String, Object> param) throws Exception {
		return locationpageDao.selectLocationpageExist(param);
	}

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertLocationpage(Map<String, Object> param) throws Exception{
		return locationpageDao.insertLocationpage(param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateLocationpage(Map<String, Object> param) throws Exception{
		return locationpageDao.updateLocationpage(param);
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteLocationpage(Map<String, Object> param) throws Exception{
		return locationpageDao.deleteLocationpage(param);
	}
}
