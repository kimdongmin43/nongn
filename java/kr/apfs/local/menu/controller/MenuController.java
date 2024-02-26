package kr.apfs.local.menu.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.board.service.BoardService;
import kr.apfs.local.common.fileupload.model.CommonFileVO;
import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.JsonUtil;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.util.fileupload.FileUploadModel;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.menu.service.MenuService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : MenuController.java
 * @Description : MenuController.Class
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
public class MenuController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(MenuController.class);

	public final static String  FRONT_PATH = "/front/menu/";
	public final static String  BACK_PATH = "/back/menu/";

	@Resource(name = "MenuService")
    private MenuService menuService;

	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;

	@Resource(name = "BoardService")
    private BoardService boardService;

	/**
     * 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/menu/menuListPage.do")
	public String menuListPage(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = BACK_PATH + "menuListPage";
		Map<String, Object> param = _req.getParameterMap();
        return jsp;
	}

	/**
	 * 메뉴 트리 리스트
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/menu/menuTreeList.do")
	public @ResponseBody List<Map<String, Object>> itemTreeList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	    Map<String, Object> param = _req.getParameterMap();
		List<Map<String, Object>> list = menuService.selectMenuTreeList(param);
		return list;
	}

	/**
     * 메뉴 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/menu/menuList.do")
	public @ResponseBody Map<String, Object> menuList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> list = menuService.selectMenuList(param);
		param.put("rows", list);

		return param;
	}

    /**
     * 메뉴 정보를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/menu/menu.do")
	public @ResponseBody Map<String, Object> menu(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

		Map<String, Object> menu = menuService.selectMenu(param);
		param.put("menu", menu);

		return param;
	}

	/**
     * 메뉴 쓰기 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/menu/menuWrite.do")
	public String menuWrite(ExtHtttprequestParam _req, ModelMap model) throws Exception {

    	String jsp = "/sub"+BACK_PATH + "menuWrite";

        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> menu = menuService.selectMenu(param);

        model.addAttribute("menu",menu);

        return jsp;
	}

	/**
     * 메뉴 데이타를 저장한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/menu/insertMenu.do")
    public ModelAndView insertMenu(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
        
        

        //System.out.println("########################################################");
        //System.out.println(param);

        //System.out.println("########################################################");
    	try{

        	rv = menuService.insertMenu(param);

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
     * 메뉴 데이타를 수정한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/menu/updateMenu.do")
    public ModelAndView updateMenu(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
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
   	   	       //commonFileService.insertCommonFile(commonFileVO);
               param.put("image",commonFileVO.getFile_id());
    		}
	       	rv = menuService.updateMenu(param);

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
     * 메뉴 데이타를 삭제한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/menu/deleteMenu.do")
    public ModelAndView deleteMenu(ExtHtttprequestParam _req, ModelMap model) throws Exception {

       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
       		rv = menuService.deleteMenu(param);
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
	 * 코드 순서를 재조정해준다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/menu/updateMenuReorder.do")
	public ModelAndView updateMenuReorder(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		   	int rv = 0;
		    Map<String, Object> param = _req.getParameterMap();

	        List<Map<String, Object>> list = (ArrayList<Map<String ,Object>>)JsonUtil.fromJsonStr(param.get("menuList").toString().replace("&quot;","'"));
		    param.put("menuList", list);
		    //System.out.println("어디서일어남?");

		   	try{
		   		rv = menuService.updateMenuReorder(param);

		       	if(rv > 0){																	// 저장한다
					param.put("success", "true" );
		        	param.put("message", "메뉴 순서를 조정하였습니다.");
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
		 * 메뉴 트리 리스트
		 * @param _req
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/back/menu/managerMenuTreeList.do")
		public @ResponseBody List<Map<String, Object>> managerMenuTreeList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		    Map<String, Object> param = _req.getParameterMap();

			List<Map<String, Object>> list = menuService.selectManagerMenuTreeList(param);

			Map<String, Object> data = null;
			Map<String, Object> normal = new HashMap();
			normal.put("selected", false);
			Map<String, Object> checked = new HashMap();
			checked.put("selected", true);
	        if(list != null && list.size() > 0)
				for(int i =0; i < list.size();i++ ){
	            	  data = (Map<String, Object>)list.get(i);
	            	  if(data.get("auth_yn").equals("Y"))
	            		  data.put("state", checked);
	            	  else
	            		  data.put("state", normal);
	            }

			return list;
	  }

	/**
	 * 권한에 메뉴를 매핑을 해준다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/auth/insertAuthMenu.do")
	public ModelAndView insertAuthMenu(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	   	int rv = 0;
	    Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = (ArrayList<Map<String ,Object>>)JsonUtil.fromJsonStr(param.get("menuList").toString().replace("&quot;","'"));
	    param.put("menuList", list);
	   	try{
	   		rv = menuService.insertAuthMenu(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", "권한에 메뉴를 매핑하는데 성공하였습니다.");
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", "권한에 메뉴를 매핑하는데 실패하였습니다."); // 실패 메시지
			}
	    }catch (IOException e) {
        	logger.error("IOException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", "권한에 메뉴를 매핑하는데 실패하였습니다."); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	param.put("success", "false"); 													// 실패여부 삽입
			param.put("message", "권한에 메뉴를 매핑하는데 실패하였습니다."); 				// 실패 메시지
			return ViewHelper.getJsonView(param);
        }catch(Exception e){
	    	//e.printStackTrace();
	    	logger.error("error===", e);
				param.put("success", "false"); 													// 실패여부 삽입
				param.put("message", "권한에 메뉴를 매핑하는데 실패하였습니다."); 				// 실패 메시지
				return ViewHelper.getJsonView(param);
			}

	    return ViewHelper.getJsonView(param);
	}

	/**
     * 관리자 권한별 메뉴리스트를 가져온다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/menu/authMenuList.do")
	public @ResponseBody Map<String, Object> authMenuList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> topMenuList = menuService.selectAuthTopMenuList(param);
		param.put("topMenuList", topMenuList);
		List<Map<String, Object>> subMenuList = null;
		List<Map<String, Object>> boardList = null;
		List<Map<String, Object>> notBoardList = null;

		//-------------------------------------------------------
		// 추가코딩(게시판글 리스트)
		String gubun = "";
		gubun = (_req.getP("gubun")==""||_req.getP("gubun")==null) ? "" : _req.getP("gubun");

		if(gubun.equals("M")){
			boardList = menuService.selectBoardMenuList(param);
			notBoardList = menuService.selectNotBoardMenuList(param);
		}
		param.put("gubun", gubun);
		param.put("boardList", boardList);
		param.put("notBoardList", notBoardList);
		//-------------------------------------------------------


		if(!StringUtil.nvl(param.get("topMenuId")).equals(""))
			subMenuList = menuService.selectAuthSubMenuList(param);
		else
			if(!StringUtil.nvl(param.get("upMenuId")).equals(""))
				subMenuList = menuService.selectAuthSubMenuList(param);
			else
				subMenuList = new ArrayList();
		param.put("subMenuList", subMenuList);


		return param;
	}

	/**
     * 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/menu/menuSearchPopup.do")
	public String menuSearchPopup(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = "/sub"+BACK_PATH + "menuListPopup";

        return jsp;
	}

	/**
     * 메뉴 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/menu/menuSearchList.do")
	public @ResponseBody Map<String, Object> menuSearchList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> list = menuService.selectMenuSearchList(param);
		param.put("rows", list);

		return param;
	}






}
