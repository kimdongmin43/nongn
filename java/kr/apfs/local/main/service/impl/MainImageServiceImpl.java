package kr.apfs.local.main.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.apfs.local.main.dao.MainImageDao;
import kr.apfs.local.main.service.MainImageService;

/**
 * @Class Name : MainImageServiceImpl.java
 * @Description : MainImageServiceImpl.Class
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

@Service("MainImageService")
public class MainImageServiceImpl implements MainImageService {
	private static final Logger logger = LogManager.getLogger(MainImageServiceImpl.class);

	@Resource(name = "MainImageDao")
    protected MainImageDao mainImageDao;

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectMainImageList(Map<String, Object> param) throws Exception{
		return mainImageDao.selectMainImageList(param);
	}

	/**
     * 리스트를 복사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int copyMainImageList(Map<String, Object> param) throws Exception{
		return mainImageDao.copyMainImageList(param);
	}

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertMainImage(Map<String, Object> param) throws Exception{
		return mainImageDao.insertMainImage(param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateMainImage(Map<String, Object> param) throws Exception{
		return mainImageDao.updateMainImage(param);
	}

	/**
     * 순서 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int saveMainImageSort(Map<String, Object> param) throws Exception{
		return mainImageDao.saveMainImageSort(param);
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteMainImage(Map<String, Object> param) throws Exception{
		return mainImageDao.deleteMainImage(param);
	}

}
