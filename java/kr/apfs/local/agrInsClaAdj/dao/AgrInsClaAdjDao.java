package kr.apfs.local.agrInsClaAdj.dao;

import java.util.List;
import java.util.Map;

/**
 * 
 * @author Administrator
 *
 */
public interface AgrInsClaAdjDao {

	/**
	 * 손해평가사 실무교육 이수여부 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectAgrInsClaAdj(Map<String, Object> param) throws Exception;
	
}
