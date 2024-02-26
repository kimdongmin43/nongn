package kr.apfs.local.board.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.apfs.local.board.service.BoardService;
import kr.apfs.local.common.fileupload.model.CommonFileVO;
import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.CryptoUtil;
import kr.apfs.local.common.util.EmailUtilForCCI;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.util.fileupload.FileUploadModel;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.file.service.AttachFileService;
import kr.apfs.local.menu.service.MenuService;
import nl.captcha.Captcha;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.apache.bcel.generic.ObjectType;
import org.hamcrest.core.IsEqual;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : BoardFrontController.java
 * @Description : BoardFrontController.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2017.02.19           최초생성
 *
 * @author kskim
 * @since 2017. 02.19
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Intocps All right reserved.
 */

@Controller
public class BoardFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(BoardFrontController.class);

	public final static String  FRONT_PATH = "/front/board/";

	@Resource(name = "BoardService")
    private BoardService boardService;

	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;

	@Resource(name = "AttachFileService")
    private AttachFileService fileService;

	@Resource(name = "MenuService")
	private MenuService menuService;

	/**
     * 게시판 리스트 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/boardContentsListPage.do")
	public String boardContentsListPage(ExtHtttprequestParam _req, ModelMap model , HttpSession session) throws Exception {


    	String jsp =  "";
    	 jsp = FRONT_PATH+"boardContentsListPage";

    	Map<String, Object> param = _req.getParameterMap();
    	Map<String, Object> boardinfo = new HashMap();
    	List<Map<String, Object>> category = null;
    	List<Map<String, Object>> viewSortList = null;
    	Map<String, Object> auth = new HashMap();
    	
    	if (param.containsKey("sName")) {
			session.setAttribute("MEMBER_AUTH", param);
		}

    	model.addAttribute("s_menuId",param.get("menuId"));
		model.addAttribute("s_boardId",param.get("boardId"));
		
        //	검색어(searchTxt) 필드 XSS 처리 - 2021.12.20
		String tmpSearchTxt = (String)param.get("searchTxt");
		if ( !((tmpSearchTxt == null) || (tmpSearchTxt.trim().isEmpty())) ) {
	        try {
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("'", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("\"", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&#34", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&#40", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&#39", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&quot", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&amp", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&#38", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("<", "");	
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&#60", "");	
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&lt", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&lt", "");	
	        	tmpSearchTxt = StringUtil.cleanXSS(tmpSearchTxt);
	       		param.put("searchTxt", tmpSearchTxt);	//	검색어
//	       		param.put("searchTxt", (StringUtil.cleanXSS((String)param.get("searchTxt"))));	//	검색어
	        }catch (NullPointerException e) {
	        	logger.error("NullPointerException error===", e);
	        	jsp = "/error.do";
				return jsp;
	        }catch(Exception e) {
				//e.printStackTrace();
	        	logger.error("error===", e);
				jsp = "/error.do";
				return jsp;
	        }
	        //	검색어(searchTxt) 필드 XSS 처리 끝
		}
			
		//농림수산식품모태펀드 온라인사업설명회(IR) url 직접 접근 차단
		if(param.get("boardId").equals("20077") || param.get("menuId").equals("53")){
			if(session.getAttribute("LOGININFO") == null){
				jsp = "/error.do";
				return jsp;
			}
		}
		if (param.get("boardId").equals("20072")||param.get("boardId").equals("20062")||param.get("boardId").equals("20075"))
	    {
			if (param.containsKey("sName"))
			{
				session.setAttribute("MEMBER_AUTH", param);
			}
			auth =  (Map<String, Object>) session.getAttribute("MEMBER_AUTH");
	        if (auth==null || !auth.containsKey("sName"))
	        {
	        	jsp = "/front/auth/auth";
			}
	        else
	        {
	        	if (!auth.get("sName").equals(""))
	        	{
	        		jsp = FRONT_PATH+"boardContentsListPage";
	        	}
	        }
	    }
 		
	    jsp = FRONT_PATH+"boardContentsListPage";

	    if(param.get("boardId") instanceof String[])
	    	param.put("boardId", ((String[])param.get("boardId"))[0]);
		boardinfo = boardService.selectBoardDetail(param);
		// 게시판 뷰설정목록 리스트
		viewSortList = boardService.selectBoardViewSortList(param);

		//카테고리 여부확인후. XR 카테고리 사용 안함 확인 사용여부 주석 처리
		//if(StringUtil.nvl(boardinfo.get("cate_yn")).equals("Y")){
			//카테고리 리스트 가져오기
    		//category = boardService.selectBoardCategoryList(param);
		//}

		model.addAttribute("boardinfo", boardinfo);
		model.addAttribute("viewSortList", viewSortList);
		model.addAttribute("category", category);
		
		
        return jsp;
	}

    /**
     * 게시물 타입별 리스트
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/boardContentsList.do")
	public String boardContentsList(ExtHtttprequestParam _req, ListOp listOp, ModelMap model , HttpSession session) throws Exception {

    	String jsp =  "/sub"+FRONT_PATH;

		NavigatorInfo navigator = new NavigatorInfo(_req);
		Map<String, Object> param  = navigator.getParam();
		Map<String, Object> boardinfo = new HashMap();
		Map<String, Object> auth = new HashMap();
		List<Map<String, Object>> viewSortList = null;
		param.put("sidx", "noti_yn DESC,reg_dt DESC, cont_id DESC, restep_seq");
		param.put("sord", "asc");

		auth = (Map<String, Object>) session.getAttribute("MEMBER_AUTH");

		/*
		if (param.get("boardId").equals("20072")||param.get("boardId").equals("20062")||param.get("boardId").equals("20075")) {
			param.put("sDupInfo", (auth.get("sDupInfo")));

		}
		 */

        //	검색어(searchTxt) 필드 XSS 처리 - 2021.12.20
		String tmpSearchTxt = (String)param.get("searchTxt");
		if ( !((tmpSearchTxt == null) || (tmpSearchTxt.trim().isEmpty())) ) {
	        try {
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("'", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("\"", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&#34", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&#40", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&#39", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&quot", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&amp", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&#38", "");
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("<", "");	
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&#60", "");	
	        	tmpSearchTxt = tmpSearchTxt.replaceAll("&lt", "");
	        	tmpSearchTxt = StringUtil.cleanXSS(tmpSearchTxt);
	       		param.put("searchTxt", tmpSearchTxt);	//	검색어
//	       		param.put("miv_pageNo", 1);	//2024 검색어 존재시 페이지번호 초기화	
//	       		navigator.setPageNo(1);		//2024 검색어 존재시 페이지번호 초기화
//	       		System.out.println("paramparamparam" + param);
	        }catch (NullPointerException e) {
	        	logger.error("NullPointerException error===", e);
	        	jsp = "/error.do";
				return jsp;
	        }catch(Exception e) {
				//e.printStackTrace();
	        	logger.error("error===", e);
				jsp = "/error.do";
				return jsp;
	        }
	        //	검색어(searchTxt) 필드 XSS 처리 끝
		}
		
		
		boardinfo = boardService.selectBoardDetail(param);
		param.put("boardId", StringUtil.nvl(boardinfo.get("boardId")));

		if("W".equals(boardinfo.get("boardCd"))){  // 요약형
			jsp +=  "boardContentsImgList";
			param.put("sidx", "reg_dt DESC, restep_seq");
		}else if("A".equals(boardinfo.get("boardCd"))){ // 앨범형
			jsp +=  "boardContentsImgList";
			param.put("sidx", "reg_dt DESC, restep_seq");
		}else if("I".equals(boardinfo.get("boardCd"))){ // 국제무역추천사이트
			jsp +=  "boardEtcList";
			param.put("sidx", "title");
		}else if("P".equals(boardinfo.get("boardCd"))){ // 국제무역추천사이트
			jsp +=  "boardGoodsList";
			param.put("sidx",  "reg_dt DESC,attach_id DESC, img_id2  ");
		}else{ // 일반형, QnA형
			jsp +=  "boardContentsList"; // 목록형, Qna형
		}
		param.put("backyn", "F"); // 사용자

		if("P".equals(boardinfo.get("boardCd")) || "I".equals(boardinfo.get("boardCd")) ){
			navigator.setList(boardService.selectBoardContentsPageListEtc(param));
		}else{
			if(!(param.get("boardId").equals("20075")||param.get("boardId").equals("20072")))
				navigator.setList(boardService.selectBoardContentsPageList(param));

			// 게시판 뷰설정목록 리스트
			viewSortList = boardService.selectBoardViewSortList(param);
			model.addAttribute("viewSortList", viewSortList);
		}
		model.addAttribute("boardinfo", boardinfo);
		model.addAttribute("boardList", navigator.getList());
		model.addAttribute("boardPagging", navigator.getPagging());
		model.addAttribute("totalcnt", navigator.getTotalCnt());
		
        return jsp;
	}

    /**
     * 게시물 등록 페이지 이동
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/boardContentsWrite.do", method = RequestMethod.POST)
	public String boardContentsWrite(ExtHtttprequestParam _req, ModelMap model , HttpSession session) throws Exception {

		String jsp = FRONT_PATH + "boardContentsWrite";

		Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> boardinfo = new HashMap();
		List<Map<String, Object>> category = null;
		Map<String, Object> contentsinfo = new HashMap();
		List<Map<String, Object>> viewSortList = null;
		Map<String, Object> auth = new HashMap();

		auth = (Map<String, Object>) session.getAttribute("MEMBER_AUTH");
		model.addAttribute("s_menuId",param.get("menuId"));
		model.addAttribute("s_boardId",param.get("boardId"));
		
		/**********   Session에 menu_id, board_id 값 저장 인증, 인가 강화 - 2021.01.08   */
		session.setAttribute("w_menuId"  , param.get("menuId"));
		session.setAttribute("w_boardId" , param.get("boardId"));
		/**********   인증, 인가 강화 끝 - 2021.01.08   */ 
		
		//240222 본인인증 우회 취약점 조치를 위한 인증 강화시작
		int rv =0;
		
		String sName = (String)session.getAttribute("sName");
		String SAFE_WRITER_NAME = (String)session.getAttribute("SAFE_WRITER_NAME");
		String sBirthDate = (String)session.getAttribute("sBirthDate");
//		System.out.println("111 : " + sName);
//		System.out.println("222 : " + SAFE_WRITER_NAME);
//		System.out.println("333 : " + sBirthDate);
		
		if( !(sName.equals(param.get("sName")))) {
//			System.out.println("sName불일치");
 			param.put("success", "false"); 													
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				
 			return "/error.do";
		}
		else if( !(SAFE_WRITER_NAME.equals(param.get("SAFE_WRITER_NAME")))) {
//			System.out.println("SAFE_WRITER_NAME불일치");
 			param.put("success", "false"); 													
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				
 			return "/error.do";
		}
		else if( !(sBirthDate.equals(param.get("sBirthDate")))) {
//			System.out.println("sBirthDate불일치");
 			param.put("success", "false"); 													
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				
 			return "/error.do";
		}
		//240222 본인인증 우회 취약점 조치를 위한 저장 인증 강화끝
		
		if(!(param.get("boardId").equals("51") || param.get("boardId").equals("20057") || param.get("boardId").equals("20075") || param.get("boardId").equals("20062")
				|| param.get("boardId").equals("20072")||param.get("boardId").equals("20082")||param.get("boardId").equals("20083") ||param.get("boardId").equals("20079"))){ //2022.07.12 김동민 대리 추가 || param.get("boardId").equals("20079")
			jsp = "/error.do";
			
			return jsp;
		}
		
		if(param.get("selTab") == null){
			param.put("selTab", "");
		}

		List<Map<String, Object>> fileList = null;
		boardinfo = boardService.selectBoardDetail(param);
		String boardCd = boardinfo.get("boardCd").toString();

		viewSortList = boardService.selectBoardViewSortList(param);

		if(!"W".equals(param.get("mode"))){
			
			if("E".equals(param.get("mode"))){
				jsp = "/error.do";
				return jsp;
			}
			
			/*contentsinfo = boardService.selectContentsDetail(param);*/
			if(boardCd.equals("P") || boardCd.equals("R") || boardCd.equals("I")){
				contentsinfo = boardService.selectContentsDetailEtc(param);		// 선택된 글에 정보
			}else{
				contentsinfo = boardService.selectContentsDetail(param);		// 선택된 글에 정보
			}
		}
		else{
			contentsinfo.put("openYn", "Y");
		}

		if (contentsinfo != null && contentsinfo.get("contents")!=null){
			contentsinfo.put("contents", contentsinfo.get("contents").toString().replaceAll("\'", "\\&#39;"));
		}

		// mode = A(답변쓰기) 일 경우 답변글에 attachIdAnswer를 가져 간다.
		if ("A".equals(param.get("mode"))){
			if(contentsinfo.get("attachIdAnswer") == null){
				param.put("attachId", "0"); // 그룹아이디가 없는경우 전체를 가져오기 방지
			}else{
				param.put("attachId", contentsinfo.get("attachIdAnswer"));
			}
		}else {

			if (contentsinfo != null) {
				if (contentsinfo.containsKey("attachId")) {
					if( contentsinfo.get("attachId") == null){						
						param.put("attachId", "0"); 
					}else{
						param.put("attachId", contentsinfo.get("attachId"));
					}
				}
			else
			{
				param.put("attachId", "0"); // 그룹아이디가 없는경우 전체를 가져오기 방지
			}
				
			}
		}

		//fileList = fileService.selectFileList(param);
		
		fileList = commonFileService.getCommonFileList(param);		// attachId만 넘겨줘야함
		
		//카테고리 여부확인후
		//if(StringUtil.nvl(boardinfo.get("cate_yn")).equals("Y")){
			//카테고리 리스트 가져오기
			category = boardService.selectBoardCategoryList(param);
		//}

		model.addAttribute("name", param.get("s_user_name"));
    	model.addAttribute("boardinfo", boardinfo);
    	model.addAttribute("category", category);
		model.addAttribute("viewSortList", viewSortList);
    	model.addAttribute("contentsinfo", contentsinfo);
    	model.addAttribute("fileList", fileList);
    	
    	

    	//	실명인증이 필요한 경우, 해당 게시판의 boardId 값 검사 조건을 넣어야 함 - 20062 : 고객제안 추가        2020.10.08 
    	if ( param.get("boardId").equals("51") || param.get("boardId").equals("20062") || param.get("boardId").equals("20079")) //2022.07.12 김동민 대리 추가 || param.get("boardId").equals("20079")
	    {
			if (param.containsKey("sName"))
			{
				session.setAttribute("MEMBER_AUTH", param);
			}
			else{
				session.setAttribute("MEMBER_AUTH", param);
			}
			//개발서버 글쓰기 페이지 이동위한 주석임. 운영 반영시 주석 풀어야 함.		//2022.07.12 김동민 대리 글 등록 테스트 위해서 잠시 주석했으니 반드시 풀어야함
			if ((auth==null || !param.containsKey("sName")))
	        {
	        	jsp = "/front/auth/auth";
			}
	        else
	        {
			
	        	if (!param.get("sName").equals(""))
	        	{
			
	        		jsp = FRONT_PATH+"boardContentsWrite";
	        
	    		}
	        }
			jsp = FRONT_PATH+"boardContentsWrite";
	    }
        return jsp;
	}

    /**
     * 게시판 상세 페이지로 이동한다. - 비밀글인지 확인. 비밀글인 경우 Session에 저장된 contId 값과 비교하고 맞을 때만 상세보기 가능
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/boardContentsView.do")
	public String boardContentsView(ExtHtttprequestParam _req, HttpSession session, ModelMap model) throws Exception {

        String jsp = FRONT_PATH + "boardContentsView";

        Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> boardinfo = new HashMap();
		Map<String, Object> contentsinfo = new HashMap();
		Map<String, Object> prenext = new HashMap();
		Map<String, Object> member_auth = new HashMap();
		Map<String, Object> fileparam = new HashMap();
		List<Map<String, Object>> fileList = null;
		List<Map<String, Object>> viewSortList = null;
		String editYn = "";

		String menuId = (String) param.get("menuId");
		contentsinfo = boardService.selectContentsDetail(param);		//	게시물 상세내용 조회
		
		/*****************
		 * 조회한 게시물이 비밀글이면 세션에 저장한 SECRET_CONT_ID 값과 contId 값을 비교한다 
		 * 2021.06.17
		 */
		if ("N".equals(contentsinfo.get("openYn"))) {
			String secretContId;
			if (session.getAttribute("SECRET_CONT_ID") != null) {
				secretContId = session.getAttribute("SECRET_CONT_ID").toString();
				session.removeAttribute("SECRET_CONT_ID");
			} else {
				secretContId = "";
			}
			
			int rv =0;
			if ( !( secretContId.equals(contentsinfo.get("contId").toString()) ) ) {
				jsp = "/error.do";
				return jsp;
			}
		}

		
		if(menuId == null){
			param.put("menuId", contentsinfo.get("menuId"));
			Map<String, Object> menu = menuService.selectMenu(param);
			session.setAttribute("MENU", menu);
		}
		param.put("boardId", contentsinfo.get("boardId"));

		// 패스워드가 있는 경우 패스워드 창으로 호출
		if("Y".equals(contentsinfo.get("pass_yn")) && !"Y".equals(param.get("chkpass")) && "Y".equals(contentsinfo.get("secret"))){
			jsp = FRONT_PATH + "boardContentsPass";
			model.addAttribute("rt","V");

			return jsp;
		}

		if(contentsinfo.get("attachId") == null){
			param.put("attachId", "0"); // 그룹아이디가 없는경우 전체를 가져오기 방지
		}else{
			param.put("attachId", contentsinfo.get("attachId"));
		}
		
		fileparam.put("attachId", param.get("attachId"));
		fileList = commonFileService.getCommonFileList(fileparam);
		boardinfo = boardService.selectBoardDetail(param);
		prenext = boardService.selectPreNextContents(param); // 이전글 다음글을 가져온다.
		boardService.updateBoardContentsHits(param); // 조회수를 증가(관리자 페이지에서는 조회수를 증가시키지 않음)

		viewSortList = boardService.selectBoardViewSortList(param);

		if(contentsinfo.get("attachId") == null){
			param.put("attachId", "A"); // 그룹아이디가 없는경우 전체를 가져오기 방지
		}else{
			param.put("attachId", contentsinfo.get("attachId"));
		}

		//List<CommonFileVO> fileList = commonFileService.getCommonFileList(param);		// attachId만 넘겨줘야함

		
		member_auth = (Map<String, Object>) session.getAttribute("MEMBER_AUTH");
		String boardId = boardinfo.get("boardId").toString();
		if (boardId.equals("51")||boardId.equals("20062")||boardId.equals("20075")||boardId.equals("20072")||boardId.equals("20057")) {
				if (contentsinfo.containsKey("dikey")) {					
					if (member_auth!= null && member_auth.containsKey("sDupInfo")) {				
						if (contentsinfo.get("dikey").equals(member_auth.get("sDupInfo"))) {				
							model.addAttribute("editYn","Y");
						}else{
							if (contentsinfo.get("dikey").equals("") && contentsinfo.get("regMemNm").equals(member_auth.get("sName"))    ) {							
								model.addAttribute("editYn","Y");
							}
							else
							{							
								model.addAttribute("editYn","N");
							}
						}
					}
				}
				else {
					model.addAttribute("editYn","N");					
				}
		}


		
		model.addAttribute("name", param.get("s_user_name"));
    	model.addAttribute("boardinfo", boardinfo);
    	model.addAttribute("contentsinfo", contentsinfo);
    	model.addAttribute("prenext", prenext);
		model.addAttribute("viewSortList", viewSortList);
    	model.addAttribute("fileList", fileList);
    	System.out.println("fileList" + fileList);
        model.addAttribute("fileList", fileList);
        
        
        return jsp;
	}


    @RequestMapping(value = "/front/board/boardEtcContentsView.do")
	public String boardEtcContentsView(ExtHtttprequestParam _req, HttpSession session, ModelMap model) throws Exception {

        String jsp = FRONT_PATH + "boardGoodsView";


        Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> boardinfo = new HashMap();
		Map<String, Object> contentsinfo = new HashMap();
		Map<String, Object> prenext = new HashMap<String, Object>();
		List<Map<String, Object>> fileList = null;
		List<Map<String, Object>> viewSortList = null;

		contentsinfo = boardService.selectGoods(param);
		boardService.updateBoardContentsHits(param); // 조회수를 증가(관리자 페이지에서는 조회수를 증가시키지 않음)

		param.put("menuId", contentsinfo.get("menuId"));

		Map<String, Object> menu = menuService.selectMenu(param);

		param.put("boardId", contentsinfo.get("boardId"));

		// 패스워드가 있는 경우 패스워드 창으로 호출
		if("Y".equals(contentsinfo.get("pass_yn")) && !"Y".equals(param.get("chkpass")) && "Y".equals(contentsinfo.get("secret"))){
			jsp = FRONT_PATH + "boardContentsPass";
			model.addAttribute("rt","V");

			return jsp;
		}

		if(contentsinfo.get("attachId") == null){
			param.put("attachId", "0"); // 그룹아이디가 없는경우 전체를 가져오기 방지
		}else{
			param.put("attachId", contentsinfo.get("attachId"));
		}
		/*fileList = fileService.selectFileList(param);*/
		boardinfo = boardService.selectBoardDetail(param);
		prenext = boardService.selectPreNextContentsEtc(param); // 이전글 다음글을 가져온다.
	
		
	/*	boardService.updateBoardContentsHits(param); // 조회수를 증가(관리자 페이지에서는 조회수를 증가시키지 않음)
*/
		viewSortList = boardService.selectBoardViewSortList(param);

		if(contentsinfo.get("attachId") == null){
			param.put("attachId", "A"); // 그룹아이디가 없는경우 전체를 가져오기 방지
		}else{
			param.put("attachId", contentsinfo.get("attachId"));
		}

		//List<CommonFileVO> fileList = commonFileService.getCommonFileList(param);		// attachId만 넘겨줘야함

		model.addAttribute("name", param.get("s_user_name"));
    	model.addAttribute("boardinfo", boardinfo);
    	model.addAttribute("contentsinfo", contentsinfo);
    	model.addAttribute("prenext", prenext);
  		model.addAttribute("viewSortList", viewSortList);
    	//model.addAttribute("fileList", fileList);
        model.addAttribute("param",param);
  /*      model.addAttribute("fileList", fileList);*/

        return jsp;
    }

    /**
	 * 게시물을 등록한다.
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/board/insertBoardContents.do")
	public ModelAndView insertBoardContents(ExtHtttprequestParam _req, ModelMap model, HttpSession session) throws Exception {
		
		
	    int rv =0;
	    int acnt = 0;
	    int sameContentsCnt = 0;
	    Map<String, Object> param = _req.getParameterMap();
	    Map<String, Object> authParam = new HashMap<String, Object>();
	    List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("/board/"));
	    FileUploadModel file = null;
	    String attachId = "";
	    authParam = (Map<String, Object>) session.getAttribute("MEMBER_AUTH");
		/**********   Session의 menu_id, board_id 값 저장 인증, 인가 강화 - 2021.01.08   */
	    String session_menuId = (String)session.getAttribute("w_menuId");
	    	session.removeAttribute("w_menuId");
	    String session_boardId = (String)session.getAttribute("w_boardId");
	    	session.removeAttribute("w_boardId");
	    
	    //240222 본인인증 우회 취약점 조치를 위한 인증 강화시작
		String sName = (String)session.getAttribute("sName");
		String SAFE_WRITER_NAME = (String)session.getAttribute("SAFE_WRITER_NAME");
		String sBirthDate = (String)session.getAttribute("sBirthDate");
