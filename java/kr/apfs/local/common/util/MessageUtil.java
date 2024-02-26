package kr.apfs.local.common.util;

import java.io.IOException;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceResolvable;




public class MessageUtil {

    private final static Logger logger = LoggerFactory.getLogger(MessageUtil.class);
  
    private final static MessageSource messageSource = (MessageSource)ObjUtil.getBean("messageSource");
    
    /**
     * 해당 id의  메시지를 locale 처리하여  돌려 준다. 
     * @param id
     * @param obj
     * @param _req
     * @return
     */
    public static String getMessage(String id, Object[] objs, Locale locale) {   
    	try {
    	    return messageSource.getMessage(id, objs, locale);
    	}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	return "#" + id;
        }
    }  
    
    public static String getMessage(MessageSourceResolvable resolvable, Locale locale) {
    	try {
    		return messageSource.getMessage(resolvable, locale);
    	}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	return "";
        }
    }
    
    /**
     * 해당 id의  메시지를 locale 처리하여  돌려 준다. 
     * @param id
     * @param obj
     * @param _req
     * @return
     */
    public static String getMessage(String id, Object obj, Locale locale) {       
            return getMessage(id, new Object[] {obj}, locale);    
    }
  
    /**
     * 해당 id의  메시지를 locale 처리하여  돌려 준다. 
     * @param id
     * @param obj
     * @param _req
     * @return
     */
    public static String getMessage(String id,  Locale locale) {       
            return getMessage(id, null, locale);    
    }
    
    /**
     * Updated 메시지를 locale 처리하여 돌려 준다.
     * @param cnt
     * @param _req
     * @return
     */
    public static String getUpdatedMsg(int cnt, ExtHtttprequestParam _req) {
        return getMessage("msg.updated", ObjUtil.toArray(cnt),_req.getLocale());
    }
    
    /**
     * insert 메시지를 locale 처리하여 돌려 준다.
     * @param cnt
     * @param _req
     * @return
     */
    public static String getInsertMsg(int cnt, ExtHtttprequestParam _req) {
        return getMessage("msg.inserted", ObjUtil.toArray(cnt),_req.getLocale());
    }
    /**
     * deleted 메시지를 locale 처리하여 돌려 준다.
     * @param cnt
     * @param _req
     * @return
     */
    public static String getDeteleMsg(int cnt, ExtHtttprequestParam _req) {
        return getMessage("msg.deleted", ObjUtil.toArray(cnt),_req.getLocale());
    }
    /**
     * 저장되었습니다  메시지를 locale 처리하여 돌려 준다.
     * @param cnt
     * @param _req
     * @return
     */
    public static String getSavedMsg(int cnt, ExtHtttprequestParam _req) {
        return getMessage("msg.saved", ObjUtil.toArray(cnt),_req.getLocale());
    }    
    /**
     * 해당 id의 메시지를 locale 처리하여 돌려 준다.
     * @param id
     * @param _req
     * @return
     */
    public static String getMessage(String id,  ExtHtttprequestParam _req) {
        return getMessage(id, null, _req.getLocale());
    }
    
    /**
     * 해당 id의  메시지를 locale 처리하여  돌려 준다. 
     * @param id
     * @param obj
     * @param _req
     * @return
     */
    public static String getMessage(String id, Object obj, ExtHtttprequestParam _req) {       
            return getMessage(id, obj, _req.getLocale());    
    }
    
    /**
     * 
     * @param cnt
     * @param _req
     * @return
     */
    public static String getProcessFaildMsg(int cnt, ExtHtttprequestParam _req) {
        return getMessage("msg.processfail", ObjUtil.toArray(cnt),_req.getLocale());
    }
    
    /**
     * 중목메시지 출력
     * @param _req
     * @param obj
     * @return
     */
    public static String getDuplicatedMsg(Object obj,ExtHtttprequestParam _req) {
        return getMessage("msg.obj.duplicate",obj,_req.getLocale());
    }
    
    
    /**
     * 성공메시지
     * @param obj
     * @param _req
     * @return
     */
    public static String getProcessSuccessMsg(Object obj, ExtHtttprequestParam _req) {
        return getMessage("msg.process.success", obj,_req.getLocale());
    }

}
