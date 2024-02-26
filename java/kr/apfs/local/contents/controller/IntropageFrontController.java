package kr.apfs.local.contents.controller;

import java.io.IOException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.util.CryptoUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.IntropageService;
import kr.apfs.local.contents.service.RecommpageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : IntropageController.java
 * @Description : IntropageController.Class
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
public class IntropageFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(IntropageFrontController.class);

	public final static String  FRONT_PATH = "/front/contents/";
	public final static String  BACK_PATH = "/back/contents/";
	//임시 지역 세션값
		//public final static String S_SITE_ID = "3";
		//public final static String CONT_ID = "34";

	@Resource(name = "IntropageService")
    private IntropageService intropageService;

	@Resource(name = "RecommpageService")
    private RecommpageService recommpageService;

/*	@RequestMapping(value ="/front/contents/intropage.do")
	public String membershipPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		param.put("contId", CONT_ID);
		param.put("*siteId", S_SITE_ID);
		String jsp = FRONT_PATH + "intropage";

		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@");
		//System.out.println(param);
		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@");
		Map<String, Object> introInfo = intropageService.selectIntropageFront(param);

		model.addAttribute("introInfo",introInfo);

		return jsp;
	}*/

	@RequestMapping(value ="/front/contents/membershipPage.do")
	public String membershipPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		//param.put("contId", CONT_ID);
		//param.put("*siteId", S_SITE_ID);
		String jsp = FRONT_PATH + "membershippage";

		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@");
		//System.out.println(param);
		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@");
		List <Map<String, Object>> memlist = intropageService.selectIntropage2(param);

		model.addAttribute("memlist",memlist);

		return jsp;
	}



	@RequestMapping(value ="/front/contents/incotermsPage.do")
	public String incotermsPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		//param.put("contId", CONT_ID);
		//param.put("*siteId", S_SITE_ID);
		String jsp = FRONT_PATH + "incotermspage";

		List <Map<String, Object>> incolist = intropageService.selectIncotermsPageList(param);

		model.addAttribute("incolist",incolist);

		return jsp;
	}


	@RequestMapping(value ="/front/contents/recommPage.do")
	public String recommPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		//param.put("contId", CONT_ID);
		//param.put("*siteId", S_SITE_ID);
		String jsp = FRONT_PATH + "recommpage";

		List <Map<String, Object>> recommlist = recommpageService.selectRecommPageList(param);

		model.addAttribute("recommlist",recommlist);

		return jsp;
	}
	
	@RequestMapping(value ="/front/contents/disclosurePage.do")
	public String disclosurePage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
		
		String aaa = CryptoUtil.AES_Encode("adins2");
		String bbb = CryptoUtil.AES_Encode("gen2014!@#");
		String eee = CryptoUtil.AES_Encode("net.sourceforge.jtds.jdbc.Driver");
		String fff = CryptoUtil.AES_Encode("jdbc:jtds:sqlserver://192.168.10.202:1433/apfs");
		String ccc = CryptoUtil.AES_Decode("4dScqQDRq/ZXQr/tzBRiiw==");
		String ddd = CryptoUtil.AES_Decode("iKG2Qd1WPxl6zKZkfHz77w==");
		String G7435 = CryptoUtil.AES_Encode("G7435");
		
		System.out.println("AES_Encode adins2 :" + aaa);
		System.out.println("AES_Encode gen2014!@# :" + bbb);
		System.out.println("AES_Encode net.sourceforge.jtds.jdbc.Driver!@# :" + eee);
		System.out.println("AES_Encode jdbc:jtds:sqlserver://192.168.10.202:1433/apfs :" + fff);
		System.out.println("AES_Decode 4dScqQDRq/ZXQr/tzBRiiw== :" + ccc);
		System.out.println("AES_Decode iKG2Qd1WPxl6zKZkfHz77w== :" + ddd);
		System.out.println("AES_Encode G7435 :" + G7435);
		
		String text = "adins2";
		byte[] targetBytes = text.getBytes();
		java.util.Base64.Encoder encoder = Base64.getEncoder();
		byte[] encodedBytes = encoder.encode(targetBytes);
		
		
		java.util.Base64.Decoder decoder = Base64.getDecoder();
		byte[] decoderdBytes = decoder.decode("4dScqQDRq/ZXQr/tzBRiiw==".getBytes());
		
		System.out.println("dmkim : " + new String(encodedBytes));
		System.out.println("dmkimde : " + new String(decoderdBytes));
		
		
		
		
		
		Map<String, Object> param = _req.getParameterMap();
		System.out.println("기준가격공시==="+param);
		//param.put("contId", CONT_ID);
		//param.put("*siteId", S_SITE_ID);
		String jsp = FRONT_PATH + "disclosurepage";
		
		// SQL Injection 방지 추가 - 2018.06.19(화) - (주)아사달 대리 함민석  ---  2022.01.26   아래 추가 내용은 운영서버에 적용되어 있지 않음
		String searchTxt = param.get("searchTxt") == null ? "" : (String)param.get("searchTxt");
		searchTxt = StringUtil.cleanSQLInjection(StringUtil.cleanXSSResult(searchTxt));
		System.out.println("searchTxt==="+searchTxt);
    	param.put("searchTxt", searchTxt);
		
    	// SQL Injection 방지 추가 - 2018.06.19(화) - (주)아사달 대리 함민석
		String searchTxt2 = param.get("searchTxt2") == null ? "" : (String)param.get("searchTxt2");
		searchTxt2 = StringUtil.cleanSQLInjection(StringUtil.cleanXSSResult_price(searchTxt2));		//230417 기준가격공시 함수명 : cleanXSSResult_price - () 으로 치환용
		System.out.println("searchTxt2==="+searchTxt2);
    	param.put("searchTxt2", searchTxt2);
    	
    	// SQL Injection 방지 추가 - 2018.06.19(화) - (주)아사달 대리 함민석
    	String searchTxt3 = param.get("searchTxt3") == null ? "" : (String)param.get("searchTxt3");
    	searchTxt3 = StringUtil.cleanSQLInjection(StringUtil.cleanXSSResult(searchTxt3));
    	System.out.println("searchTxt3==="+searchTxt3);
    	param.put("searchTxt3", searchTxt3);
    	
    	//230417 김동민 대리 기준가격공시 품목분류 추가
    	String searchTxt4 = param.get("searchTxt4") == null ? "" : (String)param.get("searchTxt4");
    	searchTxt4 = StringUtil.cleanSQLInjection(StringUtil.cleanXSSResult(searchTxt4));
    	System.out.println("searchTxt4==="+searchTxt4);
    	param.put("searchTxt4", searchTxt4);
    	//	---  2022.01.26   아래 추가 내용은 운영서버에 적용되어 있지 않음 - 여기까지
    	
		List <Map<String, Object>> dis = intropageService.selectDisclosurePage(param);
		List <Map<String, Object>> dis2 = intropageService.selectDisclosurePage_section(param);	//230418 김동민 대리 기준가격공시 품목분류
		List <Map<String, Object>> dis3 = intropageService.selectDisclosurePage_sectionNm(param);	//230418 김동민 대리 기준가격공시 품목명분류
		
		model.addAttribute("dis",dis);
		model.addAttribute("dis2",dis2);
		model.addAttribute("dis3",dis3);
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

		return jsp;
	}


	//230418 임동균: 분류에 맞는 품목명 리스트 가져오기
	@RequestMapping(value="/front/contents/disclosurePageCodeList.do")
	public ModelAndView mapTypeCodeList(ExtHtttprequestParam _req, @RequestParam("searchTxt4") String searchTxt4, ModelMap model, HttpSession session) throws Exception {
			Map<String, Object> param = _req.getParameterMap();
			
			param.put("searchTxt4", searchTxt4);
			List <Map<String, Object>> totalList  =  intropageService.selectDisclosurePage_sectionNm(param);

			param.put("dis3", totalList);
			
      	return ViewHelper.getJsonView(param);
    }	
	
	//실패...
	@RequestMapping(value="/front/contents/disclosureCodeList.do", method = RequestMethod.POST)
    public @ResponseBody HashMap disclosureCodeList(@RequestBody HashMap paramMap) throws Exception{
      	try{
      		List<HashMap> totalList  = (List<HashMap>) intropageService.selectDisclosureCodeList(paramMap);
      		System.out.println("totalList==="+totalList);
      		
      		
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
	

}//끝