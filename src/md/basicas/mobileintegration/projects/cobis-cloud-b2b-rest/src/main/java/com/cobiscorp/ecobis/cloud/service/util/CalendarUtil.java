package com.cobiscorp.ecobis.cloud.service.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import static com.cobiscorp.ecobis.cloud.service.util.DataTypeUtil.isNullOrEmpty;

/**
 * @author Cesar Loachamin
 */
public class CalendarUtil {

    private static String ISO_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
	//private static String ISO_FORMAT = "yyyy-MM-dd'T'HH:mm:ss'Z'";//cambio solicitado por bayteq

	private static SimpleDateFormat FORMATTER = new SimpleDateFormat(ISO_FORMAT);

    private CalendarUtil() {
    }

    public static Calendar from(String data) {
        return from(data, "MM/dd/yyyy");
    }

    private static Calendar from(String data, String format) {
        if (data == null) return null;
        SimpleDateFormat df = new SimpleDateFormat(format);
        try {
            Date date = df.parse(data);
            Calendar instance = Calendar.getInstance();
            instance.setTime(date);
            return instance;
        } catch (ParseException e) {
            return null;
        }
    }

    public static Calendar fromISOTime(String data) {
        if (data != null) {
            Date date;
            try {
                date = FORMATTER.parse(data);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            return calendar;
        }
        return null;
    }

    public static String toISOTime(String date) {
        return toISOTime(date, null);
    }

    public static String toISOTime(String date, String format) {
        if (date == null) {
            return null;
        }
        return toISOTime(isNullOrEmpty(format) ? from(date) : from(date, format));
    }

    public static String toISOTime(Calendar calendar) {
        if (calendar == null) {
            return null;
        }
        return FORMATTER.format(calendar.getTime());
    }
}
