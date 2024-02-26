package kr.apfs.local.common.util;


public class PathUtil {
	public PathUtil(){
		
	}
	public final static String getBaseClassPath() {
		
		return new PathUtil().getClass().getResource("/").getPath();
		
	}
}
