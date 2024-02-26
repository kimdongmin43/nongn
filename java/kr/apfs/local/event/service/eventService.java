package kr.apfs.local.event.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : eventService.java
 * @Description : eventService.Class
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
public interface eventService {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> getScheduleInfo(Map<String, Object> param) throws Exception;

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> getScheduleYearInMonth(Map<String, Object> param) throws Exception;

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> getScheduleYearInMonthList(Map<String, Object> param) throws Exception;
	/**
     * 조회수를 증가 시킨다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public void updateEventContentsHits(Map<String, Object> param) throws Exception;


	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selecteventList(Map<String, Object> param) throws Exception;


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectevent(Map<String, Object> param) throws Exception;


	/**
     * 중복 여부를 체크한다
     * @param param
     * @return
     * @throws Exception
     */
	public int selecteventExist(Map<String, Object> param) throws Exception;


	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertevent(Map<String, Object> param) throws Exception;


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateevent(Map<String, Object> param) throws Exception;


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteevent(Map<String, Object> param) throws Exception;



	public int updateeventReorder(Map<String, Object> param) throws Exception;

	/**
     * event 영역 데이터를 가져온다
     * @param
     * @return 	map
     * @throws 	Exception
     */
	public List<Map<String, Object>> selecteventArea(String mainType) throws Exception;


	/**
     * 메인타입을 가저온다
     * @param
     * @return 	map
     * @throws 	Exception
     */
	public String selectMainType() throws Exception;

	public List<Map<String, Object>> selecteventListBack(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> ScheduleList(Map<String, Object> param) throws Exception;

	public Map<String, Object> ScheduleListBack(Map<String, Object> param) throws Exception;

	public int insertEvent(Map<String, Object> param) throws Exception;

	public int updateEvent(Map<String, Object> param) throws Exception;

	public int deleteEvent(Map<String, Object> param) throws Exception;






}
