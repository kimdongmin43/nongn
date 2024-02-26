package kr.apfs.local.contents.controller;

import java.io.IOException;
import java.util.ArrayList;
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
import kr.apfs.local.contents.service.ExepageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


/**
 * @Class Name : ExepageController.java
 * @Description : ExepageController.Class
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
public class ExepageController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(ExepageController.class);

	public final static String  FRONT_PATH = "/front/content/";
	public final static String  BACK_PATH = "/back/contents/";

	@Resource(name = "CommonFileService")
	private CommonFileService commonFileService;

	@Resource(name = "ExepageService")
	private ExepageService exepageService;


	/**
     * 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/contents/exepageListPage.do")
	public String exepageListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();
		String jsp = BACK_PATH + "exepageListPage";
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

		//해당 지역코드를 가지고 데이터의 로우를 가져온다
		//rv = exepageService.selectExepageExist(param);
		//rv > 0 지부등록, rv == 0 신규등록
		//model.put("listSize", rv);
		/*model.put("exe_cd", "1");	*/

		//System.out.println("::::::::::::::::::");
		//System.out.println( param.get("exeCd")==null?1:param.get("exeCd"));
		//System.out.println("::::::::::::::::::");
		model.put("exeCd", param.get("exeCd")==null?1:param.get("exeCd"));
        return jsp;
	}

	/**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/exepagePageList.do")
	public ModelAndView exepagePageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
        //System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@");
        //System.out.println(param);
        //System.out.println(navigator.getParam());
        //System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@");
        model.put("exeCd", param.get("exeCd"));
		navigator.setList(exepageService.selectExepagePageList(param));


        return ViewHelper.getJqGridView(navigator);
	}



	   @RequestMapping(value = "/back/contents/updateExeRankReorder.do")
    public ModelAndView updateRankReorder(ExtHtttprequestParam _req, ModelMap mode) throws Exception {

       	int rv = 0;

        Map<String, Object> param = _req.getParameterMap();

       	try{

       		rv = exepageService.updateRankReorder(param);
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
     * 쓰기 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/exepageWrite.do")
	public String exepageWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        String jsp = BACK_PATH + "exepageWrite";
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> exePageInfo = new HashMap<String, Object>();
        List<Map<String, Object>> exeCdInfo = new ArrayList<Map<String,Object>>();


        exeCdInfo = exepageService.selectExeCd(param);
        List<Map<String, Object>> exeRankList = exepageService.selectExeRankList(param);
        exePageInfo.put("exeId", "W");
        exePageInfo.put("exeCd", param.get("exeCd"));


        model.addAttribute("exeCdInfo", exeCdInfo);
        model.addAttribute("exePageInfo",exePageInfo);
        model.addAttribute("exeRankList", exeRankList);


        return jsp;
	}
    /**
     * 수정 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/contents/exepageEdit.do")
	public String exepageEdit(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

    	List<Map<String, Object>> exeCdInfo = null;
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        String jsp = BACK_PATH + "exepageWrite";
        Map<String, Object> param = _req.getParameterMap();
        /*//List<Map<String, Object>> exePageInfo = exepageService.selectExepage(param);
        String [] tel = exePageInfo.get("tel").toString().split("\\^",-1);
        for (int i = 0; i < tel.length; i++) {
			exePageInfo.put("tel"+(i+1), tel[i]);
		}
        //System.out.println("exePageInfo"+exePageInfo);
        exeCdInfo = exepageService.selectExeCd(param);
        List<Map<String, Object>> exeRankList = exepageService.selectExeRankList(param);

        model.addAttribute("exePageInfo", exePageInfo);
        model.addAttribute("exeCdInfo",exeCdInfo );
        model.addAttribute("exeRankList", exeRankList);*/
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
    @RequestMapping(value = "/back/contents/insertExepage.do")
    public ModelAndView exepageInsert(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        if (param.get("exeId").equals("W")) {
        try{
	       	rv = exepageService.insertExepage(param);

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
    	       	rv = exepageService.updateExepage(param);
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
    @RequestMapping(value = "/back/contents/exepageUpdate.do")
    public ModelAndView updateExepage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	 int rv =0;
         Map<String, Object> param = _req.getParameterMap();

         try{

         	if (param.get("exe_check")!=null) {
         		if (param.get("exe_check").equals("on")) {
 	        		param.put("exe_check", "Y");
 				}
 			}


 	       	rv = exepageService.updateExepage(param);

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
    @RequestMapping(value = "/back/contents/deleteExepage.do")
    public ModelAndView deleteExepage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
       	try{
       		rv = exepageService.deleteExepage(param);

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
    @RequestMapping(value = "/back/contents/exeReorderUpdate.do")
    public ModelAndView updateExepageSort(ExtHtttprequestParam _req, ModelMap mode) throws Exception {

       	int rv = 0;

        Map<String, Object> param = _req.getParameterMap();

       	try{
       		rv = exepageService.updateExepageSort(param);
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", "번호 순서를 조정하였습니다");
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

    @RequestMapping(value = "/back/contents/exerankWrite.do")
	public String exerankpagePreview(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = "/sub"+BACK_PATH + "exerankListPopup";


        return jsp;
	}


    @RequestMapping(value = "/back/contents/exedeptWrite.do")
 	public String exedeptpagePreview(ExtHtttprequestParam _req, ModelMap model) throws Exception {

         String jsp = "/sub"+BACK_PATH + "exedeptListPopup";

         return jsp;
 	}

    @RequestMapping(value = "/back/contents/exeRankInsertpage.do")
	public String exeRankInsertpage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = "/sub"+BACK_PATH + "exerankWritePopup";
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
        Map<String, Object> exeRankInfo = new HashMap<String, Object>();


        if (!param.get("rankId").equals("W")) exeRankInfo = exepageService.selectRank(param);
        else	exeRankInfo.put("rankId", "W");

        model.addAttribute("exeRankInfo",exeRankInfo );
        return jsp;
	}

    @RequestMapping(value = "/back/contents/exeDeptInsertpage.do")
   	public String exeDeptInsertpage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	String jsp = "/sub"+BACK_PATH + "exedeptWritePopup";
           NavigatorInfo navigator = new NavigatorInfo(_req);
           Map<String, Object> param  = navigator.getParam();
           Map<String, Object> exeDeptInfo = new HashMap<String, Object>();


           if (!param.get("dept_id").equals("W")) exeDeptInfo = exepageService.selectDept(param);
           else	exeDeptInfo.put("dept_id", "W");



           model.addAttribute("exeDeptInfo",exeDeptInfo );

           return jsp;
   	}

    @RequestMapping(value = "/back/contents/exeRankList.do")
	public ModelAndView exeRankList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
        navigator.setList(exepageService.selectExeRankList(param));
        return ViewHelper.getJqGridView(navigator);

	}


    @RequestMapping(value = "/back/contents/exeDeptList.do")
  	public ModelAndView exeDeptList(ExtHtttprequestParam _req, ModelMap model) throws Exception {


      	NavigatorInfo navigator = new NavigatorInfo(_req);
          Map<String, Object> param  = navigator.getParam();
          navigator.setList(exepageService.selectExeDeptList(param));
          return ViewHelper.getJqGridView(navigator);

  	}


    @RequestMapping(value = "/back/contents/exeRankInsert.do")
    public ModelAndView exeRankInsert(ExtHtttprequestParam _req, ModelMap mode) throws Exception {

       	int rv = 0;

        Map<String, Object> param = _req.getParameterMap();

        if (param.get("rankId").toString().equals("W")) {
        	try{
           		rv = exepageService.insertExeRank(param);
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
           		rv = exepageService.updateRank(param);
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



    @RequestMapping(value = "/back/contents/exeDeptInsert.do")
    public ModelAndView exeDeptInsert(ExtHtttprequestParam _req, ModelMap mode) throws Exception {

       	int rv = 0;

        Map<String, Object> param = _req.getParameterMap();

        if (param.get("deptId").toString().equals("W")) {
        	try{
           		rv = exepageService.insertExeDept(param);
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
           		rv = exepageService.updateDept(param);
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




    @RequestMapping(value = "/back/contents/exeRankDelete.do")
    public ModelAndView exeRankDelete(ExtHtttprequestParam _req, ModelMap mode) throws Exception {

       	int rv = 0;

        Map<String, Object> param = _req.getParameterMap();


        	try{
           		rv = exepageService.deleteRank(param);
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

    @RequestMapping(value = "/back/contents/exeDeptDelete.do")
    public ModelAndView exeDeptDelete(ExtHtttprequestParam _req, ModelMap mode) throws Exception {

       	int rv = 0;

        Map<String, Object> param = _req.getParameterMap();


        	try{
           		rv = exepageService.deleteDept(param);
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



