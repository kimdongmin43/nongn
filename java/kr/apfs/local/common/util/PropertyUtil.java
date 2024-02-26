package kr.apfs.local.common.util;

import java.io.IOException;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class PropertyUtil
{
	private Properties  properties;
	private static final Log logger = LogFactory.getLog(PropertyUtil.class);
	
	static PropertyUtil pros;
	static 
	{
		pros = new PropertyUtil();		
	}
	
	private PropertyUtil()
	{
		try
		{
			properties = new Properties();
			
			properties.load(getClass().getResourceAsStream("/config/globals.properties"));
		}
		catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }catch(IOException e)
		{
			logger.error("IOException===", e);
			//e.printStackTrace();
			//System.out.println("[Check out the Java path]-common.properties can not read the file.");
		}
	}
	
	public static PropertyUtil getInstance()
	{
		return pros;
	}
    
	/**
     * Property 정보 Get
     * @param str : String
     * @return String
     */
	@SuppressWarnings("static-access")
	public static String getString(String str)
	{
		String ret="";
		try
		{
			ret = pros.getInstance().properties.getProperty(str);
		}
		catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	ret = str+" not find";
        }
		return ret;
	}
	
}