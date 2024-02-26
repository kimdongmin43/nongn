package kr.apfs.local.code.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.apfs.local.code.dao.CodeDao;
import kr.apfs.local.code.service.CodeService;

/**
 * @Class Name : CodeServiceImpl.java
 * @Description : CodeServiceImpl.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2015.05.09           최초생성
 *
 * @author jangcw
 * @since 2016. 06.10
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Intocps All right reserved.
 */

@Service("CodeService")
public class CodeServiceImpl implements CodeService {
	private static final Logger logger = LogManager.getLogger(CodeServiceImpl.class);
	
	@Resource(name = "CodeDao")
    protected CodeDao codeDao;
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectCodemasterPageList(Map<String, Object> param) throws Exception{
		return codeDao.selectCodemasterPageList(param);
	}
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectCodemasterList(Map<String, Object> param) throws Exception{
		return codeDao.selectCodemasterList(param);
	}
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectCodemaster(Map<String, Object> param) throws Exception{
		return codeDao.selectCodemaster(param);
	}
	
	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	@Override
	public int selectCodemasterExist(Map<String, Object> param) throws Exception {
		return codeDao.selectCodemasterExist(param);
	}
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertCodemaster(Map<String, Object> param) throws Exception{
		return codeDao.insertCodemaster(param);
	}
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateCodemaster(Map<String, Object> param) throws Exception{
		return codeDao.updateCodemaster(param);
	}
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deleteCodemaster(Map<String, Object> param) throws Exception{
		return codeDao.deleteCodemaster(param);
	}
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectCodeList(Map<String, Object> param) throws Exception{
		return codeDao.selectCodeList(param);
	}
	
 	/**
     *  코드구분의 코드 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCodeMasterCodeList(String param) throws Exception{
		return codeDao.selectCodeMasterCodeList(param);
	}
     
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectCode(Map<String, Object> param) throws Exception{
		return codeDao.selectCode(param);
	}
	
	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	@Override
	public int selectCodeExist(Map<String, Object> param) throws Exception {
		return codeDao.selectCodeExist(param);
	}
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertCode(Map<String, Object> param) throws Exception{
		return codeDao.insertCode(param);
	}
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateCode(Map<String, Object> param) throws Exception{
		return codeDao.updateCode(param);
	}
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deleteCode(Map<String, Object> param) throws Exception{
		return codeDao.deleteCode(param);
	}

	/**
     * 코드 순서조정 정보를 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateCodeReorder(Map<String, Object> param) throws Exception{
		return codeDao.updateCodeReorder(param);
	}
}
