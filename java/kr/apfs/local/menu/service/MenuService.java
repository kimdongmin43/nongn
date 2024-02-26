package kr.apfs.local.menu.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : MenuService.java
 * @Description : MenuService.Class
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
public interface MenuService {

	/**
     * 메뉴 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMenuList(Map<String, Object> param) throws Exception;

	/**
     * 메뉴 트리 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMenuTreeList(Map<String, Object> param) throws Exception;

	/**
     * 홈페이지 메뉴 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectHomepageMenuList(Map<String, Object> param) throws Exception;

	/**
     * 사이트맵 메뉴 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectSiteMapList(Map<String, Object> param) throws Exception;


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectMenu(Map<String, Object> param) throws Exception;

	/**
     * 중복 여부를 체크한다
     * @param param
     * @return
     * @throws Exception
     */
	public int selectMenuExist(Map<String, Object> param) throws Exception;


	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertMenu(Map<String, Object> param) throws Exception;


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMenu(Map<String, Object> param) throws Exception;


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteMenu(Map<String, Object> param) throws Exception;

	/**
     * 메뉴 순서조정 정보를 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMenuReorder(Map<String, Object> param) throws Exception;

	/**
     * 관리자 메뉴 트리리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectManagerMenuTreeList(Map<String, Object> param) throws Exception;

	/**
     * 권한에 메뉴를 매핑한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertAuthMenu(Map<String, Object> param) throws Exception;

	/**
     * 권한별 최상위 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectAuthTopMenuList(Map<String, Object> param) throws Exception;

	/**
     * 권한별 서브 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectAuthSubMenuList(Map<String, Object> param) throws Exception;

	/**
     * 메뉴 검색 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMenuSearchList(Map<String, Object> param) throws Exception;

	/**
     * 사이트맵 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectSitemapList(Map<String, Object> param) throws Exception;

	/**
     * Navi 메뉴 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectNaviMenuList(Map<String, Object> param) throws Exception;

	/**
     * (join)게시판과 메뉴 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardMenuList(Map<String, Object> param) throws Exception;

	/**
     * 미등록된게시판 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectNotBoardMenuList(Map<String, Object> param) throws Exception;
}
