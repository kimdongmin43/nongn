package kr.apfs.local.contents.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : HistorypageService.java
 * @Description : HistorypageService.Class
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
public interface HistorypageService {		
	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */	
	public int selectHistorypageExist(Map<String, Object> param) throws Exception;
 
	/**
     * 법령 정보를 가져온다
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectHistorypage(Map<String, Object> param) throws Exception;
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertHistorypage(Map<String, Object> param) throws Exception;
		
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateHistorypage(Map<String, Object> param) throws Exception;
	
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	
	public int deleteHistotypage(Map<String, Object> param) throws Exception;
	
	
	
	
	
	
	
	
	
}
