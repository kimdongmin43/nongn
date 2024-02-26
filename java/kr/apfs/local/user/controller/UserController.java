package kr.apfs.local.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.apfs.local.common.fileupload.service.CommonFileService;
import kr.apfs.local.common.model.ListOp;
import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.CryptoUtil;
import kr.apfs.local.common.util.DateUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.SmsSend;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.web.ComAbstractController;
import kr.apfs.local.common.web.view.ViewHelper;
import kr.apfs.local.site.vo.SiteVO;
import kr.apfs.local.user.model.UserVO;
import kr.apfs.local.user.service.UserService;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author P068995
 *
 */
@Controller
public class UserController extends ComAbstractController{
	private static final Logger logger = LogManager.getLogger(UserController.class);

	public final static String  BACK_PATH = "/back/user/";

	@Resource(name = "UserService")
    private UserService userService;

	@Resource(name = "CommonFileService")
    private CommonFileService commonFileService;

	/**
     * 회원 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/user/userListPage.do")
	public String userListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		String jsp = BACK_PATH + "userListPage";

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

        return jsp;
	}

	/**
     * 회원 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/user/userPageList.do")
	public ModelAndView userPageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
        String searchKey = StringUtil.nvl(param.get("searchKey"));
        String searchTxt = StringUtil.nvl(param.get("searchTxt"));
        
        if((searchKey.equals("user_mobile")||searchKey.equals("user_email"))&&!searchTxt.equals("")){
        	param.put("searchTxt", CryptoUtil.AES_Encode(searchTxt));
        }

        List<Map<String, Object>> list = userService.selectUserPageList(param);
        Map<String, Object> user = null;
        if(list != null && list.size() > 0)
        	for(int i =0;i < list.size();i++){
        		user = list.get(i);
        		user.put("mobile", CryptoUtil.AES_Decode(StringUtil.nvl(user.get("mobile"))));
        		user.put("email", CryptoUtil.AES_Decode(StringUtil.nvl(user.get("email"))));
        	}
		navigator.setList(list);

        return ViewHelper.getJqGridView(navigator);
	}

	/**
     * 관리자 리스트 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/user/managerListPage.do")
	public String managerListPage(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		String jsp = BACK_PATH + "managerListPage";
		Map<String, Object> param = _req.getParameterMap();
		List<Map<String, Object>> authList = userService.selectAuthList(param);

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		model.addAttribute("authList", authList);

        return jsp;
	}

	/**
     * 관리자 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/user/managerPageList.do")
	public ModelAndView managerPageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
        List<Map<String, Object>> list = userService.selectUserPageList(param);
        Map<String, Object> user = null;
        if(list != null && list.size() > 0)
        	for(int i =0;i < list.size();i++){
        		user = list.get(i);
        		user.put("mobile", CryptoUtil.AES_Decode(StringUtil.nvl(user.get("mobile"))));
        		user.put("email", CryptoUtil.AES_Decode(StringUtil.nvl(user.get("email"))));
        	}
		navigator.setList(list);

        return ViewHelper.getJqGridView(navigator);
	}

	/**
     * 회원 검색리스트 페이지로딩후 grid 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/user/userSearchPageList.do")
	public ModelAndView userSearchPageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(userService.selectUserSearchPageList(param));

        return ViewHelper.getJqGridView(navigator);
	}

	/**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/user/userList.do")
	public String userList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

        String jsp = BACK_PATH + "userListPage";

        Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> list = userService.selectUserList(param);
		model.addAttribute("itemList", list);

        return jsp;
	}

	/**
     * 회원 쓰기 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/user/userWrite.do")
	public String userWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        String jsp = BACK_PATH + "userWrite";

        Map<String, Object> param = _req.getParameterMap();
        if(!StringUtil.nvl(param.get("mode")).equals("W")){
        	 // 사용자 정보를 가져온다.
        	 UserVO user = userService.selectUserId(param);
             String userMobile = StringUtil.nvl(user.getMobile());
             if(!userMobile.equals("")){
            	 String[] mobile = StringUtil.split(userMobile,"-");
            	 user.setMobile_1(mobile[0]);
            	 user.setMobile_2(mobile[1]);
            	 user.setMobile_3(mobile[2]);
             }
             String userTel = StringUtil.nvl(user.getTel());
             if(!userTel.equals("")){
            	 String[] tel = StringUtil.split(userTel,"-");
            	 user.setTel_1(tel[0]);
            	 user.setTel_2(tel[1]);
            	 user.setTel_3(tel[2]);
             }
             String userEmail = StringUtil.nvl(user.getEmail());
             if(!userEmail.equals("")){
            	 String[] email = StringUtil.split(userEmail,"@");
            	 user.setEmail_1(email[0]);
            	 user.setEmail_2(email[1]);
             }
             model.addAttribute("user",user);
        }


        return jsp;
	}

	/**
     * 관리자 쓰기 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/user/managerWrite.do")
	public String managerWrite(ExtHtttprequestParam _req, ListOp listOp, ModelMap model) throws Exception {

    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);

        String jsp = BACK_PATH + "managerWrite";

        Map<String, Object> param = _req.getParameterMap();

        if(!StringUtil.nvl(param.get("mode")).equals("W")){
        	// 사용자 정보를 가져온다.
        	UserVO user = userService.selectUserId(param);
    		if(user.getMobile() != null){
    			user.setMobile(CryptoUtil.AES_Decode(StringUtil.nvl( user.getMobile())));
    		}
    		if(user.getEmail() != null){
    			user.setEmail(CryptoUtil.AES_Decode(StringUtil.nvl( user.getEmail())));
    		}
    		if(user.getTel() != null){
    			user.setTel(CryptoUtil.AES_Decode(StringUtil.nvl( user.getTel())));
    		}
            String userMobile = StringUtil.nvl(user.getMobile());
            if(!userMobile.equals("")){
	           	 String[] mobile = StringUtil.split(userMobile,"-");
	           	 user.setMobile_1(mobile[0]);
	           	 user.setMobile_2(mobile[1]);
	           	 user.setMobile_3(mobile[2]);
            }
            String userTel = StringUtil.nvl(user.getTel());
            if(!userTel.equals("")){
	           	 String[] tel = StringUtil.split(userTel,"-");
	           	 user.setTel_1(tel[0]);
	           	 user.setTel_2(tel[1]);
	           	 user.setTel_3(tel[2]);
            }
            String userEmail = StringUtil.nvl(user.getEmail());
            if(!userEmail.equals("")){
	           	 String[] email = StringUtil.split(userEmail,"@");
	           	 user.setEmail_1(email[0]);
	           	 user.setEmail_2(email[1]);
            }
            model.addAttribute("user",user);
        }
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
    @RequestMapping(value = "/back/user/insertUser.do")
    public ModelAndView insertUser(HttpServletRequest request, ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv =0;
        Map<String, Object> param = _req.getParameterMap();
        try{

    	    param.put("password", CryptoUtil.SHA_encrypt(StringUtil.nvl(param.get("password"))));
    	    if(!StringUtil.nvl(param.get("tel")).equals(""))
   	    	 	param.put("tel", CryptoUtil.AES_Encode((String)param.get("tel")));

	        rv = userService.selectUserExist(param);

	        if(rv < 1){

	        	rv = userService.insertUser(param);

		       	if(rv > 0){																	// 저장한다
					param.put("success", "true" );
		        	param.put("message", MessageUtil.getInsertMsg(rv, _req));
				}else{
					param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
				}

	        }else{
				param.put("success", "false");
				param.put("message", "이미 등록된 사용자입니다.");
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
     * 선택된 항목의 detail 값을 가지고 온다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/user/User.do")
	public String getUser(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = BACK_PATH + "userEdit";

		Map<String, Object> param = _req.getParameterMap();

        model.addAttribute("item", userService.selectUser(param));

        return jsp;
	}

	/**
     * 데이타를 수정한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/user/updateUser.do")
    public ModelAndView updateUser(HttpServletRequest request, ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
       		List<Map<String, Object>> list = null;
       		if(StringUtil.nvl(param.get("user_gb")).equals("M"))
       			//list = (ArrayList<Map<String ,Object>>)JsonUtil.fromJsonStr(param.get("manager_auth").toString().replace("&quot;","'"));
    	    param.put("manager_auth", list);
    	    if(!StringUtil.nvl(param.get("mobile")).equals(""))
    	        param.put("mobile", CryptoUtil.AES_Encode((String)param.get("mobile")));
    	    if(!StringUtil.nvl(param.get("email")).equals(""))
   	    	 	param.put("email", CryptoUtil.AES_Encode((String)param.get("email")));
    	    if(!StringUtil.nvl(param.get("tel")).equals(""))
   	    	 	param.put("tel", CryptoUtil.AES_Encode((String)param.get("tel")));
    	    param.put("password", CryptoUtil.SHA_encrypt(StringUtil.nvl(param.get("password"))));

       		rv = userService.updateUser(param);

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
     * 사용자를 삭제한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/user/deleteUser.do")
    public ModelAndView deleteUser(ExtHtttprequestParam _req, ModelMap model) throws Exception {

       	int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
       		rv = userService.deleteUser(param);

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
     * 비밀번호 초기화
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/user/updatePasswordChange.do")
    public ModelAndView updatePasswordChange(HttpServletRequest request, ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{
    		String imsiPwd = RandomStringUtils.randomAlphanumeric(10);
    		param.put("user_pw", CryptoUtil.SHA_encrypt(imsiPwd));
       		rv = userService.updatePasswordChange(param);
 	   	   SmsSend sms = new SmsSend();

	       	if(rv > 0){																	// 저장한다
	       		// SMS를 전송해준다.
	       		UserVO user = userService.selectUser(param);
	       		// send(user.get("user_mobile",imsiPwd);
	       		sms.sendMessage(StringUtil.replace(StringUtil.nvl(user.getMobile()),"-",""), imsiPwd, "0221336588");

				param.put("success", "true" );
	        	param.put("message", "회원의 비밀번호 초기화에 성공하였으며 사용자에게 문자를 발송하였습니다.");
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", "회원의 비밀번호 초기화에 실패하였습니다."); // 실패 메시지
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
     * 아이디 중복체크
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/user/userIdCheck.do")
    public ModelAndView userIdCheck(HttpServletRequest request, ExtHtttprequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

       	try{

       		rv = userService.selectUserExist(param);

	       	if(rv > 0){																	// 저장한다
				param.put("success", "false" );
	        	param.put("message", "중복 아이디가 존재합니다. 다른 아이디를 입력해주십시요.");
			}else{
				param.put("success", "true");
				param.put("message", "사용할 수 있는 아이디입니다.");
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
	 * 권한별 관리자 리스트 페이지로딩후 grid 데이터를 가지고 온다
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/user/authUserPageList.do")
	public ModelAndView authUserPageList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
	    Map<String, Object> param  = navigator.getParam();
		navigator.setList(userService.selectAuthUserPageList(param));

	    return ViewHelper.getJqGridView(navigator);
	}

	/**
     * 시간대별 접속 통계 리스트 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/user/homepageconnHour.do")
	public String homepageconnHour(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp =  "/back/stats/homepageconnHour";
		String curdate = DateUtil.getCurrentDateTimeFormat("yyyy-MM-dd");
		model.addAttribute("curdate", curdate);
		Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("conntot", userService.selectHomepageconnTotal(param));

        return jsp;
	}

	/**
     * 시간대별 접속 통계 리스트 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/user/homepageconnHourTable.do")
	public String homepageconnHourTable(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp =  "/sub/back/stats/homepageconnHourTable";

		Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> connhour = userService.selectHomepageconnHour(param);
		if(connhour == null){
			connhour = new HashMap();

		}
		model.addAttribute("connhour", connhour);

        return jsp;
	}

	/**
     * 일자별 접속 통계 리스트 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/user/homepageconnDay.do")
	public String homepageconnDay(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = "/back/stats/homepageconnDay";
		String curdate = DateUtil.getCurrentDateTimeFormat("yyyy-MM-dd");
		model.addAttribute("curdate", curdate);
		Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("conntot", userService.selectHomepageconnTotal(param));

        return jsp;
	}

	/**
	 * 일자별 접속 통계 리스트 데이터를 가지고 온다
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/user/homepageconnDayList.do")
	public @ResponseBody Map<String, Object> homepageconnDayList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	    Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> list = userService.selectHomepageconnDay(param);

		param.put("rows", list);

	    return param;
	}

	/**
    * 연별 접속 통계 리스트 페이지로 이동한다.
    * @param _req
    * @param model
    * @return
    * @throws Exception
    */
	@RequestMapping(value = "/back/user/homepageconnYear.do")
	public String homepageconnYear(ExtHtttprequestParam _req, ModelMap model) throws Exception {

		String jsp = "/back/stats/homepageconnYear";

		Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("conntot", userService.selectHomepageconnTotal(param));

       return jsp;
	}

