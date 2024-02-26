package kr.apfs.local.mypage.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.mypage.dao.GENCMS004Dao_ms;
import kr.apfs.local.mypage.service.GENCMS004Service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;


@Service("gencms004Service")
public class GENCMS004ServiceImpl implements GENCMS004Service {
	
	@Autowired
	private GENCMS004Dao_ms gencms004Daoms;
	
	private static final Log logger = LogFactory.getLog(GENCMS004ServiceImpl.class);
	protected Log log = LogFactory.getLog(this.getClass());

	//==============================================================================================================
	// GenCMS Engine 관련
	//==============================================================================================================
	// NAVI 정보 조회
	// HTML Contents 조회
	public List<HashMap> getMapInfo(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		//MapList = gencms004Daoms.getMapInfo(param);
		
		return MapList;
	}
	
	public List<HashMap> getCropList(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getCropList(param);
		
		return MapList;
	}
	
	public List<HashMap> getCropCodeList(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getCropCodeList(param);
		HashMap map = new HashMap();
		map.put("value", "전체");
		MapList.add(0, map);
		
		return MapList;
	}
	
	public List<HashMap> getCropQTYList(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getCropQTYList(param);
		
		return MapList;
	}
	
	public List<HashMap> getCropUnitCdList(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getCropUnitCdList(param);
		
		return MapList;
	}
	
	public List<HashMap> getCropGradeList(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getCropGradeList(param);
		
		return MapList;
	}
	
	public List<HashMap> getRegisterInfo(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getRegisterInfo(param);
		
		return MapList;
	}
	
	public List<HashMap> getRegisterActiveTime(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getRegisterActiveTime(param);
		
		return MapList;
	}
	
	public List<HashMap> getRegisterCropList(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getRegisterCropList(param);
		
		return MapList;
	}
	
	public List<HashMap> getRegisterRegList(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getRegisterRegList(param);
		
		return MapList;
	}
	
	public List<HashMap> getCropAllCodeTypeList(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getCropAllCodeTypeList(param);
		
		return MapList;
	}
	
	public List<HashMap> getCropAllCodeList(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getCropAllCodeList(param);
		
		return MapList;
	}
	
	public List<HashMap> getRegCityCdList(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getRegCityCdList(param);
		
		return MapList;
	}
	
	public List<HashMap> getRegSigunguCdList(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getRegSigunguCdList(param);
		
		return MapList;
	}
	
	public HashMap updateRegisterInfo(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		HashMap map = new HashMap();
		
		map.put("registerInfo", gencms004Daoms.updateRegisterInfo((HashMap)param.get("registerInfo")));
		int count = (Integer) gencms004Daoms.getRegisterActiveTimeCount((HashMap)param.get("registerInfo")).get(0).get("CNT");
		if(count > 0){
			map.put("registerActiveTime", gencms004Daoms.updateRegisterActiveTime((HashMap)param.get("registerActiveTime")));
		}
		else{
			map.put("registerActiveTime", gencms004Daoms.insertRegisterActiveTime((HashMap)param.get("registerActiveTime")));
		}
		
		List<HashMap> registerRegCodeList = (List<HashMap>)param.get("registerRegCodeList");
		gencms004Daoms.deleteRegCodeList((HashMap)param.get("registerInfo"));
		for(int i=0; i<registerRegCodeList.size(); i++){
			map.put("registerRegCodeList", gencms004Daoms.insertRegCodeList(registerRegCodeList.get(i)));
		}
		
		List<HashMap> registerCropList = (List<HashMap>)param.get("registerCropList");
		gencms004Daoms.deleteCropList((HashMap)param.get("registerInfo"));
		for(int i=0; i<registerCropList.size(); i++){
			map.put("registerCropList", gencms004Daoms.insertCropList(registerCropList.get(i)));
		}
		
		return map;
	}
	
	public List<HashMap> getSearchRegister(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getSearchRegister(param);
		
		return MapList;
	}
	
	public List<HashMap> getSearchMapData(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getSearchMapData(param);
		
		return MapList;
	}
	
	public List<HashMap> getSearchTypeGubun(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getSearchTypeGubun(param);
		
		return MapList;
	}
	
	public List<HashMap> getAuthCheck(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getAuthCheck(param);
		
		return MapList;
	}
	
	public List<HashMap> searchHistoryEdu(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.searchHistoryEdu(param);
		
		return MapList;
	}
	
	public List<HashMap> searchEdu(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.searchEdu(param);
		
		return MapList;
	}
	
	public List<HashMap> getEduStatusCode(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getEduStatusCode(param);
		
		return MapList;
	}
	
	public HashMap updateEdu(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		HashMap MapList = new HashMap();
		
		try{
			List<HashMap> list = (List<HashMap>)param.get("eduList");
			
			for(HashMap map : list){
				gencms004Daoms.updateEdu(map);
			}
			
			MapList.put("result", "0");
			
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	MapList.put("result", "1");
        }
		
		return MapList;
	}
	
	public List<HashMap> mapTypeCodeList(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.mapTypeCodeList(param);
		
		return MapList;
	}
	
	// 2016.10.05 보험1부 성혜수 요청 농작물공시 년도별 조회로 변경 ----------------------------------------
	public List<HashMap> getSearchCodeYear(Map param)throws Exception{
		log.debug("\n SUB_NUM : " + param.get("SUB_NUM"));
		
		List<HashMap> MapList = new ArrayList<HashMap>();
		
		MapList = gencms004Daoms.getSearchCodeYear(param);
		
		return MapList;
	}
	
}
