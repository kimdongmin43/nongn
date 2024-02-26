package kr.apfs.local.common.web.tags;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspTagException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.apfs.local.common.model.NavigatorInfo;
import kr.apfs.local.common.util.ObjUtil;







/**
 * @Class Name : PageNavigationTag.java
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

public class PageNavigationTag extends HtmlTagSupport {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private static final Log logger = LogFactory.getLog(PageNavigationTag.class);
    private static final String baseForm = "_baseForm";

    private String form, target, action, method;

    private String prevImage, prev2Image, nextImage, next2Image;
    private int nPageNo, nPageSize, nScreenSize, nTotalCnt, nTotalPage,
            nPBlockIndex, nPBlockIdxCount;
    private  String CPATH = "";
//    private StringBuffer output;
    
    private boolean popupYn;

    public PageNavigationTag() {

        init();
    }
    
    private void init() {
        this.form = null;
        this.target = null;
        this.action = null;
        this.method = null;

        this.prevImage = null;
        /**
         * 이전 screen
         */
        this.prev2Image = null;
        this.nextImage = null;
        /**
         *  다음 screen
         */
        this.next2Image = null;

        this.nPageNo= 0;
        this.nPageSize = 0;
        this.nScreenSize = 0;
        this.nTotalCnt = 0;
        this.nTotalPage = 0;
        this.nPBlockIndex = 0;
        this.nPBlockIdxCount = 0;
        this.target = null;
        this.action = null;
        this.method = null;
        
        this.popupYn = false;
       
    }
    
    public void release() {
        super.release();
        init();
    }


    
    public void setNavigator(NavigatorInfo navigator) {
        this.nPageNo = navigator.getPageNo();
        this.nScreenSize = navigator.getScreenSize();
        this.nTotalCnt = navigator.getTotalCnt();
        this.nPageSize = navigator.getPageSize();
    }

    public void setForm(String form) {
        this.form = form;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public void setMethod(String method) {
        this.method = method;
    }
    
    public void setPopupYn(boolean popupYn) {
    	this.popupYn = popupYn;
    }

    /**
     * 초기값 세팅
     */
    public void setProc() {
        if (ObjUtil.isEmpty(form)) {
            form = baseForm;
        }

        if (nPageSize < 1) {
            nPageSize = NavigatorInfo.DEFAULT_PAGE_SIZE;
        }
        if (nScreenSize < 1) {
            nScreenSize = NavigatorInfo.DEFAULT_SCREEN_SIZE;
        }

    }

    /**
     * 기본 javascript 출력 처리
     */
    public void baseScript(StringBuffer output) {
        output.append("<script type='text/javascript'> \n");
        output.append("function miv_goPage(pno) { \n");
        if (action != null && !action.trim().equals("")) {
            output.append(" document." + form + ".action = '" + action
                    + "'; \n");
        }
        if (target != null && !target.trim().equals("")) {
            output.append(" document." + form + ".target = '" + target
                    + "'; \n");
        }
        if (method != null && !method.trim().equals("")) {
            output.append(" document." + form + ".method = '" + method
                    + "'; \n");
        }
        output.append(" document." + form + "." + NavigatorInfo.MIV_PAGE
                + ".value=pno; \n");
        output.append(" document." + form + ".submit(); \n");
        output.append("} \n");
        output.append("function miv_changePageSize(psize) { \n");
        output.append(" document." + form + "." + NavigatorInfo.MIV_PAGESIZE
                + ".value=psize; \n");
        output.append(" document." + form + ".submit(); \n");
        output.append("} \n");
        output.append("</script>");
    }

    /**
     * 관리자
     */
    public void skinProcA() {
        String prefix = "<img src=\"" + CPATH + "/css/cm/images/";
        prevImage = prefix + "btn-prev.gif\" alt=\"Prev \" />";// ConfigUtil.getString(CONFIG_DOMAIN
                                                                                              // +skin
                                                                                              // +
                                                                                              // ".prev");
        prev2Image =prefix + "btn-prevpage.gif\" alt=\"Prev Screen\" />";// ConfigUtil.getString(CONFIG_DOMAIN
                                                                                                     // +skin
                                                                                                     // +
                                                                                                     // ".prev2");
        nextImage = prefix + "btn-next.gif\" alt=\"Next\" />";// ConfigUtil.getString(CONFIG_DOMAIN
                                                                                              // +skin
                                                                                              // +
                                                                                              // ".next");
        next2Image =prefix + "btn-nextpage.gif\" alt=\"Next Screen\" />";// ConfigUtil.getString(CONFIG_DOMAIN
                                                                                                     // +skin
                                                                                                     // +
                                                                                                     // ".next2");
    }
    


    /**
     * 페이지 계산 처리
     */
    public void pageProc() {

        this.nTotalPage = this.nTotalCnt / this.nPageSize;
        if (this.nTotalCnt % this.nPageSize != 0) {
            this.nTotalPage++;
        }
        this.nPBlockIndex = (int) (this.nPageNo / this.nScreenSize);
        if (this.nPageNo % this.nScreenSize != 0) {
            this.nPBlockIndex++;
        }
        this.nPBlockIdxCount = (int) (this.nTotalPage / this.nScreenSize);
        if (this.nTotalPage % this.nScreenSize != 0) {
            this.nPBlockIdxCount++;
        }
    }

    /**
     * 페이징 관련 html 출력 start 단
     */
    public void writeStartProc(StringBuffer output) {

        if (form.equals(baseForm)) {
            output.append("<form name='" + form + "'>");
        }
        output.append("<input type='hidden' name='" + NavigatorInfo.MIV_PAGE
                + "' value=\"\"/> \n");
        output.append("<input type='hidden' name='"
                + NavigatorInfo.MIV_PAGESIZE + "' value=\"" + this.nPageSize
                + "\"/> \n");

    }

    /**
     * 관리자 페이징 관련 html 출력 end 단
     */
    public void writeEndProcA(StringBuffer output) {
        // form end
        if (form.equals(baseForm)) {
            output.append("</form>");
        }
        //output.append("<div class=\"pagingArea\"><div class=\"totalCount\">TOTAL : <strong>" + this.nTotalCnt + "</strong> records</div>\n");
        output.append("<div class=\"text-center\"><ul class=\"pagination pagination-sm m-t-0 m-b-10\">");
        if (this.nTotalCnt > 0 && this.nTotalPage > 0) {
            // 처음으로
            //output.append("<a href=\"javascript:miv_goPage('1')\" >");
            //output.append(prev2Image);
            //output.append("</a>\n");
            // 이전 10
            int p_10 = ((this.nPageNo - 11) / 10) * 10 + 1;
            if (this.nPageNo > 10) {
            	output.append("<li ><a href=\"javascript:miv_goPage('" + (p_10) + "')\">≪</a></li>");
            } else {
                output.append("<li class=\"disabled\" ><a href=\"#none\">≪</a></li>\n");
            }
            // 중간 페이지
            int nStart = (this.nPBlockIndex - 1) * this.nScreenSize + 1;
            int nFinish = Math.min(this.nPBlockIndex * this.nScreenSize, this.nTotalPage);
            for (int i = nStart; i <= nFinish; i++) {
                if (i == this.nPageNo) {
                    output.append("<li class=\"active\"><a href=\"#none\">" + i + "</a></li>");
                } else {
                	output.append("<li><a href=\"javascript:miv_goPage('" + i + "')\">" + i + "</a></li>\n");
                }
            }
          
            // 다음 10
            int n_10 = ((this.nPageNo + 9) / 10) * 10 + 1;

            if (n_10 <= this.nTotalPage) {
            	 output.append("<li><a href=\"javascript:miv_goPage('" + (n_10)+ "')\">≫</a></li>");
            } else {
                output.append("<li class=\"disabled\"><a href=\"#none\">≫</a></li>\n");
            }

            // 마지막으로
//            output.append("<a href=\"javascript:miv_goPage('" + (nTotalPage)+ "')\" class='txt_last'>");
//            output.append(next2Image);
//            output.append("</a>\n");
            
//            if(!popupYn){
//            	output.append("<select style=\"width:70px;\" onchange=\"miv_changePageSize(this.value)\">");
//            	int[] sizes = { 15, 30, 50 };
//            	for (int size : sizes) {
//            		output.append("<option");
//            		if (size == this.nPageSize) {
//            			output.append(" selected=\"selected\" ");
//            		}
//            		output.append(">" + size + "</option>");
//            	}
//            	output.append("</select>");
//            }

        }
        output.append("</ul>\n</div>\n");
    }
    

    public int doStartTag() throws JspTagException {
        CPATH = ((HttpServletRequest)pageContext.getRequest()).getContextPath();
        //String menu_fg = (String) this.pageContext.getRequest().getAttribute(TraMenuServiceImpl.MENU_FG);
        
        try {
            StringBuffer output = new StringBuffer();
            setProc();
            baseScript(output);

            skinProcA();

            pageProc();
            writeStartProc(output);
            pageContext.getOut().write(output.toString());

        }catch (IOException e) {
        	logger.error("IOException error===", e);
        	throw new JspTagException("IO Error : " + e.getMessage());
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	throw new JspTagException("IO Error : " + e.getMessage());
        } catch (Exception e) {
            logger.trace(e);
            throw new JspTagException("IO Error : " + e.getMessage());
        }
        return EVAL_BODY_INCLUDE;
    }

    public int doEndTag() throws JspTagException {
        try {
            StringBuffer output = new StringBuffer();
           // String menu_fg = (String) this.pageContext.getRequest().getAttribute(TraMenuServiceImpl.MENU_FG);

            writeEndProcA(output);

            pageContext.getOut().write(output.toString());
            release();
        } catch (IOException e) {
            throw new JspTagException("IO Error : " + e.getMessage());
        }
        return EVAL_PAGE;
    }

}
