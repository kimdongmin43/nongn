package kr.apfs.local.banner.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : BannerService.java
 * @Description : BannerService.Class
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
public interface BannerService {
 
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBannerPageList(Map<String, Object> param) throws Exception;
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBannerList(Map<String, Object> param) throws Exception;
	
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectBanner(Map<String, Object> param) throws Exception;
	
	
	/**
     * 중복 여부를 체크한다
     * @param param
     * @return
     * @throws Exception
     */
	public int selectBannerExist(Map<String, Object> param) throws Exception;
	
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertBanner(Map<String, Object> param) throws Exception;
		
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateBanner(Map<String, Object> param) throws Exception;
	
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deleteBanner(Map<String, Object> param) throws Exception;


	
	public int updateBannerReorder(Map<String, Object> param) throws Exception;
	
	/**
     * banner 영역 데이터를 가져온다 
     * @param 	
     * @return 	map
     * @throws 	Exception
     */
	public List<Map<String, Object>> selectBannerArea(String mainType) throws Exception;
	

	/**
     * 메인타입을 가저온다 
     * @param 	
     * @return 	map
     * @throws 	Exception
     */
	public String selectMainType() throws Exception;
	
	public List<Map<String, Object>> selectBannerListBack(Map<String, Object> param) throws Exception;
	
	
	

	
	
}
