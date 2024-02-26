package kr.apfs.local.contents.dao;

import java.util.List;
import java.util.Map;

@SuppressWarnings("unchecked")
public interface GuidancepageDao {

	public Map<String, Object> selectGuidancepage(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectGuidancepage2(Map<String, Object> param) throws Exception ;

	public int updateGuidancepage(Map<String, Object> param) throws Exception;

	public int selectGuidancepageExist(Map<String, Object> param) throws Exception;

	public int insertGuidancepage(Map<String, Object> param) throws Exception;



}
