package kr.apfs.local.contents.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.NormalContentsMenuDao;
import kr.apfs.local.contents.service.NormalContentsMenuService;

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
			  
@Service("NormalContentsMenuService")
public class NormalContentsMenuServiceImpl implements NormalContentsMenuService {
	private static final Logger logger = LogManager.getLogger(NormalContentsMenuServiceImpl.class);

	@Resource(name = "NormalContentsMenuDao")
    protected NormalContentsMenuDao normalContentsMenuDao;

	

	@Override
	public List<Map<String, Object>> selectNormalContentsMenuPageList(
			Map<String, Object> param) throws Exception {
		return normalContentsMenuDao.selectNormalContentsMenuList(param);
	}


//투자조합 결성 그리드 데이터 가저온다
	@Override
	public List<Map<String, Object>> selectInvestGridData(Map<String, Object> param) throws Exception {
		return normalContentsMenuDao.selectInvestGridData(param);
	}

//투자조합 글쓰기 데이터
	@Override
	public Map<String, Object> selectInvestWritePage(Map<String, Object> param)throws Exception {

		return normalContentsMenuDao.selectInvestWritePage(param);
	}


	@Override
	public int investInsert(Map<String, Object> param) throws Exception {
		return normalContentsMenuDao.investInsert(param);
	}


	@Override
	public int investUpdate(Map<String, Object> param) throws Exception {
		return normalContentsMenuDao.investUpdate(param);
	}
	@Override
	public int investDelete(Map<String, Object> param) throws Exception {
		return normalContentsMenuDao.investDelete(param);
	}

}
