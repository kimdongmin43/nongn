package kr.apfs.local.common.util.fileupload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.apfs.local.common.util.ConfigUtil;
import kr.apfs.local.common.util.ObjUtil;







public class FileSupport {
    private static final Logger logger = LoggerFactory.getLogger(FileSupport.class);
    
    private static final String[] MMS_FILE_EXTS = ConfigUtil
            .getStringArrayValue("fileType.mms");

    /**
     * 해당파일의 icon 이미지를 읽어옮 /src/config4j.xml 의 fileType 참조
     * 
     * @param fileName
     * @return
     */
    public static String getIconImage(String fileName) {
        return FileExtensionHelper.getInstance().getIconImage(fileName);
    }

    /**
     * 파일명의 일반적 타입을 돌려줌 없으면 null;
     * 
     * @param fileName
     * @return
     */
    public static String getGeneralFileType(String fileName) {
        return FileExtensionHelper.getInstance().getGeneralFileType(fileName);
    }

    /**
     * 스트리밍파일 여부 확인
     * 
     * @param fileName
     * @return
     */
    public static boolean isMmsFile(String fileName) {
        String fileExt = getExtension(fileName);
        for (String ext : MMS_FILE_EXTS) {
            if (ext.equals(fileExt)) {
                return true;
            }
        }
        return false;

    }

    /**
     * 스트리밍파일 여부 확인
     * 
     * @param fileName
     * @return
     */
    public static boolean isMmsFile(File file) {
        if (file != null) {
            return isMmsFile(file.getName());
        }
        return false;

    }

    /**
     * 파일의 확장자를 구분하여 파일구분을 한다 0:일반 1:동영상
     * 
     * @param fileName
     *            : 파일이름
     * @return 0:일반 1:동영상
     */
    public static int getFileTypeGubun(String fileName) {
        // String ext = getGeneralFileType(fileName)
        if (FileExtensionHelper.DEFAULT_MOVIE_TYPE
                .equals(getGeneralFileType(fileName))) {
            return 1;
        } else {
            return 0;
        }
        // int mimeType = getTypeByName(fileName);
        // if (mimeType == FileExtensionHelper.TYPE_MOVIE) {
        // return 1;
        // }
        // return 0;
    }

    /**
     * 파일을 삭제 한다. *
     * 
     * @param folder
     *            폴더명
     * @param fileName
     *            파일명
     * @return 삭제 여부
     */
    public static boolean deleteFile(String folder, String fileName) {
        boolean res = true;
        folder = folder.replaceAll("\\.","").replaceAll("/","").replaceAll("\\\\","");
        fileName = fileName.replaceAll("\\.","").replaceAll("/","").replaceAll("\\\\","");
        File file = new File(folder, fileName);
        res = file.delete();
        return res;
    }

    /**
     * List<Map<String, Object>> 형식에서 파일명에 대해 파일타입을 map에 추가한다.
     * 
     * @param list
     *            데이터
     * @param column
     *            파일명이 들어있는 Map 키값
     * @return 추가된 데이터
     */
    public static List<Map<String, Object>> addFileType(
            List<Map<String, Object>> list, String column) {
        return addFileType(list, column, "file_type");
    }

    /**
     * List<Map<String, Object>> 형식에서 파일명에 대해 파일타입을 map에 추가한다.
     * 
     * @param list
     *            데이터
     * @param column
     *            파일명이 들어있는 Map 키값
     * @param fileType
     *            추가시킬 컬럼명
     * @return 추가된 데이터
     */
    public static List<Map<String, Object>> addFileType(
            List<Map<String, Object>> list, String column, String fileType) {
        for (Map<String, Object> map : list) {
            // map.put(fileType, getFileType(ObjUtil.getStr(map.get(column))));
            map.put(fileType, getIconImage(ObjUtil.getSafeString(map.get(column))));
        }
        return list;
    }

    // /**
    // * 파일의 확장자를 구분하여 이미지 아이콘을 반환한다.
    // *
    // * @param fileName
    // * @return
    // */
    // private static String getFileType(String fileName) {
    // int mimeType = getTypeByName(fileName);
    // String imageType = "";
    //
    // switch (mimeType) {
    // case FileExtensionHelper.TYPE_PICTURE:
    // imageType = "ico_img";
    // break;
    // case FileExtensionHelper.TYPE_ARCHIVE:
    // imageType = "ico_zip";
    // break;
    // case FileExtensionHelper.TYPE_PDF:
    // imageType = "ico_pdf";
    // break;
    // case FileExtensionHelper.TYPE_DOC:
    // imageType = "ico_doc";
    // break;
    // case FileExtensionHelper.TYPE_PPT:
    // imageType = "ico_ppt";
    // break;
    // case FileExtensionHelper.TYPE_EXCEL:
    // imageType = "ico_xls";
    // break;
    // case FileExtensionHelper.TYPE_HWP:
    // imageType = "ico_hwp";
    // break;
    // case FileExtensionHelper.TYPE_MOVIE:
    // imageType = "ico_movie";
    // break;
    // default:
    // imageType = "ico_etc";
    // break;
    // }
    //
    // return imageType;
    // }

