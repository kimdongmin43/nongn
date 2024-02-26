package kr.apfs.local.common.util.fileupload;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import kr.apfs.local.common.util.ConfigUtil;
import kr.apfs.local.common.util.ObjUtil;







public class FileExtensionHelper {

    private final Logger logger = LoggerFactory.getLogger(getClass());
    
//  public static final int TYPE_PICTURE = 0;
//  public static final int TYPE_ARCHIVE = 1;
//  public static final int TYPE_PDF = 2;
//  public static final int TYPE_DOC = 3;
//  public static final int TYPE_PPT = 4;
//  public static final int TYPE_EXCEL = 5;
//  public static final int TYPE_HWP = 6;
//  public static final int TYPE_MOVIE = 7;
//  public static final int TYPE_DATA = 8;

    private static FileExtensionHelper instance = null;
    /**
     * 확장자별 type map
     */
    private Map<String, String> typeMap = new HashMap<String, String>();
    /**
     * 타입별 이미지 map
     */
    private Map<String, String> imageMap = new HashMap<String, String>();

    private final static String DEFAULT_IMG_KYE = "default";
    public final static String DEFAULT_MOVIE_TYPE = "movie";

    public static synchronized FileExtensionHelper getInstance() {
        if ( instance == null) {
            instance = new FileExtensionHelper();
        }
        return instance;
    }

    private FileExtensionHelper() {
        final String base = "fileType.";
        final String typeBase = base + "types.";
        final String imgBase = base + "images.";

        imageMap.put(DEFAULT_IMG_KYE, ConfigUtil.getString( imgBase + DEFAULT_IMG_KYE));

        String[] names = ConfigUtil.getStringArrayValue(base + "names");
        if (names != null) {
            logger.debug("Names : " + StringUtils.arrayToCommaDelimitedString(names)) ;
            for (String key : names) {
                String img = ConfigUtil.getString(imgBase + key);
                imageMap.put(toLower(key), img);
            }
            for (String key : names) {
                String[] exts = ConfigUtil.getStringArrayValue(typeBase+key );
                if (exts != null) {
                    for (String ext : exts) {
                        typeMap.put(toLower(ext), toLower(key));
                    }
                }
            }
//            logger.debug("-----typeMap------");
//            logger.debug(HashUtil.map2String(typeMap));
//            logger.debug("-----imageMap------");
//            logger.debug(HashUtil.map2String(imageMap));

        }
    }

    /**
     * 해당파일의 icon 이미지를 읽어옮 /src/config4j.xml 의 fileType 참조
     * 없으면 "";
     * @param fileName
     * @return
     */
    public String getIconImage(String fileName) {
        String img = null;

        img = imageMap.get(getGeneralFileType(fileName));

        if (img == null) {
            img = imageMap.get(DEFAULT_IMG_KYE);
        }
        return ObjUtil.nvl(img, "");
    }

    /**
     * 파일명의 일반적 타입을 돌려줌 없으면 null;
     * 
     * @param fileName
     * @return
     */
    public String getGeneralFileType(String fileName) {
        return typeMap.get(toLower(FileSupport.getExtension(fileName)));
    }

    /**
     * 소문 자로 변경 
     * @param obj
     * @return
     */
    private String toLower(String obj) {
        if(obj != null) {
            return obj.toLowerCase();
        } else {
            return "";
        }
    }



}
