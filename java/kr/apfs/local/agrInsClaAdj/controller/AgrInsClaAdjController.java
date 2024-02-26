package kr.apfs.local.agrInsClaAdj.controller;

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

import kr.apfs.local.agrInsClaAdj.service.AgrInsClaAdjService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.util.ConfigUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.StringUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Class Name : AgrInsClaAdjController.java
 * @Modification Information
 * 손해평가사 조회 컨트롤러 
 * 
 * @author Administrator
 *
 */
@Controller
public class AgrInsClaAdjController {
	
	@Resource(name="AgrInsClaAdjService")
	private AgrInsClaAdjService agrInsClaAdjService;
	
	private static final Log logger = LogFactory.getLog(AgrInsClaAdjController.class);
	
	//20230208 김동민대리 기존의 DB조회 방식에서 통합정보시스템 API 통신 개발
	@RequestMapping(value="/front/agrInsClaAdj/selectAgrInsClaAdj.do")
	public String selectAgrInsClaAdj(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
		
Map<String, Object> param = _req.getParameterMap();
		
		String jsp = "/front/insu/adjuster";
		
		List <Map<String, Object>> lossAssessor;
		if (param.get("crqfc_no") == null) {
			lossAssessor = null;
		} else {
			lossAssessor = convertListMap(param);
		}
		
		String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
		menuId = StringUtil.cleanSQLInjection(StringUtil.matchStringReplace(menuId));
		param.put("menuId", menuId);
		
    	String crqfc_no = param.get("crqfc_no") == null ? "" : (String)param.get("crqfc_no");	//(150004 이문락	1964-01-27)
    	crqfc_no = StringUtil.cleanXSSResult(crqfc_no);
    	param.put("crqfc_no", crqfc_no);
    	
    	String user_nm = param.get("user_nm") == null ? "" : (String)param.get("user_nm");
    	user_nm = StringUtil.cleanXSSResult(user_nm);
    	param.put("user_nm", user_nm);
    	
    	String sMode = (String)param.get("mode");			//	2021.08.20 검색한 경우 mode=search 가짐 - 추가
		if (sMode == null) { sMode = "none";}

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		model.addAttribute("lossAssessor",lossAssessor);
		System.out.println("lossAssessor==="+lossAssessor);
		model.addAttribute("param",param);
		System.out.println("param==="+param);

		return jsp;
	}
	
	
	public List<Map<String, Object>> convertListMap(Map<String, Object> param) throws ParseException, UnsupportedEncodingException {	
    	List <Map<String, Object>> list = new ArrayList<Map<String, Object>>();
    	//String url = "http://220.78.192.3:30880/apfs/data/agrInsClaAdj.do?";	//포도 개발서버 IP. 방화벽 열려있음
    	//String url = "https://192.168.30.54/apfs/data/agrInsClaAdj.do?";		//포도 운양서버 IP, 방화벽 막혀있음 필요시 풀어달라고 요청
    	String url = "https://ais.apfs.kr/apfs/data/agrInsClaAdj.do?";			//포도 도메인
    	String APIParam = "";

    	String crqfc_no = param.get("crqfc_no") == null ? "" : (String)param.get("crqfc_no");		//자격증번호
    	crqfc_no = StringUtil.cleanXSSResult(crqfc_no);
    	System.out.println("crqfc_no==="+crqfc_no);
    	
    	String user_nm = param.get("user_nm") == null ? "" : (String)param.get("user_nm");			//이름
    	user_nm = StringUtil.cleanXSSResult(user_nm);
    	System.out.println("user_nm==="+user_nm);

    	
    	APIParam += "&crqfc_no=" + crqfc_no;       	
    	APIParam += "&user_nm=" + URLEncoder.encode(user_nm, "utf-8");
    	APIParam += "&data_type=json";
    	System.out.println("APIParam==="+APIParam);
        try {
        	String jsonStr = getJSON(url, APIParam).get("resultData").toString(); 	//	일단 문자형으로 바꾸고 -> resultData = error001 인 경우는 데이터가 없는 경우임 
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
        }catch (Exception e) {
            //e.printStackTrace();
        	logger.error("error===", e);
        }
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
		System.out.println("uri :" + uri);
		URL u = null;
		InputStream uis = null;
		BufferedReader br = null;
		
		try {            
            u = new URL(uri);
            uis = u.openStream();
            br = new BufferedReader(new InputStreamReader(uis,"UTF-8"));
            String line = null;
            while ((line = br.readLine())!= null){
                    jsonHtml.append(line + "\n");
                    System.out.println("jsonHtml : " + jsonHtml);
            }
            //br.close();
            //uis.close();        
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }catch (Exception e) {
            //e.printStackTrace();
        	logger.error("error===", e);
        }
        finally {
        	if (br != null) {
        		try {
        			br.close();
        		} catch (IOException e) {
        			logger.error(e);
        			}
        	}
        	if (uis != null) {
        		try {
        			uis.close();
        		} catch (IOException e) {
        			logger.error(e);
        			}
        	}
        }
        
        JSONObject jsonObj = (JSONObject) JSONValue.parse(jsonHtml.toString());
        
        System.out.println("jsonObj==="+jsonObj);
        return jsonObj;
	}
	
}
