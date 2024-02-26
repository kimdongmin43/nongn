package kr.apfs.local.common.util;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.URL;
import java.rmi.dgc.VMID;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.commons.io.IOUtils;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.commons.lang.ArrayUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.util.StringUtils;

import kr.apfs.local.common.support.ApplicationContextProvider;

/**
 * @Class Name : GUtils
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
 *  2011. 8. 3.      John Doe      최초 생성
 * </pre>
 */

public class ObjUtil {

    private static final Logger logger = LoggerFactory.getLogger(ObjUtil.class);

    /**
     * <pre>
     * 개체가 비어있음(null, &quot;&quot;) : True 
     * Collection의경우 Size 가 0 이어도 : True 
     * Array 의 경우 size 가 0 이어도 :  True
     * 
     * ex) if(&quot;&quot;.equal(sample) &amp;&amp; sample == null) { }
     *  = if(Util.empty(sample)) {}
     * 
     * </pre>
     * 
     * @author : 김상준
     * @param obj
     * @return
     */
    public static boolean isEmpty(Object obj) {
        if (obj instanceof Collection) {
            return ((Collection) obj).isEmpty();
        } else if (obj instanceof Object[]) {
            return (((Object[]) obj).length == 0) ? true : false;
        } else {
            return (obj == null || "".equals(getSafeString(obj))) ? true
                    : false;
        }
    }

    /**
     * 모든 Object의 String 값을 가져온다.
     * 
     * <pre>
     *  null =&gt; null;
     *  String =&gt; string.trim();
     *  Collection =&gt; delimited by &quot;;&quot; string
     *  Object -&gt; obj.toString();
     * </pre>
     * 
     * @author : 김상준
     * @param obj
     * @return
     */
    public static String getSafeString(Object obj) {
        return getSafeString(obj, null);
    }

    public static String getSafeString(Object obj, Object def) {
        if (obj == null) {
            return null;
        } else if (obj instanceof String) {
            return String.valueOf(obj).trim();
            // return ((String) obj).v;
        } else if (obj instanceof Collections) {
            return StringUtils.collectionToDelimitedString((Collection) obj,
                    ";");
            // return ((String) obj).v;
        } else {
            return obj.toString();
        }
    }
    
    public static String nvl(Object obj, Object def) {
        return ObjUtil.getSafeString(isEmpty(obj) ? def : obj);
    }
    public static Object nvlObj(Object obj, Object def) {
        return isEmpty(obj) ? def : obj;
    }
    public static Throwable getRootCause(Throwable e) {
        Throwable t = e.getCause();
        if (t != null) {
            return getRootCause(t);
        }
        return e;

    }

    public static String getGUID() {
        VMID id = new java.rmi.dgc.VMID();

        String tmp = id.toString();
        tmp = tmp.replaceAll("[:|-]", "");
        return tmp;

    }

    public static Date long2Date(long x) {
        return new Date(x);
    }

    /**
     * 
     * 문자를 int 형으로 변환 <br>
     * Exception 발생시 0 을 반환
     * 
     * @author
     * @version 1.0
     * @modifydate 2004. 5. 19.
     * 
     * @param str
     * @return
     */
    public static int parseInt(Object obj) {
        return parseInt(obj, 0);
    }

