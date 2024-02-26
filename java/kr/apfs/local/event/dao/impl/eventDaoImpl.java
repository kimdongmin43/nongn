/**
 * @Class Name : eventDaoImpl.java
 * @Description : eventDaoImpl.Class
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

package kr.apfs.local.event.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONValue;
import org.springframework.stereotype.Repository;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.event.dao.eventDao;

@Repository("eventDao")
public class eventDaoImpl extends AbstractDao implements eventDao {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> getScheduleInfo(Map<String, Object> param) throws Exception{
		return selectPageList("eventDao.getScheduleInfo", param);
	}

     /**
     *
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> getScheduleYearInMonth(Map<String, Object> param) throws Exception{
		return selectPageList("eventDao.getScheduleYearInMonth", param);
	}
     /**
     *
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> getScheduleYearInMonthList(Map<String, Object> param) throws Exception{
		return selectPageList("eventDao.getScheduleYearInMonthList", param);
	}

     /**
      * 조회수를 증가 시킨다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
 	public void updateEventContentsHits(Map<String, Object> param) throws Exception{
 		 update("eventDao.updateEventContentsHits", param);
 	}

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selecteventList(Map<String, Object> param) throws Exception{
		return selectList("eventDao.selecteventList", param);
	}



	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectevent(Map<String, Object> param) throws Exception{
		return selectOne("eventDao.selectevent", param);
	}


	/**
     * 중복검사를 한다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int selecteventExist(Map<String, Object> param) throws Exception{
		return selectOne("eventDao.selecteventExist", param);
	}


	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertevent(Map<String, Object> param) throws Exception{
		 return update("eventDao.insertevent", param);
	}


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateevent(Map<String, Object> param) throws Exception{
		return update("eventDao.updateevent", param);
	}


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteevent(Map<String, Object> param) throws Exception{
		update("eventDao.deleteeventReorder", param);
		return delete("eventDao.deleteevent", param);
	}

	/**
     * event 순서조정 정보를 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateeventReorder(Map<String, Object> param) throws Exception{
		int listSize=0;
		int resultNum=0;

		List<Map<String, Object>> jsonStringList = (List<Map<String, Object>>) JSONValue.parse(param.get("data").toString());
		listSize = jsonStringList.size();
		for (Map<String, Object> map : jsonStringList) {
			param.put("eventId", map.get("eventId"));
			param.put("sort", map.get("sort"));
			param.put("cTabGbn", map.get("cTabGbn"));
			resultNum+=update("eventDao.updateeventReoder", param);
		}
		return listSize==resultNum?resultNum:0;
	}


	@Override
	public List<Map<String, Object>> selecteventArea(String mainType) throws Exception {
		return selectList("eventDao.selecteventArea",mainType);
	}


	@Override
	public String selectMainType() throws Exception {
		return selectOne("eventDao.selectMainType");
	}


	@Override
	public List<Map<String, Object>> selecteventListBack(
			Map<String, Object> param) throws Exception {
		return selectList("eventDao.selecteventListBack", param);
	}
	@Override
	public List<Map<String, Object>> ScheduleList(
			Map<String, Object> param) throws Exception {
		return selectList("eventDao.ScheduleList", param);
	}
	
    @SuppressWarnings("unchecked")
	public Map<String, Object> ScheduleListBack(Map<String, Object> param) throws Exception{
		return selectOne("eventDao.ScheduleListBack", param);
	}
    
	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertEvent(Map<String, Object> param) throws Exception{
		 return update("eventDao.insertEvent", param);
	}


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateEvent(Map<String, Object> param) throws Exception{
		return update("eventDao.updateEvent", param);
	}
	
	public int deleteEvent(Map<String, Object> param) throws Exception{
		return update("eventDao.deleteEvent", param);
	}


	

}
