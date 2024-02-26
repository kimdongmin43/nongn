package kr.apfs.local.member.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.member.dao.MemberpageDao;
import kr.apfs.local.member.service.MemberpageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;
/**
 * @Class Name : StatutepageServiceImpl.java
 * @Description : StatutepageServiceImpl.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2017.07.03           최초생성
 *
 * @author msu
 * @since 2017.07.03
 * @version 1.0
 * @se
 *
 *  Copyright (C) by Intocps All right reserved.
 */

@Service("MemberpageService")
public class MemberpageServiceImpl implements MemberpageService {
	private static final Logger logger = LogManager.getLogger(MemberpageServiceImpl.class);

	@Resource(name = "MemberpageDao")
    protected MemberpageDao MemberpageDao;


	@Override
	public int selectMemberpageExist(Map<String, Object> param)	throws Exception {
		return MemberpageDao.selectMemberpageExist(param);
	}

	@Override
	public Map<String, Object> selectMemberpage(Map<String, Object> param) throws Exception {
		return MemberpageDao.selectMemberpage(param);
	}

	@Override
	public int insertMemberpage(Map<String, Object> param) throws Exception {
		return MemberpageDao.insertMemberpage(param);
	}

	@Override
	public int updateMemberpage(Map<String, Object> param) throws Exception {
				return MemberpageDao.updateMemberpage(param);
	}

	@Override
	public List<Map<String, Object>> selectMemberList (Map<String, Object> param) throws Exception {
		return MemberpageDao.selectMemberList(param);
	}

	@Override
	public List<Map<String, Object>> selectSiteList(Map<String, Object> param) throws Exception{
		return MemberpageDao.selectSiteList(param);
	}

	@Override
	public int deleteMemberpage(Map<String, Object> param) throws Exception {
		return MemberpageDao.deleteMemberpage(param);
	}

	

	/**
     * 멤버 승인을 한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	@Override
	public int updateMemberPass(String memberId) throws Exception {
		return MemberpageDao.updateMemberPass(memberId);
	}

	@Override
	public Map<String, Object> login(Map<String, Object> param) throws Exception {
		return MemberpageDao.login(param);
	}



}
