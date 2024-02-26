/**
 * @Class Name : EmppageDaoImpl.java
 * @Description : EmppageDaoImpl.Class
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

package kr.apfs.local.contents.dao.impl;

import java.util.List;
import java.util.Map;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.contents.dao.EmppageDao;

import org.json.simple.JSONValue;
import org.springframework.stereotype.Repository;

@Repository("EmppageDao")
public class EmppageDaoImpl extends AbstractDao implements EmppageDao {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEmppagePageList(Map<String, Object> param) throws Exception{
		return selectPageList("EmppageDao.selectEmppagePageList", param);
	}

 	public List<Map<String, Object>> selectEmppagePageList2(Map<String, Object> param) throws Exception{
		return selectPageList("EmppageDao.selectEmppagePageList2", param);
	}

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEmppageList(Map<String, Object> param) throws Exception{
		return selectList("EmppageDao.selectEmppageList", param);
	}

	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectEmppage(Map<String, Object> param) throws Exception{
		return selectOne("EmppageDao.selectEmppage", param);
	}


	/**
     * 중복검사를 한다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int selectEmppageExist(Map<String, Object> param) throws Exception{
		return selectOne("EmppageDao.selectEmppageExist", param);
	}


	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertEmppage(Map<String, Object> param) throws Exception{
		 return update("EmppageDao.insertEmppage", param);
	}


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateEmppage(Map<String, Object> param) throws Exception{
		return update("EmppageDao.updateEmppage", param);
	}


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteEmppage(Map<String, Object> param) throws Exception{
		return delete("EmppageDao.deleteEmppage", param);
	}


	/**
     * 출력순서를 변경한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int updateEmppageSort(Map<String, Object> param) throws Exception {
		int listSize=0;
		int resultNum=0;
		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		//System.out.println(param);
		List<Map<String, Object>> jsonStringList = (List<Map<String, Object>>) JSONValue.parse(param.get("data").toString());
		listSize = jsonStringList.size();
		for (Map<String, Object> map : jsonStringList) {
			param.put("empId", map.get("empId"));
			param.put("sort", map.get("sort"));
			resultNum+=update("EmppageDao.updateEmppageSort", param);
		}
		return listSize==resultNum?resultNum:0;
	}

	@Override
	public List<Map<String, Object>> selectEmpRankList(Map<String, Object> param)throws Exception {
		return selectList("EmppageDao.selectEmpRankList", param);
	}

	@Override
	public int insertEmpRank(Map<String, Object> param) throws Exception {
		return insert("EmppageDao.insertEmpRank", param);
	}

	@Override
	public int updateRankReorder(Map<String, Object> param) throws Exception {
		int listSize=0;
		int resultNum=0;
		List<Map<String, Object>> jsonStringList = (List<Map<String, Object>>) JSONValue.parse(param.get("data").toString());
		//System.out.println("진입");
		listSize = jsonStringList.size();
		for (Map<String, Object> map : jsonStringList) {
			param.put("rankId", map.get("rankId"));
			param.put("sort", map.get("sort"));
			resultNum+=update("EmppageDao.updateRankReorder", param);
		}
		return listSize==resultNum?resultNum:0;
	}

	@Override
	public Map<String, Object> selectRank(Map<String, Object> param) throws Exception {
		return selectOne("EmppageDao.selectRank", param);
	}

	@Override
	public int updateRank(Map<String, Object> param) throws Exception {
		return update("EmppageDao.updateRank", param);
	}

	@Override
	public int deleteRank(Map<String, Object> param) throws Exception {
		return delete("EmppageDao.deleteRank",param);
	}





	@Override
	public List<Map<String, Object>> selectEmpDeptList(Map<String, Object> param)
			throws Exception {
		return selectList("EmppageDao.selectEmpDeptList", param);
	}
	@Override
	public int insertEmpDept(Map<String, Object> param) throws Exception {
		return insert("EmppageDao.insertEmpDept", param);
	}
	@Override
	public int updateDeptReorder(Map<String, Object> param) throws Exception {
		int listSize=0;
		int resultNum=0;
		List<Map<String, Object>> jsonStringList = (List<Map<String, Object>>) JSONValue.parse(param.get("data").toString());
		//System.out.println("진입");
		listSize = jsonStringList.size();
		for (Map<String, Object> map : jsonStringList) {
			param.put("deptId", map.get("deptId"));
			param.put("sort", map.get("sort"));
			resultNum+=update("EmppageDao.updateDeptReorder", param);
		}
		return listSize==resultNum?resultNum:0;
	}

	@Override
	public Map<String, Object> selectDept(Map<String, Object> param)
			throws Exception {
		return selectOne("EmppageDao.selectDept", param);
	}

	@Override
	public int updateDept(Map<String, Object> param) throws Exception {
		return update("EmppageDao.updateDept", param);
	}

	@Override
	public int deleteDept(Map<String, Object> param) throws Exception {
		return delete("EmppageDao.deleteDept",param);
	}




}
