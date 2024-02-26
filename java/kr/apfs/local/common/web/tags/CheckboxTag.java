package kr.apfs.local.common.web.tags;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.DynamicAttributes;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.taglibs.standard.tag.common.core.OutSupport;
import org.springframework.web.util.HtmlUtils;

import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.LocaleUtil;
import kr.apfs.local.common.util.ObjUtil;


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

public class CheckboxTag extends OutSupport implements DynamicAttributes {

	/**
     *
     */
	private static final long serialVersionUID = 1L;

	private static final Log logger = LogFactory.getLog(CheckboxTag.class);

	@SuppressWarnings("unchecked")
	private List<Object> optionList = null;
	private Object curValue = null;
	private String onChange = null;
	private String option = null;
	private String seperator = null;
	private String connector = null;
	private String checked = null;
	private String id = null;
	private String name = null;
	private boolean useAll = false;
	private boolean dspCode = false;
	private boolean label	= false;
	private String cls	 = null;
    private String exclude = null;
    private String include = null;

	protected Map<String, Object> tagAttributes = new HashMap<String, Object>();

	private String codeGroup = null;

	public CheckboxTag() {
		init();
	}

	private void init() {
		this.curValue = null;
		this.onChange = null;
		this.codeGroup = null;
		this.optionList = null;
		this.option = null;
		this.seperator = null;
		this.connector = null;
		this.id = null;
		this.checked = null;
		this.useAll = false;
		this.dspCode = false;
		this.label = false;
		this.cls = null;
        this.include = null;
        this.exclude = null;
	}

