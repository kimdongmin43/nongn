package kr.apfs.local.popnoti.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : PopnotiService.java
 * @Description : PopnotiService.Class
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
public interface PopnotiService {
 
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectPopnotiPageList(Map<String, Object> param) throws Exception;
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectPopnotiList(Map<String, Object> param) throws Exception;
	
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectPopnoti(Map<String, Object> param) throws Exception;
	
	
	/**
     * 중복 여부를 체크한다
     * @param param
     * @return
     * @throws Exception
     */
	public int selectPopnotiExist(Map<String, Object> param) throws Exception;
	
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertPopnoti(Map<String, Object> param) throws Exception;
		
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updatePopnoti(Map<String, Object> param) throws Exception;
	
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deletePopnoti(Map<String, Object> param) throws Exception;
	
	/**
     * 메인페이지 팝업 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMainPopnotiList(Map<String, Object> param) throws Exception;

}
