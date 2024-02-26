package kr.apfs.local.scheduling.service;

import java.util.List;
import java.util.Map;

public interface UserDropService {
	
	public void userAutoDropOut() throws Exception;
	
	public void userAutoDropOut2(Map<String, Object> param) throws Exception;

}
