package kr.apfs.local.member.dao.impl;

import java.util.List;
import java.util.Map;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.member.dao.MemberpageDao;

import org.springframework.stereotype.Repository;

@Repository("MemberpageDao")
public class MemberpageDaoImpl extends AbstractDao implements MemberpageDao {

	@Override
	public int selectMemberpageExist(Map<String, Object> param) throws Exception {
		//System.out.println("푸터진입");
		return selectOne("memberpageDao.selectMemberpageExist", param);
	}

	@Override
	public Map<String, Object> selectMemberpage(Map<String, Object> param) throws Exception {
		return selectOne("memberpageDao.selectMember", param);
	}

	@Override
	public int insertMemberpage(Map<String, Object> param) throws Exception {
		return insert("memberpageDao.insertMemberpage", param);
	}

	@Override
	public int updateMemberpage(Map<String, Object> param) throws Exception {
		return update("memberpageDao.updateMemberpage", param);
	}

	@Override
	public List<Map<String, Object>> selectMemberList(Map<String, Object> param) throws Exception {

		return selectList("memberpageDao.selectMemberList", param);
	}

	@Override
	public List<Map<String, Object>> selectSiteList(Map<String, Object> param) throws Exception {
		return selectList("memberpageDao.selectSiteList", param);		
	}

	@Override
	public int deleteMemberpage(Map<String, Object> param) throws Exception {
		return delete("memberpageDao.deleteMemberpage", param);
	}
	
	
	/**
     * 멤버승인을 한다
     * @param 	param
     * @return 	List
     * @throws 	Exception
     */
	@Override
	public int updateMemberPass(String memberId) throws Exception {
		return update("memberpageDao.updateMemberPass", memberId);
	}

	@Override
	public Map<String, Object> login(Map<String, Object> param) throws Exception {
		return selectOne("memberpageDao.login", param);
	}

}
