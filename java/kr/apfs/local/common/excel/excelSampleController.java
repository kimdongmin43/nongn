package kr.apfs.local.common.excel;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.apfs.local.common.util.CommonUtil;
import kr.apfs.local.common.util.ExcelUtil;


@Controller
@RequestMapping("/test")
public class excelSampleController {
	
	private static final Logger logger = LogManager.getLogger(excelSampleController.class);
    
    @Autowired
    private MessageSource messageSource;

    
    
	/**
	 * 엑셀 파일로 다운받기 예제
	 * @param map : 모델맵
	 * @param req : HttpServletRequest
	 * @param resp : HttpServletResponse
	 */
    @RequestMapping(value = "excelDownload.do")
    public void excelDownload(ModelMap map, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
    	//엑셀의 헤더 설정
		List headerName = new ArrayList();
		headerName.add("1번");
		headerName.add("2번");
		headerName.add("3번");
		headerName.add("4번");
		headerName.add("5번");
		
		//다운받을 데이타 조회
		List colValue = new ArrayList();
/*		List<JobHistoryVO> list = jobHistoryDao.getJobHistoryList();
		for(int i=0; i < list.size(); i++ ) {
			JobHistoryVO vo = list.get(i);
			String[] arrValue = new String[5];
			arrValue[0] = vo.getHost_ip();
			arrValue[1] = vo.getHost_name();
			arrValue[2] = vo.getEvent_type();
			arrValue[3] = vo.getEvent_name();
			arrValue[4] = vo.getScheduler_name();
			colValue.add(arrValue);
		}*/
		
		//엑셀 생성
    	Workbook workbook = new SXSSFWorkbook(100); //엑셀 2007 이상인 경우 사용, 대용량 엑셀처리에 적함(쓰기전용임), 100 row마다 파일로 flush
    	//Workbook workbook = new XSSFWorkbook(); // 엑셀 2007 이상인 경우 사용
    	//Workbook workbook = new HSSFWorkbook(); // 엑셀 97~2003 버전인 경우 사용
        Sheet sheet = workbook.createSheet("쉬트1"); //쉬트명
        
        //셀넓이 설정(표시할 문자수로 설정)
        sheet.setColumnWidth(0, 265*10); // Cell Width (문자수 * 256)
        sheet.setColumnWidth(1, 265*10);
        sheet.setColumnWidth(2, 265*10);
        sheet.setColumnWidth(3, 265*10);
        sheet.setColumnWidth(4, 265*10);

		// 헤더 표시
		Row headerRow = sheet.createRow(0);
		headerRow.setHeight((short) 400);
		for (int i = 0; i < headerName.size(); i++) {
			
			Cell cell = headerRow.createCell(i);
			cell.setCellValue((String)headerName.get(i));
			
			cell.setCellStyle(ExcelUtil.genericHeaderCellStyle(workbook)); //헤더의 셀 스타일 설정
		}
		
		// 데이타 표시
		for (int i = 0; i < colValue.size(); i++) {
			
			Row row = sheet.createRow(i + 1);
			row.setHeight((short) 300);
			String[] rowData =  (String[]) colValue.get(i);
			for (int j = 0; j < rowData.length; j++) {
				
				Cell cell = row.createCell(j);
				cell.setCellValue( rowData[j] );
				
				cell.setCellStyle(ExcelUtil.genericDataCellStyle(workbook));
			}
		}
		
		//다운로드 파일명 설정
    	//String fileName = "한글.xls"; // HSSFWorkbook 사용할 경우
    	String fileName = "한글.xlsx"; //SXSSFWorkbook, XSSFWorkbook 사용할 경우
		String userAgent = req.getHeader("User-Agent");
		if(userAgent.indexOf("MSIE") > -1  ||   userAgent.indexOf("Trident") > -1 ) {
			fileName = URLEncoder.encode(fileName, "utf-8");
		} else {
			fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
		}
		resp.setHeader("Content-Disposition", "attachment; filename=" + fileName);
		workbook.write( resp.getOutputStream() );
    }
    
    
    
    
	@RequestMapping(value = "excel_export.do")
	public String excelExport(@RequestParam Map params, Map modelMap) throws Exception {
		
		List colName = new ArrayList();
		colName.add("1번");
		colName.add("2번");
		colName.add("3번");
		colName.add("4번");
		colName.add("5번");

		List colValue = new ArrayList();
		
/*		List<JobHistoryVO> list = jobHistoryDao.getJobHistoryList();
		for(int i=0; i < list.size(); i++ ) {
			JobHistoryVO vo = list.get(i);
			String[] arrValue = new String[5];
			arrValue[0] = vo.getHost_ip();
			arrValue[1] = vo.getHost_name();
			arrValue[2] = vo.getEvent_type();
			arrValue[3] = vo.getEvent_name();
			arrValue[4] = vo.getScheduler_name();
			colValue.add(arrValue);
		}*/
		

		modelMap.put("fileName", "한글");
		modelMap.put("sheetName", "쉬트1");
		modelMap.put("colName", colName);
		modelMap.put("colValue", colValue);
		
		logger.debug("genericExcelView run");

		return "genericExcelView";
	}
	
	
	
	
    @RequestMapping(value = "excelUploadForm.do")
    public String excelUploadForm(ModelMap model) throws Exception {
    	return "/sample/excelUpload";
    }
    
    
    
