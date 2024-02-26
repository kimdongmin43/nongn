package kr.apfs.local.common.util.fileupload;

import java.util.HashMap;
import java.util.Map;

public class UploadStatus {

    private Map infoMap = null;
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    public final static String SESSION_KEY = UploadStatus.class.getName()
            + ".SESSION_KEY";
    public final static String DEFAULT_FID = "0";
    public final static String PARAMETER_KEY = "UPLOAD_IDENTIFIER";

    public UploadStatus() {
        infoMap = new HashMap();
    }

    // public void addUploadStatus(String fid, UploadStatusInfo info) {
    // infoMap.put(makeFid(fid), info);
    // }

    public UploadStatusInfo getUploadStatus(String fid) {
        UploadStatusInfo info = chkStatusInfo(fid);
        if (info == null) {
            info = new UploadStatusInfo();
            infoMap.put(makeFid(fid), info);
        }
        return info;
    }

    public void update(String fid, int items, long bytesRead, long contentLength) {
        UploadStatusInfo info = chkStatusInfo(fid);
        if (info == null) {
            info = new UploadStatusInfo();

        }

        info.setBytesRead(bytesRead);
        info.setContentLength(contentLength);
        info.setItems(items);
        infoMap.put(makeFid(fid), info);
    }

    private String makeFid(String fid) {
        if (fid == null) {
            return DEFAULT_FID;
        } else {
            return fid;
        }
    }

    private UploadStatusInfo chkStatusInfo(String fid) {
        return (UploadStatusInfo) infoMap.get(makeFid(fid));
    }
}
