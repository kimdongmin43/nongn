package kr.apfs.local.scheduling.job;

import kr.apfs.local.scheduling.service.UserAgreeService;
import kr.apfs.local.scheduling.service.UserDropService;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class UserDropJob extends QuartzJobBean  {

	private UserDropService userDropService;

	private UserAgreeService userAgreeService;

	public UserDropService getUserDropService() {
		return userDropService;
	}

	public void setUserDropService(UserDropService userDropService) {
		this.userDropService = userDropService;
	}

	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {

        	//System.out.println( "############# 스케쥴링 시작 #############");


        	//System.out.println( "############# 스케쥴링 끝  #############");
	}
}