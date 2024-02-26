/**
 * @Class Name : MainBoardDaoImpl.java
 * @Description : MainBoardDaoImpl.Class
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

package kr.apfs.local.main.dao;

import java.util.List;
import java.util.Map;

import kr.apfs.local.common.dao.AbstractDao;

import org.springframework.stereotype.Repository;

@Repository("MainBoardDao")
public class MainBoardDao extends AbstractDao {

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */

	public List<Map<String, Object>> selectBoardList(Map<String, Object> param) throws Exception{
		return selectList("MainBoard.selectBoardList", param);
	}

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */

	public List<Map<String, Object>> selectMainPhotoList(Map<String, Object> param) throws Exception{
		return selectList("MainBoard.selectMainPhotoList", param);
	}

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */

	public List<Map<String, Object>> selectMainEventList(Map<String, Object> param) throws Exception{
		return selectList("MainBoard.selectMainEventList", param);
	}

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */

	public List<Map<String, Object>> selectMainBoardList(Map<String, Object> param) throws Exception{
		return selectList("MainBoard.selectMainBoardList", param);
	}

	/**
    *
    * @param param
    * @return
    * @throws Exception
    */

	public List<Map<String, Object>> selectMainBoardContentsList(Map<String, Object> param) throws Exception{
		return selectList("MainBoard.selectMainBoardContentsList", param);
	}
	
	
	public List<Map<String, Object>> selectMainBoardContentsList2(Map<String, Object> param) throws Exception{
		return selectList("MainBoard.selectMainBoardContentsList2", param);
	}
	

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertMainBoard(Map<String, Object> param) throws Exception{
		 return update("MainBoard.insertMainBoard", param);
	}


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMainBoard(Map<String, Object> param) throws Exception{
		return update("MainBoard.updateMainBoard", param);
	}


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteMainBoard(Map<String, Object> param) throws Exception{
		return delete("MainBoard.deleteMainBoard", param);
	}


}
