package kr.apfs.local.common.util;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * session Util.
 * - Spring에서 제공하는 RequestContextHolder 를 이용하여
 * request 객체를 service까지 전달하지 않고 사용할 수 있게 해줌
 * @author h2y
 *
 */
public final class SessionUtil {
	/**
	 * 
	 */
	private SessionUtil() {
	}
	
	/**
	 * attribute 값을 가져 오기 위한 method.
	 * @param name 
	 * @return Object
	 * @throws Exception 
	 */
	public static Object getAttribute(final String name) {
		return (Object) RequestContextHolder.getRequestAttributes()
				.getAttribute(name, RequestAttributes.SCOPE_SESSION);
	}

	/**
	 * attribute 설정 method.
	 * @param name 
	 * @param object 
	 * @throws Exception 
	 */
	public static void setAttribute(
			final String name, 
			final Object object) {
		RequestContextHolder.getRequestAttributes().setAttribute(
				name, object, RequestAttributes.SCOPE_SESSION);
	}

	/**
	 * 설정한 attribute 삭제.
	 * @param name 
	 * @throws Exception 
	 */
	public static void removeAttribute(
			final String name) {
		RequestContextHolder.getRequestAttributes().removeAttribute(
				name, RequestAttributes.SCOPE_SESSION);
	}

	/**
	 * session id.
	 * @return String 
	 * @throws Exception 
	 */
	public static String getSessionId() {
		return RequestContextHolder.getRequestAttributes().getSessionId();
	}
}
