package kr.apfs.local.contents.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.common.fileupload.model.CommonFileVO;
import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.fileupload.FileUploadModel;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.contents.service.EmppageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


/**
 * @Class Name : EmppageController.java
 * @Description : EmppageController.Class
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
public class EmppageController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(EmppageController.class);
	
	public final static String  FRONT_PATH = "/front/content/";
	public final static String  BACK_PATH = "/back/contents/";
	
	@Resource(name = "CommonFileService")
	private CommonFileService commonFileService;	
	
	@Resource(name = "EmppageService")
	private EmppageService emppageService;
	
	
	/**
     * 리스트 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/contents/emppageListPage.do")
	public String emppageListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
		
		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();
		String jsp = BACK_PATH + "emppageListPage";			
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

		//해당 지역코드를 가지고 데이터의 로우를 가져온다
		rv = emppageService.selectEmppageExist(param);
		//rv > 0 지부등록, rv == 0 신규등록 
		model.put("listSize", rv);				
        return jsp;	
	}
		
	/**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/emppagePageList.do")
	public ModelAndView emppagePageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
		NavigatorInfo navigator = new NavigatorInfo(_req);	
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(emppageService.selectEmppagePageList(param));     
		
        return ViewHelper.getJqGridView(navigator);
	}

	
	/**
     * 쓰기 페이지로 이동한다  
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/emppageWrite.do")
	public String emppageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
         
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        String jsp = BACK_PATH + "emppageWrite";    									  
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> empPageInfo = new HashMap<String, Object>();
        empPageInfo.put("emp_id", "W");
        List<Map<String, Object>> empRankList = emppageService.selectEmpRankList(param);
        List<Map<String, Object>> empDeptList = emppageService.selectEmpDeptList(param);
        
        model.addAttribute("empPageInfo",empPageInfo);
        model.addAttribute("empRankList", empRankList);
        model.addAttribute("empDeptList", empDeptList);
        
        return jsp;
	}
    /**
     * 수정 페이지로 이동한다  
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/emppageEdit.do")
	public String emppageEdit(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
         
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        String jsp = BACK_PATH + "emppageWrite";    									  
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> empPageInfo = emppageService.selectEmppage(param);     
        List<Map<String, Object>> empRankList = emppageService.selectEmpRankList(param);
        List<Map<String, Object>> empDeptList = emppageService.selectEmpDeptList(param);
        model.addAttribute("empPageInfo", empPageInfo);
        model.addAttribute("empRankList", empRankList);
        model.addAttribute("empDeptList", empDeptList);
        
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
    @RequestMapping(value = "/back/contents/insertEmppage.do")
    public ModelAndView insertEmppage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
        
        if (param.get("mode").equals("W")) {
        try{
	       	rv = emppageService.insertEmppage(param);
	       	
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
        }
        else
        {
            try{
    	       	rv = emppageService.updateEmppage(param);
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
    @RequestMapping(value = "/back/contents/emppageUpdate.do")
    public ModelAndView updateEmppage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
    	 int rv =0;
         Map<String, Object> param = _req.getParameterMap();
         
         try{
         	
         	List<FileUploadModel> file = null;
         	if (param.get("emp_check")!=null) {
         		if (param.get("emp_check").equals("on")) {
 	        		param.put("emp_check", "Y");				
 				}
 			}      	
         	
         	
 	       	rv = emppageService.updateEmppage(param);
 	       	
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
    @RequestMapping(value = "/back/contents/deleteEmppage.do")
    public ModelAndView deleteEmppage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
       	try{
       		rv = emppageService.deleteEmppage(param);
       		
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
     * 데이타를 삭제한다 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/empReorderUpdate.do")
    public ModelAndView updateEmppageSort(ExtHtttprequestParam _req, ModelMap mode) throws Exception {
        
       	int rv = 0;
       	
        Map<String, Object> param = _req.getParameterMap();        
        
       	try{
       		rv = emppageService.updateEmppageSort(param);
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", "코드 순서를 조정하였습니다.");
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
    
    
    @RequestMapping(value = "/back/contents/updateRankReorder.do")
    public ModelAndView updateRankReorder(ExtHtttprequestParam _req, ModelMap mode) throws Exception {
        
       	int rv = 0;
       	
        Map<String, Object> param = _req.getParameterMap();        
        
       	try{
       									 
       		rv = emppageService.updateRankReorder(param);
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
    
    
    @RequestMapping(value = "/back/contents/updateDeptReorder.do")
    public ModelAndView updateDeptReorder(ExtHtttprequestParam _req, ModelMap mode) throws Exception {
        
       	int rv = 0;
       	
        Map<String, Object> param = _req.getParameterMap();        
        
       	try{
       									 
       		rv = emppageService.updateDeptReorder(param);
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", "코드 순서를 조정하였습니다.");
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
    
    @RequestMapping(value = "/back/contents/emprankWrite.do")
	public String emprankpagePreview(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        String jsp = "/sub"+BACK_PATH + "emprankListPopup";
        
        
        return jsp;
	}
    
    
    @RequestMapping(value = "/back/contents/empdeptWrite.do")
 	public String empdeptpagePreview(ExtHtttprequestParam _req, ModelMap model) throws Exception {
         
         String jsp = "/sub"+BACK_PATH + "empdeptListPopup";
         
         return jsp;
 	}
        
    @RequestMapping(value = "/back/contents/empRankInsertpage.do")
	public String empRankInsertpage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        
        String jsp = "/sub"+BACK_PATH + "emprankWritePopup";
        NavigatorInfo navigator = new NavigatorInfo(_req);	
        Map<String, Object> param  = navigator.getParam();
        Map<String, Object> empRankInfo = new HashMap<String, Object>();
        
        if (!param.get("rankId").equals("W")) empRankInfo = emppageService.selectRank(param);   	     	
        else	empRankInfo.put("rankId", "W");
        
        model.addAttribute("empRankInfo",empRankInfo );        	
        return jsp;
	}
    
    @RequestMapping(value = "/back/contents/empDeptInsertpage.do")
   	public String empDeptInsertpage(ExtHtttprequestParam _req, ModelMap model) throws Exception {
           String jsp = "/sub"+BACK_PATH + "empdeptWritePopup";
           NavigatorInfo navigator = new NavigatorInfo(_req);	
           Map<String, Object> param  = navigator.getParam();
           Map<String, Object> empDeptInfo = new HashMap<String, Object>();
           
           if (!param.get("deptId").equals("W")) empDeptInfo = emppageService.selectDept(param);   	     	
           else	empDeptInfo.put("deptId", "W");
           
           model.addAttribute("empDeptInfo",empDeptInfo );
           return jsp;
   	}
    
    @RequestMapping(value = "/back/contents/empRankList.do")
	public ModelAndView empRankList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	NavigatorInfo navigator = new NavigatorInfo(_req);	
        Map<String, Object> param  = navigator.getParam();
        navigator.setList(emppageService.selectEmpRankList(param));		
        return ViewHelper.getJqGridView(navigator);
        
	}
    
    
    @RequestMapping(value = "/back/contents/empDeptList.do")
  	public ModelAndView empDeptList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	
      	NavigatorInfo navigator = new NavigatorInfo(_req);	
          Map<String, Object> param  = navigator.getParam();
          navigator.setList(emppageService.selectEmpDeptList(param));		
          return ViewHelper.getJqGridView(navigator);
          
  	}
    
 
    @RequestMapping(value = "/back/contents/empRankInsert.do")
    public ModelAndView empRankInsert(ExtHtttprequestParam _req, ModelMap mode) throws Exception {
        
       	int rv = 0;
       	
        Map<String, Object> param = _req.getParameterMap();        
        
        
        if (param.get("rankId").toString().equals("W")) {
        	try{
           		rv = emppageService.insertEmpRank(param);
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
		}
        else{
        	try{
           		rv = emppageService.updateRank(param);
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
        	
        }
       					
        									
        return ViewHelper.getJsonView(param);
    }
    
    
    
    @RequestMapping(value = "/back/contents/empDeptInsert.do")
    public ModelAndView empDeptInsert(ExtHtttprequestParam _req, ModelMap mode) throws Exception {
        
       	int rv = 0;
       	
        Map<String, Object> param = _req.getParameterMap();        
        
        if (param.get("deptId").toString().equals("W")) {
        	try{
           		rv = emppageService.insertEmpDept(param);
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
		}
        else{
        	try{
           		rv = emppageService.updateDept(param);
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
        	
        }
       					
        									
        return ViewHelper.getJsonView(param);
    }
    
    
        
    
    @RequestMapping(value = "/back/contents/empRankDelete.do")
    public ModelAndView empRankDelete(ExtHtttprequestParam _req, ModelMap mode) throws Exception {
        
       	int rv = 0;
       	
        Map<String, Object> param = _req.getParameterMap();        
     
       
        	try{
           		rv = emppageService.deleteRank(param);
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
    
    @RequestMapping(value = "/back/contents/empDeptDelete.do")
    public ModelAndView empDeptDelete(ExtHtttprequestParam _req, ModelMap mode) throws Exception {
        
       	int rv = 0;
       	
        Map<String, Object> param = _req.getParameterMap();        
     
       
        	try{
           		rv = emppageService.deleteDept(param);
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



