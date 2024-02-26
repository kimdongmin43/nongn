package kr.apfs.local.popnoti.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.apfs.local.popnoti.dao.PopnotiDao;
import kr.apfs.local.popnoti.service.PopnotiService;

/**
 * @Class Name : PopnotiServiceImpl.java
 * @Description : PopnotiServiceImpl.Class
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

@Service("PopnotiService")
public class PopnotiServiceImpl implements PopnotiService {
	private static final Logger logger = LogManager.getLogger(PopnotiServiceImpl.class);
	
	@Resource(name = "PopnotiDao")
    protected PopnotiDao popnotiDao;
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectPopnotiPageList(Map<String, Object> param) throws Exception{
		return popnotiDao.selectPopnotiPageList(param);
	}
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectPopnotiList(Map<String, Object> param) throws Exception{
		return popnotiDao.selectPopnotiList(param);
	}
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectPopnoti(Map<String, Object> param) throws Exception{
		return popnotiDao.selectPopnoti(param);
	}
	
	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	@Override
	public int selectPopnotiExist(Map<String, Object> param) throws Exception {
		return popnotiDao.selectPopnotiExist(param);
	}
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertPopnoti(Map<String, Object> param) throws Exception{
		return popnotiDao.insertPopnoti(param);
	}
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updatePopnoti(Map<String, Object> param) throws Exception{
		return popnotiDao.updatePopnoti(param);
	}
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deletePopnoti(Map<String, Object> param) throws Exception{
		return popnotiDao.deletePopnoti(param);
	}

	/**
     * 메인페이지 팝업 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMainPopnotiList(Map<String, Object> param) throws Exception{
		return popnotiDao.selectMainPopnotiList(param);
	}
}
