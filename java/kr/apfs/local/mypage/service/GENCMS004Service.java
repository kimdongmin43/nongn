package kr.apfs.local.mypage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Class Name : GENCMS001Controller.java
 * @Description : CMS Engine ServiceImpl interface Class
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
public interface GENCMS004Service {

	public List<HashMap> getMapInfo(Map param)throws Exception;
	
	public List<HashMap> getCropList(Map param)throws Exception;
	
	public List<HashMap> getCropCodeList(Map param)throws Exception;
	
	public List<HashMap> getCropQTYList(Map param)throws Exception;
	
	public List<HashMap> getCropUnitCdList(Map param)throws Exception;
	
	public List<HashMap> getCropGradeList(Map param)throws Exception;
	
	public List<HashMap> getRegisterInfo(Map param)throws Exception;
	
	public List<HashMap> getRegisterActiveTime(Map param)throws Exception;
	
	public List<HashMap> getRegisterCropList(Map param)throws Exception;
	
	public List<HashMap> getRegisterRegList(Map param)throws Exception;
	
	public List<HashMap> getCropAllCodeTypeList(Map param)throws Exception;
	
	public List<HashMap> getCropAllCodeList(Map param)throws Exception;
	
	public List<HashMap> getRegCityCdList(Map param)throws Exception;
	
	public List<HashMap> getRegSigunguCdList(Map param)throws Exception;
	
	public HashMap updateRegisterInfo(Map param)throws Exception;
	
	public List<HashMap> getSearchRegister(Map param)throws Exception;
	
	public List<HashMap> getSearchMapData(Map param)throws Exception;
	
	public List<HashMap> getSearchTypeGubun(Map param)throws Exception;

	public List<HashMap> getAuthCheck(Map param)throws Exception;
	
	public List<HashMap> searchHistoryEdu(Map param)throws Exception;
	
	public List<HashMap> searchEdu(Map param)throws Exception;
	
	public List<HashMap> getEduStatusCode(Map param)throws Exception;
	
	public HashMap updateEdu(Map param)throws Exception;
	
	public List<HashMap> mapTypeCodeList(Map param)throws Exception;
	
	public List<HashMap> getSearchCodeYear(Map param)throws Exception; // 2016.10.05 보험1부 성혜수 요청 농작물공시 년도별 조회로 변경 
	
}
