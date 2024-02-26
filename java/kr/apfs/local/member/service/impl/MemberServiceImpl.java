package kr.apfs.local.member.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.member.dao.MemberDao;

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

@Service("MemberService")
public class MemberServiceImpl implements kr.apfs.local.member.service.MemberService {

	private static final Logger logger = LogManager.getLogger(MemberServiceImpl.class);

	@Resource(name = "MemberDao")
    protected MemberDao memberDao;

	/**
     * 사업자번호를 이용하여 구상공회의 회원유형을 가져온다.
     * 7년내 기납 회원일 경우 'A'
	 * 7년내 미납 회원일 경우 'B'
	 * 7년전 회원이거나 비회원일 경우 'C'
     * @param param
     * @return
     * @throws Exception
     */

	public List<Map<String,Object>> selectMemberCode(Map<String, Object> param) throws Exception{
		return memberDao.selectMemberCode(param);
	}


}
