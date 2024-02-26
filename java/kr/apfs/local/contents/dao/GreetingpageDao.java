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
 
package kr.apfs.local.contents.dao;

import java.util.List;
import java.util.Map;

@SuppressWarnings("unchecked")
public interface GreetingpageDao {

		
		
	/**
     * 인사말을 가져온다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
     /*public Map<String, Object> selectGreetingpage(Map<String, Object> param) throws Exception;*/
     public Map<String, Object> selectGreetingpage(Map<String, Object> param) throws Exception;
     	
 	public List<Map<String, Object>> selectGreetingpage2(Map<String, Object> param) throws Exception;
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateGreetingpage(Map<String, Object> param) throws Exception;

	/**
     * 중복 체크를 한다 
     * @param param
     * @return int
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int selectGreetingpageExist(Map<String, Object> param) throws Exception;
     
 	/**
      * 중복 체크를 한다 
      * @param param
      * @return int
      * @throws Exception
      */

	public int insertGreetingpage(Map<String, Object> param) throws Exception;




}
