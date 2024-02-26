package kr.apfs.local.banner.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.apfs.local.banner.dao.BannerDao;
import kr.apfs.local.banner.service.BannerService;

/**
 * @Class Name : BannerServiceImpl.java
 * @Description : BannerServiceImpl.Class
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

@Service("BannerService")
public class BannerServiceImpl implements BannerService {
	private static final Logger logger = LogManager.getLogger(BannerServiceImpl.class);
	
	@Resource(name = "BannerDao")
    protected BannerDao bannerDao;
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBannerPageList(Map<String, Object> param) throws Exception{
		return bannerDao.selectBannerPageList(param);
	}
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBannerList(Map<String, Object> param) throws Exception{
		return bannerDao.selectBannerList(param);
	}
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectBanner(Map<String, Object> param) throws Exception{
		return bannerDao.selectBanner(param);
	}
	
	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	@Override
	public int selectBannerExist(Map<String, Object> param) throws Exception {
		return bannerDao.selectBannerExist(param);
	}
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertBanner(Map<String, Object> param) throws Exception{
		return bannerDao.insertBanner(param);
	}
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateBanner(Map<String, Object> param) throws Exception{
		return bannerDao.updateBanner(param);
	}
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deleteBanner(Map<String, Object> param) throws Exception{
		return bannerDao.deleteBanner(param);
	}

	/**
     * banner 순서조정 정보를 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBannerReorder(Map<String, Object> param) throws Exception{
		return bannerDao.updateBannerReorder(param);
	}

	
	/**
     * banner 순서조정 정보를 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	
	@Override
	public List<Map<String, Object>> selectBannerArea(String mainType) throws Exception {
		return bannerDao.selectBannerArea(mainType);
	}

	@Override
	public String selectMainType() throws Exception {
		return bannerDao.selectMainType();
	}
	
	@Override
	public List<Map<String, Object>> selectBannerListBack(Map<String, Object> param) throws Exception {
		return bannerDao.selectBannerListBack(param);
	}
}
