package kr.apfs.local.user.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.apfs.local.banner.service.BannerService;
import kr.apfs.local.board.service.BoardService;
import kr.apfs.local.common.Const;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.CryptoUtil;
import kr.apfs.local.common.util.DateUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.SmsSend;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.IntropageService;
import kr.apfs.local.footerinfo.service.FooterinfopageService;
import kr.apfs.local.main.service.MainBoardService;
import kr.apfs.local.main.service.MainDataService;
import kr.apfs.local.main.service.MainImageService;
import kr.apfs.local.main.service.MainService;
import kr.apfs.local.menu.service.MenuService;
import kr.apfs.local.popnoti.service.PopnotiService;
import kr.apfs.local.site.vo.SiteVO;
import kr.apfs.local.user.model.UserVO;
import kr.apfs.local.user.service.UserService;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author P068995
 *
 */
@Controller
public class UserFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(UserFrontController.class);

	public final static String  FRONT_PATH = "/front/user/";

	@Resource(name = "UserService")
    private UserService userService;

	@Resource(name = "MenuService")
    private MenuService menuService;

	@Resource(name = "IntropageService")
    private IntropageService intropageService;

	@Resource(name = "BannerService")
    private BannerService bannerService;

	@Resource(name = "BoardService")
    private BoardService boardService;
	
	@Resource(name = "MainService")
    private MainService mainService;

	@Resource(name = "MainBoardService")
    private MainBoardService mainBoardService;

	@Resource(name = "MainImageService")
    private MainImageService mainImageService;

	@Resource(name = "PopnotiService")
    private PopnotiService popnotiService;

	@Resource(name = "MainDataService")
    private MainDataService mainDataService;

	@Resource(name = "FooterinfopageService")
    private FooterinfopageService footerinfopageService;
	
	
	
	/**
     *  front Main 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/front/user/main.do")
	public String frontMain(ExtHtttprequestParam _req, ListOp listOp, HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {

		String jsp =  "/sub/front/user/main";
		

		Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> mainParam = new HashMap<String, Object>();
		
		//System.out.println("=======================");
		//System.out.println("session==="+session.getAttribute("*siteId"));
		//System.out.println("=======================");

		mainParam.put("pubYn", "Y" );
		mainParam.put("siteId", session.getAttribute("*siteId") );
		if(session.getAttribute("*siteId").equals("5") ){
			jsp +="B";
		}else{
			jsp +="A";		//	현재 동작하는 메인 페이지
		}

		if(param.containsKey("newMainId")){
			mainParam.put("mainId", param.get("newMainId") );
			mainParam.put("pubYn", null );
			mainParam.put("useYn", null );
			mainParam.put("delYn", null );
			param.put("mainId", param.get("newMainId"));
		}
		else if(param.containsKey("originMainId")){
			mainParam.put("mainId", param.get("originMainId") );
			mainParam.put("useYn", "Y" );
			mainParam.put("delYn", "N" );
			mainParam.put("pubYn", null );
			param.put("mainId", param.get("originMainId"));
		}
		List<Map<String,Object>> mainList = mainService.selectMainList(mainParam);
		param.put("mainId", "1");
		param.put("sectionCd", "1");

	    if(param.get("mainId")!=null){
logger.info("--------UserFrontController---------------------여기 실행되나? ");	    	
	    	 List<Map<String, Object>> mainBannerList = bannerService.selectBannerList(param);
	    	 List<Map<String, Object>> mainPhotoList =mainBoardService.selectMainPhotoList(param);
	    	 List<Map<String, Object>> mainBoardList = mainBoardService.selectMainBoardList(param);
	         /*List<Map<String, Object>> mainBoardContentsList = mainBoardService.selectMainBoardContentsList(param);*/
	         List<Map<String, Object>> mainBoardContentsList2 = mainBoardService.selectMainBoardContentsList2(param); 
	 		 Map<String, Object> footerInfopage = footerinfopageService.selectFooterinfopage(param);
	 		 List<Map<String, Object>> mainPopupList = popnotiService.selectMainPopnotiList(mainParam);




	         for(int i=1; i<=4; i++){
	        	 if(!model.containsAttribute("mainBoardList"+i)){
	        		 model.addAttribute("mainBoardList"+i, getMachList(mainBoardList,String.valueOf(i)) );
	        	 }
	         }


	         model.addAttribute("mainBoardList", mainBoardList);
	         model.addAttribute("mainBannerList", mainBannerList);
	         model.addAttribute("mainPhotoList", mainPhotoList);
	         model.addAttribute("mainPopupList", mainPopupList);
	         /*model.addAttribute("mainBoardContentsList", mainBoardContentsList);*/
	         model.addAttribute("mainBoardContentsList2", mainBoardContentsList2);
			 model.addAttribute("footerInfopage",footerInfopage);
	         model.addAttribute("mobileYn", session.getAttribute(Const.SESSION_MOBILE_YN).toString()=="Y"? true:false);
	    }

	    //System.out.println("서브는 대체 어디에..."+jsp);
        return jsp;
	}
	


	private List<Map<String, Object>> getMachList(List<Map<String, Object>> mainBoardList, String index){

		List<Map<String, Object>> partList = new ArrayList<Map<String, Object>>();

		for(Map<String, Object> map : mainBoardList){
			if(map.get("sectionCd").equals(index))
				partList.add(map);
        }

		return partList;
	}

	/**
     * 게시판 메인 출력용 게시물
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/user/initContents.do")
    public ModelAndView loadMainBoard(ExtHtttprequestParam _req, ModelMap model) throws Exception {
    	Map<String, Object> param = _req.getParameterMap();
    	if(param.get("mainId")!=null){

	         List<Map<String, Object>> mainBoardList = mainBoardService.selectMainBoardList(param);
	         List<Map<String, Object>> mainBoardContentsList = mainBoardService.selectMainBoardContentsList(param);

	         for(Map<String, Object> map : mainBoardContentsList){
	        	 map.put("contents", StringUtil.removeTag(StringUtil.nvl(map.get("contents"))));
	         }

	         model.addAttribute("mainBoardList", mainBoardList);
	         model.addAttribute("mainBoardContentsList", mainBoardContentsList);
	    }
        return ViewHelper.getJsonView(param);
    }

	/**
     *  공통 동적 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/front/user/dynaPage.do")
	public String dynaPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		String jsp =  "/front/user/dynaPage";

        return jsp;
	}

	/**
     *  사용자 로그인 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/front/user/login.do")
	public String login(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp =  "/comm/front/user/login";
		Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("leftNm", "로그인");
        return jsp;
	}

	/**
     *  사용자 로그인 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/front/user/logout.do")
	public ModelAndView logout(ExtHtttprequestParam _req, ModelMap model, HttpServletRequest request,HttpSession session) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
	    param.put("user_gb", "N"); // 사용자단에서 수정


	    Cookie[] cookies = request.getCookies();            // 요청에서 쿠키를 가져온다.

	    if(cookies != null) {
		    for(int i=0; i<cookies.length; i++) {
			    if(cookies[i].getName().equals("c_membid") || cookies[i].getName().equals("c_setyn") ) {
			    	cookies[i].setMaxAge(0);
			    }
		    }
	    }

	    session.invalidate();

	    return ViewHelper.getJsonView(param);
	}

	/**
	*  사용자단 메뉴리스트를 가져온다.
	* @param _req
	* @param model
	* @return
	* @throws Exception
	*/
	@RequestMapping(value = "/front/user/homepageMenuList.do")
	public @ResponseBody Map<String, Object> homepageMenuList(ExtHtttprequestParam _req, HttpSession session, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> topMenuList = menuService.selectHomepageMenuList(param);
		param.put("topMenuList", topMenuList);
		return param;
	}

	/**
     * 회원가입 (가입인증) 페이지로 이동을 한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/user/userRegistStep1Page.do")
	public String userRegistStep1Page(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = FRONT_PATH + "userRegistStep1Page";

        Map<String, Object> param = _req.getParameterMap();

        return jsp;
	}
    
    /*@RequestMapping(value = "/front/user/apiTest.do") //2022.12.20 김동민 api 테스트용
	public String apiTest(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = FRONT_PATH + "apiTest";

        Map<String, Object> param = _req.getParameterMap();
    	
        return jsp;
	}*/
	
    

    /**
     * 회원가입 (약관동의) 페이지로 이동을 한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/user/userRegistStep2Page.do")
	public String userRegistStep2Page(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        String civil_name = "";
        String jsp = FRONT_PATH + "userRegistStep2Page";
        Map<String, Object> param = _req.getParameterMap();

        // 이용약관 가져오기
        param.put("page_id", "9f603da0fad04dcc861eab7d77b547b7");
        model.addAttribute("agreement", intropageService.selectIntropage(param));

        // 개인정보보호정책 가져오기
        param.put("page_id", "c00759b0f6a34b9caa2065c3c3cab63c");
        model.addAttribute("privacy", intropageService.selectIntropage(param));

        if("yes".equals(StringUtil.nvl(param.get("realNameChk")))){
	        civil_name = URLDecoder.decode((String)param.get("CIVIL_NAME"), "utf-8");
	        model.addAttribute("civilNm", civil_name);
	        model.addAttribute("sms_number", (String)param.get("SMS_NUMBER"));
        }

        return jsp;
	}

    /**
     * 회원가입 (회원정보입력) 페이지로 이동을 한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/user/userRegistStep3Page.do")
	public String userRegistStep3Page(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = FRONT_PATH + "userRegistStep3Page";

        Map<String, Object> param = _req.getParameterMap();
        String selYear = StringUtil.nvl(param.get("p_year"),DateUtil.getCurrentYear());
		model.addAttribute("curYear", DateUtil.getCurrentYear());
		model.addAttribute("selYear", selYear);
		param.put("year", selYear);

        return jsp;
	}

    /**
     * 회원가입 (회원가입완료) 페이지로 이동을 한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/user/userRegistStep4Page.do")
	public String userRegistStep4Page(ExtHtttprequestParam _req, ModelMap model, HttpServletRequest req) throws Exception {

        String jsp = FRONT_PATH + "userRegistStep4Page";

        Map<String, Object> param = _req.getParameterMap();
        UserVO user = userService.selectUser(param);
	    model.addAttribute("user",user);

        return jsp;
	}

	/**
     * 이용약관 페이지로 이동을 한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/user/agreementPage.do")
	public String agreementPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = FRONT_PATH + "agreementPage";

        Map<String, Object> param = _req.getParameterMap();
        // 이용약관 가져오기
        param.put("page_id", "9f603da0fad04dcc861eab7d77b547b7");
        model.addAttribute("agreement", intropageService.selectIntropage(param));

        return jsp;
	}

    /**
     * 개인정보정책 페이지로 이동을 한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/user/privacyPage.do")
	public String privacyPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = FRONT_PATH + "privacyPage";

        Map<String, Object> param = _req.getParameterMap();
        // 개인정보보호정책 가져오기
        param.put("page_id", "c00759b0f6a34b9caa2065c3c3cab63c");
        model.addAttribute("privacy", intropageService.selectIntropage(param));

        return jsp;
	}

    /**
     * 회원정보 재동의 확인팝업으로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/user/reAgreementPopup.do")
	public String reAgreementPopup(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        return "/popup"+FRONT_PATH + "reAgreementPopup";
	}

    /**
     * 회원정보 재동의 확인
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/user/reAgreementPage.do")
	public String reAgreementPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = FRONT_PATH + "reAgreementPage";
        Map<String, Object> param = _req.getParameterMap();
        param.put("user_no", param.get("s_user_no"));
        UserVO user = userService.selectUser(param);
	    model.addAttribute("agree_dt", StringUtil.nvl(user.getAgreeDt()));

        // 이용약관 가져오기
        param.put("page_id", "9f603da0fad04dcc861eab7d77b547b7");
        model.addAttribute("agreement", intropageService.selectIntropage(param));

        // 개인정보보호정책 가져오기
        param.put("page_id", "c00759b0f6a34b9caa2065c3c3cab63c");
        model.addAttribute("privacy", intropageService.selectIntropage(param));

        return jsp;
	}

    /**
     * 아이디/패스워드 찾기 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/user/findIdPassPage.do")
	public String findIdPassPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
    	String civil_name = "";
    	String civil_mobile = "";
        String jsp = FRONT_PATH + "findIdPassPage";
        Map<String, Object> param = _req.getParameterMap();
        SmsSend sms = new SmsSend();

        if("yes".equals(StringUtil.nvl(param.get("realNameChk")))){
        	Map<String, Object> map = new HashMap();
	        civil_name = URLDecoder.decode(StringUtil.nvl(param.get("CIVIL_NAME")), "utf-8");
	        civil_mobile = StringUtil.nvl(param.get("SMS_NUMBER"));
	        String mode = StringUtil.nvl(param.get("mode")).substring(0,1);
	        String mobile = "";
	        String mobile1 = "";
	        String mobile2 = "";
	        String mobile3 = "";
	        int rv = 0;

	        if(civil_mobile.length() == 10){
	        	mobile1 = civil_mobile.substring(0, 3);
	        	mobile2 = civil_mobile.substring(3, 6);
	        	mobile3 = civil_mobile.substring(6, 10);
	        }else{
	        	mobile1 = civil_mobile.substring(0, 3);
	        	mobile2 = civil_mobile.substring(3, 7);
	        	mobile3 = civil_mobile.substring(7, 11);
	        }

	        mobile = mobile1+"-"+mobile2+"-"+mobile3;

	        param.put("user_mobile", CryptoUtil.AES_Encode(mobile));
	        param.put("user_nm", civil_name);

	        map = userService.selectUserPhoneExist(param);
	        if(map == null) {
	        	map = new HashMap();
	        	mode = "N";
	        }else{

		        if("I".equals(mode)){ // 아이디 찾기
		        	model.addAttribute("user_id", StringUtil.nvl(map.get("user_id")));
		        }else{ // 패스워드 찾기
		        	param.put("user_no", StringUtil.nvl(map.get("user_no")));
		        	String imsiPwd = RandomStringUtils.randomAlphanumeric(10);
		    		param.put("user_pw", CryptoUtil.SHA_encrypt(imsiPwd));
		       		rv = userService.updatePasswordChange(param);

		       		if(rv > 0){
		       			// 	send(mobile, imsiPwd);
		       			sms.sendMessage(civil_mobile, imsiPwd, "0221336588");
		       		}else{
		       			mode = "E";
		       		}
		        }
	        }
	        model.addAttribute("mode2", mode);
        }

        model.addAttribute("realNameChk", (String)param.get("realNameChk"));

        return jsp;
	}

    /**
     * 회원탈퇴 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/user/userDropOutPage.do")
	public String dropOutPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = "/popup"+FRONT_PATH + "userDropOutPage";

        Map<String, Object> param = _req.getParameterMap();

        return jsp;
	}

	/**
	 * 가입처리 해준다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/user/userRegist.do")
	public ModelAndView userRegist(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	    int rv =0;
	    Map<String, Object> param = _req.getParameterMap();
	    param.put("user_gb", "N"); // 사용자단에서 수정
	    try{
	       	// 이미 등록된 회원 확인
	        //rv = userService.selectUserExist(param);

	    	param.put("user_pw", CryptoUtil.SHA_encrypt(StringUtil.nvl(param.get("user_pw"))));
	    	if(!StringUtil.nvl(param.get("user_mobile")).equals(""))
    	        param.put("user_mobile", CryptoUtil.AES_Encode((String)param.get("user_mobile")));
    	    if(!StringUtil.nvl(param.get("user_email")).equals(""))
   	    	 	param.put("user_email", CryptoUtil.AES_Encode((String)param.get("user_email")));
    	    if(!StringUtil.nvl(param.get("user_tel")).equals(""))
   	    	 	param.put("user_tel", CryptoUtil.AES_Encode((String)param.get("user_tel")));

    	    param.put("user_no", CommonUtil.createUUID());
        	param.put("s_user_no", param.get("user_no"));
	    	rv = userService.insertUserRegist(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", "가입에 성공하였습니다. 로그인 후 이용해주십시요.");
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", "가입에 실패하였습니다."); // 실패 메시지
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        }catch(Exception e){
			//e.printStackTrace();
			logger.error("error===", e);
				param.put("success", "false"); 													// 실패여부 삽입
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
				return ViewHelper.getJsonView(param);
			}

	    return ViewHelper.getJsonView(param);

	}

	/**
	 * 회원수정 페이지로 이동을 한다.
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/user/userModifyPage.do")
	public String userModifyPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	    String jsp = FRONT_PATH + "userModifyPage";

		// 컨텐츠 최상위 분류를 가져온다.
		Map<String, Object> param = _req.getParameterMap();
	    param.put("user_no", param.get("s_user_no"));
	    UserVO user = userService.selectUser(param);
	    model.addAttribute("user",user);

	    return jsp;
	}

	/**
	 * 내정보 수정처리를 해준다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/user/userModify.do")
	public ModelAndView userModify(HttpServletRequest request, ExtHtttprequestParam _req, ModelMap model, HttpServletRequest req) throws Exception {

	    int rv =0;
	    Map<String, Object> param = _req.getParameterMap();

	    try{
	    	param.put("user_no", param.get("s_user_no"));
	    	rv = userService.updateUserModify(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", "내 정보수정에 성공하였습니다.");
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", "내 정보수정에 실패하였습니다."); // 실패 메시지
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        }catch(Exception e){
			//e.printStackTrace();
			logger.error("error===", e);
				param.put("success", "false"); 													// 실패여부 삽입
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
				return ViewHelper.getJsonView(param);
			}

	    return ViewHelper.getJsonView(param);
	}

	/**
	 * 패스워드 찾기를 처리 해준다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/user/passwordSearch.do")
	public ModelAndView passwordSearch(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	    int rv =0;
	    Map<String, Object> param = _req.getParameterMap();

	    try{
	       	// 이메일이 이미 있는지를 검색한다.
	        rv = userService.selectUserEmailExist(param);
	        if(rv > 0){
	        	param.put("pwd_confirm_word", CommonUtil.createUUID());
		    	rv = userService.updatePwdConfirmWord(param);

		       	if(rv > 0){
		       		// 메일을 전송한다.

					param.put("success", "true" );
		        	param.put("message", "암호를 재설정할 수 있는 이메일을 곧 받으실 것입니다. 이메일을 찾을 수 없으면 스팸 편지함 및 휴지통을 확인하십시오.");
				}else{
					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
					param.put("message", "암호재설정 정보를 전송하는데 실패하였습니다."); // 실패 메시지
				}
	        }else{
				param.put("success", "false");
				param.put("message", "정보와 일치하는 사용자를 찾을 수 없습니다.");
	        }
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        }catch(Exception e){
			//e.printStackTrace();
			logger.error("error===", e);
				param.put("success", "false"); 													// 실패여부 삽입
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
				return ViewHelper.getJsonView(param);
			}

	    return ViewHelper.getJsonView(param);
	}

	/**
	 * 패스워드 변경 페이지로 이동한다.
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/user/pwdChangePage.do")
	public String pwdChangePage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	    String jsp = FRONT_PATH + "pwdChangePage";

	    Map<String, Object> param = _req.getParameterMap();

	    return jsp;
	}

	/**
	 * 메인 패스워드 변경 팝업으로 이동한다.(90일 기준)
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/user/pwdChangePopup.do")
	public String pwdChangePopup(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	    String jsp = "/popup"+FRONT_PATH + "pwdChangePopup";

	    Map<String, Object> param = _req.getParameterMap();

	    return jsp;
	}

	/**
	 * 패스워드 변경을 처리 해준다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/user/passwordChange.do")
	public ModelAndView passwordChange(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	    int rv =0;
	    int chk = 0;
	    Map<String, Object> param = _req.getParameterMap();
	    String nowpw = StringUtil.nvl(param.get("now_pw"));

	    try{
	    	param.put("user_no", param.get("s_user_no"));
	    	// 기존패스워드 확인
	    	if(!"".equals(nowpw)){
	    		param.put("now_pw", CryptoUtil.SHA_encrypt(nowpw));
	    		chk = userService.selectUserPassExist(param);

	    		if(chk == 0){
	    			param.put("success", "false"); 													// 실패여부 삽입
					param.put("message", "비밀번호가 맞지 않습니다."); 				// 실패 메시지
					return ViewHelper.getJsonView(param);
	    		}

	    	}

	    	param.put("user_pw", CryptoUtil.SHA_encrypt(StringUtil.nvl(param.get("user_pw"))));
	    	rv = userService.updatePasswordChange(param);

	       	if(rv > 0){
				param.put("success", "true" );
	        	param.put("message", "비밀번호를 변경하였습니다.");
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", "비밀번호 변경에 실패하였습니다."); // 실패 메시지
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        }catch(Exception e){
			//e.printStackTrace();
			logger.error("error===", e);
				param.put("success", "false"); 													// 실패여부 삽입
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
				return ViewHelper.getJsonView(param);
			}

	    return ViewHelper.getJsonView(param);
	}

	/**
	 * 회원정보재동의 수정
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/user/updateAgreement.do")
	public ModelAndView updateAgreement(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	    int rv =0;
	    Map<String, Object> param = _req.getParameterMap();

	    try{
	    	rv = userService.updateAgreement(param);

	       	if(rv > 0){
				param.put("success", "true" );
	        	param.put("message", "회원정보 재동의 하였습니다.");
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", "회원정보 재동의에 실패하였습니다."); // 실패 메시지
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        }catch(Exception e){
			//e.printStackTrace();
			logger.error("error===", e);
				param.put("success", "false"); 													// 실패여부 삽입
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
				return ViewHelper.getJsonView(param);
			}

	    return ViewHelper.getJsonView(param);
	}

	/**
	 * 회원을 탈퇴 시킨다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/user/userDropOut.do")
	public ModelAndView userDropOut(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	    int rv =0;
	    Map<String, Object> param = _req.getParameterMap();

	    try{
	    	// 회원을 탈퇴 시킨다.
	    	param.put("user_no", param.get("s_user_no"));
	    	rv = userService.userDropOut(param);

	       	if(rv > 0){
				param.put("success", "true" );
	        	param.put("message", "탈퇴 하였습니다.");
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", "탈퇴에 실패하였습니다."); // 실패 메시지
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        }catch(Exception e){
			//e.printStackTrace();
			logger.error("error===", e);
				param.put("success", "false"); 													// 실패여부 삽입
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
				return ViewHelper.getJsonView(param);
			}

	    return ViewHelper.getJsonView(param);
	}

	/**
     * 중복 아이디 체크
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/user/userChkId.do")
    public ModelAndView userChkId(ExtHtttprequestParam _req, ModelMap model) throws Exception {
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
       	try{
       		rv = userService.selectUserExist(param);

	       	if(rv > 0){
				param.put("success", "false" );
				param.put("message", "중복된 아이디가 존재합니다.");
			}else{
				param.put("success", "true"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", "사용가능한 아이디입니다.");
			}
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
        }catch(Exception e){
        	//e.printStackTrace();
        	logger.error("error===", e);
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}

        return ViewHelper.getJsonView(param);
    }

	/**
	 * 주소팝업 페이지로 이동을 해준다.
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/user/jusoSearchPopup.do")
	public String jusoSearchPopup(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	    String jsp = "/sub"+FRONT_PATH + "jusoSearchPopup";

	    Map<String, Object> param = _req.getParameterMap();

	    return jsp;
	}

	/**
	 * 주소테스트 팝업 페이지로 이동을 해준다.
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/user/jusotest.do")
	public String jusoSearchTestPopup(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	    String jsp = FRONT_PATH + "jusoTest";

	    Map<String, Object> param = _req.getParameterMap();

	    return jsp;
	}

    /**
     * 주소를 가져온다
     * @param req
     * @param model
     * @param response
     * @throws Exception
     */
    @RequestMapping(value="/front/user/getAddrApi.do")
    public void getAddrApi(HttpServletRequest req, ModelMap model, HttpServletResponse response) throws Exception {
    	String currentPage = req.getParameter("currentPage");
		String countPerPage = req.getParameter("countPerPage");
		String resultType = req.getParameter("resultType");
		String confmKey = req.getParameter("confmKey");
		String keyword = req.getParameter("keyword");
		//System.out.println("*** API 시작 ***");
		String apiUrl = "http://www.juso.go.kr/addrlink/addrLinkApi.do?currentPage="+currentPage+"&countPerPage="+countPerPage+"&keyword="+URLEncoder.encode(keyword,"UTF-8")+"&confmKey="+confmKey+"&resultType="+resultType;
		URL url = new URL(apiUrl);
    	BufferedReader br = null;
    	StringBuffer sb = new StringBuffer();
    	String tempStr = null;
    	
    	try{
    		br = new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
    		while(true){
    			tempStr = br.readLine();
    			if(tempStr == null) break;
    			sb.append(tempStr);
    		}
    	}
    	catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        } catch (Exception e) {
            //e.printStackTrace();
        	logger.error("error===", e);
        }
    	finally{
    		if (br != null) {
	       		try {
	       			br.close();
	       		} catch (IOException e) {
	       			logger.error("IOException error===", e);
	       			}
	       	}
    	}
    	response.setCharacterEncoding("UTF-8");
		response.setContentType("text/xml");
		response.getWriter().write(sb.toString());
    }

    /**
     * 주소2를 가져온다
     * @param req
     * @param model
     * @param response
     * @throws Exception
     */
    @RequestMapping(value="/front/user/getAddrApi2.do")
    public void getAddrApi2(HttpServletRequest req, ModelMap model, HttpServletResponse response) throws Exception {

		String host = "http://10.182.60.22";
    	String currentPage = req.getParameter("currentPage");
		String countPerPage = req.getParameter("countPerPage");
		String resultType = req.getParameter("resultType");
		String confmKey = req.getParameter("confmKey");
		String keyword = req.getParameter("keyword");
		String apiUrl = host + "/addrlink/addrLinkApi.do?currentPage="+currentPage+"&countPerPage="+countPerPage+"&keyword="+URLEncoder.encode(keyword,"UTF-8")+"&confmKey="+confmKey;
		URL url = new URL(apiUrl);
		BufferedReader br = null;
    	StringBuffer sb = new StringBuffer();
    	String tempStr = null;
    	
    	try{
    		br = new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
	    	while(true){
	    		tempStr = br.readLine();
	    		if(tempStr == null) break;
	    		sb.append(tempStr);
	    	}
    	}
    	catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        } catch (Exception e) {
            //e.printStackTrace();
        	logger.error("error===", e);
        }
    	finally{
    		if (br != null) {
	       		try {
	       			br.close();
	       		} catch (IOException e) {
	       			logger.error("IOException error===", e);
	       			}
	       	}
    	}
    	response.setCharacterEncoding("UTF-8");
		response.setContentType("text/xml");
		response.getWriter().write(sb.toString());
    }
}
