package kr.apfs.local.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.member.service.MemberpageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : FooterInfopageController.java
 * @Description : FooterInfopageController.Class
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
public class MemberpageController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(MemberpageController.class);

	public final static String  FRONT_PATH = "/front/member/";
	public final static String  BACK_PATH = "/back/member/";


	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;

	@Resource(name = "MemberpageService")
    private MemberpageService memberpageService;



	/**
     * 하단정보 페이지로 이동
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/member/memberPageList.do")
	public String footerInfopageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		String jsp = BACK_PATH + "memberPageList";

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

        return jsp;
	}

	/**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/member/memberList.do")
	public ModelAndView intropagePageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();

        navigator.setList(memberpageService.selectMemberList(param));
        return ViewHelper.getJqGridView(navigator);

	}


    @RequestMapping(value = "/back/member/memberpageWrite.do")
    public String memberpageWirte(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

    	Map<String, Object> param = _req.getParameterMap();
    	Map<String,Object>memberInfo = new HashMap<String, Object>();
    	List<Map<String,Object>>siteInfo;
    	String[] temp = null;
    	String jsp = BACK_PATH + "memberPageWrite";
    	
    	memberInfo=memberpageService.selectMemberpage(param);
    	
    	model.put("memberInfo", memberInfo);    
    	model.put("param", param);

    	return jsp;
    }


    /**
     * 사업자번호 확인
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/front/member/memberCheck.do")
	public ModelAndView memberCheck(ExtHtttprequestParam _req, ModelMap model,HttpServletRequest request) throws Exception {
		Map<String, Object> param = _req.getParameterMap();
		Map<String,Object>memberInfo = memberpageService.selectMemberpage(param);
		try {

				if (memberInfo != null) {
					param.put("success", "false" );
		        	param.put("message", "이미 등록된 사업자번호 입니다.");
				}
				else
				{
					param.put("success", "true" );
		        	param.put("message", "회원 가입 가능한 사업자번호 입니다.");
				}
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	return ViewHelper.getJsonView(param);
        } catch (Exception e) {
        	logger.error("Exception error===", e);
 			return ViewHelper.getJsonView(param);
 		}
        return ViewHelper.getJsonView(param);
	}


    /**
     * 멤버데이터저장
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/member/memberInsert.do")
	public ModelAndView memberPageUpdate(ExtHtttprequestParam _req, ModelMap model,HttpServletRequest request,String [] chk,String[] title,String[] contents) throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {

				if (param.get("mode").equals("W")) {
					param.put("useYn", "Y");
					rv = memberpageService.insertMemberpage(param);
					param.put("success", "true" );
		        	param.put("message", MessageUtil.getInsertMsg(rv, _req));

				}
				else
				{
					rv = memberpageService.updateMemberpage(param);
					param.put("success", "true" );
		        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
				}
																							// 저장한다


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
        } catch (Exception e) {
			//e.printStackTrace();
			logger.error("error===", e);
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}

        return ViewHelper.getJsonView(param);
	}


	 /**
     * 멤버데이터삭제
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/member/memberDelete.do")
	public ModelAndView memberPageDelete(ExtHtttprequestParam _req, ModelMap model,HttpServletRequest request,String [] chk,String[] title,String[] contents) throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
					rv = memberpageService.deleteMemberpage(param);
					param.put("success", "true" );
		        	param.put("message", MessageUtil.getDeteleMsg(rv, _req));




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
        } catch (Exception e) {
			//e.printStackTrace();
			logger.error("error===", e);
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}

        return ViewHelper.getJsonView(param);
	}





	  /**
     * 멤버승인
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/member/memberPassUpdate.do")
	public ModelAndView memberPassUpdate(ExtHtttprequestParam _req, ModelMap model,HttpServletRequest request) throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
					rv = memberpageService.updateMemberPass(param.get("memberId").toString());
					param.put("success", "true" );
		        	param.put("message", MessageUtil.getInsertMsg(rv, _req));

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
        } catch (Exception e) {
			//e.printStackTrace();
			logger.error("error===", e);
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}

        return ViewHelper.getJsonView(param);
	}


	/**
     * 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/member/memberJoinPrt.do")
	public String memberJoinPrt(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		//int rv = 0;
		Map<String, Object> param = _req.getParameterMap();
	  	Map<String, Object>memberInfo=memberpageService.selectMemberpage(param);

		String jsp = BACK_PATH + "/prt/joinPrt";

		//repTel,repHp,fax,chargeHp
		if (memberInfo.get("repTel")!=null) {
			memberInfo.put("repTel", memberInfo.get("repTel").toString().replaceAll("\\^", "-"));
		}
		if (memberInfo.get("repHp")!=null) {
			memberInfo.put("repHp", memberInfo.get("repHp").toString().replaceAll("\\^", "-"));
		}
		if (memberInfo.get("fax")!=null) {
			memberInfo.put("fax", memberInfo.get("fax").toString().replaceAll("\\^", "-"));
		}
		if (memberInfo.get("chargeHp")!=null) {
			memberInfo.put("chargeHp", memberInfo.get("chargeHp").toString().replaceAll("\\^", "-"));

		}




		model.addAttribute("memberInfo",memberInfo);
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);



        return jsp;
	}
		
	/**
     * 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/front/member/memberLoginCheck.do")
	public String memberLoginCheck(ExtHtttprequestParam _req, ListOp listOp, ModelMap model,HttpSession session) throws Exception {
		
		// 수정 코드 - 2018.06.18(월)
		Map<String, Object> param = _req.getParameterMap();
		
		String boardId = param.get("boardId") == null ? "" : (String)param.get("boardId");
		boardId = StringUtil.matchStringReplace(boardId);		
		param.put("boardId", boardId);
		
		String member = "";
		if (session.getAttribute("LOGININFO")!=null) {
			member = session.getAttribute("LOGININFO").toString();
		}
		String jsp = "";
		
		if (member==null ||  member=="") { 
			model.put("param", param);
			jsp = "/front/member/memberLogin";
		}
		else
		{
			
			jsp = "/front/board/boardContentsListPage";
			//20077
		}
		
        return jsp;
	}
	
	
	
	  /**
     * 멤버승인
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/front/member/memberLogin.do")
	public ModelAndView memberLogin(ExtHtttprequestParam _req, ModelMap model,HttpServletRequest request,HttpSession session) throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();
		String cnt = "";
		try {
					cnt =  memberpageService.login(param).get("cnt").toString();
					if (cnt.equals("1")) {						
						session.setAttribute("LOGININFO", memberpageService.login(param).get("memberNm").toString());
						param.put("success", "true" );
			        	param.put("message", MessageUtil.getInsertMsg(rv, _req));
					}
					else
					{
						param.put("success", "false"); 													// 실패여부 삽입
			 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
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
        } catch (Exception e) {
			//e.printStackTrace();
			logger.error("error===", e);
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}
        return ViewHelper.getJsonView(param);
	}
	
	
	
	 /**
     * 주소호출
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */

	@RequestMapping(value = "/front/member/memberJusoPopup.do")
	public String memberJusoPopup(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {


		String jsp =  "/common/jusoPopup";

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
