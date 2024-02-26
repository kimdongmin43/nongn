package kr.apfs.local.mypage.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : MypageService.java
 * @Description : MypageService.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2017.06.26 최초생성
 *
 * @author sumoon
 * @since 2017. 06.26
 * @version 1.0
 *
 *  Copyright (C) by Intocps All right reserved.
 */
public interface MypageService {



	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */

	public int selectMypageExist(Map<String, Object> param) throws Exception;

	/**
     * 인사말 정보를 가져온다
     * @param param
     * @return
     * @throws Exception
     */
	
	public Map<String, Object> selectExist(Map<String, Object> param) throws Exception;
	
	public Map<String, Object> selectMypage(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectMypage2(Map<String, Object> param) throws Exception;	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertMypage(Map<String, Object> param) throws Exception;

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMypage(Map<String, Object> param) throws Exception;
	
	//손해평가사 정보
	public Map<String, Object> mypageInfo (Map<String, Object> param) throws Exception;	
	public Map<String, Object> selectMonths(Map<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectAreas(Map<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectItems(Map<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectSosokCd(Map<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectProductCd(Map<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectMyProduct(Map<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectMyAreas(Map<String, Object> param) throws Exception;
	
	
	public List<Map<String, Object>> selectMyEduHistory(Map<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectMyEduFuture(Map<String, Object> param) throws Exception;
	

	
	


}
