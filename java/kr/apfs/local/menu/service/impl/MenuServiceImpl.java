package kr.apfs.local.menu.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.apfs.local.menu.dao.MenuDao;
import kr.apfs.local.menu.service.MenuService;

/**
 * @Class Name : MenuServiceImpl.java
 * @Description : MenuServiceImpl.Class
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

@Service("MenuService")
public class MenuServiceImpl implements MenuService {
	private static final Logger logger = LogManager.getLogger(MenuServiceImpl.class);

	@Resource(name = "MenuDao")
    protected MenuDao menuDao;

	/**
     *  메뉴리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMenuList(Map<String, Object> param) throws Exception{
		return menuDao.selectMenuList(param);
	}

	/**
     *  메뉴 트리리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMenuTreeList(Map<String, Object> param) throws Exception{
		return menuDao.selectMenuTreeList(param);
	}

	/**
     * 홈페이지 메뉴 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectHomepageMenuList(Map<String, Object> param) throws Exception{
		return menuDao.selectHomepageMenuList(param);
	}

	/**
     * 사이트 맵 메뉴 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectSiteMapList(Map<String, Object> param) throws Exception{
		return menuDao.selectSiteMapList(param);
	}


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectMenu(Map<String, Object> param) throws Exception{
		return menuDao.selectMenu(param);
	}

	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	@Override
	public int selectMenuExist(Map<String, Object> param) throws Exception {
		return menuDao.selectMenuExist(param);
	}

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertMenu(Map<String, Object> param) throws Exception{
		return menuDao.insertMenu(param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMenu(Map<String, Object> param) throws Exception{
		return menuDao.updateMenu(param);
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteMenu(Map<String, Object> param) throws Exception{
		return menuDao.deleteMenu(param);
	}

	/**
     * 메뉴 순서조정 정보를 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMenuReorder(Map<String, Object> param) throws Exception{
		return menuDao.updateMenuReorder(param);
	}

	/**
     * 관리자 메뉴 트리리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectManagerMenuTreeList(Map<String, Object> param) throws Exception{
		return menuDao.selectManagerMenuTreeList(param);
	}

	/**
     * 권한에 메뉴를 매핑한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertAuthMenu(Map<String, Object> param) throws Exception{
		int rt = 0;
		menuDao.deleteAuthMenu(param);
		ArrayList list = (ArrayList)param.get("menuList");
		Map<String, Object> data = new HashMap();
		data.put("authId", param.get("authId"));
		for(int i =0; i < list.size(); i++){
			data.put("meniId", list.get(i));
			menuDao.insertAuthMenu(data);
			rt++;
		}
		return rt;
	}

	/**
     * 권한별 최상위 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectAuthTopMenuList(Map<String, Object> param) throws Exception{
		return menuDao.selectAuthTopMenuList(param);
	}

	/**
     * 권한별 서브 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectAuthSubMenuList(Map<String, Object> param) throws Exception{
		return menuDao.selectAuthSubMenuList(param);
	}

	/**
     * 메뉴 검색 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMenuSearchList(Map<String, Object> param) throws Exception{
		return menuDao.selectMenuSearchList(param);
	}

	/**
     * 사이트맵 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectSitemapList(Map<String, Object> param) throws Exception{
		return menuDao.selectSitemapList(param);
	}

	/**
     * Navi 메뉴 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectNaviMenuList(Map<String, Object> param) throws Exception{
		return menuDao.selectNaviMenuList(param);
	}

	/**
     * (join)게시판과 메뉴 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectBoardMenuList(Map<String, Object> param) throws Exception{
		return menuDao.selectBoardMenuList(param);
	}

	/**
     * 미등록된게시판 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectNotBoardMenuList(Map<String, Object> param) throws Exception{
		return menuDao.selectNotBoardMenuList(param);
	}
}
