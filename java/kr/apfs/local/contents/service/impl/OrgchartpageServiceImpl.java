package kr.apfs.local.contents.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.OrgchartpageDao;
import kr.apfs.local.contents.service.OrgchartpageService;
import kr.apfs.local.contents.service.OrgchartpageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @Class Name : OrgchartpageServiceImpl.java
 * @Description : OrgchartpageServiceImpl.Class
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

@Service("OrgchartpageService")
public class OrgchartpageServiceImpl implements OrgchartpageService {
	private static final Logger logger = LogManager.getLogger(OrgchartpageServiceImpl.class);

	@Resource(name = "OrgchartpageDao")
    protected OrgchartpageDao orgchartpageDao;


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	@Override
	public Map<String, Object> selectOrgchartpage(Map<String, Object> param) throws Exception{
		return orgchartpageDao.selectOrgchartpage(param);
	}

	public Map<String, Object> selectIndicatorsback(Map<String, Object> param) throws Exception{
		return orgchartpageDao.selectIndicatorsback(param);
	}


	@Override
	public List <Map<String, Object>> selectOrgchartpage2(Map<String, Object> param) throws Exception{
		return orgchartpageDao.selectOrgchartpage2(param);
	}
	@Override
	public List <Map<String, Object>> selectOrgchartAll(Map<String, Object> param) throws Exception{
		return orgchartpageDao.selectOrgchartAll(param);
	}

	@Override
	public List <Map<String, Object>> selectchart1(Map<String, Object> param) throws Exception{
		return orgchartpageDao.selectchart1(param);
	}
	@Override
	public List <Map<String, Object>> selectchart2(Map<String, Object> param) throws Exception{
		return orgchartpageDao.selectchart2(param);
	}
	@Override
	public List <Map<String, Object>> selectchart3(Map<String, Object> param) throws Exception{
		return orgchartpageDao.selectchart3(param);
	}
	@Override
	public List <Map<String, Object>> selectchart4(Map<String, Object> param) throws Exception{
		return orgchartpageDao.selectchart4(param);
	}
	@Override
	public List <Map<String, Object>> selectchart5(Map<String, Object> param) throws Exception{
		return orgchartpageDao.selectchart5(param);
	}
	@Override
	public List <Map<String, Object>> selectchart6(Map<String, Object> param) throws Exception{
		return orgchartpageDao.selectchart6(param);
	}

	@Override
	public List <Map<String, Object>> selectchartcode(Map<String, Object> param) throws Exception{
		return orgchartpageDao.selectchartcode(param);
	}
	@Override
	public List <Map<String, Object>> selectchartdn(Map<String, Object> param) throws Exception{
		return orgchartpageDao.selectchartdn(param);
	}
	@Override
	public List <Map<String, Object>> selectIndicators(Map<String, Object> param) throws Exception{
		return orgchartpageDao.selectIndicators(param);
	}


	/**
     * 인사말을 수정한다 온다
     * @param param
     * @return int
     * @throws Exception
     */

	@Override
	public int insertIndicators(Map<String, Object> param) throws Exception {
		return orgchartpageDao.insertIndicators(param);
	}

	@Override
	public int updateIndicators(Map<String, Object> param) throws Exception {
		return orgchartpageDao.updateIndicators(param);
	}
	
	@Override
	public int deleteIndicators(Map<String, Object> param) throws Exception {
		return orgchartpageDao.deleteIndicators(param);
	}


	@Override
	public int updateOrgchartpage(Map<String, Object> param) throws Exception {
		return orgchartpageDao.updateOrgchartpage(param);
	}

	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int selectOrgchartpageExist(Map<String, Object> param) throws Exception {
		return orgchartpageDao.selectOrgchartpageExist(param);
	}

	/**
     * 값을 입력한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertOrgchartpage(Map<String, Object> param) throws Exception {
		return orgchartpageDao.insertOrgchartpage(param);
	}



}
