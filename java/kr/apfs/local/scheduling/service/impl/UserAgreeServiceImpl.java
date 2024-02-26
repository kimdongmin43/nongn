package kr.apfs.local.scheduling.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

import kr.apfs.local.scheduling.dao.UserAgreeDao;
import kr.apfs.local.scheduling.service.UserAgreeService;

@Service("UserAgreeService")
public class UserAgreeServiceImpl implements UserAgreeService {
	private static final Logger logger = LogManager.getLogger(UserAgreeServiceImpl.class);
	
	@Resource(name = "UserAgreeDao")
    protected UserAgreeDao userAgreeDao;
	
	/**
     * 동의후 23개월(700일)인 사용자들
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectUserAgreeList(Map<String, Object> param) throws Exception{
		return userAgreeDao.selectUserAgreeList(param);
	}
	
	/**
     * 로그인 접속이 11개월이 지난 사용자들
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectUserLoginList(Map<String, Object> param) throws Exception{
		return userAgreeDao.selectUserLoginList(param);
	}
}