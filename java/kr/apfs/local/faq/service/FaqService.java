package kr.apfs.local.faq.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : FaqService.java
 * @Description : FaqService.Class
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
public interface FaqService {
 
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectFaqPageList(Map<String, Object> param) throws Exception;
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectFaqList(Map<String, Object> param) throws Exception;
	
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectFaq(Map<String, Object> param) throws Exception;
	
	
	/**
     * 중복 여부를 체크한다
     * @param param
     * @return
     * @throws Exception
     */
	public int selectFaqExist(Map<String, Object> param) throws Exception;
	
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertFaq(Map<String, Object> param) throws Exception;
		
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateFaq(Map<String, Object> param) throws Exception;
	
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deleteFaq(Map<String, Object> param) throws Exception;

	/**
     * faq 순서조정 정보를 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateFaqReorder(Map<String, Object> param) throws Exception;
	
	/**
     * 게시판 메인 출력용 게시물
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectLoadMainFaq(Map<String, Object> param) throws Exception;
}
