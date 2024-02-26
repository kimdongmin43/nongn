package kr.apfs.local.main.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : MainDataService.java
 * @Description : MainDataService.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2015.05.10           최초생성
 *
 * @author kkh
 * @since 2016. 06.10
 * @version 1.0
 *
 *  Copyright (C) by Intocps All right reserved.
 */
public interface MainDataService {


	/**
     * E-Contents
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEContentsList(Map<String, Object> param) throws Exception;

	/**
     * 경제지표
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectProspectList(Map<String, Object> param) throws Exception;

	/**
     * 온라인세미나
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectSeminarList(Map<String, Object> param) throws Exception;


}
