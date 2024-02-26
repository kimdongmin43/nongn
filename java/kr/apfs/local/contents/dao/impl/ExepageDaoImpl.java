/**

 * @Class Name : ExepageDaoImpl.java
 * @Description : ExepageDaoImpl.Class
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.contents.dao.ExepageDao;

import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Repository;

@Repository("ExepageDao")
public class ExepageDaoImpl extends AbstractDao implements ExepageDao {

	/**
     *
     * @param param
     * @returnhtoa
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectExepagePageList(Map<String, Object> param) throws Exception{
		return selectPageList("ExepageDao.selectExepagePageList", param);

	}

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectExepageList(Map<String, Object> param) throws Exception{
		return selectList("ExepageDao.selectExepageList", param);
	}

	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<HashMap> selectExepage(Map<String, Object> param) throws Exception{
    	 return selectList("ExepageDao.selectExepage", param);
	}

     @SuppressWarnings("unchecked")
 	public List <Map<String, Object>> selectExepage2(Map<String, Object> param) throws Exception{
     	 return selectList("ExepageDao.selectExepage2", param);
 	}


	/**
     * 중복검사를 한다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int selectExepageExist(Map<String, Object> param) throws Exception{
		return selectOne("ExepageDao.selectExepageExist", param);
	}


	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertExepage(Map<String, Object> param) throws Exception{
		 return update("ExepageDao.insertExepage", param);
	}


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateExepage(Map<String, Object> param) throws Exception{
		return update("ExepageDao.updateExepage", param);
	}


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteExepage(Map<String, Object> param) throws Exception{
		return delete("ExepageDao.deleteExepage", param);
	}


	/**
     * 출력순서를 변경한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int updateExepageSort(Map<String, Object> param) throws Exception {
		int listSize=0;
		int resultNum=0;
		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		//System.out.println(param);
		JSONParser parser =new JSONParser();
		List<Map<String, Object>> jsonStringList = (List<Map<String, Object>>)parser.parse(param.get("data").toString());
		listSize = jsonStringList.size();
		for (Map<String, Object> map : jsonStringList) {
			param.put("exeId", map.get("exeId"));
			param.put("sort", map.get("sort"));
			resultNum+=update("ExepageDao.updateExepageSort", param);
		}
		return listSize==resultNum?resultNum:0;
	}

	@Override
	public List<Map<String, Object>> selectExeRankList(Map<String, Object> param)throws Exception {
		return selectList("ExepageDao.selectExeRankList", param);
	}

	@Override
	public int insertExeRank(Map<String, Object> param) throws Exception {
		return insert("ExepageDao.insertExeRank", param);
	}

	@Override
	public int updateRankReorder(Map<String, Object> param) throws Exception {
		int listSize=0;
		int resultNum=0;
		JSONParser parser =new JSONParser();
		List<Map<String, Object>> jsonStringList = (List<Map<String, Object>>)parser.parse(param.get("data").toString());
		//System.out.println("진입");
		listSize = jsonStringList.size();
		for (Map<String, Object> map : jsonStringList) {
			param.put("rankId", map.get("rankId"));
			param.put("sort", map.get("sort"));
			resultNum+=update("ExepageDao.updateRankReorder", param);
		}
		return listSize==resultNum?resultNum:0;
	}

	@Override
	public Map<String, Object> selectRank(Map<String, Object> param) throws Exception {
		return selectOne("ExepageDao.selectRank", param);
	}

	@Override
	public int updateRank(Map<String, Object> param) throws Exception {
		return update("ExepageDao.updateRank", param);
	}

	@Override
	public int deleteRank(Map<String, Object> param) throws Exception {
		return delete("ExepageDao.deleteRank",param);
	}





	@Override
	public List<Map<String, Object>> selectExeDeptList(Map<String, Object> param)
			throws Exception {
		return selectList("ExepageDao.selectExeDeptList", param);
	}
	@Override
	public int insertExeDept(Map<String, Object> param) throws Exception {
		return insert("ExepageDao.insertExeDept", param);
	}
	@Override
	public int updateDeptReorder(Map<String, Object> param) throws Exception {
		int listSize=0;
		int resultNum=0;
		JSONParser parser =new JSONParser();
		List<Map<String, Object>> jsonStringList = (List<Map<String, Object>>)parser.parse(param.get("data").toString());
		//System.out.println("진입");
		listSize = jsonStringList.size();
		for (Map<String, Object> map : jsonStringList) {
			param.put("dept_id", map.get("dept_id"));
			param.put("sort", map.get("sort"));
			resultNum+=update("ExepageDao.updateDeptReorder", param);
		}
		return listSize==resultNum?resultNum:0;
	}

	@Override
	public Map<String, Object> selectDept(Map<String, Object> param)
			throws Exception {
		return selectOne("ExepageDao.selectDept", param);
	}

	@Override
	public int updateDept(Map<String, Object> param) throws Exception {
		return update("ExepageDao.updateDept", param);
	}

	@Override
	public int deleteDept(Map<String, Object> param) throws Exception {
		return delete("ExepageDao.deleteDept",param);
	}

	@Override
	public List<Map<String, Object>> selectExeCd(Map<String, Object> param)throws Exception {

		return selectList("ExepageDao.selectExeCd",param);
	}




}
