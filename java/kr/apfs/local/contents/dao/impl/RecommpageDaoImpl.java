/**
 * @Class Name : RecommpageDaoImpl.java
 * @Description : RecommpageDaoImpl.Class
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
import kr.apfs.local.contents.dao.RecommpageDao;

import org.springframework.stereotype.Repository;

@Repository("RecommpageDao")
public class RecommpageDaoImpl extends AbstractDao implements RecommpageDao  {

	/**
     * 추천사이트, 유관기관
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
 	public List<Map<String, Object>> selectRecommPageList(Map<String, Object> param) throws Exception{
 		return selectPageList("RecommpageDao.selectRecommPageList", param);
 	}

}
