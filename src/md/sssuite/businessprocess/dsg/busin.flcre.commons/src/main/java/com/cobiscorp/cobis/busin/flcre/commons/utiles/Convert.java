package com.cobiscorp.cobis.busin.flcre.commons.utiles;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Format;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class Convert {
	private static final ILogger logger = LogFactory.getLogger(Convert.class);

	public static class CString {
		public static Date toDate(final String date) {
			int dateFormat = SessionContext.getFormatDate();
			SimpleDateFormat formatter = new SimpleDateFormat();
			if (dateFormat == SessionContext.DATE100)
				formatter = new SimpleDateFormat(SessionContext.PATTERN_DATE100, Locale.US);
			else
				formatter = new SimpleDateFormat(SessionContext.getPatternDate());

			try {
				return formatter.parse(date);
			} catch (ParseException e) {
				logger.logDebug("Error al convertir el String:" + date + ", con formato:" + dateFormat + ", a java.util.Date\n", e);
			}
			return null;
		}

		public static Date toDate(int dateFormat, String date) {
			SimpleDateFormat formatter = new SimpleDateFormat();
			if (dateFormat == SessionContext.DATE103)
				formatter = new SimpleDateFormat(SessionContext.PATTERN_DATE103);
			else if (dateFormat == SessionContext.DATE100)
				formatter = new SimpleDateFormat(SessionContext.PATTERN_DATE100, Locale.US);
			else if (dateFormat == SessionContext.DATE111)
				formatter = new SimpleDateFormat(SessionContext.PATTERN_DATE111);

			try {
				return formatter.parse(date);
			} catch (ParseException e) {
				logger.logDebug("Error al convertir el String:" + date + ", con formato:" + dateFormat + ", a java.util.Date\n", e);
			}
			return null;
		}

		public static Character toCharacter(final String value) {
			if (value != null && value.length() >= 1) {
				return value.charAt(0);
			}
			return null;
		}

		public static String toDBNullAsString(final String value) {
			return Validate.Strings.isNotNullOrEmptyOrWhiteSpace(value) ? value : Format.DB_NULL;
		}
	}

	public static class CCharacter {
		public static String toString(final Character value) {
			if (value != null) {
				return value.toString();
			}
			return null;
		}

		public static Character toDBNullAsCharacter(final Character value) {
			return (value != null && !Character.isWhitespace(value)) ? value : 'X';
		}

		public static String toDBNullAsString(final Character value) {
			return (value != null && !Character.isWhitespace(value)) ? value.toString() : Format.DB_NULL_CHAR;
		}
	}

	public static class CCalendar {
		public static String toString(final Calendar date) {
			SimpleDateFormat formatter = new SimpleDateFormat(SessionContext.getPatternDate());
			return formatter.format(date.getTime());
		}
	}

	public static class CDate {
		public static String toString(final Date date) {
			SimpleDateFormat formatter = new SimpleDateFormat(SessionContext.getPatternDate());
			return formatter.format(date);
		}

		public static String toString(int dateFormat, Date date) {
			if (dateFormat == SessionContext.getFormatDate()) {
				return toString(date);
			} else if (dateFormat == SessionContext.DATE103) {
				SimpleDateFormat formatter = new SimpleDateFormat(SessionContext.PATTERN_DATE103);
				return formatter.format(date);
			} else if (dateFormat == SessionContext.DATE101) {
				SimpleDateFormat formatter = new SimpleDateFormat(SessionContext.PATTERN_DATE101);
				return formatter.format(date);
			} else if (dateFormat == SessionContext.DATE111) {
				SimpleDateFormat formatter = new SimpleDateFormat(SessionContext.PATTERN_DATE111);
				return formatter.format(date);
			}
			return null;
		}

		public static Calendar toCalendar(final Date date) {
			Calendar initalDate = Calendar.getInstance();
			initalDate.setTime(date);
			return initalDate;
		}

		public static Calendar toCalendarRaw(final Date date) {
			String strDate = CCalendar.toString(toCalendar(date));
			Date dtDate = CString.toDate(strDate);
			return toCalendar(dtDate);
		}
	}

	public static Date getEndOfTheMonth(Date currentDate) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(currentDate);
		cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.getActualMaximum(Calendar.DAY_OF_MONTH), cal.getMaximum(Calendar.HOUR_OF_DAY), cal.getMaximum(Calendar.MINUTE),
				cal.getMaximum(Calendar.SECOND));
		return cal.getTime();
	}

	public static BigDecimal DoubleToBigDecimal(Double value) {
		return DoubleToBigDecimal(value, new BigDecimal(0));
	}

	public static BigDecimal DoubleToBigDecimal(Double value, BigDecimal defaultValue) {
		return (value != null) ? new BigDecimal(value) : defaultValue;
	}

	public static String IntegerToString(Integer value) {
		return IntegerToString(value, "0");
	}

	public static String IntegerToString(Integer value, String defaultValue) {
		return (value != null) ? value.toString() : defaultValue;
	}

	public static String StringToString(String value) {
		return StringToString(value, "");
	}

	public static String StringToString(String value, String defaultValue) {
		return (value != null) ? value : defaultValue;
	}

	public static int GetDays(Date initial, Date end) {
		long diferenciaEn_ms = end.getTime() - initial.getTime();
		long dias = diferenciaEn_ms / (1000 * 60 * 60 * 24);
		return (int) dias;

	}
}
