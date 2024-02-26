package kr.apfs.local.contents.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.HistorypageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : HistorypageController.java
 * @Description : HistorypageController.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2017.06.26   최초생성
 *
 * @author msu
 * @since 2017. 06.28
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Intocps All right reserved.
 */

@Controller
public class HistorypageController extends ComAbstractController {

	private static final Logger logger = LogManager.getLogger(HistorypageController.class);

	public final static String  FRONT_PATH = "/front/content/";
	public final static String  BACK_PATH = "/back/contents/";



	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;

	@Resource(name = "HistorypageService")
    private HistorypageService historypageService;


	/**
     * 안내 저장페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */

	@RequestMapping(value = "/back/contents/historypageWrite.do")
	public String historypageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		//임시지역코드
		String jsp = BACK_PATH + "historypageWrite";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		List<Map<String, Object>>historypageinfo = historypageService.selectHistorypage(param);
		for (int i = 0; i < historypageinfo.size(); i++) {
			Map<String, Object>temp = historypageinfo.get(i);
			if(temp.get("contents") != null){
				temp.put("contents", temp.get("contents").toString().replaceAll("\'", "\\&#39;"));
			}
			historypageinfo.set(i, temp);
		}

		//greetingpageinfo.put("contents", greetingpageinfo.get("contents").toString().replaceAll("\'", "\\&#39;"));

		model.addAttribute("historypageinfo",historypageinfo);
		model.addAttribute("listSize",historypageinfo.size());

		//Map<String, Object> historypageinfo = historypageService.selectHistorypage(param);


        return jsp;
	}



	/**
     * 안내 데이터 저장
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/contents/historypageUpdate.do")
	public ModelAndView historypageUpdate(ExtHtttprequestParam _req, ModelMap model,HttpServletRequest request,String [] chk,String[] sort,String[] title,String[] contents) throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();


		try {

			for (int i = 0; i < chk.length; i++) {
				rv=0;
				param.put("contId", chk[i]);
				param.put("title", title[i]);
				param.put("contents", contents[i]);
				param.put("sort", sort[i]);
				rv = historypageService.selectHistorypageExist(param);

				if (rv>0) {
					//System.out.println("있다");
					rv = historypageService.updateHistorypage(param);
				}
				else
				{
					//System.out.println("없다");
					rv = historypageService.insertHistorypage(param);
				}
			}																					// 저장한다
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




	@RequestMapping(value = "/back/contents/historypageCreatepageId.do")
	public ModelAndView historypageCreatepageId(ExtHtttprequestParam _req, ModelMap model) throws Exception {

				String pageId = "";
				pageId = CommonUtil.createUUID();
				Map<String, Object> param = _req.getParameterMap();
				param.put("success", "true" );
				param.put("pageId", pageId );



        return ViewHelper.getJsonView(param);
	}

	@RequestMapping(value = "/back/contents/historypageDelete.do")
	public ModelAndView historypageDeletepageId(ExtHtttprequestParam _req, ModelMap model) throws Exception {

			int rv = 0;

			Map<String, Object> param = _req.getParameterMap();
			String [] contId = param.get("contId").toString().split(",",-1);
			param.put("contId", contId);



			try{
				rv = historypageService.deleteHistotypage(param);


				if (rv > 0) {
					param.put("success", "true" );
					param.put("message", MessageUtil.getDeteleMsg(rv, _req));
				}
				else
				{
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
	        }
			catch (Exception e)
			{
				//e.printStackTrace();
				logger.error("error===", e);
	 			param.put("success", "false"); 													// 실패여부 삽입
	 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
	 			return ViewHelper.getJsonView(param);
			}


        return ViewHelper.getJsonView(param);
	}

}
