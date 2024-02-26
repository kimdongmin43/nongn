package kr.apfs.local.banner.controller;

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
import kr.apfs.local.banner.service.BannerService;

/**
 * @Class Name : BannerFrontController.java
 * @Description : BannerFrontController.Class
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
public class BannerFrontController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(BannerFrontController.class);
	
	public final static String  FRONT_PATH = "/front/banner/";
	
	@Resource(name = "BannerService")
    private BannerService bannerService;
	
	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;
	
	/**
     * 게시판 메인 출력용 게시물
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/banner/loadMainBanner.do")
    public ModelAndView loadMainBoard(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        Map<String, Object> param = _req.getParameterMap();
        param.put("use_yn", "Y" );
        List<Map<String, Object>> list = bannerService.selectBannerList(param);	
        param.put("list", list );
        return ViewHelper.getJsonView(param);
    }

}
