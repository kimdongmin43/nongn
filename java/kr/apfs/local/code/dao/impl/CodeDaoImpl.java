/**
 * @Class Name : CodeDaoImpl.java
 * @Description : CodeDaoImpl.Class
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
 
package kr.apfs.local.code.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.apfs.local.code.dao.CodeDao;
import kr.apfs.local.common.dao.AbstractDao;

 @Repository("CodeDao")
public class CodeDaoImpl extends AbstractDao implements CodeDao { 

		/**
	     * 
	     * @param param
	     * @return
	     * @throws Exception
	     */
	     @SuppressWarnings("unchecked")
		public List<Map<String, Object>> selectCodemasterPageList(Map<String, Object> param) throws Exception{
			return selectPageList("CodeDao.selectCodemasterPageList", param);
		} 
		
		
		/**
	     * 
	     * @param param
	     * @return
	     * @throws Exception
	     */
	     @SuppressWarnings("unchecked")
		public List<Map<String, Object>> selectCodemasterList(Map<String, Object> param) throws Exception{
			return selectList("CodeDao.selectCodemasterList", param);
		}
		
		
		
		/**
	     * 선택된 행의 값을 가지고 온다 
	     * @param param
	     * @return
	     * @throws Exception
	     */
	     @SuppressWarnings("unchecked")
		public Map<String, Object> selectCodemaster(Map<String, Object> param) throws Exception{
			return selectOne("CodeDao.selectCodemaster", param);
		}
		
		
		/**
	     * 중복검사를 한다 
	     * @param param
	     * @return
	     * @throws Exception
	     */
	     @SuppressWarnings("unchecked")
		public int selectCodemasterExist(Map<String, Object> param) throws Exception{
			return selectOne("CodeDao.selectCodemasterExist", param);
		}
		
		
		/**
	     * 값을 입력한다 
	     * @param 	param
	     * @return 	int
	     * @throws 	Exception
	     */	
		public int insertCodemaster(Map<String, Object> param) throws Exception{
			 return update("CodeDao.insertCodemaster", param);
		}
		
		
		/**
	     * 값을 수정한다 
	     * @param 	param
	     * @return 	int
	     * @throws 	Exception
	     */
		public int updateCodemaster(Map<String, Object> param) throws Exception{
			return update("CodeDao.updateCodemaster", param);
		}
		
		
		/**
	     * 값을 삭제한다 
	     * @param 	param
	     * @return 	int
	     * @throws 	Exception
	     */
		public int deleteCodemaster(Map<String, Object> param) throws Exception{
			delete("CodeDao.deleteCodeAll", param);
			int retVal = delete("CodeDao.deleteCodemaster", param);
			return retVal;
		}
	
	/**
     *  코드리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCodeList(Map<String, Object> param) throws Exception{
		return selectList("CodeDao.selectCodeList", param);
	}
	
 	/**
      *  코드구분의 코드 리스트를 가져온다.
      * @param param
      * @return
      * @throws Exception
      */
      @SuppressWarnings("unchecked")
 	public List<Map<String, Object>> selectCodeMasterCodeList(String param) throws Exception{
 		return selectList("CodeDao.selectCodeMasterCodeList", param);
 	}
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectCode(Map<String, Object> param) throws Exception{
		return selectOne("CodeDao.selectCode", param);
	}
	
	
	/**
     * 중복검사를 한다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int selectCodeExist(Map<String, Object> param) throws Exception{
		return selectOne("CodeDao.selectCodeExist", param);
	}
	
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertCode(Map<String, Object> param) throws Exception{
		 return update("CodeDao.insertCode", param);
	}
	
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateCode(Map<String, Object> param) throws Exception{
		return update("CodeDao.updateCode", param);
	}
	
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteCode(Map<String, Object> param) throws Exception{
		update("CodeDao.deleteCodeReorder", param);
		delete("CodeDao.deleteCode", param);
		return 1;
	}

	/**
     * 코드 순서조정 정보를 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateCodeReorder(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> list = (List<Map<String, Object>>)param.get("code_list");
		Map<String, Object> data = new HashMap();
		data.put("mstId", param.get("mstId"));
		for(int i =0; i < list.size();i++){
			data.put("codeId", list.get(i).get("codeId"));
			data.put("sort", list.get(i).get("sort"));
			update("CodeDao.updateCodeSeq", data);
		}
		
		return list.size();
	}
}
