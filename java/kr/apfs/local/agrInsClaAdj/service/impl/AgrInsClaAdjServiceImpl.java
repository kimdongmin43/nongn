package kr.apfs.local.agrInsClaAdj.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.agrInsClaAdj.dao.AgrInsClaAdjDao;
import kr.apfs.local.agrInsClaAdj.service.AgrInsClaAdjService;

import org.springframework.stereotype.Service;

@Service("AgrInsClaAdjService")
public class AgrInsClaAdjServiceImpl implements AgrInsClaAdjService {

	@Resource(name="AgrInsClaAdjDao")
	protected AgrInsClaAdjDao agrInsClaAdjDao;
	
	@Override
	public List<Map<String, Object>> selectAgrInsClaAdj(Map<String, Object> param) throws Exception {
		return agrInsClaAdjDao.selectAgrInsClaAdj(param);
	}

}
