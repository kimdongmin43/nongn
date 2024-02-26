package kr.apfs.local.contents.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.contents.service.ExepageService;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * @Class Name : ExepageController.java
 * @Description : ExepageController.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2015.05.10           최초생성
 *
 * @author jangcw
 * @since 2015. 05.10
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Intocps All right reserved.
 */

@Controller
public class ExepageFrontController extends ComAbstractController
{
	private static final Logger logger = LogManager.getLogger(ExepageFrontController.class);
	public final static String  FRONT_PATH = "/front/contents/";
	public final static String  BACK_PATH = "/back/contents/";
	//임시 지역 세션값
	//public final static String S_SITE_ID = "3";
	//임시 아이디
	//public final static String S_USER_ID = "0000000000";

	@Resource(name = "CommonFileService")
	private CommonFileService commonFileService;

	@Resource(name = "ExepageService")
	private ExepageService exepageService;



	@RequestMapping(value ="/front/contents/mapPage.do")
	public String exepageRankList(ExtHtttprequestParam _req, ListOp listOp, ModelMap model)
			throws Exception {
		
		Map<String, Object> param = _req.getParameterMap();
		
		/* 웹취약점 cross site scripting 처리 메소드 추가 - 숫자 유효성 검사 matchStringReplace 메소드 적용 (2018.06.18) - (주)아사달 대리 함민석 
		 * menuId 파라미터 저장하는 아래의 소스코드는 운영서버에 존재하지 않음 2022.01.26 */
		String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
    	menuId = StringUtil.cleanSQLInjection(StringUtil.matchStringReplace(menuId));
    	param.put("menuId", menuId);
    	
		String jsp = FRONT_PATH + "mappage";

		List <Map<String, Object>> exerank = exepageService.selectExepage2(param);
		model.addAttribute("exerank",exerank);

		return jsp;
	}



	@RequestMapping(value="/front/contents/getSearchMapData.do", method = RequestMethod.POST)
    public @ResponseBody HashMap getSearchMapData(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		paramMap.put("list", exepageService.selectExepage2(paramMap));

      		List<HashMap> totalList = (List<HashMap>)paramMap.get("list");
      		List<HashMap> sidoList = new ArrayList<HashMap>();
      		List<HashMap> sigunguList = new ArrayList<HashMap>();

      		for(HashMap map : totalList){
      			if(map.get("시도시군구").toString().length() == 2){
      				sidoList.add(map);
      			}
      			else{
      				sigunguList.add(map);
      			}
      		}

      		Double sidoParam1 = 0.0;
      		Double sidoParam2 = 0.0;
      		Double sidoParam3 = 0.0;
      		Double sidoParam4 = 0.0;
      		Double sidoParam5 = 0.0;

      		for(HashMap map : sidoList){
      			if(Double.parseDouble(map.get("위험보험료").toString()) > sidoParam1){
      				sidoParam1 = Double.parseDouble(map.get("위험보험료").toString());
      			}

      			if(Double.parseDouble(map.get("가입금액").toString()) > sidoParam2){
      				sidoParam2 = Double.parseDouble(map.get("가입금액").toString());
      			}
      			if(Double.parseDouble(map.get("지급금액").toString()) > sidoParam3){
      				sidoParam3 = Double.parseDouble(map.get("지급금액").toString());
      			}
      			if(Double.parseDouble(map.get("보험금지급건수").toString()) > sidoParam4){
      				sidoParam4 = Double.parseDouble(map.get("보험금지급건수").toString());
      			}
      			if(Double.parseDouble(map.get("인원").toString()) > sidoParam5){
      				sidoParam5 = Double.parseDouble(map.get("인원").toString());
      			}
      		}

      		paramMap.put("sidoMax위험보험료", sidoParam1);
      		paramMap.put("sidoMax가입금액", sidoParam2);
      		paramMap.put("sidoMax지급금액", sidoParam3);
      		paramMap.put("sidoMax보험금지급건수", sidoParam4);
      		paramMap.put("sidoMax인원", sidoParam5);

      		sidoParam1 = 0.0;
      		sidoParam2 = 0.0;
      		sidoParam3 = 0.0;
      		sidoParam4 = 0.0;
      		sidoParam5 = 0.0;

      		for(HashMap map : sigunguList){
      			if(Double.parseDouble(map.get("위험보험료").toString()) > sidoParam1){
      				sidoParam1 = Double.parseDouble(map.get("위험보험료").toString());
      			}
      			if(Double.parseDouble(map.get("가입금액").toString()) > sidoParam2){
      				sidoParam2 = Double.parseDouble(map.get("가입금액").toString());
      			}
      			if(Double.parseDouble(map.get("지급금액").toString()) > sidoParam3){
      				sidoParam3 = Double.parseDouble(map.get("지급금액").toString());
      			}
      			if(Double.parseDouble(map.get("보험금지급건수").toString()) > sidoParam4){
      				sidoParam4 = Double.parseDouble(map.get("보험금지급건수").toString());
      			}
      			if(Double.parseDouble(map.get("인원").toString()) > sidoParam5){
      				sidoParam5 = Double.parseDouble(map.get("인원").toString());
      			}
      		}

      		paramMap.put("sigunguMax위험보험료", sidoParam1);
      		paramMap.put("sigunguMax가입금액", sidoParam2);
      		paramMap.put("sigunguMax지급금액", sidoParam3);
      		paramMap.put("sigunguMax보험금지급건수", sidoParam4);
      		paramMap.put("sigunguMax인원", sidoParam5);

      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
        	logger.error("Exception error===", e);
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }


	@RequestMapping(value="/front/contents/mapTypeCodeList.do", method = RequestMethod.POST)
    public @ResponseBody HashMap mapTypeCodeList(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		List<HashMap> totalList  = (List<HashMap>) exepageService.selectExepage(paramMap);
      		paramMap.put("list", totalList);
      		paramMap.put("result","0");

     	}catch (IOException e) {
        	logger.error("IOException error===", e);
        	paramMap.put("result","1");
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	paramMap.put("result","1");
        }catch (Exception e){
        	logger.error("Exception error===", e);
     		paramMap.put("result","1");
     	}

      	return paramMap;
    }


	@RequestMapping(value ="/front/contents/exepageList.do")
	public String exepageList(ExtHtttprequestParam _req, ListOp listOp, ModelMap model)
			throws Exception {

		//임원1 rankList
		//의원2

		String jsp = "";

		Map<String, Object> param = _req.getParameterMap();
		if (param.get("exeGbn")==null || param.get("exeGbn")==null ) {
			param.put("exeGbn", 1);
		}

		if (param.get("exeGbn").toString().equals("1")) {
			jsp = FRONT_PATH + "exerankpage";
			List <Map<String, Object>> exerank = exepageService.selectExepage2(param);
			model.addAttribute("exerank",exerank);
		}
		else{
			jsp = FRONT_PATH + "exepage";
			model.addAttribute(ListOp.LIST_OP_NAME, listOp);
			List <Map<String, Object>> exepagelist = exepageService.selectExepage2(param);
			model.addAttribute("exepagelist",exepagelist);
		}

		model.addAttribute("defaulttype",_req.getP("defaulttype"));


		return jsp;

	}



}