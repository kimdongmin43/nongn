package kr.apfs.local.contents.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.ExepageDao;
import kr.apfs.local.contents.service.ExepageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @Class Name : ExepageServiceImpl.java
 * @Description : ExepageServiceImpl.Class
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

@Service("ExepageService")
public class ExepageServiceImpl implements ExepageService {
	private static final Logger logger = LogManager.getLogger(ExepageServiceImpl.class);

	@Resource(name = "ExepageDao")
    protected ExepageDao exepageDao;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectExepagePageList(Map<String, Object> param) throws Exception{
		return exepageDao.selectExepagePageList(param);
	}

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectExepageList(Map<String, Object> param) throws Exception{
		return exepageDao.selectExepageList(param);
	}

	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public List<HashMap> selectExepage(Map<String, Object> param) throws Exception{
		return exepageDao.selectExepage(param);
	}

	public List <Map<String, Object>> selectExepage2(Map<String, Object> param) throws Exception{
		return exepageDao.selectExepage2(param);
	}


	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectExepageExist(Map<String, Object> param) throws Exception {
		return exepageDao.selectExepageExist(param);
	}

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertExepage(Map<String, Object> param) throws Exception{
		return exepageDao.insertExepage(param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateExepage(Map<String, Object> param) throws Exception{
		return exepageDao.updateExepage(param);
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteExepage(Map<String, Object> param) throws Exception{
		return exepageDao.deleteExepage(param);
	}


	/**
     * 출력순서를 변경한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int updateExepageSort(Map<String, Object> param) throws Exception {
		return exepageDao.updateExepageSort(param);
	}

	@Override
	public List<Map<String, Object>> selectExeRankList(Map<String, Object> param)
			throws Exception {
		return exepageDao.selectExeRankList(param);
	}

	@Override
	public int insertExeRank(Map<String, Object> param) throws Exception {
				return exepageDao.insertExeRank(param);
	}

	@Override
	public int updateRankReorder(Map<String, Object> param) throws Exception {
		return exepageDao.updateRankReorder(param);
	}

	@Override
	public Map<String, Object> selectRank(Map<String, Object> param) throws Exception {
		return exepageDao.selectRank(param);
	}

	@Override
	public int updateRank(Map<String, Object> param) throws Exception {
		return exepageDao.updateRank(param);
	}

	@Override
	public int deleteRank(Map<String, Object> param) throws Exception {
		return exepageDao.deleteRank(param);
	}




	@Override
	public List<Map<String, Object>> selectExeDeptList(Map<String, Object> param)
			throws Exception {
		return exepageDao.selectExeDeptList(param);
	}

	@Override
	public int insertExeDept(Map<String, Object> param) throws Exception {
		return exepageDao.insertExeDept(param);
	}

	@Override
	public int updateDeptReorder(Map<String, Object> param) throws Exception {
		return exepageDao.updateDeptReorder(param);
	}

	@Override
	public Map<String, Object> selectDept(Map<String, Object> param)
			throws Exception {
		return exepageDao.selectDept(param);
	}

	@Override
	public int updateDept(Map<String, Object> param) throws Exception {
		return exepageDao.updateDept(param);
	}

	@Override
	public int deleteDept(Map<String, Object> param) throws Exception {
		return exepageDao.deleteDept(param);
	}

	@Override
	public List<Map<String, Object>> selectExeCd(Map<String, Object> param)throws Exception {

		return exepageDao.selectExeCd(param);
	}



}
