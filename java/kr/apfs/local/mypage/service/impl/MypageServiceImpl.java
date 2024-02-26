package kr.apfs.local.mypage.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.mypage.dao.MypageDao;
import kr.apfs.local.mypage.service.MypageService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @Class Name : MypageServiceImpl.java
 * @Description : MypageServiceImpl.Class
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

@Service("MypageService")
public class MypageServiceImpl implements MypageService {
	private static final Logger logger = LogManager.getLogger(MypageServiceImpl.class);

	@Resource(name = "MypageDao")
    protected MypageDao mypageDao;


	/**
     * 선택된 행의 값을 가지고 온다
     * @param param
     * @return
     * @throws Exception
     */
	@Override
	public Map<String, Object> selectMypage(Map<String, Object> param) throws Exception{
		return mypageDao.selectMypage(param);
	}

	@Override
	public List <Map<String, Object>> selectMypage2(Map<String, Object> param) throws Exception{
		return null;//visionpageDao.selectMypage(param);
	}

	/**
     * 인사말을 수정한다 온다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int updateMypage(Map<String, Object> param) throws Exception {
		return mypageDao.updateMypage(param);
	}

	/**
     * 중복 체크를 한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int selectMypageExist(Map<String, Object> param) throws Exception {
		return mypageDao.selectMypageExist(param);
	}

	/**
     * 값을 입력한다
     * @param param
     * @return int
     * @throws Exception
     */
	@Override
	public int insertMypage(Map<String, Object> param) throws Exception {
		return mypageDao.insertMypage(param);
	}

	//존재여부 체크
	
	@Override
	public Map<String, Object> selectExist(Map<String, Object> param)throws Exception {
		return mypageDao.selectExist(param);
	}

	@Override
	public Map<String, Object> mypageInfo(Map<String, Object> param)throws Exception {
		return mypageDao.mypageInfo(param);
	}

	@Override
	public Map<String, Object> selectMonths(Map<String, Object> param)throws Exception {
		return mypageDao.selectMonths(param);
	}

	@Override
	public List<Map<String, Object>> selectAreas(Map<String, Object> param)throws Exception {
		return mypageDao.selectAreas(param);
	}
	
	@Override
	public List<Map<String, Object>> selectItems(Map<String, Object> param)throws Exception {
		return mypageDao.selectItems(param);
	}

	@Override
	public List<Map<String, Object>> selectSosokCd(Map<String, Object> param)throws Exception {
		return mypageDao.selectSosokCd(param);
	}

	@Override
	public List<Map<String, Object>> selectProductCd(Map<String, Object> param)throws Exception {
		return mypageDao.selectProductCd(param);
	}

	@Override
	public List<Map<String, Object>> selectMyProduct(Map<String, Object> param)throws Exception {
		return mypageDao.selectMyProduct(param);
	}

	@Override
	public List<Map<String, Object>> selectMyEduHistory(Map<String, Object> param) throws Exception {
		return mypageDao.selectMyEduHistory(param);
	}

	@Override
	public List<Map<String, Object>> selectMyEduFuture(Map<String, Object> param)throws Exception {
		return mypageDao.selectMyEduFuture(param);
	}

	@Override
	public List<Map<String, Object>> selectMyAreas(Map<String, Object> param)	throws Exception {
		return mypageDao.selectMyAreas(param);
	}



}
