package kr.apfs.local.faq.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.apfs.local.faq.dao.FaqDao;
import kr.apfs.local.faq.service.FaqService;

/**
 * @Class Name : FaqServiceImpl.java
 * @Description : FaqServiceImpl.Class
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

@Service("FaqService")
public class FaqServiceImpl implements FaqService {
	private static final Logger logger = LogManager.getLogger(FaqServiceImpl.class);
	
	@Resource(name = "FaqDao")
    protected FaqDao faqDao;
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectFaqPageList(Map<String, Object> param) throws Exception{
		return faqDao.selectFaqPageList(param);
	}
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectFaqList(Map<String, Object> param) throws Exception{
		return faqDao.selectFaqList(param);
	}
	
	/**
     * 선택된 행의 값을 가지고 온다 
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectFaq(Map<String, Object> param) throws Exception{
		return faqDao.selectFaq(param);
	}
	
	/**
     * 중복여부를 검사한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	@Override
	public int selectFaqExist(Map<String, Object> param) throws Exception {
		return faqDao.selectFaqExist(param);
	}
	
	/**
     * 값을 입력한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int insertFaq(Map<String, Object> param) throws Exception{
		return faqDao.insertFaq(param);
	}
	
	/**
     * 값을 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int updateFaq(Map<String, Object> param) throws Exception{
		return faqDao.updateFaq(param);
	}
	
	/**
     * 값을 삭제한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */	
	public int deleteFaq(Map<String, Object> param) throws Exception{
		return faqDao.deleteFaq(param);
	}

	/**
     * faq 순서조정 정보를 수정한다 
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateFaqReorder(Map<String, Object> param) throws Exception{
		return faqDao.updateFaqReorder(param);
	}
	
	/**
     * 게시판 메인 출력용 게시물
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectLoadMainFaq(Map<String, Object> param) throws Exception{
		return faqDao.selectLoadMainFaq(param);
	}
}
