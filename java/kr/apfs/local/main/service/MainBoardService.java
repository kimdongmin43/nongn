package kr.apfs.local.main.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : MainBoardService.java
 * @Description : MainBoardService.Class
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
public interface MainBoardService {

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectBoardList(Map<String, Object> param) throws Exception;

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectMainPhotoList(Map<String, Object> param) throws Exception;

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectMainEventList(Map<String, Object> param) throws Exception;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMainBoardList(Map<String, Object> param) throws Exception;

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */
	public List<Map<String, Object>> selectMainBoardContentsList(Map<String, Object> param) throws Exception;
	
	
	public List<Map<String, Object>> selectMainBoardContentsList2(Map<String, Object> param) throws Exception;


	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertMainBoard(Map<String, Object> param) throws Exception;


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMainBoard(Map<String, Object> param) throws Exception;


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteMainBoard(Map<String, Object> param) throws Exception;


}
