/**
 * @Class Name : LocationpageDao.java
 * @Description : LocationpageDao.Class
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


public interface LocationpageDao {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
    
	public List<Map<String, Object>> selectLocationpagePageList(Map<String, Object> param) throws Exception;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
    
	public List<Map<String, Object>> selectLocationpageList(Map<String, Object> param) throws Exception;

	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
    
	public Map<String, Object> selectLocationpage(Map<String, Object> param) throws Exception;

     @SuppressWarnings("unchecked")
 	public List<Map<String, Object>> selectLocationpage2(Map<String, Object> param)throws Exception;

	/**
     * 중복검사를 한다
     * @param param
     * @return
     * @throws Exception
     */
    
	public int selectLocationpageExist(Map<String, Object> param) throws Exception;

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertLocationpage(Map<String, Object> param) throws Exception;

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateLocationpage(Map<String, Object> param) throws Exception;

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteLocationpage(Map<String, Object> param) throws Exception;

}
