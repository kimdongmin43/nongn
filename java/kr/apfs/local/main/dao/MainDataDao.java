/**
 * @Class Name : MainDataDaoImpl.java
 * @Description : MainDataDaoImpl.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2015.05.10           최초생성
 *
 * @author kkh
 * @since 2017. 08.17
 * @version 1.0
 *
 *  Copyright (C) by KCCI All right reserved.
 */

package kr.apfs.local.main.dao;

import java.util.List;
import java.util.Map;

import kr.apfs.local.common.dao.AbstractDao;

import org.springframework.stereotype.Repository;

@Repository("MainDataDao")
public class MainDataDao extends AbstractDao {


	/**
     * E-Contents
     * @param param
     * @return
     * @throws Exception
     */

	public List<Map<String, Object>> selectEContentsList(Map<String, Object> param) throws Exception{
		return selectList("MainData.selectEContentsList", param);
	}

	/**
     * 경제지표
     * @param param
     * @return
     * @throws Exception
     */

	public List<Map<String, Object>> selectProspectList(Map<String, Object> param) throws Exception{
		return selectList("MainData.selectProspectList", param);
	}

	/**
     * 온라인세미나
     * @param param
     * @return
     * @throws Exception
     */

	public List<Map<String, Object>> selectSeminarList(Map<String, Object> param) throws Exception{
		return selectList("MainData.selectSeminarList", param);
	}
}
