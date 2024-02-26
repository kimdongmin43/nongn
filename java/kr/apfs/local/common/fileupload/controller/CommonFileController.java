package kr.apfs.local.common.fileupload.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.apfs.local.board.service.BoardService;
import kr.apfs.local.common.fileupload.model.CommonFileVO;
import kr.apfs.local.common.fileupload.model.FileVO;
import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.ObjUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.util.fileupload.FileDownloadInfo;
import kr.apfs.local.common.util.fileupload.FileSupport;
import kr.apfs.local.common.util.fileupload.FileUploadModel;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;

@Controller
public class CommonFileController extends ComAbstractController
{

	private static final Logger logger = LoggerFactory.getLogger(CommonFileController.class);
	public final static String  JSP_PATH = "/commonfile/";
	public final static String  FRONT_PATH = "/front/board/";
	@Resource(name = "CommonFileService")
	private CommonFileService commonFileService;
	
    /**
     * file_id를 받아 파일 다운로드를 처리해준다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/commonfile/fileidDownLoad.do", method = RequestMethod.GET) //, method = RequestMethod.POST
    public ModelAndView fileidDownLoad(ExtHtttprequestParam _req, ModelMap model) throws Exception {
		int rv =0;
		Map<String, Object> param 		= _req.getParameterMap();									//param값의 맵을 만듬
		String path="";																				//파일경로
		String filename="";																			//파일이름
		String orignl_file_nm="";																	//파일이름
		Map<String, Object> param2=null;
		String jsp =  "";
		System.out.println("fileidDownLoadparam1 + " + param);
		param2 = commonFileService.getCommonFile(param);
		System.out.println("fileidDownLoadparam2 + " + param2);
		
		path = param2.get("filePath").toString();		
		filename = param2.get("fileNm").toString();
		orignl_file_nm = param2.get("originFileNm").toString();
		
		
		String pramAttachId = (String) param.get("attachId");	//요청된 attachId 값
		String pramAttachId2 = (String) param2.get("attachId");	//DB에 있는 attachId 값
		if(pramAttachId.equals(pramAttachId2)){		//요청된 attachId 값과 DB에 있는 attachId 값을 비교
			System.out.println("파일 다운로드 성공!");
			FileDownloadInfo file = new FileDownloadInfo(path,filename,orignl_file_nm);								//다운로드 받을 파일 정보를 만듬
			return ViewHelper.getFileDownloadView(file);
		}
		else{
			System.out.println("파일 다운로드 실패!");
			return null;
		}
		
//		FileDownloadInfo file = new FileDownloadInfo(path,filename,orignl_file_nm);								//다운로드 받을 파일 정보를 만듬
		
		
//		return ViewHelper.getFileDownloadView(file);
    }

	
	//디비 삭제 작업만 일단
	@RequestMapping(value = "/commonfile/deleteFile.do")
    public ModelAndView insertCeopage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
        try{
        	
        	rv = commonFileService.deleteCommonFile(param.get("fileId").toString());
	       	
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

	
	
	
	
	
	
	
	
	
	
	

}
