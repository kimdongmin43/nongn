package kr.apfs.local.common.util;

import java.awt.Font;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelUtil {

	private static final Log logger = LogFactory.getLog(ExcelUtil.class);
	
	public static List procExcelFile(String filePath, String excelFileName) throws IOException{
		 List excelContentList = null; 
		 
		 String downfilePath = filePath+File.separator+excelFileName;
		 
	     if (excelFileName.indexOf(".xlsx") > -1) { 
	      // EXCEL 2007(.xlsx)
	      excelContentList = procExtractExcel2007(downfilePath);
	      
	     } else if (excelFileName.indexOf(".xls") > -1) { 
	      // EXCEL 97~2003(.xls)
	      excelContentList = procExtractExcel(downfilePath);
	     }
	     
	     return excelContentList;
	}
	
	public static List procExtractExcel2007(String excelFileName)
			throws IOException {

		// SET LOCAL VALUE
		List excelContentList = new ArrayList();
		File file = new File(excelFileName);
		
		XSSFWorkbook wb = null;

		// VALIDATE FILE
		if (!file.exists() || !file.isFile() || !file.canRead()) {
			throw new IOException(excelFileName);
		}

		try {
			wb = new XSSFWorkbook(new FileInputStream(file));
			int listCount = 0;
			ArrayList list = null;
			for (int i = 0; i < wb.getNumberOfSheets(); i++) {
				int cellCnt = 0, cellIdx = 0;
				for (Row row : wb.getSheetAt(i)) {
					if (listCount > 0)
						list = new ArrayList(cellCnt);
					cellIdx = 0;
					for (Cell cell : row) {
						if (listCount == 0) {
							cellCnt++;
						} else {
							if (cellIdx < cellCnt) {
								list.add(getCellValue(cell));
							}
							cellIdx++;
						}
					}
					if (listCount > 0 && cellIdx < cellCnt - 1) {
						for (int j = cellIdx; j < cellCnt; j++)
							list.add("");
					}
					if (listCount > 0)
						excelContentList.add(list);
					listCount++;
				}
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
		finally{
	       	if (wb != null) {
	       		try {
	       			wb.close();
	       		} catch (IOException e) {
	       			logger.error("error===", e);
	       			}
	       	}
		}

		return excelContentList;
	}
	 
	/* 엑셀업로드 후 데이터 추출 EXCEL 97~2003(*.xls) @REX */
	public static List procExtractExcel(String excelFileName)
			throws IOException {

		// SET LOCAL VALUE
		List excelContentList = new ArrayList();
		File file = new File(excelFileName);
		HSSFWorkbook wb = null;
		
		// VALIDATE FILE
		if (!file.exists() || !file.isFile() || !file.canRead()) {
			throw new IOException(excelFileName);
		}

		try {
			wb = new HSSFWorkbook(new FileInputStream(file));
			int listCount = 0;
			int cellMax = 0;
			for (int i = 0; i < wb.getNumberOfSheets(); i++) {
				int cellCnt = 0, cellIdx = 0;
				ArrayList list = null;
				for (Row row : wb.getSheetAt(i)) {
					if (listCount > 0)
						list = new ArrayList(cellCnt);
					
					cellIdx = 0;
					
					if(listCount == 0) {
						for (Cell cell : row) {
							cellCnt++;
						}
					} else {
						for(int z = 0 ; z < cellCnt ; z++) {
							if (cellIdx < cellCnt) {
								Cell cell = row.getCell(z);
								list.add(getCellValue(cell));
							}
							
							cellIdx++;
						}
					}
					
					if (listCount > 0 && cellIdx < cellCnt - 1) {
						for (int j = cellIdx; j < cellCnt; j++)
							list.add("");
					}
					
					if (listCount > 0)
						excelContentList.add(list);
					
					listCount++;
				}
			}
		}catch (IOException e) {
        	logger.error("IOException error===", e);
        } catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        }
		finally{
	       	if (wb != null) {
	       		try {
	       			wb.close();
	       		} catch (IOException e) {
	       			logger.error("error===", e);
	       			}
	       	}
		}

		return excelContentList;
	}
	
	private static String getCellValue(Cell cell) {
		String value = "";

		try {
			switch (cell.getCellType()) {
				case Cell.CELL_TYPE_FORMULA:
					value = cell.getCellFormula();
					break;
		
				case Cell.CELL_TYPE_NUMERIC:
					cell.setCellType(Cell.CELL_TYPE_STRING);
					value = cell.getStringCellValue();
					break;
		
				case Cell.CELL_TYPE_STRING:
					value = "" + cell.getStringCellValue();
					break;
				case Cell.CELL_TYPE_BLANK:
					value = "";
					break;
				case Cell.CELL_TYPE_ERROR:
					value = "" + cell.getErrorCellValue();
					break;
				default:
			}
		}catch (NullPointerException e) {
        	logger.error("NullPointerException error===", e);
        	value = "";
        }
		
		return value;
	}
	
	
	/**
	 * 엑셀 헤더 셀의 공통 스타일 설정 함수 
	 * @param workbook : 엑셀 Workbook
	 * @return CellStyle 
	 */
	public final static CellStyle genericHeaderCellStyle(Workbook workbook) {
		CellStyle style=workbook.createCellStyle();
		
		//정렬
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		
		//라인
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(HSSFColor.BLACK.index);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(HSSFColor.BLACK.index);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(HSSFColor.BLACK.index);
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(HSSFColor.BLACK.index);
		
		//백그라운드 색상
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		
		//폰트
/*		Font font = workbook.createFont();
		//font.setFontName(HSSFFont.FONT_ARIAL);
		font.setFontHeightInPoints((short) 10);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		//font.setColor(HSSFColor.BLACK.index);
		style.setFont(font);*/
		
	    return style;
	}
	
	/**
	 * 엑셀 데이타 셀의 공통 스타일 설정 함수 
	 * @param workbook : 엑셀 Workbook
	 * @return CellStyle 
	 */
	public final static CellStyle genericDataCellStyle(Workbook workbook) {
		CellStyle style=workbook.createCellStyle();
		
		//정렬
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		
		//라인
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(HSSFColor.BLACK.index);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(HSSFColor.BLACK.index);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(HSSFColor.BLACK.index);
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(HSSFColor.BLACK.index);
		
	    return style;
	}
	
	
	/**
	 * 셀의 데이타를 유형에 맞게 읽기위한 함수
	 * @param cell : 엑셀 Cell
	 * @return Object 
	 */
	public final static Object getCellData(Cell cell) {
		Object cellData=null;

		switch( cell.getCellType() ) {
		
			case Cell.CELL_TYPE_STRING :
				cellData = cell.getStringCellValue();
				break;
				
			case Cell.CELL_TYPE_NUMERIC :
			/*	if( DateUtil.isCellDateFormatted(cell) )
					cellData = cell.getDateCellValue();
				else
					cellData = cell.getNumericCellValue();*/
				break;
				
			case Cell.CELL_TYPE_FORMULA :
				cellData = cell.getCellFormula();
				break;
				
			case Cell.CELL_TYPE_BOOLEAN :
				cellData = cell.getBooleanCellValue();
				break;
				
			case Cell.CELL_TYPE_ERROR :
				cellData = cell.getErrorCellValue();
				break;
				
			case Cell.CELL_TYPE_BLANK :
				cellData ="";
				break;
				
			default: break;
			
		}

		return cellData;
	}
	
	public static String getExcelCellString(Cell cell) {
		String value="";

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		if(cell != null) {
			switch (cell.getCellType()){
			case HSSFCell.CELL_TYPE_FORMULA :
				value = cell.getCellFormula();
				break;

			case HSSFCell.CELL_TYPE_NUMERIC :
				if(HSSFDateUtil.isCellDateFormatted(cell)) {
					value = sdf.format(cell.getDateCellValue());
				} else {
					value = Long.toString((long) cell.getNumericCellValue());
				}

				break;

			case HSSFCell.CELL_TYPE_STRING :
				value = "" + cell.getStringCellValue();
				break;

			case HSSFCell.CELL_TYPE_BLANK :
				value =  "" + cell.getStringCellValue();
				break;

			case HSSFCell.CELL_TYPE_BOOLEAN :
				value =  "" + cell.getBooleanCellValue();
				break;

			case HSSFCell.CELL_TYPE_ERROR :
				break;
			}
		}
		return value;
	}
}
