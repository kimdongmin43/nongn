package kr.apfs.local.common.fileupload.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.apfs.local.common.fileupload.dao.CommonFileDao;
import kr.apfs.local.common.fileupload.model.CommonFileVO;
import kr.apfs.local.common.fileupload.service.CommonFileService;


/**
 * @Class Name : CommonFileServiceImpl
 * @Description : file upload
 * @author : ocm
 * @since 20150523
 * @version 1.0
 * @see
 * 
 * @Modification Information
 * 
 *               <pre>
 *    Date                Changer         Comment
 *  ===========    =========    ===========================
 *  20150523       jangcw
 * </pre>
 */
 
@Service("CommonFileService")
public class CommonFileServiceImpl implements CommonFileService {
	Logger logger = LoggerFactory.getLogger(CommonFileServiceImpl.class);
	
	@Resource(name = "CommonFileDao")
	private CommonFileDao commonFileDao;

	/**
	 * 공통파일 정보를 반환해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getCommonFile(Map<String, Object> param) throws Exception{
        return commonFileDao.getCommonFile(param);
	}
	/**
	 * 공통파일 리스트를 반환해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getCommonFileList(Map<String, Object> param) throws Exception{		
        return commonFileDao.getCommonFileList(param);
	}
	/**
	 * 공통파일을 등록 처리해준다.
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public int insertCommonFile(Map<String, Object> param) throws Exception{
		int retVal = 0;
		
		retVal = commonFileDao.insertCommonFile(param);
		
		return retVal; 
	}
	
	/**
	 * 공통파일들을 등록 처리해준다.
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public int insertCommonFiles(List<CommonFileVO> list) throws Exception{
		int retVal = 0;
	
		CommonFileVO param = null;
		for(int i =0; i < list.size();i++){
			param = list.get(i);
			//retVal += commonFileDao.insertCommonFile(param);
		}
		return retVal; 
	}
	
	/**
	 * 공통파일을 수정 처리해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateCommonFile(CommonFileVO param) throws Exception{
		int retVal = 0;
		
		retVal = commonFileDao.updateCommonFile(param);
		
		return retVal;
	}
	/**
	 * 공통파일을 삭제 처리해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteCommonFile(String param) throws Exception{
		int retVal = 0;
		
		retVal = commonFileDao.deleteCommonFile(param);
		
		return retVal;
	}
	/**
	 * 그룹의 모든 공통파일을 삭제 처리해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteCommonFileAll(Map<String, Object> param) throws Exception{
		int retVal = 0;
		
		retVal = commonFileDao.deleteCommonFileAll(param);
		
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
		
		list = (List<Object>)commonFileDao.getCommonFilePageList(param);
		
        return list;
	}
	
	/**
	 * 공통파일 코드 리스트를 반환해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getCommonFileCodeList(Map<String, Object> param) throws Exception{
		return commonFileDao.getCommonFileCodeList(param);
	}
	
}
