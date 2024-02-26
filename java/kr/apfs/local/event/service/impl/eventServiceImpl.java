package kr.apfs.local.event.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.apfs.local.event.dao.eventDao;
import kr.apfs.local.event.service.eventService;

/**
 * @Class Name : eventServiceImpl.java
 * @Description : eventServiceImpl.Class
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

@Service("eventService")
public class eventServiceImpl implements eventService {
	private static final Logger logger = LogManager.getLogger(eventServiceImpl.class);

	@Resource(name = "eventDao")
    protected eventDao eventDao;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> getScheduleInfo(Map<String, Object> param) throws Exception{
		return eventDao.getScheduleInfo(param);
	}

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> getScheduleYearInMonth(Map<String, Object> param) throws Exception{
		return eventDao.getScheduleYearInMonth(param);
	}	/**
    *
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> getScheduleYearInMonthList(Map<String, Object> param) throws Exception{
		return eventDao.getScheduleYearInMonthList(param);
	}
	/**
     * 조회수를 증가 시킨다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public void updateEventContentsHits(Map<String, Object> param) throws Exception{
		eventDao.updateEventContentsHits(param);
	}
	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selecteventList(Map<String, Object> param) throws Exception{
		return eventDao.selecteventList(param);
	}

	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectevent(Map<String, Object> param) throws Exception{
		return eventDao.selectevent(param);
	}

	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selecteventExist(Map<String, Object> param) throws Exception {
		return eventDao.selecteventExist(param);
	}

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertevent(Map<String, Object> param) throws Exception{
		return eventDao.insertevent(param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateevent(Map<String, Object> param) throws Exception{
		return eventDao.updateevent(param);
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteevent(Map<String, Object> param) throws Exception{
		return eventDao.deleteevent(param);
	}

	/**
     * event 순서조정 정보를 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateeventReorder(Map<String, Object> param) throws Exception{
		return eventDao.updateeventReorder(param);
	}


	/**
     * event 순서조정 정보를 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */

	@Override
	public List<Map<String, Object>> selecteventArea(String mainType) throws Exception {
		return eventDao.selecteventArea(mainType);
	}

	@Override
	public String selectMainType() throws Exception {
		return eventDao.selectMainType();
	}

	@Override
	public List<Map<String, Object>> selecteventListBack(Map<String, Object> param) throws Exception {
		return eventDao.selecteventListBack(param);
	}
	
	@Override
	public List<Map<String, Object>> ScheduleList(Map<String, Object> param) throws Exception {
		return eventDao.ScheduleList(param);
	}
	
	@Override
	public Map<String, Object> ScheduleListBack(Map<String, Object> param) throws Exception {
		return eventDao.ScheduleListBack(param);
	}
	
	public int insertEvent(Map<String, Object> param) throws Exception{
		return eventDao.insertEvent(param);
	}
	
	public int updateEvent(Map<String, Object> param) throws Exception{
		return eventDao.updateEvent(param);
	}
	
	public int deleteEvent(Map<String, Object> param) throws Exception{
		return eventDao.deleteEvent(param);
	}
}
