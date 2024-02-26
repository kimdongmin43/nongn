package kr.apfs.local.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;

import com.ibm.icu.text.CharsetDetector;

// TODO: Auto-generated Javadoc
/**
 * The Class FileUploadUtil.
 */
public class FileUploadUtil {
	
	/** The byte num. */
	private static final int BYTE_NUM = 1024;
	
	private static final Log logger = LogFactory.getLog(FileUploadUtil.class);
	
	/**
	 * 파일 확장자 체크.
	 *
	 * @param filename the filename
	 * @param chExt the ch ext
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	public static boolean filenmCheck(final String filename, final String chExt)
			throws Exception {
		String ext = "";
		boolean result = false;
		
		try { 
			
			int dot = filename.lastIndexOf(".");
			if (dot != -1) {
				ext = filename.substring(dot + 1);  // 확장자
			}
			
			if (!ext.equals("")) {
				if (ext.equalsIgnoreCase(chExt)) {
					result = true;
				} else {
					result = false;
				}
			}

		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        } catch (Exception e) {
			throw e;
		} 
		return result;
	}
	
	/**
	 * 파일 확장자 체크.
	 *
	 * @param filename the filename
	 * @param chExt the ch ext
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	public static boolean filenmCheck(
			final String filename, 
			final String[] chExt) throws Exception {
		
		String ext = "";
		boolean result = false;
		
		try { 
			
			int dot = filename.lastIndexOf(".");
			if (dot != -1) {
				ext = filename.substring(dot + 1);  // 확장자
			}
			
			if (!ext.equals("")) {
				
				for (int i = 0; i < chExt.length; i++) {
					if (chExt[i].equalsIgnoreCase(ext)) {
						result = true;
						break;
					} else {
						result = false;
					}
				}
			}

		} catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        } catch (Exception e) {
			throw e;
		} 
		return result;
	}
	
	/**
	 * 파일 사이즈 체크.
	 *
	 * @param file the file
	 * @param chSize the ch size
	 * @param bt the bt
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	public static boolean fileSizeCheck(
			final File file, 
			final float chSize, 
			final String bt) throws Exception {
		
		boolean result = false;
		
		try { 
			
			if (file != null) {
				float filelen = file.length();
				float fileSize = 0.0F;
				
				if (bt.equals("K")) {
					fileSize = filelen / BYTE_NUM;
				} else if (bt.equals("M")) {
					fileSize = filelen / (BYTE_NUM * BYTE_NUM);
				}
				
				if (fileSize < chSize) {
					result = true;
				} else {
					result = false;
				}
			}
			
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        } catch (Exception e) { 
			throw e;
		} 
		return result;
	}

	/**
	 * Gets the file extension.
	 *
	 * @param filename the filename
	 * @return the file extension
	 */
	public static String getFileExtension(
			final String filename) {
		int index = filename.lastIndexOf(".");
    	String fileExtension = filename.substring(index + 1);
    	
    	return fileExtension;
	}

	/**
	 * 업로드한 파일의 인코딩 타입을 구해온다.
	 *
	 * @param file the file
	 * @return String file encoding type
	 * @throws Exception the exception
	 */
	public static String getReadFileEncoding(final File file) throws Exception {
		FileInputStream fin = null;
		String encoding = "";

		try {
			long length = file.length();
			byte[] strByte = new byte[(int) length];

			fin = new FileInputStream(file);
			fin.read(strByte);

			// ICU 라이브러리 사용 - 리눅스, 유닉스 서버일 경우 UTF-8 BOM 타입 구분
			CharsetDetector detector = new CharsetDetector();
			detector.setText(strByte);

			encoding = detector.detect().getName();

			if (encoding.equalsIgnoreCase("IBM420_ltr")
					|| encoding.equalsIgnoreCase("ISO-8859-1")
					|| encoding.equalsIgnoreCase("Big5")
					|| encoding.equalsIgnoreCase("ISO-8859-9")) {
				encoding = "EUC-KR";
			}

			fin.close();

		} catch (IOException e) {
			throw new Exception(e);
		} finally {
			if (fin != null) {
				try {
					fin.close();
				}catch (IOException e) {
		        	logger.error("IOException error===", e);
		        } catch (NullPointerException e) {
		        	logger.error("NullPointerException error===", e);
		        }
			}
		}
		return encoding;
	}
	
	/**
	 * 업로드한 파일의 인코딩 타입을 구해온다.
	 *
	 * @param multipartFile the multipart file
	 * @return String file encoding type
	 * @throws Exception the exception
	 */
	public static String getReadFileEncoding(
			final MultipartFile multipartFile) throws Exception {
		InputStream fin = null;
		String encoding = "";

		try {
			long length = multipartFile.getSize();
			byte[] strByte = new byte[(int) length];

			fin = (InputStream) multipartFile.getInputStream();
			fin.read(strByte);

			// ICU 라이브러리 사용 - 리눅스, 유닉스 서버일 경우 UTF-8 BOM 타입 구분
			CharsetDetector detector = new CharsetDetector();
			detector.setText(strByte);

			encoding = detector.detect().getName();

			if (encoding.equalsIgnoreCase("IBM420_ltr")
					|| encoding.equalsIgnoreCase("ISO-8859-1")
					|| encoding.equalsIgnoreCase("Big5")
					|| encoding.equalsIgnoreCase("ISO-8859-9")) {
				encoding = "EUC-KR";
			}

			fin.close();

		} catch (IOException e) {
			throw new Exception(e);
		} finally {
			if (fin != null) {
				try {
					fin.close();
				}catch (IOException e) {
		        	logger.error("IOException error===", e);
		        } catch (NullPointerException e) {
		        	logger.error("NullPointerException error===", e);
		        }
			}
		}
		return encoding;
	}
	
    /**
     * 파일의 확장자를 체크하여 필터링된 확장자를 포함한 파일인 경우에 true를 리턴한다.
     * @param file
     * */
    public static boolean fileExtIsReturnBoolean(String fileName, String checkExt) {
        String ext = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
        String[] CHECK_EXTENSION = checkExt.split(",");

        int len =  CHECK_EXTENSION.length;
        for (int i = 0; i < len; i++) {
            if (ext.equalsIgnoreCase(CHECK_EXTENSION[i])) {
                return true;
            }
        }
        return false;
    }
    
    /*
     * 업로드 제한 확장자 체크 메소드 수정 badFileExtIsReturn
     * 작업일자 : 2018.07.11(수)
     * 작업자 : (주)아사달 대리 함민석
     */
    public static boolean badFileExtIsReturn(String fileName) {
        String ext = fileName;
        final String[] BAD_EXTENSION = {
        		".jsp", ".php", ".php3", ".php4", 
        		".phps", ".asp", ".aspx", 
        		".html", ".perl", ".exe", ".phtml", 
        		".in", ".pl", ".shtml", ".com",
        		".war", ".do", ".htm", ".aspx", 
        		".sh", ".cgi", ".phps", ".java",
        		".bak", ".backup", ".org", ".old",
        		".log", "!", "sql", ".dll", 
        		".bat", ".new", ".txt", ".tmp", 
        		".temp"
        };
        
        int len = BAD_EXTENSION.length;
        for (int i = 0; i < len; i++) {
            //if (ext.equalsIgnoreCase(BAD_EXTENSION[i])) {
        	if (ext.contains(BAD_EXTENSION[i])) {
                // 불량 확장자가 존재할 때, IOExepction 발생
               return true;
            }
        }
        
        return false;
    }

}
