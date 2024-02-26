/**
 * @Class Name : BannerDaoImpl.java
 * @Description : BannerDaoImpl.Class
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
 
package kr.apfs.local.banner.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONValue;
import org.springframework.stereotype.Repository;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.banner.dao.BannerDao;

@Repository("BannerDao")
public class BannerDaoImpl extends AbstractDao implements BannerDao {

	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBannerPageList(Map<String, Object> param) throws Exception{
		return selectPageList("BannerDao.selectBannerPageList", param);
	}
	
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBannerList(Map<String, Object> param) throws Exception{
		return selectList("BannerDao.selectBannerList", param);
	}
	
	
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectBanner(Map<String, Object> param) throws Exception{
		return selectOne("BannerDao.selectBanner", param);
	}
	
	
	/**
     * 중복검사를 한다 
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int selectBannerExist(Map<String, Object> param) throws Exception{
		return selectOne("BannerDao.selectBannerExist", param);
	}
	
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertBanner(Map<String, Object> param) throws Exception{
		 return update("BannerDao.insertBanner", param);
	}
	
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBanner(Map<String, Object> param) throws Exception{
		return update("BannerDao.updateBanner", param);
	}
	
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteBanner(Map<String, Object> param) throws Exception{
		update("BannerDao.deleteBannerReorder", param);
		return delete("BannerDao.deleteBanner", param);
	}

	/**
     * banner 순서조정 정보를 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBannerReorder(Map<String, Object> param) throws Exception{
		int listSize=0;
		int resultNum=0;
		
		List<Map<String, Object>> jsonStringList = (List<Map<String, Object>>) JSONValue.parse(param.get("data").toString());
		listSize = jsonStringList.size();
		for (Map<String, Object> map : jsonStringList) {
			param.put("bannerId", map.get("bannerId"));
			param.put("sort", map.get("sort"));
			param.put("cTabGbn", map.get("cTabGbn"));
			resultNum+=update("BannerDao.updateBannerReoder", param);			
		}
		return listSize==resultNum?resultNum:0;
	}


	@Override
	public List<Map<String, Object>> selectBannerArea(String mainType) throws Exception {
		return selectList("BannerDao.selectBannerArea",mainType);
	}


	@Override
	public String selectMainType() throws Exception {
		return selectOne("BannerDao.selectMainType");
	}


	@Override
	public List<Map<String, Object>> selectBannerListBack(
			Map<String, Object> param) throws Exception {
		return selectList("BannerDao.selectBannerListBack", param);
	}
	
}
