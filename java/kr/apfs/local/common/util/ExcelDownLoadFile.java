package kr.apfs.local.common.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class ExcelDownLoadFile extends AbstractExcelView {
	
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook workbook,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		Map<String, Object> excelList = (Map<String, Object>) model.get("excelList");
		
		if(excelList.get("excelname") != null && !excelList.get("excelname").equals("")){
			String filename = excelList.get("excelname").toString();
			response.setContentType("Application/Msexcel");
			response.setHeader("Content-Disposition", "attachment; filename=\""+ filename +".xls\"");
			response.setHeader("Content-Transfer-Encoding", "binary");
		}
		
		List<String> colName = (List<String>) excelList.get("colName");
		
		Map<String,Object> colValue = (Map<String,Object>) excelList.get("colValue");

		HSSFSheet sheet = workbook.createSheet();
		HSSFCellStyle cs = workbook.createCellStyle();
		
		cs.setFillForegroundColor(workbook.getCustomPalette().findSimilarColor((byte)0x99, (byte)0xCC, (byte)0xFF).getIndex());
		//cs.setFillForegroundColor(workbook.getCustomPalette().getColor(HSSFColor.GREEN.index).getIndex());
		cs.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		cs.setBorderTop(HSSFCellStyle.BORDER_THIN);
		
		workbook.setSheetName(0, (String) excelList.get("sheetName"));		
		
		creatColum(sheet, colName, cs);
		
		for ( int i = 0; i < colValue.size(); i++ ) {
			createRow(sheet, (List<Map<String,Object>>)colValue.get("item"+i), i+1);
		}
		
		//for ( int i = 0; i < colName.size(); i++ ) sheet.autoSizeColumn(i);
		autoSizeColumns(sheet);
	}

	private void creatColum(HSSFSheet sheet, List<String> coln, HSSFCellStyle cs) {

		HSSFRow header = sheet.createRow(0);

		HSSFCell cell = null;
		
		for (int i = 0; i < coln.size(); i++) {
			cell = header.createCell(i);
			cell.setCellValue(coln.get(i));
			cell.setCellStyle(cs);
		}
	}

	// 각 로우에 대한 값 입력
	private void createRow(HSSFSheet sheet, List<Map<String,Object>> colv, int rowNum) {

		HSSFRow row = sheet.createRow(rowNum);
		HSSFCell cell = null;
		List<String> colvTemp = new ArrayList();
		
		for(int i=0 ; colv.size()<i ; i++){
			colvTemp = (List<String>) colv.get(i);
			System.out.println("##############################################################");
			System.out.println(colvTemp.size());
			System.out.println("##############################################################");
			for ( int j = 0 ; j < colvTemp.size(); j++ ) {
				cell = row.createCell(j);
				cell.setCellValue(colvTemp.get(j));
				System.out.println("##############################################################");
				System.out.println(colvTemp.get(j));
				System.out.println("##############################################################");
			}
		}
	}
	
    public Sheet autoSizeColumns(Sheet sheet) {
        for (Row row : sheet) {
            for (Cell cell : row) {
                //sheet.autoSizeColumn((short)cell.getColumnIndex()); 
                if(row.getRowNum() > 1) {
                    break;
                }
                
                short colNum = (short)cell.getColumnIndex(); 
                //sheet.autoSizeColumn(colNum,true); 
                sheet.setColumnWidth(colNum, (short)(sheet.getColumnWidth(colNum)+500)); 
            }
          }
        return sheet;
    }
}
