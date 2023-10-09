package com.cobiscorp.mobile.converter;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;
import java.util.TimeZone;

import com.cobiscorp.mobile.model.Constants;

public class DateConverter {

	public static String calendarToFormattedString(Calendar calendar) {
		if (calendar == null) {
			return null;
		}
		TimeZone currentTimeZone = TimeZone.getDefault();
		if (!calendar.getTimeZone().equals(currentTimeZone)) {
			calendar.setTimeZone(currentTimeZone);
		}
		DateFormat dateFormat = new SimpleDateFormat(Constants.DATE_FORMAT, Locale.forLanguageTag("es"));
		String result = dateFormat.format(calendar.getTime());
		return result.substring(0, 1).toUpperCase().concat(result.substring(1));
	}

	public static String calendarToDateTimeString(Calendar calendar) {
		if (calendar == null) {
			return null;
		}
		TimeZone currentTimeZone = TimeZone.getDefault();
		if (!calendar.getTimeZone().equals(currentTimeZone)) {
			calendar.setTimeZone(currentTimeZone);
		}
		DateFormat dateFormat = new SimpleDateFormat(Constants.DATE_TIME_FORMAT2, Locale.forLanguageTag("es"));
		String result = dateFormat.format(calendar.getTime());
		return result.substring(0, 1).toUpperCase().concat(result.substring(1));
	}

	public static String calendarToDateTimeStringAmPm(Calendar calendar) {
		if (calendar == null) {
			return null;
		}
		TimeZone currentTimeZone = TimeZone.getDefault();
		if (!calendar.getTimeZone().equals(currentTimeZone)) {
			calendar.setTimeZone(currentTimeZone);
		}
		DateFormat dateFormat = new SimpleDateFormat(Constants.DATE_TIME_FORMAT3, Locale.forLanguageTag("es"));
		String result = dateFormat.format(calendar.getTime());
		return result.substring(0, 1).toUpperCase().concat(result.substring(1));
	}
}
