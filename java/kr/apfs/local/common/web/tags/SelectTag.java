package kr.apfs.local.common.web.tags;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.LocaleUtil;
import kr.apfs.local.common.util.StringUtil;







/**
 * @Class Name : SelectTag.java
 * @Description : 클래스 설명을 기술합니다.
 * @author SangJoon Kim
 * @since 2011. 8. 3.
 * @version 1.0
 * @see
 *
 * @Modification Information
 *
 *               <pre>
 *    수정일         수정자              수정내용
 *  ===========    =========    ===========================
 *  2011. 8. 3.      SangJoon Kim      최초 생성
 * </pre>
 */

/**
 * @author Administrator
 *
 */
public class SelectTag extends HtmlTagSupport {

    private static final Log logger = LogFactory.getLog(SelectTag.class);
    private static final long serialVersionUID = 4867576298804029320L;

    private String titleCode = null;
    private int size = 1;
    private boolean multiple = false;
    private boolean showTitle = false;
    @SuppressWarnings("unchecked")
    private List<Object> optionList = null;
    private String selected = null;
    private String dispStyle = null;
//    private String onChange = null;
    private String option = null;
    private String codeGroup = null;
    private String cls	 = null;
    private String style = null;
    private String exclude = null;
    private String include = null;
    private String required = null;
    private int width = 0;
    private boolean isNumber = false;

    public SelectTag() {
        init();
    }

    private void init() {
        this.size = 1;
        this.multiple = false;
        this.selected = null;
        this.cls	 = null;
        this.codeGroup = null;
        this.dispStyle = null;
//        this.optionList = null;
        this.option = null;
        this.style = null;
        this.include = null;
        this.required = null;
        this.isNumber = false;
    }

    public void release() {
        super.release();
        init();
    }

    public void setDispStyle(String dispStyle) {
        this.dispStyle = dispStyle;
    }
    public void setOption(String option) {
        this.option = option;
    }
    public void setItems(Object obj) {

        if(obj instanceof List) {
            this.optionList = (List) obj;
        }
    }

    public String getTitleCode() {
        return titleCode;
    }

