package kr.apfs.local.contents.controller;

/*			2021.10.13    		*/
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.OrgchartpageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



/**
 * @Class Name : OrgchartpageController.java
 * @Description : OrgchartpageController.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2017.06.26   최초생성
 *
 * @author moonsu
 * @since 2017. 06.26
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Intocps All right reserved.
 */

//컨텐츠 인사말 컨트롤러
@Controller
public class OrgchartpageFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(OrgchartpageFrontController.class);

	public final static String  FRONT_PATH = "/front/contents/";
	public final static String  BACK_PATH = "/back/contents/";
	//임시 지역 세션값
	//public final static String S_SITE_ID = "3";
	//public final static String S_USER_ID = "0000000000";

	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;

	@Resource(name = "OrgchartpageService")
    private OrgchartpageService orgchartpageService;


	@RequestMapping(value ="/front/contents/Indicators.do")
	public String orgchartpageList(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		
		/* 
    	 * 추가 코드 - 2018.06.15(금) - (주)아사달 대리 함민석
    	*/
		String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
		menuId = StringUtil.cleanSQLInjection(StringUtil.matchStringReplace(menuId));
    	param.put("menuId", menuId);

		//임시지역코드
		//param.put("*siteId", S_SITE_ID);
		String jsp =  FRONT_PATH +"orgchartpage";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		List <Map<String, Object>> orgchartlist = orgchartpageService.selectOrgchartpage2(param);

		List <Map<String, Object>> orgchartall = orgchartpageService.selectOrgchartAll(param);


		model.addAttribute("defaulttype",_req.getP("defaulttype"));
		model.addAttribute("orgchartlist",orgchartlist);
		model.addAttribute("orgchartall",orgchartall);

		return jsp;
	}

	@RequestMapping(value ="/front/contents/chart1ListPage.do")
	public String chart1ListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		
		/*
		 * API 연결 농작물재해보험 - 품목별 데이터 가져오기 - 2021.10.13
		 * 초기화면 로딩 시 호출하면 안됨 - searchKey(년도)를 기준으로 판단
		*/
		List <Map<String, Object>> list2;
		if (param.get("searchKey") == null) {
			list2 = null;
		} else {
			list2 = convertListMap(param);
		}
		
		/* 
    	 * 추가 코드 - 2018.06.20(수) - (주)아사달 대리 함민석
    	*/
		String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
		menuId = StringUtil.cleanSQLInjection(StringUtil.matchStringReplace(menuId));
    	param.put("menuId", menuId);
    	
    	String searchKey = param.get("searchKey") == null ? "" : (String)param.get("searchKey");
    	searchKey = StringUtil.cleanXSSResult(searchKey);
    	param.put("searchKey", searchKey);

		//임시지역코드
		//param.put("*siteId", S_SITE_ID);
		String jsp =  FRONT_PATH +"chart1ListPage";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		//param.put("searchYM","201706");
		//List <Map<String, Object>> chartlist = orgchartpageService.selectchart1(param);			//	API 조회 사용으로 불필요 - 2021.10.20
		
		//model.addAttribute("chartlist",chartlist);		//	API 조회 사용으로 불필요 - 2021.10.20
		model.addAttribute("chartlist2",list2);		//	API에서 조회 - 2021.10.13
		System.out.println("chartlist1==="+list2);
		model.addAttribute("param",param);
		System.out.println("param==="+param);

		return jsp;
	}

	@RequestMapping(value ="/front/contents/chart2ListPage.do")
	public String chart2ListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		
		/*
		 * API 연결 농작물재해보험 - 지역별 데이터 가져오기 - 2021.10.14
		 * 초기화면 로딩 시 호출하면 안됨 - searchKey(년도)를 기준으로 판단
		*/
		List <Map<String, Object>> list2;
		if (param.get("searchKey") == null) {
			list2 = null;
		} else {
			list2 = convertListMap(param);
		}
		
		
		/* 
    	 * 추가 코드 - 2018.06.20(수) - (주)아사달 대리 함민석
    	*/
		String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
		menuId = StringUtil.cleanSQLInjection(StringUtil.matchStringReplace(menuId));
    	param.put("menuId", menuId);

		//임시지역코드
		//param.put("*siteId", S_SITE_ID);
		String jsp =  FRONT_PATH +"chart2ListPage";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		//param.put("searchYM","201706");
		//List <Map<String, Object>> chartlist = orgchartpageService.selectchart2(param);				//	API 조회 사용으로 불필요 - 2021.10.20

		//model.addAttribute("chartlist",chartlist);				//	API 조회 사용으로 불필요 - 2021.10.20
		System.out.println("chartlist2==="+list2);
		model.addAttribute("chartlist2",list2);		//	API에서 조회 - 2021.10.14
		model.addAttribute("param",param);

		return jsp;
	}


	@RequestMapping(value ="/front/contents/chart3ListPage.do")
	public String chart3ListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		
		/*
		 * API 연결 가축재해보험 - 축종별 데이터 가져오기 - 2021.10.14
		 * 초기화면 로딩 시 호출하면 안됨 - searchKey(년도)를 기준으로 판단
		*/
		List <Map<String, Object>> list2;
		if (param.get("searchKey") == null) {
			list2 = null;
		} else {
			list2 = convertListMap(param);
		}

		
		/* 
    	 * 추가 코드 - 2018.06.20(수) - (주)아사달 대리 함민석
    	*/
		String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
		menuId = StringUtil.cleanSQLInjection(StringUtil.matchStringReplace(menuId));
    	param.put("menuId", menuId);

		//임시지역코드
		//param.put("*siteId", S_SITE_ID);
		String jsp =  FRONT_PATH +"chart3ListPage";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		//param.put("searchYM","201707");
		//List <Map<String, Object>> chartlist = orgchartpageService.selectchart3(param);				//	API 조회 사용으로 불필요 - 2021.10.20

		//model.addAttribute("chartlist",chartlist);				//	API 조회 사용으로 불필요 - 2021.10.20
		model.addAttribute("chartlist2",list2);		//	API에서 조회 - 2021.10.14
		System.out.println("chartlist3==="+list2);
		model.addAttribute("param",param);

		return jsp;
	}
	@RequestMapping(value ="/front/contents/chart4ListPage.do")
	public String chart4ListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		
		/*
		 * API 연결 가축재해보험 - 지역별 데이터 가져오기 - 2021.10.14
		 * 초기화면 로딩 시 호출하면 안됨 - searchKey(년도)를 기준으로 판단
		*/
		List <Map<String, Object>> list2;
		if (param.get("searchKey") == null) {
			list2 = null;
		} else {
			list2 = convertListMap(param);
		}
		
		
		/* 
    	 * 추가 코드 - 2018.06.20(수) - (주)아사달 대리 함민석
    	*/
		String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
		menuId = StringUtil.cleanSQLInjection(StringUtil.matchStringReplace(menuId));
    	param.put("menuId", menuId);

		//임시지역코드
		//param.put("*siteId", S_SITE_ID);
		String jsp =  FRONT_PATH +"chart4ListPage";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		//param.put("searchYM","201706");
		//List <Map<String, Object>> chartlist = orgchartpageService.selectchart4(param);				//	API 조회 사용으로 불필요 - 2021.10.20

		//model.addAttribute("chartlist",chartlist);				//	API 조회 사용으로 불필요 - 2021.10.20
		model.addAttribute("chartlist2",list2);		//	API에서 조회 - 2021.10.14
		System.out.println("chartlist4==="+list2);
		model.addAttribute("param",param);

		return jsp;
	}
	@RequestMapping(value ="/front/contents/chart5ListPage.do")
	public String chart5ListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		String searchC = "";

		/*
		 * API 연결 보험료수준 - 농작물 데이터 가져오기 - 2021.10.14
		 * 초기화면 로딩 시 호출하면 안됨 - searchKey(년도)를 기준으로 판단
		*/
		List <Map<String, Object>> list2;
		if (param.get("searchKey") == null) {
			list2 = null;
		} else {
			list2 = convertListMap(param);
		}
		
		/* 
    	 * 추가 코드 - 2018.06.15(금) - (주)아사달 대리 함민석
    	*/
    	String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
    	menuId = StringUtil.cleanXSSResult(StringUtil.matchStringReplace(menuId));
    	param.put("menuId", menuId);
    	
    	String searchB = param.get("searchB") == null ? "" : (String)param.get("searchB");
    	searchB = StringUtil.cleanXSSResult(searchB);
    	param.put("searchB", searchB);
    	
    	if(param.get("searchC") != null){
    		searchC = param.get("searchC").toString().replaceAll("&amp; #40;", "(");
    		searchC = searchC.replaceAll("&amp;#41;", ")");
    		searchC = searchC.replaceAll("& #40;","(").replaceAll("& #41;", ")" );
    		param.put("searchC", searchC);
    	}

		//임시지역코드
		//param.put("*siteId", S_SITE_ID);
		String jsp =  FRONT_PATH +"chart5ListPage";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		param.put("codeKey","5");
		//List <Map<String, Object>> chartlist = orgchartpageService.selectchart5(param);				//	API 조회 사용으로 불필요 - 2021.10.20
		List <Map<String, Object>> codelist = orgchartpageService.selectchartcode(param);
		
		System.out.println(param);
		
		//model.addAttribute("chartlist",chartlist);				//	API 조회 사용으로 불필요 - 2021.10.20
		model.addAttribute("chartlist2",list2);		//	API에서 조회 - 2021.10.14
		System.out.println("chartlist5==="+list2);
		model.addAttribute("codelist",codelist);
		model.addAttribute("param",param);

		return jsp;
	}
	
	/**
	 * 농업정책보험 실적집계 > 보험료수준 > 가축 보험료수준 
	 * @param _req
	 * @param listOp
	 * @param model
	 * @return
	 * @throws Exception
	 * 2018.04.03 : 파라미터에 기준년도값이 존재하지 않을 경우 조회하지 않음.
	 * 
	 */	
	@RequestMapping(value ="/front/contents/chart6ListPage.do")
	public String chart6ListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		
		/*
		 * API 연결 보험료수준 - 농작물 데이터 가져오기 - 2021.10.14
		 * 초기화면 로딩 시 호출하면 안됨 - searchKey(년도)를 기준으로 판단
		*/
		List <Map<String, Object>> list2;
		if (param.get("searchKey") == null) {
			list2 = null;
		} else {
			list2 = convertListMap(param);
		}
		
		/* 
    	 * 추가 코드 - 2018.06.20(수) - (주)아사달 대리 함민석
    	*/
		String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
		menuId = StringUtil.cleanSQLInjection(StringUtil.matchStringReplace(menuId));
    	param.put("menuId", menuId);

		//임시지역코드
		//param.put("*siteId", S_SITE_ID);
		String jsp =  FRONT_PATH +"chart6ListPage";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		param.put("codeKey","6");
		
		// 2018.04.03 기준년도가 존재할 경우에만 조회처리하도록 변경
		//List <Map<String, Object>> chartlist = new ArrayList<Map<String, Object>>();				//	API 조회 사용으로 불필요 - 2021.10.20
		
		if(param.containsKey("searchYM")) {		
			//chartlist = orgchartpageService.selectchart6(param);					//	API 조회 사용으로 불필요 - 2021.10.20
		}
		
		List <Map<String, Object>> codelist = orgchartpageService.selectchartcode(param);

		//model.addAttribute("chartlist",chartlist);				//	API 조회 사용으로 불필요 - 2021.10.20
		model.addAttribute("chartlist2",list2);		//	API에서 조회 - 2021.10.14
		System.out.println("chartlist6==="+list2);
		model.addAttribute("codelist",codelist);
		model.addAttribute("param",param);

		return jsp;
	}

	/**
	 * 농업정책보험 실적집계 엑셀다운로드
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value ="/front/contents/chartDownload.do")
	public ModelAndView chartDownload(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();

    	/*
    	 * API 요청 조회 방식으로 변경 - 2021.10.20 
    	 */
