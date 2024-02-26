package kr.apfs.local.event.controller;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.event.service.eventService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Class Name : eventFrontController.java
 * @Description : eventFrontController.Class
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
public class eventFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(eventFrontController.class);

	public final static String  FRONT_PATH = "/front/event/";

	@Resource(name = "eventService")
    private eventService eventService;

	/**
     * 게시판 메인 출력용 게시물
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/event/eventList.do")
    public String eventList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        String jsp = FRONT_PATH +"eventListPage";
        Map<String, Object> param = _req.getParameterMap();
        
        Calendar cal = Calendar.getInstance();
        
        /* 메뉴 아이디 Cross Site Scripting 웹 취약점 조치 - 2018.06.18(월) - (주)아사달 대리 함민석 */
        String menuId = param.get("menuId") == null ? "" : (String)param.get("menuId");
        menuId = StringUtil.cleanSQLInjection(StringUtil.matchStringReplace(menuId));
    	param.put("menuId", menuId);
        
        /* 연도, 구분 cross site scripting 웹 취약점 조치 - 2018.06.05(화) - (주)아사달 대리 함민석 */
		String strYear = param.get("SEARCH_YEAR") == null ? Integer.toString(cal.get(Calendar.YEAR)) :  (String)param.get("SEARCH_YEAR");
		strYear = StringUtil.cleanXSSResult(strYear);
		
		/* 추가코드 (2018.06.07) - (주)아사달 대리 함민석 */
		String schd_class = param.get("SCHD_CLASS") == null ? "01" :  (String)param.get("SCHD_CLASS");
		schd_class = StringUtil.cleanXSSResult(schd_class);
		
		/* 추가코드 (2018.06.07) - (주)아사달 대리 함민석 */
		String mvM = param.get("mvM") == null ? "0" : (String)param.get("mvM");
		mvM = StringUtil.cleanXSSResult(mvM);
		
		/* 추가코드 (2018.06.07) - (주)아사달 대리 함민석 */
		String mode = param.get("mode") == null ? "Y" : (String)param.get("mode");
		mode = StringUtil.cleanXSSResult(mode);
		
		/*
		param.put("menuId", menuId);
		param.put("mvM", mvM);
		param.put("mode", mode);
		param.put("SCHD_CLASS", schd_class);
		*/
		
		//model.put("param.menuId",menuId);
		model.put("param.mvM",mvM);
		model.put("param.mode",mode);
		model.put("param.SCHD_CLASS",schd_class);
		
		model.addAttribute("SEARCHYEAR", strYear);
		//model.addAttribute("SCHD_CLASS", schd_class); // 추가코드 (2018.06.05)
        return jsp;
    }


    /**
     * 게시판 메인 출력용 게시물
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/event/eventListYPage.do")
    public String eventListYPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
    	String jsp = "/sub"+FRONT_PATH +"eventList";
        Map<String, Object> param = _req.getParameterMap();
        Calendar cal = Calendar.getInstance();
    	String strYear = param.get("SEARCH_YEAR") == null ? Integer.toString(cal.get(Calendar.YEAR)) :  (String)param.get("SEARCH_YEAR");
    	    	
    	strYear = matchStringReplace(strYear); // 추가코드 (2018.06.05)
    	
    	/* 추가코드 (2018.06.07) - (주)아사달 대리 함민석 */
		String mvM = param.get("mvM") == null ? "0" : (String)param.get("mvM");
		mvM = matchStringReplace(mvM);
    	
    	param.put("SEARCHDATE", strYear);
    	param.put("mvM", mvM);
        List<Map<String, Object>> list = eventService.getScheduleInfo(param);
        
        List<Map<String, Object>> month = eventService.getScheduleYearInMonth(param);
        model.put("scheduleInfo", list );
        model.put("MONTH", month );
        
		model.addAttribute("SEARCHYEAR", 	strYear);
        return jsp;
    }

    /**
     * 게시판 메인 출력용 게시물
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/event/eventListMPage.do")
    public String eventListMPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
    	String jsp = "/sub"+FRONT_PATH +"eventMonth";
        Map<String, Object> param = _req.getParameterMap();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM");
        Calendar cal = Calendar.getInstance();
        String minVal2 = param.get("mvM") == null ? "0" :  (String)param.get("mvM");
        int minVal = Integer.parseInt(minVal2);
        cal.add(cal.MONTH, minVal);

        String beforeYear = dateFormat.format(cal.getTime()).substring(0,4);
        String beforeMonth = dateFormat.format(cal.getTime()).substring(4,6);


    	String strYear = beforeYear;
    	String strMon = beforeMonth;



    	param.put("SEARCH_YEAR", strYear);
    	param.put("SEARCH_MONTH", strMon);
        //List<Map<String, Object>> list = eventService.getScheduleInfo(param);

    	eventService.updateEventContentsHits(param); // 조회수를 증가(관리자 페이지에서는 조회수를 증가시키지 않음)
        List<Map<String, Object>> month = eventService.getScheduleYearInMonthList(param);
        //model.put("scheduleInfo", list );
        model.put("MONTH", month );


		model.addAttribute("SEARCHYEAR", 	strYear);
		model.addAttribute("SEARCHMONTH", 	strMon);
        return jsp;
    }


	/**
     * 교육 뷰
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/event/eventView.do")
    public String eventVIew(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        String jsp = FRONT_PATH +"eventView";
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> eventinfo = null;
        List<Map<String, Object>> list = eventService.getScheduleInfo(param);
        if(list.size()>0) {
        	eventinfo = list.get(0);
        }
        model.put("eventinfo", eventinfo );
        return jsp;
    }
    
    public static String matchStringReplace(String str){
		String match = "[^0-9]";
		String match2 = "[^\\d]";
		String match3 = "\\D";
		
		str = str.replaceAll(match, "");
		str = str.replaceAll(match2, "");
		str = str.replaceAll(match3, "");
		
		return str;
	}
    
}
