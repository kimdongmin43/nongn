package kr.apfs.local.scheduling.job;

import java.io.IOException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.CryptoUtil;
import kr.apfs.local.common.util.LmsSend;
import kr.apfs.local.common.util.MMSSend;
import kr.apfs.local.common.util.SmsSend;
import kr.apfs.local.common.util.SmsSendInterface;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.scheduling.service.UserAgreeService;

public class UserAgreeJob extends QuartzJobBean  {
	
	private static final Log logger = LogFactory.getLog(UserAgreeJob.class);
	private UserAgreeService userAgreeService;
	
	public UserAgreeService getUserAgreeService() {
		return userAgreeService;
	}
	
	public void setUserAgreeService(UserAgreeService userAgreeService) {
		this.userAgreeService = userAgreeService;
	}
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		
		try {
        	//System.out.println( "############# 스케쥴링 시작 #############");
        	/*Map<String, Object> param = new HashMap();
        	param.put("pday", "700");
        	String phone = "";
        	String message = "";
        	SmsSendInterface sms =  new LmsSend();
        	long result = 0;
        	
        	if("192.168.166.85".equals(CommonUtil.getHostIp())){
        		return;
        	}*/
        	
        	// 리스트 사람들 문자보내기
    		/*List<Map<String, Object>> list = userAgreeService.selectUserAgreeList(param); // 동의후 23개월(700일)인 사용자들
    		Map<String, Object> map = new HashMap();
    		if(list != null){
    			for(int i=0; i<list.size(); i++) {
    				map = list.get(i);
    				if(map.get("user_mobile") != null){
    					phone = CryptoUtil.AES_Decode((String)map.get("user_mobile"));
    				}
    				message = "[서울시 청년활동지원 온라인플랫폼 홈페이지 회원정보 재동의 안내]\n 본 메일을 수신하시는 회원께서는 재동의 대상에 해당되오니 아래 내용을 확인하시고 재동의하여 주시기 바랍니다.\n 1. 표준개인정보보호지침(안전행정부 2011.09)에 의거 2년을 주기로 재동의 절차를 거쳐 동의한 경우에만 회원자격을 유지할 수 있습니다.\n 2. 이에 따라, 회원정보 재동의를 시행하고 있으며, 재동의 하지 않을 경우 (2년 도래일 익일) 자동탈퇴 처리됩니다.\n 3. youthhope.seoul.go.kr 로그인 후 재동의 대상 회원인 경우 동의해 주시면 됩니다.";
    				result = sms.sendMessage(StringUtil.replace(StringUtil.nvl(phone),"-",""), message, "0221336588");
    			}
    			if(result < 1){
    				//System.out.println(map.get("user_mobile")+"님의 핸드폰으로 문자메시지 전송이 실패하였습니다.");
    			}
    		}
        	
        	//System.out.println( "############# 스케쥴링 끝  #############");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//System.out.println( "############# 스케쥴링 에러 !! 시작 #############");
			e.printStackTrace();
			//System.out.println( "############# 스케쥴링 에러 !! 끝  #############");
		}
		
		try {
        	//System.out.println( "############# 스케쥴링 시작 #############");
        	Map<String, Object> param = new HashMap();
        	param.put("pday", "335");
        	String phone = "";
        	String message = "";
        	SmsSendInterface sms =  new LmsSend();
        	long result = 0;
        	
        	if("192.168.166.85".equals(CommonUtil.getHostIp())){
        		return;
        	}*/
        	
        	// 리스트 사람들 문자보내기
    		/*List<Map<String, Object>> list2 = userAgreeService.selectUserLoginList(param); //  11개월(335일) 동안 로그인이력이 없는 사용자들
    		Map<String, Object> map2 = new HashMap();
    		if(list2 != null){
    			for(int i=0; i<list2.size(); i++) {
    				map2 = list2.get(i);
    				if(map2.get("user_mobile") != null){
    					phone = CryptoUtil.AES_Decode((String)map2.get("user_mobile"));
    				}
    				message = "[서울시 청년활동지원 온라인플랫폼 홈페이지 회원 탈퇴 및 개인정보 삭제에 대한 안내]\n 본 메일을 수신하시는 회원께서는 자동탈퇴 대상에 해당되오니 하래 내용을 확인하시고 로그인 하시기 바랍니다.\n 1. 자동탈퇴 처리되면 사용하고 계시는 아이디는 재사용 및 복구가 불가능합니다.\n 2. 자동탈퇴 및 삭제 예정일 : 30일 이후\n 3. 삭제대상 개인정보 : 회원가입 시 입력한 모든 정보 : 이름, 아이디, 비밀번호, 자택전화, 휴대전화, 법정생년월일, 이메일 등 단, 청년수당 신청자 정보, 게시물은 그대로 남아있습니다.";
    				result = sms.sendMessage(StringUtil.replace(StringUtil.nvl(phone),"-",""), message, "0221336588");
    			}
    			if(result < 1){
    				//System.out.println(map2.get("user_mobile")+"님의 핸드폰으로 문자메시지 전송이 실패하였습니다.");
    			}
    		}*/
        	
        	//System.out.println( "############# 스케쥴링 끝  #############");
		}catch (NullPointerException e) {
			//System.out.println( "############# 스케쥴링 에러 !! 시작 #############");
        	logger.error("NullPointerException error===", e);
			//System.out.println( "############# 스케쥴링 에러 !! 끝  #############");
        }
        	
	}
}