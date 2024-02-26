package kr.apfs.local.contents.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.contents.dao.EmppageDao;
import kr.apfs.local.contents.service.EmppageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @Class Name : EmppageServiceImpl.java
 * @Description : EmppageServiceImpl.Class
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

@Service("EmppageService")
public class EmppageServiceImpl implements EmppageService {
	private static final Logger logger = LogManager.getLogger(EmppageServiceImpl.class);

	@Resource(name = "EmppageDao")
    protected EmppageDao emppageDao;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEmppagePageList(Map<String, Object> param) throws Exception{
		return emppageDao.selectEmppagePageList(param);
	}

	public List<Map<String, Object>> selectEmppagePageList2(Map<String, Object> param) throws Exception{
		return emppageDao.selectEmppagePageList2(param);
	}


	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEmppageList(Map<String, Object> param) throws Exception{
		return emppageDao.selectEmppageList(param);
	}

	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectEmppage(Map<String, Object> param) throws Exception{
		return emppageDao.selectEmppage(param);
	}

	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectEmppageExist(Map<String, Object> param) throws Exception {
		return emppageDao.selectEmppageExist(param);
	}

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertEmppage(Map<String, Object> param) throws Exception{
		return emppageDao.insertEmppage(param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateEmppage(Map<String, Object> param) throws Exception{
		return emppageDao.updateEmppage(param);
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteEmppage(Map<String, Object> param) throws Exception{
		return emppageDao.deleteEmppage(param);
	}


	/**
     * 출력순서를 변경한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int updateEmppageSort(Map<String, Object> param) throws Exception {
		return emppageDao.updateEmppageSort(param);
	}

	@Override
	public List<Map<String, Object>> selectEmpRankList(Map<String, Object> param)
			throws Exception {
		return emppageDao.selectEmpRankList(param);
	}

	@Override
	public int insertEmpRank(Map<String, Object> param) throws Exception {
				return emppageDao.insertEmpRank(param);
	}

	@Override
	public int updateRankReorder(Map<String, Object> param) throws Exception {
		return emppageDao.updateRankReorder(param);
	}

	@Override
	public Map<String, Object> selectRank(Map<String, Object> param) throws Exception {
		return emppageDao.selectRank(param);
	}

	@Override
	public int updateRank(Map<String, Object> param) throws Exception {
		return emppageDao.updateRank(param);
	}

	@Override
	public int deleteRank(Map<String, Object> param) throws Exception {
		return emppageDao.deleteRank(param);
	}




	@Override
	public List<Map<String, Object>> selectEmpDeptList(Map<String, Object> param)
			throws Exception {
		return emppageDao.selectEmpDeptList(param);
	}

	@Override
	public int insertEmpDept(Map<String, Object> param) throws Exception {
		return emppageDao.insertEmpDept(param);
	}

	@Override
	public int updateDeptReorder(Map<String, Object> param) throws Exception {
		return emppageDao.updateDeptReorder(param);
	}

	@Override
	public Map<String, Object> selectDept(Map<String, Object> param)
			throws Exception {
		return emppageDao.selectDept(param);
	}

	@Override
	public int updateDept(Map<String, Object> param) throws Exception {
		return emppageDao.updateDept(param);
	}

	@Override
	public int deleteDept(Map<String, Object> param) throws Exception {
		return emppageDao.deleteDept(param);
	}



}
