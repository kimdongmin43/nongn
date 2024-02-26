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
 * @Class Name : PopnotiFrontController.java
 * @Description : PopnotiFrontController.Class
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
public class PopnotiFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(PopnotiFrontController.class);

	public final static String  FRONT_PATH = "/front/popnoti/";

	@Resource(name = "PopnotiService")
    private PopnotiService popnotiService;

	@Resource(name = "AttachFileService")
    private AttachFileService fileService;

	/**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/popnoti/popnotiList.do")
    public ModelAndView popnotiList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
    	Map<String, Object> param = _req.getParameterMap();
        param.put("use_yn", "Y" );
        param.put("today", "Y" );
        List<Map<String, Object>> list = popnotiService.selectMainPopnotiList(param);
        param.put("list", list );

        List<String> attachIdList = new ArrayList<String>();
        for(Map<String, Object> map:list){
        	if(map.get("attachId") != null){
        		attachIdList.add((String) map.get("attachId"));
         	}
        }

        if(attachIdList.size() > 0){
        	param.put("attachIdList", attachIdList);
        	List<Map<String, Object>> fileList = fileService.selectFileList(param);
        	param.put("fileList", fileList);
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
    @RequestMapping(value = "/front/popnoti/popnotiPreview.do")
	public String popnotiPreview(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = "/popup"+FRONT_PATH + "popnotiPreview";

        Map<String, Object> param = _req.getParameterMap();

        model.addAttribute("popnoti",param);

        return jsp;
	}

}
