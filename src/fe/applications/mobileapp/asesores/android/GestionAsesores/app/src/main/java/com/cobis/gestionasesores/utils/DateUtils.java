package com.cobis.gestionasesores.utils;

import android.support.annotation.Nullable;

import com.bayteq.libcore.logs.Log;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

/**
 * Created by bqtdesa02 on 6/7/2017.
 */

public final class DateUtils {
    private static final String DATE_PATTERN_SYNC = "MMM d, hh:mm aaa";
    private static final String DATE_PATTERN = "dd/MM/yyyy";
    private static final String SERVICE_DATE_PATTERN = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    private static final String SERVICE_RESPONSE_DATE_PATTERN = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    private static final String TIME_PATTERN = "kk:mm";

    private DateUtils() {
    }

    @Nullable
    public static Date parseMillisecondsDate(Long date) {
        if (date == null) return null;
        return new Date(date);
    }

    @Nullable
    public static String formatDate(Long date) {
        if (date == null) return null;
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN, Locale.getDefault());
        return sdf.format(new Date(date));
    }

    @Nullable
    public static String formatDateForService(Long date) {
        if (date == null) return null;
        SimpleDateFormat sdf = new SimpleDateFormat(SERVICE_DATE_PATTERN, Locale.getDefault());
        return sdf.format(new Date(date));
    }

    public static String formatDateForSync(Long date) {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN_SYNC, Locale.getDefault());
        return sdf.format(new Date(date));
    }

    @Nullable
    public static Long parseDateFromService(String serverDate) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat(SERVICE_RESPONSE_DATE_PATTERN, Locale.getDefault());
            Date date = sdf.parse(serverDate);
            return date.getTime();
        } catch (Exception ex) {
            Log.e("DateUtils: Pare error parseDateFromService! ", ex);
            return null;
        }
    }

    @Nullable
    public static Date parseTimeDate(String time) {
        Date result = null;
        try {
            if (time != null) {
                SimpleDateFormat sdf = new SimpleDateFormat(TIME_PATTERN, Locale.getDefault());
                result = sdf.parse(time);
            }
        } catch (ParseException ex) {
            Log.e("DateUtils: Pare error parseTimeDate! ", ex);
        }
        return result;
    }

    @Nullable
    public static String formatTime(Long date) {
        if (date == null) return null;
        SimpleDateFormat sdf = new SimpleDateFormat(TIME_PATTERN, Locale.getDefault());
        return sdf.format(new Date(date));
    }

    @Nullable
    public static String formatTimeForService(Long time) {
        return formatDateForService(time);
    }

    @Nullable
    public static Long parseTimeFromService(String date) {
        return parseDateFromService(date);
    }


    public static int getAge(Long birthday) {
        GregorianCalendar today = new GregorianCalendar();
        int y, m, d;
        y = today.get(Calendar.YEAR);
        m = today.get(Calendar.MONTH);
        d = today.get(Calendar.DAY_OF_MONTH);

        Calendar dob = Calendar.getInstance();
        dob.setTimeInMillis(birthday);

        int age = y - dob.get(Calendar.YEAR);
        if ((m < dob.get(Calendar.MONTH))
                || ((m == dob.get(Calendar.MONTH)) && (d < dob
                .get(Calendar.DAY_OF_MONTH)))) {
            --age;
        }
        return age;
    }
}
