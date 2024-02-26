package kr.apfs.local.common.util.fileupload;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.apfs.local.common.util.ConfigUtil;
import kr.apfs.local.common.util.StringUtil;

public class UploadedFileUtil  {
    

    private static final Logger logger = LoggerFactory.getLogger(UploadedFileUtil.class);

    /**
     * Create new File
     * 
     * @param f
     * @return [true] if the named file does not exist and was successfully created; [false] if the named file already
     *         exists
     */
    protected static boolean createNewFile(File f) {
        try {
            return f.createNewFile();
        } catch (IOException ignored) {
            return false;
        }
    }

    /**
     * getUniq file Name
     * 
     * @param f
     * @return
     */
    public static File uniqueFile(File f) {
        if (createNewFile(f)) {
            return f;
        }
        String name = f.getName();
        String body = null;
        String ext = null;

        int dot = name.lastIndexOf(".");
        if (dot != -1) {
            body = name.substring(0, dot) + "_(";
            ext = ")" + name.substring(dot); // includes "."
        } else {
            body = name + "_(";
            ext = ")";
        }

        int count = 0;
        while (!createNewFile(f) && count < 9999) {
            count++;
            String newName = body + count + ext;
            f = new File(f.getParent(), newName);
        }

        return f;
    }


    protected static void _deleteFile(String tempFilename) {
        try {
            java.io.File f = new java.io.File(tempFilename);
            if (f != null) {
                f.delete();
            }
        }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
    }

    /**
     * 파일을 filePath경로에 newFileName으로 저장 한다.
     * canOverwrite이 true 이면 기존 파일을 덮어 쓰며 false이면 새로운 파일명을 만들어 저장 한다.
     * 
     * @param dto
     * @param filePath
     * @param newFileName
     * @param canOverwrite
     * @return
     * @throws Exception
     */
    public static String saveAs(FileUploadModel dto, String filePath, String newFileName, boolean canOverwrite)
                    throws Exception {
        File newFile = null;
        if (dto.getSize() > 0) {
            try {
                FileSupport.checkAndMakeDir(filePath);
                newFile = new File(filePath, newFileName);
                if (!canOverwrite) {
                    newFile = uniqueFile(newFile);
                }
                InputStream fis = null;
                
                try{
                	fis = dto.getInputStream();
	                if (FileSupport.streamToFile(fis, newFile)) {
	                    dto.setNewFileName(newFile.getName());
	                    dto.setFileStreCours(filePath);
	/*                    if (logger.isDebugEnabled()) {
	                        StringBuffer msg = new StringBuffer();
	                        msg.append(" > UploadedFile.SaveAS() : [" + dto.getFieldName() +"] ");
	                        msg.append(" '"+dto.getFilename() + "' save as '"+newFile.getName()+"'");
	                        
	                        logger.debug("msg");
	                    }*/
	                    //업로드 파일이 이미지 파일일경우 피일 넚이 높이값을 계산해서 넣어준다 
	                    /*String ext = FileSupport.getExtension(newFile);
	                    String[] img_exts  = ConfigUtil.getStringArrayValue("fileType.types.img");
	                    boolean imgYn = StringUtil.splitExistYn(img_exts,ext);
	                    if(imgYn){
	                    	BufferedImage sourceImage = ImageIO.read(newFile);
	                    	dto.setImgHeight(sourceImage.getHeight());
	                    	dto.setImgWidth(sourceImage.getWidth());
	                    }*/
	                    // mms 서버에 올릴 확장자의 경우 자동으로 mms서버에 업로드 !
	                    //if (uploadToMMS && FileSupport.isMmsFile(newFile)) {
	                    //MMSUtil.storeFile(newFile);
	                    //}
                	}
                else {
                    throw new Exception("Can't make " + newFileName +","+ newFile);
                }
                }catch(IOException e){
                	logger.error("IOException : " + e);
                }
                finally{
            		if (fis != null) {
        	       		try {
        	       			fis.close();
        	       		} catch (IOException e) {
        	       			logger.error("IOException error===", e);
        	       			}
        	       	}
            	}
                // }
            }catch (IOException e) {
            	logger.error("IOException error===", e);
            	return null;
            } catch (NullPointerException e) {
            	logger.error("NullPointerException error===", e);
            	return null;
            } catch (Throwable e) {
                if (newFile != null) {
                    newFile.delete();
                }

                logger.error("UploadedFile.SaveAS()  : " + filePath + ", " + newFileName + " :" + e.getMessage());
                throw new Exception(e.getMessage(), e);
            }
        } else {
            return null;
        }
        return newFile.getName();

    }

    /**
     * Check Request Type is Multipart
     * 
     * @param hRequest
     * @return true=Multipart, false=normal;
     */
    public static boolean isMultiPart(HttpServletRequest hRequest) {
        return (hRequest.getHeader("content-type") != null && hRequest.getHeader("content-type").indexOf("multipart/form-data") != -1);
    }
}