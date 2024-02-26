package kr.apfs.local.code.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : CodeService.java
 * @Description : CodeService.Class
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
public interface CodeService {
 

	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectCodemasterPageList(Map<String, Object> param) throws Exception;
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectCodemasterList(Map<String, Object> param) throws Exception;
	
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectCodemaster(Map<String, Object> param) throws Exception;
	
	
	/**
     * 중복 여부를 체크한다
     * @param param
     * @return
     * @throws Exception
     */
	public int selectCodemasterExist(Map<String, Object> param) throws Exception;
	
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertCodemaster(Map<String, Object> param) throws Exception;
		
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateCodemaster(Map<String, Object> param) throws Exception;
	
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deleteCodemaster(Map<String, Object> param) throws Exception;

	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectCodeList(Map<String, Object> param) throws Exception;
	
 	/**
     *  코드구분의 코드 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCodeMasterCodeList(String param) throws Exception;
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectCode(Map<String, Object> param) throws Exception;
	
	
	/**
     * 중복 여부를 체크한다
     * @param param
     * @return
     * @throws Exception
     */
	public int selectCodeExist(Map<String, Object> param) throws Exception;
	
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertCode(Map<String, Object> param) throws Exception;
		
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateCode(Map<String, Object> param) throws Exception;
	
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deleteCode(Map<String, Object> param) throws Exception;

	/**
     * 코드 순서조정 정보를 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateCodeReorder(Map<String, Object> param) throws Exception;
}
