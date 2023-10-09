package com.cobiscorp.cobis.clcol.customevents.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Locale;

import org.apache.poi.ss.usermodel.Cell;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class Utils {
	private static final ILogger LOGGER = LogFactory.getLogger(Utils.class);

	public static String cellToString(Cell cell) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start cellToString");

		if (cell != null) {

			switch (cell.getCellType()) {
			case 0:
				double value = cell.getNumericCellValue();
				Locale.setDefault(Locale.US);
				DecimalFormat num = new DecimalFormat("####");
				return num.format(value);
			case 1:
				return cell.getStringCellValue();

			default:
				break;
			}

		}
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Finish cellToString");
		return "";

	}
}
