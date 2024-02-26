package kr.apfs.local.common.util.fileupload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;







public class FileDownloadInfo {
    
    /**
     * 
     */
    private static final long serialVersionUID = -8594092365759476575L;

    File file = null;
    
    String fileName = null;
    String originalFileName = null;
    String contentType = null;
    String path = null;
    boolean inLineYn = false;
    boolean isStream = false;
    OutputStream stream = null;
    
    
    /**
     * @return the isStream
     */
    public boolean isStream() {
        return isStream;
    }
    /**
     * @param isStream the isStream to set
     */
    public void setStream(FileOutputStream stream) {
        this.isStream = true;
        this.stream = stream;
    }
    
    
    public OutputStream getStream() {
        return this.stream;
    }
    
    
    public FileDownloadInfo() {
        
    }
    
    public FileDownloadInfo(String path, String fileName,String orginFileName) {
        this.fileName = fileName.replaceAll("\\.","").replaceAll("/","").replaceAll("\\\\","");
        this.path = path.replaceAll("\\.","").replaceAll("/","").replaceAll("\\\\","");
        this.originalFileName = orginFileName;
        this.file = new File(path, fileName);
    }
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getOriginalFileName() {
        return originalFileName;
    }

    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }

    public boolean isInLineYn() {
        return inLineYn;
    }

    public void setInLineYn(boolean inLineYn) {
        this.inLineYn = inLineYn;
    }

    public File getFile() {
        return file;
    }

    public void setFile(File file) {
        this.file = file;
    }
    public String getContentType() {
        return contentType;
    }
    public void setContentType(String contentType) {
        this.contentType = contentType;
    }
    public String getPath() {
        return path;
    }
    public void setPath(String path) {
        this.path = path;
    }

}
