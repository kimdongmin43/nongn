package kr.apfs.local.site.dao;

import java.util.List;
import java.util.Map;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.site.vo.SiteVO;

import org.springframework.stereotype.Repository;

@Repository("SiteDao")
public class SiteDao extends AbstractDao {

	 public List<SiteVO> selectSiteList() throws Exception{
	 		return selectList("SiteDao.selectSiteList");
 	}

    public SiteVO selectSite(Map<String, Object> param) throws Exception{
 		return selectOne("SiteDao.selectSiteList", param);
 	}
}