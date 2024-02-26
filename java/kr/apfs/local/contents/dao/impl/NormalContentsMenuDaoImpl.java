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
import kr.apfs.local.contents.dao.NormalContentsMenuDao;

import org.springframework.stereotype.Repository;

@Repository("NormalContentsMenuDao")
public class NormalContentsMenuDaoImpl extends AbstractDao implements NormalContentsMenuDao {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	@Override
	public List<Map<String, Object>> selectNormalContentsMenuList(Map<String, Object> param) throws Exception {
		return selectList("IntropageDao.selectNormalContentsMeunList",param);
	}

	@Override
	public List<Map<String, Object>> selectInvestGridData(Map<String, Object> param) throws Exception {
		return selectList("IntropageDao.selectInvesGridData" , param);
	}

	@Override
	public Map<String, Object> selectInvestWritePage(Map<String, Object> param)throws Exception {
		return selectOne("IntropageDao.selectInvestWritePage",param);
	}

	@Override
	public int investInsert(Map<String, Object> param) throws Exception {
		return insert("IntropageDao.investInsert", param);
	}
	@Override
	public int investUpdate(Map<String, Object> param) throws Exception {
		return update("IntropageDao.investUpdate", param);
	}
	@Override
	public int investDelete(Map<String, Object> param) throws Exception {
		return delete("IntropageDao.investDelete", param);
	}

}
