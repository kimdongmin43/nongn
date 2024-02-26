package kr.apfs.local.common.support;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.apfs.local.common.util.ConfigUtil;
import kr.apfs.local.common.util.ExtHtttprequestParam;
import kr.apfs.local.common.util.FileUploadUtil;
import kr.apfs.local.common.util.StringUtil;
import kr.apfs.local.common.util.fileupload.FileUploadModel;
import kr.apfs.local.common.util.fileupload.SessionUpdatingProgressListener;

public class RequestParamParser  {
    private static final Logger logger = LoggerFactory.getLogger(RequestParamParser.class);
    private static final String EXPTION_XSS_PARAM = "CONTENTS";  
    
    public static ExtHtttprequestParam parse(HttpServletRequest request) throws Exception {
        ExtHtttprequestParam extParam = new ExtHtttprequestParam();
        extParam.setMultiPart(ServletFileUpload.isMultipartContent(request));
        if (extParam.isMultiPart()) {
            logger.debug("request is MultipartContent!");
            if(request instanceof MultipartHttpServletRequest) {
                springMultiParseReq((MultipartHttpServletRequest) request, extParam);
            } else {
                multiPartParseReq(request, extParam);
            }
        } else {
            httpRequestParse(request, extParam);
        }

        return extParam;
    }

    /**
     * 
     * @param request
     * @throws SysException
     */
    @SuppressWarnings("unchecked")
	public static  void httpRequestParse(HttpServletRequest request, ExtHtttprequestParam extParam) throws Exception {
        Map<String, Object> hParam = new HashMap<String, Object>();
        
        try {
            //String paramName = null;
            Enumeration<String> names = request.getParameterNames();
            while( names.hasMoreElements()) {
            	String paramName = (String)names.nextElement();
                if (paramName != null && !paramName.equals("")) {                	
                	/*if(EXPTION_XSS_PARAM.indexOf(paramName.toUpperCase()) > -1)*/
                	if(paramName.toUpperCase().indexOf(EXPTION_XSS_PARAM)>-1)
                	{                		
                		if(request.getRequestURI().substring(0, 5).equals("/back"))
                		{
                			hParam.put(paramName, request.getParameterValues(paramName));
                		}else{
                			hParam.put(paramName, StringUtil.getXssScript(request.getParameterValues(paramName)));
                		}
                	}
                	else
                	{            
                		if(request.getRequestURI().substring(0, 5).equals("/back"))
                		{
                			hParam.put(paramName, request.getParameterValues(paramName));
                		}else{
                			hParam.put(paramName, StringUtil.getXssValues(request.getParameterValues(paramName)));
                		}
                	}
                }
            }
        }catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }catch (Exception e) {
            logger.error(e.getMessage());
            throw new Exception(e);
        }

