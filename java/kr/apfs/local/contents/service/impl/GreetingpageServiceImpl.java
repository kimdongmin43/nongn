package kr.apfs.local.contents.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.GreetingpageDao;
import kr.apfs.local.contents.service.GreetingpageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @Class Name : GreetingpageServiceImpl.java
 * @Description : GreetingpageServiceImpl.Class
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

@Service("GreetingpageService")
public class GreetingpageServiceImpl implements GreetingpageService {
	private static final Logger logger = LogManager.getLogger(GreetingpageServiceImpl.class);
	
	@Resource(name = "GreetingpageDao")
    protected GreetingpageDao greetingpageDao;
	
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	@Override
	public Map<String, Object> selectGreetingpage(Map<String, Object> param) throws Exception{
		return greetingpageDao.selectGreetingpage(param);
	}
	
	@Override
	public List <Map<String, Object>> selectGreetingpage2(Map<String, Object> param) throws Exception{
		return greetingpageDao.selectGreetingpage2(param);
	}

	/**
     * 인사말을 수정한다 온다 
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int updateGreetingpage(Map<String, Object> param) throws Exception {
		return greetingpageDao.updateGreetingpage(param);
	}

	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int selectGreetingpageExist(Map<String, Object> param) throws Exception {		
		return greetingpageDao.selectGreetingpageExist(param);
	}

	/**
     * 값을 입력한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertGreetingpage(Map<String, Object> param) throws Exception {
		return greetingpageDao.insertGreetingpage(param);
	}
	


}
