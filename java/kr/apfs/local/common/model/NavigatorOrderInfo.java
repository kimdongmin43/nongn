package kr.apfs.local.common.model;

import java.io.IOException;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.apfs.local.common.util.JsonUtil;
import kr.apfs.local.common.util.ObjUtil;

public class NavigatorOrderInfo {

    /**
     * 
     */
    
    private static final long serialVersionUID = 1L;
    
    
    public final static String ORD_ASC = "ASC";
    public final static String ORD_DESC = "DESC";
    
    private Log logger = LogFactory.getLog(NavigatorOrderInfo.class);
    private String order = ORD_ASC;
    private String orderParam = "";
    private String key = null;
    private boolean ordSpecified = false;

    /**
     * 
     * @param param
     *            "(A|D):FieldName"
     */
    public NavigatorOrderInfo(String param) {
        // ExtJS Grid에서 넘어오는 String 
        // [{"property":"cdid","direction":"DESC"}]
        
        try {
            Map[] sortList = (Map[]) JsonUtil.fromJsonStr(param);
            
            this.orderParam = param;
            if (sortList != null && sortList.length > 0) {
//                String[] t = orderParam.split(":", 2);
//
//                if (t.length > 1) {
//                    this.order = (ORD_ASC.equals(t[0])) ? ORD_ASC : ORD_DESC;
//                    this.key = t[1];
//                    if (key != null) {
//                        key = key.replaceAll(" ", "");
//                        ordSpecified = true;
//                    }
//                }
                Map sortInfo = (Map) sortList[0];
                this.key = ObjUtil.getSafeString(sortInfo.get("property"));
                this.order = ObjUtil.getSafeString(sortInfo.get("direction"));
                this.ordSpecified = true;
                
            }
        }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	logger.error("param = [" + orderParam + "]" + e.getMessage(), e);
        }
    }

    public NavigatorOrderInfo(String fieldname, boolean isdescending) {
        this.key = fieldname;
        this.order = (isdescending) ? ORD_DESC : ORD_ASC;
    }

    /**
     * @return Returns the key.
     */
    public String getKey() {
        return key;
    }

    /**
     * @param key
     *            The key to set.
     */
    public void setKey(String key) {
        this.key = key;
    }

    /**
     * @return Returns the ord.
     */
    public String getOrder() {
        return order;
    }


    /**
     * @param ord
     *            The ord to set.
     */
    public void setOrder(String ord) {
        this.order = ord;
    }

    /**
     * order option을 String으로 전환
     * 
     * @return
     */
    public String getParam() {
        return this.orderParam;
    }

    /**
     * @return the ordSpecified
     */
    public boolean isOrdSpecified() {
        return ordSpecified;
    }

}