    @RequestMapping(value = "excelUpload.do")
    public void excelUpload(ModelMap model, MultipartHttpServletRequest req,  HttpServletResponse resp) throws Exception {
    	
    	MultipartFile multipartFile = req.getFile("excel");

    	resp.setCharacterEncoding("UTF-8");
    	resp.setContentType("text/html; charset=UTF-8");
    	PrintWriter writer=resp.getWriter();
    	
		//메시지 조회
		String successMsg = messageSource.getMessage("upload.success", null, CommonUtil.getLocale(req));
		String failMsg = messageSource.getMessage("upload.fail", null, CommonUtil.getLocale(req));
		String excelonlyMsg = messageSource.getMessage("upload.excelonly", null, CommonUtil.getLocale(req));

    	if( multipartFile != null && multipartFile.getSize() > 0 ) {

    		//파일 정보 읽기
    		long fileSize = multipartFile.getSize();
    		String saveFileName = multipartFile.getOriginalFilename();
    		String fileFormat = saveFileName.toLowerCase();
    		
    		//파일 확장자 체크
    		if( fileFormat.indexOf(".xlsx") == -1 && fileFormat.indexOf(".xls") == -1 ) {
    			writer.println("<script>alert('"+ excelonlyMsg +"'); history.go(-1);</script>");
    			return;
    		}
    		
    		//엑셀 데이타 읽기
    		String resultCode = readExcel( multipartFile );
    		if(resultCode!=null && resultCode.equals("S"))
    			writer.println("<script>alert('"+ successMsg +"'); history.go(-1);</script>");
    		else 
    			writer.println("<script>alert('"+ failMsg +"'); history.go(-1);</script>");

    	}  else {
    		writer.println("<script>alert('"+ failMsg +"'); history.go(-1);</script>");
    	}
    	 
    }


	private String readExcel(MultipartFile multipartFile) {
		String resultCode="S";

		String saveFileName = multipartFile.getOriginalFilename();
		String fileFormat = saveFileName.toLowerCase();
		Workbook wb = null;
		
		try {
			
			//엑셀파일을 저장하지 않고 스트림에서 읽음(파일 보관이 필요하면 파일로 저장하는 로직 추가할것)
			if( fileFormat.indexOf(".xlsx") > -1 ) {
				wb = new XSSFWorkbook(multipartFile.getInputStream()); //Excel 2007(.xlsx) 인 경우 XSSFWorkbook 사용
			} else if( fileFormat.indexOf(".xls") > -1 ) {
				wb = new HSSFWorkbook(multipartFile.getInputStream()); //Excel 97~2003(.xls) 인 경우 HSSFWorkbook 사용
			}
	
			Sheet sheet = wb.getSheetAt(0);
			int last = sheet.getLastRowNum();
			int totalCnt = last + 1;
			logger.info("총 건수:" + totalCnt);
			
			for(int i=0; i<=last; i++) {
				
				//Row 조회
				Row row = sheet.getRow(i);
				
				//Row의 셀 데이타 읽기
				String name = (String) ExcelUtil.getCellData( row.getCell(0, Row.CREATE_NULL_AS_BLANK) );
				double bill_amt = (double) ExcelUtil.getCellData( row.getCell(1, Row.CREATE_NULL_AS_BLANK) );
				Date bill_date = (Date) ExcelUtil.getCellData( row.getCell(2, Row.CREATE_NULL_AS_BLANK) );
				
				
				logger.info("이름:" + name);
				logger.info("청구액:" + bill_amt);
				
				//DB 저장 로직은 각 개발자분들이 삽입(대용량 데이타는 성능향상을 위해 다중 Insert 사용할것)
	
			}
		
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        	resultCode="F";
			logger.error(e.toString());
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	resultCode="F";
        }catch(Exception e) {
			resultCode="F";
			logger.error(e.toString());
		}
		
		return resultCode;
		
	}




}
