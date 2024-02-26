package kr.apfs.local.common.model;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.apfs.local.common.util.ObjUtil;







public class ListOpUtil {

    private static final Logger logger = LoggerFactory.getLogger(ListOpUtil.class);
    
    private final static String URL_ENCODE= "UTF-8";
    
    /**
     * String(key=value;값을) hashtable로 만들어 넘겨준다. 
     * @param st
     * @return
     */
    public static Map str2hashtable(String st) {
        Map ht = new HashMap();
        try {
            
            String[] sParam = st.split(";");
            String key = null;
    
            for (int i = 0; i < sParam.length; i++) {
                String[] sData = sParam[i].split("=");
                if(sData != null && sData.length > 0) {
                    key = sData[0];
                    // LISTOP자체는 배열에서 뺌ob.getFl_read().indexOf(os.getUtype())
                    if (!"LISTOP".equals(key)) {
                        if (sData.length > 1) {
                            ht.put(key, URLDecoder.decode(sData[1], URL_ENCODE));
                        } else if (sData.length == 1) {
                            ht.put(key, "");
                        }
                    }
                }
            }
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        	ht.clear();
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	ht.clear();
        }
        return ht;
    }
    
    /**
     * HashTable의 값을 key1=urlencode(value1);key2=urlencode(value2); 형태의 String으로 돌려 준다. 
     * @param ht
     * @return
     */
    public static String hashtable2str(Map<String,Object> ht) {
        if (ht !=null) {
            try {
                StringBuffer st = new StringBuffer();

                ht.put(ListOp.SERIALISVALID, "T");

                Set<String> keySet = ht.keySet();
                for(String key : keySet) {
                    
                    st.append(key);
                    st.append("=");
                    st.append(URLEncoder.encode(ObjUtil.nvl(ht.get(key),""), URL_ENCODE));
                    st.append(";");                 
                }
                return st.toString();
            }catch (IOException e) {
            	logger.error("IOException error===", e);
            	return null;
            } catch (NullPointerException e) {
            	logger.error("NullPointerException error===", e);
            	return null;
            }
        } else {
            logger.error("Hashtable ht is null");
            return null;
        }
    }
    
 
}

