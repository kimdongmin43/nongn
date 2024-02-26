package kr.apfs.local.contents.dao;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : OrgchartpageService.java
 * @Description : OrgchartpageService.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2017.06.26 최초생성
 *
 * @author msu
 * @since 2017. 06.26
 * @version 1.0
 *
 *  Copyright (C) by Intocps All right reserved.
 */
public interface OrgchartpageDao {



	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */

	public int selectOrgchartpageExist(Map<String, Object> param) throws Exception;

	/**
     * 조직도를 가져온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectOrgchartpage(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectIndicatorsback(Map<String, Object> param) throws Exception;

	public List <Map<String, Object>> selectOrgchartpage2(Map<String, Object> param) throws Exception;
	public List <Map<String, Object>> selectOrgchartAll(Map<String, Object> param) throws Exception;

	public List <Map<String, Object>> selectchart1(Map<String, Object> param) throws Exception;
	public List <Map<String, Object>> selectchart2(Map<String, Object> param) throws Exception;
	public List <Map<String, Object>> selectchart3(Map<String, Object> param) throws Exception;
	public List <Map<String, Object>> selectchart4(Map<String, Object> param) throws Exception;
	public List <Map<String, Object>> selectchart5(Map<String, Object> param) throws Exception;
	public List <Map<String, Object>> selectchart6(Map<String, Object> param) throws Exception;
	public List <Map<String, Object>> selectchartdn(Map<String, Object> param) throws Exception;

	public List <Map<String, Object>> selectchartcode(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectIndicators(Map<String, Object> param) throws Exception;
	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertOrgchartpage(Map<String, Object> param) throws Exception;

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateOrgchartpage(Map<String, Object> param) throws Exception;

	public int insertIndicators(Map<String, Object> param) throws Exception;

	public int updateIndicators(Map<String, Object> param) throws Exception;

	public int deleteIndicators(Map<String, Object> param) throws Exception;








}
