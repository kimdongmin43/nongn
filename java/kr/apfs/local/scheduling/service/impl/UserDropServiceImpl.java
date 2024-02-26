package kr.apfs.local.scheduling.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

import kr.apfs.local.scheduling.dao.UserDropDao;
import kr.apfs.local.scheduling.service.UserDropService;

@Service("UserDropService")
public class UserDropServiceImpl implements UserDropService {
	private static final Logger logger = LogManager.getLogger(UserDropServiceImpl.class);
	
	@Resource(name = "UserDropDao")
    protected UserDropDao userDropDao;
	
	public void userAutoDropOut() throws Exception{
		userDropDao.userAutoDropOut();
	}
	
	public void userAutoDropOut2(Map<String, Object> param) throws Exception{
		userDropDao.userAutoDropOut2(param);
	}
}