package kr.apfs.local.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.apfs.local.common.Const;
import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
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
public class MemberpageFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(MemberpageFrontController.class);

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
	@RequestMapping(value = "/front/member/memberPage.do")
	public String footerInfopageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		String jsp = FRONT_PATH + "memberPage";

        return jsp;
	}

    @RequestMapping(value = "/front/member/memberpageWrite.do")
    public String memberpageWirte(ExtHtttprequestParam _req, ListOp listOp, HttpSession session, ModelMap model) throws Exception {

    	String jsp = "/comm"+FRONT_PATH + "memberPageWrite";
    	Map<String, Object> param = _req.getParameterMap();
    	Map<String,Object>memberInfo = new HashMap<String, Object>();
    	List<Map<String,Object>>siteInfo;

    	Map<String,Object> member = (Map<String, Object>) session.getAttribute(Const.SESSION_MEMBER);

	    	String[] temp = null;

	    	if (member !=null){
	    		param.put("memberId", member.get("memberId"));
	    		param.put("mode","E");
	    		memberInfo=memberpageService.selectMemberpage(param);
	    		if (memberInfo.get("repTel")!=null) {
	    			temp = memberInfo.get("repTel").toString().split("\\^",-1);
	        		memberInfo.put("repTel1", temp[0]);
	        		memberInfo.put("repTel2", temp[1]);
	        		memberInfo.put("repTel3", temp[2]);

				}
	    		if (memberInfo.get("repHp")!=null) {
	    			temp = memberInfo.get("repHp").toString().split("\\^",-1);
	        		memberInfo.put("repHp1", temp[0]);
	        		memberInfo.put("repHp2", temp[1]);
	        		memberInfo.put("repHp3", temp[2]);

				}
	    		if (memberInfo.get("fax")!=null) {
	    			temp = memberInfo.get("fax").toString().split("\\^",-1);
	        		memberInfo.put("fax1", temp[0]);
	        		memberInfo.put("fax2", temp[1]);
	        		memberInfo.put("fax3", temp[2]);

				}
	    		if (memberInfo.get("chargeHp")!=null) {
	    			temp = memberInfo.get("chargeHp").toString().split("\\^",-1);
	        		memberInfo.put("chargeHp1", temp[0]);
	        		memberInfo.put("chargeHp2", temp[1]);
	        		memberInfo.put("chargeHp3", temp[2]);

				}



	    	}
    	siteInfo = memberpageService.selectSiteList(param);
    	model.put("memberInfo", memberInfo);
    	model.put("siteInfo", siteInfo);
    	model.put("param", param);

    	model.addAttribute("leftNm", "회원가입");
    	return jsp;
    }

    /**
     * 멤버데이터저장
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/front/member/memberInsert.do")
	public ModelAndView historypageUpdate(ExtHtttprequestParam _req, ModelMap model,HttpServletRequest request,String [] chk,String[] title,String[] contents) throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {

				if (param.get("mode") == null || param.get("mode").equals("W")) {
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
     * 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */

	@RequestMapping(value ="/front/contents/memberPageList.do")
	public String memberPageList(ExtHtttprequestParam _req, ListOp listOp,ModelMap model)
			throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();

		String jsp = "/front/contents/memberListPage";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

		return  jsp;
	}

	@RequestMapping(value ="/front/contents/memberPageList2.do")
	public String memberPageList2(ExtHtttprequestParam _req, ListOp listOp,ModelMap model)
			throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
        param.put("sidx", "COMPANY_NM");
		param.put("sord", "asc");

/*        param.put("*siteId", S_SITE_ID);*/
		String jsp = "/sub/front/contents/memberListPage2";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		List <Map<String, Object>> memberlist = memberpageService.selectMemberList(param);
		navigator.setList(memberlist);

		model.addAttribute("memberlist",memberlist);
		model.addAttribute("boardList", navigator.getList());
		model.addAttribute("memberPagging", navigator.getPagging());
		model.addAttribute("totalCnt", navigator.getTotalCnt());
		model.addAttribute("pageNo", navigator.getPageNo());

		return  jsp;
	}



}
