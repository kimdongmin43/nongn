package kr.apfs.local.main.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : MainImageService.java
 * @Description : MainImageService.Class
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
public interface MainImageService {


	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMainImageList(Map<String, Object> param) throws Exception;


	/**
     * 리스트를 복사한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int copyMainImageList(Map<String, Object> param) throws Exception;

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertMainImage(Map<String, Object> param) throws Exception;


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMainImage(Map<String, Object> param) throws Exception;


	/**
     * 순서를 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int saveMainImageSort(Map<String, Object> param) throws Exception;

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteMainImage(Map<String, Object> param) throws Exception;


}
