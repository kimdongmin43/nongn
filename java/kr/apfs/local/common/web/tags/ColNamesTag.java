package kr.apfs.local.common.web.tags;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.apfs.local.common.util.JsonUtil;



public class ColNamesTag extends HtmlTagSupport {

    private static final Log logger = LogFactory.getLog(ColNamesTag.class);

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private List<String> jarr = null;

    private String name ;
    public void setDesc(String dummy) {
        
    }
    public void setName(String name) {
        this.name = name;
    }
    
    public ColNamesTag() {
        super();

        jarr = new ArrayList<String>();
    }

    public void addItem(String json) {
        jarr.add(json);
    }

    public int doStartTag() throws JspException {

        return EVAL_BODY_INCLUDE;
    }

    public int doEndTag() throws JspException {
        StringBuffer sb = new StringBuffer();
        sb.append("<script type=\"text/javascript\">\n");
        sb.append(" var " + name + " = ");
        sb.append(JsonUtil.toJsonStr(jarr));
        sb.append(";\n");
        sb.append("</script>\n");
        
        try {
            
            
//            this.pageContext.getOut().write("columns:");
            this.pageContext.getOut().write(sb.toString());
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        } catch (Exception e) {
            throw new JspException("Could not write data " + e.toString());
        }
        release();
        return EVAL_PAGE;
    }
    public void release() {
        super.release();
        jarr =  new ArrayList<String>();
    }
}
