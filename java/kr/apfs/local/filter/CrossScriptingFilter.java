package kr.apfs.local.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

public class CrossScriptingFilter implements Filter {
	
    @Autowired
	public FilterConfig filterConfig;
    
	public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }
	
    public void destroy() {
        this.filterConfig = null;
    }
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
    		throws IOException, ServletException {
    	
    	RequestWrapper wrRequest = new RequestWrapper((HttpServletRequest) request);
    	
    	HttpServletResponse res = ((HttpServletResponse) response);
    	
    	// 교차 프레임 스크립팅 방어 누락
    	res.setHeader("X-Frame-Options", "ALLOW-FROM");
    	
    	// Missing "X-Content-Type-Options" header
    	res.setHeader("X-Content-Type-Options", "nosniff");
    	
    	// Missing "X-XSS-Protection" header
    	res.setHeader("X-XSS-Protection", "1");
    	
    	// chain.doFilter(new RequestWrapper((HttpServletRequest) request), response);
    	chain.doFilter(wrRequest, res);
    }

}