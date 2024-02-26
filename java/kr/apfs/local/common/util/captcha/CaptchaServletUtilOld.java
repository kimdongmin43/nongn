package kr.apfs.local.common.util.captcha;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import kr.apfs.local.common.util.ConfigUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public final class CaptchaServletUtilOld {
	
	private static final Log logger = LogFactory.getLog(CaptchaServletUtilOld.class);
	
	public static void writeImage(HttpServletResponse response, BufferedImage bi) {
	        
	        response.setHeader("Cache-Control", "private,no-cache,no-store");
	        response.setContentType("image/png");
	         
	        try {
	            writeImage(response.getOutputStream(), bi);
	        } catch (IOException e) {
	        	//e.printStackTrace();
	        	logger.error("error===", e);
	        }
	    }
	 
	    public static void writeImage(OutputStream os, BufferedImage bi) {
	         
	        try {
	            ImageIO.write(bi, "png", os);
	            os.close();
	        } catch (IOException e) {
	            //e.printStackTrace();
	        	logger.error("error===", e);
	        }
	    }
} 