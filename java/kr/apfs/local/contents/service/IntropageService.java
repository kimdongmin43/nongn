package kr.apfs.local.contents.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Class Name : IntropageService.java
 * @Description : IntropageService.Class
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
public interface IntropageService {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectIntropagePageList(Map<String, Object> param) throws Exception;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectIntropageList(Map<String, Object> param) throws Exception;


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectIntropage(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectIntropage2(Map<String, Object> param) throws Exception;

	/**
     * 중복 여부를 체크한다
     * @param param
     * @return
     * @throws Exception
     */
	public int selectIntropageExist(Map<String, Object> param) throws Exception;


	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertIntropage(Map<String, Object> param) throws Exception;


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateIntropage(Map<String, Object> param) throws Exception;


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteIntropage(Map<String, Object> param) throws Exception;


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectIntropageFront(Map<String, Object> param) throws Exception;

	/**
    * 무역용어사전
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectIncotermsPageList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectDisclosurePage(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectDisclosurePage_section(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> selectDisclosurePage_sectionNm(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectDisclosurePageback(Map<String, Object> param) throws Exception;

	public int insertDisclosure(Map<String, Object> param) throws Exception;

	public int updateDisclosure(Map<String, Object> param) throws Exception;

	public List<HashMap> selectDisclosureCodeList(Map<String, Object> param) throws Exception;

}