	/**
	 * 년별 접속 통계 리스트 데이터를 가지고 온다
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/back/user/homepageconnYearList.do")
	public @ResponseBody Map<String, Object> homepageconnYearList(ExtHtttprequestParam _req, ModelMap model) throws Exception {

	    Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> list = userService.selectHomepageconnYear(param);

		param.put("rows", list);

	    return param;
	}
	
	/**
     * 내부사용자계정(SSO) 팝업 페이지로 이동한다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/back/user/managerSearchPopup.do")
	public String managerSearchPopup(ExtHtttprequestParam _req, ModelMap model) throws Exception {
		
		String jsp = "/sub"+BACK_PATH + "managerListPopup";
		/*String jsp = BACK_PATH + "intropageListPopup";*/
        return jsp;	
	}
	
	/**
     * 내부사용자계정(SSO) list 데이터를 가지고 온다 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/back/user/managerSearchList.do")
	public @ResponseBody Map<String, Object> managerSearchList(ExtHtttprequestParam _req, ModelMap model, HttpSession session) throws Exception {
        
    	Map<String, Object> param = _req.getParameterMap();
    	SiteVO siteVO = (SiteVO) session.getAttribute("SITE");
		param.put("chamCd", StringUtil.nvl(siteVO.getChamCd()));
    	
		List<Map<String, Object>> list = userService.selectManagerList(param);

		param.put("rows", list);
        return param;
	}
}
