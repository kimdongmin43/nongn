package kr.apfs.local.contents.dao;

import java.util.List;
import java.util.Map;


public interface HistorypageDao {

	public List<Map<String, Object>> selectHistorypage(Map<String, Object> param) throws Exception;

	public int updateHistorypage(Map<String, Object> param) throws Exception;

	public int selectHistorypageExist(Map<String, Object> param) throws Exception;

	public int insertHistorypage(Map<String, Object> param) throws Exception;
	
	public int deleteHistorypage(Map<String, Object> param) throws Exception;

}
