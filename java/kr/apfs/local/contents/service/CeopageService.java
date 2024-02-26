package kr.apfs.local.contents.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : CeopageService.java
 * @Description : CeopageService.Class
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
public interface CeopageService {
 
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectCeopagePageList(Map<String, Object> param) throws Exception;
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectCeopageList(Map<String, Object> param) throws Exception;
	
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectCeopage(Map<String, Object> param) throws Exception;
	
	
	public List<Map<String, Object>> selectCeopage2(Map<String, Object> param) throws Exception;
	
	
	
	/**
     * 중복 여부를 체크한다
     * @param param
     * @return
     * @throws Exception
     */
	public int selectCeopageExist(Map<String, Object> param) throws Exception;
	
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertCeopage(Map<String, Object> param) throws Exception;
		
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateCeopage(Map<String, Object> param) throws Exception;
	
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deleteCeopage(Map<String, Object> param) throws Exception;
	
	/**
     * 출력 순서를 저장한다. 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateCeopageSort(Map<String, Object> param) throws Exception;


}
