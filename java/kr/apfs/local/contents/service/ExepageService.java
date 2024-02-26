package kr.apfs.local.contents.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Class Name : ExepageService.java
 * @Description : ExepageService.Class
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
public interface ExepageService {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectExepagePageList(Map<String, Object> param) throws Exception;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectExepageList(Map<String, Object> param) throws Exception;


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public List<HashMap> selectExepage(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectExepage2(Map<String, Object> param) throws Exception;
	/**
     * 중복 여부를 체크한다
     * @param param
     * @return
     * @throws Exception
     */
	public int selectExepageExist(Map<String, Object> param) throws Exception;


	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertExepage(Map<String, Object> param) throws Exception;


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateExepage(Map<String, Object> param) throws Exception;


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteExepage(Map<String, Object> param) throws Exception;

	/**
     * 출력 순서를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateExepageSort(Map<String, Object> param) throws Exception;




	/**
     * 출력 순서를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public List<Map<String, Object>> selectExeRankList(Map<String, Object> param) throws Exception;

	public int insertExeRank(Map<String, Object> param) throws Exception;

	public int updateRankReorder(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectRank(Map<String, Object> param) throws Exception;

	public int updateRank(Map<String, Object> param) throws Exception;

	public int deleteRank(Map<String, Object> param) throws Exception;



	public List<Map<String, Object>> selectExeDeptList(Map<String, Object> param) throws Exception;

	public int insertExeDept(Map<String, Object> param) throws Exception;

	public int updateDeptReorder(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectDept(Map<String, Object> param) throws Exception;

	public int updateDept(Map<String, Object> param) throws Exception;

	public int deleteDept(Map<String, Object> param) throws Exception;

	/**
     * 임원의원구분 동통코드를 가져온다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public List<Map<String, Object>> selectExeCd(Map<String , Object> param) throws Exception;





}
