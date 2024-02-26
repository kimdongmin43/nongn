package kr.apfs.local.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import java.net.URLDecoder;
import java.util.regex.Pattern;

public final class RequestWrapper extends HttpServletRequestWrapper {
	
	/*
	 * XSS 취약점 방지시 script 관련 문자 등 패턴 정의(컴파일)함 
	 * 처리자 : 2018.06.11(월) (주)아사달 대리 함민석
	 */
	private static Pattern[] patterns = new Pattern[]{
        Pattern.compile("<script>(.*?)</script>", Pattern.CASE_INSENSITIVE),
        Pattern.compile("src[\r\n]*=[\r\n]*\\\'(.*?)\\\'", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        Pattern.compile("src[\r\n]*=[\r\n]*\\\"(.*?)\\\"", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        Pattern.compile("</script>", Pattern.CASE_INSENSITIVE),
        Pattern.compile("<script(.*?)>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        Pattern.compile("eval\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        Pattern.compile("expression\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE),
        Pattern.compile("vbscript:", Pattern.CASE_INSENSITIVE),
        Pattern.compile("onload(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL)
    };
	
    public RequestWrapper(HttpServletRequest servletRequest) {
        super(servletRequest);
    }
 
    public String[] getParameterValues(String parameter) {
 
      String[] values = super.getParameterValues(parameter);
      if (values==null)  {
    	  return null;
      }
      int count = values.length;
      String[] encodedValues = new String[count];
      for (int i = 0; i < count; i++) {
    	  encodedValues[i] = cleanXSS(values[i]);
      }
      return encodedValues;
    }
    
    public String getParameter(String parameter) {
          String value = super.getParameter(parameter);
          if (value == null) {
                 return null;
                  }
          return cleanXSS(value);
    }
 
    public String getHeader(String name) {
        String value = super.getHeader(name);
        if (value == null)
            return null;
        return cleanXSS(value);
    }
    
    // XSS 방지를 위한 특수문자 치환, script 태그 삽입 방지 - 2018.06.11(월) - (주)아사달 대리 함민석
    @SuppressWarnings("deprecation")
	private String cleanXSS(String value) {
    	String str_low = "";
    	
    	if(value != null) {
    		value = value.replaceAll("<", "&lt;");
    		value = value.replaceAll(">", "&gt;");
    		
    		// 특수 문자 제거
    		value = value.replaceAll("\\(", "& #40;").replaceAll("\\)", "&#41;");
    		value = value.replaceAll("\"", "&gt;");
    		value = value.replaceAll("&", "&amp;");
    		value = value.replaceAll("%00", null);
    		value = value.replaceAll("\"", "&#34;");
    		value = value.replaceAll("\'", "&#39;");
    		value = value.replaceAll("%", "&#37;");
    		value = value.replaceAll("../", "");
    		value = value.replaceAll("..\\\\", "");
    		value = value.replaceAll("./", "");
    		value = value.replaceAll("%2F", "");
    		
    		
    		// 허용할 HTML tag만 변경
    		value = value.replaceAll("&lt;p&gt;", "<p>");
    		value = value.replaceAll("&lt;P&gt;", "<P>");
    		value = value.replaceAll("&lt;br&gt;", "<br>");
    		value = value.replaceAll("&lt;BR&gt;", "<BR>");
    		
    		str_low = value.toLowerCase();
    		
    		if(
    				str_low.contains("javascript") || str_low.contains("script") || 
    				str_low.contains("document") || str_low.contains("vbscript") || 
    				str_low.contains("applet") || 
    				str_low.contains("embed") || str_low.contains("object") || 
    				str_low.contains("frame") || 
    				str_low.contains("grameset") || str_low.contains("layer") || 
    				str_low.contains("bgsound") ||  
    				str_low.contains("alert") || str_low.contains("onblur") || 
    				str_low.contains("onclick") || str_low.contains("ondbclick") || 
    				str_low.contains("enerror") || 
    				str_low.contains("onfocus") || str_low.contains("onload") || 
    				str_low.contains("onmouse") ||  
    				str_low.contains("onscroll") || str_low.contains("onsubmit") || 
    				str_low.contains("onmouse") || str_low.contains("isindex")
    				) {
    			value = str_low;
    			
    			value = value.replaceAll("javascript", "x-javascript");
    			value = value.replaceAll("script", "x-script");
    			value = value.replaceAll("iframe", "x-iframe");
    			value = value.replaceAll("document", "x-document");
    			value = value.replaceAll("vbscript", "x-vbscript");
    			value = value.replaceAll("applet", "x-applet");
    			value = value.replaceAll("embed", "x-embed");
    			value = value.replaceAll("object", "x-object");
    			value = value.replaceAll("frame", "x-frame");
    			value = value.replaceAll("grameset", "x-grameset");
    			value = value.replaceAll("layer", "x-layer");
    			value = value.replaceAll("bgsound", "x-bgsound");
    			value = value.replaceAll("alert", "x-alert");
    			value = value.replaceAll("onblur", "x-onblur");
    			value = value.replaceAll("onchange", "x-onchange");
    			value = value.replaceAll("onclick", "x-onclick");
    			value = value.replaceAll("ondblclick", "x-ondblclick");
    			value = value.replaceAll("enerror", "x-enerror");
    			value = value.replaceAll("onfocus", "x-onfocus");
    			value = value.replaceAll("onload", "x-onload");
    			value = value.replaceAll("onmouse", "x-onmouse");
    			value = value.replaceAll("onscroll", "x-onscroll");
    			value = value.replaceAll("onsubmit", "x-onsubmit");
    			value = value.replaceAll("onunload", "x-onunload");
    			value = value.replaceAll("isindex", "x-isindex");
    		}
    	}
    	
    	
        return value;
    }
    
}