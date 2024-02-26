package kr.apfs.local.common.model;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mvel2.util.ThisLiteral;

import kr.apfs.local.common.Const;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.ObjUtil;







public class NavigatorInfo {
    /**
     *
     */
    private static final long serialVersionUID = 1L;
    private final static Log logger = LogFactory.getLog(NavigatorInfo.class);

    public static final int DEFAULT_PAGE_SIZE  =  15;
    public static final int DEFAULT_SCREEN_SIZE = 10;
    public static final String MIV_ORDER = "miv_sort";
    public static final String MIV_PAGESIZE = "miv_pageSize";
    public static final String MIV_PAGE = "miv_pageNo";
    public static final String MIV_START_INDEX = "miv_start_index";
    public static final String MIV_END_INDEX = "miv_end_index";
    public static final String TOT_COUNT_FIELD_NAME = "totalCnt";
    private int pageNo = 1;
    private int totalCount = 0;
    private int pageCount = 0;
    private int pageSize = DEFAULT_PAGE_SIZE;
    private int screenSize = DEFAULT_SCREEN_SIZE;
    private int startPage = 0;
    private int endPage = 0;
    private List list = null;
    private NavigatorOrderInfo order = null;
    private ListOp listOp = null;
    private Map<String, Object> param = null;

    /**
     * List페이지에 관련 된 정보를 가지고 다닌다.
     *
     * @author goindole
     *
     */
    public NavigatorInfo() {

    }
    /**
     *
     * @param _req
     * @param listOp
     */
    public NavigatorInfo(ExtHtttprequestParam _req) {
    	ListOp listOp = new ListOp();
        this.init(_req, listOp, null, DEFAULT_PAGE_SIZE, null);
    }
    /**
     *
     * @param _req
     * @param listOp
     */
    public NavigatorInfo(ExtHtttprequestParam _req, ListOp listOp) {
        this.init(_req, listOp, null, DEFAULT_PAGE_SIZE, null);
    }

    /**
     *
     * @param _req
     * @param listOp
     * @param searchFields : {"srch1:A1234","srch3[]:['RE',AA']};
     */
    public NavigatorInfo(ExtHtttprequestParam _req, ListOp listOp,
            String[] searchFields) {
        this.init(_req, listOp, null, DEFAULT_PAGE_SIZE, searchFields);
    }

    /**
     *
     * @param _req
     * @param listOp
     * @param pageSize
     *            한페이지에 나오는 기본수 ( 1-100)
     */
    public NavigatorInfo(ExtHtttprequestParam _req, ListOp listOp, int pageSize) {
        this.init(_req, listOp, null, pageSize, null);
    }

    public NavigatorInfo(ExtHtttprequestParam _req, ListOp listOp,
            String[] searchFields, int pageSize) {
        this.init(_req, listOp, null, pageSize, searchFields);
    }

    /**
     * exam) new NavigatorInfo(_req, this.listOp, new
     * NavigatorOrderInfo("A:groupNm"));
     *
     * @param _req
     * @param listOp
     * @param defaultOrder
     */

    public NavigatorInfo(ExtHtttprequestParam _req, ListOp listOp,
            NavigatorOrderInfo defaultOrder) {
        this.init(_req, listOp, defaultOrder, DEFAULT_PAGE_SIZE, null);
    }

    public NavigatorInfo(ExtHtttprequestParam _req, ListOp listOp,
            String[] searchFields, NavigatorOrderInfo defaultOrder) {
        this.init(_req, listOp, defaultOrder, DEFAULT_PAGE_SIZE, searchFields);
    }

    /**
     * exam) new NavigatorInfo(_req, this.listOp, new
     * NavigatorOrderInfo("A:groupNm"));
     *
     * @param _req
     * @param listOp
     * @param defaultOrder
     * @param pageSize
     *            : 한페이지에 나오는 기본수 ( 1-100)
     */
    public NavigatorInfo(ExtHtttprequestParam _req, ListOp listOp,
            NavigatorOrderInfo defaultOrder, int pageSize) {
        this.init(_req, listOp, defaultOrder, pageSize, null);
    }

