package kr.apfs.local.contents.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.HistorypageDao;
import kr.apfs.local.contents.service.HistorypageService;
import kr.apfs.local.contents.service.HistorypageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @Class Name : HistorypageServiceImpl.java
 * @Description : HistorypageServiceImpl.Class
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

@Service("HistorypageService")
public class HistorypageServiceImpl implements HistorypageService {
	private static final Logger logger = LogManager.getLogger(HistorypageServiceImpl.class);
	
	@Resource(name = "HistorypageDao")
    protected HistorypageDao historypageDao;

	
	
	

	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int selectHistorypageExist(Map<String, Object> param)
			throws Exception {
		return historypageDao.selectHistorypageExist(param);
	}

	
	

	/**
     *  데이터를 가져온다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public List<Map<String, Object>> selectHistorypage(Map<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return historypageDao.selectHistorypage(param);
	}


	/**
     *  데이터를 입력한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertHistorypage(Map<String, Object> param) throws Exception {
		return historypageDao.insertHistorypage(param);
	}


	/**
     *  데이터를 수정한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int updateHistorypage(Map<String, Object> param) throws Exception {
		return historypageDao.updateHistorypage(param);
	}



	/**
     *  데이터를 삭제한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int deleteHistotypage(Map<String, Object> param) throws Exception {
		return historypageDao.deleteHistorypage(param);
	}
	
	



}
