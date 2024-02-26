/**
 * @Class Name : ClassifyDao.java
 * @Description : ClassifyDao.Class
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
 
package kr.apfs.local.classify.dao;

import java.util.List;
import java.util.Map;


public interface ClassifyDao {

	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    
	public List<Map<String, Object>> selectClassifyPageList(Map<String, Object> param) throws Exception;
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    
	public List<Map<String, Object>> selectClassifyList(Map<String, Object> param) throws Exception;
	
 	/**
      * 분류 트리 리스트를 반환해준다.
      * @param param
      * @return
      * @throws Exception
      */
     
 	public List<Map<String, Object>> selectClassifyTreeList(Map<String, Object> param) throws Exception;
      
  	/**
      *  분류 코드 리스트를 반환해준다.
      * @param param
      * @return
      * @throws Exception
      */
     
 	public List<Map<String, Object>> selectClassifyCodeList(Map<String, Object> param) throws Exception;
      
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
    
	public Map<String, Object> selectClassify(Map<String, Object> param) throws Exception;
	
	/**
     * 중복검사를 한다 
     * @param param
     * @return
     * @throws Exception
     */
    
	public int selectClassifyExist(Map<String, Object> param) throws Exception;
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertClassify(Map<String, Object> param) throws Exception;
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateClassify(Map<String, Object> param) throws Exception;
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteClassify(Map<String, Object> param) throws Exception;
	
	/**
     * 분류 순서를 조정해준다. 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateClassifyReorder(Map<String, Object> param) throws Exception;
}
