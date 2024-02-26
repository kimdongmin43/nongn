package kr.apfs.local.site.service;

import java.util.List;
import java.util.Map;

import kr.apfs.local.site.vo.SiteVO;

public interface SiteService {

	/**
     * 지역 상공 사이트 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<SiteVO> selectSiteList() throws Exception;

	/**
     * 지역 상공 사이트 정보
     * @param param
     * @return
     * @throws Exception
     */
	public SiteVO selectSite(Map<String, Object> param) throws Exception;


}
