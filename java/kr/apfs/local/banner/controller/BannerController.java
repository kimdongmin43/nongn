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
 * @Class Name : BannerController.java
 * @Description : BannerController.Class
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
public class BannerController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(BannerController.class);

	public final static String  FRONT_PATH = "/front/banner/";
	public final static String  BACK_PATH = "/back/banner/";

	@Resource(name = "BannerService")
    private BannerService bannerService;

	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;

	/**
     * 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/banner/bannerListPage.do")
	public String bannerListPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = BACK_PATH + "bannerListPage";
		String sectionCd = "";


		Map<String, Object> param = _req.getParameterMap();
		sectionCd = param.containsKey("arearCd")?param.get("arearCd").toString():"1";

		model.put("sectionCd", sectionCd);

        return jsp;
	}

	/**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/banner/bannerPageList.do")
	public ModelAndView bannerPageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();



		navigator.setList(bannerService.selectBannerPageList(param));


        return ViewHelper.getJqGridView(navigator);
	}

	/**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/banner/bannerList.do")
	public @ResponseBody Map<String, Object> bannerList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = BACK_PATH + "bannerListPage";
        Map<String, Object> param = _req.getParameterMap();
		List<Map<String, Object>> list = bannerService.selectBannerListBack(param);
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
    @RequestMapping(value = "/back/banner/bannerWrite.do")
	public String bannerWrite(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = "/sub"+BACK_PATH + "bannerWrite";

        Map<String, Object> param = _req.getParameterMap();

        Map<String, Object> banner = new HashMap();
        if(!StringUtil.nvl(param.get("mode")).equals("W")){
        	 // banner 정보를 가져온다.
        	banner = bannerService.selectBanner(param);
        }else{

        	banner.put("targetCd", "_self");
        	banner.put("useYn", "Y");
        	banner.put("sectionCd",param.get("sectionCd"));

        }

        model.addAttribute("banner",banner);

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
    @RequestMapping(value = "/back/banner/insertBanner.do")
    public ModelAndView insertBanner(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
       		List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("banner/"));
    		FileUploadModel file = null;
    		Map<String, Object> fileParam = new HashMap<String, Object>();

     		if(fileList != null && fileList.size()>0){
     		   file = (FileUploadModel)fileList.get(0);
     		   fileParam.put("attachId", CommonUtil.createUUID());
     		   fileParam.put("fileNm", file.getFileName());
     		   fileParam.put("originFileNm", file.getOriginalFileName());
     		   fileParam.put("fileType", file.getExtension());
     		   fileParam.put("fileSize", file.getFileSize());
     		   fileParam.put("filePath", "/banner/");
     		   fileParam.put("*userId", param.get("*userId"));
   	   	       commonFileService.insertCommonFile(fileParam);
               param.put("attachId",fileParam.get("attachId"));
    		}
	       	rv = bannerService.insertBanner(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
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
     * 데이타를 수정한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/banner/updateBanner.do")
    public ModelAndView updateBanner(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
       		List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("banner/"));
    		FileUploadModel file = null;
    		Map<String, Object> fileParam = new HashMap<String, Object>();

     		if(fileList != null && fileList.size()>0){
     		   file = (FileUploadModel)fileList.get(0);
     		   fileParam.put("attachId", CommonUtil.createUUID());
     		   fileParam.put("fileNm", file.getFileName());
     		   fileParam.put("originFileNm", file.getOriginalFileName());
     		   fileParam.put("fileType", file.getExtension());
     		   fileParam.put("fileSize", file.getFileSize());
     		   fileParam.put("filePath", "/banner/");
     		   fileParam.put("*userId", param.get("*userId"));
   	   	       commonFileService.insertCommonFile(fileParam);
               param.put("attachId",fileParam.get("attachId"));
    		}
	       	rv = bannerService.updateBanner(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
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
     * 데이타를 삭제한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/banner/deleteBanner.do")
    public ModelAndView deleteBanner(ExtHtttprequestParam _req, ModelMap model) throws Exception {

       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
       		rv = bannerService.deleteBanner(param);

	       	if(rv > 0){																	// 저장한다
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
	 * banner 순서를 재조정해준다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/banner/updateBannerReorder.do")
	public ModelAndView updateBannerReorder(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	   	int rv = 0;
	    Map<String, Object> param = _req.getParameterMap();

	   	try{
	   		rv = bannerService.updateBannerReorder(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", "배너 순서를 저장하였습니다.");
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

}
