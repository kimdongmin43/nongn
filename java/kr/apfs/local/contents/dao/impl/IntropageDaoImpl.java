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

package kr.apfs.local.contents.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.contents.dao.IntropageDao;

import org.springframework.stereotype.Repository;


@Repository("IntropageDao")
public class IntropageDaoImpl extends AbstractDao implements IntropageDao {
public static final int ROWSIZE = 10;
public static final String[] TITLE = {"인사말","연혁","역대회장","의원현황","조직도","비전(CI)","찾아오시는 길","상공회의소법령","안내"};




	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIntropagePageList(Map<String, Object> param) throws Exception{
		return selectPageList("IntropageDao.selectIntropagePageList", param);
	}
     
     
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDisclosurePage(Map<String, Object> param) throws Exception{
		return selectList("IntropageDao.selectDisclosurePage", param);
	}
     
     @SuppressWarnings("unchecked")
 	public List<Map<String, Object>> selectDisclosurePage_section(Map<String, Object> param) throws Exception{
 		return selectList("IntropageDao.selectDisclosurePage_section", param);
 	}
     
     @SuppressWarnings("unchecked")
  	public List<Map<String, Object>> selectDisclosurePage_sectionNm(Map<String, Object> param) throws Exception{
  		return selectList("IntropageDao.selectDisclosurePage_sectionNm", param);
  	}
     
     @SuppressWarnings("unchecked")
	public List<HashMap> selectDisclosureCodeList(Map<String, Object> param) throws Exception{
    	 return selectList("IntropageDao.selectDisclosureCodeList", param);
	} 
     
    
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectDisclosurePageback(Map<String, Object> param) throws Exception{
		return selectOne("IntropageDao.selectDisclosurePageback", param);
	} 
     

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIntropageList(Map<String, Object> param) throws Exception{
    	 List<Map<String, Object>> list = selectList("IntropageDao.selectIntropageList", param);
    	 
		
    	 return list;
	}

	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectIntropage(Map<String, Object> param) throws Exception{
		return selectOne("IntropageDao.selectIntropage", param);
	}

     @SuppressWarnings("unchecked")
	public List <Map<String, Object>> selectIntropage2(Map<String, Object> param) throws Exception{
		return selectList("IntropageDao.selectIntropage2", param);
	}


	/**
     * 중복검사를 한다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int selectIntropageExist(Map<String, Object> param) throws Exception{
		return selectOne("IntropageDao.selectIntropageExist", param);
	}


	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertIntropage(Map<String, Object> param) throws Exception{
		 return update("IntropageDao.insertIntropage", param);
	}


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateIntropage(Map<String, Object> param) throws Exception{
		return update("IntropageDao.updateIntropage", param);
	}


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteIntropage(Map<String, Object> param) throws Exception{
		return delete("IntropageDao.deleteIntropage", param);
	}
	
	
	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertDisclosure(Map<String, Object> param) throws Exception{
		 return update("IntropageDao.insertDisclosure", param);
	}


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateDisclosure(Map<String, Object> param) throws Exception{
		return update("IntropageDao.updateDisclosure", param);
	}

	@Override
	public Map<String, Object> selectIntropageFront(Map<String, Object> param)
			throws Exception {
		return selectOne("IntropageDao.selectIntropageFront",param);
	}

	/**
    * 무역용어사전
    * @param param
    * @return
    * @throws Exception
    */
    @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIncotermsPageList(Map<String, Object> param) throws Exception{
		return selectPageList("IntropageDao.selectIncotermsPageList", param);
	}
}
