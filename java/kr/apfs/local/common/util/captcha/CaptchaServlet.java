package kr.apfs.local.common.util.captcha;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import nl.captcha.Captcha;
import nl.captcha.backgrounds.GradiatedBackgroundProducer;

public class CaptchaServlet extends HttpServlet {
	
private static final long serialVersionUID = 1L; 
private static final Log logger = LogFactory.getLog(CaptchaServlet.class);
    
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		try {
            Captcha captcha = new Captcha.Builder(150, 60)
                                    .addText()
                                    .addBackground(new GradiatedBackgroundProducer())
                                    .addNoise()
                                    .addBorder()
                                    .build();
 
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            response.setContentType("image/jpeg");
            CaptchaServletUtilOld.writeImage(response, captcha.getImage());
            request.getSession().setAttribute("captcha", captcha);
        }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        } catch (Exception e) {
        	logger.error("Exception error===", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }
	}
}