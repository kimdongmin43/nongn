package kr.apfs.local.contents.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.IntropageDao;
import kr.apfs.local.contents.service.IntropageService;

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

@Service("IntropageService")
public class IntropageServiceImpl implements IntropageService {
	private static final Logger logger = LogManager.getLogger(IntropageServiceImpl.class);

	@Resource(name = "IntropageDao")
    protected IntropageDao intropageDao;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectIntropagePageList(Map<String, Object> param) throws Exception{
		return intropageDao.selectIntropagePageList(param);
	}

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectIntropageList(Map<String, Object> param) throws Exception{
		return intropageDao.selectIntropageList(param);
	}

	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectIntropage(Map<String, Object> param) throws Exception{
		return intropageDao.selectIntropage(param);
	}


	public List <Map<String, Object>> selectIntropage2(Map<String, Object> param) throws Exception{
		return intropageDao.selectIntropage2(param);
	}
	
	public List<Map<String, Object>> selectDisclosurePage(Map<String, Object> param) throws Exception{
		return intropageDao.selectDisclosurePage(param);
	}
	
	public List<Map<String, Object>> selectDisclosurePage_section(Map<String, Object> param) throws Exception{
		return intropageDao.selectDisclosurePage_section(param);
	}
	
	public List<Map<String, Object>> selectDisclosurePage_sectionNm(Map<String, Object> param) throws Exception{
		return intropageDao.selectDisclosurePage_sectionNm(param);
	}
	
	public List<HashMap> selectDisclosureCodeList(Map<String, Object> param) throws Exception{
		return intropageDao.selectDisclosureCodeList(param);
	}
	
	
	public Map<String, Object> selectDisclosurePageback(Map<String, Object> param) throws Exception{
		return intropageDao.selectDisclosurePageback(param);
	}

	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectIntropageExist(Map<String, Object> param) throws Exception {
		return intropageDao.selectIntropageExist(param);
	}

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertIntropage(Map<String, Object> param) throws Exception{
		return intropageDao.insertIntropage(param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateIntropage(Map<String, Object> param) throws Exception{
		return intropageDao.updateIntropage(param);
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteIntropage(Map<String, Object> param) throws Exception{
		return intropageDao.deleteIntropage(param);
	}

	
	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertDisclosure(Map<String, Object> param) throws Exception{
		return intropageDao.insertDisclosure(param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateDisclosure(Map<String, Object> param) throws Exception{
		return intropageDao.updateDisclosure(param);
	}

	
	@Override
	public Map<String, Object> selectIntropageFront(Map<String, Object> param)
			throws Exception {
		return intropageDao.selectIntropageFront(param);
	}

	/**
    * 무역용어사전
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectIncotermsPageList(Map<String, Object> param) throws Exception{
		return intropageDao.selectIncotermsPageList(param);
	}

}
