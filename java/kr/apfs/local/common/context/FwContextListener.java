package kr.apfs.local.common.context;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class FwContextListener implements ServletContextListener {

    private final Log logger = LogFactory.getLog(FwContextListener.class);
    /**
     * Initialize the root web application context.
     */
    public void contextInitialized(ServletContextEvent event) {
        logger.info(">>>>> [ {} ]  Start Initialize " + this.getClass() );
//        DocRecommendation docReco = new DocRecommendation();
//        docReco.init();
//        FwContext.getInstance().setServletContext(event.getServletContext());
        logger.info("<<<<< [ {} ]  Initialized..." + this.getClass() );
    }

    /**
     * Close the root web application context.
     */
    public void contextDestroyed(ServletContextEvent event) {

        logger.info( "{} Destroyed..." + this.getClass() );
    }
}