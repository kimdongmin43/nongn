package kr.apfs.local.common.web.view;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * @Class Name : ViewerSupport.java
 * @Description : 클래스 설명을 기술합니다.
 * @author SangJoon Kim
 * @since 2011. 8. 3.
 * @version 1.0
 * @see 
 *
 * @Modification Information
 * <pre>
 *    수정일         수정자              수정내용
 *  ===========    =========    ===========================
 *  2011. 8. 3.      SangJoon Kim      최초 생성
 * </pre>
 */

public class ViewerSupport  {
    public static final String PARAM_KEY = ViewerSupport.class + ".PARAM_KEY";
    public static final String DATA_SOURCE_KEY = ViewerSupport.class + ".DATA_SOURCE_KEY";
    //public static final String DATA_SOURCE_KEY = "param_data";
    public static final String XML_DOC_KEY = ViewerSupport.class + ".XML_DOC_KEY";
    public static final String JSON_KEY = ViewerSupport.class + ".JSON_KEY";
    
    /**
     * JaperView에 파라미터 Map을 넘겨준다.
     * @param request
     * @param param
     */
    public  static void setPapameterMap(HttpServletRequest request, Map param) {
        request.setAttribute(ViewerSupport.PARAM_KEY, param);
    }
    
    /**
     * JasperPDFVIewer에 데이타 List를 넘겨준다. 
     * @param request
     * @param data
     */
    public  static void setDataSourceList(HttpServletRequest request, List data) {
        request.setAttribute(ViewerSupport.DATA_SOURCE_KEY, data);
    }
}

