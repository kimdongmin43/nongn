package kr.apfs.local.main.controller;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.JsonUtil;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.util.fileupload.FileUploadModel;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.file.service.AttachFileService;
import kr.apfs.local.filter.CrossScriptingFilter;
import kr.apfs.local.main.service.MainBoardService;
import kr.apfs.local.main.service.MainImageService;
import kr.apfs.local.main.service.MainService;
import kr.apfs.local.popnoti.service.PopnotiService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.parser.JSONParser;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : MainController.java
 * @Description : MainController.Class
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
public class MainController extends ComAbstractController{

	private static final Logger logger = LogManager.getLogger(MainController.class);

	public final static String  FRONT_PATH = "/front/main/";
	public final static String  BACK_PATH = "/back/main/";
	public final static String  BACK_PATH2 = "/back/popnoti/";

	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;

	@Resource(name = "AttachFileService")
    private AttachFileService fileService;

	@Resource(name = "MainService")
    private MainService mainService;

	@Resource(name = "MainBoardService")
    private MainBoardService mainBoardService;

	@Resource(name = "MainImageService")
    private MainImageService mainImageService;

	@Resource(name = "PopnotiService")
    private PopnotiService popnotiService;



	/**
     * 메인관리 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/main/mainListPage.do")
	public String mainTypeListPage(ExtHtttprequestParam _req,HttpSession session, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> mainParam = new HashMap<String, Object>();

		mainParam.put("pubYn", "Y" );
		mainParam.put("siteId", session.getAttribute("*siteId") );
		List<Map<String,Object>> mainList = mainService.selectMainList(mainParam);

		if(mainList.size() > 0)
		{

		    Map<String,Object> mainMap = mainList.get(0);

		    model.addAttribute("mainMap", mainMap );
		    param.put("mainId", mainMap.get("mainId"));
			//List<Map<String, Object>> mainList = mainService.selectMainList(param);
	        List<Map<String, Object>> boardList = mainBoardService.selectBoardList(param);
	        List<Map<String, Object>> mainImageList = mainImageService.selectMainImageList(param);
	        List<Map<String, Object>> mainBoardList = mainBoardService.selectMainBoardList(param);


	        //model.addAttribute("mainList", mainList);
	        model.addAttribute("boardList", boardList);
	        model.addAttribute("mainImageList", mainImageList);
	        model.addAttribute("mainBoardList", mainBoardList);
		}

		String jsp = BACK_PATH + "mainListPage";

        return jsp;
	}

	/**
     * 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/main/popnotiListPage.do")
	public String popnotiListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		String jsp = BACK_PATH2 + "popnotiListPage";

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
    @RequestMapping(value = "/back/main/popnotiPageList.do")
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
    @RequestMapping(value = "/back/main/popnotiList.do")
	public @ResponseBody Map<String, Object> popnotiList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = BACK_PATH2 + "popnotiListPage";

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
    @RequestMapping(value = "/back/main/popnotiWrite.do")
	public String popnotiWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {



    	String jsp = "/sub"+BACK_PATH + "mainImageWrite";

        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> popnoti = new HashMap<String, Object>();
        List<Map<String,Object>> list = popnotiService.selectPopnotiPageList(param);
        if(list.size()>0 && !StringUtil.nvl(param.get("mode")).equals("W")){
        	popnoti = list.get(0);
        }
        model.addAttribute("mainImage",popnoti);

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
    @RequestMapping(value = "/back/main/insertPopnoti.do")
    public ModelAndView insertPopnoti(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{


        	List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("/pop/"));
    		FileUploadModel file = null;

    		//단건처리용 파라메터 맵 생성   fileVo 제거 중
    		Map<String, Object> fileParam = new HashMap<String, Object>();

    		if(fileList != null && fileList.size()>0){
    		   file = (FileUploadModel)fileList.get(0);
    		   fileParam.put("attachId", CommonUtil.createUUID());
    		   fileParam.put("fileNm", file.getFileName());
    		   fileParam.put("originFileNm", file.getOriginalFileName());
    		   fileParam.put("fileType", file.getExtension());
    		   fileParam.put("fileSize", file.getFileSize());
    		   fileParam.put("filePath", "/file/pop/");
    		   fileParam.put("*userId", param.get("*userId"));
   	   	       commonFileService.insertCommonFile(fileParam);
               param.put("attachId",fileParam.get("attachId"));
    		}

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
    @RequestMapping(value = "/back/main/updatePopnoti.do")
    public ModelAndView updatePopnoti(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

        try{


        	List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("/pop/"));
    		FileUploadModel file = null;

    		//단건처리용 파라메터 맵 생성   fileVo 제거 중
    		Map<String, Object> fileParam = new HashMap<String, Object>();

    		if(fileList != null && fileList.size()>0){
    		   file = (FileUploadModel)fileList.get(0);
    		   fileParam.put("attachId", CommonUtil.createUUID());
    		   fileParam.put("fileNm", file.getFileName());
    		   fileParam.put("originFileNm", file.getOriginalFileName());
    		   fileParam.put("fileType", file.getExtension());
    		   fileParam.put("fileSize", file.getFileSize());
    		   fileParam.put("filePath", "/file/pop/");
    		   fileParam.put("*userId", param.get("*userId"));
   	   	       commonFileService.insertCommonFile(fileParam);
               param.put("attachId",fileParam.get("attachId"));
    		}

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
    @RequestMapping(value = "/back/main/deletePopnoti.do")
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
     * 메인관리 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/main/mainImgList.do")
	public ModelAndView mainImgList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();

        List<Map<String, Object>> mainImageList = new ArrayList<Map<String,Object>>();

        if (param.get("tabGbn").equals("A")) {
        	mainImageList = mainImageService.selectMainImageList(param);
		}
        else{
        	mainImageList = popnotiService.selectPopnotiList(param);
        }



        model.addAttribute("rows", mainImageList);

        return ViewHelper.getJsonView(param);
	}

	/**
     * 메인관리 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/main/preview.do")
	public String preview(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();

		//System.out.println("previewMain : " + param);

		List<Map<String, Object>> mainboardList = mainBoardService.selectMainBoardList(param);
        List<Map<String, Object>> mainImageList = mainImageService.selectMainImageList(param);
        model.addAttribute("mainboardList", mainboardList);
        model.addAttribute("mainImageList", mainImageList);

		String jsp = "/sub"+BACK_PATH + "previewPop";
        return jsp;
	}

	/**
     * 메인관리 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/main/version.do")
	public String version(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();

		Map<String, Object> verParam = new HashMap<String, Object>();
		verParam.put("*siteId",param.get("*siteId"));
		verParam.put("delYN", "N");
		verParam.put("useYn", "Y");
        List<Map<String, Object>> saveMainList = mainService.selectMainList(verParam);
		List<Map<String, Object>> mainboardList = mainBoardService.selectMainBoardList(param);
        List<Map<String, Object>> mainImageList = mainImageService.selectMainImageList(param);

        model.addAttribute("saveMainList", saveMainList);
        model.addAttribute("mainboardList", mainboardList);
        model.addAttribute("mainImageList", mainImageList);

		String jsp = "/sub"+BACK_PATH + "versionPop";
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
    @RequestMapping(value = "/back/main/mainImgListPage.do")
    public ModelAndView mainImgListPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	/*List<Map<String, Object>> mainImageList;
        Map<String, Object> param = _req.getParameterMap();

        try{

        	mainImageList = mainImageService.selectMainImageList(param);

	       	if(mainImageList.size() > 0){
				param.put("success", "true" );
				param.put("mainImageList", mainImageList );
			}
		}catch(Exception e){
			e.printStackTrace();
 			param.put("success", "false"); 													// 실패여부 삽입
 			return ViewHelper.getJsonView(param);
 		}

        return ViewHelper.getJsonView(param);*/

