package kr.apfs.local.contents.dao;

import java.util.List;
import java.util.Map;


public interface StatutepageDao {

	public Map<String, Object> selectStatutepage(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectStatutepage2(Map<String, Object> param) throws Exception;

	public int updateStatutepage(Map<String, Object> param) throws Exception;

	public int selectStatutepageExist(Map<String, Object> param) throws Exception;

	public int insertStatutepage(Map<String, Object> param) throws Exception;

}
