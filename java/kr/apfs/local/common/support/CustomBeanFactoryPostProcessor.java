package kr.apfs.local.common.support;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.config.BeanFactoryPostProcessor;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.web.context.WebApplicationContext;

/**
 * @Description :  test 시 tilesConfigurer 의 scope를 request를 변경해 주기 위한 클래스
 * @author 장태식
 * @since 2015. 6. 17.
 */
public class CustomBeanFactoryPostProcessor implements BeanFactoryPostProcessor {

	public CustomBeanFactoryPostProcessor() {
	}

	
    @Override
    public void postProcessBeanFactory(ConfigurableListableBeanFactory beanFactory) throws BeansException 
    {
        // test 시 tilesConfigurer 의 scope를 request를 변경해준다.
        BeanDefinition bd = beanFactory.getBeanDefinition("tilesConfigurer");
        bd.setScope(WebApplicationContext.SCOPE_REQUEST);
    }

}