    /**
     * 
     * 문자를 int 형으로 변환 <br>
     * Exception 발생시 default_num 을 반환
     * 
     * @author
     * @version 1.0
     * @modifydate 2004. 5. 19.
     * 
     * @param str
     * @param default_num
     *            에러 발생시 반환할 기본 값
     * @return
     */
    public static int parseInt(Object obj, int default_num) {
        int parseInt = 0;
        try {
            if(obj instanceof Integer) {
                parseInt =  (Integer) obj;
            } else {   
                String str = getSafeString( obj);
                if (str != null) {
                    parseInt = Integer.parseInt(str.trim());
                } else {
                    parseInt = default_num;
                }
            }
        }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	parseInt = default_num;
        }
        return parseInt;
    }

    /**
     * 스트링을 float 변환. NumberFormatException, NullPointerException 을 검사하기 위해,
     * Exception 발생시 0 리턴
     * 
     * @author :
     * @e-mail :
     */
    public static float parseFloat(String str) {
        return parseFloat(str, 0);
    }

    /**
     * 스트링을 float 변환. NumberFormatException, NullPointerException 을 검사하기 위해,
     * Exception 발생시 default_num 리턴
     * 
     * @author :
     * @e-mail :
     */
    public static float parseFloat(String str, float default_num) {
        float parseFloat = 0.0f;
        try {
            if (str != null) {
                parseFloat = Float.parseFloat(str.trim());
            } else {
                parseFloat = default_num;
            }
        }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
        return parseFloat;
    }

    public static double parseDouble(Object str) {
        double n = 0;
        try {
            n = Double.parseDouble(str.toString());
        }catch (NullPointerException e) {
        	logger.error("str = [" + str + "], NullPointerException error===", e);
        }
        return n;
    }

 
    /**
     * URL에서 데이타를 읽어와 String으로 돌려줌.
     * @param addr
     * @return
     * @throws IOException
     */
    public static String stringOfUrl(String addr) throws IOException {
        
    	ByteArrayOutputStream output = null;
    	
    	try{
    	output = new ByteArrayOutputStream();
        URL url = new URL(addr);
        IOUtils.copy(url.openStream(), output);
    	}
    	catch (IOException e){
			logger.error("IOException error===", e);
		}
    	finally{
	       		//IOUtils.closeQuietly(output);		오류날까봐 주석
    		if (output != null) {
	       		try {
	       			output.close();
	       		} catch (IOException e) {
	       			logger.error("IOException error===", e);
	       			}
	       	}
    	}
        return output.toString();
    }
    /**
     * Exception Stack Trace to String
     * 
     * <pre>

     * 
     * </pre>
     * 
     * @version 2009. 2. 10.
     * @author goindole
     * @param e
     * @param sDelimiter
     * @return
     */
    public static String getStackTrace(Exception e) {
        StringBuffer sBuf = new StringBuffer();
        sBuf.append(e);
        StackTraceElement[] trace = e.getStackTrace();
        for (StackTraceElement el : trace) {
            sBuf.append("\n").append("\tat " + el);
        }
        return sBuf.toString();
    }
    
    /**
     * 날자값에 들어간 쓸때 없는 "-" 문자 제거 
     * @param dateStr
     * @return
     */
    public static String cleanDate(String dateStr) {
        return dateStr.replace("-", "");
    }
    
    /**
     * vo 객체를  Map data 로 변환해준다 
     * @param obj
     * @return
     */
    public static Map<String,Object> ConvertObjectToMap(Object obj){
    	Map<String,Object>resultMap = new HashMap<String,Object>();
    	try {
            //Field[] fields = obj.getClass().getFields(); //private field는 나오지 않음.
            Field[] fields = obj.getClass().getDeclaredFields();
            for(int i=0; i<=fields.length-1;i++){
                fields[i].setAccessible(true);
                resultMap.put(fields[i].getName(), fields[i].get(obj));
            }
        } catch (IllegalArgumentException e) {
            //e.printStackTrace();
        	logger.error("error===", e);
        } catch (IllegalAccessException e) {
            //e.printStackTrace();
        	logger.error("error===", e);
        }
        return resultMap;
    }

	/**
	 * Map데이터를 Object로 변환한다
	 * @param map
	 * @param objClass
	 * @return
	 */
	public static Object convertMapToObject(Map map, Object objClass){
        String keyAttribute = null;
        String setMethodString = "set";
        String methodString = null;
        Iterator itr = map.keySet().iterator();
        while(itr.hasNext()){
            keyAttribute = (String) itr.next();
            methodString = setMethodString+keyAttribute.substring(0,1).toUpperCase()+keyAttribute.substring(1);
            try {
                Method[] methods = objClass.getClass().getDeclaredMethods();
                for(int i=0;i<=methods.length-1;i++){
                    if(methodString.equals(methods[i].getName())){
                        //System.out.println("invoke : "+methodString);
                        methods[i].invoke(objClass, map.get(keyAttribute));
                    }
                }
            } catch (SecurityException e) {
                //e.printStackTrace();
            	logger.error("error===", e);
            } catch (IllegalAccessException e) {
                //e.printStackTrace();
            	logger.error("error===", e);
            } catch (IllegalArgumentException e) {
                //e.printStackTrace();
            	logger.error("error===", e);
            } catch (InvocationTargetException e) {
                //e.printStackTrace();
            	logger.error("error===", e);
            }
        }
        return objClass;
    }

    /**
     * 문자열 배열을 delimiter를 추가한 문자열로 돌려줌.
     * @param arr
     * @param delimeter
     * @return
     */
    public static String arrayToDelimString(String arr[], String delimiter){
        if(arr == null) return "";
        
        StringBuffer sb = new StringBuffer();
        for(int i = 0; i < arr.length; i++){
            if(i > 0)
                sb.append(delimiter);
            sb.append(arr[i]);
        }
        return sb.toString();
    }
    
    /**
     * Object를 Object Array 형태로 돌려준다. 
     * object가 Array면 그냥 돌려줌.
     * @param obj
     * @return
     */
    public static Object[] toArray(Object obj) {
         if(obj == null ){
             return ArrayUtils.EMPTY_OBJECT_ARRAY;
         } else if (obj instanceof Object[]) {
             return (Object[]) obj;
         } else if (obj instanceof Collection) {
             return (Object[]) ((Collection)obj).toArray(new Object[0])  ;         
         } else {
             return ArrayUtils.add(ArrayUtils.EMPTY_OBJECT_ARRAY, obj);
         }
    }
    
    /**
     * 배열을 List로 돌려줌
     * @param obj
     * @return
     */
    public static List<Object> convertArrayToList(Object[] obj) {
        return Arrays.asList(obj);
    }
    
 
    
    /**
     * List<String>을 문자열 배열로 변경 하여 돌려줌. 
     * null일 경우는 길이0인 문자열 배열 return
     * @param list
     * @return
     */
    public static String[] list2StrArray(List<String> list) {
        if (list != null) {
            return (String[])list.toArray(new String[0]);
        } else {
            return new String[0];
        }
    }


    
    public static String[] safeArray(String arr[], int length){
        String newArr[] = new String[length];
        Arrays.fill(newArr, "");
        
        for(int j =0; j < arr.length; j++){
            newArr[j] = arr[j];
        }
        return newArr;
    }
    
    /**
     * 두 Object Array 함침 ( Appache Common ArrayUtils 활용) 
     * concatenate  two arrays.
     * @param arg0
     * @param arg1
     * @return
     */
    public static Object[] addAll(Object[] arg0, Object[] arg1) {
    	return ArrayUtils.addAll(arg0, arg1);
    }
    
    /**
     * Spring Application Context에서 bean Object를 가져옴
     * 
     * @param beanID
     * @return
     */
    public static Object getBean(String beanID) {
        Object obj = null;
        try {
            ApplicationContext ctx = ApplicationContextProvider.getApplicationContext();
            if (ctx != null) {
                obj = ctx.getBean(beanID);
            }
        }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
        return obj;
    }
    
    /**
     * Object를 Json String으로
     * 
     * @param obj
     * @return
     */
    public static String toJsonStr(Object obj) {
        return JsonUtil.toJsonStr(obj);
    }
    
    /**
     * 
     *  Object의 타입을 확인하고 String형태로 반환해준다.
     * @param obj
     * @return
     */
    public static String getDataString(Object obj) {
        if (obj == null) {
            return null;
        } else if (obj instanceof String) {
            return String.valueOf(obj).trim();
        } else if (obj instanceof Collections) {
            return StringUtils.collectionToDelimitedString((Collection) obj,";");
        } else {
        	return String.valueOf(obj).trim();
        }
    }
    
    public static boolean isNumeric(String s) { 
        java.util.regex.Pattern pattern = Pattern.compile("[+-]?\\d+"); 
        return pattern.matcher(s).matches(); 
    }  
}
