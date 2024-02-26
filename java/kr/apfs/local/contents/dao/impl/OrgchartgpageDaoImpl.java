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

import java.util.List;
import java.util.Map;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.contents.dao.OrgchartpageDao;

import org.springframework.stereotype.Repository;

@Repository("OrgchartpageDao")
public class OrgchartgpageDaoImpl extends AbstractDao implements OrgchartpageDao {


	/**
     * 인사말을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectOrgchartpage(Map<String, Object> param) throws Exception{
		return selectOne("OrgchartpageDao.selectOrgchartpage", param);
	}

     @SuppressWarnings("unchecked")
 	public Map<String, Object> selectIndicatorsback(Map<String, Object> param) throws Exception{
 		return selectOne("OrgchartpageDao.selectIndicatorsback", param);
 	}


     @SuppressWarnings("unchecked")
 	public List <Map<String, Object>> selectOrgchartpage2(Map<String, Object> param) throws Exception{
 		return selectList("OrgchartpageDao.selectOrgchartpage2", param);
 	}

     @SuppressWarnings("unchecked")
	public List <Map<String, Object>> selectOrgchartAll(Map<String, Object> param) throws Exception{
		return selectList("OrgchartpageDao.selectOrgchartAll", param);
	}


     @SuppressWarnings("unchecked")
 	public List <Map<String, Object>> selectchart1(Map<String, Object> param) throws Exception{
 		return selectList("OrgchartpageDao.selectchart1", param);
 	}
      @SuppressWarnings("unchecked")
  	public List <Map<String, Object>> selectchart2(Map<String, Object> param) throws Exception{
  		return selectList("OrgchartpageDao.selectchart2", param);
  	}
      @SuppressWarnings("unchecked")
  	public List <Map<String, Object>> selectchart3(Map<String, Object> param) throws Exception{
  		return selectList("OrgchartpageDao.selectchart3", param);
  	}
      @SuppressWarnings("unchecked")
  	public List <Map<String, Object>> selectchart4(Map<String, Object> param) throws Exception{
  		return selectList("OrgchartpageDao.selectchart4", param);
  	}
      @SuppressWarnings("unchecked")
  	public List <Map<String, Object>> selectchart5(Map<String, Object> param) throws Exception{
  		return selectList("OrgchartpageDao.selectchart5", param);
  	}
      @SuppressWarnings("unchecked")
  	public List <Map<String, Object>> selectchart6(Map<String, Object> param) throws Exception{
  		return selectList("OrgchartpageDao.selectchart6", param);
  	}
      @SuppressWarnings("unchecked")
    public List <Map<String, Object>> selectchartdn(Map<String, Object> param) throws Exception{
    		return selectList("OrgchartpageDao.selectchartdn", param);
    }
      @SuppressWarnings("unchecked")
	public List <Map<String, Object>> selectchartcode(Map<String, Object> param) throws Exception{
		return selectList("OrgchartpageDao.selectchartcode", param);
	}


     @SuppressWarnings("unchecked")
	public List <Map<String, Object>> selectIndicators(Map<String, Object> param) throws Exception{
		return selectList("OrgchartpageDao.selectIndicators", param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */

 	public int updateIndicators(Map<String, Object> param) throws Exception{
		return update("OrgchartpageDao.updateIndicators", param);
	}
 	
	public int deleteIndicators(Map<String, Object> param) throws Exception{
		return update("OrgchartpageDao.deleteIndicators", param);
	}


	public int insertIndicators(Map<String, Object> param) throws Exception {
		return insert("insertIndicators", param);
	}


	public int updateOrgchartpage(Map<String, Object> param) throws Exception{
		return update("OrgchartpageDao.updateOrgchartpage", param);
	}


	/**
     * 중복 체크를 한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectOrgchartpageExist(Map<String, Object> param) throws Exception {
		return selectOne("OrgchartpageDao.selectOrgchartpageExist", param);
	}

	/**
     * 값을 저장한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertOrgchartpage(Map<String, Object> param) throws Exception {
		return insert("insertOrgchartpage", param);
	}
}