//		System.out.println("444 : " + sName);
//		System.out.println("555 : " + SAFE_WRITER_NAME);
//		System.out.println("666 : " + sBirthDate);
	    session.removeAttribute("sName");
	    session.removeAttribute("SAFE_WRITER_NAME");
	    session.removeAttribute("sBirthDate");
	    //240222 본인인증 우회 취약점 조치를 위한 인증 강화끝  	
	    
		if ( !((session_menuId.equals(param.get("menuId"))) || (session_boardId.equals(param.get("boardId")))) ) {
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
		}
		/**********   인증, 인가 강화 끝 - 2021.01.08   */
	    //240222 본인인증 우회 취약점 조치를 위한 인증 강화시작
		if( !(sName.equals(param.get("regMemNm")))) {
//			System.out.println("regMemNm불일치");
 			param.put("success", "false"); 													
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				
 			return ViewHelper.getJsonView(param);
		}
	    //240222 본인인증 우회 취약점 조치를 위한 인증 강화끝
	    
	    Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);		//	버전업 하며서 getAttribute("captcha") 이름을 수정함 2020.10.27
	    
        String captchaAnswer = _req.getP("captchaAnswer");

        if(StringUtils.isNotEmpty(captchaAnswer)) {
        	if(captcha.isCorrect(captchaAnswer)) {
        		
        	}else{
        		param.put("success", "false"); 													// 실패여부 삽입
        		param.put("message", "보안문자 입력값이 일치하지 않습니다."); 					// 실패 메시지
        		
        		return ViewHelper.getJsonView(param);
        	}
        }else{
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
        }
        
        String[] values;

        //	내용(contents) 필드 XSS 처리
        try {
        	//     XSS 방지 - 고객제안 (20062),농림수산식품모태펀드 상담신청(20057) 추가  -2021.01.07
        	if ( (param.get("boardId").equals("51")) || (param.get("boardId").equals("20062")) || (param.get("boardId").equals("20057")) ) {		
        		param.put("contents", (StringUtil.cleanXSS((String)param.get("contents"))));	//	내용 <- 제목은 변환되어 넘어옴
        	}
        }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
        }catch(Exception e) {
			//e.printStackTrace();
        	logger.error("error===", e);
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
        }
        //	내용(contents) 필드 XSS 처리 끝
        
        
        if(param.get("boardId").equals("20082")){
        	param.put("title", param.get("etc1").toString()+" 컨설팅 지원사업 신청");
        	param.put("openYn", "N");
        }
        else if(param.get("boardId").equals("20083")){
        	param.put("title", param.get("etc1").toString()+" 지원사업 신청");
        	param.put("openYn", "N");
        	
        	if(param.get("items01").toString().length() > 1){
        		values = (String[])param.get("items01");
        		for(int i=0 ; i<values.length ; i++){
        			if(i==0){
        				param.put("etc18", values[0].toString());
        			}else{
        				param.put("etc18", param.get("etc18") + "," + values[i].toString());
        			}
        		}
        	}
        	else{
        		param.put("etc18", param.get("items01"));
        	}
        	
        	if(param.get("items02").toString().length() > 1){
        		values = (String[])param.get("items02");
        		for(int i=0 ; i<values.length ; i++){
        			if(i==0){
        				param.put("etc19", values[0].toString());
        			}else{
        				param.put("etc19", param.get("etc19") + "," + values[i].toString());
        			}
        		}
        	}
        	else{
        		param.put("etc19", param.get("items02"));
        	}
        	
        }
        /*
	    if (param.get("boardId").equals("20072") || param.get("boardId").equals("51") || param.get("boardId").equals("20062")||param.get("boardId").equals("20057") ||param.get("boardId").equals("20075")) {
	    	param.put("sDupInfo", authParam.get("sDupInfo"));
		}
	    */ 
	    
        
	    //단건처리용 파라메터 맵 생성   fileVo 제거 중
  		Map<String, Object> fileParam = new HashMap<String, Object>();
  		/*
  		if(fileList != null && fileList.size()>0){
  			file = (FileUploadModel)fileList.get(0);
  			attachId = fileList.get(0).getAtchFileId()==null?CommonUtil.createUUID():fileList.get(0).getAtchFileId();
  			fileParam.put("attachId", attachId);
  			fileParam.put("fileNm", file.getFileName());
  			fileParam.put("originFileNm", file.getOriginalFileName());
  			fileParam.put("fileType", file.getExtension());
  			fileParam.put("fileSize", file.getFileSize());
  			fileParam.put("filePath", "/file/board/");
  			fileParam.put("*userId", param.get("*userId"));
  			commonFileService.insertCommonFile(fileParam);
  			param.put("attachId",fileParam.get("attachId"));
  		}
  		*/
  		if(fileList != null && fileList.size()>0){
			attachId = param.get("attachId")==null?CommonUtil.createUUID():param.get("attachId").toString();
			
			
			for (int i = 0; i < fileList.size(); i++) {
				
				file = (FileUploadModel)fileList.get(i);		   
				fileParam.put("attachId", attachId);		   
				fileParam.put("fileNm", file.getFileName());
				fileParam.put("originFileNm", file.getOriginalFileName());
				fileParam.put("fileType", file.getExtension());
				fileParam.put("fileSize", file.getFileSize());
				fileParam.put("filePath", "/file/board/");
				fileParam.put("*userId", param.get("*userId"));
		   	   	commonFileService.insertCommonFile(fileParam);
			}
			param.put("attachId",attachId);
		}
	  			

	    try{
        	param.put("restep_seq", 0);
        	param.put("relevel_seq", 0);
        	if(param.get("password") != null)
        		param.put("password", CryptoUtil.SHA_encrypt(param.get("password").toString()));
        	if(param.get("boardId").equals("20072")||param.get("boardId").equals("20075"))
        		param.put("openYn", "N");
        	
        	sameContentsCnt = boardService.chkBoardExistContents(param);
        	if(sameContentsCnt > 0){
        		param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", "같은 내용의 글을 연속해서 등록할 수 없습니다."); // 실패 메시지
				return ViewHelper.getJsonView(param);
        	}
        	
	       	rv = boardService.insertBoardContents(param);

	       	if(rv > 0){																	// 저장한다
	       		String title_msg = param.get("title") + " 게시판에 게시글이 등록되었습니다.";
	       		String msg = "";
	       		msg += "제목 : "+param.get("title")+ "<br>";
	       		msg += "등록자 이름 : "+param.get("reg_mem_nm")+ "<br>";
	       		msg += "<a href = 'http://www.apfs.kr/sadm18.do' target = '_blank'>확인하기(관리자모드 접속)</a>";
	       		String serverUrl = "";

				param.put("success", "true" );
	        	param.put("message", MessageUtil.getInsertMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
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
		 * 메일 테스트
		 * @param model
		 * @param validator
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/front/board/insertBoardContentsEmail.do")
		public ModelAndView insertBoardContentsEmail(ExtHtttprequestParam _req, ModelMap model, HttpSession session) throws Exception {

			EmailUtilForCCI mailcci = new EmailUtilForCCI();

		    int rv =0;
		    int acnt = 0;
		    Map<String, Object> param = _req.getParameterMap();
		    Map<String, Object> authParam = new HashMap<String, Object>();
		    String attachId = "";
		    String title_msg = param.get("btitle") + " 게시판에 게시글이 등록되었습니다.";
       		String msg = "";
       		msg += "제목 : "+param.get("title")+ "<br>";
       		msg += "내용 : "+param.get("contents")+ "<br>";
       	    //msg += "등록자 이메일 : "+param.get("etc9")+ "<br><br>";
       		msg += "<a href = 'http://www.apfs.kr/sadm18.do' target = '_blank'>확인하기(관리자모드 접속)</a>";
       		String serverUrl = "";

		    try{
		    	//	sendEmail : 		//	4번째 파라미터 title_msg를 문장으로 대체 - 아래는 개발서버에서는 필요없다
//개발용 메일전송 주석걸기
/*
		    	if(param.get("boardId").equals("51")){  //질의응답
		    		if(param.containsKey("etc0")){
		       			if(param.get("etc0").equals("9")){ //기타   
		       				mailcci.sendEmail("712rbtjd@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 기타 게시물 등록", msg, serverUrl);//조규성
		       				mailcci.sendEmail("jjg12@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 기타 게시물 등록", msg, serverUrl);//조재근
		       			}
		       			if(param.get("etc0").equals("1")){  //농림수산식품모태펀드
		       				mailcci.sendEmail("ykc@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 농림수산식품 모태펀드 게시물 등록", msg, serverUrl);//유근철
		       				
		       			}
		       			if(param.get("etc0").equals("2")){  //농식품전문 크라우드펀딩
		       				mailcci.sendEmail("psj1783@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 농림수산식품 모태펀드 게시물 등록", msg, serverUrl);//박수정
		       			}
		       			if(param.get("etc0").equals("3")){  //농업정책보험
		       				mailcci.sendEmail("hw96004@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 농업정책보험 게시물 등록", msg, serverUrl);//이한
		       				mailcci.sendEmail("jch7382@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 농업정책보험 게시물 등록", msg, serverUrl);//장창훈
		       				mailcci.sendEmail("tmvlf2130@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 농업정책보험 게시물 등록", msg, serverUrl);//조은영
		       			}
		       			if(param.get("etc0").equals("4")){  //손해평가사
		       				mailcci.sendEmail("mskim@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 손해평가사 게시물 등록", msg, serverUrl);//김민성
		       				mailcci.sendEmail("kimsp10@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 손해평가사 게시물 등록", msg, serverUrl);//김선표
		       				mailcci.sendEmail("phn1215@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 손해평가사 게시물 등록", msg, serverUrl);//박하늘
		       			}
		       			if(param.get("etc0").equals("5")){  //농림수산정책자금 검사
		       				mailcci.sendEmail("ynkim@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 농림수산정책자금 검사 게시물 등록", msg, serverUrl);//김용남
		       				mailcci.sendEmail("ph@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 농림수산정책자금 검사 게시물 등록", msg, serverUrl);//박현
		       				mailcci.sendEmail("rnjssp@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 농림수산정책자금 검사 게시물 등록", msg, serverUrl);//권예림
		       			}
		       			if(param.get("etc0").equals("6")){  //농특회계 융자금 관리
		       				mailcci.sendEmail("eomsy@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 농특회계 융자금 관리 게시물 등록", msg, serverUrl);//엄소영
		       			}
		       			if(param.get("etc0").equals("7")){  //양재수산물재해보험
		       				mailcci.sendEmail("june6@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 - 양재수산물재해보험 게시물 등록", msg, serverUrl);//정준하
		       			}
		    		}else{
	       				//mailcci.sendEmail("lym1432@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 질의응답 게시물 등록", msg, serverUrl);
		    		}
	       		}
	       		if(param.get("boardId").equals("20072")){   //부정부패 신고마당
       				mailcci.sendEmail("kmhduck@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 부정부패 신고마당 게시물 등록", msg, serverUrl);//강민형
	       		}
	       		
	       		if(param.get("boardId").equals("20075"))  //농림수산정책자금 부당사용 신고센터
	       		{
       				mailcci.sendEmail("ynkim@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 부당사용 신고센터 게시물 등록", msg, serverUrl);//김용남
       				mailcci.sendEmail("ph@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 부당사용 신고센터 게시물 등록", msg, serverUrl);//박현
       				mailcci.sendEmail("rnjssp@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 부당사용 신고센터 게시물 등록", msg, serverUrl);//권예림
	       		}
	       		if(param.get("boardId").equals("20062"))  //고객제안
	       		{
       				mailcci.sendEmail("jjg12@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "[농금원 알림] 고객제안 게시물 등록", msg, serverUrl);//조재근
	       		}
*/
//개발용 메일전송 주석걸기
mailcci.sendEmail("dmkim@apfs.kr", "APFS<apfsreport@gmail.com>", "농업정책보험금융원 정보화팀", "게시물 등록 확인 - " + param.get("boardId"), msg, serverUrl);	//20221024 김동민 webMaster 메일주소 변경

	       		param.put("restep_seq", 0);
	        	param.put("relevel_seq", 0);
		       	rv = 1;

		       	if(rv > 0){																	// 저장한다
					param.put("success", "true" );
		        	param.put("message", MessageUtil.getInsertMsg(rv, _req));
				}else{
					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
				}
			}catch (NullPointerException e) {
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
     * 답글을 등록한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/insertBoardContentsReply.do")
    public ModelAndView insertBoardContentsReply(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();

        try{
        	List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("board/"));
    		FileUploadModel file = null;
    		CommonFileVO commonFileVO = new CommonFileVO();
    		if(fileList != null && fileList.size()>0){
    			for(int i =0; i < fileList.size();i++){
	    			file = (FileUploadModel)fileList.get(i);
	    			if("thumb".equals(file.getFieldName())){ // 썸네일
		    			commonFileVO.setGroup_id(CommonUtil.createUUID());
		    			commonFileVO.setFile_nm(file.getFileName());
		    			commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
		    			commonFileVO.setFile_type(file.getExtension());
		    			commonFileVO.setFile_size(file.getFileSize());
		    			commonFileVO.setFile_path("board/");
		    			commonFileVO.setS_user_no((String)param.get("s_user_no"));
		    			//commonFileService.insertCommonFile(commonFileVO);
		    			param.put("image_file_id",commonFileVO.getFile_id());
	    			}else{ // 첨부파일
		    			if(acnt == 0){
		    				commonFileVO.setGroup_id(CommonUtil.createUUID());
		    				param.put("group_id",commonFileVO.getGroup_id());
		    			}else{
		    				commonFileVO.setGroup_id((String)param.get("group_id"));
		    			}
		    			commonFileVO.setFile_nm(file.getFileName());
		    			commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
		    			commonFileVO.setFile_type(file.getExtension());
		    			commonFileVO.setFile_size(file.getFileSize());
		    			commonFileVO.setFile_path("board/");
		    			commonFileVO.setS_user_no((String)param.get("s_user_no"));
		    			//commonFileService.insertCommonFile(commonFileVO);
		    			acnt++;
	    			}
    			}
    		}

        	param.put("contents_id", CommonUtil.createUUID());
        	boardService.updateBoardContentsReorder(param);
        	param.put("noti", "N");
        	param.put("restep_seq", StringUtil.nvl(param.get("restep_seq"),0)+1);
            param.put("relevel_seq", StringUtil.nvl(param.get("relevel_seq"),0)+1);

        	rv = boardService.insertBoardContents(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getInsertMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
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
     * 게시물 수정한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/updateBoardContents.do")
    public ModelAndView updateBoardContents(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
        /*
        String attachId = "";

        try{
        	List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("board/"));
    		FileUploadModel file = null;
    		
    		Map<String, Object> fileParam = new HashMap<String, Object>();
			
			if(fileList != null && fileList.size()>0){
				attachId = param.get("attachId")==null?CommonUtil.createUUID():param.get("attachId").toString();
				
				
				for (int i = 0; i < fileList.size(); i++) {
					
					file = (FileUploadModel)fileList.get(i);		   
					fileParam.put("attachId", attachId);		   
					fileParam.put("fileNm", file.getFileName());
					fileParam.put("originFileNm", file.getOriginalFileName());
					fileParam.put("fileType", file.getExtension());
					fileParam.put("fileSize", file.getFileSize());
					fileParam.put("filePath", "/file/board/");
					fileParam.put("*userId", param.get("*userId"));
			   	   	commonFileService.insertCommonFile(fileParam);
				}
				param.put("attachId",attachId);
					   	   	
			}
	       	rv = boardService.updateBoardContents(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
		}catch(Exception e){
			e.printStackTrace();
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}

        return ViewHelper.getJsonView(param);
		*/
        param.put("success", "false");
		param.put("message", "이 글을 수정할 수 있는 권한이 없습니다."); // 
        
        return ViewHelper.getJsonView(param);
    }

    /**
     * 게시물을 삭제한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/deleteBoardContents.do", method = RequestMethod.POST)
    public ModelAndView deleteBoardContents(ExtHtttprequestParam _req, ModelMap model) throws Exception {
       	
    	/*
    	int rv = 0;
       	int chk = 0;
        Map<String, Object> param = _req.getParameterMap();
       	try{
       		// 삭제하기전 자식글이 있는지 확인
       		chk  = boardService.chkBoardChildContents(param);
       		if(chk > 0){
       		}else{
       			rv = boardService.deleteBoardContents(param);
       		}

	       	if(rv > 0){
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getDeteleMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				if(chk > 0){
					param.put("message", "답글이 있으면 삭제할 수 없습니다."); // 실패 메시지
				}else{
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
				}
			}
        }catch(Exception e){
        	e.printStackTrace();
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}
 		
 		
    	return ViewHelper.getJsonView(param);
 		*/
    	
    	Map<String, Object> param = _req.getParameterMap();
    	param.put("message", "이 글을 삭제할 수 있는 권한이 없습니다.");

        return ViewHelper.getJsonView(param);
    }

    /**
     * 게시물을 삭제한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/chkBoardPass.do", method = RequestMethod.POST)
    public ModelAndView chkBoardPass(ExtHtttprequestParam _req, ModelMap model) throws Exception {
       	int rv = 0;
       	int chk = 0;
        Map<String, Object> param = _req.getParameterMap();
       	try{
       		// 삭제하기전 자식글이 있는지 확인
       		rv = boardService.chkBoardPass(param);

	       	if(rv > 0){
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getDeteleMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				if(chk > 0){
					param.put("message", "답글이 있으면 삭제할 수 없습니다."); // 실패 메시지
				}else{
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
				}
			}
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
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
     * 답변을 저장한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/saveBoardContentsAnswer.do")
    public ModelAndView saveBoardContentsAnswer(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{
	       	rv = boardService.saveBoardContentsAnswer(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getSavedMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
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
     * 댓글을 저장한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/saveComment.do")
    public ModelAndView saveComment(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{
        	if("E".equals(param.get("mode"))){
        		rv = boardService.updateComment(param);
        	}else if("R".equals(param.get("mode"))){
        		param.put("comment_id", CommonUtil.createUUID());
        		boardService.updateCommentReorder(param);
            	param.put("sort", StringUtil.nvl(param.get("sort"),0)+1);
        		rv = boardService.saveComment(param);
        	}else{
        		param.put("comment_id", CommonUtil.createUUID());
    	       	rv = boardService.saveComment(param);
        	}

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getSavedMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
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
     * 댓글을 삭제한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/deleteComment.do")
    public ModelAndView deleteComment(ExtHtttprequestParam _req, ModelMap model) throws Exception {
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
       	try{
       		rv = boardService.deleteComment(param);
	       	if(rv > 0){
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getDeteleMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
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
     * 댓글의 패스워드를 확인한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/chkComment.do")
    public ModelAndView chkComment(ExtHtttprequestParam _req, ModelMap model) throws Exception {
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
       	try{
       		rv = boardService.chkComment(param);
	       	if(rv > 0){
				param.put("success", "true" );
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
			}
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
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
     * 댓글 리스트 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/boardCommentList.do")
	public String boardCommentList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        String jsp = "/sub"+FRONT_PATH + "boardCommentList";
        Map<String, Object> param = _req.getParameterMap();
		List<Map<String, Object>> list = boardService.selectBoardCommentList(param);
		model.addAttribute("commentList", list);

        return jsp;
	}

    /**
     * 만족도를 저장한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/saveSatisfy.do")
    public ModelAndView saveSatisfy(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{
        	param.put("satisfy_id", CommonUtil.createUUID());
	       	rv = boardService.saveSatisfy(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getSavedMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
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
     * 게시물 추천수를 가져온다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/loadRecommend.do")
    public ModelAndView loadRecommend(ExtHtttprequestParam _req, ModelMap model) throws Exception {
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> recommendinfo = new HashMap();
        int total_cnt = 0;
        String recommend_yn = "N";

        recommendinfo = boardService.selectRecommend(param);
        if(recommendinfo != null){
        	total_cnt = ((BigDecimal) recommendinfo.get("total_cnt")).intValue();
        	recommend_yn = (String) recommendinfo.get("recommend_yn");
        }

        param.put("recommend_cnt", total_cnt);
        param.put("recommend_yn", recommend_yn);

        return ViewHelper.getJsonView(param);
    }

    /**
     * 추천하기, 추천취소하기
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/saveRecommend.do")
    public ModelAndView saveRecommend(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{
        	if("Y".equals(param.get("recommend_yn"))){
        		param.put("recommend_yn", "N");
        		param.put("message", "취소하였습니다.");
        	}else{
        		param.put("recommend_yn", "Y");
        		param.put("message", "추천하였습니다.");
        	}

	       	rv = boardService.saveRecommend(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
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
     * 게시판 메인 출력용 게시물
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/loadMainBoard.do")
    public ModelAndView loadMainBoard(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = boardService.selectLoadMainBoard(param);
        param.put("list", list );
        return ViewHelper.getJsonView(param);
    }

    /**
     * 자동등록방지 문자를 반환해준다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/getCaptcharAnswer.do")
    public ModelAndView getCaptcharAnswer(ExtHtttprequestParam _req, ModelMap model, HttpServletRequest request) throws Exception {
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

        String answer = StringUtil.nvl(request.getSession().getAttribute("correctAnswer"));

        param.put("answer", answer);

        return ViewHelper.getJsonView(param);
    }

    /**
     * 게시판 댓글 패스워드 팝업
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/boardContentsPassPopup.do")
	public String boardContentsPassPopup(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	String jsp =  "/sub"+FRONT_PATH+"boardContentsPassPopup";

        return jsp;
	}


    /**
     * 게시물 타입별 리스트
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/boardNewsList.do")
	public String boardNewsList(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

    	String jsp =  "/sub/front/boardlink/";

		NavigatorInfo navigator = new NavigatorInfo(_req);
		Map<String, Object> param  = navigator.getParam();
		Map<String, Object> boardinfo = new HashMap();

		param.put("sidx", " reg_dt DESC, cont_id");
		param.put("sord", "asc");

		jsp +=  "boardlinkNewsList"; // 기업뉴스
		navigator.setList(boardService.selectBoardNewsPageList(param));


		model.addAttribute("boardList", navigator.getList());
		model.addAttribute("boardPagging", navigator.getPagging());
		model.addAttribute("totalcnt", navigator.getTotalCnt());


        return jsp;
	}


    /**
     * 게시판 상세 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/board/boardNewsView.do")
	public String boardNewsView(ExtHtttprequestParam _req, HttpSession session, ModelMap model) throws Exception {

        String jsp = "/front/boardlink/boardlinkContentsView";

        Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> contentsinfo = new HashMap();
		Map<String, Object> prenext = new HashMap();

		contentsinfo = boardService.selectNewsDetail(param);
		prenext = boardService.selectNewsPreNextContents(param); // 이전글 다음글을 가져온다.


    	model.addAttribute("contentsinfo", contentsinfo);
    	model.addAttribute("prenext", prenext);
        model.addAttribute("param",param);

        return jsp;
	}



    //비밀번호체크 -> 비밀글의 contId 값 저장 추가 2021.06.17

   	@RequestMapping(value = "/front/board/pwdCheck.do")
    public ModelAndView pwdCheck(ExtHtttprequestParam _req, ModelMap model, HttpSession session) throws Exception {


        Map<String, Object> param = _req.getParameterMap();
        //Map<String, Object> auth = new HashMap<String, Object>();
        //auth = (Map<String, Object>) session.getAttribute("MEMBER_AUTH");
        //String key = "";
        //Map<String, Object> test = new HashMap<String, Object>();
        String password = "";

        if(param.get("password") != null){
        	try{
        		password = boardService.pwdCheck(param).get("password").toString();
        		if(CryptoUtil.SHA_encrypt(param.get("password").toString()).equals(password)){
        			param.put("success", "true" );
        			
        			//	세션에 contId 값을 저장한다 - 2021.06.17
        			session.setAttribute("SECRET_CONT_ID", param.get("contId"));
        		}else{
        			param.put("success", "false");
        		}
        	}catch (IOException e) {
            	logger.error("IOException error===", e);
            } catch (NullPointerException e) {
            	logger.error("NullPointerException error===", e);
            }catch(Exception e){
        		//e.printStackTrace();
        		logger.error("error===", e);
        		param.put("success", "false");
        		
        		return ViewHelper.getJsonView(param);
        	}
        }
        
        return ViewHelper.getJsonView(param);
    }
   	
   	
   	//230629 .exe파일 실행 테스트 : 로컬과서버의 주체문제로 보류...
	@RequestMapping(value = "/front/user/playexe.do")
	public void playexe(ExtHtttprequestParam _req, ListOp listOp, HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {

		Runtime rt = Runtime.getRuntime();
		String exeFile = "C:\\a\\PLAY_v4\\eCBT.exe";
		Process p;
		
		try{
			p = rt.exec(exeFile);
			p.waitFor();
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }	
		catch (Exception e){
			logger.error("Exception error===", e);
		}
		return;
	}
}
