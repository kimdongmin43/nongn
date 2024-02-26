package kr.apfs.local.common.support;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * @Description : Spring의 Application Context 를 가져오기위한 클래스
 * @author 장태식
 * @since 2015. 6. 17.
 */
public class ApplicationContextProvider implements ApplicationContextAware {

    private static ApplicationContext applicationContext = null;


	public ApplicationContextProvider() {
	}

	@Override
	public void setApplicationContext(ApplicationContext ctx) throws BeansException {
		ApplicationContextProvider.applicationContext = ctx;
	}
	
	public static ApplicationContext getApplicationContext() {
		return applicationContext;
	}


}
