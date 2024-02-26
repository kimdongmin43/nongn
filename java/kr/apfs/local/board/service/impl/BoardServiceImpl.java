package kr.apfs.local.board.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.apfs.local.board.controller.BoardController;
import kr.apfs.local.board.dao.BoardDao;
import kr.apfs.local.board.service.BoardService;
import kr.apfs.local.common.util.CryptoUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.util.SmsSend;

/**
 * @Class Name : BoardServiceImpl.java
 * @Description : BoardServiceImpl.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2015.05.09           최초생성
 *
 * @author jangcw
 * @since 2016. 06.10
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Intocps All right reserved.
 */

@Service("BoardService")
public class BoardServiceImpl implements BoardService {
	private static final Logger logger = LogManager.getLogger(BoardServiceImpl.class);

	@Resource(name = "BoardDao")
    protected BoardDao boardDao;



	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardPageList(Map<String, Object> param) throws Exception{
		return boardDao.selectBoardPageList(param);
	}

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardList(Map<String, Object> param) throws Exception{
		return boardDao.selectBoardList(param);
	}

	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectBoard(Map<String, Object> param) throws Exception{
		return boardDao.selectBoard(param);
	}

	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectBoardExist(Map<String, Object> param) throws Exception {
		return boardDao.selectBoardExist(param);
	}