    private void init(ExtHtttprequestParam _req, ListOp pListOp,
            NavigatorOrderInfo defaultOrder, int pageSize, String[] searchFields) {
    	String ordParam = pListOp.get(MIV_ORDER);
        ordParam = ObjUtil.nvl(_req.getParameter(MIV_ORDER), ordParam);
        this.order = new NavigatorOrderInfo(ordParam);
        if (!this.order.isOrdSpecified() && defaultOrder != null) {
            this.order = defaultOrder;
        }
        this.pageSize = ObjUtil.parseInt(pListOp.get(MIV_PAGESIZE), pageSize);
        this.pageSize = ObjUtil.parseInt(_req.getParameter(MIV_PAGESIZE),
                this.pageSize);

        String mobileYn = (String) _req.getParameter(Const.SESSION_MOBILE_YN);

        if (mobileYn=="Y") this.screenSize = 5;

        if (this.pageSize > 200)
            //this.pageSize = 200;
        if (this.pageSize < 1)
            this.pageSize = 1;

        try {

            this.pageNo = ObjUtil.parseInt(pListOp.get(MIV_PAGE), 1);
//            logger.debug("1:" + this.pageNo);
            this.pageNo = ObjUtil.parseInt(_req.getParameter(MIV_PAGE),
                    this.pageNo);
//            logger.debug("2:" + this.pageNo);
        } catch (NumberFormatException e) {
            this.pageNo = 1;
        }
        if (this.pageNo < 1) {
            this.pageNo = 1;
        }
        this.listOp = pListOp;
        this.listOp.put(MIV_ORDER, this.order.getParam());
        this.listOp.put(MIV_PAGESIZE, this.pageSize + "");
        this.listOp.put(MIV_PAGE, this.pageNo + "");
        int start_num  = ( this.pageNo -1) * this.pageSize ;
        this.listOp.put(MIV_START_INDEX, start_num +"");
        this.listOp.put(MIV_END_INDEX, (start_num + this.pageSize) + "");

        this.param = this.listOp.getMergedParam(_req, searchFields);
    }

    public int getTotalCnt() {
        return totalCount;
    }

    public void setTotalCnt(int count) {
        this.totalCount = count;
    }

    public void setTotalCount(int count) {
        this.totalCount = count;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int currentPage) {
        this.pageNo = currentPage;
    }

    public long getEndPage() {
        return endPage;
    }

