package kr.apfs.local.common.fileupload.dao;

import java.util.List;
import java.util.Map;

import kr.apfs.local.common.fileupload.model.CommonFileVO;

public interface CommonFileDao {
	/**
	 * 공통파일 정보를 반환해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getCommonFile(Map<String, Object> param) throws Exception;
	/**
	 * 공통파일 리스트를 반환해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getCommonFileList(Map<String, Object> param) throws Exception;
	/**
	 * 공통파일을 등록 처리해준다.
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public int insertCommonFile(Map<String, Object> param) throws Exception;
	/**
	 * 공통파일을 수정 처리해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateCommonFile(CommonFileVO param) throws Exception;
	/**
	 * 공통파일을 삭제 처리해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteCommonFile(String file_id) throws Exception;
	/**
	 * 그룹의 모든 공통파일을 삭제 처리해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteCommonFileAll(Map<String, Object> param) throws Exception;
	/**
	 * 공통파일 페이지리스트를 반환해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Object> getCommonFilePageList(Map<String, Object> param) throws Exception;
	/**
	 * 공통파일 코드 리스트를 반환해준다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getCommonFileCodeList(Map<String, Object> param) throws Exception;
}
