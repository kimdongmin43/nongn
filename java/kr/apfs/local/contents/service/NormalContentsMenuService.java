package kr.apfs.local.contents.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : NormalContentsMenuService.java
 * @Description : NormalContentsMenuService.Class
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
public interface NormalContentsMenuService {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectNormalContentsMenuPageList(Map<String, Object> param) throws Exception;
	
	
	//투자조합 그리드데이터
	public List<Map<String, Object>> selectInvestGridData(Map<String, Object> param) throws Exception;
	//투자조합 글쓰기 데이터
	public Map<String,Object> selectInvestWritePage(Map<String,Object>param) throws Exception;
	//투자조합 입력
	public int investInsert(Map<String, Object> param)throws Exception;
	//투자조합 수정
	public int investUpdate(Map<String, Object> param)throws Exception;
	//투자조합 삭제
	public int investDelete(Map<String, Object> param)throws Exception;
	
	
	

	

}
