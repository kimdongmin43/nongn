package kr.apfs.local.contents.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : VisionpageService.java
 * @Description : VisionpageService.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2017.06.26 최초생성
 *
 * @author sumoon
 * @since 2017. 06.26
 * @version 1.0
 *
 *  Copyright (C) by Intocps All right reserved.
 */
public interface VisionpageService {



	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */

	public int selectVisionpageExist(Map<String, Object> param) throws Exception;

	/**
     * 인사말 정보를 가져온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectVisionpage(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectVisionpage2(Map<String, Object> param) throws Exception;


	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertVisionpage(Map<String, Object> param) throws Exception;

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateVisionpage(Map<String, Object> param) throws Exception;




}
