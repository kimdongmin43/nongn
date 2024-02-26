package kr.apfs.local.contents.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.CeopageDao;
import kr.apfs.local.contents.service.CeopageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @Class Name : CeopageServiceImpl.java
 * @Description : CeopageServiceImpl.Class
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

@Service("CeopageService")
public class CeopageServiceImpl implements CeopageService {
	private static final Logger logger = LogManager.getLogger(CeopageServiceImpl.class);
	
	@Resource(name = "CeopageDao")
    protected CeopageDao ceopageDao;
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectCeopagePageList(Map<String, Object> param) throws Exception{
		return ceopageDao.selectCeopagePageList(param);
	}
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectCeopageList(Map<String, Object> param) throws Exception{
		return ceopageDao.selectCeopageList(param);
	}
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectCeopage(Map<String, Object> param) throws Exception{
		return ceopageDao.selectCeopage(param);
	}
	
	public List <Map<String, Object>> selectCeopage2(Map<String, Object> param) throws Exception{
		return ceopageDao.selectCeopage2(param);
	}
	
	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	@Override
	public int selectCeopageExist(Map<String, Object> param) throws Exception {
		return ceopageDao.selectCeopageExist(param);
	}
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertCeopage(Map<String, Object> param) throws Exception{
		return ceopageDao.insertCeopage(param);
	}
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateCeopage(Map<String, Object> param) throws Exception{
		return ceopageDao.updateCeopage(param);
	}
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deleteCeopage(Map<String, Object> param) throws Exception{
		return ceopageDao.deleteCeopage(param);
	}

	
	/**
     * 출력순서를 변경한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	@Override
	public int updateCeopageSort(Map<String, Object> param) throws Exception {
		return ceopageDao.updateCeopageSort(param);
	}
}
