package kr.apfs.local.agrInsClaAdj.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.apfs.local.agrInsClaAdj.dao.AgrInsClaAdjDao;
import kr.apfs.local.common.dao.AbstractDao;

/**
 *  
 * @author Administrator
 *
 */
@Repository("AgrInsClaAdjDao")
public class AgrInsClaAdjDaoImpl extends AbstractDao implements AgrInsClaAdjDao {

	@Override
	public List<Map<String, Object>> selectAgrInsClaAdj(Map<String, Object> param) throws Exception {
		return selectList("AgrInsClaAdjDao.selectAgrInsClaAdj", param);
	}

}