	public void release() {
		super.release();
		init();
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setDynamicAttribute(String uri, String localName, Object value)
			throws JspException {
		tagAttributes.put(localName, value);
	}

	public void setOption(String option) {
		this.option = option;
	}

	public void setUseAll(boolean useAll) {
		this.useAll = useAll;
	}

	public void setDspCode(boolean dspCode) {
		this.dspCode = dspCode;
	}

	/**
	 * @param connector
	 *            the connector to set
	 */
	public void setConnector(String connector) {
		this.connector = connector;
	}

	/**
	 * @param seperator
	 *            the seperator to set
	 */
	public void setSeperator(String seperator) {
		this.seperator = seperator;
	}

	public void setCurValue(Object curValue) {
		this.curValue = curValue;
	}

	public void setOnchange(String onChange) {
		this.onChange = onChange;
	}

	public void setCodeGroup(String codeGroup) {
		this.codeGroup = codeGroup;

	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

	public void setCls(String cls) {
		this.cls = cls;
	}

	/**
	 * @param label the label to set
	 */
	public void setLabel(boolean label) {
		this.label = label;
	}


    public void setExclude(String exclude) {
		this.exclude = exclude;
	}


	public void setInclude(String include) {
		this.include = include;
	}

    public void setSource(List paramObject) {
        optionList = paramObject;
    }

	public int doStartTag() throws JspException {
		StringBuffer sb = new StringBuffer();

		try {
			// master코드나 optionMap이 있으면 기존 option List 무시
			if (this.codeGroup != null) {
				optionList = (List) CommonUtil.getCodeList(this.codeGroup);
			}

			if (this.optionList != null) {
				Locale locale = LocaleUtil
						.getSafeLocale((HttpServletRequest) this.pageContext
								.getRequest());
				List<KV> nList = new ArrayList<KV>();

				for (Object option : optionList) {

					// Object option = optionList.get(i);
					String opValue = "";
					String opText = "";
					 if (option instanceof Map) {
						opValue = (String) (((Map) option).get("codeId"));
						opText = (String) (((Map) option).get("codeNm"));

						nList.add(new KV(opValue, opText, 0));
					}
				}

				Collections.sort(nList, new KVCompare());
				String tConnector = ObjUtil.nvl(connector, " : ");
				if (useAll) {
					sb.append("<LABEL> Select all : <input type='checkbox'   id='srchValAll'   /> &gt;&gt; </LABEL> &nbsp; &nbsp;");
				}

				for (KV kv : nList) {
	            	if (exclude != null && exclude.indexOf(kv.getKey()) >   -1) continue;
	            	if (include != null && !"".equals(include) && include.indexOf(kv.getKey()) ==  -1) continue;


					if(label){
						sb.append("<label class=\"checkbox-inline\">");
						//sb.append("<LABEL title='" + kv.getText() + "' class='checkbox-inline m-r-10' > ");
					}
					startOneTag(sb);
					sb.append(" value='" + kv.getKey() + "' ");
					if ("checked".equals(this.checked)) {
						sb.append(" checked='checked' ");
					} else if (this.curValue != null) {
						if (curValue instanceof String) {
							if (((String)curValue).indexOf(kv.getKey())>-1)
								sb.append(" checked='checked' ");
						} else if (curValue instanceof Collection) {
							if (((Collection) curValue).contains(kv.getKey())) {
								sb.append(" checked='checked' ");
							}
						} else if (curValue instanceof Object[]) {
							if (ArrayUtils.contains((Object[]) curValue,
									kv.getKey())) {
								sb.append(" checked='checked' ");
							}
						}
					}
					if (dspCode) {
						sb.append(" title='"+htmlEscape(kv.getText())+"' ");
					}
					sb.append(" />");
					//sb.append(tConnector);
					if (dspCode) {
						sb.append(htmlEscape(kv.getKey()));
					} else {
						if (this.cls != null) {
//		                    sb.append(" <span class='");
//		                    sb.append(this.cls);
//		                    sb.append("'>");
		                    sb.append(htmlEscape(kv.getText()));
//		                    sb.append(" </span>");
		                }else{
		                	sb.append(htmlEscape(kv.getText()));
		                }
					}
					if(label){
						sb.append("</LABEL>");
					}

					if (this.seperator != null) {
						sb.append(this.seperator);
					}
					sb.append(" ");
				}
				if (this.seperator != null && sb.length() > 0) {
					sb.delete(sb.length() - this.seperator.length(),
							sb.length());
				}

			}

			this.pageContext.getOut().write(sb.toString());
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        	throw new JspException("Could not write data " + e.toString());
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw new JspException("Could not write data " + e.toString());
        } catch (Exception e) {
			logger.error(ExceptionUtils.getFullStackTrace(e));
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
			this.seq = seq;
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

	protected void startOneTag(StringBuffer sb) throws JspException {
		boolean hasClass = false;
		//sb.append("<LABEL><input type=\"checkbox\" ");
		sb.append("<input type='checkbox' ");

		if (this.name != null) {
			sb.append(" name='");
			sb.append(this.name);
			sb.append("'");
		}
		if (this.id != null) {
			sb.append(" id='");
			sb.append(this.id);
			sb.append("'");
		}

		if (this.cls != null) {
            sb.append(" class='");
            sb.append(this.cls);
            sb.append("'");
        }

		for (String attrName : tagAttributes.keySet()) {
			sb.append(" ");
			sb.append(attrName);
			sb.append("='");
			sb.append(tagAttributes.get(attrName));
			if (useAll && "class".equals(attrName)) {
				hasClass = true;

				sb.append(" select_one");
			}
			sb.append("'");
		}
		if (useAll && !hasClass) {
			sb.append(" class='select_one' ");
		}
		if (this.onChange != null) {
			sb.append(" onChange='");
			sb.append(this.onChange);
			sb.append("'");
		}

	}

	/**
	 * Html Escape 처리
	 *
	 * @param msg
	 * @return
	 */
	protected String htmlEscape(String msg) {
		return HtmlUtils.htmlEscape(msg);
	}

	class KVCompare implements Comparator {

		public KVCompare() {
		}

		public int compare(Object arg1, Object arg2) {
			KV a = (KV) arg1;
			KV b = (KV) arg2;
			if (a.getSeq() == b.getSeq()) {
				if (a.getText().compareTo(b.getText()) < 0) {
					return 0;
				} else {
					return 1;
				}
			} else if (a.getSeq() > b.getSeq()) {
				return 1;
			}
			return 0;

		}

	}
}
