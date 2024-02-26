package kr.apfs.local.contents.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : EmppageService.java
 * @Description : EmppageService.Class
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
public interface EmppageService {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEmppagePageList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectEmppagePageList2(Map<String, Object> param) throws Exception;
	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEmppageList(Map<String, Object> param) throws Exception;


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectEmppage(Map<String, Object> param) throws Exception;


	/**
     * 중복 여부를 체크한다
     * @param param
     * @return
     * @throws Exception
     */
	public int selectEmppageExist(Map<String, Object> param) throws Exception;


	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertEmppage(Map<String, Object> param) throws Exception;


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateEmppage(Map<String, Object> param) throws Exception;


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteEmppage(Map<String, Object> param) throws Exception;

	/**
     * 출력 순서를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateEmppageSort(Map<String, Object> param) throws Exception;




	/**
     * 출력 순서를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public List<Map<String, Object>> selectEmpRankList(Map<String, Object> param) throws Exception;

	public int insertEmpRank(Map<String, Object> param) throws Exception;

	public int updateRankReorder(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectRank(Map<String, Object> param) throws Exception;

	public int updateRank(Map<String, Object> param) throws Exception;

	public int deleteRank(Map<String, Object> param) throws Exception;



	public List<Map<String, Object>> selectEmpDeptList(Map<String, Object> param) throws Exception;

	public int insertEmpDept(Map<String, Object> param) throws Exception;

	public int updateDeptReorder(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectDept(Map<String, Object> param) throws Exception;

	public int updateDept(Map<String, Object> param) throws Exception;

	public int deleteDept(Map<String, Object> param) throws Exception;





}