    public void setTitleCode(String title) {
        this.titleCode = title;
        this.showTitle = true;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public void setMultiple(boolean multiple) {
        this.multiple = multiple;
    }

    public void setSelected(String selected) {
        this.selected = selected;
    }

    public void setCls(String cls) {
		this.cls = cls;
	}

    @SuppressWarnings("unchecked")
    public void setSource(List paramObject) {
        optionList = paramObject;
    }

    public void setCodeGroup(String codeGroup) {
        this.codeGroup = codeGroup;

    }

    public boolean isShowTitle() {
        return showTitle;
    }

    public void setShowTitle(boolean showTitle) {
        this.showTitle = showTitle;
    }

    public void setStyle(String style) {
		this.style = style;
	}

    public void setExclude(String exclude) {
		this.exclude = exclude;
	}


	public void setInclude(String include) {
		this.include = include;
	}

	public boolean getIsNumber() {
		return this.isNumber;
	}

	public void setIsNumber(boolean isNumber) {
		this.isNumber = isNumber;
	}

	public int getWidth() {
		return this.width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	@SuppressWarnings("unchecked")
    private String render() throws Exception {

        // master코드나 optionMap이 있으면 기존 option List 무시
        if (this.codeGroup != null) {
            optionList = (List) CommonUtil.getCodeList(this.codeGroup);
        }
        StringBuffer sb = new StringBuffer();
        StringBuffer sbt = new StringBuffer();

        if (this.optionList != null) {
            Locale locale = LocaleUtil.getSafeLocale((HttpServletRequest)this.pageContext.getRequest());
            List<KV> nList = new ArrayList<KV>();

            for (Object option : optionList) {
                // Object option = optionList.get(i);
                String opValue = "";
                String opText = "";
                 if (option instanceof Map) {
                    opValue = (String) (((Map) option).get("codeId"));
                    opText =  (String) (((Map) option).get("codeNm"));
                    nList.add(new KV(opValue, opText, 0));
                }

            }
            int optionCnt =0 ;
            if (this.codeGroup != null) {
            	Collections.sort(nList, new KVCompare());
            }
            for (KV kv : nList) {
            	if (exclude != null && exclude.indexOf(kv.getKey()) >   -1) continue;
            	if (include != null && !"".equals(include) && include.indexOf(kv.getKey()) ==  -1) continue;
            	optionCnt++;
                sb.append("<option value='" + kv.getKey() + "' ");
                if (this.selected != null) {
                    if (selected.equals(kv.getKey()))
                        sb.append(" selected='selected' ");
                        //sb.append(" selected ");
                }
                sb.append(">");
                if(isNumber)  sb.append(StringUtil.amountFormater((String)kv.getText()));
                else sb.append(super.htmlEscape(kv.getText()));
                sb.append("</option>");
            }
            int maxLen = 0;
            for (KV kv : nList) {
            	if(maxLen < kv.getText().length()) maxLen = kv.getText().length();
            }
            if(this.width == 0) width = (maxLen*10)+20;
            sbt.append(getSelectTag(this.width));
	        if ( this.titleCode != null && !this.titleCode.equals("")) {
	        	String msg = this.titleCode;
	        	sbt.append("<option value=''>-" + msg + "-</option>");
	        }
            sbt.append(sb.toString());
        }else{
        	sbt.append(getSelectTag(this.width));
       	    if ( this.titleCode != null) {
	        	String msg = this.titleCode;
	        	sbt.append("<option value=''>-" + msg + "-</option>");
	        }
        }

        sbt.append("</select>");
        if( isNumber){
        	sbt.append("</div>");
        }
        return sbt.toString();
    }

    public String getSelectTag(int width) {
        StringBuffer sb = new StringBuffer();

        selectHtmlTag(sb, width);

        if (this.cls != null) {
            sb.append(" class='");
            sb.append(this.cls);
            if(isNumber) sb.append(" select_num");
            sb.append("'");
        }

        sb.append(" size='");
        sb.append("" + this.size);
        sb.append("' ");

        sb.append(" style='");
        if (this.style !=null) {
        	sb.append("" + this.style+",");
        }
        if(isNumber) sb.append(" width:"+(width+20)+"px");
        sb.append("' ");

        if (this.multiple) {
            sb.append(" multiple");
        }

        if ("true".equals(this.required)) {
            sb.append(" required ");
        }

        sb.append(">");

        return sb.toString();
    }

	protected void selectHtmlTag(StringBuffer sb, int width){

        if(isNumber) sb.append("<div class=\"select_div\"  id=\""+name+"_number_div\"  style=\"width:"+width+"px\">");
        sb.append("<");
        sb.append("select");
        if(this.name != null) {
            sb.append(" name=\"");
            sb.append(this.name);
            sb.append("\"");
        }
        if (this.id != null) {
            sb.append(" id=\"");
            sb.append(this.id);
            sb.append("\"");
        }
        if (this.style != null) {
            sb.append(" style=\"");
            sb.append(this.style);
            sb.append("\"");
        }

        if (this.disabled)
            sb.append(" disabled='disabled' ");

        if (this.onChange != null) {
            sb.append(" onChange=\"");
            sb.append(this.onChange);
            sb.append("\"");
        }

        for (String attrName : tagAttributes.keySet()) {
            sb.append(" ");
            sb.append(attrName);
            sb.append("=\"");
            sb.append(tagAttributes.get(attrName));
            sb.append("\"");
        }
    }

    public int doEndTag() throws JspException {
        try {
            this.pageContext.getOut().write(render());
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        	throw new JspException("Could not write data " + e.toString());
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw new JspException("Could not write data " + e.toString());
        } catch (Exception e) {
            //e.printStackTrace();
        	logger.error("error===", e);
            throw new JspException("Could not write data " + e.toString());
        }
        return EVAL_PAGE;
    }

    public class KV {
        private String key = null;
        private String text = null;
        private int seq = 0;

        public KV(String key, String text, int seq) {
            this.key = key;
            this.text = text;
            this.seq = seq ;
        }
        public String getKey() {
            return key;
        }

        public String getText() {
            return text;
        }

        public int getSeq() {
            return seq;
        }

    }

    class KVCompare implements Comparator {

        public KVCompare() {
        }

        public int compare(Object arg1, Object arg2) {
            KV a = (KV) arg1;
            KV b = (KV) arg2;
            if(a.getSeq() == b.getSeq()) {
                if (a.getText().compareTo(b.getText()) < 0) {
                    return 0;
                } else {
                    return 1;
                }
            } else if ( a.getSeq() > b.getSeq() ){
                return 1;
            }
            return 0;

        }

    }
}
