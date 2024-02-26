/**
 * @Class Name : ClassifyDaoImpl.java
 * @Description : ClassifyDaoImpl.Class
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
 
package kr.apfs.local.classify.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.apfs.local.classify.dao.ClassifyDao;
import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.common.util.StringUtil;

@Repository("ClassifyDao")
public class ClassifyDaoImpl extends AbstractDao implements ClassifyDao {

	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClassifyPageList(Map<String, Object> param) throws Exception{
		return selectPageList("ClassifyDao.selectClassifyPageList", param);
	}
	
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClassifyList(Map<String, Object> param) throws Exception{
		return selectList("ClassifyDao.selectClassifyList", param);
	}
 	
 	/**
      * 분류 트리 리스트를 반환해준다.
      * @param param
      * @return
      * @throws Exception
      */
      @SuppressWarnings("unchecked")
 	public List<Map<String, Object>> selectClassifyTreeList(Map<String, Object> param) throws Exception{
     	 return selectList("ClassifyDao.selectClassifyTreeList", param);
      }
      
 	/**
      *  분류 코드 리스트를 반환해준다.
      * @param param
      * @return
      * @throws Exception
      */
      @SuppressWarnings("unchecked")
 	public List<Map<String, Object>> selectClassifyCodeList(Map<String, Object> param) throws Exception{
 		return selectList("ClassifyDao.selectClassifyCodeList", param);
 	}
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectClassify(Map<String, Object> param) throws Exception{
		return selectOne("ClassifyDao.selectClassify", param);
	}
	
	/**
     * 중복검사를 한다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int selectClassifyExist(Map<String, Object> param) throws Exception{
		return selectOne("ClassifyDao.selectClassifyExist", param);
	}
	
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertClassify(Map<String, Object> param) throws Exception{
		 return update("ClassifyDao.insertClassify", param);
	}
	
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateClassify(Map<String, Object> param) throws Exception{
		return update("ClassifyDao.updateClassify", param);
	}
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteClassify(Map<String, Object> param) throws Exception{
		String classifyId = "";
		List<Map<String,Object>> childList = selectList("ClassifyDao.selectClassifyChildList", param);
		Map<String,Object> map = new HashMap();
		classifyId = StringUtil.nvl(param.get("classify_id"));
		update("ClassifyDao.deleteClassifyReorder", param);
		map.put("gubun", param.get("gubun"));
		map.put("classify_id", classifyId);
		delete("ClassifyDao.deleteClassify", map);
        
		for(int i = 0; i < childList.size();i++){
			classifyId = StringUtil.nvl(childList.get(i).get("classify_id"));
			map.put("classify_id", classifyId);
			delete("ClassifyDao.deleteClassify", map);
		}
		
		return 1; 
	}
	
	/**
     * 분류 순서를 조정해준다. 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateClassifyReorder(Map<String, Object> param) throws Exception{
			String upClassifyId = "", oldUpClassifyId = "";
			int sort = 0, oldsort = 0;
			sort = StringUtil.nvl(param.get("sort"),0);
			oldsort = StringUtil.nvl(param.get("old_sort"),0);
			upClassifyId = (String)param.get("up_classify_id");
			oldUpClassifyId = (String)param.get("old_up_classify_id");
			if(!upClassifyId.equals(oldUpClassifyId)){
				param.put("direction", "A");
			    update("ClassifyDao.updateClassifyReordersort", param);
			    param.put("sort", param.get("old_sort"));
			    param.put("up_classify_id", param.get("old_up_classify_id"));
			    param.put("direction", "D");
			    update("ClassifyDao.updateClassifyReordersort", param);
			}else{
			    param.put("sort", oldsort-1);
			    param.put("direction", "A");
			    update("ClassifyDao.updateClassifyReordersort", param);
			    param.put("sort", sort-1);
				param.put("direction", "A");
			    update("ClassifyDao.updateClassifyReordersort", param);				
			}
		    param.put("sort", sort);
		    param.put("up_classify_id", upClassifyId);		    
			update("ClassifyDao.updateClassifyReorder", param);
			
		  return 1;
	}
}