        trimTrailingWhitespace(hParam);
        extParam.setParam(hParam);
        //System.out.println(extParam);
    }

    private static void springMultiParseReq(MultipartHttpServletRequest hReq, ExtHtttprequestParam extParam) throws Exception {

        String paramName = null;
        List<String> values = null;
        
        Map<String, List<String>> tempParamMap = new HashMap<String, List<String>>();
        // Map<String, List<FileUploadModel>> fileListMap = new HashMap<String, List<FileUploadModel>>();
        List<MultipartFile> fieldItemList  = new ArrayList<MultipartFile>();
        Map<String, MultipartFile> mFileMap = hReq.getFileMap();
        Set<String> keys = mFileMap.keySet();
        for(String key : keys) {
            fieldItemList.addAll(hReq.getFiles(key));
        }
        logger.debug("Spring MultiPartfile Uploaded File field count is  {}", fieldItemList.size());
        logger.debug("####  CharacterEncoding is {}", hReq.getCharacterEncoding());
        
        Map<String, List<FileUploadModel>> fileListMap = new HashMap<String, List<FileUploadModel>>();
        FileUploadModel  fileModel = null;
        for (MultipartFile item : fieldItemList) {
        	fileModel = new FileUploadModel(item);
        	if(FileUploadUtil.badFileExtIsReturn(fileModel.getOriginalFileName())){
        		return;
        	}
        	
            paramName = item.getName();
            String tempParamName = paramName;

            if (tempParamMap.containsKey(tempParamName)) {
                values = tempParamMap.get(tempParamName);
            } else {
                values = new ArrayList<String>();
            }
            if (item.getSize() > 0) {
                values.add(item.getName());
                tempParamMap.put(tempParamName, values);
                List<FileUploadModel> tempList = fileListMap.get(tempParamName);
                if (tempList == null) {
                    tempList = new ArrayList<FileUploadModel>();
                }
                tempList.add(fileModel);
                fileListMap.put(tempParamName, tempList);
            }
        }
        Map<String, Object> hParam = new HashMap<String, Object>();
        
        Enumeration<String>  names = hReq.getParameterNames();
        while( names.hasMoreElements()) {
            paramName = names.nextElement();

            String[] tVals = hReq.getParameterValues(paramName);
        	tempParamMap.put(paramName, Arrays.asList(tVals));
        	if(paramName.toUpperCase().indexOf(EXPTION_XSS_PARAM)>-1)
        	{                		
        		hParam.put(paramName, StringUtil.getXssScript(hReq.getParameterValues(paramName)));
        	}
        	else
        	{
        		hParam.put(paramName, StringUtil.getXssValues(hReq.getParameterValues(paramName)));
        	}
        }

        /**
         * Arrage Request Data
        */
        
        Iterator<String> iterKeys = tempParamMap.keySet().iterator();
        while (iterKeys.hasNext()) {
            String key = iterKeys.next();
            List<String> valueList = tempParamMap.get(key);            
            /*if(EXPTION_XSS_PARAM.indexOf(paramName.toUpperCase()) > -1){*/            
            if(key.toUpperCase().indexOf(EXPTION_XSS_PARAM)>-1){        		   	    
        		hParam.put(key, StringUtil.getXssScript(valueList.toArray(new String[0])));        	
        	}
        	else
        		hParam.put(key, StringUtil.getXssValues(valueList.toArray(new String[0])));
        }

        trimTrailingWhitespace(hParam);
        extParam.setParam(hParam);
        extParam.setUploadedFiles(fileListMap);
    }
    /**
     * Multipart Parsing
     * @param hReq
     * @throws Exception
     */
    private static void multiPartParseReq(HttpServletRequest hReq, ExtHtttprequestParam extParam) throws Exception {

        Map<String, List<String>> tempParamMap = new HashMap<String, List<String>>();

        String paramName = null;
        List<String> values = null;

        Map<String, List<FileUploadModel>> fileListMap = new HashMap<String, List<FileUploadModel>>();

        List<DiskFileItem> fieldItemList = getUploadFileList(hReq);
        if (fieldItemList == null) {
            logger.debug("Uploaded field count is null ");
        } else {
            logger.debug("Uploaded field count is  {}", fieldItemList.size());
        }
        logger.debug("####  CharacterEncoding is {}", hReq.getCharacterEncoding());
        FileUploadModel  fileModel = null;
        for (DiskFileItem item : fieldItemList) {
        	fileModel = new FileUploadModel(item);
            if(FileUploadUtil.badFileExtIsReturn(fileModel.getOriginalFileName())){
            	return;
            }

            paramName = item.getFieldName();
            logger.debug("Field {} is formfield {}.", new String[] { paramName, item.isFormField() + "" });
            String tempParamName = paramName;

            if (tempParamMap.containsKey(tempParamName)) {
                values = tempParamMap.get(tempParamName);
            } else {
                values = new ArrayList<String>();
            }

            if (item.isFormField()) {
                values.add(new String(item.getString().getBytes("ISO8859_1"), hReq.getCharacterEncoding()));
                tempParamMap.put(tempParamName, values);
            } else {
                if (item.getSize() > 0) {
                    values.add(item.getName());
                    tempParamMap.put(tempParamName, values);
                    List<FileUploadModel> tempList = fileListMap.get(tempParamName);
                    if (tempList == null) {
                        tempList = new ArrayList<FileUploadModel>();
                    }
                    tempList.add(fileModel);
                    fileListMap.put(tempParamName, tempList);
                }
            }
        }

        Map<String, Object> hParam = new HashMap<String, Object>();
        Iterator<String> iterKeys = tempParamMap.keySet().iterator();

        while (iterKeys.hasNext()) {
            String key = iterKeys.next();
            List<String> valueList = tempParamMap.get(key);
         
            if(paramName.toUpperCase().indexOf(EXPTION_XSS_PARAM)>-1)
        		hParam.put(key, StringUtil.getXssScript(valueList.toArray(new String[0])));
        	else
        		hParam.put(key, StringUtil.getXssValues(valueList.toArray(new String[0])));
        }

        trimTrailingWhitespace(hParam);
        extParam.setParam(hParam);
        extParam.setUploadedFiles(fileListMap);

    }

    /**
     * remove TrailingWhitespace of parameter's value
     */
    private static  void trimTrailingWhitespace(Map<String, Object> inputData) {
        String[] tStrs = null;
        List<String> tmpArray = new ArrayList<String>();
        for (String paramName : inputData.keySet()) {

            tStrs = (String[]) inputData.get(paramName);
            tmpArray.clear();
            for (String t : tStrs) {
                tmpArray.add(StringUtils.trimTrailingWhitespace(t));
            }
            inputData.put(paramName, tmpArray.toArray(new String[tmpArray.size()]));
        }
    }

    /**
     * MultiPart HttpServletRequest -> List of DiskFileItem
     * 
     * @param hReq
     * @return
     * @throws FileUploadException
     * @throws RequestParsingException
     * @throws FWException
     */
    @SuppressWarnings("unchecked")
    public static  List<DiskFileItem> getUploadFileList(HttpServletRequest hReq) throws FileUploadException {

        int maxSizeMega =  ConfigUtil.getIntValue("common.upload.MaxFileSize", 100);
        DiskFileItemFactory factory = null;
        ServletFileUpload servletFileUpload = null;

        int maxSize = maxSizeMega * 1024 * 1024;
        logger.debug("MaxFile Size is {}.", maxSize);

        int sizeThreshold = 1024 * 1024 * 2;
        factory = new DiskFileItemFactory();
        factory.setSizeThreshold(sizeThreshold);

        servletFileUpload = new ServletFileUpload(factory);
        servletFileUpload.setSizeMax(maxSize);

        ProgressListener progressListener = new SessionUpdatingProgressListener(hReq);
        servletFileUpload.setProgressListener(progressListener);

        return servletFileUpload.parseRequest(hReq);
    }
}