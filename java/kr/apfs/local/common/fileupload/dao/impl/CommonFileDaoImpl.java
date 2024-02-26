package kr.apfs.local.common.fileupload.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.common.fileupload.dao.CommonFileDao;
import kr.apfs.local.common.fileupload.model.CommonFileVO;

@Repository("CommonFileDao")
public class CommonFileDaoImpl extends AbstractDao implements CommonFileDao{
 
	public Map<String, Object> getCommonFile(Map<String, Object> param) throws Exception{
		param = selectOne("getCommonFile",param);
		
        return param;
	}
	
	public List<Map<String, Object>> getCommonFileList(Map<String, Object> param) throws Exception{
        return selectList("CommonFileDao.getCommonFileList", param);
	}
	
	public int insertCommonFile(Map<String, Object> param) throws Exception{
		int retVal = 0;
		
		retVal = update("CommonFileDao.insertCommonFile",param);
		
		return retVal;
	}
	public int updateCommonFile(CommonFileVO param) throws Exception{
		int retVal = 0;
		
		retVal = update("CommonFileDao.updateCommonFile",param);
		
		return retVal;
	}
	public int deleteCommonFile(String param) throws Exception{
		int retVal = 0;
		
		retVal = delete("CommonFileDao.deleteCommonFile",param);
		
		return retVal;
	}
	
	public int deleteCommonFileAll(Map<String, Object> param) throws Exception{
		int retVal = 0;
		
		retVal = delete("CommonFileDao.deleteCommonFileAll",param);
		
        return retVal;
	}
	/**
	 * 공통파일 페이지리스트를 반환해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Object> getCommonFilePageList(Map<String, Object> param) throws Exception{
		List<Object> list = null;
		 
		list = (List<Object>)selectList("CommonFileDao.getCommonFilePageList",param);
		
        return list;
	}
	/**
	 * 공통파일 코드 리스트를 반환해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getCommonFileCodeList(Map<String, Object> param) throws Exception{
		return selectList("CommonFileDao.getCommonFileCodeList",param);
	}
}
