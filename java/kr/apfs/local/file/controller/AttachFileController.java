package kr.apfs.local.file.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.JsonUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.file.service.AttachFileService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : FileController.java
 * @Description : FileController.Class
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
public class AttachFileController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(AttachFileController.class);

	@Resource(name = "AttachFileService")
    private AttachFileService fileService;

	/**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/common/file/fileList.do")
	public @ResponseBody Map<String, Object> fileList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> list = fileService.selectFileList(param);
		param.put("rows", list);

        return param;
	}

	/**
     * 데이타를 저장한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/common/file/insertFile.do")
    public ModelAndView insertFile(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	Map<String, Object> param = _req.getParameterMap();

        int rv =0;
        Map<String,Object> fileMap =JsonUtil.jacksonToObj((String) param.get("inFile"));
        try{
        	for (Entry<String, Object> entry : fileMap.entrySet()) {
        		//System.out.println("Key : " + entry.getKey() + " Value : " + entry.getValue());
        		fileMap.put(entry.getKey(), entry.getValue().toString().replace("\"", "").replace("[", "").replace("]", ""));
        	}

        	rv = fileService.insertFile(fileMap);	// 저장한다
			param.put("attachId", fileMap.get("attachId"));
			param.put("success", rv > 0 ? "true" : "false" );

		}catch (IOException e) {
        	logger.error("IOException error===", e);
        	param.put("success", "false"); 		// 실패여부 삽입
 			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false"); 		// 실패여부 삽입
 			return ViewHelper.getJsonView(param);
        }catch(Exception e){

			//e.printStackTrace();
			logger.error("error===", e);
 			param.put("success", "false"); 		// 실패여부 삽입

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
    @RequestMapping(value = "/common/file/updateFile.do")
    public ModelAndView updateFile(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	Map<String, Object> param = _req.getParameterMap();
    	int rv =0;
    	int inFileMapSize=0;
    	int delFileMapSize=0;
    	String[] delFileArray = null;
    	String[] inFileArray = null;

        Map<String,Object> inFileMap =JsonUtil.jacksonToObj((String) param.get("inFile"));
        Map<String,Object> delFileMap =JsonUtil.jacksonToObj((String) param.get("delFile"));

        
        if(delFileMap!=null){
        	delFileArray =  (delFileMap.get("uniqKey").toString().replace("\"", "")).replace("[", "").replace("]","").split(",");
        }
        param.put("delFileArray", delFileArray);
        try{
        	if (inFileMap != null) {
        		for (Entry<String, Object> entry : inFileMap.entrySet()) {
            		//System.out.println("Key : " + entry.getKey() + " Value : " + entry.getValue());
            		inFileMap.put(entry.getKey(), entry.getValue().toString().replaceAll("\"", "").replace("[", "").replace("]", ""));
            	}
			}
        	param.put("inFileMap", inFileMap);
        	if (inFileMap!=null||delFileMap!=null)rv = fileService.updateFile(param);

        	//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        	//System.out.println(rv);
        	//System.out.println(inFileMapSize);
        	//System.out.println(delFileMapSize);
        	//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			param.put("rv", rv );
			//param.put("success", rv>0? "true" : "false" );
			param.put("success", "true");

		}catch (IOException e) {
        	logger.error("IOException error===", e);
        	param.put("success", "false"); // 실패여부 삽입
 			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false"); // 실패여부 삽입
 			return ViewHelper.getJsonView(param);
        }catch(Exception e){
			//e.printStackTrace();
			logger.error("error===", e);
 			param.put("success", "false"); // 실패여부 삽입

 			return ViewHelper.getJsonView(param);
 		}
        
        List<Map<String, Object>> fileList = null;
        fileList = fileService.selectFileList(param);
        if (fileList.size() < 1) {
        	param.put("attachId",null);        	
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
    @RequestMapping(value = "/common/file/deleteFile.do")
    public ModelAndView deleteFile(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	Map<String, Object> param = _req.getParameterMap();

       	int rv = 0;

       	try{
       		rv = fileService.deleteFile(param);
       		param.put("success", rv > 0 ? "true" : "false" );
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        	param.put("success", "false");// 실패여부 삽입
 			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false");// 실패여부 삽입
 			return ViewHelper.getJsonView(param);
        }catch(Exception e){
        	//e.printStackTrace();
        	logger.error("error===", e);
 			param.put("success", "false");// 실패여부 삽입
 			return ViewHelper.getJsonView(param);
 		}
        return ViewHelper.getJsonView(param);
    }


}