	/**
     * 게시판 기본정보를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertBoard(Map<String, Object> param) throws Exception{

		// 게시판 타입에 따라 항목설정, 목록뷰설정 디폴트저장
		String v_type = (String) param.get("boardCd");
		String v_item_use = "";
		String v_item_user = "";
		String v_item_required = "number,title,reg_mem_nm,reg_dt,hit";
		String v_view_print = "number,title,attach,reg_mem_nm,reg_dt,hit";
		String v_view_size = "";
		String v_view_sort = "";
		String v_item_out = "";
		String v_file_cnt = "5";
		String detail_yn = "Y";

		if("Q".equals(v_type)){				 		// QNA게시판으로 생성 할 때
			v_item_use = "number,title,reg_mem_nm,contents,reg_dt,attach,reply_yn,reply_status,reply_content,reply_date";
			v_item_user = "1,1,1,1,1,1,1,1,1,1";
			v_view_size = "15,30,20,20,15";
			v_view_sort = "1,2,3,4,5";
			v_view_print = "number,title,attach,reg_mem_nm,reg_dt,reply_status";
			v_item_out = "번호|제목|작성자|내용|작성일|첨부파일| | |답변내용|답변일";
		}else if("N".equals(v_type)){			// 목록형으로 생성 할 때
			// 사용 화면 : 순번, 제목, 내용, 첨부, 작성자, 작성일, 조회수
			/*v_item_use = "number,title,contents,attach,reg_mem_nm,reg_dt,hit";*/
			v_item_use = "number,title,reg_mem_nm,contents,reg_dt,hit,attach";
			v_item_user = "1,1,1,1,1,1,1";
			v_view_size = "10,35,10,15,20,10";
			v_view_sort = "1,2,3,4,5,6";
			// 목록 화면 : 순번, 제목, 첨부, 작성자, 작성일, 조회수
			//v_view_print = "number,title,attach,reg_mem_nm,reg_dt,hit";
			v_item_out = "번호|제목|작성자|내용|작성일|조회수|첨부파일";
		}else if("W".equals(v_type) || "A".equals(v_type)){			// 포토뉴스형(리스트,갤러리)으로 생성 할 때
			// 사용 화면 : 순번, 제목, 내용, 첨부, 작성자, 작성일, 조회수
			v_item_use = "number,title,reg_mem_nm,contents,reg_dt,hit,attach";
			v_item_user = "1,1,1,1,1,1";
			v_view_size = "15,40,10,15,20";
			v_view_sort = "1,2,3,4,5";
			// 목록 화면 : 순번, 제목, 첨부, 작성자, 작성일, 조회수
			v_view_print = "title,contents,reg_mem_nm,reg_dt,hit";
			v_item_out = "번호|제목|작성자|내용|작성일|조회수|첨부파일";
		}else if("L".equals(v_type)){												// "L" 링크형 게시판
			/*v_item_use = "number,title,thumb,reg_mem_nm,reg_dt,reg_ip,hit";*/
			v_item_use = "number,title,link,reg_mem_nm,reg_dt";
			v_item_user = "1,1,1,1,1";
			v_view_size = "15,50,15,20";
			v_view_sort = "1,2,3,4,5";
			// 목록 화면 : 순번, 제목, 작성자, 작성일, 조회수
			v_view_print = "number,title,reg_mem_nm,reg_dt";
			v_item_required = "number,title,link,reg_mem_nm,reg_dt";
			v_item_out = "번호|제목|제목링크|작성자|작성일";
			// 링크형 게시판 디테일 여부 N으로
			detail_yn = "N";
		}else {
			// 사용 화면 : 순번, 제목, 내용, 첨부, 작성자, 작성일, 조회수
			v_item_use = "number,title,reg_mem_nm,contents,reg_dt,hit,attach";
			v_item_user = "1,1,1,1,1,1,1";
			v_view_size = "10,35,10,15,20,10";
			v_view_sort = "1,2,3,4,5,6";
			// 목록 화면 : 순번, 제목, 첨부, 작성자, 작성일, 조회수
			v_view_print = "number,title,reg_mem_nm,reg_dt";
			v_item_out = "번호|제목|작성자|내용|작성일|조회수|첨부파일";
			if("P".equals(v_type)){
				// 사용 화면 : 순번,카테,상품명,상품홍보,카테,첨부,작성자
				v_item_use ="number,cate,title,product,attach,reg_mem_nm,reg_dt";//reg_dt
				v_item_user = "1,1,1,1,1,1,1";
				// 목록 화면 : 순번, 제목, 첨부, 작성자, 작성일, 조회수
				v_view_print = "number,title,reg_mem_nm,reg_dt";
				v_view_size = "15,50,15,20";
				v_view_sort = "1,2,3,4";
				v_item_out = "번호|분류|상품명|상품홍보|이미지|작성자|작성일";
			}else if("R".equals(v_type)){
				// 사용 화면 : 순번,분류,기관명,유관기관,작성자
				v_item_use ="number,cate,title,related,reg_mem_nm,reg_dt";//reg_dt
				v_item_user = "1,1,1,1,1,1";
				// 목록 화면 : 순번, 제목, 첨부, 작성자, 작성일, 조회수
				v_view_print = "number,title,reg_mem_nm,reg_dt";
				v_view_size = "15,50,15,20";
				v_view_sort = "1,2,3,4";
				v_item_out = "번호|분류|기관명|유관기관|작성자|작성일";
			}else if("I".equals(v_type)){
				// 사용 화면 : 순번,분류,사이트명,국제무역추천사이트,카테,첨부,작성자
				v_item_use ="number,cate,title,international,reg_mem_nm,reg_dt";//reg_dt
				v_item_user = "1,1,1,1,1,1,1";
				// 목록 화면 : 순번, 제목, 첨부, 작성자, 작성일, 조회수
				v_view_print = "number,title,reg_mem_nm,reg_dt";
				v_view_size = "15,50,15,20";
				v_view_sort = "1,2,3,4";
				v_item_out = "번호|분류|사이트명|국제무역추천사이트|작성자|작성일";
			}
		}

		param.put("itemUse", v_item_use);
		param.put("itemUser", v_item_user);
		param.put("itemRequired", v_item_required);
		param.put("viewPrint", v_view_print);
		param.put("viewSize", v_view_size);
		param.put("viewSort", v_view_sort);
		param.put("fileCnt", v_file_cnt);
		param.put("itemOut",v_item_out);
		param.put("detailYn",detail_yn);

		return boardDao.insertBoard(param);
	}

	/**
     * 게시판 기본정보를 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoard(Map<String, Object> param) throws Exception{
		return boardDao.updateBoard(param);
	}

	/**
     * 게시판 항목설정을 저장한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardItemSet(Map<String, Object> param) throws Exception{
		return boardDao.updateBoardItemSet(param);
	}

	/**
     * 게시판 목록뷰설정을 저장한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardViewSet(Map<String, Object> param) throws Exception{
		return boardDao.updateBoardViewSet(param);
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteBoard(Map<String, Object> param) throws Exception{
		return boardDao.deleteBoard(param);
	}

	/**
     * 메뉴 매핑여부 확인
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int chkBoardMapp(Map<String, Object> param) throws Exception{
		return boardDao.chkBoardMapp(param);
	}

	/**
     * 게시판 기본정보를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectBoardDetail(Map<String, Object> param) throws Exception{
		return boardDao.selectBoardDetail(param);
	}

	/**
     * 게시판 카테고리 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardCategoryList(Map<String, Object> param) throws Exception{
		return boardDao.selectBoardCategoryList(param);
	}

	/**
     * 게시판 카테고리 상세내용을 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectBoardCategoryDetail(Map<String, Object> param) throws Exception{
		return boardDao.selectBoardCategoryDetail(param);
	}

	/**
     * 게시판 카테고리를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertBoardCategory(Map<String, Object> param) throws Exception{
		return boardDao.insertBoardCategory(param);
	}

	/**
     * 게시판 카테고리를 수정한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardCategory(Map<String, Object> param) throws Exception{
		return boardDao.updateBoardCategory(param);
	}

	/**
     * 게시판 카테고리를 삭제한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteBoardCategory(Map<String, Object> param) throws Exception{
		return boardDao.deleteBoardCategory(param);
	}

	/**
     * 게시물을 등록한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertBoardContents(Map<String, Object> param) throws Exception{
		String v_phone = "";
		if(param.get("phone2") != null && param.get("phone3") != null){
			v_phone = param.get("phone1")+"-"+param.get("phone2")+"-"+param.get("phone3");
			param.put("mobile", CryptoUtil.AES_Encode(v_phone));
		}

		return boardDao.insertBoardContents(param);
	}

	/**
     * 게시물을 등록한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertBoardContentsEtc(Map<String, Object> param) throws Exception{
		/*String v_phone = "";
		if(param.get("phone2") != null && param.get("phone3") != null){
			v_phone = param.get("phone1")+"-"+param.get("phone2")+"-"+param.get("phone3");
			param.put("mobile", CryptoUtil.AES_Encode(v_phone));
		}*/

		return boardDao.insertBoardContentsEtc(param);
	}

	/**
     * 게시물을 수정한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardContents(Map<String, Object> param) throws Exception{
		String v_phone = "";
		if(param.get("phone2") != null && param.get("phone3") != null){
			v_phone = param.get("phone1")+"-"+param.get("phone2")+"-"+param.get("phone3");
			param.put("mobile", CryptoUtil.AES_Encode(v_phone));
		}

		return boardDao.updateBoardContents(param);
	}

	/**
     * 게시물을 수정한다. (ETC)
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardContentsEtc(Map<String, Object> param) throws Exception{
		/*String v_phone = "";
		if(param.get("phone2") != null && param.get("phone3") != null){
			v_phone = param.get("phone1")+"-"+param.get("phone2")+"-"+param.get("phone3");
			param.put("mobile", CryptoUtil.AES_Encode(v_phone));
		}*/

		return boardDao.updateBoardContentsEtc(param);
	}

	/**
     * 답변게시물여부를 확인한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int chkBoardChildContents(Map<String, Object> param) throws Exception{
		return boardDao.chkBoardChildContents(param);
	}

	/**
     * 게시물 패스워드를 검증한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int chkBoardPass(Map<String, Object> param) throws Exception{
		return boardDao.chkBoardPass(param);
	}

	/**
     * 게시물을 삭제한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteBoardContents(Map<String, Object> param) throws Exception{
		return boardDao.deleteBoardContents(param);
	}

	/**
     * 게시물을 삭제한다. (ETC)
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteBoardContentsEtc(Map<String, Object> param) throws Exception{
		return boardDao.deleteBoardContentsEtc(param);
	}

	/**
     * 게시물을 재정렬한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public void updateBoardContentsReorder(Map<String, Object> param) throws Exception{
		boardDao.updateBoardContentsReorder(param);
	}

	/**
     * 게시판 출력 항목을 정렬순으로 리스트를 가져온다. (view_out)
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardViewSortList(Map<String, Object> param) throws Exception{
		return boardDao.selectBoardViewSortList(param);
	}

	/**
     * 게시판 사용 항목 리스트를 가져온다. (item_out)
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardItemList(Map<String, Object> param) throws Exception{
		return boardDao.selectBoardItemList(param);
	}

	/**
     * 게시물 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardContentsPageList(Map<String, Object> param) throws Exception{
		CryptoUtil a256 = CryptoUtil.getInstance();
		List<Map<String, Object>> list = boardDao.selectBoardContentsPageList(param);
		List<Map<String, Object>> list2 =  new ArrayList();
		Map<String, Object> map = new HashMap();
		if(list != null){
			for(int i=0; i<list.size(); i++) {
				map = null;
				map = list.get(i);
				/*if(map.get("mobile") != null){
					map.put("mobile", a256.AES_Decode((String)map.get("mobile")));
					System.out.println("복호화==="+map.get("mobile"));
				}*/
				
				if(map.get("contents") != null){
					map.put("contents", StringUtil.removeTag(StringUtil.nvl(map.get("contents"))));
				}
				list2.add(map);
			}
		}

		return list2;
	}
	/**
     * 게시물 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardContentsPageListEtc(Map<String, Object> param) throws Exception{
		CryptoUtil a256 = CryptoUtil.getInstance();
		List<Map<String, Object>> list = boardDao.selectBoardContentsPageListEtc(param);
		List<Map<String, Object>> list2 =  new ArrayList();
		Map<String, Object> map = new HashMap();
		if(list != null){
			for(int i=0; i<list.size(); i++) {
				map = null;
				map = list.get(i);
				/*if(map.get("mobile") != null){
					map.put("mobile", a256.AES_Decode((String)map.get("mobile")));
					//System.out.println(map.get("mobile"));
				}
				if(map.get("contents") != null){
					map.put("contents", StringUtil.removeTag(StringUtil.nvl(map.get("contents"))));
				}*/
				list2.add(map);
			}
		}

		return list2;
	}

	/**
     * 게시물 기본정보를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectContentsDetail(Map<String, Object> param) throws Exception{
		CryptoUtil a256 = CryptoUtil.getInstance();
		Map<String, Object> map = boardDao.selectContentsDetail(param);
		/*if(map.get("mobile") != null){
			map.put("mobile", CryptoUtil.AES_Decode(StringUtil.nvl(map.get("mobile"))));
		}*/
		return map;
	}

	/**
     * 게시물 이전글, 다음글을 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectPreNextContents(Map<String, Object> param) throws Exception{
		return boardDao.selectPreNextContents(param);
	}

	/**
     * 게시물 기본정보를 가져온다.(ETC)
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectContentsDetailEtc(Map<String, Object> param) throws Exception{
		CryptoUtil a256 = CryptoUtil.getInstance();
		Map<String, Object> map = boardDao.selectContentsDetailEtc(param);
		/*if(map.get("mobile") != null){
			map.put("mobile", CryptoUtil.AES_Decode(StringUtil.nvl(map.get("mobile"))));
		}
		*/
		return map;
	}

	/**
     * 게시물 이전글, 다음글을 가져온다.(ETC)
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectPreNextContentsEtc(Map<String, Object> param) throws Exception{
		return boardDao.selectPreNextContentsEtc(param);
	}

	/**
     * 조회수를 증가 시킨다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public void updateBoardContentsHits(Map<String, Object> param) throws Exception{
		boardDao.updateBoardContentsHits(param);
	}
	
	
	public void updateEtcBoardContentsHits(Map<String, Object> param) throws Exception{
		boardDao.updateEtcBoardContentsHits(param);
	}

	/**
     * 답변을 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int saveBoardContentsAnswer(Map<String, Object> param) throws Exception{
		int rv = boardDao.saveBoardContentsAnswer(param);
		/*SmsSend sms = new SmsSend();

		// 답신여부 확인후 처리
		Map<String, Object> map = boardDao.chkSmsRecv(param);
		if(map != null){
			String v_phone = "";
			if(map.get("mobile") != null){
				v_phone = CryptoUtil.AES_Decode(StringUtil.nvl(map.get("mobile")));
				v_phone = v_phone.replaceAll("-", "");

				// SMS를 보낸다.
				sms.sendMessage(v_phone, "회원님의 게시글에 답변이 기재되었습니다.", "0221336588");
			}
		}*/

		return rv;
	}

	/**
     * 댓글 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardCommentList(Map<String, Object> param) throws Exception{
		return boardDao.selectBoardCommentList(param);
	}

	/**
     * 댓글을 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int saveComment(Map<String, Object> param) throws Exception{
		return boardDao.saveComment(param);
	}

	/**
     * 댓글을 수정한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateComment(Map<String, Object> param) throws Exception{
		return boardDao.updateComment(param);
	}

	/**
     * 댓글을 재정렬한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public void updateCommentReorder(Map<String, Object> param) throws Exception{
		boardDao.updateCommentReorder(param);
	}

	/**
     * 댓글을 삭제한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteComment(Map<String, Object> param) throws Exception{
		return boardDao.deleteComment(param);
	}

	/**
     * 댓글의 패스워드를 확인한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int chkComment(Map<String, Object> param) throws Exception{
		return boardDao.chkComment(param);
	}

	/**
     * 만족도를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int saveSatisfy(Map<String, Object> param) throws Exception{
		return boardDao.saveSatisfy(param);
	}

	/**
     * 추천 정보를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectRecommend(Map<String, Object> param) throws Exception{
		return boardDao.selectRecommend(param);
	}

	/**
     * 추천을 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int saveRecommend(Map<String, Object> param) throws Exception{
		return boardDao.saveRecommend(param);
	}

	/**
     * 게시판 메인 출력용 게시물
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectLoadMainBoard(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> list = boardDao.selectLoadMainBoard(param);
		List<Map<String, Object>> list2 =  new ArrayList();
		Map<String, Object> map = new HashMap();
		if(list != null){
			for(int i=0; i<list.size(); i++) {
				map = null;
				map = list.get(i);
				if(map.get("contents") != null){
					map.put("contents", StringUtil.removeTag(StringUtil.nvl(map.get("contents"))));
				}
				list2.add(map);
			}
		}

		return list2;
	}

	/**
     * 게시판 순서조정 정보를 수정한다 (상단공지순서)
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardContentsReorderNoti(Map<String, Object> param) throws Exception{
		return boardDao.updateBoardContentsReorderNoti(param);
	}

	/**
     * 게시물 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardNewsPageList(Map<String, Object> param) throws Exception{
		CryptoUtil a256 = CryptoUtil.getInstance();
		List<Map<String, Object>> list = boardDao.selectBoardNewsPageList(param);
		List<Map<String, Object>> list2 =  new ArrayList();
		Map<String, Object> map = new HashMap();
		if(list != null){
			for(int i=0; i<list.size(); i++) {
				map = null;
				map = list.get(i);
				if(map.get("mobile") != null){
					map.put("mobile", a256.AES_Decode((String)map.get("mobile")));
					//System.out.println(map.get("mobile"));
				}
				if(map.get("contents") != null){
					map.put("contents", StringUtil.removeTag(StringUtil.nvl(map.get("contents"))));
				}
				list2.add(map);
			}
		}

		return list2;
	}

	/**
     * 게시물 기본정보를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectNewsDetail(Map<String, Object> param) throws Exception{
		CryptoUtil a256 = CryptoUtil.getInstance();
		Map<String, Object> map = boardDao.selectNewsDetail(param);
		return map;
	}

	/**
     * 기업뉴스 이전글, 다음글을 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectNewsPreNextContents(Map<String, Object> param) throws Exception{
		return boardDao.selectNewsPreNextContents(param);
	}

	/**
     * 메뉴등록 보드리스트
     * @param param
     * @return
     * @throws Exception
     */
	@Override
	public List<Map<String, Object>> selectMenuBoardList(Map<String, Object> param) throws Exception {
		return boardDao.selectMenuBoardList(param);
	}

	/**
     * 메뉴등록 보드리스트
     * @param param
     * @return
     * @throws Exception
     */
	@Override
	public List<Map<String, Object>> seleckorchamTBoardList(Map<String, Object> param) throws Exception {
		return boardDao.seleckorchamTBoardList(param);
	}

	public Map<String, Object> selectGoods(Map<String, Object> param) throws Exception {
		return boardDao.selectGoods(param);
	}

	@Override
	public Map<String, Object> pwdCheck(Map<String, Object> param)throws Exception {
		return boardDao.selectPwdCheck(param);
	}

	@Override
	public int chkBoardExistContents(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.chkBoardExistContents(param);
	}

	@Override
	public List<Map<String, Object>> selectDownloadExcelBoardList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectDownloadExcelBoardList(param);
	}
}
