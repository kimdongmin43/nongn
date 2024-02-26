package kr.apfs.local.popnoti.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.JsonUtil;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.fileupload.model.CommonFileVO;
import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.fileupload.FileUploadModel;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.file.service.AttachFileService;
import kr.apfs.local.popnoti.service.PopnotiService;

/**
 * @Class Name : PopnotiController.java
 * @Description : PopnotiController.Class
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
public class PopnotiController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(PopnotiController.class);

	public final static String  FRONT_PATH = "/front/popnoti/";
	public final static String  BACK_PATH = "/back/popnoti/";

	@Resource(name = "PopnotiService")
    private PopnotiService popnotiService;

	@Resource(name = "AttachFileService")
    private AttachFileService fileService;

	/**
     * 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/popnoti/popnotiListPage.do")
	public String popnotiListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		String jsp = BACK_PATH + "popnotiListPage";

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
    @RequestMapping(value = "/back/popnoti/popnotiPageList.do")
	public ModelAndView popnotiPageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(popnotiService.selectPopnotiPageList(param));

        return ViewHelper.getJqGridView(navigator);
	}

	/**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/popnoti/popnotiList.do")
	public @ResponseBody Map<String, Object> popnotiList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = BACK_PATH + "popnotiListPage";

        Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> list = popnotiService.selectPopnotiList(param);
		param.put("rows", list);

        return param;
	}

	/**
     * 쓰기 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/popnoti/popnotiWrite.do")
	public String popnotiWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);

    	String jsp = BACK_PATH + "popnotiWrite";

        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> popnoti = new HashMap();
        List<Map<String, Object>> fileList = null;

        if(!StringUtil.nvl(param.get("mode")).equals("W")){
        	 // popnoti 정보를 가져온다.
        	popnoti = popnotiService.selectPopnoti(param);
        }else{
        	popnoti.put("satisfy_yn", "Y");
        	popnoti.put("useYn", "Y");
        }

        if (popnoti != null && popnoti.get("contents")!=null){
        	popnoti.put("contents", popnoti.get("contents").toString().replaceAll("\'", "\\&#39;"));
		}

        if(popnoti.get("attachId") == null){
        	param.put("attachId", "0"); // 그룹아이디가 없는경우 전체를 가져오기 방지
     	}
        else{
     		param.put("attachId", popnoti.get("attachId"));
     	}

     	fileList = fileService.selectFileList(param);

     	model.addAttribute("fileList", fileList);
        model.addAttribute("popnoti",popnoti);

        return jsp;
	}


	/**
     * 쓰기 페이지로 이동한다(수퍼관리자)
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/popnoti/popnotiallWrite.do")
	public String popnotiallWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);


    	logger.info("######hear");


    	String jsp = BACK_PATH + "popnotiWrite";

        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> popnoti = new HashMap();
        if(!StringUtil.nvl(param.get("mode")).equals("W")){
        	 // popnoti 정보를 가져온다.
        	popnoti = popnotiService.selectPopnoti(param);
        }else{
        	popnoti.put("satisfy_yn", "Y");
        	popnoti.put("useYn", "Y");
        }

        model.addAttribute("popnoti",popnoti);

        return jsp;
	}


	/**
     * 데이타를 저장한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/popnoti/insertPopnoti.do")
    public ModelAndView insertPopnoti(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{
        	/*
       		List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("menu/"));
    		FileUploadModel file = null;
    		CommonFileVO commonFileVO = new CommonFileVO();
    		if(fileList != null && fileList.size()>0){
    		   file = (FileUploadModel)fileList.get(0);
    		   commonFileVO.setGroup_id(CommonUtil.createUUID());
    		   commonFileVO.setFile_nm(file.getFileName());
    		   commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
    		   commonFileVO.setFile_type(file.getExtension());
    		   commonFileVO.setFile_size(file.getFileSize());
    		   commonFileVO.setFile_path("menu/");
    		   commonFileVO.setS_user_no((String)param.get("s_user_no"));
   	   	       commonFileService.insertCommonFile(commonFileVO);
               param.put("attachId",commonFileVO.getFile_id());
    		}
        	param.put("noti_id", CommonUtil.createUUID());
        	*/

	       	rv = popnotiService.insertPopnoti(param);

	       	if(rv > 0){																	// 저장한다
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
     * 데이타를 수정한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/popnoti/updatePopnoti.do")
    public ModelAndView updatePopnoti(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
       		/*
       		List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("menu/"));
    		FileUploadModel file = null;
    		CommonFileVO commonFileVO = new CommonFileVO();
    		if(fileList != null && fileList.size()>0){
    		   file = (FileUploadModel)fileList.get(0);
    		   commonFileVO.setGroup_id(CommonUtil.createUUID());
    		   commonFileVO.setFile_nm(file.getFileName());
    		   commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
    		   commonFileVO.setFile_type(file.getExtension());
    		   commonFileVO.setFile_size(file.getFileSize());
    		   commonFileVO.setFile_path("menu/");
    		   commonFileVO.setS_user_no((String)param.get("s_user_no"));
   	   	       commonFileService.insertCommonFile(commonFileVO);
               param.put("attachId",commonFileVO.getFile_id());
    		}
    		*/
	       	rv = popnotiService.updatePopnoti(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
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
     * 데이타를 삭제한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/popnoti/deletePopnoti.do")
    public ModelAndView deletePopnoti(ExtHtttprequestParam _req, ModelMap model) throws Exception {

       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
       		rv = popnotiService.deletePopnoti(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getDeteleMsg(rv, _req));
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
     * 미리보기 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/popnoti/popnotiPreview.do")
	public String popnotiPreview(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = "/popup"+BACK_PATH + "popnotiPreview";

        Map<String, Object> param = _req.getParameterMap();

        List<Map<String, Object>> fileList = null;
        if(param.get("attachId") == null){
        	param.put("attachId", "0"); // 그룹아이디가 없는경우 전체를 가져오기 방지
     	}
        else{
     		param.put("attachId", param.get("attachId"));
     	}

     	fileList = fileService.selectFileList(param);

     	model.addAttribute("fileList",fileList);
        model.addAttribute("popnoti",param);

        return jsp;
	}

}