    /**
     * 첨부파일의 갯수를 넘겨주어 2개 이상이면 외 [파일갯수-1]로 표현
     * 
     * @param fileCount
     * @return
     */
    public static String getFileExtCount(int fileCount) {
        if (fileCount > 1) {
            return "&nbsp;외[" + (fileCount - 1) + "]";
        }
        return "";
    }

    // public static int getTypeByName(String name) {
    // String extension = FileExtensionHelper.getExtension(name);
    // return getType(extension);
    // }
    //
    // public static int getType(String extension) {
    // return FileExtensionHelper.getType(extension);
    // }

    public static boolean streamToFile(InputStream fi, File DestFile) {
        boolean chk = false;
        FileOutputStream fo = null;
        try {
            fo = new FileOutputStream(DestFile);
            if (fi != null && fo != null) {
                byte[] b = new byte[1024];
                int numRead = fi.read(b);
                while (numRead != -1) {
                    fo.write(b, 0, numRead);
                    numRead = fi.read(b);
                }
                fo.flush();
                // logger.info("Moved file="+SrcFile+" outputFile="+DestFile);
                chk = true;
            } else {
                if (DestFile != null) {
                    DestFile.delete();
                }
            }
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
            try {
                if (DestFile != null) {
                    DestFile.delete();
                }
            }catch (NullPointerException ex) {
            	logger.error("NullPointerException error===", ex);
            }

         finally {
            if (fi != null)
                try {
                    fi.close();
                    fi = null;
                }catch (IOException e) {
                	logger.error("IOException error===", e);
                } catch (NullPointerException e) {
                	logger.error("NullPointerException error===", e);
                }
            if (fo != null)
                try {
                    fo.close();
                    fo = null;
                }catch (IOException e) {
                	logger.error("IOException error===", e);
                } catch (NullPointerException e) {
                	logger.error("NullPointerException error===", e);
                }
        }
        return chk;
    }

    /**
     * 대상폴더의 존재여부 확인 후 없으면 폴더를 생성 한다.
     * 
     * @param FilePath
     * @throws FileUtilsException
     */
    public static void checkAndMakeDir(String FilePath) throws Exception {
        // 파일패스 뒤에 separator가 있는지 확인한다.
        FilePath = chkSeparator(FilePath);
        // 복사할 곳에 디렉토리가 있는지 확인한다.
        if (!existDirectory(FilePath)) {
            // 디렉토리가 없으면 만든다.
            createDirectory(FilePath);
        }
    }

    /*******************************************************************************************************************************
     * 파일 패스 뒤에 \ 혹은 / 이 없으면 붙여주는 메서드
     * <p>
     * @ param path 파일패스
     * <p>
     * @ param
     * <p>
     * @ return tempp 고쳐진 파일 패스
     * <p>
     ******************************************************************************************************************************/
    public static String chkSeparator(String path) {
        String tempp = "";
        try {
            tempp = path;
            if (!tempp.substring(tempp.length() - 1, tempp.length()).equals(
                    File.separator)) {
                tempp = tempp + File.separator;
            }
        }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
        return tempp;
    }

    /*******************************************************************************************************************************
     * 디렉토리가 있는지 확인한다.
     * <p>
     * @ param path 파일패스
     * <p>
     * @ return true:디렉토리 있음, false:디렉토리없음
     * <p>
     ******************************************************************************************************************************/
    public static boolean existDirectory(String path) {
        boolean i = false;
        try {
            File f = new File(path);
            i = f.exists();
        }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	i = false;
        }
        return i;
    }

    /*******************************************************************************************************************************
     * 디렉토리를 생성한다.
     * <p>
     * @ param path 파일패스
     * <p>
     * @ return true:성공,false:실패
     * <p>
     ******************************************************************************************************************************/
    public static void createDirectory(String path) throws Exception {
        boolean flag = false;
        try {
        	//System.out.println("-----------------------------------------------------------------------File Upload Path > "+path);
        	path = path.replaceAll("\\.","").replaceAll("/","").replaceAll("\\\\","");
            File f = new File(path);
            File fp = f.getParentFile();
            if (!fp.exists()) {
                createDirectory(fp.getPath());
            }
            if (!f.exists()) {
                flag = f.mkdir();
                logger.info("Created Directory: {}", f.getPath());
                if (!flag) {
                    throw new Exception("Can't make dir : " + path);
                }
            }
        }catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        } catch (Exception e) {
            throw new Exception(e.getMessage(), e);
        }
    }

    public static String getExtension(File file) {
        if (file != null) {
            return getExtension(file.getName());
        }
        return "";
    }

    /**
     * 파일명의 확장자를 가져옮
     * 
     * @param fileName
     * @return
     */
    public static String getExtension(String fileName) {
        if (fileName.startsWith(".")) {
            return fileName.substring(1);
        }
        String[] tokens = fileName.split("\\.");

        if (tokens.length == 1)
            return "";
        return tokens[(tokens.length - 1)];

    }
}