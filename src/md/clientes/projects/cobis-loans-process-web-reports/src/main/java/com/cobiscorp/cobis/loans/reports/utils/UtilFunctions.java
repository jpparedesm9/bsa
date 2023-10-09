package com.cobiscorp.cobis.loans.reports.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class UtilFunctions {
	private static final ILogger logger = LogFactory.getLogger(UtilFunctions.class);

	public static String getHours(Calendar time) {
		if (time != null) {
			int hour;
			int minute;
			String sMinute = "";
			String shour = "";
			hour = time.get(Calendar.HOUR_OF_DAY);
			minute = time.get(Calendar.MINUTE);
			if (hour < 10) {
				shour = "0" + hour;
			} else {
				shour = String.valueOf(hour);
			}
			if (minute < 10) {
				sMinute = "0" + minute;
			} else {
				sMinute = String.valueOf(minute);
			}
			return shour + ":" + sMinute;

		}
		return null;
	}

	public static String getMonth(String processDate) {
		String result = "";
		Calendar date = stringToCalendar(processDate);
		if (date != null) {
			int month = date.get(Calendar.MONTH);

			switch (month) {
			case 0: {
				result = "Enero";
				break;
			}
			case 1: {
				result = "Febrero";
				break;
			}
			case 2: {
				result = "Marzo";
				break;
			}
			case 3: {
				result = "Abril";
				break;
			}
			case 4: {
				result = "Mayo";
				break;
			}
			case 5: {
				result = "Junio";
				break;
			}
			case 6: {
				result = "Julio";
				break;
			}
			case 7: {
				result = "Agosto";
				break;
			}
			case 8: {
				result = "Septiembre";
				break;
			}
			case 9: {
				result = "Octubre";
				break;
			}
			case 10: {
				result = "Noviembre";
				break;
			}
			case 11: {
				result = "Diciembre";
				break;
			}
			default: {
				result = "ERROR";
				break;
			}
			}
		}
		return result;
	}

	public static Calendar stringToCalendar(String date) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Fecha a Convertir: " + date);
		}
		if (date != null && date != "") {
			Calendar cal = Calendar.getInstance();
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				cal.setTime(sdf.parse(date));
				return cal;
			} catch (Exception e) {
				logger.logError("ERROR AL CONVERTIR FECHA: ", e);
				return null;
			}
		}
		return null;
	}

	public static String getDay(String processDate) {
		Calendar date = stringToCalendar(processDate);
		String dia = null;
		if (date != null) {

			if (date.get(Calendar.DAY_OF_MONTH) < 10) {
				dia = "0" + String.valueOf(date.get(Calendar.DAY_OF_MONTH));
			} else {
				dia = String.valueOf(date.get(Calendar.DAY_OF_MONTH));
			}
		}
		return dia;

	}

	public static String getYear(String processDate) {
		Calendar date = stringToCalendar(processDate);
		String anio = null;
		if (date != null) {
			anio = String.valueOf(date.get(Calendar.YEAR));
		}
		return anio;
	}

	public static String ddMMyy(String date, String dm, String my) {
		String ddMMyy = "";
		ddMMyy = getDay(date) + " " + dm + " " + getMonth(date) + " " + my + " " + getYear(date);
		return ddMMyy;
	}

	/**
	 * validation of isnull
	 * 
	 * @param value
	 * @return string
	 */
	public static String isnull(String value) {
		return (value == null || value.isEmpty()) ? "" : value;
	}

	public static String getDateFormater(Date date) {
		String ddMMyyyy = "";

		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyy");
		ddMMyyyy = formatter.format(date);

		return ddMMyyyy;
	}

}
