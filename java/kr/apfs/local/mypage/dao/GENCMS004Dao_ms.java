/**
 * @Class Name : MEMBER001Dao_ms.java
 * @Description : 관리자페이지 로그인 Class
 * @Modification Information  
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2016.03.14    김상진       최초생성
 * 
 * @author 개발팀 
 * @since 2016.03.14 
 * @version 1.0
 * @see Copyright (C) by Gentrust All right reserved.
 */

package kr.apfs.local.mypage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.common.dao.AbstractDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository("gencms004Dao_ms")
public class GENCMS004Dao_ms extends AbstractDao {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	/*@Autowired	
	public AG001Dao(SqlMapClient sqlMapClient) {
		super();
		setSqlMapClient(sqlMapClient);
	}
	*/	
	public List<HashMap> getCropList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getCropList", param);
	}
	public List<HashMap> getCropCodeList(Map param) throws DataAccessException{					
			return selectList("GENCMS004_MS.getCropCodeList", param);		
	}
	public List<HashMap> getCropQTYList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getCropQTYList", param);
	}
	public List<HashMap> getCropUnitCdList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getCropUnitCdList", param);
	}
	public List<HashMap> getCropGradeList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getCropGradeList", param);
	}
	public List<HashMap> getRegisterInfo(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getRegisterInfo", param);
	}
	public List<HashMap> getRegisterActiveTime(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getRegisterActiveTime", param);
	}
	public List<HashMap> getRegisterCropList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getRegisterCropList", param);
	}
	public List<HashMap> getRegisterRegList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getRegisterRegList", param);
	}
	public List<HashMap> getCropAllCodeTypeList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getCropAllCodeTypeList", param);
	}
	public List<HashMap> getCropAllCodeList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getCropAllCodeList", param);
	}
	public List<HashMap> getRegCityCdList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getRegCityCdList", param);
	}
	public List<HashMap> getRegSigunguCdList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getRegSigunguCdList", param);
	}
	public List<HashMap> updateRegisterInfo(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.updateRegisterInfo", param);
	}
	public List<HashMap> getRegisterActiveTimeCount(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getRegisterActiveTimeCount", param);
	}
	public List<HashMap> insertRegisterActiveTime(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.insertRegisterActiveTime", param);
	}
	public List<HashMap> updateRegisterActiveTime(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.updateRegisterActiveTime", param);
	}
	public List<HashMap> deleteRegCodeList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.deleteRegCodeList", param);
	}
	public List<HashMap> insertRegCodeList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.insertRegCodeList", param);
	}
	public List<HashMap> deleteCropList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.deleteCropList", param);
	}
	public List<HashMap> insertCropList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.insertCropList", param);
	}
	public List<HashMap> getSearchRegister(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getSearchRegister", param);
	}
	public List<HashMap> getSearchMapData(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getSearchMapData", param);
	}
	public List<HashMap> getSearchTypeGubun(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getSearchTypeGubun", param);
	}
	public List<HashMap> getAuthCheck(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getAuthCheck", param);
	}
	public List<HashMap> searchHistoryEdu(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.searchHistoryEdu", param);
	}
	public List<HashMap> searchEdu(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.searchEdu", param);
	}
	public List<HashMap> getEduStatusCode(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getEduStatusCode", param);
	}
	public List<HashMap> updateEdu(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.updateEdu", param);
	}
	public List<HashMap> mapTypeCodeList(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.mapTypeCodeList", param);
	}
	// 2016.10.05 보험1부 성혜수 요청 농작물공시 년도별 조회로 변경 ----------------------------------------
	public List<HashMap> getSearchCodeYear(Map param) throws DataAccessException{
			return selectList("GENCMS004_MS.getSearchCodeYear", param);
	}
	
}
