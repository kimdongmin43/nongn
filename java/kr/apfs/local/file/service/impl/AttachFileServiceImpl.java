package kr.apfs.local.file.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.apfs.local.file.dao.AttachFileDao;
import kr.apfs.local.file.service.AttachFileService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.stereotype.Service;

/**
 * @Class Name : FileServiceImpl.java
 * @Description : FileServiceImpl.Class
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

@Service("AttachFileService")
public class AttachFileServiceImpl implements AttachFileService {
	private static final Logger logger = LogManager.getLogger(AttachFileServiceImpl.class);

	@Resource(name = "AttachFileDao")
    protected AttachFileDao fileDao;


	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectFileList(Map<String, Object> param) throws Exception{
		return fileDao.selectFileList(param);
	}

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertFile(Map<String, Object> param) throws Exception{
		return fileDao.insertFile(param);
	}

	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateFile(Map<String, Object> param) throws Exception{
		return fileDao.updateFile(param);
	}

	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteFile(Map<String, Object> param) throws Exception{
		return fileDao.deleteFile(param);
	}

}