/*    	System.out.println("****************================== 엑셀 다운로드    ========================************************");
    	System.out.println(param.toString());
    	System.out.println("****************================== 엑셀 다운로드    ========================************************");*/

    	List <Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		if (param.get("searchKey") == null) {
			System.out.println("searchKey11==="+param);
			list = null;
		} else {
			System.out.println("searchKey22==="+param);
			list = convertListMap(param);
		}

		navigator.setList(list);
		//		2021.10.20
    	
    	// 2018.04.03 가축보험료 수준의 천두당보험료_원, 천두당농가부담보험료_원 값이 0일 경우 '-' 출력하기 위한 수정 -> 여기 필요없을 것 같은데?? 2021.10.20
/*        if(param.containsKey("chartKey")) {
	        if(param.get("chartKey").equals("6")) {
	        	List <Map<String, Object>> list = new ArrayList<Map<String, Object>>();
	        	//	List <Map<String, Object>> result = orgchartpageService.selectchartdn(param);			//		API 요청 조회 방식으로 변경 불필요 - 2021.10.20	
	        	
	        	for (Map<String, Object> map : result) {
	        		//BigDecimal sum10 = new BigDecimal(20);
	        		//sum10 = (BigDecimal)map.get("sum10");        		
	        		//double dSum10 = sum10.doubleValue();
	        		//double dSum10 = 0.00000d;
					//if(dSum10 == 0.00000d) {
						//map.put("sum8", "-");
						//map.put("sum9", "-");
					//}				
					list.add(map);
				} 
				       	
	        	navigator.setList(list);
	        	
	        } else {
	        	navigator.setList(orgchartpageService.selectchartdn(param));	
	        }       
        }
*/        
        return ViewHelper.getJqGridView(navigator);
	}

	
	
	
	/**
	 * 농업정책보험 데이터 get 방식 API 로딩
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */

	
	
	/**
	 * JSON 형식을 List<Map>으로 변환 - 2021.10.13
	 * @param param : searchType-데이터 요청 구분, searchYear-데이터 요청 기준 년도, searchMonth-데이터 요청 기준 월, searchPrdlstLclas-데이터 요청 기준 대분류, searchPrdlstMlsfc-데이터 요청 기준 중분류, searchPrdlstSclas-데이터 요청 기준 소분류
	 * @return list : API 요청 결과 데이터
	 * @throws ParseException 
	 * @throws UnsupportedEncodingException 
	 * @throws Exception
	 */
	public List<Map<String, Object>> convertListMap(Map<String, Object> param) throws ParseException, UnsupportedEncodingException {	
    	List <Map<String, Object>> list = new ArrayList<Map<String, Object>>();
    	//String url = "http://211.55.33.107:8081/apfs/apfs/data/provdData.do"; 포도 개발서버
    	String url = "https://ais.apfs.kr/apfs/data/provdData.do";
    	//String url = "http://192.168.30.54/apfs/data/provdData.do";	//java.net.ConnectException: Connection refused: connect
    	//String url = "http://192.168.30.54:80/apfs/data/provdData.do";	//java.net.ConnectException: Connection refused: connect
    	//String url = "http://192.168.30.54:443/apfs/data/provdData.do";	//java.io.IOException: Server returned HTTP response code: 400 for URL: http://192.168.30.54:443/apfs/data/provdData.do?searchType=604&searchYear=2022&searchMonth=2&searchPrdlstLclas=&searchPrdlstMlsfc=&searchPrdlstSclas=
    	//String url = "https://192.168.30.54:443/apfs/data/provdData.do";	//javax.net.ssl.SSLHandshakeException: java.security.cert.CertificateException: No subject alternative names matching IP address 192.168.30.54 found
    	//String url = "192.168.30.54:80/apfs/data/provdData.do"; //no protocol: 192.168.30.54:80/apfs/data/provdData.do?searchType=604&searchYear=2022&searchMonth=4&searchPrdlstLclas=&searchPrdlstMlsfc=&searchPrdlstSclas=
    	//String testParam = "?searchType=601";				//	주요지표 - 농작물재해보험
    	//String APIParam = "?searchType=603&searchYear=2021&searchMonth=10";			//	농작물재해보험 - 폼목별 -> 9월 데이터는 없는데, 죄다 0으로 채워짐, 10월도 마찬가지(화면에서는 9월까지 검색 가능)
    	String APIParam = "";

    	String searchType = param.get("searchType") == null ? "" : (String)param.get("searchType");
    	searchType = StringUtil.cleanXSSResult(searchType);
    	System.out.println("searchType==="+searchType);
    	
    	String searchYear = param.get("searchKey") == null ? "" : (String)param.get("searchKey");
    	searchYear = StringUtil.cleanXSSResult(searchYear);
    	System.out.println("searchYear==="+searchYear);
    	
    	String searchMonth = param.get("strsearch") == null ? "" : (String)param.get("strsearch");
    	searchMonth = StringUtil.cleanXSSResult(searchMonth);
    	System.out.println("searchMonth==="+searchMonth);
    	
    	String searchPrdlstLclas = param.get("searchA") == null ? "" : (String)param.get("searchA");
    	searchPrdlstLclas = StringUtil.cleanXSSResult(searchPrdlstLclas);
    	System.out.println("searchPrdlstLclas==="+searchPrdlstLclas);
    	
    	String searchPrdlstMlsfc = param.get("searchB") == null ? "" : (String)param.get("searchB");
    	searchPrdlstMlsfc = StringUtil.cleanXSSResult(searchPrdlstMlsfc);
    	System.out.println("searchPrdlstMlsfc==="+searchPrdlstMlsfc);
    	
    	String searchPrdlstSclas = param.get("searchC") == null ? "" : (String)param.get("searchC");
    	searchPrdlstSclas = StringUtil.cleanXSSResult(searchPrdlstSclas);
    	System.out.println("searchPrdlstSclas==="+searchPrdlstSclas);
    	
    	APIParam += "?searchType=" + searchType;
    	APIParam += "&searchYear=" + searchYear;
    	APIParam += "&searchMonth=" + searchMonth;
    	APIParam += "&searchPrdlstLclas=" + URLEncoder.encode(searchPrdlstLclas, "utf-8");        	
    	APIParam += "&searchPrdlstMlsfc=" + URLEncoder.encode(searchPrdlstMlsfc, "utf-8");        	
    	APIParam += "&searchPrdlstSclas=" + URLEncoder.encode(searchPrdlstSclas, "utf-8");
    	System.out.println("APIParam==="+APIParam);
        try {
        	String jsonStr = getJSON(url, APIParam).get("resultData").toString(); 	//	일단 문자형으로 바꾸고 -> resultData = error001 인 경우는 데이터가 없는 경우임 
        	System.out.println("jsonStr==="+jsonStr);
        	if (jsonStr == "error001") {
        		return list;
        	} else {
        		ObjectMapper mapper = new ObjectMapper();
        		list = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>() {});
        	}
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        } catch (Exception e) {
            //e.printStackTrace();
        	logger.error("error===", e);
        }	
        		
        System.out.println("list==="+list);
        return list; 
	}

	/**
	 * API의 주소와 파라미터를 받아 JSON 형식으로 반환한다 - 2021.10.13
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public JSONObject getJSON(String url, String param) {
        StringBuffer jsonHtml = new StringBuffer();
		String uri = new String( url + param );
		System.out.println("uri==="+uri);
		URL u = null;
		
		BufferedReader br = null;
		InputStream uis = null;
		
		try {            
            u = new URL(uri);
            System.out.println("u==="+u);
            uis = u.openStream();
            System.out.println("uis==="+uis);

            br = new BufferedReader(new InputStreamReader(uis,"UTF-8"));
            System.out.println("br==="+br);
            String line = null;
            while ((line = br.readLine())!= null){
                    jsonHtml.append(line + "\n");
            }
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        } catch (Exception e) {
            //e.printStackTrace();
        	logger.error("error===", e);
        }
		finally{
			if (uis != null) {
	       		try {
	       			uis.close();
	       		} catch (IOException e) {
	       			logger.error("IOException error===", e);
	       			}
	       	}
			if (br != null) {
	       		try {
	       			br.close();
	       		} catch (IOException e) {
	       			logger.error("IOException error===", e);
	       			}
	       	}
		}
        JSONObject jsonObj = (JSONObject) JSONValue.parse(jsonHtml.toString());
        
        System.out.println("jsonObj==="+jsonObj);
        return jsonObj;
	}	
}

