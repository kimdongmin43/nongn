package kr.apfs.local.site.service.impl;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.site.dao.SiteDao;
import kr.apfs.local.site.service.SiteService;
import kr.apfs.local.site.vo.SiteVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @author P068995
 *
 */

@Service("SiteService")
public class SiteServiceImpl implements SiteService{
	private static final Logger logger = LogManager.getLogger(SiteServiceImpl.class);

	@Resource(name = "SiteDao")
    protected SiteDao siteDao;

	public List< SiteVO> selectSiteList() throws Exception{
		return siteDao.selectSiteList();
	}

	public SiteVO selectSite(Map<String, Object> param) throws Exception{
		return siteDao.selectSite(param);
	}

}