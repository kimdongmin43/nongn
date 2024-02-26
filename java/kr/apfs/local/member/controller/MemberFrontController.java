package kr.apfs.local.member.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.member.service.MemberService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : MemberController.java
 * @Description : MemberController.Class
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
public class MemberFrontController extends ComAbstractController{

	private static final Logger logger = LogManager.getLogger(MemberFrontController.class);

	public final static String  FRONT_PATH = "/front/member/";
	public final static String  BACK_PATH = "/back/member/";

	@Resource(name = "MemberService")
    private MemberService memberService;

	/**
     * 사업자번호를 이용하여 구상공회의 회원유형을 가져온다.
     * 7년내 기납 회원일 경우 'A'
	 * 7년내 미납 회원일 경우 'B'
	 * 7년전 회원이거나 비회원일 경우 'C'
     * @param param
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/front/member/member.do")
	public ModelAndView selectMemberCode(ExtHtttprequestParam _req, ModelMap model,HttpSession session) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
        try{

        	List<Map<String,Object>> memberList = memberService.selectMemberCode(param);

	       	if(memberList.size()>0){
	       		session.setAttribute("MEMBER", memberList.get(0));
	       		param.put("MEMBER", memberList.get(0) );
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getUpdatedMsg(0, _req));
			}else{
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(0, _req));
			}
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        	param.put("success", "false");
 			param.put("message", MessageUtil.getProcessFaildMsg(0, _req));
 			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false");
 			param.put("message", MessageUtil.getProcessFaildMsg(0, _req));
 			return ViewHelper.getJsonView(param);
        }catch(Exception e){
        	//e.printStackTrace();
        	logger.error("error===", e);
 			param.put("success", "false");
 			param.put("message", MessageUtil.getProcessFaildMsg(0, _req));
 			return ViewHelper.getJsonView(param);
 		}

         return ViewHelper.getJsonView(param);
	}
}
