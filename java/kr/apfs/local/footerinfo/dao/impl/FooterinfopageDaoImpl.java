package kr.apfs.local.footerinfo.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.footerinfo.dao.FooterinfopageDao;

@Repository("FooterinfopageDao")
public class FooterinfopageDaoImpl extends AbstractDao implements FooterinfopageDao {

	@Override
	public int selectFooterinfopageExist(Map<String, Object> param) throws Exception {
		//System.out.println("푸터진입");
		return selectOne("FooterinfopageDao.selectFooterpageinfoExist", param);
	}

	@Override
	public Map<String, Object> selectFooterinfopage(Map<String, Object> param) throws Exception {
		return selectOne("FooterinfopageDao.selectFooterinfopage", param);
	}

	@Override
	public int insertFooterinfopage(Map<String, Object> param) throws Exception {
		return insert("FooterinfopageDao.insertFooterinfopage", param);
	}

	@Override
	public int updateFooterinfopage(Map<String, Object> param) throws Exception {
		return update("FooterinfopageDao.updateFooterinfopage", param);
	}

}