    	NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(mainImageService.selectMainImageList(param));

        return ViewHelper.getJqGridView(navigator);

    }

	/**
     * 쓰기 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/main/mainImageWrite.do")
	public String mainImageWrite(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = "/sub"+BACK_PATH + "mainImageWrite";

        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> mainImage = new HashMap<String, Object>();
        List<Map<String,Object>> list = mainImageService.selectMainImageList(param);



        if(list.size()>0 && !StringUtil.nvl(param.get("mode")).equals("W")){
        	mainImage = list.get(0);
        }
        model.addAttribute("mainImage",mainImage);

        return jsp;
	}

	/**
     * 데이타를 저장한다(임시저장에 이용)
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/main/insertMain.do")
    public ModelAndView insertMain(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{

        	//System.out.println("curMain : " + param);

    		//임시저장할 메인생성
	       	rv = mainService.insertMain(param);

	       	//System.out.println("newMain : " + param);

        	//메인노출 게시판
       		String mainBoardListString = (String) param.get("mainBoardList");
       		JSONParser parser =new JSONParser();
    		List<Map<String, Object>> mainBoardList = (List<Map<String, Object>>)parser.parse(mainBoardListString);
    		param.put("mainBoardList", mainBoardList);
    		mainBoardService.insertMainBoard(param);
    		mainImageService.copyMainImageList(param);

    		//다른 임시저장된 메인 및 메인이미지 메인보드 삭제
    		//mainService.deleteMain(param);

	       	if(rv > 0){
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
     * 데이타를 수정한다(사이트적용에 이용)
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/main/updateMain.do")
    public ModelAndView updateMain(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{

    		//사이트 적용될 메인 생성
        	if(!param.get("mode").equals("E")){
        		rv = mainService.insertMain(param);
        		 //사이트적용
    	       	mainService.updateMain(param);
        	}else{
        		rv = mainService.updateMain(param);
        	}
        	//메인노출 게시판
       		String mainBoardListString = (String) param.get("mainBoardList");
       		JSONParser parser =new JSONParser();
    		List<Map<String, Object>> mainBoardList = (List<Map<String, Object>>)parser.parse(mainBoardListString);
    		param.put("mainBoardList", mainBoardList);
    		if(!param.get("mode").equals("E")) {
    			mainBoardService.insertMainBoard(param);
    			mainImageService.copyMainImageList(param);
    		}

    		//다른 임시저장된 메인 및 메인이미지 메인보드 삭제
    		mainService.deleteMain(param);

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
     * 데이타를 수정한다(사이트적용에 이용)
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/main/updateVersionMain.do")
    public ModelAndView updateVersionMain(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{

	        //사이트적용
	       	rv = mainService.updateMain(param);

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
    @RequestMapping(value = "/back/main/deleteMain.do")
    public ModelAndView deleteMain(ExtHtttprequestParam _req, ModelMap model) throws Exception {

       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
       		rv = mainService.deleteMain(param);

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
	 * main 순서를 재조정해준다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/mainmainListMainImageSort.do")
	public ModelAndView saveMainImageSort(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	   	int rv = 0;
	    Map<String, Object> param = _req.getParameterMap();

        List<Map<String, Object>> list = (ArrayList<Map<String ,Object>>)JsonUtil.fromJsonStr(param.get("imgList").toString().replace("&quot;","'"));
	    param.put("imgList", list);
	   	try{
	   		rv = mainImageService.saveMainImageSort(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", "이미지 순서를 저장하였습니다.");
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
	 * 이미지를 등록한다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/main/insertMainImg.do")
	public ModelAndView insertMainImg(ExtHtttprequestParam _req, ModelMap model) throws Exception {


		int rv =0;

        Map<String, Object> param = _req.getParameterMap();

        try{


        	List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("/maimg/"));
    		FileUploadModel file = null;

    		//단건처리용 파라메터 맵 생성   fileVo 제거 중
    		Map<String, Object> fileParam = new HashMap<String, Object>();

    		if(fileList != null && fileList.size()>0){
    		   file = (FileUploadModel)fileList.get(0);
    		   fileParam.put("attachId", CommonUtil.createUUID());
    		   fileParam.put("fileNm", file.getFileName());
    		   fileParam.put("originFileNm", file.getOriginalFileName());
    		   fileParam.put("fileType", file.getExtension());
    		   fileParam.put("fileSize", file.getFileSize());
    		   fileParam.put("filePath", "/file/maimg/");
    		   fileParam.put("*userId", param.get("*userId"));
   	   	       commonFileService.insertCommonFile(fileParam);
               param.put("attachId",fileParam.get("attachId"));
    		}

            rv = mainImageService.insertMainImage(param);


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
	 * 이미지 순서를 저장한다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/main/saveMainImgSort.do")
	public ModelAndView saveMainImgSort(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		int rv = 0;

        Map<String, Object> param = _req.getParameterMap();

       	try{
       		rv = mainImageService.saveMainImageSort(param);
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", "이미지 순서를 조정하였습니다.");
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
	 * 이미지를 수정한다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/main/updateMainImg.do")
	public ModelAndView updateMainImg(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		int rv =0;

        Map<String, Object> param = _req.getParameterMap();

        try{


        	List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("/maimg/"));
    		FileUploadModel file = null;

    		//단건처리용 파라메터 맵 생성   fileVo 제거 중
    		Map<String, Object> fileParam = new HashMap<String, Object>();

    		if(fileList != null && fileList.size()>0){
    		   file = (FileUploadModel)fileList.get(0);
    		   fileParam.put("attachId", CommonUtil.createUUID());
    		   fileParam.put("fileNm", file.getFileName());
    		   fileParam.put("originFileNm", file.getOriginalFileName());
    		   fileParam.put("fileType", file.getExtension());
    		   fileParam.put("fileSize", file.getFileSize());
    		   fileParam.put("filePath", "/file/maimg/");
    		   fileParam.put("*userId", param.get("*userId"));
   	   	       commonFileService.insertCommonFile(fileParam);
               param.put("attachId",fileParam.get("attachId"));
    		}

            rv = mainImageService.updateMainImage(param);


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
	 * 이미지를 삭제한다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/main/deleteMainImg.do")
	public ModelAndView deleteMainImg(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{

    		//메인타입지정
	       	rv = mainImageService.deleteMainImage(param);

	       	if(rv > 0){
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
     * 검색 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/front/main/searchPage.do")
	public String searchPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
		String jsp = "/search/front/search/searchListPage";
		Map<String, Object> param = _req.getParameterMap();
		System.out.println("param==="+param);
		/* 추가(수정) 코드 - 2018.06.18(월) - (주)아사달 대리 함민석  - 2022.01.27 운영서버 비교 시 누락된 부분 있음 */
		String total_searchTxt = param.get("total_searchTxt") == null ? "" : (String)param.get("total_searchTxt");
		String searchTxt = param.get("searchTxt") == null ? "" : (String)param.get("searchTxt");
		System.out.println("total_searchTxt111==="+total_searchTxt);
		searchTxt = StringUtil.cleanXSSResult(searchTxt);
		total_searchTxt = StringUtil.cleanXSSResult(total_searchTxt);
		System.out.println("total_searchTxt222==="+total_searchTxt);
		param.put("searchTxt", searchTxt);
		param.put("total_searchTxt", total_searchTxt);
		
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		model.addAttribute("total_searchTxt", total_searchTxt);		//	2020.11.04 - 강철구 추가(서버 클래스 디컴파일/비교 후)
		model.addAttribute("searchTxt", searchTxt);					//	2020.11.04 - 강철구 추가(서버 클래스 디컴파일/비교 후)
		
        return jsp;
	}

	//
	/**
     * 게시물 타입별 리스트
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/main/searchContents.do")
	public String boardContentsList(ExtHtttprequestParam _req, ListOp listOp, ModelMap model , HttpSession session) throws Exception {

    	String jsp =  "/sub/front/search/";
    	
		NavigatorInfo navigator = new NavigatorInfo(_req);
		Map<String, Object> param  = navigator.getParam();
		param.put("sidx", "convert(int,left(reg_dt,10)) DESC, cont_id");
		param.put("sord", "desc");
		
		jsp +=  "searchContents";

		navigator.setList(mainService.selectSearchContents(param));

		model.addAttribute("boardList", navigator.getList());
		model.addAttribute("boardPagging", navigator.getPagging());
		model.addAttribute("totalcnt", navigator.getTotalCnt());

        return jsp;
	}


    /**
     * 게시물 타입별 리스트
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/front/main/searchList.do")
	public String searchList(ExtHtttprequestParam _req, ListOp listOp, ModelMap model , HttpSession session) throws Exception {

    	String jsp =  "/sub/front/search/";

		NavigatorInfo navigator = new NavigatorInfo(_req);
		Map<String, Object> param  = navigator.getParam();
		param.put("sidx", "convert(int,left(reg_dt,10)) DESC, cont_id");
		param.put("sord", "desc");

		jsp +=  "searchList";

		navigator.setList(mainService.selectSearchList(param));

		model.addAttribute("boardList", navigator.getList());
		model.addAttribute("boardPagging", navigator.getPagging());
		model.addAttribute("totalcnt", navigator.getTotalCnt());


        return jsp;
	}
}
