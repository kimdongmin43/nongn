/**
 * @Class Name : AttachFileDaoImpl.java
 * @Description : AttachFileDaoImpl.Class
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

package kr.apfs.local.file.dao;

import java.util.List;
import java.util.Map;

import kr.apfs.local.common.dao.AbstractDao;

import org.springframework.stereotype.Repository;

@Repository("AttachFileDao")
public class AttachFileDao extends AbstractDao {

	/**
     *
     * @param param
     * @return
     * @throws Exception
     */
    
	public List<Map<String, Object>> selectFileList(Map<String, Object> param) throws Exception{
		return selectList("AttachFile.selectAttachFileList", param);
	}

	/**
     * 값을 입력한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int insertFile(Map<String, Object> param) throws Exception{
		 return insert("AttachFile.insertAttachFile", param);
	}


	/**
     * 값을 수정한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int updateFile(Map<String, Object> param) throws Exception{
		return update("AttachFile.updateAttachFile", param);
	}


	/**
     * 값을 삭제한다
     * @param 	param
     * @return 	int
     * @throws 	Exception
     */
	public int deleteFile(Map<String, Object> param) throws Exception{
		update("AttachFile.deleteAttachFile", param);
		return delete("AttachFile.deleteAttachFile", param);
	}
}
