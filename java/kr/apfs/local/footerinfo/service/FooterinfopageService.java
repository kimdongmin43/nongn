package kr.apfs.local.footerinfo.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : FooterinfopageService.java
 * @Description : FooterinfopageService.Class
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
public interface FooterinfopageService {		
	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */	
	public int selectFooterinfopageExist(Map<String, Object> param) throws Exception;
 
	/**
     * 하단 정보를 가져온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectFooterinfopage(Map<String, Object> param) throws Exception;
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertFooterinfopage(Map<String, Object> param) throws Exception;
		
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateFooterinfopage(Map<String, Object> param) throws Exception;
	
	
	
}
