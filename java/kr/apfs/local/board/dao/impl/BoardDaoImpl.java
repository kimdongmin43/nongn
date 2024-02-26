/**
 * @Class Name : BoardDaoImpl.java
 * @Description : BoardDaoImpl.Class
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

package kr.apfs.local.board.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.apfs.local.common.dao.AbstractDao;
import kr.apfs.local.board.dao.BoardDao;

@Repository("BoardDao")
public class BoardDaoImpl extends AbstractDao implements BoardDao {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardPageList(Map<String, Object> param) throws Exception{
		return selectPageList("BoardDao.selectBoardPageList", param);
	}


	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardList(Map<String, Object> param) throws Exception{
		return selectList("BoardDao.selectBoardList", param);
	}



	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectBoard(Map<String, Object> param) throws Exception{
		return selectOne("BoardDao.selectBoard", param);
	}


	/**
     * 중복검사를 한다
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int selectBoardExist(Map<String, Object> param) throws Exception{
		return selectOne("BoardDao.selectBoardExist", param);
	}


	/**
     * 게시판 기본정보를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertBoard(Map<String, Object> param) throws Exception{
		 return update("BoardDao.insertBoard", param);
	}


	/**
     * 게시판 기본정보를 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoard(Map<String, Object> param) throws Exception{
		return update("BoardDao.updateBoard", param);
	}

	/**
     * 게시판 항목설정을 저장한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardItemSet(Map<String, Object> param) throws Exception{
		return update("BoardDao.updateBoardItemSet", param);
	}

	/**
     * 게시판 목록뷰설정을 저장한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardViewSet(Map<String, Object> param) throws Exception{
		return update("BoardDao.updateBoardViewSet", param);
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteBoard(Map<String, Object> param) throws Exception{
		return delete("BoardDao.deleteBoard", param);
	}

	/**
     * 메뉴 매핑여부 확인
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public int chkBoardMapp(Map<String, Object> param) throws Exception{
		return selectOne("BoardDao.chkBoardMapp", param);
	}

	/**
     * 게시판 기본정보를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> param) throws Exception{
		return selectOne("BoardDao.selectBoardDetail", param);
	}

	/**
     * 게시판 카테고리 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
     @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardCategoryList(Map<String, Object> param) throws Exception{
		return selectList("BoardDao.selectBoardCategoryList", param);
	}

     /**
      * 게시판 카테고리 상세내용을 가져온다.
      * @param param
      * @return
      * @throws Exception
      */
      @SuppressWarnings("unchecked")
 	public Map<String, Object> selectBoardCategoryDetail(Map<String, Object> param) throws Exception{
 		return selectOne("BoardDao.selectBoardCategoryDetail", param);
 	}

	/**
     * 게시판 카테고리를 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertBoardCategory(Map<String, Object> param) throws Exception{
		 return update("BoardDao.insertBoardCategory", param);
	}

	/**
     * 게시판 카테고리를 수정한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardCategory(Map<String, Object> param) throws Exception{
		 return update("BoardDao.updateBoardCategory", param);
	}

	/**
     * 게시판 카테고리를 삭제한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteBoardCategory(Map<String, Object> param) throws Exception{
		 return update("BoardDao.deleteBoardCategory", param);
	}

	/**
     * 게시물을 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertBoardContents(Map<String, Object> param) throws Exception{
		 return update("BoardDao.insertBoardContents", param);
	}

	/**
     * 게시물을 저장한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertBoardContentsEtc(Map<String, Object> param) throws Exception{
		 return update("BoardDao.insertBoardContentsEtc", param);
	}

	/**
     * 게시물을 수정한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardContents(Map<String, Object> param) throws Exception{
		 return update("BoardDao.updateBoardContents", param);
	}

	/**
     * 게시물을 수정한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateBoardContentsEtc(Map<String, Object> param) throws Exception{
		 return update("BoardDao.updateBoardContentsEtc", param);
	}

	/**
     * 답변게시물여부를 확인한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int chkBoardChildContents(Map<String, Object> param) throws Exception{
		 return selectOne("BoardDao.chkBoardChildContents", param);
	}

	/**
     * 게시물 패스워드를 검증한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int chkBoardPass(Map<String, Object> param) throws Exception{
		 return selectOne("BoardDao.chkBoardPass", param);
	}

	/**
     * 게시물을 삭제한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteBoardContents(Map<String, Object> param) throws Exception{
		 return update("BoardDao.deleteBoardContents", param);
	}

	/**
     * 게시물을 삭제한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteBoardContentsEtc(Map<String, Object> param) throws Exception{
		 return update("BoardDao.deleteBoardContentsEtc", param);
	}

	/**
     * 게시물을 재정렬한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public void updateBoardContentsReorder(Map<String, Object> param) throws Exception{
		 update("BoardDao.updateBoardContentsReorder", param);
	}

	/**
     * 게시판 출력 항목을 정렬순으로 리스트를 가져온다. (view_out)
     * @param param
     * @return
     * @throws Exception
     */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardViewSortList(Map<String, Object> param) throws Exception{
		return selectList("BoardDao.selectBoardViewSortList", param);
	}

	/**
     * 게시판 사용 항목 리스트를 가져온다. (item_out)
     * @param param
     * @return
     * @throws Exception
     */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardItemList(Map<String, Object> param) throws Exception{
		return selectList("BoardDao.selectBoardItemList", param);
	}

     /**
      * 게시물 리스트를 가져온다.
      * @param param
      * @return
      * @throws Exception
      */
     @SuppressWarnings("unchecked")
     public List<Map<String, Object>> selectBoardContentsPageList(Map<String, Object> param) throws Exception{
    	 return selectPageList("BoardDao.selectBoardContentsPageList", param);
     }
     /**
      * 게시물 리스트를 가져온다.
      * @param param
      * @return
      * @throws Exception
      */
     @SuppressWarnings("unchecked")
     public List<Map<String, Object>> selectBoardContentsPageListEtc(Map<String, Object> param) throws Exception{
    	 return selectPageList("BoardDao.selectBoardContentsPageListEtc", param);
     }

     /**
      * 게시물 기본정보를 가져온다.
      * @param param
      * @return
      * @throws Exception
      */
     @SuppressWarnings("unchecked")
     public Map<String, Object> selectContentsDetail(Map<String, Object> param) throws Exception{
    	 return selectOne("BoardDao.selectContentsDetail", param);
     }

     /**
      * 게시물 이전글, 다음글을 가져온다.
      * @param param
      * @return
      * @throws Exception
      */
     @SuppressWarnings("unchecked")
     public Map<String, Object> selectPreNextContents(Map<String, Object> param) throws Exception{
    	 return selectOne("BoardDao.selectPreNextContents", param);
     }

     /**
      * 게시물 기본정보를 가져온다.(ETC)
      * @param param
      * @return
      * @throws Exception
      */
     @SuppressWarnings("unchecked")
     public Map<String, Object> selectContentsDetailEtc(Map<String, Object> param) throws Exception{
    	 return selectOne("BoardDao.selectContentsDetailEtc", param);
     }

     /**
      * 게시물 이전글, 다음글을 가져온다.(ETC)
      * @param param
      * @return
      * @throws Exception
      */
     @SuppressWarnings("unchecked")
     public Map<String, Object> selectPreNextContentsEtc(Map<String, Object> param) throws Exception{
    	 return selectOne("BoardDao.selectPreNextContentsEtc", param);
     }

     /**
      * 조회수를 증가 시킨다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
 	public void updateBoardContentsHits(Map<String, Object> param) throws Exception{
 		 update("BoardDao.updateBoardContentsHits", param);
 	}

 	public void updateEtcBoardContentsHits(Map<String, Object> param) throws Exception{
		 update("BoardDao.updateEtcBoardContentsHits", param);
	}

     /**
      * 답변을 저장한다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
     public int saveBoardContentsAnswer(Map<String, Object> param) throws Exception{
    	 return update("BoardDao.saveBoardContentsAnswer", param);
     }

     /**
      * 답글 리스트를 가져온다.
      * @param param
      * @return
      * @throws Exception
      */
     @SuppressWarnings("unchecked")
     public List<Map<String, Object>> selectBoardCommentList(Map<String, Object> param) throws Exception{
    	 return selectPageList("BoardDao.selectBoardCommentList", param);
     }

     /**
      * 댓글을 저장한다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
     public int saveComment(Map<String, Object> param) throws Exception{
    	 return update("BoardDao.saveComment", param);
     }

     /**
      * 댓글을 수정한다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
     public int updateComment(Map<String, Object> param) throws Exception{
    	 return update("BoardDao.updateComment", param);
     }

     /**
      * 댓글을 재정렬한다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
     public void updateCommentReorder(Map<String, Object> param) throws Exception{
    	 update("BoardDao.updateCommentReorder", param);
     }

     /**
      * 댓글을 삭제한다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
     public int deleteComment(Map<String, Object> param) throws Exception{
    	 return update("BoardDao.deleteComment", param);
     }

     /**
      * 댓글의 패스워드를 확인한다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
     public int chkComment(Map<String, Object> param) throws Exception{
    	 return selectOne("BoardDao.chkComment", param);
     }

     /**
      * 만족도를 저장한다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
     public int saveSatisfy(Map<String, Object> param) throws Exception{
    	 return update("BoardDao.saveSatisfy", param);
     }

     /**
      * 추천 정보를 가져온다.
      * @param param
      * @return
      * @throws Exception
      */
     @SuppressWarnings("unchecked")
     public Map<String, Object> selectRecommend(Map<String, Object> param) throws Exception{
    	 return selectOne("BoardDao.selectRecommend", param);
     }

     /**
      * 추천을 저장한다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
     public int saveRecommend(Map<String, Object> param) throws Exception{
    	 return update("BoardDao.saveRecommend", param);
     }

     /**
      * 답신여부를 가져온다.
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
     public Map<String, Object> chkSmsRecv(Map<String, Object> param) throws Exception{
    	 return selectOne("BoardDao.chkSmsRecv", param);
     }

     /**
      * 게시판 메인 출력용 게시물
      * @param param
      * @return
      * @throws Exception
      */
     @SuppressWarnings("unchecked")
     public List<Map<String, Object>> selectLoadMainBoard(Map<String, Object> param) throws Exception{
    	 return selectPageList("BoardDao.selectLoadMainBoard", param);
     }

     /**
      * 게시판 순서조정 정보를 수정한다 (상단공지순서)
      * @param 	param
      * @return 	int
      * @throws 	Exception
      */
 	public int updateBoardContentsReorderNoti(Map<String, Object> param) throws Exception{
 		List<Map<String, Object>> list = (List<Map<String, Object>>)param.get("sort_list");
 		
 		for(int i =0; i < list.size();i++){
 			
 			param.put("contId", list.get(i).get("contId"));
			param.put("notiSeq", list.get(i).get("notiSeq"));
 			
			update("BoardDao.updateBoardSort", param);
 		}

 		return list.size();
 	}

 	/**
     * 게시물 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectBoardNewsPageList(Map<String, Object> param) throws Exception{
   	 return selectPageList("BoardDao.selectBoardNewsPageList", param);
    }

 	/**
     * 게시물 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectNewsDetail(Map<String, Object> param) throws Exception{
   	 return selectOne("BoardDao.selectNewsDetail", param);
    }

    /**
     * 기업뉴스 이전글, 다음글을 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectNewsPreNextContents(Map<String, Object> param) throws Exception{
   	 return selectOne("BoardDao.selectNewsPreNextContents", param);
    }



	/**
     * 메뉴등록 보드리스트
     * @param param
     * @return
     * @throws Exception
     */
	@Override
	public List<Map<String, Object>> selectMenuBoardList(Map<String, Object> param) throws Exception {
		return selectList("BoardDao.selectMenuBoardList", param);
	}


	@Override
	public List<Map<String, Object>> seleckorchamTBoardList(Map<String, Object> param) throws Exception {
		return selectList("BoardDao.seleckorchamTBoardList", param);
	}

	@Override
	public Map<String, Object> selectGoods(Map<String, Object> param) throws Exception {
		return selectOne("BoardDao.selectGoods", param);
	}


	@Override
	public Map<String, Object> selectPwdCheck(Map<String, Object> param) throws Exception {
		return selectOne("BoardDao.pwdCheck", param);
	}


	@Override
	public int chkBoardExistContents(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return selectOne("BoardDao.chkBoardExistContents", param);
	}


	@Override
	public List<Map<String, Object>> selectDownloadExcelBoardList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return selectList("BoardDao.selectDownloadExcelBoardList", param);
	}
}
