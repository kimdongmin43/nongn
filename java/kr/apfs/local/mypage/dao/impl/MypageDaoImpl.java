/**
 * @Class Name : IntropageDaoImpl.java
 * @Description : IntropageDaoImpl.Class
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

package kr.apfs.local.mypage.dao.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.mypage.dao.MypageDao;

import org.springframework.stereotype.Repository;

@Repository("MypageDao")
public class MypageDaoImpl extends AbstractDao implements MypageDao {
	public static final String[] months = {"jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec"};
	/**
     * 인사말을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectMypage(Map<String, Object> param) throws Exception{
		return selectOne("MypageDao.selectMypage", param);
	}


     @SuppressWarnings("unchecked")
	public List <Map<String, Object>> selectMypage2(Map<String, Object> param) throws Exception{
		return selectList("MypageDao.selectMypage2", param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMypage(Map<String, Object> param) throws Exception{
		int rv = 0;
		String [] product;
		String [] areas;
		Map<String,Object> productList = new HashMap<String, Object>();
		Map<String,Object> areasList = new HashMap<String, Object>();
		rv +=  update("MypageDao.updateMypageInfo", param);
		
		for (int i = 0; i < months.length; i++) {
			if (param.containsKey(months[i])) {
				param.put(months[i], "1");				
			}
			else
			{
				param.put(months[i], "0");
			}
		}	
		rv += update("MypageDao.updateActiveMonth", param);
		
		delete("deleteProduct",param.get("licenseKey").toString());
		
		if (param.containsKey("productSecond")) {
		
			product = (String[]) param.get("arrayProductSecond");			
			productList.put("licenseKey", param.get("licenseKey"));
			for (int i = 0; i < product.length; i++) {				
				productList.put("productCd", product[i]);
				insert("insertProduct",productList);
			}			
		}
		
		delete("deleteAreas",param.get("licenseKey").toString());
		
		if (param.containsKey("areasSecond")) {
			
			areas = (String[]) param.get("arrayAreasSecond");			
			areasList.put("licenseKey", param.get("licenseKey"));
			for (int i = 0; i < areas.length; i++) {				
				areasList.put("areaCd", areas[i]);
				insert("insertAreas",areasList);
			}			
		}
		
		
		
				
		
		return rv;
	}


	/**
     * 중복 체크를 한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectMypageExist(Map<String, Object> param) throws Exception {
		return selectOne("MypageDao.selectMypageExist", param);
	}

	/**
     * 값을 저장한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertMypage(Map<String, Object> param) throws Exception {
		return insert("insertMypage", param);
	}


	@Override
	public Map<String, Object> selectExist(Map<String, Object> param)throws Exception {
		return selectOne("MypageDao.selectExist",param);
	}
	@Override
	public Map<String, Object> mypageInfo(Map<String, Object> param)throws Exception {
		return selectOne("MypageDao.mypageInfo", param);
	}
	@Override
	public Map<String, Object> selectMonths(Map<String, Object> param)throws Exception {
		return selectOne("MypageDao.selectMonths",param);
	}
	@Override
	public List<Map<String, Object>> selectAreas(Map<String, Object> param)throws Exception {
		return selectList("MypageDao.selectAreas",param);
	}
	@Override
	public List<Map<String, Object>> selectItems(Map<String, Object> param)throws Exception {	
		return selectList("MypageDao.selectItems",param);
	}

	@Override
	public List<Map<String, Object>> selectSosokCd(Map<String, Object> param)throws Exception {
		return selectList("MypageDao.selectSosokCd",param);
	}

	@Override
	public List<Map<String, Object>> selectProductCd(Map<String, Object> param)throws Exception {
		return selectList("MypageDao.selectProductCd",param);
	}

	@Override
	public List<Map<String, Object>> selectMyProduct(Map<String, Object> param)throws Exception {
		return selectList("MypageDao.selectMyProduct",param);
	}


	@Override
	public List<Map<String, Object>> selectMyEduHistory(Map<String, Object> param) throws Exception{
		return selectList("MypageDao.selectMyEduHistory",param);
	}


	@Override
	public List<Map<String, Object>> selectMyEduFuture(Map<String, Object> param) throws Exception{
		return selectList("MypageDao.selectMyEduFuture",param);
	}


	@Override
	public List<Map<String, Object>> selectMyAreas(Map<String, Object> param) throws Exception {
		return selectList("MypageDao.selectMyAreas",param);
	}

}
