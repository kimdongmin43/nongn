/**
 * @Class Name : CeopageDaoImpl.java
 * @Description : CeopageDaoImpl.Class
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
 
package kr.apfs.local.contents.dao.impl;

import java.util.List;
import java.util.Map;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.contents.dao.CeopageDao;

import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Repository;

@Repository("CeopageDao")
public class CeopageDaoImpl extends AbstractDao implements CeopageDao {

	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCeopagePageList(Map<String, Object> param) throws Exception{
		return selectPageList("CeopageDao.selectCeopagePageList", param);
	}	
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCeopageList(Map<String, Object> param) throws Exception{
		return selectList("CeopageDao.selectCeopageList", param);
	}
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectCeopage(Map<String, Object> param) throws Exception{
		return selectOne("CeopageDao.selectCeopage", param);
	}
     
     @SuppressWarnings("unchecked")
 	public List <Map<String, Object>> selectCeopage2(Map<String, Object> param) throws Exception{
 		return selectList("CeopageDao.selectCeopage2", param);
 	}
     
     
	
	
	/**
     * 중복검사를 한다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int selectCeopageExist(Map<String, Object> param) throws Exception{
		return selectOne("CeopageDao.selectCeopageExist", param);
	}
	
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertCeopage(Map<String, Object> param) throws Exception{
		 return update("CeopageDao.insertCeopage", param);
	}
	
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateCeopage(Map<String, Object> param) throws Exception{
		return update("CeopageDao.updateCeopage", param);
	}
	
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteCeopage(Map<String, Object> param) throws Exception{
		return delete("CeopageDao.deleteCeopage", param);
	}

	
	/**
     * 출력순서를 변경한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int updateCeopageSort(Map<String, Object> param) throws Exception {
		int listSize=0;
		int resultNum=0;
		JSONParser parser =new JSONParser();
		List<Map<String, Object>> jsonStringList = (List<Map<String, Object>>)parser.parse(param.get("data").toString());
		listSize = jsonStringList.size();
		for (Map<String, Object> map : jsonStringList) {
			param.put("ceoId", map.get("ceoId"));
			param.put("sort", map.get("sort"));
			resultNum+=update("CeopageDao.updateCeopageSort", param);			
		}
		return listSize==resultNum?resultNum:0;
		
	}
	/*public static Object parse(String s)
	  {
	    StringReader in = new StringReader(s);
	    return parse(in);
	  }
	
	public static Object parse(Reader in)
	  {
	    try
	    {
	      JSONParser parser = new JSONParser();
	      return parser.parse(in);
	    } catch (Exception e) {
	    }
	    return null;
	  }*/

}
