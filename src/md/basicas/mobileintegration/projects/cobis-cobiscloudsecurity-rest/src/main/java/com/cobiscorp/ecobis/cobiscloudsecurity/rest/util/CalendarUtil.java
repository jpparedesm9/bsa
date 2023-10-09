package com.cobiscorp.ecobis.cobiscloudsecurity.rest.util;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.util.ISO8601DateFormat;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import static com.cobiscorp.ecobis.cobiscloudsecurity.rest.util.DataTypeUtil.isNullOrEmpty;

/**
 * @author Cesar Loachamin
 */
public class CalendarUtil {

    private CalendarUtil() {
    }

    public static Calendar from(String data) {
        return from(data, "MM/dd/yyyy");
    }

    public static Calendar from(String data, String format) {
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
            Date date = getMapper().convertValue(data, Date.class);
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
        try {
            return getMapper().writeValueAsString(calendar).replace("\"", "");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static ObjectMapper mapper;
    private static ObjectMapper getMapper() {
        if (mapper == null) {
            mapper = new ObjectMapper();
            mapper.setDateFormat(new ISO8601DateFormat());
        }
        return mapper;
    }
}
