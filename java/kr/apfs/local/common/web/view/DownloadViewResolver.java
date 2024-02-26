package kr.apfs.local.common.web.view;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.AbstractView;

import kr.apfs.local.common.util.ObjUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.util.fileupload.FileDownloadInfo;
import kr.apfs.local.common.util.fileupload.FileSupport;







public class DownloadViewResolver extends AbstractView {
    private final int DEFAULT_BUF_SIZE = 65536;
    private Logger logger = LoggerFactory.getLogger(DownloadViewResolver.class);
    
    /**
     * 
     */
    public DownloadViewResolver() {
        setContentType("application/x-download");						//			<-- 	2021.07.02 설정해 보았으나 의미 없음, 원래 값 octet-stream
    }
    
    /**
     * 
     * @param request
     * @return
     */
    private String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } else if (header.indexOf("Trident") > -1) {	// IE11 문자열 깨짐 방지
            return "Trident";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }
    
    /**
     * 
     * @param filename
     * @param request
     * @param response
     * @throws Exception
     */
    private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);
		
		String dispositionPrefix = "attachment; filename=\"";			//		2021.07.02  파일명에 쉼표(,) 포함 시 오류 방지를 위해 \" 단어를 포함시킴
		String encodedFilename = null;
		
		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Trident")) {		// IE11 문자열 깨짐 방지
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedFilename = sb.toString();
		} else {
			throw new IOException("Not supported browser");
		}
		
		
		/*    
		 * 2021.07.02    파일명에 , 포함되는 경우 에러 방지를 위해
		 * dispositionPrefix + encodedFilename   <-   이전 코드를 하나의 문자열로 만듦
		 */
		String full_file_name = dispositionPrefix + encodedFilename + "\"";
		/*
		 * 
		 */
		
		response.setHeader("Content-Disposition", full_file_name);			//	2021.07.02 이전 구문 : dispositionPrefix + encodedFilename);

		if ("Opera".equals(browser)){
			response.setContentType("application/octet-stream;charset=UTF-8");
		}
		
		logger.debug("{}, {}, Content-Disposition:{}", new String[] {request.getRemoteAddr(),browser, full_file_name } );			//	2021.07.02 이전 구문 : dispositionPrefix + encodedFilename);
    }
    
    
    @SuppressWarnings("unchecked")
    @Override
    protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        FileDownloadInfo downloadInfo = (FileDownloadInfo) model.get(ViewerSupport.DATA_SOURCE_KEY);
        
        
        String path = downloadInfo.getFile().toString();         
        File file = new File("D:"+path);    
                      
        //File file = downloadInfo.getFile();        
        
        logger.debug(downloadInfo.toString());
        if (file == null || !file.canRead()) {            
            throw new FileNotFoundException("File not found!");
        } else {
            long seek_start = 0L;
            byte abyte0[] = null;

            String seek_range = request.getHeader("Range");
            //String sendFileName = ObjUtils.nvl(downloadInfo.getOriginalFileName(),file.getName());
            String sendFileName = ObjUtil.nvl(StringUtil.getUrlDecode(downloadInfo.getOriginalFileName()),file.getName());
            

            //sendFileName = new String(sendFileName.getBytes("UTF-8"), "ISO-8859-1");
            
            String ext = FileSupport.getExtension(sendFileName);
            String mimeType = downloadInfo.getContentType();
            if(mimeType == null) {
                if ("xlsx".equalsIgnoreCase(ext) || "xls".equalsIgnoreCase(ext)) {
                    mimeType = "application/vnd.ms-excel;charset=UTF-8";
                } else if ("docx".equalsIgnoreCase(ext) || "doc".equalsIgnoreCase(ext)) {
                    mimeType = "application/vnd.ms-word;charset=UTF-8";
                } else if ("pptx".equalsIgnoreCase(ext) || "ppt".equalsIgnoreCase(ext)) {
                    mimeType = "application/vnd.ms-powerpoint;charset=UTF-8";
                } else {
                    mimeType = "application/x-download;";						//		<-- 	2021.07.02 설정해 보았으나 의미 없음, 원래 값 octet-stream
                }
            }
            response.setContentType(mimeType);
            
            // sendFileName = java.net.URLEncoder.encode(sendFileName, "UTF-8");
            
            /*
            boolean inline_yn = downloadInfo.isInLineYn();
            String agent = request.getHeader("USER-AGENT");
            String rawFileName = null;
            if (agent.indexOf("MSIE") != -1) {
                rawFileName = java.net.URLEncoder.encode(sendFileName, "UTF-8").replaceAll("\\+", "%20");
                
            } else {
                rawFileName = I18n.convertTo(sendFileName, "utf-8", "utf-8");
            }
            rawFileName = rawFileName.replace("+", " ");
            

            StringBuffer disposition = new StringBuffer(30);
            if(inline_yn) {
                disposition.append("inline; "); // 뒤에 space 주의 !!
            } else {
                disposition.append("attachment; "); // 뒤에 space 주의 !!
            }
            disposition.append("filename=\"");
            disposition.append(rawFileName);
            disposition.append("\"");
            response.setHeader("Content-Disposition", disposition.toString());
             */
            
            //logger.debug(request.getRemoteAddr() + "," + agent + ", Content-Disposition:" + disposition.toString());
            //logger.debug("{}, {}, Content-Disposition:{}", new String[] {request.getRemoteAddr(),agent, disposition.toString() } );
            
            setDisposition(sendFileName, request, response);
            // 전송되는 데이터의 인코딩이 바이너리 타입이라는 것을 명시.
            response.setHeader("Content-Transfer-Encoding", "binary");

            if (seek_range != null) {
                long l1 = 0L;
                int i1 = seek_range.indexOf('=') + 1;
                int j1 = seek_range.indexOf('-');
                String s8 = seek_range.substring(i1, j1);
                seek_start = Long.parseLong(s8);
                l1 = file.length() - seek_start;
                if (l1 < 0L) {
                    l1 = 0L;
                }
                response.setHeader("Content-Range", Long.toString(seek_start) + "-" + (l1 - 1L) + "/" + file.length());
                response.setContentLength((int) l1);
            } else {
                response.setContentLength((int) file.length());
            }

            response.setHeader("Cache-Control", "no-cache, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");

            abyte0 = new byte[DEFAULT_BUF_SIZE];
            RandomAccessFile randomAccessFile = new RandomAccessFile(file, "r");
            if (seek_range != null) {
                randomAccessFile.seek(seek_start);
            }
            ServletOutputStream servletUutputStream = response.getOutputStream();

            int j = 0;
            try {
                int i = 0;
                while ((i = randomAccessFile.read(abyte0, 0, DEFAULT_BUF_SIZE)) != -1) {
                    servletUutputStream.write(abyte0, 0, i);
                    servletUutputStream.flush();
                    j += i;
                }
            } finally {
                if (randomAccessFile != null) {
                    try {
                        randomAccessFile.close();
                    }catch (IOException e) {
                    	logger.error("IOException error===", e);
                    } catch (NullPointerException e) {
                    	logger.error("NullPointerException error===", e);
                    }
                }
                if (servletUutputStream != null) {
                    try {
                        servletUutputStream.close();
                    }catch (IOException e) {
                    	logger.error("IOException error===", e);
                    } catch (NullPointerException e) {
                    	logger.error("NullPointerException error===", e);
                    }
                }
                randomAccessFile = null;
                servletUutputStream = null;
                HttpSession session = request.getSession();
                session.setAttribute("processSimulator", "end_process");
            }
        }
    }
}
