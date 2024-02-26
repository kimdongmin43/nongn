package kr.apfs.local.common.web.tags;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.tags.RequestContextAwareTag;
import org.springframework.web.util.ExpressionEvaluationUtils;
import org.springframework.web.util.JavaScriptUtils;

import kr.apfs.local.common.util.LocaleUtil;
import kr.apfs.local.common.util.MessageUtil;







public class MessageTag extends RequestContextAwareTag  {

    /**
     * 
     */
    private static final long serialVersionUID = -687755899636921977L;
    
//    LocaleResolver localeResolver = (LocaleResolver) ObjUtils.getBean("localeResolver");
    private final static Log logger = LogFactory.getLog(MessageTag.class);
    private String _code;
    private String _default = "";
    private String escapeJS_; // stores EL-based property
    private String[] params;
    
    public MessageTag() {
        super();
        init();
    }
    private void init() {
        _code = null;
        _default = null;
        escapeJS_ = null;
        params = null;
    }
    
    public void release() {
        super.release();
    }
    
    public void setDesc(String dummy) {
        
    }
    public void setCode(String code) {
        this._code = code;
    }

    public void setParam(String param) {
        this.params = param.split(";");
    }

    public void setDefault(String defaultStr) {
        this._default = defaultStr;
    }

    public void setEscapeJS(String escapeJS_) {
        this.escapeJS_ = escapeJS_;
    }

    public int doStartTagInternal() throws JspException {


        try {
            JspWriter out = pageContext.getOut();
            String msg = null;
            if ( params != null && params.length > 0 ) {
//                msg = GResourceStore.getMessage(_code,params,LocaleUtils.getSafeLocale((HttpServletRequest)this.pageContext.getRequest()));
                msg = MessageUtil.getMessage(_code, params, LocaleUtil.getSafeLocale((HttpServletRequest)this.pageContext.getRequest()));
            } else {
                msg = MessageUtil.getMessage(_code, LocaleUtil.getSafeLocale((HttpServletRequest)this.pageContext.getRequest())); 
            }
            
            boolean escapeJS = ExpressionEvaluationUtils.evaluateBoolean(
                        "escapeJS", escapeJS_, pageContext);

            if (escapeJS) {
                msg = JavaScriptUtils.javaScriptEscape(msg);
//                } else {
//                    msg = HtmlUtils.htmlEscape(msg);
            }
            

            out.print(msg);
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
        return EVAL_PAGE;
    }
    
}
