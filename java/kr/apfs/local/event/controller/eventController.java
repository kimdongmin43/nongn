package kr.apfs.local.event.controller;

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
import kr.apfs.local.event.service.eventService;

/**
 * @Class Name : eventController.java
 * @Description : eventController.Class
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
public class eventController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(eventController.class);

	public final static String  FRONT_PATH = "/front/event/";
	public final static String  BACK_PATH = "/back/event/";
	public final static String  BACK_PATH2 = "/back/contents/";

	@Resource(name = "eventService")
    private eventService eventService;

	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;

	/**
     * 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
/*	@RequestMapping(value = "/back/contents/eventListPage.do")
	public String eventListPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = BACK_PATH + "eventListPage";
		String sectionCd = "";


		Map<String, Object> param = _req.getParameterMap();
		sectionCd = param.containsKey("arearCd")?param.get("arearCd").toString():"1";

		model.put("sectionCd", sectionCd);

        return jsp;
	}*/

	/**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/event/eventPageList.do")
	public String eventPageList(ExtHtttprequestParam _req,ListOp listOp, ModelMap model) throws Exception {


    	String jsp = BACK_PATH + "eventListPage";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

        return jsp;
	}

	/**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/event/eventList.do")
	public ModelAndView eventList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(eventService.ScheduleList(param));
		
        return ViewHelper.getJqGridView(navigator);
	}
    



    

	/**
     * 쓰기 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
 /*   @RequestMapping(value = "/back/contents/eventWrite.do")
	public String eventWrite(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = "/sub"+BACK_PATH + "eventWrite";

        Map<String, Object> param = _req.getParameterMap();

        Map<String, Object> event = new HashMap();
        if(!StringUtil.nvl(param.get("mode")).equals("W")){
        	 // event 정보를 가져온다.
        	event = eventService.selectevent(param);
        }else{

        	event.put("targetCd", "_self");
        	event.put("useYn", "Y");
        	event.put("sectionCd",param.get("sectionCd"));

        }

        model.addAttribute("event",event);

        return jsp;
	}*/
    
    
    
    
    
    @RequestMapping(value = "/back/event/eventWrite.do")
  	public String eventWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
  				
  		Map<String, Object> param = _req.getParameterMap();
  		String jsp = BACK_PATH + "eventWrite";	
  		
  	    Map<String, Object> event = new HashMap();
  		
  	       if(!StringUtil.nvl(param.get("mode")).equals("W")){
  	        	 // 
  	    	    event = eventService.ScheduleListBack(param);
  	        }else{
  	        	event.put("schdIdx",param.get("schdIdx"));
  	        }

          model.addAttribute("event",event);	
          
          
          
  		
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
  	    @RequestMapping(value = "/back/event/insertEvent.do")
  	    public ModelAndView insertEvent(ExtHtttprequestParam _req, ModelMap model) throws Exception {

  	        int rv = 0;
  	        Map<String, Object> param = _req.getParameterMap();

  	
  		       	rv = eventService.insertEvent(param);

  		       	if(rv > 0){																	// 저장한다
  					param.put("success", "true" );
  		        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
  				}else{
  					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
  					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
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
  	    @RequestMapping(value = "/back/event/updateEvent.do")
  	    public ModelAndView updateEvent(ExtHtttprequestParam _req, ModelMap model) throws Exception {

  	        int rv = 0;
  	        Map<String, Object> param = _req.getParameterMap();

  	
  		       	rv = eventService.updateEvent(param);

  		       	if(rv > 0){																	// 저장한다
  					param.put("success", "true" );
  		        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
  				}else{
  					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
  					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
  				}
  	     
  	        return ViewHelper.getJsonView(param);
  	    }
  	
  	    
  	    @RequestMapping(value = "/back/event/deleteEvent.do")
  	    public ModelAndView deleteEvent(ExtHtttprequestParam _req, ModelMap model) throws Exception {

  	        int rv = 0;
  	        Map<String, Object> param = _req.getParameterMap();

  	
  		       	rv = eventService.deleteEvent(param);

  		       	if(rv > 0){																	// 저장한다
  					param.put("success", "true" );
  		        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
  				}else{
  					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
  					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
  				}
  	     
  	        return ViewHelper.getJsonView(param);
  	    }
  	
      
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

	/**
     * 데이타를 저장한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     *//*
    @RequestMapping(value = "/back/contents/insertevent.do")
    public ModelAndView insertevent(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
       		List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("event/"));
    		FileUploadModel file = null;
    		Map<String, Object> fileParam = new HashMap<String, Object>();

     		if(fileList != null && fileList.size()>0){
     		   file = (FileUploadModel)fileList.get(0);
     		   fileParam.put("attachId", CommonUtil.createUUID());
     		   fileParam.put("fileNm", file.getFileName());
     		   fileParam.put("originFileNm", file.getOriginalFileName());
     		   fileParam.put("fileType", file.getExtension());
     		   fileParam.put("fileSize", file.getFileSize());
     		   fileParam.put("filePath", "/event/");
     		   fileParam.put("*userId", param.get("*userId"));
   	   	       commonFileService.insertCommonFile(fileParam);
               param.put("attachId",fileParam.get("attachId"));
    		}
	       	rv = eventService.insertevent(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
        }catch(Exception e){
        	e.printStackTrace();
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}

        return ViewHelper.getJsonView(param);
    }

	*//**
     * 데이타를 수정한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     *//*
    @RequestMapping(value = "/back/contents/updateevent.do")
    public ModelAndView updateevent(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
       		List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("event/"));
    		FileUploadModel file = null;
    		Map<String, Object> fileParam = new HashMap<String, Object>();

     		if(fileList != null && fileList.size()>0){
     		   file = (FileUploadModel)fileList.get(0);
     		   fileParam.put("attachId", CommonUtil.createUUID());
     		   fileParam.put("fileNm", file.getFileName());
     		   fileParam.put("originFileNm", file.getOriginalFileName());
     		   fileParam.put("fileType", file.getExtension());
     		   fileParam.put("fileSize", file.getFileSize());
     		   fileParam.put("filePath", "/event/");
     		   fileParam.put("*userId", param.get("*userId"));
   	   	       commonFileService.insertCommonFile(fileParam);
               param.put("attachId",fileParam.get("attachId"));
    		}
	       	rv = eventService.updateevent(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
        }catch(Exception e){
        	e.printStackTrace();
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}

        return ViewHelper.getJsonView(param);
    }

	*//**
     * 데이타를 삭제한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     *//*
    @RequestMapping(value = "/back/contents/deleteevent.do")
    public ModelAndView deleteevent(ExtHtttprequestParam _req, ModelMap model) throws Exception {

       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
       		rv = eventService.deleteevent(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getDeteleMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
        }catch(Exception e){
        	e.printStackTrace();
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
 		}

        return ViewHelper.getJsonView(param);
    }
*/
	

}
