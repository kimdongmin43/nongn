/**
 * @Class Name : MainImageDaoImpl.java
 * @Description : MainImageDaoImpl.Class
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

@Repository("MainImageDao")
public class MainImageDao extends AbstractDao {


	/**
     *
     * @param param
     * @return
     * @throws Exception
     */

	public List<Map<String, Object>> selectMainImageList(Map<String, Object> param) throws Exception{
		return selectList("MainImage.selectMainImageList", param);
	}

	/**
     * 리스트를 복사한다.
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int copyMainImageList(Map<String, Object> param) throws Exception{
		 return update("MainImage.copyMainImageList", param);
	}

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertMainImage(Map<String, Object> param) throws Exception{
		 return update("MainImage.insertMainImage", param);
	}


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMainImage(Map<String, Object> param) throws Exception{
		return update("MainImage.updateMainImage", param);
	}

	/**
     * 순서를 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int saveMainImageSort(Map<String, Object> param) throws Exception{
		return update("MainImage.saveMainImageSort", param);
	}


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteMainImage(Map<String, Object> param) throws Exception{
		return delete("MainImage.deleteMainImage", param);
	}


}
