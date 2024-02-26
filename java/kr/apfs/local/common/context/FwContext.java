package kr.apfs.local.common.context;

import javax.servlet.ServletContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class FwContext  {

    private final Log logger = LogFactory.getLog(FwContext.class);
    private ServletContext servletContext = null;

    private static FwContext _instance = new FwContext();

    private String CPATH = null;
    
    private FwContext() {

    }

    public static synchronized FwContext getInstance() {
        return _instance;
    }

    /**
     * @return Returns the servletContext.
     */
    public static final ServletContext getServletContext() {
        return _instance.servletContext;
    }

    /**
     * @param servletContext
     *            The servletContext to set.
     */
    protected void setServletContext(ServletContext ctx) {
        
        this.servletContext = ctx;
        logger.info("  >> Server is  [{} ] \n >> Document root is [{}]" + new String[] {ctx.getServerInfo(),ctx.getRealPath("/")} );
    }
    
    public static String getRealPath(String fileName) {
        return _instance.servletContext.getRealPath(fileName);
    }
    
    public static final String getCPATH() {
        return _instance.CPATH;
    }
    

}