package kr.apfs.local.member.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : MemberService.java
 * @Description : MemberService.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2015.05.10           최초생성
 *
 * @author jangcw
 * @since 2016. 06.10
 * @version 1.0
 *
 *  Copyright (C) by Intocps All right reserved.
 */
public interface MemberService {


	/**
     * 사업자번호를 이용하여 구상공회의 회원유형을 가져온다.
     * 7년내 기납 회원일 경우 'A'
	 * 7년내 미납 회원일 경우 'B'
	 * 7년전 회원이거나 비회원일 경우 'C'
     * @param param
     * @return
     * @throws Exception
     */

	public List<Map<String,Object>> selectMemberCode(Map<String, Object> param) throws Exception;

}
