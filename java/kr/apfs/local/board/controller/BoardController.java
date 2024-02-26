package kr.apfs.local.board.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.board.service.BoardService;
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
import kr.apfs.local.menu.service.MenuService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;



import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : BoardController.java
 * @Description : BoardController.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2017.02.05           최초생성
 *
 * @author kskim
 * @since 2017. 02.05
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Intocps All right reserved.
 */

@Controller
public class BoardController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(BoardController.class);

	public final static String  BACK_PATH = "/back/board/";

	@Resource(name = "BoardService")
    private BoardService boardService;

	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;

	@Resource(name = "AttachFileService")
    private AttachFileService fileService;

	@Resource(name = "MenuService")
    private MenuService menuService;

	/***************** 게시판 관리 *****************/

	/**
     * 게시판 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/board/boardListPage.do")
	public String boardListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		String jsp = BACK_PATH + "boardListPage";

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		model.addAttribute("defaulttype",_req.getP("defaulttype"));
        return jsp;
	}

	/**
     * 게시판 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/boardPageList.do")
	public ModelAndView boardPageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(boardService.selectBoardPageList(param));

        return ViewHelper.getJqGridView(navigator);
	}

	/**
     * 게시판 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/boardList.do")
	public String boardList(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);

        String jsp = BACK_PATH + "boardListPage";

        Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> list = boardService.selectBoardList(param);
		model.addAttribute("defaulttype",_req.getP("defaulttype"));
		model.addAttribute("boardList", list);
        return jsp;
	}

	/**
     * 게시판 등록, 기본정보 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/boardWrite.do")
	public String boardWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);

    	String jsp = BACK_PATH + "boardWrite";
    	Map<String, Object> param = _req.getParameterMap();
    	Map<String, Object> boardinfo = new HashMap();

    	if(StringUtil.nvl(param.get("mode")).equals("E")){
    		boardinfo = boardService.selectBoardDetail(param);
    	}else{
    		boardinfo.put("boardCd",_req.getP("defaulttype") );
    	}
    	model.addAttribute("defaulttype",_req.getP("defaulttype"));
    	model.addAttribute("boardinfo",boardinfo);
    	model.addAttribute("mode",param.get("mode"));

        return jsp;
	}

	/**
     * 게시판 기본 정보를 저장한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/insertBoard.do")
    public ModelAndView insertBoard(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
        try{
        	rv = boardService.insertBoard(param);
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
     * 항목설정 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/boardItemSet.do")
	public String boardItemSet(ExtHtttprequestParam _req, ModelMap model) throws Exception {
    	String jsp = BACK_PATH + "boardItemSet";
    	Map<String, Object> param = _req.getParameterMap();
    	Map<String, Object> boardinfo = new HashMap();

    	if(StringUtil.nvl(param.get("mode")).equals("E")){
    		boardinfo = boardService.selectBoardDetail(param);
    	}
    	model.addAttribute("defaulttype",_req.getP("defaulttype"));
    	model.addAttribute("boardinfo",boardinfo);

        return jsp;
	}

    /**
     * 목록 뷰설정 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/boardViewSet.do")
	public String boardViewSet(ExtHtttprequestParam _req, ModelMap model) throws Exception {
    	String jsp = BACK_PATH + "boardViewSet";
    	Map<String, Object> param = _req.getParameterMap();
    	Map<String, Object> boardinfo = new HashMap();

    	if(StringUtil.nvl(param.get("mode")).equals("E")){
    		boardinfo = boardService.selectBoardDetail(param);
    	}
    	model.addAttribute("defaulttype",_req.getP("defaulttype"));
    	model.addAttribute("boardinfo",boardinfo);

        return jsp;
	}

	/**
     * 선택된 항목의 detail 값을 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/Board.do")
	public String getBoard(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = BACK_PATH + "boardEdit";

		Map<String, Object> param = _req.getParameterMap();

        model.addAttribute("item", boardService.selectBoard(param));

        return jsp;
	}

	/**
     * 게시판 기본정보를 수정한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/updateBoard.do")
    public ModelAndView updateBoard(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
       	try{
	       	rv = boardService.updateBoard(param);
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
     * 게시판 항목설정를 저장한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/updateBoardItemSet.do")
    public ModelAndView updateBoardItemSet(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
	       	rv = boardService.updateBoardItemSet(param);
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getSavedMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        	logger.error("error===", e);
 			param.put("success", "false"); 													// 실패여부 삽입
 			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
 			return ViewHelper.getJsonView(param);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	logger.error("error===", e);
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
     * 게시판 목록뷰설정를 저장한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/updateBoardViewSet.do")
    public ModelAndView updateBoardViewSet(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
       	try{
	       	rv = boardService.updateBoardViewSet(param);
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getSavedMsg(rv, _req));
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
     * 게시판을 삭제한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/deleteBoard.do")
    public ModelAndView deleteBoard(ExtHtttprequestParam _req, ModelMap model) throws Exception {

       	int rv = 0;
       	int chk = 0;
        Map<String, Object> param = _req.getParameterMap();
       	try{
       		// 삭제하기전 매핑 확인
       		chk = boardService.chkBoardMapp(param);

       		if(chk <= 0){
       			rv = boardService.deleteBoard(param);
       		}

	       	if(rv > 0){
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getDeteleMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				if(chk > 0){
					param.put("message", "메뉴에 매핑된 게시판입니다."); // 실패 메시지
				}else{
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
				}
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

    /***************** 게시판 관리 end *****************/

    /***************** 게시판 카테고리 관리 *****************/

    /**
     * 게시판 카테고리 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/boardCategoryListPage.do")
	public String faqWrite(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = "/sub"+BACK_PATH + "boardCategoryListPage";

        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> category = new HashMap();

        model.addAttribute("category",category);

        return jsp;
	}

    /**
     * 게시판 카테고리 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/boardCategoryList.do")
	public @ResponseBody Map<String, Object> boardCategoryList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> list = boardService.selectBoardCategoryList(param);

		param.put("rows", list);

        return param;
	}

    /**
     * 게시판 카테고리를 저장한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/insertBoardCategory.do")
    public ModelAndView insertBoardCategory(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
        try{
        	//param.put("cate_id", CommonUtil.createUUID());
        	rv = boardService.insertBoardCategory(param);
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
     * 게시판 카테고리를 수정한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/updateBoardCategory.do")
    public ModelAndView updateBoardCategory(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
        try{
        	rv = boardService.updateBoardCategory(param);
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
     * 게시판 카테고리를 삭제한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/deleteBoardCategory.do")
    public ModelAndView deleteBoardCategory(ExtHtttprequestParam _req, ModelMap model) throws Exception {
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
       	try{
       		rv = boardService.deleteBoardCategory(param);
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
     * 게시판 카테고리 상세정보를 가져온다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/selectBoardCategoryDetail.do")
	public ModelAndView selectBoardCategoryDetail(ExtHtttprequestParam _req, ModelMap model) throws Exception {
		Map<String, Object> param = _req.getParameterMap();
       // model.addAttribute("data", boardService.selectBoardCategoryDetail(param));
		param.put("data", boardService.selectBoardCategoryDetail(param));

        return ViewHelper.getJsonView(param);
	}

    /***************** 게시판 카테고리 관리 end *****************/

    /***************** 게시물 관리 *****************/

    /**
     * 게시물 관리 페이지 이동
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/boardContentsListPage.do")
	public String boardContentsListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        String jsp = BACK_PATH + "boardContentsListPage";

        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> boardinfo = new HashMap();
        List<Map<String, Object>> category = null;

        List<Map<String, Object>> menuBoardList = null;

		List<Map<String, Object>> list = boardService.selectBoardList(param);
		model.addAttribute("boardList", list); // 게시판리스트

		//추가코딩(게시판글 리스트)
		//--------------------------------------------------------------------------------------------
     	String gubun = "";
     	gubun = (_req.getP("gubun")==""||_req.getP("gubun")==null) ? "" : _req.getP("gubun");
        if(StringUtil.nvl(param.get("boardId")).equals("") && gubun.equals("M")){
        	menuBoardList = menuService.selectBoardMenuList(param);

        	for (int i = 0; i < menuBoardList.size(); i++) {
        		if( menuBoardList.get(i).get("refBoardId")!=null ){
        			param.put("boardId", menuBoardList.get(i).get("refBoardId"));
        			model.addAttribute("defaultBoardId", menuBoardList.get(i).get("refBoardId"));
        			break;
        		}
			}
        	//param.put("boardId", menuBoardList.get(1).get("refBoardId"));
        	//model.addAttribute("defaultBoardId", menuBoardList.get(1).get("refBoardId"));
		}
        //--------------------------------------------------------------------------------------------

		if(!StringUtil.nvl(param.get("boardId")).equals("")){
    		boardinfo = boardService.selectBoardDetail(param);

    		//카테고리 여부확인후
    		if(StringUtil.nvl(boardinfo.get("cateYn")).equals("Y")){
    			//카테고리 리스트 가져오기
        		category = boardService.selectBoardCategoryList(param);
    		}
        	model.addAttribute("boardinfo", boardinfo);
        	model.addAttribute("category", category);
    	}
		model.addAttribute("gubun", param.get("gubun"));
        return jsp;
	}

    /**
     * 게시물 리스트
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/selectBoardContentsPageList.do")
	public ModelAndView selectBoardContentsPageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
        param.put("backyn", "B"); // 관리자단
        
        if(param.containsKey("notiYn"))
        	if(param.get("notiYn").equals("Y"))
        		param.put("delYn", "N");
        	

        String boardCd = _req.getP("defaulttype");
        if(boardCd.equals("P")||boardCd.equals("R")||boardCd.equals("I")){
        //if(boardCd.equals("P")){
        	navigator.setList(boardService.selectBoardContentsPageListEtc(param));
        }else{
        	navigator.setList(boardService.selectBoardContentsPageList(param));
        }
        return ViewHelper.getJqGridView(navigator);
	}

    /**
     * 게시물 등록 페이지 이동
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/boardContentsWrite.do")
	public String boardContentsWrite(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = BACK_PATH + "boardContentsWrite";

		Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> boardinfo = new HashMap();
		List<Map<String, Object>> category = null;
		Map<String, Object> contentsinfo = new HashMap();

		List<Map<String, Object>> fileList = null;

		boardinfo = boardService.selectBoardDetail(param);
		String boardCd = boardinfo.get("boardCd").toString();

		if(!"W".equals(param.get("mode"))){

			/*contentsinfo = boardService.selectContentsDetail(param);*/
			if(boardCd.equals("P") || boardCd.equals("R") || boardCd.equals("I")){
				contentsinfo = boardService.selectContentsDetailEtc(param);		// 선택된 글에 정보
			}else{
				contentsinfo = boardService.selectContentsDetail(param);		// 선택된 글에 정보
			}
		}

		if (contentsinfo != null && contentsinfo.get("contents")!=null){
			contentsinfo.put("contents", contentsinfo.get("contents").toString().replaceAll("\'", "\\&#39;"));
		}

		// mode = A(답변쓰기) 일 경우 답변글에 attachIdAnswer를 가져 간다.
		if ("A".equals(param.get("mode"))){
			if(contentsinfo.get("attachIdAnswer") == null){
				param.put("attachId", "0"); // 그룹아이디가 없는경우 전체를 가져오기 방지
			}else{
				param.put("attachId", contentsinfo.get("attachIdAnswer").toString());
			}
		}else {

			if(!contentsinfo.containsKey("attachId")){
				param.put("attachId", "0"); // 그룹아이디가 없는경우 전체를 가져오기 방지
			}else{				
				param.put("attachId", contentsinfo.get("attachId").toString());
			}
		}

		//fileList = fileService.selectFileList(param);
		fileList = commonFileService.getCommonFileList(param);		// attachId만 넘겨줘야함

		//카테고리 여부확인후
		if(StringUtil.nvl(boardinfo.get("cateYn")).equals("Y")){
			//카테고리 리스트 가져오기
			category = boardService.selectBoardCategoryList(param);
		}
		
		String str="";
		String tempStr="";
		String[] tempStrArr;
		
		if(param.get("boardId").equals("20083")){
			
			contentsinfo.put("etc12",contentsinfo.get("etc18").toString().replace("1", "농업"));
			contentsinfo.put("etc12",contentsinfo.get("etc12").toString().replace("2", "임산"));
			contentsinfo.put("etc12",contentsinfo.get("etc12").toString().replace("3", "축산"));
			contentsinfo.put("etc12",contentsinfo.get("etc12").toString().replace("4", "식품제조가공"));
			contentsinfo.put("etc12",contentsinfo.get("etc12").toString().replace("5", "유통"));
			contentsinfo.put("etc12",contentsinfo.get("etc12").toString().replace("6", "기타 연관산업"));
			
			contentsinfo.put("etc17",contentsinfo.get("etc19").toString().replace("1", "후원형"));
			contentsinfo.put("etc17",contentsinfo.get("etc17").toString().replace("2", "증권형"));
			/*
			if(contentsinfo.get("etc18") != null){
				str = contentsinfo.get("etc18").toString();
				tempStrArr = str.split(","); 
				for(int i=0 ; i<tempStrArr.length ; i++)
					if(str.length() == 0){
						if(tempStrArr[i].equals("1")){
							tempStr = "농업";
						}else if(tempStrArr[i].equals("2")){
							tempStr = "임산";
						}else if(tempStrArr[i].equals("3")){
							tempStr = "축산";
						}else if(tempStrArr[i].equals("4")){
							tempStr = "식품제조가공";
						}else if(tempStrArr[i].equals("5")){
							tempStr = "유통";
						}else{
							tempStr = "기타 연관산업";
						}
					}else{
						if(tempStrArr[i].equals("1")){
							tempStr = tempStr+", 농업";
						}else if(tempStrArr[i].equals("2")){
							tempStr = tempStr+", 임산";
						}else if(tempStrArr[i].equals("3")){
							tempStr = tempStr+", 축산";
						}else if(tempStrArr[i].equals("4")){
							tempStr = tempStr+", 식품제조가공";
						}else if(tempStrArr[i].equals("5")){
							tempStr = tempStr+", 유통";
						}else{
							tempStr = tempStr+", 기타 연관산업";
						}
					}
				}
				contentsinfo.put("etc12", tempStr);
			
			str="";
			tempStr="";
			if(contentsinfo.get("etc19") != null){
				str = contentsinfo.get("etc19").toString();
				tempStrArr = str.split(","); 
				for(int i=0 ; i<tempStrArr.length ; i++){
					if(str.length() == 0){
						if(tempStrArr[i].equals("1")){
							tempStr = "후원형";
						}else{
							tempStr = "증권형";
						}
					}else{
						if(tempStrArr[i].equals("1")){
							tempStr = tempStr+", 후원형";
						}else{
							tempStr = tempStr+", 증권형";
						}
					}
				}
				contentsinfo.put("etc17", tempStr);
			}
			*/
		}
		model.addAttribute("reg_mem_nm", param.get("s_user_name"));
    	model.addAttribute("boardinfo", boardinfo);
    	model.addAttribute("category", category);
    	model.addAttribute("contentsinfo", contentsinfo);
    	model.addAttribute("fileList", fileList);
    	//
    	//model.addAttribute("param", param);

        return jsp;
	}

    /**
     * 게시물 등록한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/insertBoardContents.do")
    public ModelAndView insertBoardContents(ExtHtttprequestParam _req, ModelMap mode) throws Exception {

        int rv =0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
        String boardCd =  _req.getP("boardCd");
        List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("/board/"));
        FileUploadModel file = null;
        String attachId = "";
        
      //단건처리용 파라메터 맵 생성   fileVo 제거 중
		Map<String, Object> fileParam = new HashMap<String, Object>();	
		

		if(fileList != null && fileList.size()>0){
			attachId = param.get("attachId")==null?CommonUtil.createUUID():param.get("attachId").toString();
			
			
			for (int i = 0; i < fileList.size(); i++) {
				
				file = (FileUploadModel)fileList.get(i);		   
				fileParam.put("attachId", attachId);		   
				fileParam.put("fileNm", file.getFileName());
				fileParam.put("originFileNm", file.getOriginalFileName());
				fileParam.put("fileType", file.getExtension());
				fileParam.put("fileSize", file.getFileSize());
				fileParam.put("filePath", "/file/board/");
				fileParam.put("*userId", param.get("*userId"));
		   	   	commonFileService.insertCommonFile(fileParam);
			}
			param.put("attachId",attachId);
				   	   	
		}

        
        

        try{
        	param.put("restepSeq", 0);
        	param.put("relevelSeq", 0);
        	if (boardCd.equals("P")||boardCd.equals("R")||boardCd.equals("I")){
        		rv = boardService.insertBoardContentsEtc(param);
        	}else{
        		rv = boardService.insertBoardContents(param);
        	}

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
     * 답글을 등록한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/insertBoardContentsReply.do")
    public ModelAndView insertBoardContentsReply(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();

        try{
        	boardService.updateBoardContentsReorder(param);
        	param.put("noti_yn", "N");
        	param.put("restep_seq", StringUtil.nvl(param.get("restep_seq"),0)+1);
            param.put("relevel_seq", StringUtil.nvl(param.get("relevel_seq"),0)+1);

        	rv = boardService.insertBoardContents(param);

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
     * 게시물 수정한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/updateBoardContents.do")
    public ModelAndView updateBoardContents(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
        String boardCd =  _req.getP("boardCd");
        String attachId = "";

        try{
   
    		if (boardCd.equals("P")||boardCd.equals("R")||boardCd.equals("I")){

    	        List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("/board/"));
    	        FileUploadModel file = null;
    			
    			Map<String, Object> fileParam = new HashMap<String, Object>();

    			if(fileList != null && fileList.size()>0){
    				attachId = param.get("attachId")==null?CommonUtil.createUUID():param.get("attachId").toString();
    				
    				
    				for (int i = 0; i < fileList.size(); i++) {
    					
    					file = (FileUploadModel)fileList.get(i);		   
    					fileParam.put("attachId", attachId);		   
    					fileParam.put("fileNm", file.getFileName());
    					fileParam.put("originFileNm", file.getOriginalFileName());
    					fileParam.put("fileType", file.getExtension());
    					fileParam.put("fileSize", file.getFileSize());
    					fileParam.put("filePath", "/file/board/");
    					fileParam.put("*userId", param.get("*userId"));
    			   	   	commonFileService.insertCommonFile(fileParam);
    				}
    				param.put("attachId",attachId);
    					   	   	
    			}
    			
    			rv = boardService.updateBoardContentsEtc(param);
    		}else{
    			
    	        List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("/board/"));
    	        FileUploadModel file = null;
    	        
    	      //단건처리용 파라메터 맵 생성   fileVo 제거 중
    			Map<String, Object> fileParam = new HashMap<String, Object>();
    			
    			if(fileList != null && fileList.size()>0){
    				attachId = param.get("attachId")==null?CommonUtil.createUUID():param.get("attachId").toString();
    				
    				
    				for (int i = 0; i < fileList.size(); i++) {
    					
    					file = (FileUploadModel)fileList.get(i);		   
    					fileParam.put("attachId", attachId);		   
    					fileParam.put("fileNm", file.getFileName());
    					fileParam.put("originFileNm", file.getOriginalFileName());
    					fileParam.put("fileType", file.getExtension());
    					fileParam.put("fileSize", file.getFileSize());
    					fileParam.put("filePath", "/file/board/");
    					fileParam.put("*userId", param.get("*userId"));
    			   	   	commonFileService.insertCommonFile(fileParam);
    				}
    				param.put("attachId",attachId);
    					   	   	
    			}
    			
    			rv = boardService.updateBoardContents(param);
    		}

	       	if(rv > 0){																	// 저장한다s
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
     * 게시물을 삭제한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/deleteBoardContents.do")
    public ModelAndView deleteBoardContents(ExtHtttprequestParam _req, ModelMap model) throws Exception {
       	int rv = 0;
       	int chk = 0;
        Map<String, Object> param = _req.getParameterMap();
        String boardCd =  _req.getP("boardCd");
        String deleteMsg =  _req.getP("delYn").equals("N") ? "건이 복원되었습니다." : "건이 삭제되었습니다.";

       	try{
       		if(boardCd.equals("P")||boardCd.equals("R")||boardCd.equals("I")){
       			// 상품홍보,유관기관,국제무역추천사이트 게시판 여부 확인
       			rv = boardService.deleteBoardContentsEtc(param);
       		}else{
       			// 삭제하기전 자식글이 있는지 확인
	       		chk  = boardService.chkBoardChildContents(param);
	       		if(chk <= 0){
	       			rv = boardService.deleteBoardContents(param);
	       		}
       		}

	       	if(rv > 0){
				param.put("success", "true" );
	        	//param.put("message", MessageUtil.getDeteleMsg(rv, _req));
				param.put("message", rv+deleteMsg);
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				if(chk > 0){
					param.put("message", "답글이 있으면 삭제할 수 없습니다."); // 실패 메시지
				}else{
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
				}
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
     * 게시물 타입별 리스트
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/boardContentsList.do")
	public String boardContentsList(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		String jsp = "/sub"+BACK_PATH;

		NavigatorInfo navigator = new NavigatorInfo(_req);
		//Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> param  = navigator.getParam();
		Map<String, Object> boardinfo = new HashMap();
		Map<String, Object> temp = null;
		List<Map<String, Object>> itemList = null;
		List<Map<String, Object>> viewSortList = null;
		List<Map<String, Object>> boardlist = null;

		boardinfo = boardService.selectBoardDetail(param);

		if("W".equals(boardinfo.get("boardCd"))){  // 요약형 (포토뉴스(리스트))
			jsp +=  "boardContentsSmyList";
			param.put("sidx", "cont_id DESC, noti_seq DESC, restep_seq");
			param.put("sord", "asc");
			navigator.setList(boardService.selectBoardContentsPageList(param));
			model.addAttribute("boardList", navigator.getList());
			model.addAttribute("boardPagging", navigator.getPagging());
			model.addAttribute("totalcnt", navigator.getTotalCnt());
		}else if("A".equals(boardinfo.get("boardCd"))){ // 앨범형 (포토뉴스(갤러리))
			jsp +=  "boardContentsImgList";
			param.put("sidx", "cont_id DESC, noti_seq DESC, restep_seq");
			param.put("sord", "asc");
			navigator.setList(boardService.selectBoardContentsPageList(param));
			model.addAttribute("boardList", navigator.getList());
			model.addAttribute("boardPagging", navigator.getPagging());
			model.addAttribute("totalcnt", navigator.getTotalCnt());
		}else{ // 일반형, QnA형
			// 조회일 경우에만 페이지를 1페이지로 보냄
			if(param.get("searchYn").equals("Y")){
				listOp.remove("miv_pageNo");
				listOp.setDef("miv_pageNo", "1");
				model.addAttribute("searchYn", "N");
			}else{
				model.addAttribute("searchYn", "N");
			}
			model.addAttribute(ListOp.LIST_OP_NAME, listOp);
			jsp +=  "boardContentsList"; // 목록형, Qna형
			model.addAttribute("boardlist", boardlist);
		}

		// 게시판 뷰설정목록 리스트
		//itemList = boardService.selectBoardItemList(param);
		viewSortList = boardService.selectBoardViewSortList(param);

		model.addAttribute("viewSortList", viewSortList);
    	model.addAttribute("boardinfo", boardinfo);

        return jsp;
	}

    /**
     * 게시물 뷰 페이지로 이동
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/boardContentsView.do")
	public String boardContentsView(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);

		String jsp = BACK_PATH + "boardContentsView";
		String boardCd = _req.getP("defaulttype");

		Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> boardinfo = new HashMap();
		Map<String, Object> contentsinfo = new HashMap();
		Map<String, Object> prenext = new HashMap();

		boardinfo = boardService.selectBoardDetail(param);				// 선택된 글에 게시판 정보

		if(boardCd.equals("P") || boardCd.equals("R") || boardCd.equals("I")){
			contentsinfo = boardService.selectContentsDetailEtc(param);		// 선택된 글에 정보
			prenext = boardService.selectPreNextContentsEtc(param); // 이전글 다음글을 가져온다.
			//boardService.updateBoardContentsHits(param); // 조회수를 증가(관리자 페이지에서는 조회수를 증가시키지 않음)
		}else{
			contentsinfo = boardService.selectContentsDetail(param);		// 선택된 글에 정보
			prenext = boardService.selectPreNextContents(param); // 이전글 다음글을 가져온다.
			//boardService.updateBoardContentsHits(param); // 조회수를 증가(관리자 페이지에서는 조회수를 증가시키지 않음)
		}

		if(contentsinfo.get("attachId") == null){
			param.put("attachId", "A"); // 그룹아이디가 없는경우 전체를 가져오기 방지
		}else{
			param.put("attachId", contentsinfo.get("attachId"));
		}

		List<Map<String, Object>> fileList = commonFileService.getCommonFileList(param);		// attachId만 넘겨줘야함

		model.addAttribute("reg_mem_nm", param.get("s_user_name"));
    	model.addAttribute("boardinfo", boardinfo);
    	model.addAttribute("contentsinfo", contentsinfo);
    	model.addAttribute("prenext", prenext);
    	model.addAttribute("fileList", fileList);

        return jsp;
	}

    /**
     * 답변을 저장한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/saveBoardContentsAnswer.do")
    public ModelAndView saveBoardContentsAnswer(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
        try{
    		param.put("contentsTxt", param.get("contentsTxt"));
	       	rv = boardService.saveBoardContentsAnswer(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getSavedMsg(rv, _req));
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



    /***************** 게시물 관리 end *****************/

    /***************** 댓글 *****************/

    /**
     * 댓글을 저장한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/saveComment.do")
    public ModelAndView saveComment(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{
        	if("E".equals(param.get("mode"))){
        		rv = boardService.updateComment(param);
        	}else if("R".equals(param.get("mode"))){
        		param.put("comment_id", CommonUtil.createUUID());
        		boardService.updateCommentReorder(param);
            	param.put("sort", StringUtil.nvl(param.get("sort"),0)+1);
        		rv = boardService.saveComment(param);
        	}else{
        		param.put("comment_id", CommonUtil.createUUID());
    	       	rv = boardService.saveComment(param);
        	}

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getSavedMsg(rv, _req));
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
     * 댓글을 삭제한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/deleteComment.do")
    public ModelAndView deleteComment(ExtHtttprequestParam _req, ModelMap model) throws Exception {
       	int rv = 0;
       	int chk = 0;
        Map<String, Object> param = _req.getParameterMap();
       	try{
       		rv = boardService.deleteComment(param);
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
     * 댓글 리스트 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/boardCommentList.do")
	public String boardCommentList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
        String jsp = "/sub"+BACK_PATH + "boardCommentList";
        Map<String, Object> param = _req.getParameterMap();
		List<Map<String, Object>> list = boardService.selectBoardCommentList(param);
		model.addAttribute("commentList", list);

        return jsp;
	}

    /***************** 댓글 end *****************/

    /***************** 만족도  *****************/

    /**
     * 만족도를 저장한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/saveSatisfy.do")
    public ModelAndView saveSatisfy(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{
        	//param.put("satisfy_id", CommonUtil.createUUID());
	       	rv = boardService.saveSatisfy(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
	        	param.put("message", MessageUtil.getSavedMsg(rv, _req));
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

    /***************** 만족도 end *****************/

    /***************** 추천  *****************/

    /**
     * 게시물 추천수를 가져온다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/loadRecommend.do")
    public ModelAndView loadRecommend(ExtHtttprequestParam _req, ModelMap model) throws Exception {
       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> recommendinfo = new HashMap();
        int total_cnt = 0;
        String recommend_yn = "N";

        recommendinfo = boardService.selectRecommend(param);
        if(recommendinfo != null){
        	total_cnt = ((BigDecimal) recommendinfo.get("total_cnt")).intValue();
        	recommend_yn = (String) recommendinfo.get("recommend_yn");
        }

        param.put("recommend_cnt", total_cnt);
        param.put("recommend_yn", recommend_yn);

        return ViewHelper.getJsonView(param);
    }

	/**
     * 추천하기, 추천취소하기
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/saveRecommend.do")
    public ModelAndView saveRecommend(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();

        try{
        	if("Y".equals(param.get("recommend_yn"))){
        		param.put("recommend_yn", "N");
        		param.put("message", "취소하였습니다.");
        	}else{
        		param.put("recommend_yn", "Y");
        		param.put("message", "추천하였습니다.");
        	}

	       	rv = boardService.saveRecommend(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );
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

    /***************** 추천 end *****************/


	/**
     * 게시판 팝업 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/board/boardSearchPopup.do")
	public String boardSearchPopup(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = "/sub"+BACK_PATH + "boardListPopup";

        return jsp;
	}

	/**
     * 게시판 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/boardSearchList.do")
	public @ResponseBody Map<String, Object> boardSearchList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> list = boardService.selectBoardList(param);
		param.put("rows", list);

		return param;
	}

    @RequestMapping(value = "/back/board/menuBoardhList.do")
   	public @ResponseBody Map<String, Object> menuBoardhList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();
   		List<Map<String, Object>> list = boardService.selectMenuBoardList(param);
   		param.put("rows", list);

   		return param;
   	}

    /**
     * 게시물 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/board/boardContentsListReorder.do")
	public String menuSearchPopup(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = "/sub"+BACK_PATH + "boardContentsListReorder";
        return jsp;
	}

	/**
	 * 게시물 순서를 재조정해준다.(상단공지전용)
	 * @param _req
	 *
	 *
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/board/updateBoardContentsReorderNoti.do")
	public ModelAndView updateMenuReorder(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		   	int rv = 0;
		    Map<String, Object> param = _req.getParameterMap();

	        List<Map<String, Object>> list = (ArrayList<Map<String ,Object>>)JsonUtil.fromJsonStr(param.get("sort_list").toString().replace("&quot;","'"));
		    param.put("sort_list", list);
		   	try{
		   		rv = boardService.updateBoardContentsReorderNoti(param);

		       	if(rv > 0){																	// 저장한다
					param.put("success", "true" );
		        	param.put("message", "공지 순서를 조정하였습니다.");
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
     * 게시판 팝업 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/board/korchamBoardSearchPopup.do")
	public String korchamSearchPopup(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = "/sub"+BACK_PATH + "korchamBoardListPopup";

        return jsp;
	}

	/**
     * 게시판 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/korchamBoardSearchList.do")
	public @ResponseBody Map<String, Object> korchamSearchList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> list = boardService.seleckorchamTBoardList(param);
		param.put("rows", list);

		return param;
	}
    
    /**
     * 게시판 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/board/selectDownloadExcelBoardList.do")
    public ModelAndView selectDownloadExcelBoardList(ExtHtttprequestParam _req, ModelMap model) throws Exception {
    	
    	NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();

    	List <Map<String, Object>> list = new ArrayList<Map<String, Object>>();
    	List <Map<String, Object>> result = boardService.selectDownloadExcelBoardList(param);
    	
    	for (Map<String, Object> map : result) {
			list.add(map);
		} 
		       	
    	navigator.setList(list);
	        	

        return ViewHelper.getJqGridView(navigator);
    	
    	
    }


}