    /**
     * Total Pages
     * @return
     */
    public long getPageCount() {
        return pageCount;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getScreenSize() {
        return screenSize;
    }

    public void setScreenSize(int screenSize) {
        this.screenSize = screenSize;
    }

    public int getStartPage() {
        return (pageNo - 1) / screenSize * screenSize + 1;
    }

    /**
     * screensize와 tocalcount 등의 값으로 page등을 계산 한다.
     *
     */
    public void sync() {
        pageCount = totalCount / pageSize
                + (totalCount % pageSize == 0 ? 0 : 1);
        startPage = (pageNo - 1) / screenSize * screenSize + 1;
        endPage = startPage + screenSize - 1;
        if (endPage > pageCount) {
            endPage = pageCount;
        }
    }

    public void setList(List<Map<String, Object>> list) {
        if (list != null && list.size() > 0) {
            Map<String, Object> rec = list.get(0);
            if (rec.containsKey(TOT_COUNT_FIELD_NAME)) {
                this.totalCount = ObjUtil.parseInt(ObjUtil.getSafeString(rec.get(TOT_COUNT_FIELD_NAME)));
                sync();
            }
        }
        this.list = list;
    }

    public List<Map<String, Object>> getList() {
        if (this.list == null) {
            return Collections.EMPTY_LIST;
        }
        return this.list;
    }

    public Map<String, Object> getParam() {
        return param;
    }

    public String toString() {
        return "";
    }

    /**
     * @return Returns the order.
     */
    public NavigatorOrderInfo getOrderInfo() {
        return order;
    }

    public String getListOpValue() {
    	if(this.listOp != null) {
    		return this.listOp.getValue();
    	} else {
    		return "";
    	}
    }

    /**
     *
     * @return
     */
    public ListOp getListOp() {
    	if(this.listOp != null) {
    		return this.listOp;
    	} else {
    		return null;
    	}
    }

    public String getPagging() {
        int iTemp = 0;

        if ( this.totalCount < 1 ) {
        	return "";
        }

       	String img_path = "/images/common";
        String	func_name = "go_Page";

        StringBuffer page = new StringBuffer();

       int intStartPage = (int)(Math.floor(((float)this.pageNo-1)/(float)this.screenSize)) *this.screenSize + 1;
       // int intStartPage = ( this.pageCount % this.pageNo) * this.screenSize +1;

        //int intStartPage =((int)Math.ceil(this.pageNo/this.screenSize)-1)*this.screenSize+1;
        //int intStartPage = this.pageNo;

        page.append("<div class='paging paging_area' >\n");

        if ( intStartPage>1 ) {
	        page.append("<a href=\"javascript:"+func_name+"("+1+")\"  class=\"stimg\" alt=\"맨앞으로\"> <img src=\""+img_path+"/btn_paging_first.png\" alt=\"맨앞으로\" /> </a>\n");
	    } else {
	        page.append(" <img src=\""+img_path+"/btn_paging_first.png\" alt=\"맨앞으로\" /> \n");
	    }


//System.out.println(" 이전 처리 : this.pageNo : " + Integer.toString(this.pageNo) + " / intStartPage : " + Integer.toString(intStartPage) + " / this.screenSize : " + Integer.toString(this.screenSize) );       
        
        if ( this.pageNo > 1 && (intStartPage-this.screenSize) > 0 ) {
			page.append("<a href=\"javascript:"+func_name+"("+(intStartPage-1)+")\"  class=\"stimg\" alt=\"이전\"> <img src=\""+img_path+"/btn_paging_prev.png\" alt=\"이전\" /> </a>\n");
		} else {
			page.append(" <a href=\"#none\"  class=\"stimg\" alt=\"이전\"> <img src=\""+img_path+"/btn_paging_prev.png\" alt=\"이전\" /> </a> \n");
		}
        page.append("<span class=\"mobileoff_in\">");
	    for (int i=intStartPage; i<intStartPage + this.screenSize ; i++) {
	    	iTemp=i;
	        if ( i<=this.pageCount ) {
	        	if ( i !=this.pageNo ) {
	        		page.append("<a href='javascript:"+func_name+"("+i+")'>"+ i +"</a>\n");
		        } else {
		        	page.append("<strong>"+i+"</strong>\n");
		        }
	        } else	{
	        	break;
	        }
	    }
	    page.append("</span>");

	    /*page.append("<span class=\"mobileon_in\">");
	    for (int i=intStartPage; i<intStartPage + this.screenSize ; i++) {
	    	iTemp=i;
	        if ( i<=this.pageCount ) {
	        	if ( i !=this.pageNo ) {
	        		page.append("<a href='javascript:"+func_name+"("+i+")'>"+ i +"</a>\n");
		        } else {
		        	page.append("<a href='javascript:"+func_name+"("+i+")' class=\"on\">"+i+"</a>\n");
		        }
	        } else	{
	        	break;
	        }
	    }
	    page.append("</span>");*/

//System.out.println(" 다음 처리 : this.pageNo : " + Integer.toString(this.pageNo) + " / this.pageCount : " + Integer.toString(this.pageCount) + " / iTemp : " + Integer.toString(iTemp) + " / pageCount : " + Integer.toString(pageCount) );       
	    
	    if ( this.pageNo < this.pageCount && ( iTemp+1 ) < pageCount ) {
	    	page.append("<a href=\"javascript:"+func_name+"("+(iTemp+1)+")\"  class=\"stimg\" alt=\"다음\"> <img src=\""+img_path+"/btn_paging_next.png\" alt=\"다음\" /> </a>\n");
	    } else if (iTemp+1<= this.pageCount) {
	    	page.append("<a href=\"javascript:"+func_name+"("+( pageCount )+")\"  class=\"stimg\" alt=\"다음\"> <img src=\""+img_path+"/btn_paging_next.png\" alt=\"다음\" /> </a>\n");
	    }else{
	    	page.append(" <a href=\"#none\"  class=\"stimg\" alt=\"다음\"> <img src=\""+img_path+"/btn_paging_next.png\" alt=\"다음\" /> </a> \n");
	    }

	    if (iTemp+1<= this.pageCount) {
	    	page.append("<a href=\"javascript:"+func_name+"("+( pageCount )+")\"  class=\"stimg\" alt=\"맨뒤로\"> <img src=\""+img_path+"/btn_paging_last.png\" alt=\"맨뒤로\" /> </a>\n");
	    } else {
	    	page.append(" <img src=\""+img_path+"/btn_paging_last.png\" alt=\"맨뒤로\" /> \n");
		}

	    page.append("</div>\n");

       return page.toString();
    }
}
