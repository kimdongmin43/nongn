package kr.apfs.local.member.dao;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : MemberpageService.java
 * @Description : MemberpageService.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2017.06.28 최초생성
 *
 * @author moonsu
 * @since 2017. 06.28
 * @version 1.0
 *
 *  Copyright (C) by Intocps All right reserved.
 */
public interface MemberpageDao {		
	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */	
	public int selectMemberpageExist(Map<String, Object> param) throws Exception;
 
	/**
     * 하단 정보를 가져온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectMemberpage(Map<String, Object> param) throws Exception;
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertMemberpage(Map<String, Object> param) throws Exception;
		
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateMemberpage(Map<String, Object> param) throws Exception;

	
	/**
     * 맴버리스트를 가저온다 
     * @param 	param
     * @return 	List
     * @throws 	Exception
     */	
	public List<Map<String, Object>> selectMemberList(Map<String, Object> param) throws Exception;
	
	
	/**
     * 지역리스트를 가저온다 
     * @param 	param
     * @return 	List
     * @throws 	Exception
     */	
	public List<Map<String, Object>> selectSiteList(Map<String, Object> param) throws Exception;
	
	/**
     * 지역리스트를 가저온다 
     * @param 	param
     * @return 	List
     * @throws 	Exception
     */
	public int deleteMemberpage(Map<String, Object> param) throws Exception;
	
	/**
     * 멤버승인을한다 
     * @param 	String
     * @return 	int
     * @throws 	Exception
     */
	public int updateMemberPass(String memberId)throws Exception;

	public Map<String, Object> login(Map<String, Object> param)throws Exception;
	
	
}
