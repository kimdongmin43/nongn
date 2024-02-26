package kr.apfs.local.common.web.tags;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.apfs.local.common.util.LocaleUtil;
import kr.apfs.local.common.util.MessageUtil;
import kr.apfs.local.common.util.ObjUtil;



public class ColItemTag extends HtmlTagSupport {

    /**
     * 
     */
	private static final Log logger = LogFactory.getLog(ColItemTag.class);
    private static final long serialVersionUID = 1L;
    private String code;
    
    private String text;
    
    public void setDesc(String dummy) {
        
    }

    public void setCode(String code) {
        this.code = code;
    }
    

    public void setText(String text) {
        this.text = text;
    }


    public int doStartTag() throws JspException {

//        String test = TagUtils.getMessageWithParams(text, text, null, (HttpServletRequest)this.pageContext.getRequest());
        String msg = null;
        if (this.text == null) {
            try{
                msg = MessageUtil.getMessage("LABEL." + code, LocaleUtil.getSafeLocale((HttpServletRequest)this.pageContext.getRequest()));
            }catch (NullPointerException e) {
            	logger.error("NullPointerException error===", e);
            	msg = text;
            }
        } else {
            msg = text;
        }
    
        Object obj = getParent();
        if (obj instanceof ColNamesTag) {
            ((ColNamesTag) obj).addItem(ObjUtil.nvl(msg, "#" + this.code));
        }
        

        return SKIP_BODY;
    }
    
    public void release() {
        super.release();
        this.code = null;
        this.text = null;
    }
}
