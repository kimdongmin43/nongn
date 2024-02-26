package kr.apfs.local.classify.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.apfs.local.classify.dao.ClassifyDao;
import kr.apfs.local.classify.service.ClassifyService;

/**
 * @Class Name : ClassifyServiceImpl.java
 * @Description : ClassifyServiceImpl.Class
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

@Service("ClassifyService")
public class ClassifyServiceImpl implements ClassifyService {
	private static final Logger logger = LogManager.getLogger(ClassifyServiceImpl.class);
	
	@Resource(name = "ClassifyDao")
    protected ClassifyDao classifyDao;
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectClassifyPageList(Map<String, Object> param) throws Exception{
		return classifyDao.selectClassifyPageList(param);
	}
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectClassifyList(Map<String, Object> param) throws Exception{
		return classifyDao.selectClassifyList(param);
	}
	
	/**
     * 분류 트리 리스트를 반환해준다.
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClassifyTreeList(Map<String, Object> param) throws Exception{
    	return classifyDao.selectClassifyTreeList(param);
     }
     
 	/**
     *  분류 코드 리스트를 반환해준다.
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClassifyCodeList(Map<String, Object> param) throws Exception{
		return classifyDao.selectClassifyCodeList(param);
	}
     
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectClassify(Map<String, Object> param) throws Exception{
		return classifyDao.selectClassify(param);
	}
	
	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	@Override
	public int selectClassifyExist(Map<String, Object> param) throws Exception {
		return classifyDao.selectClassifyExist(param);
	}
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertClassify(Map<String, Object> param) throws Exception{
		return classifyDao.insertClassify(param);
	}
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateClassify(Map<String, Object> param) throws Exception{
		return classifyDao.updateClassify(param);
	}
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deleteClassify(Map<String, Object> param) throws Exception{
		return classifyDao.deleteClassify(param);
	}
	
	/**
     * 분류 순서를 조정해준다. 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateClassifyReorder(Map<String, Object> param) throws Exception{
		return classifyDao.updateClassifyReorder(param);
	}
}
