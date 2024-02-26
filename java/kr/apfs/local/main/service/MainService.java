package kr.apfs.local.main.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : MainService.java
 * @Description : MainService.Class
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
public interface MainService {


	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMainList(Map<String, Object> param) throws Exception;


	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertMain(Map<String, Object> param) throws Exception;


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMain(Map<String, Object> param) throws Exception;


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteMain(Map<String, Object> param) throws Exception;



	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectSearchContents(Map<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectSearchList(Map<String, Object> param) throws Exception;

}
