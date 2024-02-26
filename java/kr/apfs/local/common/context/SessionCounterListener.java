package kr.apfs.local.common.context;

import java.util.Enumeration;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.commons.logging.Log;					//	테스트
import org.apache.commons.logging.LogFactory;		//	테스트



public class SessionCounterListener implements HttpSessionListener {
private Log logger = LogFactory.getLog(SessionCounterListener.class);

static private int activeSessions;

   public static int getActiveSessions() {
        return activeSessions;
    }

   @Override
    public void sessionCreated(HttpSessionEvent arg0) {
        activeSessions++;
        ////System.out.println("Created!! activeSessions : " + activeSessions);
    }

   @Override
    public void sessionDestroyed(HttpSessionEvent arg0) {
        activeSessions--;
        ////System.out.println("Destoryed!! activeSessions : " + activeSessions);
    }
}
