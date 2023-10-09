package com.cobiscorp.cobis.loans.commons.services.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Convert {
	public static Calendar toCalendar(final Date date) {
		Calendar initalDate = Calendar.getInstance();
		initalDate.setTime(date);
		return initalDate;
	}

	public static Date calendarToDate(Calendar calendar) {
		return calendar.getTime();
	}

	public static String convertDate(String date) throws Exception {
		String resultDate = null;
		SimpleDateFormat oldDateFormat = new SimpleDateFormat("MM/dd/yyyy");
		SimpleDateFormat newDateFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date fechaDate = null;
		if (null != date && "" != date) {
			try {
				fechaDate = oldDateFormat.parse(date);
				resultDate = newDateFormat.format(fechaDate);
			} catch (ParseException e) {
				throw e;
			}
		}
		return resultDate;

	}
}
