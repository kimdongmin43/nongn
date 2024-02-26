package kr.apfs.local.scheduling.service;

import java.util.List;
import java.util.Map;

public interface UserAgreeService {
	
	/**
     * 동의후 23개월(700일)인 사용자들
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectUserAgreeList(Map<String, Object> param) throws Exception;
	
	/**
     * 로그인 접속이 11개월이 지난 사용자들
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectUserLoginList(Map<String, Object> param) throws Exception;
}
