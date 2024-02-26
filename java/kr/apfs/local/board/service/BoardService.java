package kr.apfs.local.board.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : BoardService.java
 * @Description : BoardService.Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2015.05.10           최초생성
 *
 * @author jangcw
 * @since 2016. 06.10
 * @version 1.0
 *
 *  Copyright (C) by Intocps All right reserved.
 */
public interface BoardService {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardPageList(Map<String, Object> param) throws Exception;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardList(Map<String, Object> param) throws Exception;


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectBoard(Map<String, Object> param) throws Exception;


	/**
     * 중복 여부를 체크한다
     * @param param
     * @return
     * @throws Exception
     */
	public int selectBoardExist(Map<String, Object> param) throws Exception;


	/**
     * 게시판 기본정보를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertBoard(Map<String, Object> param) throws Exception;


	/**
     * 게시판 기본정보를 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoard(Map<String, Object> param) throws Exception;

	/**
     * 게시판 항목설정을 저장한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardItemSet(Map<String, Object> param) throws Exception;

	/**
     * 게시판 목록뷰설정을 저장한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardViewSet(Map<String, Object> param) throws Exception;

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteBoard(Map<String, Object> param) throws Exception;

	/**
     * 메뉴 매핑여부 확인
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int chkBoardMapp(Map<String, Object> param) throws Exception;

	/**
     * 게시판 기본정보를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectBoardDetail(Map<String, Object> param) throws Exception;

	/**
     * 게시판 카테고리 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardCategoryList(Map<String, Object> param) throws Exception;

	/**
     * 게시판 카테고리 상세내용을 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectBoardCategoryDetail(Map<String, Object> param) throws Exception;

	/**
     * 게시판 카테고리를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertBoardCategory(Map<String, Object> param) throws Exception;

	/**
     * 게시판 카테고리를 수정한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardCategory(Map<String, Object> param) throws Exception;

	/**
     * 게시판 카테고리를 삭제한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteBoardCategory(Map<String, Object> param) throws Exception;
	
	/**
	 * 기존 게시물 존재 여부 확인.
	 * @param 	param
	 * @return 	int
	 * @throws 	Exception
	 */
	public int chkBoardExistContents(Map<String, Object> param) throws Exception;

	/**
     * 게시물를 등록한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertBoardContents(Map<String, Object> param) throws Exception;

	/**
     * 게시물를 등록한다.(ETC)
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertBoardContentsEtc(Map<String, Object> param) throws Exception;

	/**
     * 게시물를 수정한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardContents(Map<String, Object> param) throws Exception;

	/**
     * 게시물를 수정한다.(ETC)
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardContentsEtc(Map<String, Object> param) throws Exception;

	/**
     * 답변게시물여부를 확인한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int chkBoardChildContents(Map<String, Object> param) throws Exception;

	/**
     * 게시물 패스워드를 검증한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int chkBoardPass(Map<String, Object> param) throws Exception;

	/**
     * 게시물를 삭제한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteBoardContents(Map<String, Object> param) throws Exception;

	/**
     * 게시물를 삭제한다.(ETC)
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteBoardContentsEtc(Map<String, Object> param) throws Exception;

	/**
     * 게시물을 재정렬한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public void updateBoardContentsReorder(Map<String, Object> param) throws Exception;

	/**
     * 게시판 출력 항목을 정렬순으로 리스트를 가져온다. (view_out)
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardViewSortList(Map<String, Object> param) throws Exception;

	/**
     * 게시판 사용 항목 리스트를 가져온다. (item_out)
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardItemList(Map<String, Object> param) throws Exception;

	/**
     * 게시물 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardContentsPageList(Map<String, Object> param) throws Exception;
	/**
     * 게시물 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardContentsPageListEtc(Map<String, Object> param) throws Exception;

	/**
     * 게시물 기본정보를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectContentsDetail(Map<String, Object> param) throws Exception;

	/**
     * 게시물 이전글, 다음글을 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectPreNextContentsEtc(Map<String, Object> param) throws Exception;

	/**
     * 게시물 기본정보를 가져온다. (ETC)
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectContentsDetailEtc(Map<String, Object> param) throws Exception;

	/**
     * 게시물 이전글, 다음글을 가져온다. (ETC)
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectPreNextContents(Map<String, Object> param) throws Exception;
	/**
     * 조회수를 증가 시킨다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public void updateBoardContentsHits(Map<String, Object> param) throws Exception;

	/**
     * 답변을 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int saveBoardContentsAnswer(Map<String, Object> param) throws Exception;

	/**
     * 댓글 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardCommentList(Map<String, Object> param) throws Exception;

	/**
     * 댓글을 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int saveComment(Map<String, Object> param) throws Exception;

	/**
     * 댓글을 수정한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateComment(Map<String, Object> param) throws Exception;

	/**
     * 댓글을 재정렬한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public void updateCommentReorder(Map<String, Object> param) throws Exception;

	/**
     * 댓글을 삭제한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteComment(Map<String, Object> param) throws Exception;

	/**
     * 댓글의 패스워드를 확인한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int chkComment(Map<String, Object> param) throws Exception;

	/**
     * 만족도를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int saveSatisfy(Map<String, Object> param) throws Exception;

	/**
     * 추천 정보를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectRecommend(Map<String, Object> param) throws Exception;

	/**
     * 추천을 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int saveRecommend(Map<String, Object> param) throws Exception;

	/**
     * 게시판 메인 출력용 게시물
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectLoadMainBoard(Map<String, Object> param) throws Exception;

	/**
     * 게시물 순서조정 정보를 수정한다 (상단공지순서)
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardContentsReorderNoti(Map<String, Object> param) throws Exception;

	/**
     * 기업뉴스 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardNewsPageList(Map<String, Object> param) throws Exception;

	/**
     * 기업뉴스 상세를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectNewsDetail(Map<String, Object> param) throws Exception;

	/**
     * 기업뉴스 이전글, 다음글을 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectNewsPreNextContents(Map<String, Object> param) throws Exception;

	/**
     * 메뉴등록 보드리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMenuBoardList(Map<String, Object> param) throws Exception;

	//코참게시판 연동
	/**
     * 메뉴등록 보드리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> seleckorchamTBoardList(Map<String, Object> param) throws Exception;

	public Map<String, Object> selectGoods(Map<String, Object> param) throws Exception;

	
	
	//비밀번호 체크 
	public Map<String, Object> pwdCheck(Map<String, Object> param) throws Exception;

	public void updateEtcBoardContentsHits(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectDownloadExcelBoardList(Map<String, Object> param) throws Exception;
    
}
