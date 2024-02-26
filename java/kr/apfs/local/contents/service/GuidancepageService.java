package kr.apfs.local.contents.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : GuidancepageService.java
 * @Description : GuidancepageService.Class
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
public interface GuidancepageService {
	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */
	public int selectGuidancepageExist(Map<String, Object> param) throws Exception;

	/**
     * 안내 정보를 가져온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectGuidancepage(Map<String, Object> param) throws Exception;


	public List<Map<String, Object>> selectGuidancepage2(Map<String, Object> param) throws Exception;
	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertGuidancepage(Map<String, Object> param) throws Exception;

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateGuidancepage(Map<String, Object> param) throws Exception;





}
