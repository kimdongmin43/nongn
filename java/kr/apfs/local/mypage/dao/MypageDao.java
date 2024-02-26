/**
 * @Class Name : IntropageDao.java
 * @Description : IntropageDao.Class
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
 
package kr.apfs.local.mypage.dao;

import java.util.List;
import java.util.Map;


public interface MypageDao {
	
		
	/**
     * 인사말을 가져온다
     * @param param
     * @return
     * @throws Exception
     */
    
     /*public Map<String, Object> selectMypage(Map<String, Object> param) throws Exception;*/
     public Map<String, Object> selectMypage(Map<String, Object> param) throws Exception;
     	
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMypage(Map<String, Object> param) throws Exception;

	/**
     * 중복 체크를 한다 
     * @param param
     * @return int
     * @throws Exception
     */
    
	public int selectMypageExist(Map<String, Object> param) throws Exception;
     
 	/**
      * 중복 체크를 한다 
      * @param param
      * @return int
      * @throws Exception
      */

	public int insertMypage(Map<String, Object> param) throws Exception;


	public Map<String, Object> selectExist(Map<String, Object> param) throws Exception;
	public Map<String, Object> mypageInfo(Map<String, Object> param)throws Exception;
	public Map<String, Object> selectMonths(Map<String, Object> param)throws Exception;
	public List<Map<String, Object>> selectAreas(Map<String, Object> param)throws Exception;
	public List<Map<String, Object>> selectItems(Map<String, Object> param)throws Exception;
	public List<Map<String, Object>> selectSosokCd(Map<String, Object> param)throws Exception;
	public List<Map<String, Object>> selectProductCd(Map<String, Object> param)throws Exception;
	public List<Map<String, Object>> selectMyProduct(Map<String, Object> param)throws Exception;


	public List<Map<String, Object>> selectMyEduHistory(Map<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectMyEduFuture(Map<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectMyAreas(Map<String, Object> param) throws Exception;



}
